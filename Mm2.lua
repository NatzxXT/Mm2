-- ============================================================
--  MM2 CHECK HUB v3 - FINAL ORGANIZADO
--  Visual • Visual+ • Aimbot • Murder • Sheriff • Farm
--  Player • Performance • Extras • Teleporte • Protecao
-- ============================================================

-- ============================================================
--  VERIFICAÇÃO DE JOGO (só funciona no MM2)
-- ============================================================
local MM2_PLACE_IDS = { 142823291, 1990777535, 321010323 }

local function isMM2()
    for _, id in ipairs(MM2_PLACE_IDS) do
        if game.PlaceId == id then return true end
    end
    local gname = string.lower(game.Name or "")
    if gname == "murder mystery 2" or gname == "mm2" then return true end
    local ok, info = pcall(function()
        return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
    end)
    if ok and info and info.Name then
        local n = string.lower(info.Name)
        if n == "murder mystery 2" or n == "mm2" then return true end
    end
    return false
end

if not isMM2() then
    local avisoGui = Instance.new("ScreenGui")
    avisoGui.Name = "MM2_NotCompatible"
    avisoGui.ResetOnSpawn = false
    avisoGui.IgnoreGuiInset = true
    avisoGui.DisplayOrder = 9999
    pcall(function() avisoGui.Parent = game:GetService("CoreGui") end)

    local gameDisplayName = game.Name or "?"

    local frame = Instance.new("Frame")
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame.Size = UDim2.fromOffset(440, 150)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    frame.BackgroundTransparency = 0.05
    frame.BorderSizePixel = 0
    frame.Parent = avisoGui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 70, 70)
    stroke.Thickness = 2
    stroke.Transparency = 0.2
    stroke.Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -20, 0, 40)
    title.Position = UDim2.fromOffset(10, 10)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.TextColor3 = Color3.fromRGB(255, 90, 90)
    title.Text = "⚠ Jogo Incompatível"
    title.Parent = frame

    local msg = Instance.new("TextLabel")
    msg.Size = UDim2.new(1, -20, 0, 80)
    msg.Position = UDim2.fromOffset(10, 50)
    msg.BackgroundTransparency = 1
    msg.Font = Enum.Font.Gotham
    msg.TextSize = 14
    msg.TextColor3 = Color3.fromRGB(230, 230, 240)
    msg.TextWrapped = true
    msg.Text = "Este script só funciona no Murder Mystery 2 (MM2).\n\nJogo atual: " .. tostring(gameDisplayName) .. "\nPlaceId: " .. tostring(game.PlaceId)
    msg.Parent = frame

    task.spawn(function()
        pcall(function()
            local HttpService = game:GetService("HttpService")
            local url = "https://games.roblox.com/v1/games?universeIds=" .. tostring(game.GameId)
            local response = nil
            if syn and syn.request then
                local ok, res = pcall(function() return syn.request({ Url = url, Method = "GET" }) end)
                if ok and res and res.Body then response = res.Body end
            elseif request then
                local ok, res = pcall(function() return request({ Url = url, Method = "GET" }) end)
                if ok and res and res.Body then response = res.Body end
            elseif http_request then
                local ok, res = pcall(function() return http_request({ Url = url, Method = "GET" }) end)
                if ok and res and res.Body then response = res.Body end
            else
                local ok, res = pcall(function() return game:HttpGet(url, true) end)
                if ok and res then response = res end
            end
            if response then
                local data = HttpService:JSONDecode(response)
                if data and data.data and data.data[1] and data.data[1].name then
                    gameDisplayName = data.data[1].name
                    if msg and msg.Parent then
                        msg.Text = "Este script só funciona no Murder Mystery 2 (MM2).\n\nJogo atual: " .. tostring(gameDisplayName) .. "\nPlaceId: " .. tostring(game.PlaceId)
                    end
                end
            end
        end)
    end)

    task.spawn(function()
        for i = 0, 1, 0.1 do
            frame.BackgroundTransparency = 0.05 + 0.95 * (1 - i)
            title.TextTransparency = 1 - i
            msg.TextTransparency = 1 - i
            task.wait(0.02)
        end
    end)

    task.delay(5, function()
        for i = 1, 0, -0.1 do
            frame.BackgroundTransparency = 0.05 + 0.95 * (1 - i)
            title.TextTransparency = 1 - i
            msg.TextTransparency = 1 - i
            task.wait(0.02)
        end
        avisoGui:Destroy()
    end)

    warn("[MM2 Hub] Jogo incompatível: " .. tostring(gameDisplayName) .. " (PlaceId: " .. tostring(game.PlaceId) .. ")")
    return
end

-- ============================================================
--  SCRIPT PRINCIPAL
-- ============================================================
local okLoad, errLoad = pcall(function()

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local Lighting = game:GetService("Lighting")
local PhysicsService = game:GetService("PhysicsService")
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
    Aimbot_Smoothness = 0.2,
    Aimbot_FOV = 150,
    Aimbot_WallCheck = false,
    Aimbot_TeamCheck = false,
    Aimbot_Instant = false,
    Show_FOV = true,
    TriggerBot = false,
    TriggerBot_TeamCheck = false,
    TriggerBot_Delay = 0.08,
    TriggerBot_FOV = 40,
    TriggerBot_WallCheck = false,
    TriggerBot_Instant = false,
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
    Invisible = false,
    InvisibleX = 0,
    InvisibleY = 5000,
    InvisibleZ = 0,
    AutoGrabGun = false,
    AutoGrabGun_Delay = 1.0,
    AutoGrabGun_ReturnDelay = 0.4,
    AutoGrabGun_ReturnInstant = true,
    Perf_NoFog = false,
    Perf_NoShadow = false,
    Perf_SmoothTexture = false,
    Perf_FullBright = false,
    AntiKick = false,
    AntiRagdoll = false,
    KillNotifier = false,
    AutoDodge = false,
    HitboxExpander = false,
    HitboxSize = 5,
    HitboxMaxDist = 200,
    CoinESP = false,
    RadarHUD = false,
    AntiAFK = false,
    MurdererAlert = false,
    MurdererAlertRange = 80,
    LockCameraMurderer = false,
    AntiExplosion = false,
    AutoReset = false,
    FOV_Color_Aimbot = Color3.fromRGB(0, 200, 255),
    FOV_Color_Trigger = Color3.fromRGB(255, 100, 100),
}

-- ============================================================
--  ROLE
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
    if c and now - c.time < ROLE_CACHE_TIME then return c.role end
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
fovStroke.Color = Config.FOV_Color_Aimbot
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
trigStroke.Color = Config.FOV_Color_Trigger
trigStroke.Transparency = 0.4
trigStroke.Parent = trigCircle

local trigCorner = Instance.new("UICorner")
trigCorner.CornerRadius = UDim.new(1, 0)
trigCorner.Parent = trigCircle

local function getScreenCenter()
    return Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
end

-- ============================================================
--  HELPERS
-- ============================================================
local function findTool(char, keyword)
    if not char then return nil end
    for _, t in ipairs(char:GetChildren()) do
        if t:IsA("Tool") and t.Name:lower():find(keyword) then return t end
    end
    return nil
end

local function getEquippedTool(char)
    if not char then return nil end
    local tool = char:FindFirstChildOfClass("Tool")
    if tool then return tool end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum and hum.GetEquippedTool then
        pcall(function() tool = hum:GetEquippedTool() end)
    end
    return tool
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
--  FINDERS (OTIMIZADO)
-- ============================================================
local gunCache = { obj = nil, time = 0 }

local function findDroppedGunPart()
    local now = tick()
    if gunCache.obj and gunCache.obj.Parent and now - gunCache.time < 2 then
        return gunCache.obj
    end

    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:IsA("Tool") then
            local n = obj.Name:lower()
            if n:find("gun") or n:find("revolver") or n:find("pistol") then
                if not isInAnyCharacter(obj) then
                    gunCache.obj = obj
                    gunCache.time = now
                    return obj
                end
            end
        end
    end

    for _, folderName in ipairs({"Guns", "Items", "Tools", "Weapons", "DroppedItems"}) do
        local folder = workspace:FindFirstChild(folderName)
        if folder then
            for _, obj in ipairs(folder:GetChildren()) do
                if obj:IsA("Tool") or obj:IsA("BasePart") or obj:IsA("Model") then
                    local n = obj.Name:lower()
                    if n:find("gun") or n:find("revolver") or n:find("pistol") then
                        if not isInAnyCharacter(obj) then
                            gunCache.obj = obj
                            gunCache.time = now
                            return obj
                        end
                    end
                end
            end
        end
    end

    gunCache.obj = nil
    return nil
end

-- ============================================================
--  ESP
-- ============================================================
local espCache = {}
local nameCache = {}
local ESP_UPDATE_INTERVAL = 0.35
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

local function isHighlightValid(player)
    local hl = espCache[player]
    if not hl or not hl.Parent then return false end
    if hl.Adornee ~= player.Character then return false end
    return true
end

local function isNameTagValid(player)
    local bg = nameCache[player]
    if not bg or not bg.Parent then return false end
    local head = player.Character and player.Character:FindFirstChild("Head")
    if bg.Adornee ~= head then return false end
    return true
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
                if not isHighlightValid(player) then
                    removeHighlight(player)
                    createHighlight(player)
                end
                if espCache[player] then
                    local c = getRoleColor(getRole(player))
                    if espCache[player].FillColor ~= c then
                        espCache[player].FillColor = c
                        espCache[player].OutlineColor = c
                    end
                    espCache[player].DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                end
            else
                removeHighlight(player)
            end
            if Config.ESP_Name and char and not tooFar then
                if not isNameTagValid(player) then
                    removeNameTag(player)
                    createNameTag(player)
                end
                if nameCache[player] and nameCache[player].Adornee then
                    local c = getRoleColor(getRole(player))
                    local lbl = nameCache[player]:FindFirstChildOfClass("TextLabel")
                    if lbl and lbl.TextColor3 ~= c then lbl.TextColor3 = c end
                end
            else
                removeNameTag(player)
            end
        end
    end
end

local gunESP = nil
local gunESPObject = nil
local function updateGunESP()
    if not Config.ESP_Gun then
        if gunESP then gunESP:Destroy() gunESP = nil gunESPObject = nil end
        return
    end
    local gun = findDroppedGunPart()
    if not gun then
        if gunESP then gunESP:Destroy() gunESP = nil gunESPObject = nil end
        return
    end
    if gunESPObject == gun and gunESP and gunESP.Parent then return end
    if gunESP then gunESP:Destroy() gunESP = nil end
    gunESPObject = gun

    local adornee = gun
    if gun:IsA("Tool") then
        adornee = gun:FindFirstChild("Handle") or gun:FindFirstChildWhichIsA("BasePart") or gun
    end

    gunESP = Instance.new("Highlight")
    gunESP.Adornee = adornee
    gunESP.FillColor = Color3.fromRGB(255, 255, 0)
    gunESP.OutlineColor = Color3.fromRGB(255, 255, 0)
    gunESP.FillTransparency = 0.3
    gunESP.OutlineTransparency = 0
    gunESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    gunESP.Parent = adornee
end

-- ============================================================
--  AIMBOT / TRIGGER
-- ============================================================
local function isTargetValid(targetPlayer, useTeamCheck)
    if targetPlayer == LocalPlayer then return false end
    local myRole = getRole(LocalPlayer)
    local tRole = getRole(targetPlayer)
    if useTeamCheck and myRole == tRole then return false end
    if myRole == "Murderer" then return tRole ~= "Murderer" end
    return tRole == "Murderer"
end

local function getTargetByRole(fovLimit)
    local best, bestDistSq = nil, math.huge
    local fovSq = fovLimit * fovLimit
    local camPos = Camera.CFrame.Position
    local myChar = LocalPlayer.Character
    local center = getScreenCenter()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local char = player.Character
            if char then
                local head = char:FindFirstChild("Head")
                if head and isTargetValid(player, Config.Aimbot_TeamCheck) then
                    local sp, onScreen = Camera:WorldToScreenPoint(head.Position)
                    if onScreen then
                        local dx = sp.X - center.X
                        local dy = sp.Y - center.Y
                        local dSq = dx*dx + dy*dy
                        if dSq <= fovSq and dSq < bestDistSq then
                            local okWall = true
                            if Config.Aimbot_WallCheck then
                                okWall = hasLineOfSight(camPos, head.Position, myChar)
                            end
                            if okWall then
                                bestDistSq = dSq
                                best = char
                            end
                        end
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
    if not Config.TriggerBot_Instant then
        if now - lastFire < Config.TriggerBot_Delay then return end
    end
    local char = LocalPlayer.Character
    if not char then return end
    local tool = getEquippedTool(char)
    if not tool then return end

    local myRole = getRole(LocalPlayer)
    local isMelee = myRole == "Murderer" or tool.Name:lower():find("knife")
    local myHRP = char:FindFirstChild("HumanoidRootPart")
    if not myHRP then return end
    local myPos = myHRP.Position
    local center = getScreenCenter()
    local camPos = Camera.CFrame.Position

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local tChar = player.Character
            if tChar then
                local head = tChar:FindFirstChild("Head")
                local tHRP = tChar:FindFirstChild("HumanoidRootPart")
                if head and tHRP then
                    if isTargetValid(player, Config.TriggerBot_TeamCheck) then
                        local dist = (tHRP.Position - myPos).Magnitude
                        local rangeOk = true
                        if isMelee then rangeOk = dist <= 18 end
                        if rangeOk then
                            local sp, onScreen = Camera:WorldToScreenPoint(head.Position)
                            if onScreen then
                                local dx = sp.X - center.X
                                local dy = sp.Y - center.Y
                                local dSq = dx*dx + dy*dy
                                if dSq <= (Config.TriggerBot_FOV * Config.TriggerBot_FOV) then
                                    local canFire = true
                                    if Config.TriggerBot_WallCheck then
                                        canFire = hasLineOfSight(camPos, head.Position, char)
                                    end
                                    if canFire then
                                        pcall(function() tool:Activate() end)
                                        lastFire = now
                                        return
                                    end
                                end
                            end
                        end
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
                local tp = char.Head.Position
                local dx = tp.X - myHead.X
                local dy = tp.Y - myHead.Y
                local dz = tp.Z - myHead.Z
                local dSq = dx*dx + dy*dy + dz*dz
                if dSq < bestDistSq then
                    if not Config.AutoKill_WallCheck or hasLineOfSight(myHead, tp, char) then
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
                    local tp = char.Head.Position
                    local dx = tp.X - myHead.X
                    local dy = tp.Y - myHead.Y
                    local dz = tp.Z - myHead.Z
                    local dSq = dx*dx + dy*dy + dz*dz
                    if dSq <= closestDistSq then
                        if not Config.AutoKill_WallCheck or hasLineOfSight(myHead, tp, char) then
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
--  LOOPS
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
                        if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.05) do
        if Config.TriggerBot then pcall(handleTriggerBot) end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if Config.AutoKill then pcall(handleAutoKill) end
    end
end)

task.spawn(function()
    while task.wait(ESP_UPDATE_INTERVAL) do pcall(updateESP) end
end)

task.spawn(function()
    while task.wait(1) do pcall(updateGunESP) end
end)

-- ============================================================
--  EXTRAS — SISTEMAS
-- ============================================================
-- ANTI-KICK
pcall(function()
    local StarterGui = game:GetService("StarterGui")
    if hookfunction then
        local oldSetCore = StarterGui.SetCore
        hookfunction(oldSetCore, function(self, ...)
            local args = {...}
            if args[1] == "SendNotification" then
                return oldSetCore(self, ...)
            end
            if Config.AntiKick then return end
            return oldSetCore(self, ...)
        end)
    end
end)

-- ANTI-RAGDOLL
task.spawn(function()
    while task.wait(0.15) do
        if Config.AntiRagdoll then
            pcall(function()
                local char = LocalPlayer.Character
                if char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then
                        local state = hum:GetState()
                        if state == Enum.HumanoidStateType.FallingDown
                           or state == Enum.HumanoidStateType.Ragdoll
                           or state == Enum.HumanoidStateType.Physics then
                            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
                            hum.PlatformStand = false
                            local hrp = char:FindFirstChild("HumanoidRootPart")
                            if hrp then hrp.AssemblyAngularVelocity = Vector3.zero end
                        end
                    end
                end
            end)
        end
    end
end)

-- KILL NOTIFIER
local killHealthTrack = {}
task.spawn(function()
    while task.wait(0.5) do
        if Config.KillNotifier then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    local char = player.Character
                    if char then
                        local hum = char:FindFirstChildOfClass("Humanoid")
                        if hum then
                            local last = killHealthTrack[player]
                            if last and last > 0 and hum.Health <= 0 then
                                local role = getRole(player)
                                pcall(function()
                                    Rayfield:Notify({
                                        Title = "💀 Kill Notifier",
                                        Content = player.Name .. " (" .. role .. ") morreu!",
                                        Duration = 4,
                                    })
                                end)
                            end
                            killHealthTrack[player] = hum.Health
                        end
                    end
                end
            end
        end
    end
end)

-- AUTO DODGE
task.spawn(function()
    while task.wait(0.25) do
        if Config.AutoDodge then
            pcall(function()
                local char = LocalPlayer.Character
                if not char then return end
                local hrp = char:FindFirstChild("HumanoidRootPart")
                local hum = char:FindFirstChildOfClass("Humanoid")
                if not hrp or not hum or hum.Health <= 0 then return end
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and getRole(player) == "Murderer" then
                        local tChar = player.Character
                        if tChar then
                            local tHrp = tChar:FindFirstChild("HumanoidRootPart")
                            if tHrp then
                                local diff = hrp.Position - tHrp.Position
                                local dist = diff.Magnitude
                                if dist < 18 and dist > 1 then
                                    local dir = diff.Unit
                                    hrp.Velocity = dir * 90 + Vector3.new(0, 35, 0)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- ============================================================
--  NOVAS FUNÇÕES
-- ============================================================
-- HITBOX EXPANDER
local hitboxSaved = setmetatable({}, { __mode = "k" })
task.spawn(function()
    while task.wait(0.15) do
        if Config.HitboxExpander then
            pcall(function()
                local myChar = LocalPlayer.Character
                local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
                local myPos = myHrp and myHrp.Position or nil
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer then
                        local char = player.Character
                        if char then
                            local hrp = char:FindFirstChild("HumanoidRootPart")
                            local dist = (myPos and hrp) and (hrp.Position - myPos).Magnitude or 0
                            if dist <= Config.HitboxMaxDist then
                                for _, part in ipairs(char:GetDescendants()) do
                                    if part:IsA("BasePart") and (part.Name == "Head" or part.Name:find("Torso")) then
                                        if hitboxSaved[part] == nil then
                                            hitboxSaved[part] = part.Size
                                        end
                                        pcall(function()
                                            part.Size = Vector3.new(Config.HitboxSize, Config.HitboxSize, Config.HitboxSize)
                                            part.CanCollide = false
                                            part.Transparency = 0.5
                                        end)
                                    end
                                end
                            else
                                for _, part in ipairs(char:GetDescendants()) do
                                    if part:IsA("BasePart") and hitboxSaved[part] then
                                        pcall(function()
                                            part.Size = hitboxSaved[part]
                                            part.CanCollide = true
                                            part.Transparency = 0
                                        end)
                                        hitboxSaved[part] = nil
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        else
            pcall(function()
                for part, size in pairs(hitboxSaved) do
                    if part and part.Parent then
                        part.Size = size
                        part.CanCollide = true
                        part.Transparency = 0
                    end
                end
                hitboxSaved = setmetatable({}, { __mode = "k" })
            end)
        end
    end
end)

-- COIN ESP
local coinESPObjs = {}
local function updateCoinESP()
    if not Config.CoinESP then
        for _, o in pairs(coinESPObjs) do pcall(function() o:Destroy() end) end
        coinESPObjs = {}
        return
    end
    for _, coin in ipairs(findCoins()) do
        if not coinESPObjs[coin.obj] then
            local hl = Instance.new("Highlight")
            hl.Adornee = coin.obj
            hl.FillColor = Color3.fromRGB(255, 215, 0)
            hl.OutlineColor = Color3.fromRGB(255, 215, 0)
            hl.FillTransparency = 0.4
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.Parent = coin.obj
            coinESPObjs[coin.obj] = hl
        end
    end
    for obj, hl in pairs(coinESPObjs) do
        if not obj.Parent then
            pcall(function() hl:Destroy() end)
            coinESPObjs[obj] = nil
        end
    end
end
task.spawn(function()
    while task.wait(1) do pcall(updateCoinESP) end
end)

-- RADAR HUD
local radarGui = Instance.new("ScreenGui")
radarGui.Name = "MM2_Radar"
radarGui.ResetOnSpawn = false
radarGui.IgnoreGuiInset = true
pcall(function() radarGui.Parent = game.CoreGui end)

local radarFrame = Instance.new("Frame")
radarFrame.Size = UDim2.fromOffset(140, 140)
radarFrame.Position = UDim2.new(0, 20, 0.5, -70)
radarFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
radarFrame.BackgroundTransparency = 0.6
radarFrame.BorderSizePixel = 0
radarFrame.Visible = false
radarFrame.Parent = radarGui
Instance.new("UICorner", radarFrame).CornerRadius = UDim.new(1, 0)

local radarPlayer = Instance.new("Frame")
radarPlayer.Size = UDim2.fromOffset(6, 6)
radarPlayer.Position = UDim2.new(0.5, -3, 0.5, -3)
radarPlayer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
radarPlayer.BorderSizePixel = 0
radarPlayer.Parent = radarFrame
Instance.new("UICorner", radarPlayer).CornerRadius = UDim.new(1, 0)

local radarDots = {}
local RADAR_RANGE = 200

task.spawn(function()
    while task.wait(0.15) do
        radarFrame.Visible = Config.RadarHUD
        if Config.RadarHUD then
            local myChar = LocalPlayer.Character
            local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
            if myHrp then
                local myPos = myHrp.Position
                local myLook = Camera.CFrame.LookVector
                local angle = math.atan2(myLook.X, myLook.Z)
                local used = {}
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer then
                        local char = player.Character
                        local hrp = char and char:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            local rel = hrp.Position - myPos
                            if rel.Magnitude <= RADAR_RANGE then
                                local rotX = rel.X * math.cos(-angle) - rel.Z * math.sin(-angle)
                                local rotZ = rel.X * math.sin(-angle) + rel.Z * math.cos(-angle)
                                local px = (rotX / RADAR_RANGE) * 60 + 70
                                local py = -(rotZ / RADAR_RANGE) * 60 + 70
                                local dot = radarDots[player]
                                if not dot then
                                    dot = Instance.new("Frame")
                                    dot.Size = UDim2.fromOffset(8, 8)
                                    dot.BorderSizePixel = 0
                                    dot.Parent = radarFrame
                                    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
                                    radarDots[player] = dot
                                end
                                dot.Position = UDim2.fromOffset(px - 4, py - 4)
                                local role = getRole(player)
                                dot.BackgroundColor3 = getRoleColor(role)
                                used[player] = true
                            end
                        end
                    end
                end
                for p, dot in pairs(radarDots) do
                    if not used[p] then
                        pcall(function() dot:Destroy() end)
                        radarDots[p] = nil
                    end
                end
            end
        end
    end
end)

-- ANTI-AFK
task.spawn(function()
    while task.wait(60) do
        if Config.AntiAFK then
            pcall(function()
                local VirtualUser = game:GetService("VirtualUser")
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new(0, 0))
            end)
        end
    end
end)

-- MURDERER ALERT
local lastMurdererDist = 999
task.spawn(function()
    while task.wait(0.5) do
        if Config.MurdererAlert then
            pcall(function()
                local myChar = LocalPlayer.Character
                local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
                if myHrp then
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and getRole(player) == "Murderer" then
                            local tChar = player.Character
                            local tHrp = tChar and tChar:FindFirstChild("HumanoidRootPart")
                            if tHrp then
                                local dist = (tHrp.Position - myHrp.Position).Magnitude
                                if dist <= Config.MurdererAlertRange and lastMurdererDist > Config.MurdererAlertRange then
                                    Rayfield:Notify({
                                        Title = "🚨 ALERTA",
                                        Content = "Murderer perto! Distancia: " .. math.floor(dist) .. " studs",
                                        Duration = 4,
                                    })
                                end
                                lastMurdererDist = dist
                                break
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- LOCK CAMERA NO MURDERER
task.spawn(function()
    while task.wait(0.05) do
        if Config.LockCameraMurderer then
            pcall(function()
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and getRole(player) == "Murderer" then
                        local tChar = player.Character
                        local head = tChar and tChar:FindFirstChild("Head")
                        if head then
                            local desired = CFrame.lookAt(Camera.CFrame.Position, head.Position)
                            Camera.CFrame = Camera.CFrame:Lerp(desired, 0.3)
                        end
                        break
                    end
                end
            end)
        end
    end
end)

-- ANTI-EXPLOSION
task.spawn(function()
    while task.wait(0.2) do
        if Config.AntiExplosion then
            pcall(function()
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("Explosion") then
                        obj.BlastRadius = 0
                        obj.BlastPressure = 0
                    end
                end
            end)
        end
    end
end)

-- PLAYER LIST
local function showPlayerList()
    local msg = "Jogadores:\n"
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local role = getRole(player)
            msg = msg .. "• " .. player.Name .. " — " .. role .. "\n"
        end
    end
    Rayfield:Notify({ Title = "Player List", Content = msg, Duration = 10 })
end

-- SERVER HOP
local function serverHop()
    Rayfield:Notify({ Title = "Server Hop", Content = "Procurando servidor...", Duration = 3 })
    task.spawn(function()
        pcall(function()
            local HttpService = game:GetService("HttpService")
            local TS = game:GetService("TeleportService")
            local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
            local response
            if syn and syn.request then
                response = syn.request({ Url = url, Method = "GET" }).Body
            elseif request then
                response = request({ Url = url, Method = "GET" }).Body
            else
                response = game:HttpGet(url)
            end
            local data = HttpService:JSONDecode(response)
            if data and data.data then
                for _, server in ipairs(data.data) do
                    if server.playing < server.maxPlayers and server.id ~= game.JobId then
                        TS:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                        return
                    end
                end
            end
            Rayfield:Notify({ Title = "Server Hop", Content = "Nenhum servidor encontrado", Duration = 3 })
        end)
    end)
end

-- MURDER: KILL ALL
local function killAll()
    local char = LocalPlayer.Character
    if not char then return end
    local knife = findTool(char, "knife")
    if not knife then
        Rayfield:Notify({ Title = "Kill All", Content = "Precisa estar de Murderer com faca!", Duration = 3 })
        return
    end
    task.spawn(function()
        local myHrp = char:FindFirstChild("HumanoidRootPart")
        if not myHrp then return end
        local originalCF = myHrp.CFrame
        local count = 0
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local tChar = player.Character
                if tChar then
                    local tHrp = tChar:FindFirstChild("HumanoidRootPart")
                    local hum = tChar:FindFirstChildOfClass("Humanoid")
                    if tHrp and hum and hum.Health > 0 then
                        myHrp.CFrame = tHrp.CFrame
                        task.wait(0.12)
                        pcall(function() knife:Activate() end)
                        task.wait(0.18)
                        count = count + 1
                    end
                end
            end
        end
        myHrp.CFrame = originalCF
        Rayfield:Notify({ Title = "Kill All", Content = "Tentei matar " .. count .. " players", Duration = 4 })
    end)
end

-- TELEPORT TO ROLE
local function teleportToRole(roleName)
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and getRole(player) == roleName then
            local char = player.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local myChar = LocalPlayer.Character
                    if myChar then
                        local myHrp = myChar:FindFirstChild("HumanoidRootPart")
                        if myHrp then
                            myHrp.CFrame = CFrame.new(hrp.Position + Vector3.new(0, 3, 0))
                            Rayfield:Notify({
                                Title = "Teleporte",
                                Content = "Fui para " .. player.Name .. " (" .. roleName .. ")",
                                Duration = 3,
                            })
                            return
                        end
                    end
                end
            end
        end
    end
    Rayfield:Notify({ Title = "Teleporte", Content = roleName .. " nao encontrado", Duration = 3 })
end

-- ============================================================
--  PERFORMANCE (OTIMIZADO)
-- ============================================================
local perfSaved = {}
local savedMaterials = setmetatable({}, { __mode = "k" })
local savedShadows = setmetatable({}, { __mode = "k" })
local perfState = { nofog = false, noshadow = false, smooth = false, bright = false }

local function saveLightingOnce(key, props)
    if perfSaved[key] then return end
    perfSaved[key] = {}
    for _, p in ipairs(props) do perfSaved[key][p] = Lighting[p] end
end

local function restoreLighting(key)
    if not perfSaved[key] then return end
    for p, v in pairs(perfSaved[key]) do
        pcall(function() Lighting[p] = v end)
    end
    perfSaved[key] = nil
end

local function applyPartPerf(part)
    if not part:IsA("BasePart") then return end
    if perfState.noshadow then
        if savedShadows[part] == nil then savedShadows[part] = part.CastShadow end
        pcall(function() part.CastShadow = false end)
    end
    if perfState.smooth then
        if savedMaterials[part] == nil then savedMaterials[part] = part.Material end
        pcall(function() part.Material = Enum.Material.SmoothPlastic end)
    end
end

workspace.DescendantAdded:Connect(function(obj)
    if perfState.noshadow or perfState.smooth then
        pcall(applyPartPerf, obj)
    end
end)

local function restoreMaterials()
    for obj, mat in pairs(savedMaterials) do
        if obj and obj.Parent then pcall(function() obj.Material = mat end) end
    end
end

local function restoreShadows()
    for obj, sh in pairs(savedShadows) do
        if obj and obj.Parent then pcall(function() obj.CastShadow = sh end) end
    end
end

local function bulkApply()
    task.spawn(function()
        local count = 0
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                applyPartPerf(obj)
                count = count + 1
                if count % 500 == 0 then task.wait() end
            end
        end
    end)
end

task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            if Config.Perf_FullBright and not perfState.bright then
                saveLightingOnce("bright", { "Brightness", "Ambient", "OutdoorAmbient", "ClockTime" })
                Lighting.Brightness = 3
                Lighting.ClockTime = 14
                Lighting.Ambient = Color3.fromRGB(200, 200, 200)
                Lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 200)
                perfState.bright = true
            elseif not Config.Perf_FullBright and perfState.bright then
                restoreLighting("bright")
                perfState.bright = false
            end

            if Config.Perf_NoFog and not perfState.nofog then
                saveLightingOnce("fog", { "FogEnd", "FogStart", "FogColor" })
                Lighting.FogEnd = 100000
                Lighting.FogStart = 100000
                perfState.nofog = true
            elseif not Config.Perf_NoFog and perfState.nofog then
                restoreLighting("fog")
                perfState.nofog = false
            end

            if Config.Perf_NoShadow and not perfState.noshadow then
                saveLightingOnce("shadow", { "GlobalShadows" })
                Lighting.GlobalShadows = false
                perfState.noshadow = true
                bulkApply()
            elseif not Config.Perf_NoShadow and perfState.noshadow then
                restoreLighting("shadow")
                restoreShadows()
                perfState.noshadow = false
            end

            if Config.Perf_SmoothTexture and not perfState.smooth then
                perfState.smooth = true
                bulkApply()
            elseif not Config.Perf_SmoothTexture and perfState.smooth then
                restoreMaterials()
                perfState.smooth = false
            end
        end)
    end
end)

-- ============================================================
--  AUTO FARM
-- ============================================================
local CoinFarm = { Enabled = false, Speed = 0.4, MaxCoins = 40 }
local coinAttempts = {}
local coinBlacklist = {}
local BLACKLIST_TIME = 8
local MAX_ATTEMPTS = 3

local function isBlacklisted(obj)
    local t = coinBlacklist[obj]
    if not t then return false end
    if tick() - t > BLACKLIST_TIME then
        coinBlacklist[obj] = nil
        coinAttempts[obj] = nil
        return false
    end
    return true
end

local function findCoins()
    local coins = {}
    local seen = {}
    local function scanRoot(root)
        for _, obj in ipairs(root:GetDescendants()) do
            if (obj:IsA("BasePart") or obj:IsA("MeshPart")) and not seen[obj] then
                local n = obj.Name:lower()
                if n:find("coin") or n:find("token") or n == "money" or n:find("gold") or n:find("cash") then
                    if not isBlacklisted(obj) then
                        local isInChar = false
                        for _, p in ipairs(Players:GetPlayers()) do
                            if p.Character and obj:IsDescendantOf(p.Character) then
                                isInChar = true break
                            end
                        end
                        if not isInChar and obj.Parent then
                            seen[obj] = true
                            table.insert(coins, { obj = obj, pos = obj.Position })
                        end
                    end
                end
            end
        end
    end
    local coinsFolder = workspace:FindFirstChild("Coins")
    if coinsFolder then scanRoot(coinsFolder) end
    local ignored = workspace:FindFirstChild("Ignored") or workspace:FindFirstChild("Ignore")
    if ignored then scanRoot(ignored) end
    scanRoot(workspace)
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

local function collectCoin(coinObj, coinPos)
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    hrp.CFrame = CFrame.new(coinPos + Vector3.new(0, 1, 0))
    hrp.Velocity = Vector3.new(0, 0, 0)
    task.wait(0.05)
    local prompt = coinObj:FindFirstChildOfClass("ProximityPrompt")
    if prompt then pcall(function() fireproximityprompt(prompt) end) end
    local cd = coinObj:FindFirstChildOfClass("ClickDetector")
    if cd then pcall(function() fireclickdetector(cd) end) end
    pcall(function()
        firetouchinterest(hrp, coinObj, 0)
        firetouchinterest(hrp, coinObj, 1)
        task.wait(0.03)
        firetouchinterest(hrp, coinObj, 0)
        firetouchinterest(hrp, coinObj, 1)
        task.wait(0.03)
        firetouchinterest(hrp, coinObj, 0)
        firetouchinterest(hrp, coinObj, 1)
    end)
end

local farmRunning = false
local function startCoinFarm()
    if farmRunning then return end
    farmRunning = true
    task.spawn(function()
        while CoinFarm.Enabled do
            pcall(function()
                local c = LocalPlayer.Character
                if not c then return end
                local h = c:FindFirstChild("HumanoidRootPart")
                if not h then return end
                local hum = c:FindFirstChildOfClass("Humanoid")
                if not hum or hum.Health <= 0 then return end
                if getMyCoinCount() >= CoinFarm.MaxCoins then
                    CoinFarm.Enabled = false
                    Rayfield:Notify({ Title = "Auto Farm", Content = "Limite atingido! Desligando...", Duration = 5 })
                    return
                end
                local coins = findCoins()
                if #coins == 0 then task.wait(0.5) return end
                local myPos = h.Position
                local closest, closestDistSq = nil, math.huge
                for _, coin in ipairs(coins) do
                    local dx = coin.pos.X - myPos.X
                    local dy = coin.pos.Y - myPos.Y
                    local dz = coin.pos.Z - myPos.Z
                    local dSq = dx*dx + dy*dy + dz*dz
                    if dSq < closestDistSq then
                        closestDistSq = dSq
                        closest = coin
                    end
                end
                if closest then
                    local obj = closest.obj
                    coinAttempts[obj] = (coinAttempts[obj] or 0) + 1
                    local beforeCount = getMyCoinCount()
                    collectCoin(obj, closest.pos)
                    task.wait(0.15)
                    local afterCount = getMyCoinCount()
                    local stillThere = obj.Parent ~= nil
                    if afterCount > beforeCount or not stillThere then
                        coinBlacklist[obj] = tick()
                    elseif coinAttempts[obj] >= MAX_ATTEMPTS then
                        coinBlacklist[obj] = tick()
                    end
                end
            end)
            task.wait(CoinFarm.Speed)
        end
        farmRunning = false
    end)
end

-- ============================================================
--  RENDERSTEPPED
-- ============================================================
RunService.RenderStepped:Connect(function()
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

    if Config.Aimbot then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local target = getTargetByRole(Config.Aimbot_FOV)
            if target then
                local head = target:FindFirstChild("Head")
                if head then
                    local desired = CFrame.lookAt(Camera.CFrame.Position, head.Position)
                    local smooth = Config.Aimbot_Instant and 1 or Config.Aimbot_Smoothness
                    Camera.CFrame = Camera.CFrame:Lerp(desired, smooth)
                end
            end
        end
    end

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
--  ANTI-FLING COM COLLISION GROUP
-- ============================================================
pcall(function()
    PhysicsService:RegisterCollisionGroup("MM2_Self")
    PhysicsService:RegisterCollisionGroup("MM2_Others")
end)
pcall(function()
    PhysicsService:CollisionGroupSetCollidable("MM2_Self", "MM2_Others", false)
end)

local function applySelfGroupTo(part)
    if part:IsA("BasePart") and part.CollisionGroup ~= "MM2_Self" then
        pcall(function() part.CollisionGroup = "MM2_Self" end)
    end
end

local function applyOthersGroupTo(part)
    if part:IsA("BasePart") and part.CollisionGroup ~= "MM2_Others" then
        pcall(function() part.CollisionGroup = "MM2_Others" end)
    end
end

local function setSelfGroup()
    local char = LocalPlayer.Character
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do applySelfGroupTo(part) end
end

local function setOthersGroup()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            for _, part in ipairs(player.Character:GetDescendants()) do
                applyOthersGroupTo(part)
            end
        end
    end
end

local function restoreAllGroups()
    local char = LocalPlayer.Character
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                pcall(function() part.CollisionGroup = "Default" end)
            end
        end
    end
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            for _, part in ipairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    pcall(function() part.CollisionGroup = "Default" end)
                end
            end
        end
    end
end

local function enableAntiFling()
    if not Config.AntiFling then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5, 1, 1)
    end
    pcall(setSelfGroup)
    pcall(setOthersGroup)
end

workspace.DescendantAdded:Connect(function(obj)
    if not Config.AntiFling then return end
    if not obj:IsA("BasePart") then return end
    task.spawn(function()
        local parentChar = obj:FindFirstAncestorOfClass("Model")
        if not parentChar then return end
        if parentChar == LocalPlayer.Character then
            applySelfGroupTo(obj)
        else
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character == parentChar then
                    applyOthersGroupTo(obj)
                    break
                end
            end
        end
    end)
end)

Players.PlayerAdded:Connect(function()
    task.wait(1)
    if Config.AntiFling then
        pcall(setSelfGroup)
        pcall(setOthersGroup)
    end
end)

Players.PlayerRemoving:Connect(function()
    if Config.AntiFling then pcall(setOthersGroup) end
end)

RunService.Heartbeat:Connect(function()
    if not Config.AntiFling then return end
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum or hum.Health <= 0 then return end

        if not hrp.CustomPhysicalProperties or hrp.CustomPhysicalProperties.Density ~= 0.7 then
            hrp.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5, 1, 1)
        end

        local v = hrp.AssemblyLinearVelocity
        local horizontal = Vector3.new(v.X, 0, v.Z).Magnitude
        local angular = hrp.AssemblyAngularVelocity.Magnitude

        if horizontal > 160 or v.Y > 80 or angular > 40 then
            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero
            hrp.Velocity = Vector3.zero
            hrp.RotVelocity = Vector3.zero
            local state = hum:GetState()
            if state == Enum.HumanoidStateType.FallingDown
                or state == Enum.HumanoidStateType.Ragdoll
                or state == Enum.HumanoidStateType.Physics then
                hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
            hum.PlatformStand = false
        end
    end)
end)

-- ============================================================
--  INVISIBLE MODE (Seat Bug)
-- ============================================================
local SeatInvisible = {}
local invisMySeat = nil
local invisActive = false

local function invisCleanupSeat()
    local e = workspace:FindFirstChild("invischair")
    if e then pcall(function() e:Destroy() end) end
    invisMySeat = nil
end

local function invisActivate()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    invisCleanupSeat()
    local sp = hrp.CFrame
    local tp = Vector3.new(Config.InvisibleX, Config.InvisibleY, Config.InvisibleZ)
    char:MoveTo(tp)
    task.wait(0.15)
    local st = Instance.new("Seat")
    st.Name = "invischair"
    st.Anchored = false
    st.CanCollide = false
    st.Transparency = 1
    st.Position = tp
    st.Parent = workspace
    invisMySeat = st
    local wl = Instance.new("Weld")
    wl.Part0 = st
    wl.Part1 = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
    wl.Parent = st
    task.wait()
    st.CFrame = sp
    for _, d in ipairs(char:GetDescendants()) do
        if d:IsA("BasePart") or d:IsA("Decal") then d.Transparency = 0.5 end
    end
end

local function invisDeactivate()
    invisCleanupSeat()
    if LocalPlayer.Character then
        for _, d in ipairs(LocalPlayer.Character:GetDescendants()) do
            if d:IsA("BasePart") or d:IsA("Decal") then d.Transparency = 0 end
        end
    end
end

SeatInvisible.toggle = function()
    invisActive = not invisActive
    Config.Invisible = invisActive
    if invisActive then invisActivate() else invisDeactivate() end
end

task.spawn(function()
    while task.wait(0.5) do
        if invisActive and (not invisMySeat or not invisMySeat.Parent) then
            invisActive = false
            Config.Invisible = false
            invisDeactivate()
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(1)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = Config.Speed
        hum.UseJumpPower = true
        hum.JumpPower = Config.JumpPower
    end
    invisActive = false
    Config.Invisible = false
    invisCleanupSeat()
    if Config.AntiFling then
        task.wait(0.5)
        enableAntiFling()
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
        if obj:IsA("BasePart") and obj.Name:lower():find("obby") then return obj.Position end
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
local grabbing = false
local function grabGun()
    if grabbing then return false end
    local char = LocalPlayer.Character
    if not char then return false end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return false end

    for _, t in ipairs(char:GetChildren()) do
        if t:IsA("Tool") and t.Name:lower():find("gun") then return false end
    end

    local gun = findDroppedGunPart()
    if not gun then return false end

    local targetPos
    if gun:IsA("Tool") then
        local h = gun:FindFirstChild("Handle")
        targetPos = h and h.Position or nil
    elseif gun:IsA("BasePart") then
        targetPos = gun.Position
    elseif gun:IsA("Model") then
        targetPos = gun:GetPivot().Position
    end
    if not targetPos then return false end

    grabbing = true
    local originalCFrame = hrp.CFrame
    local originalVelocity = hrp.Velocity

    hrp.CFrame = CFrame.new(targetPos + Vector3.new(0, 1, 0))
    hrp.Velocity = Vector3.new(0, 0, 0)
    task.wait(0.25)
    hum:MoveTo(targetPos)

    local prompt = gun:FindFirstChildOfClass("ProximityPrompt")
    if not prompt then
        for _, d in ipairs(gun:GetDescendants()) do
            if d:IsA("ProximityPrompt") then prompt = d break end
        end
    end
    if prompt then pcall(function() fireproximityprompt(prompt) end) end

    local cd = gun:FindFirstChildOfClass("ClickDetector")
    if not cd then
        for _, d in ipairs(gun:GetDescendants()) do
            if d:IsA("ClickDetector") then cd = d break end
        end
    end
    if cd then pcall(function() fireclickdetector(cd) end) end

    local partsToTouch = {}
    if gun:IsA("BasePart") then
        table.insert(partsToTouch, gun)
    else
        for _, d in ipairs(gun:GetDescendants()) do
            if d:IsA("BasePart") then table.insert(partsToTouch, d) end
        end
    end

    for _, part in ipairs(partsToTouch) do
        pcall(function()
            firetouchinterest(hrp, part, 0)
            firetouchinterest(hrp, part, 1)
        end)
    end
    task.wait(0.5)

    local hasGun = false
    for _, t in ipairs(char:GetChildren()) do
        if t:IsA("Tool") and t.Name:lower():find("gun") then hasGun = true break end
    end
    if not hasGun then
        for _, part in ipairs(partsToTouch) do
            pcall(function()
                firetouchinterest(hrp, part, 0)
                firetouchinterest(hrp, part, 1)
            end)
        end
        task.wait(0.3)
    end

    if char.Parent and hrp.Parent then
        hrp.CFrame = originalCFrame
        hrp.Velocity = originalVelocity
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
                            hasG = true break
                        end
                    end
                    if not hasG and findDroppedGunPart() then pcall(grabGun) end
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

-- ============================================================
--  ABA VISUAL
-- ============================================================
local VisualTab = Window:CreateTab("Visual", 4483362458)
VisualTab:CreateToggle({
    Name = "ESP Players (atraves das paredes)",
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
    Name = "ESP Gun (arma dropada)",
    CurrentValue = false,
    Callback = function(v) Config.ESP_Gun = v end,
})

-- ============================================================
--  ABA VISUAL+
-- ============================================================
local VisualPlusTab = Window:CreateTab("Visual+", 4483362458)
VisualPlusTab:CreateToggle({
    Name = "Coin ESP (moedas no mapa)",
    CurrentValue = false,
    Callback = function(v) Config.CoinESP = v end,
})
VisualPlusTab:CreateToggle({
    Name = "Radar HUD (minimapa)",
    CurrentValue = false,
    Callback = function(v) Config.RadarHUD = v end,
})
VisualPlusTab:CreateToggle({
    Name = "Hitbox Expander (aumenta hitbox)",
    CurrentValue = false,
    Callback = function(v) Config.HitboxExpander = v end,
})
VisualPlusTab:CreateSlider({
    Name = "Tamanho da Hitbox",
    Range = {2, 20}, Increment = 1, Suffix = " studs",
    CurrentValue = 5,
    Callback = function(v) Config.HitboxSize = v end,
})
VisualPlusTab:CreateSlider({
    Name = "Hitbox Range",
    Range = {50, 500}, Increment = 10, Suffix = " studs",
    CurrentValue = 200,
    Callback = function(v) Config.HitboxMaxDist = v end,
})
VisualPlusTab:CreateToggle({
    Name = "Lock Camera no Murderer",
    CurrentValue = false,
    Callback = function(v) Config.LockCameraMurderer = v end,
})

-- ============================================================
--  ABA AIMBOT
-- ============================================================
local AimbotTab = Window:CreateTab("Aimbot", 4483362458)
AimbotTab:CreateToggle({ Name = "Aimbot por Role", CurrentValue = false, Callback = function(v) Config.Aimbot = v end })
AimbotTab:CreateToggle({ Name = "Aimbot Instantaneo (snap)", CurrentValue = false, Callback = function(v) Config.Aimbot_Instant = v end })
AimbotTab:CreateToggle({ Name = "Aimbot Team Check", CurrentValue = false, Callback = function(v) Config.Aimbot_TeamCheck = v end })
AimbotTab:CreateToggle({ Name = "Aimbot Wall Check", CurrentValue = false, Callback = function(v) Config.Aimbot_WallCheck = v end })
AimbotTab:CreateSlider({ Name = "Suavidade", Range = {0.05, 1.0}, Increment = 0.05, CurrentValue = 0.2, Callback = function(v) Config.Aimbot_Smoothness = v end })
AimbotTab:CreateSlider({ Name = "FOV do Aimbot", Range = {30, 500}, Increment = 5, Suffix = " px", CurrentValue = 150, Callback = function(v) Config.Aimbot_FOV = v end })
AimbotTab:CreateToggle({ Name = "Mostrar FOVs", CurrentValue = true, Callback = function(v) Config.Show_FOV = v end })
AimbotTab:CreateToggle({ Name = "Trigger Bot", CurrentValue = false, Callback = function(v) Config.TriggerBot = v end })
AimbotTab:CreateToggle({ Name = "Trigger Instantaneo", CurrentValue = false, Callback = function(v) Config.TriggerBot_Instant = v end })
AimbotTab:CreateToggle({ Name = "Trigger Team Check", CurrentValue = false, Callback = function(v) Config.TriggerBot_TeamCheck = v end })
AimbotTab:CreateToggle({ Name = "Trigger Wall Check", CurrentValue = false, Callback = function(v) Config.TriggerBot_WallCheck = v end })
AimbotTab:CreateSlider({ Name = "Trigger Bot FOV", Range = {10, 300}, Increment = 5, Suffix = " px", CurrentValue = 40, Callback = function(v) Config.TriggerBot_FOV = v end })
AimbotTab:CreateSlider({ Name = "Trigger Delay", Range = {0, 0.5}, Increment = 0.01, CurrentValue = 0.08, Callback = function(v) Config.TriggerBot_Delay = v end })

-- ============================================================
--  ABA MURDER (só pra quando você for o assassino)
-- ============================================================
local MurderTab = Window:CreateTab("Murder", 4483362458)
MurderTab:CreateButton({
    Name = "⚔️ KILL ALL (matar todos)",
    Callback = function() killAll() end,
})
MurderTab:CreateToggle({
    Name = "Auto Kill (faca automatica)",
    CurrentValue = false,
    Callback = function(v) Config.AutoKill = v end,
})
MurderTab:CreateToggle({
    Name = "Auto Equip Faca",
    CurrentValue = true,
    Callback = function(v) Config.AutoKill_AutoEquip = v end,
})
MurderTab:CreateToggle({
    Name = "Wall Check",
    CurrentValue = true,
    Callback = function(v) Config.AutoKill_WallCheck = v end,
})
MurderTab:CreateSlider({
    Name = "Alcance da Faca",
    Range = {5, 50}, Increment = 1, Suffix = " studs",
    CurrentValue = 15,
    Callback = function(v) Config.AutoKill_Range = v end,
})
MurderTab:CreateSlider({
    Name = "Delay entre acoes",
    Range = {0.1, 1.0}, Increment = 0.05, Suffix = " s",
    CurrentValue = 0.35,
    Callback = function(v) Config.AutoKill_Delay = v end,
})
MurderTab:CreateButton({
    Name = "🎯 Teleport to Innocent",
    Callback = function() teleportToRole("Innocent") end,
})
MurderTab:CreateButton({
    Name = "🎯 Teleport to Sheriff",
    Callback = function() teleportToRole("Sheriff") end,
})

-- ============================================================
--  ABA SHERIFF (só pra quando você for o xerife)
-- ============================================================
local SheriffTab = Window:CreateTab("Sheriff", 4483362458)
SheriffTab:CreateButton({
    Name = "🔫 Grab Gun (manual)",
    Callback = function()
        local ok = grabGun()
        if ok then
            Rayfield:Notify({Title = "Grab Gun", Content = "Arma pega!", Duration = 3})
        else
            Rayfield:Notify({Title = "Grab Gun", Content = "Nenhuma arma dropada.", Duration = 3})
        end
    end,
})
SheriffTab:CreateToggle({
    Name = "Auto Grab Gun",
    CurrentValue = false,
    Callback = function(v) Config.AutoGrabGun = v end,
})
SheriffTab:CreateToggle({
    Name = "Retorno instantaneo",
    CurrentValue = true,
    Callback = function(v) Config.AutoGrabGun_ReturnInstant = v end,
})
SheriffTab:CreateToggle({
    Name = "Auto Kill (tiro automatico)",
    CurrentValue = false,
    Callback = function(v) Config.AutoKill = v end,
})
SheriffTab:CreateToggle({
    Name = "Auto Equip Arma",
    CurrentValue = true,
    Callback = function(v) Config.AutoKill_AutoEquip = v end,
})
SheriffTab:CreateToggle({
    Name = "Wall Check",
    CurrentValue = true,
    Callback = function(v) Config.AutoKill_WallCheck = v end,
})
SheriffTab:CreateSlider({
    Name = "Alcance do Tiro",
    Range = {50, 1000}, Increment = 10, Suffix = " studs",
    CurrentValue = 500,
    Callback = function(v) Config.AutoKill_GunRange = v end,
})
SheriffTab:CreateSlider({
    Name = "Delay entre tiros",
    Range = {0.1, 1.0}, Increment = 0.05, Suffix = " s",
    CurrentValue = 0.35,
    Callback = function(v) Config.AutoKill_Delay = v end,
})
SheriffTab:CreateButton({
    Name = "🎯 Teleport to Murderer",
    Callback = function() teleportToRole("Murderer") end,
})

-- ============================================================
--  ABA AUTO FARM
-- ============================================================
local FarmTab = Window:CreateTab("Auto Farm", 4483362458)
FarmTab:CreateToggle({
    Name = "Auto Farm Coins",
    CurrentValue = false,
    Callback = function(v)
        CoinFarm.Enabled = v
        if v then
            startCoinFarm()
            Rayfield:Notify({ Title = "Auto Farm", Content = "Farmando ate " .. CoinFarm.MaxCoins .. " moedas...", Duration = 4 })
        end
    end,
})
FarmTab:CreateSlider({ Name = "Farm Speed", Range = {0.2, 1.0}, Increment = 0.05, Suffix = " s", CurrentValue = 0.4, Callback = function(v) CoinFarm.Speed = v end })
FarmTab:CreateSlider({ Name = "Limite de Moedas", Range = {10, 50}, Increment = 5, CurrentValue = 40, Callback = function(v) CoinFarm.MaxCoins = v end })
FarmTab:CreateButton({
    Name = "Ver minhas moedas atuais",
    Callback = function()
        Rayfield:Notify({ Title = "Moedas", Content = "Voce tem: " .. getMyCoinCount(), Duration = 4 })
    end,
})
FarmTab:CreateButton({
    Name = "Debug: quantas moedas achou?",
    Callback = function()
        local coins = findCoins()
        Rayfield:Notify({ Title = "Debug Farm", Content = "Achei " .. #coins .. " moedas", Duration = 5 })
    end,
})
FarmTab:CreateButton({
    Name = "Limpar blacklist de moedas",
    Callback = function()
        coinBlacklist = {}
        coinAttempts = {}
        Rayfield:Notify({Title = "Farm", Content = "Blacklist limpa!", Duration = 3})
    end,
})

-- ============================================================
--  ABA PLAYER
-- ============================================================
local MoveTab = Window:CreateTab("Player", 4483362458)
MoveTab:CreateSlider({
    Name = "Speed", Range = {16, 200}, Increment = 1, Suffix = " studs", CurrentValue = 16,
    Callback = function(v)
        Config.Speed = v
        local c = LocalPlayer.Character
        if c and c:FindFirstChildOfClass("Humanoid") then c.Humanoid.WalkSpeed = v end
    end,
})
MoveTab:CreateSlider({
    Name = "Jump Power", Range = {50, 300}, Increment = 5, CurrentValue = 50,
    Callback = function(v)
        Config.JumpPower = v
        local c = LocalPlayer.Character
        if c and c:FindFirstChildOfClass("Humanoid") then
            c.Humanoid.UseJumpPower = true
            c.Humanoid.JumpPower = v
        end
    end,
})
MoveTab:CreateToggle({ Name = "Infinite Jump  [J]", CurrentValue = false, Callback = function(v) Config.InfiniteJump = v end })
MoveTab:CreateToggle({ Name = "Anti Void  [V]", CurrentValue = false, Callback = function(v) Config.AntiVoid = v end })
MoveTab:CreateToggle({
    Name = "Fly  [F]", CurrentValue = false,
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
MoveTab:CreateSlider({ Name = "Fly Speed", Range = {10, 200}, Increment = 5, CurrentValue = 50, Callback = function(v) Config.FlySpeed = v end })
MoveTab:CreateToggle({
    Name = "Noclip  [N]", CurrentValue = false,
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
MoveTab:CreateToggle({
    Name = "Invisible Mode (Seat Bug)  [I]", CurrentValue = false,
    Callback = function(v)
        task.spawn(function() SeatInvisible.toggle() end)
    end,
})
MoveTab:CreateSlider({ Name = "Invisible Y (altura)", Range = {1000, 50000}, Increment = 100, CurrentValue = 5000, Callback = function(v) Config.InvisibleY = v end })

-- ============================================================
--  ABA PERFORMANCE
-- ============================================================
local PerfTab = Window:CreateTab("Performance", 4483362458)
PerfTab:CreateToggle({ Name = "Remover Neblina (No Fog)", CurrentValue = false, Callback = function(v) Config.Perf_NoFog = v end })
PerfTab:CreateToggle({ Name = "Remover Sombras (No Shadows)", CurrentValue = false, Callback = function(v) Config.Perf_NoShadow = v end })
PerfTab:CreateToggle({ Name = "Textura Lisa (SmoothPlastic)", CurrentValue = false, Callback = function(v) Config.Perf_SmoothTexture = v end })
PerfTab:CreateToggle({ Name = "Full Bright", CurrentValue = false, Callback = function(v) Config.Perf_FullBright = v end })
PerfTab:CreateButton({
    Name = "Aplicar tudo (recomendado)",
    Callback = function()
        Config.Perf_NoFog = true
        Config.Perf_NoShadow = true
        Config.Perf_FullBright = true
        Rayfield:Notify({ Title = "Performance", Content = "Neblina, sombras e FullBright ativados!", Duration = 4 })
    end,
})
PerfTab:CreateButton({
    Name = "Resetar Performance",
    Callback = function()
        Config.Perf_NoFog = false
        Config.Perf_NoShadow = false
        Config.Perf_SmoothTexture = false
        Config.Perf_FullBright = false
        restoreLighting("bright")
        restoreLighting("fog")
        restoreLighting("shadow")
        restoreMaterials()
        restoreShadows()
        perfState.bright = false
        perfState.nofog = false
        perfState.noshadow = false
        perfState.smooth = false
        Rayfield:Notify({ Title = "Performance", Content = "Tudo restaurado ao original.", Duration = 4 })
    end,
})

-- ============================================================
--  ABA EXTRAS
-- ============================================================
local ExtrasTab = Window:CreateTab("Extras", 4483362458)
ExtrasTab:CreateToggle({
    Name = "Anti-Kick (bloqueia SetCore)",
    CurrentValue = false,
    Callback = function(v) Config.AntiKick = v end,
})
ExtrasTab:CreateToggle({
    Name = "Anti-Ragdoll (levanta automatico)",
    CurrentValue = false,
    Callback = function(v) Config.AntiRagdoll = v end,
})
ExtrasTab:CreateToggle({
    Name = "Kill Notifier (avisar mortes)",
    CurrentValue = false,
    Callback = function(v) Config.KillNotifier = v end,
})
ExtrasTab:CreateToggle({
    Name = "Auto Dodge (desvia do Murderer)",
    CurrentValue = false,
    Callback = function(v) Config.AutoDodge = v end,
})
ExtrasTab:CreateToggle({
    Name = "Anti-AFK (evita kick por inatividade)",
    CurrentValue = false,
    Callback = function(v) Config.AntiAFK = v end,
})
ExtrasTab:CreateToggle({
    Name = "Anti-Explosion (bloqueia explosoes)",
    CurrentValue = false,
    Callback = function(v) Config.AntiExplosion = v end,
})
ExtrasTab:CreateToggle({
    Name = "Murderer Alert (avisa quando perto)",
    CurrentValue = false,
    Callback = function(v) Config.MurdererAlert = v end,
})
ExtrasTab:CreateSlider({
    Name = "Alerta range",
    Range = {30, 200}, Increment = 10, Suffix = " studs",
    CurrentValue = 80,
    Callback = function(v) Config.MurdererAlertRange = v end,
})
ExtrasTab:CreateButton({
    Name = "📋 Ver lista de jogadores + roles",
    Callback = function() showPlayerList() end,
})
ExtrasTab:CreateButton({
    Name = "🌐 Server Hop (trocar de servidor)",
    Callback = function() serverHop() end,
})

-- ============================================================
--  ABA TELEPORTE
-- ============================================================
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

-- ============================================================
--  ABA PROTECAO
-- ============================================================
local ProtTab = Window:CreateTab("Protecao", 4483362458)
ProtTab:CreateToggle({
    Name = "Anti-Fling (sem colisao com players)",
    CurrentValue = false,
    Callback = function(v)
        Config.AntiFling = v
        if v then
            enableAntiFling()
        else
            pcall(restoreAllGroups)
            Rayfield:Notify({ Title = "Anti-Fling", Content = "Desligado. Colisao restaurada.", Duration = 3 })
        end
    end,
})

-- ============================================================
--  KEYBINDS
-- ============================================================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
    local key = input.KeyCode

    if key == Enum.KeyCode.F then
        Config.Fly = not Config.Fly
        if not Config.Fly then
            local c = LocalPlayer.Character
            if c then
                local hrp = c:FindFirstChild("HumanoidRootPart")
                if hrp then hrp.Velocity = Vector3.new(0, 0, 0) end
            end
        end
        Rayfield:Notify({Title = "Fly", Content = Config.Fly and "Ligado" or "Desligado", Duration = 2})
    end

    if key == Enum.KeyCode.N then
        Config.Noclip = not Config.Noclip
        if not Config.Noclip then
            local c = LocalPlayer.Character
            if c then
                for _, p in ipairs(c:GetDescendants()) do
                    if p:IsA("BasePart") then p.CanCollide = true end
                end
            end
        end
        Rayfield:Notify({Title = "Noclip", Content = Config.Noclip and "Ligado" or "Desligado", Duration = 2})
    end

    if key == Enum.KeyCode.G then
        task.spawn(function()
            local ok = grabGun()
            Rayfield:Notify({ Title = "Grab Gun", Content = ok and "Arma pega!" or "Nenhuma arma dropada.", Duration = 3 })
        end)
    end

    if key == Enum.KeyCode.J then
        Config.InfiniteJump = not Config.InfiniteJump
        Rayfield:Notify({Title = "Infinite Jump", Content = Config.InfiniteJump and "Ligado" or "Desligado", Duration = 2})
    end

    if key == Enum.KeyCode.V then
        Config.AntiVoid = not Config.AntiVoid
        Rayfield:Notify({Title = "Anti Void", Content = Config.AntiVoid and "Ligado" or "Desligado", Duration = 2})
    end

    if key == Enum.KeyCode.I then
        task.spawn(function()
            SeatInvisible.toggle()
            Rayfield:Notify({ Title = "Invisible", Content = Config.Invisible and "Ligado" or "Desligado", Duration = 2 })
        end)
    end

    if key == Enum.KeyCode.H then
        Config.HitboxExpander = not Config.HitboxExpander
        Rayfield:Notify({Title = "Hitbox", Content = Config.HitboxExpander and "Ligado" or "Desligado", Duration = 2})
    end

    if key == Enum.KeyCode.C then
        Config.CoinESP = not Config.CoinESP
        Rayfield:Notify({Title = "Coin ESP", Content = Config.CoinESP and "Ligado" or "Desligado", Duration = 2})
    end
end)

Rayfield:Notify({
    Title = "MM2 Check Hub v3",
    Content = "Teclas: F=Fly N=Noclip G=GrabGun J=Jump V=AntiVoid I=Invisible H=Hitbox C=CoinESP",
    Duration = 7,
})

end)

if not okLoad then
    warn("[MM2 Hub] ERRO:", tostring(errLoad))
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Erro no Script",
            Text = tostring(errLoad),
            Duration = 15,
        })
    end)
end
