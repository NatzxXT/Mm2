-- ============================================================
--  MM2 CHECK HUB v3 - VERSÃO COMPATÍVEL (Xeno/Delta)
--  ESP corrigido (funciona com arma guardada)
--  Trigger Bot com FOV configurável
-- ============================================================
local okLoad, errLoad = pcall(function()

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- ============================================================
--  CONFIG
-- ============================================================
local Config = {
    ESP_Players = false,
    ESP_Name = false,
    ESP_Gun = false,
    ESP_Color_Innocent = Color3.fromRGB(0, 255, 0),
    ESP_Color_Sheriff = Color3.fromRGB(0, 150, 255),
    ESP_Color_Murderer = Color3.fromRGB(255, 0, 0),
    Aimbot = false,
    Aimbot_Smoothness = 0.15,
    Aimbot_FOV = 150,
    Show_FOV = true,
    TriggerBot = false,
    TriggerBot_TeamCheck = true,
    TriggerBot_Delay = 0.05,
    TriggerBot_FOV = 40,
    AutoKill = false,
    AutoKill_Range = 15,
    AutoKill_GunRange = 500,
    AutoKill_Delay = 0.35,
    AutoKill_WallCheck = true,
    AutoKill_AutoEquip = true,
    AutoKill_KeepEquipped = true,
    AutoKill_EquipCheckDelay = 0.15,
    Speed = 16,
    JumpPower = 50,
    InfiniteJump = false,
    Fly = false,
    FlySpeed = 50,
    Noclip = false,
    AntiVoid = false,
    AntiFling = false,
    AutoGrabGun = false,
    AutoGrabGun_Delay = 0.8,
    AutoGrabGun_ReturnDelay = 0.35,
    AutoGrabGun_ReturnInstant = true,
    GunDropNotify = true,
    GunDropNotify_Sound = true,
}

-- ============================================================
--  ROLE  (CORRIGIDO: checa Character + Backpack + Descendants)
-- ============================================================
local function getRole(player)
    local char = player.Character
    if not char then return "Innocent" end

    -- 1) Checa no Character (equipado)
    if char:FindFirstChild("Knife") then return "Murderer" end
    if char:FindFirstChild("Gun") then return "Sheriff" end

    -- 2) Checa no Backpack (guardado)
    local backpack = player:FindFirstChildOfClass("Backpack")
    if backpack then
        if backpack:FindFirstChild("Knife") then return "Murderer" end
        if backpack:FindFirstChild("Gun") then return "Sheriff" end
    end

    -- 3) Fallback: varre descendentes do Character por Tools com nome knife/gun
    for _, obj in ipairs(char:GetDescendants()) do
        if obj:IsA("Tool") then
            local n = obj.Name:lower()
            if n:find("knife") then return "Murderer" end
            if n:find("gun") then return "Sheriff" end
        end
    end

    return "Innocent"
end

local function getRoleColor(role)
    if role == "Murderer" then return Config.ESP_Color_Murderer end
    if role == "Sheriff" then return Config.ESP_Color_Sheriff end
    return Config.ESP_Color_Innocent
end

-- ============================================================
--  FOV CIRCLE
-- ============================================================
local fovGui = Instance.new("ScreenGui")
fovGui.Name = "MM2_FOV"
fovGui.IgnoreGuiInset = true
fovGui.ResetOnSpawn = false
pcall(function() fovGui.Parent = game.CoreGui end)

local fovCircle = Instance.new("Frame")
fovCircle.Size = UDim2.new(0, Config.Aimbot_FOV * 2, 0, Config.Aimbot_FOV * 2)
fovCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
fovCircle.AnchorPoint = Vector2.new(0.5, 0.5)
fovCircle.BackgroundTransparency = 1
fovCircle.BorderSizePixel = 0
fovCircle.Parent = fovGui

local fovStroke = Instance.new("UIStroke")
fovStroke.Thickness = 1.5
fovStroke.Color = Color3.fromRGB(0, 200, 255)
fovStroke.Transparency = 0.3
fovStroke.Parent = fovCircle

local fovCorner = Instance.new("UICorner")
fovCorner.CornerRadius = UDim.new(1, 0)
fovCorner.Parent = fovCircle

local function isInFOV(worldPos, fovPixels)
    local sp, onScreen = Camera:WorldToScreenPoint(worldPos)
    if not onScreen then return false, nil end
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    local diff = Vector2.new(sp.X, sp.Y) - center
    return diff.Magnitude <= fovPixels, sp
end

-- ============================================================
--  HELPERS
-- ============================================================
local function findTool(char, keyword)
    if not char then return nil end
    for _, t in ipairs(char:GetChildren()) do
        if t:IsA("Tool") and t.Name:lower():find(keyword) then
            return t
        end
    end
    return nil
end

local function getEquippedTool(char)
    if not char then return nil end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return nil end
    return hum:GetEquippedTool()
end

local function equipTool(tool)
    if not tool then return false end
    local char = LocalPlayer.Character
    if not char then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return false end
    if hum:GetEquippedTool() == tool then return true end
    if tool.Parent ~= char then tool.Parent = char end
    pcall(function() hum:EquipTool(tool) end)
    return true
end

local function isInAnyCharacter(obj)
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character and obj:IsDescendantOf(p.Character) then return true end
    end
    return false
end

local function hasLineOfSight(originPos, targetPos, targetChar)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.IgnoreWater = true
    local filter = {}
    if LocalPlayer.Character then table.insert(filter, LocalPlayer.Character) end
    if targetChar then table.insert(filter, targetChar) end
    params.FilterDescendantsInstances = filter
    local result = workspace:Raycast(originPos, targetPos - originPos, params)
    return result == nil
end

-- ============================================================
--  ESP
-- ============================================================
local espCache = {}
local nameCache = {}

local function removeHighlight(player)
    if espCache[player] then espCache[player]:Destroy() espCache[player] = nil end
end

local function removeNameTag(player)
    if nameCache[player] then nameCache[player]:Destroy() nameCache[player] = nil end
end

local function createHighlight(player)
    local char = player.Character
    if not char then return end
    local hl = Instance.new("Highlight")
    hl.Name = "MM2_ESP"
    hl.Adornee = char
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.FillTransparency = 0.5
    hl.OutlineTransparency = 0
    local c = getRoleColor(getRole(player))
    hl.FillColor = c
    hl.OutlineColor = c
    hl.Parent = char
    espCache[player] = hl
end

local function createNameTag(player)
    local char = player.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end
    if nameCache[player] then nameCache[player]:Destroy() end

    local bg = Instance.new("BillboardGui")
    bg.Name = "MM2_NameTag"
    bg.Size = UDim2.new(0, 180, 0, 26)
    bg.StudsOffset = Vector3.new(0, 3, 0)
    bg.Adornee = head
    bg.AlwaysOnTop = true
    bg.Parent = head

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = player.Name
    label.TextStrokeTransparency = 0
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.TextColor3 = getRoleColor(getRole(player))
    label.Parent = bg

    nameCache[player] = bg
end

local function updateESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if Config.ESP_Players then
                if not espCache[player] or not espCache[player].Adornee then
                    createHighlight(player)
                end
                if espCache[player] then
                    local c = getRoleColor(getRole(player))
                    espCache[player].FillColor = c
                    espCache[player].OutlineColor = c
                end
            else
                removeHighlight(player)
            end

            if Config.ESP_Name then
                if not nameCache[player] then createNameTag(player) end
                if nameCache[player] and nameCache[player].Adornee then
                    local lbl = nameCache[player]:FindFirstChildOfClass("TextLabel")
                    if lbl then
                        lbl.Text = player.Name
                        lbl.TextColor3 = getRoleColor(getRole(player))
                    end
                end
            else
                removeNameTag(player)
            end
        end
    end
end

local gunESP = nil
local function updateGunESP()
    if not Config.ESP_Gun then
        if gunESP then gunESP:Destroy() gunESP = nil end
        return
    end
    local gun = workspace:FindFirstChild("Gun", true)
    if gun and gun:IsA("BasePart") then
        if not gunESP or gunESP.Adornee ~= gun then
            if gunESP then gunESP:Destroy() end
            gunESP = Instance.new("Highlight")
            gunESP.Adornee = gun
            gunESP.FillColor = Color3.fromRGB(255, 255, 0)
            gunESP.OutlineColor = Color3.fromRGB(255, 255, 0)
            gunESP.FillTransparency = 0.3
            gunESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            gunESP.Parent = gun
        end
    else
        if gunESP then gunESP:Destroy() gunESP = nil end
    end
end

-- ============================================================
--  AIMBOT / TRIGGER
-- ============================================================
local function isTargetValid(targetPlayer, useTeamCheck)
    local myRole = getRole(LocalPlayer)
    local tRole = getRole(targetPlayer)
    if myRole == "Murderer" then
        if useTeamCheck and tRole == "Murderer" then return false end
        return true
    elseif myRole == "Sheriff" or myRole == "Innocent" then
        return tRole == "Murderer"
    end
    return false
end

local function getTargetByRole(fovLimit)
    local best, bestDist = nil, math.huge
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local char = player.Character
            if char and char:FindFirstChild("Head") and isTargetValid(player, false) then
                local inFov, sp = isInFOV(char.Head.Position, fovLimit)
                if inFov then
                    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                    local d = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                    if d < bestDist then
                        bestDist = d
                        best = char
                    end
                end
            end
        end
    end
    return best
end

local lastFire = 0
local function handleTriggerBot()
    if not Config.TriggerBot then return end
    local now = tick()
    if now - lastFire < Config.TriggerBot_Delay then return end

    local char = LocalPlayer.Character
    if not char then return end
    local tool = char:FindFirstChildOfClass("Tool")
    if not tool then return end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local tChar = player.Character
            if tChar and tChar:FindFirstChild("Head") then
                if not Config.TriggerBot_TeamCheck or isTargetValid(player, true) then
                    local inFov = isInFOV(tChar.Head.Position, Config.TriggerBot_FOV)
                    if inFov then
                        pcall(function() tool:Activate() end)
                        lastFire = now
                        break
                    end
                end
            end
        end
    end
end

-- ============================================================
--  AUTO KILL
-- ============================================================
local function findMurderer()
    local myChar = LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("Head") then return nil end
    local myHead = myChar.Head.Position
    local best, bestDist = nil, math.huge
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local char = player.Character
            if char and char:FindFirstChild("Head") and getRole(player) == "Murderer" then
                local targetPos = char.Head.Position
                local dist = (targetPos - myHead).Magnitude
                if dist < bestDist then
                    if not Config.AutoKill_WallCheck or hasLineOfSight(myHead, targetPos, char) then
                        bestDist = dist
                        best = char
                    end
                end
            end
        end
    end
    return best
end

local function findNearestEnemy(maxRange)
    local myChar = LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("Head") then return nil end
    local myHead = myChar.Head.Position
    local closest, closestDist = nil, maxRange
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local char = player.Character
            if char and char:FindFirstChild("Head") then
                local role = getRole(player)
                if role ~= "Murderer" then
                    local targetPos = char.Head.Position
                    local dist = (targetPos - myHead).Magnitude
                    if dist <= closestDist then
                        if not Config.AutoKill_WallCheck or hasLineOfSight(myHead, targetPos, char) then
                            closestDist = dist
                            closest = char
                        end
                    end
                end
            end
        end
    end
    return closest, closestDist
end

local lastAutoKill = 0
local function handleAutoKill()
    if not Config.AutoKill then return end
    local now = tick()
    if now - lastAutoKill < Config.AutoKill_Delay then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return end
    local myRole = getRole(LocalPlayer)

    if myRole == "Sheriff" or findTool(char, "gun") then
        local gun = findTool(char, "gun")
        if gun then
            local murderer = findMurderer()
            if murderer and murderer:FindFirstChild("HumanoidRootPart") then
                local myHRP = char:FindFirstChild("HumanoidRootPart")
                local mHRP = murderer.HumanoidRootPart
                if myHRP then
                    local dist = (mHRP.Position - myHRP.Position).Magnitude
                    if dist <= Config.AutoKill_GunRange then
                        if Config.AutoKill_AutoEquip and getEquippedTool(char) ~= gun then
                            equipTool(gun)
                            lastAutoKill = now
                            return
                        end
                        pcall(function() gun:Activate() end)
                        lastAutoKill = now
                    end
                end
            end
        end
        return
    end

    if myRole == "Murderer" then
        local knife = findTool(char, "knife")
        if knife then
            local enemy = findNearestEnemy(Config.AutoKill_Range)
            if enemy and enemy:FindFirstChild("HumanoidRootPart") then
                if Config.AutoKill_AutoEquip and getEquippedTool(char) ~= knife then
                    equipTool(knife)
                    lastAutoKill = now
                    return
                end
                pcall(function()
                    Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, enemy.HumanoidRootPart.Position)
                end)
                pcall(function() knife:Activate() end)
                lastAutoKill = now
            end
        end
    end
end

-- ============================================================
--  INFINITE JUMP / ANTI VOID
-- ============================================================
UserInputService.JumpRequest:Connect(function()
    if Config.InfiniteJump then
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end
    end
end)

local function handleAntiVoid()
    if not Config.AntiVoid then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp and hrp.Position.Y < -50 then
        hrp.CFrame = CFrame.new(hrp.Position.X, 50, hrp.Position.Z)
        hrp.Velocity = Vector3.new(0, 0, 0)
    end
end

-- ============================================================
--  LOOP PRINCIPAL
-- ============================================================
RunService.RenderStepped:Connect(function()
    pcall(updateESP)
    pcall(updateGunESP)
    pcall(handleTriggerBot)
    pcall(handleAntiVoid)
    pcall(handleAutoKill)

    fovCircle.Visible = Config.Show_FOV
    if Config.Show_FOV then
        fovCircle.Size = UDim2.new(0, Config.Aimbot_FOV * 2, 0, Config.Aimbot_FOV * 2)
    end

    if Config.Aimbot and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local target = getTargetByRole(Config.Aimbot_FOV)
        if target and target:FindFirstChild("Head") then
            local camPos = Camera.CFrame.Position
            local desired = CFrame.lookAt(camPos, target.Head.Position)
            Camera.CFrame = Camera.CFrame:Lerp(desired, Config.Aimbot_Smoothness)
        end
    end

    if Config.Fly and LocalPlayer.Character then
        local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local dir = Vector3.new()
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0, 1, 0) end
            if dir.Magnitude > 0 then
                hrp.Velocity = dir.Unit * Config.FlySpeed
            else
                hrp.Velocity = Vector3.new(0, 0, 0)
            end
        end
    end

    if Config.Noclip and LocalPlayer.Character then
        for _, p in ipairs(LocalPlayer.Character:GetDescendants()) do
            if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end
        end
    end
end)

-- ============================================================
--  ANTI-FLING
-- ============================================================
local function enableAntiFling()
    if not Config.AntiFling then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5, 1, 1)
    end
end

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(1)
    if Config.AntiFling then enableAntiFling() end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = Config.Speed
        hum.UseJumpPower = true
        hum.JumpPower = Config.JumpPower
    end
end)

-- ============================================================
--  TELEPORTES
-- ============================================================
local function teleportTo(position)
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = CFrame.new(position + Vector3.new(0, 5, 0))
        hrp.Velocity = Vector3.new(0, 0, 0)
    end
end

local function findObby()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name:lower():find("obby") then
            return obj.Position
        end
    end
    return nil
end

local function findMapCenter()
    local sum, count = Vector3.new(), 0
    for _, p in ipairs(Players:GetPlayers()) do
        local c = p.Character
        if c and c:FindFirstChild("HumanoidRootPart") then
            sum = sum + c.HumanoidRootPart.Position
            count = count + 1
        end
    end
    if count > 0 then return sum / count end
    return Vector3.new(0, 10, 0)
end

-- ============================================================
--  GRAB GUN
-- ============================================================
local function findDroppedGun()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Tool") and obj.Name:lower():find("gun") then
            if not isInAnyCharacter(obj) then return obj end
        end
    end
    for _, obj in ipairs(workspace:GetChildren()) do
        if (obj:IsA("Model") or obj:IsA("BasePart"))
           and obj.Name:lower() == "gun"
           and not isInAnyCharacter(obj) then
            return obj
        end
    end
    return nil
end

local function getGunPosition(gun)
    if gun:IsA("BasePart") then return gun.Position end
    if gun:IsA("Tool") then
        local h = gun:FindFirstChild("Handle")
        if h then return h.Position end
    end
    if gun:IsA("Model") then
        if gun.PrimaryPart then return gun.PrimaryPart.Position end
        local any = gun:FindFirstChildWhichIsA("BasePart")
        if any then return any.Position end
    end
    return nil
end

local function attemptPickup(gun)
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local prompt = gun:FindFirstChildOfClass("ProximityPrompt")
    if prompt then
        pcall(function() fireproximityprompt(prompt) end)
        return
    end
    local touchPart = nil
    if gun:IsA("BasePart") then touchPart = gun
    elseif gun:FindFirstChild("Handle") then touchPart = gun:FindFirstChild("Handle")
    elseif gun:IsA("Model") then touchPart = gun:FindFirstChildWhichIsA("BasePart") end

    if touchPart then
        pcall(function()
            firetouchinterest(hrp, touchPart, 0)
            task.wait(0.02)
            firetouchinterest(hrp, touchPart, 1)
        end)
    end
end

local grabbing = false
local function grabGun()
    if grabbing then return false end
    local char = LocalPlayer.Character
    if not char then return false end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end

    for _, t in ipairs(char:GetChildren()) do
        if t:IsA("Tool") and t.Name:lower():find("gun") then return false end
    end

    local gun = findDroppedGun()
    if not gun then return false end
    local gunPos = getGunPosition(gun)
    if not gunPos then return false end

    grabbing = true
    local originalCFrame = hrp.CFrame
    hrp.CFrame = CFrame.new(gunPos + Vector3.new(0, 3, 0))
    hrp.Velocity = Vector3.new(0, 0, 0)
    task.wait(0.08)

    attemptPickup(gun)
    task.wait(Config.AutoGrabGun_ReturnDelay)

    if char.Parent and hrp.Parent then
        if Config.AutoGrabGun_ReturnInstant then
            hrp.CFrame = originalCFrame
            hrp.Velocity = Vector3.new(0, 0, 0)
        else
            local start = hrp.Position
            local target = originalCFrame.Position
            for i = 1, 8 do
                if not hrp.Parent then break end
                hrp.CFrame = CFrame.new(start:Lerp(target, i / 8))
                task.wait(0.02)
            end
            hrp.CFrame = originalCFrame
        end
    end
    grabbing = false
    return true
end

task.spawn(function()
    while task.wait(Config.AutoGrabGun_Delay) do
        pcall(function()
            if Config.AutoGrabGun and not grabbing then
                local char = LocalPlayer.Character
                if char and getRole(LocalPlayer) ~= "Murderer" then
                    local hasG = false
                    for _, t in ipairs(char:GetChildren()) do
                        if t:IsA("Tool") and t.Name:lower():find("gun") then
                            hasG = true
                            break
                        end
                    end
                    if not hasG and findDroppedGun() then pcall(grabGun) end
                end
            end
        end)
    end
end)

-- ============================================================
--  GUN DROP NOTIFIER
-- ============================================================
local lastNotify = 0
local function notifyGunDrop()
    if tick() - lastNotify < 3 then return end
    lastNotify = tick()
    if not Config.GunDropNotify then return end

    pcall(function()
        Rayfield:Notify({
            Title = "Gun Dropada!",
            Content = "A arma do Sheriff caiu. Use Grab Gun!",
            Duration = 5,
        })
    end)

    if Config.GunDropNotify_Sound then
        pcall(function()
            local s = Instance.new("Sound")
            s.SoundId = "rbxassetid://4590662766"
            s.Volume = 0.5
            s.Parent = SoundService
            s:Play()
            task.delay(2, function() s:Destroy() end)
        end)
    end
end

-- ============================================================
--  INTERFACE
-- ============================================================
local Window = Rayfield:CreateWindow({
    Name = "MM2 Check Hub v3",
    LoadingTitle = "Carregando...",
    LoadingSubtitle = "por Check",
    ConfigurationSaving = { Enabled = false },
    Theme = "DarkBlue",
})

-- ---------- Visual ----------
local VisualTab = Window:CreateTab("Visual", 4483362458)
VisualTab:CreateToggle({
    Name = "ESP Players",
    CurrentValue = false,
    Callback = function(v)
        Config.ESP_Players = v
        if not v then for p in pairs(espCache) do removeHighlight(p) end end
    end,
})
VisualTab:CreateToggle({
    Name = "ESP Name",
    CurrentValue = false,
    Callback = function(v)
        Config.ESP_Name = v
        if not v then for p in pairs(nameCache) do removeNameTag(p) end end
    end,
})
VisualTab:CreateToggle({
    Name = "ESP Gun",
    CurrentValue = false,
    Callback = function(v) Config.ESP_Gun = v end,
})

-- ---------- Aimbot ----------
local AimbotTab = Window:CreateTab("Aimbot", 4483362458)
AimbotTab:CreateToggle({
    Name = "Aimbot por Role",
    CurrentValue = false,
    Callback = function(v) Config.Aimbot = v end,
})
AimbotTab:CreateSlider({
    Name = "Suavidade",
    Range = {0.05, 0.5}, Increment = 0.01, CurrentValue = 0.15,
    Callback = function(v) Config.Aimbot_Smoothness = v end,
})
AimbotTab:CreateSlider({
    Name = "FOV do Aimbot",
    Range = {30, 500}, Increment = 5, Suffix = " px",
    CurrentValue = 150,
    Callback = function(v) Config.Aimbot_FOV = v end,
})
AimbotTab:CreateToggle({
    Name = "Mostrar FOV",
    CurrentValue = true,
    Callback = function(v) Config.Show_FOV = v end,
})
AimbotTab:CreateToggle({
    Name = "Trigger Bot",
    CurrentValue = false,
    Callback = function(v) Config.TriggerBot = v end,
})
AimbotTab:CreateToggle({
    Name = "Trigger Team Check",
    CurrentValue = true,
    Callback = function(v) Config.TriggerBot_TeamCheck = v end,
})
AimbotTab:CreateSlider({
    Name = "Trigger Bot FOV",
    Range = {10, 300}, Increment = 5, Suffix = " px",
    CurrentValue = 40,
    Callback = function(v) Config.TriggerBot_FOV = v end,
})
AimbotTab:CreateSlider({
    Name = "Trigger Delay",
    Range = {0, 0.5}, Increment = 0.01, CurrentValue = 0.05,
    Callback = function(v) Config.TriggerBot_Delay = v end,
})

-- ---------- Auto Kill ----------
local AutoKillTab = Window:CreateTab("Auto Kill", 4483362458)
AutoKillTab:CreateToggle({
    Name = "Auto Kill",
    CurrentValue = false,
    Callback = function(v) Config.AutoKill = v end,
})
AutoKillTab:CreateSlider({
    Name = "Alcance Faca",
    Range = {5, 50}, Increment = 1, Suffix = " studs",
    CurrentValue = 15,
    Callback = function(v) Config.AutoKill_Range = v end,
})
AutoKillTab:CreateSlider({
    Name = "Alcance Tiro",
    Range = {50, 1000}, Increment = 10, Suffix = " studs",
    CurrentValue = 500,
    Callback = function(v) Config.AutoKill_GunRange = v end,
})
AutoKillTab:CreateSlider({
    Name = "Delay",
    Range = {0.1, 1.0}, Increment = 0.05, Suffix = " s",
    CurrentValue = 0.35,
    Callback = function(v) Config.AutoKill_Delay = v end,
})
AutoKillTab:CreateToggle({
    Name = "Wall Check",
    CurrentValue = true,
    Callback = function(v) Config.AutoKill_WallCheck = v end,
})
AutoKillTab:CreateToggle({
    Name = "Auto Equip",
    CurrentValue = true,
    Callback = function(v) Config.AutoKill_AutoEquip = v end,
})

-- ---------- Gun ----------
local GunTab = Window:CreateTab("Gun", 4483362458)
GunTab:CreateButton({
    Name = "Grab Gun (manual)",
    Callback = function()
        local ok = grabGun()
        if ok then
            Rayfield:Notify({Title = "Grab Gun", Content = "Arma pega!", Duration = 3})
        else
            Rayfield:Notify({Title = "Grab Gun", Content = "Nenhuma arma encontrada.", Duration = 3})
        end
    end,
})
GunTab:CreateToggle({
    Name = "Auto Grab Gun",
    CurrentValue = false,
    Callback = function(v) Config.AutoGrabGun = v end,
})

-- ---------- Movimento ----------
local MoveTab = Window:CreateTab("Movimento", 4483362458)
MoveTab:CreateSlider({
    Name = "Speed",
    Range = {16, 200}, Increment = 1, Suffix = " studs",
    CurrentValue = 16,
    Callback = function(v)
        Config.Speed = v
        local c = LocalPlayer.Character
        if c and c:FindFirstChildOfClass("Humanoid") then c.Humanoid.WalkSpeed = v end
    end,
})
MoveTab:CreateSlider({
    Name = "Jump Power",
    Range = {50, 300}, Increment = 5,
    CurrentValue = 50,
    Callback = function(v)
        Config.JumpPower = v
        local c = LocalPlayer.Character
        if c and c:FindFirstChildOfClass("Humanoid") then
            c.Humanoid.UseJumpPower = true
            c.Humanoid.JumpPower = v
        end
    end,
})
MoveTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(v) Config.InfiniteJump = v end,
})
MoveTab:CreateToggle({
    Name = "Anti Void",
    CurrentValue = false,
    Callback = function(v) Config.AntiVoid = v end,
})
MoveTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Callback = function(v)
        Config.Fly = v
        if not v then
            local c = LocalPlayer.Character
            if c then
                local hrp = c:FindFirstChild("HumanoidRootPart")
                if hrp then hrp.Velocity = Vector3.new(0, 0, 0) end
            end
        end
    end,
})
MoveTab:CreateSlider({
    Name = "Fly Speed",
    Range = {10, 200}, Increment = 5,
    CurrentValue = 50,
    Callback = function(v) Config.FlySpeed = v end,
})
MoveTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Callback = function(v)
        Config.Noclip = v
        if not v then
            local c = LocalPlayer.Character
            if c then
                for _, p in ipairs(c:GetDescendants()) do
                    if p:IsA("BasePart") then p.CanCollide = true end
                end
            end
        end
    end,
})

-- ---------- Teleporte ----------
local TpTab = Window:CreateTab("Teleporte", 4483362458)
TpTab:CreateButton({
    Name = "Teleport to Obby",
    Callback = function()
        local pos = findObby()
        if pos then
            teleportTo(pos)
            Rayfield:Notify({Title = "Teleporte", Content = "Indo para o Obby...", Duration = 3})
        else
            Rayfield:Notify({Title = "Teleporte", Content = "Obby nao encontrado.", Duration = 3})
        end
    end,
})
TpTab:CreateButton({
    Name = "Teleport to Map (centro)",
    Callback = function()
        teleportTo(findMapCenter())
        Rayfield:Notify({Title = "Teleporte", Content = "Indo para o centro...", Duration = 3})
    end,
})

-- ---------- Protecao ----------
local ProtTab = Window:CreateTab("Protecao", 4483362458)
ProtTab:CreateToggle({
    Name = "Anti-Fling",
    CurrentValue = false,
    Callback = function(v)
        Config.AntiFling = v
        if v then enableAntiFling() end
    end,
})

Rayfield:Notify({
    Title = "MM2 Check Hub v3",
    Content = "Script carregado com sucesso!",
    Duration = 5,
})

end) -- fim do pcall

if not okLoad then
    warn("========================================")
    warn("[MM2 Hub] ERRO AO CARREGAR:")
    warn(tostring(errLoad))
    warn("========================================")
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Erro no Script",
            Text = tostring(errLoad),
            Duration = 15,
        })
    end)
end
