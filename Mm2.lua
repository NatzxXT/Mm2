-- ============================================================
--  MM2 CHECK HUB v3 - ULTRA OTIMIZADO
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
--  ROLE COM CACHE (evita recalcular a cada frame)
-- ============================================================
local roleCache = {}
local ROLE_CACHE_TIME = 0.5

local function getRoleRaw(player)
    local char = player.Character
    if not char then return "Innocent" end

    if char:FindFirstChild("Knife") then return "Murderer" end
    if char:FindFirstChild("Gun") then return "Sheriff" end

    local backpack = player:FindFirstChildOfClass("Backpack")
    if backpack then
        if backpack:FindFirstChild("Knife") then return "Murderer" end
        if backpack:FindFirstChild("Gun") then return "Sheriff" end
    end

    for _, obj in ipairs(char:GetChildren()) do
        if obj:IsA("Tool") then
            local n = obj.Name:lower()
            if n:find("knife") then return "Murderer" end
            if n:find("gun") then return "Sheriff" end
        end
    end
    return "Innocent"
end

local function getRole(player)
    local c = roleCache[player]
    local now = tick()
    if c and now - c.time < ROLE_CACHE_TIME then
        return c.role
    end
    local r = getRoleRaw(player)
    roleCache[player] = { role = r, time = now }
    return r
end

local function getRoleColor(role)
    if role == "Murderer" then return Config.ESP_Color_Murderer end
    if role == "Sheriff" then return Config.ESP_Color_Sheriff end
    return Config.ESP_Color_Innocent
end

Players.PlayerRemoving:Connect(function(p) roleCache[p] = nil end)

-- ============================================================
--  FOV CIRCLES
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
fovCircle.Parent = fovGui

local fovStroke = Instance.new("UIStroke")
fovStroke.Thickness = 1.5
fovStroke.Color = Color3.fromRGB(0, 200, 255)
fovStroke.Transparency = 0.3
fovStroke.Parent = fovCircle

local fovCorner = Instance.new("UICorner")
fovCorner.CornerRadius = UDim.new(1, 0)
fovCorner.Parent = fovCircle

local trigCircle = Instance.new("Frame")
trigCircle.Size = UDim2.new(0, Config.TriggerBot_FOV * 2, 0, Config.TriggerBot_FOV * 2)
trigCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
trigCircle.AnchorPoint = Vector2.new(0.5, 0.5)
trigCircle.BackgroundTransparency = 1
trigCircle.Parent = fovGui

local trigStroke = Instance.new("UIStroke")
trigStroke.Thickness = 1.5
trigStroke.Color = Color3.fromRGB(255, 100, 100)
trigStroke.Transparency = 0.4
trigStroke.Parent = trigCircle

local trigCorner = Instance.new("UICorner")
trigCorner.CornerRadius = UDim.new(1, 0)
trigCorner.Parent = trigCircle

local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
    screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
end)

local function isInFOV(worldPos, fovPixels)
    local sp, onScreen = Camera:WorldToScreenPoint(worldPos)
    if not onScreen then return false end
    local dx = sp.X - screenCenter.X
    local dy = sp.Y - screenCenter.Y
    return (dx*dx + dy*dy) <= (fovPixels * fovPixels)
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
--  ESP (loop próprio, throttle alto)
-- ============================================================
local espCache = {}
local nameCache = {}

local ESP_UPDATE_INTERVAL = 0.25
local ESP_MAX_DISTANCE = 400

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
    hl.DepthMode = Enum.HighlightDepthMode.Occluded
    hl.FillTransparency = 0.7
    hl.OutlineTransparency = 0.3
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
    bg.Size = UDim2.new(0, 160, 0, 22)
    bg.StudsOffset = Vector3.new(0, 3, 0)
    bg.Adornee = head
    bg.AlwaysOnTop = true
    bg.MaxDistance = ESP_MAX_DISTANCE
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
    local myChar = LocalPlayer.Character
    local myPos = myChar and myChar:FindFirstChild("HumanoidRootPart")
        and myChar.HumanoidRootPart.Position or nil

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")

            local tooFar = false
            if myPos and hrp then
                local dx = hrp.Position.X - myPos.X
                local dy = hrp.Position.Y - myPos.Y
                local dz = hrp.Position.Z - myPos.Z
                if (dx*dx + dy*dy + dz*dz) > (ESP_MAX_DISTANCE * ESP_MAX_DISTANCE) then
                    tooFar = true
                end
            end

            if Config.ESP_Players and char and not tooFar then
                if not espCache[player] or not espCache[player].Adornee then
                    createHighlight(player)
                end
                if espCache[player] then
                    local c = getRoleColor(getRole(player))
                    if espCache[player].FillColor ~= c then
                        espCache[player].FillColor = c
                        espCache[player].OutlineColor = c
                    end
                end
            else
                removeHighlight(player)
            end

            if Config.ESP_Name and char and not tooFar then
                if not nameCache[player] then createNameTag(player) end
                if nameCache[player] and nameCache[player].Adornee then
                    local c = getRoleColor(getRole(player))
                    local lbl = nameCache[player]:FindFirstChildOfClass("TextLabel")
                    if lbl and lbl.TextColor3 ~= c then
                        lbl.TextColor3 = c
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
            gunESP.FillTransparency = 0.4
            gunESP.DepthMode = Enum.HighlightDepthMode.Occluded
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
    local best, bestDistSq = nil, math.huge
    local fovSq = fovLimit * fovLimit
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local char = player.Character
            if char and char:FindFirstChild("Head") and isTargetValid(player, false) then
                local sp, onScreen = Camera:WorldToScreenPoint(char.Head.Position)
                if onScreen then
                    local dx = sp.X - screenCenter.X
                    local dy = sp.Y - screenCenter.Y
                    local dSq = dx*dx + dy*dy
                    if dSq <= fovSq and dSq < bestDistSq then
                        bestDistSq = dSq
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
                    if isInFOV(tChar.Head.Position, Config.TriggerBot_FOV) then
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
    local best, bestDistSq = nil, math.huge
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local char = player.Character
            if char and char:FindFirstChild("Head") and getRole(player) == "Murderer" then
                local targetPos = char.Head.Position
                local dx = targetPos.X - myHead.X
                local dy = targetPos.Y - myHead.Y
                local dz = targetPos.Z - myHead.Z
                local dSq = dx*dx + dy*dy + dz*dz
                if dSq < bestDistSq then
                    if not Config.AutoKill_WallCheck or hasLineOfSight(myHead, targetPos, char) then
                        bestDistSq = dSq
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
    local closest, closestDistSq = nil, maxRange * maxRange
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local char = player.Character
            if char and char:FindFirstChild("Head") then
                if getRole(player) ~= "Murderer" then
                    local targetPos = char.Head.Position
                    local dx = targetPos.X - myHead.X
                    local dy = targetPos.Y - myHead.Y
                    local dz = targetPos.Z - myHead.Z
                    local dSq = dx*dx + dy*dy + dz*dz
                    if dSq <= closestDistSq then
                        if not Config.AutoKill_WallCheck or hasLineOfSight(myHead, targetPos, char) then
                            closestDistSq = dSq
                            closest = char
                        end
                    end
                end
            end
        end
    end
    return closest
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
--  INFINITE JUMP
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

-- ============================================================
--  ANTI VOID / NOCLIP (loops throttle)
-- ============================================================
task.spawn(function()
    while task.wait(0.3) do
        if Config.AntiVoid then
            pcall(function()
                local char = LocalPlayer.Character
                if char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp and hrp.Position.Y < -50 then
                        hrp.CFrame = CFrame.new(hrp.Position.X, 50, hrp.Position.Z)
                        hrp.Velocity = Vector3.new(0, 0, 0)
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.4) do
        if Config.Noclip then
            pcall(function()
                local char = LocalPlayer.Character
                if char then
                    for _, p in ipairs(char:GetDescendants()) do
                        if p:IsA("BasePart") and p.CanCollide then
                            p.CanCollide = false
                        end
                    end
                end
            end)
        end
    end
end)

-- ============================================================
--  TRIGGER BOT / AUTO KILL (loops throttle, fora do RenderStepped)
-- ============================================================
task.spawn(function()
    while task.wait(0.05) do
        if Config.TriggerBot then
            pcall(handleTriggerBot)
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if Config.AutoKill then
            pcall(handleAutoKill)
        end
    end
end)

-- ============================================================
--  ESP LOOPS (throttle alto, fora do RenderStepped)
-- ============================================================
task.spawn(function()
    while task.wait(ESP_UPDATE_INTERVAL) do
        pcall(updateESP)
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        pcall(updateGunESP)
    end
end)

-- ============================================================
--  AUTO FARM
-- ============================================================
local CoinFarm = { Enabled = false, Speed = 0.3, MaxCoins = 40 }

local function findCoins()
    local coins = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("Model") then
            local n = obj.Name:lower()
            if n == "coin" or n:find("coin") or n:find("gold") then
                local isInChar = false
                for _, p in ipairs(Players:GetPlayers()) do
                    if p.Character and obj:IsDescendantOf(p.Character) then
                        isInChar = true
                        break
                    end
                end
                if not isInChar then
                    local pos = nil
                    if obj:IsA("BasePart") then
                        pos = obj.Position
                    elseif obj:IsA("Model") and obj.PrimaryPart then
                        pos = obj.PrimaryPart.Position
                    end
                    if pos then table.insert(coins, { obj = obj, pos = pos }) end
                end
            end
        end
    end
    return coins
end

local function getMyCoinCount()
    local stats = LocalPlayer:FindFirstChild("leaderstats")
    if stats then
        local c = stats:FindFirstChild("Coins") or stats:FindFirstChild("Coin")
        if c then return c.Value end
    end
    return 0
end

local farmRunning = false
local function startCoinFarm()
    if farmRunning then return end
    farmRunning = true
    task.spawn(function()
        while CoinFarm.Enabled do
            pcall(function()
                local char = LocalPlayer.Character
                if not char then return end
                local hum = char:FindFirstChildOfClass("Humanoid")
                if not hum or hum.Health <= 0 then return end

                if getMyCoinCount() >= CoinFarm.MaxCoins then
                    CoinFarm.Enabled = false
                    Rayfield:Notify({
                        Title = "Auto Farm",
                        Content = "Limite atingido! Desligando...",
                        Duration = 5,
                    })
                    return
                end

                local coins = findCoins()
                if #coins == 0 then return end

                local myHrp = char:FindFirstChild("HumanoidRootPart")
                if not myHrp then return end
                local myPos = myHrp.Position

                local closest, closestDistSq = nil, math.huge
                for _, c in ipairs(coins) do
                    local dx = c.pos.X - myPos.X
                    local dy = c.pos.Y - myPos.Y
                    local dz = c.pos.Z - myPos.Z
                    local dSq = dx*dx + dy*dy + dz*dz
                    if dSq < closestDistSq then
                        closestDistSq = dSq
                        closest = c
                    end
                end

                if closest then
                    myHrp.CFrame = CFrame.new(closest.pos + Vector3.new(0, 2, 0))
                    myHrp.Velocity = Vector3.new(0, 0, 0)
                end
            end)
            task.wait(CoinFarm.Speed)
        end
        farmRunning = false
    end)
end

-- ============================================================
--  RENDERSTEPPED (SÓ AIMBOT + FLY + FOV)
-- ============================================================
RunService.RenderStepped:Connect(function()
    -- FOV visual
    fovCircle.Visible = Config.Show_FOV
    if Config.Show_FOV then
        local sz = Config.Aimbot_FOV * 2
        if fovCircle.AbsoluteSize.X ~= sz then
            fovCircle.Size = UDim2.new(0, sz, 0, sz)
        end
        trigCircle.Visible = Config.TriggerBot
        if trigCircle.Visible then
            local tsz = Config.TriggerBot_FOV * 2
            if trigCircle.AbsoluteSize.X ~= tsz then
                trigCircle.Size = UDim2.new(0, tsz, 0, tsz)
            end
        end
    else
        trigCircle.Visible = false
    end

    -- Aimbot (precisa ser por frame pra ser suave)
    if Config.Aimbot then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local target = getTargetByRole(Config.Aimbot_FOV)
            if target and target:FindFirstChild("Head") then
                local desired = CFrame.lookAt(Camera.CFrame.Position, target.Head.Position)
                Camera.CFrame = Camera.CFrame:Lerp(desired, Config.Aimbot_Smoothness)
            end
        end
    end

    -- Fly
    if Config.Fly then
        local char = LocalPlayer.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
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
--  INTERFACE
-- ============================================================
local Window = Rayfield:CreateWindow({
    Name = "MM2 Check Hub v3",
    LoadingTitle = "Carregando...",
    LoadingSubtitle = "por Check",
    ConfigurationSaving = { Enabled = false },
    Theme = "DarkBlue",
})

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
    Name = "Mostrar FOVs",
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

local FarmTab = Window:CreateTab("Auto Farm", 4483362458)
FarmTab:CreateToggle({
    Name = "Auto Farm Coins",
    CurrentValue = false,
    Callback = function(v)
        CoinFarm.Enabled = v
        if v then
            startCoinFarm()
            Rayfield:Notify({
                Title = "Auto Farm",
                Content = "Farmando ate " .. CoinFarm.MaxCoins .. " moedas...",
                Duration = 4,
            })
        end
    end,
})
FarmTab:CreateSlider({
    Name = "Farm Speed",
    Range = {0.1, 1.0}, Increment = 0.05, Suffix = " s",
    CurrentValue = 0.3,
    Callback = function(v) CoinFarm.Speed = v end,
})
FarmTab:CreateSlider({
    Name = "Limite de Moedas",
    Range = {10, 50}, Increment = 5,
    CurrentValue = 40,
    Callback = function(v) CoinFarm.MaxCoins = v end,
})
FarmTab:CreateButton({
    Name = "Ver minhas moedas atuais",
    Callback = function()
        Rayfield:Notify({
            Title = "Moedas",
            Content = "Voce tem: " .. getMyCoinCount(),
            Duration = 4,
        })
    end,
})

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

end)

if not okLoad then
    warn("[MM2 Hub] ERRO:", tostring(errLoad))
end
