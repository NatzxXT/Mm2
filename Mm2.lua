-- MM2 Hub v3
-- Funciona apenas no Murder Mystery 2

local PLACE_IDS = {142823291, 1990777535, 321010323}

local function isMM2()
    for _, id in ipairs(PLACE_IDS) do
        if game.PlaceId == id then return true end
    end
    local n = (game.Name or ""):lower()
    if n == "murder mystery 2" or n == "mm2" then return true end
    return false
end

if not isMM2() then
    local gui = Instance.new("ScreenGui")
    gui.Name = "MM2_Block"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 9999
    pcall(function() gui.Parent = game:GetService("CoreGui") end)

    local frame = Instance.new("Frame")
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame.Size = UDim2.fromOffset(420, 130)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    frame.BackgroundTransparency = 0.05
    frame.BorderSizePixel = 0
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

    local st = Instance.new("UIStroke")
    st.Color = Color3.fromRGB(255, 70, 70)
    st.Thickness = 2
    st.Transparency = 0.2
    st.Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -20, 0, 40)
    title.Position = UDim2.fromOffset(10, 10)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.TextColor3 = Color3.fromRGB(255, 90, 90)
    title.Text = "Jogo Incompativel"
    title.Parent = frame

    local msg = Instance.new("TextLabel")
    msg.Size = UDim2.new(1, -20, 0, 70)
    msg.Position = UDim2.fromOffset(10, 45)
    msg.BackgroundTransparency = 1
    msg.Font = Enum.Font.Gotham
    msg.TextSize = 14
    msg.TextColor3 = Color3.fromRGB(230, 230, 240)
    msg.TextWrapped = true
    msg.Text = "Este script funciona apenas no Murder Mystery 2.\nJogo atual: " .. tostring(game.Name) .. "\nPlaceId: " .. tostring(game.PlaceId)
    msg.Parent = frame

    task.delay(4, function()
        pcall(function() gui:Destroy() end)
    end)
    return
end

local okLoad, errLoad = pcall(function()

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local PhysicsService = game:GetService("PhysicsService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local Config = {
    ESP_Players = false,
    ESP_Name = false,
    ESP_Gun = false,
    ESP_Coin = false,
    ESP_CoinMaxDist = 150,
    ESP_GunMaxDist = 500,
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
    TriggerBot_Delay = 0.25,
    TriggerBot_FOV = 40,
    TriggerBot_WallCheck = false,
    TriggerBot_Instant = false,
    AutoKill_Murder = false,
    AutoKill_Sheriff = false,
    AutoKill_Range = 25,
    AutoKill_GunRange = 500,
    AutoKill_Delay = 0.5,
    AutoKill_WallCheck = true,
    Speed = 16,
    JumpPower = 50,
    InfiniteJump = false,
    Fly = false,
    FlySpeed = 50,
    Noclip = false,
    AntiVoid = false,
    AntiFling = false,
    Invisible = false,
    InvisibleY = 5000,
    AutoGrabGun = false,
    AutoGrabGun_Delay = 1.0,
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
    RadarHUD = false,
    AntiAFK = false,
    MurdererAlert = false,
    MurdererAlertRange = 80,
    LockCameraMurderer = false,
}

-- Role
local roleCache = {}
local ROLE_TTL = 0.5
local MURDERER_KW = {"knife", "dagger", "blade"}
local SHERIFF_KW = {"gun", "revolver", "pistol"}

local function getRoleRaw(player)
    local char = player.Character
    if not char then return "Innocent" end
    local function scan(container)
        if not container then return nil end
        for _, obj in ipairs(container:GetChildren()) do
            if obj:IsA("Tool") then
                local n = obj.Name:lower()
                for _, k in ipairs(MURDERER_KW) do
                    if n:find(k) then return "Murderer" end
                end
                for _, k in ipairs(SHERIFF_KW) do
                    if n:find(k) then return "Sheriff" end
                end
            end
        end
        return nil
    end
    local r = scan(char)
    if r then return r end
    r = scan(player:FindFirstChildOfClass("Backpack"))
    if r then return r end
    return "Innocent"
end

local function getRole(player)
    local c = roleCache[player]
    local now = tick()
    if c and now - c.time < ROLE_TTL then return c.role end
    local r = getRoleRaw(player)
    roleCache[player] = {role = r, time = now}
    return r
end

local function roleColor(role)
    if role == "Murderer" then return Config.ESP_Color_Murderer end
    if role == "Sheriff" then return Config.ESP_Color_Sheriff end
    return Config.ESP_Color_Innocent
end

Players.PlayerRemoving:Connect(function(p) roleCache[p] = nil end)

-- FOV circles
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
Instance.new("UICorner", fovCircle).CornerRadius = UDim.new(1, 0)

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
Instance.new("UICorner", trigCircle).CornerRadius = UDim.new(1, 0)

local function screenCenter()
    return Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
end

-- Helpers
local function findTool(char, keyword, player)
    if not char then return nil end
    for _, t in ipairs(char:GetChildren()) do
        if t:IsA("Tool") and t.Name:lower():find(keyword) then return t end
    end
    if player then
        local bp = player:FindFirstChildOfClass("Backpack")
        if bp then
            for _, t in ipairs(bp:GetChildren()) do
                if t:IsA("Tool") and t.Name:lower():find(keyword) then return t end
            end
        end
    end
    return nil
end

local function inAnyCharacter(obj)
    for _, p in ipairs(Players:GetPlayers()) do
        local char = p.Character
        if char and obj:IsDescendantOf(char) then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then return true end
        end
    end
    return false
end

local function hasLOS(from, to, targetChar)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.IgnoreWater = true
    local filter = {}
    if LocalPlayer.Character then table.insert(filter, LocalPlayer.Character) end
    if targetChar then table.insert(filter, targetChar) end
    params.FilterDescendantsInstances = filter
    local r = workspace:Raycast(from, to - from, params)
    return r == nil
end

local function myPos()
    local c = LocalPlayer.Character
    local hrp = c and c:FindFirstChild("HumanoidRootPart")
    return hrp and hrp.Position
end

-- Attack
local attacking = false

local function attackWith(tool, targetChar)
    if attacking or not tool then return end
    attacking = true
    task.spawn(function()
        local char = LocalPlayer.Character
        if not char then attacking = false return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then attacking = false return end

        if targetChar then
            local tHrp = targetChar:FindFirstChild("HumanoidRootPart")
            local myHrp = char:FindFirstChild("HumanoidRootPart")
            if tHrp and myHrp then
                myHrp.CFrame = CFrame.new(tHrp.Position)
                myHrp.Velocity = Vector3.zero
            end
        end

        if tool.Parent ~= char then tool.Parent = char end
        if hum:GetEquippedTool() ~= tool then
            pcall(function() hum:EquipTool(tool) end)
        end

        task.wait(0.2)
        pcall(function() tool:Activate() end)
        task.wait(0.05)

        local bp = LocalPlayer:FindFirstChildOfClass("Backpack")
        if bp then pcall(function() tool.Parent = bp end) end

        attacking = false
    end)
end

-- Finders
local function findGunOnGround()
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:IsA("Tool") then
            local n = obj.Name:lower()
            if n:find("gun") or n:find("revolver") or n:find("pistol") or n:find("weapon") then
                if not inAnyCharacter(obj) then return obj end
            end
        end
    end
    for _, folderName in ipairs({"Guns","Items","Tools","Weapons","DroppedItems","Gun","Drops"}) do
        local folder = workspace:FindFirstChild(folderName)
        if folder then
            for _, obj in ipairs(folder:GetChildren()) do
                if obj:IsA("Tool") then
                    if not inAnyCharacter(obj) then
                        local n = obj.Name:lower()
                        if n:find("gun") or n:find("revolver") or n:find("pistol") or n:find("weapon") then
                            return obj
                        end
                    end
                end
            end
        end
    end
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Tool") then
            local n = obj.Name:lower()
            if n:find("gun") or n:find("revolver") or n:find("pistol") then
                if not inAnyCharacter(obj) then return obj end
            end
        end
    end
    return nil
end

local function findCoins()
    local out = {}
    local seen = {}
    local my = myPos()
    if not my then return out end
    local maxDsq = Config.ESP_CoinMaxDist * Config.ESP_CoinMaxDist

    local function add(obj)
        if seen[obj] then return end
        if inAnyCharacter(obj) then return end
        local d = obj.Position - my
        if d.X*d.X + d.Y*d.Y + d.Z*d.Z > maxDsq then return end
        seen[obj] = true
        out[#out+1] = {obj = obj, pos = obj.Position}
    end

    local folder = workspace:FindFirstChild("Coins")
    if folder then
        for _, obj in ipairs(folder:GetChildren()) do
            if obj:IsA("BasePart") or obj:IsA("MeshPart") then add(obj) end
        end
        return out
    end

    for _, name in ipairs({"Coin", "CoinFolder", "Money", "Rewards"}) do
        local f = workspace:FindFirstChild(name)
        if f then
            for _, obj in ipairs(f:GetChildren()) do
                if obj:IsA("BasePart") or obj:IsA("MeshPart") then add(obj) end
            end
        end
    end
    return out
end

-- ESP Players
local espCache = {}
local nameCache = {}
local ESP_TICK = 0.35
local ESP_MAX_DIST = 400

local function dropHighlight(p)
    if espCache[p] then espCache[p]:Destroy() espCache[p] = nil end
end
local function dropNameTag(p)
    if nameCache[p] then nameCache[p]:Destroy() nameCache[p] = nil end
end

local function makeHighlight(player)
    local char = player.Character
    if not char then return end
    local hl = Instance.new("Highlight")
    hl.Name = "MM2_ESP"
    hl.Adornee = char
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.FillTransparency = 0.5
    hl.OutlineTransparency = 0
    local c = roleColor(getRole(player))
    hl.FillColor = c
    hl.OutlineColor = c
    hl.Parent = char
    espCache[player] = hl
end

local function makeNameTag(player)
    local char = player.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end
    if nameCache[player] then nameCache[player]:Destroy() end
    local bg = Instance.new("BillboardGui")
    bg.Name = "MM2_Name"
    bg.Size = UDim2.new(0, 160, 0, 22)
    bg.StudsOffset = Vector3.new(0, 3, 0)
    bg.Adornee = head
    bg.AlwaysOnTop = true
    bg.MaxDistance = ESP_MAX_DIST
    bg.Parent = head
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = player.Name
    lbl.TextStrokeTransparency = 0
    lbl.TextScaled = true
    lbl.Font = Enum.Font.GothamBold
    lbl.TextColor3 = roleColor(getRole(player))
    lbl.Parent = bg
    nameCache[player] = bg
end

local function validHL(p)
    local hl = espCache[p]
    if not hl or not hl.Parent then return false end
    return hl.Adornee == p.Character
end
local function validName(p)
    local bg = nameCache[p]
    if not bg or not bg.Parent then return false end
    local head = p.Character and p.Character:FindFirstChild("Head")
    return bg.Adornee == head
end

local function updatePlayers()
    local my = myPos()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local char = p.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local tooFar = false
            if my and hrp then
                local d = hrp.Position - my
                if d.X*d.X + d.Y*d.Y + d.Z*d.Z > ESP_MAX_DIST*ESP_MAX_DIST then
                    tooFar = true
                end
            end

            if Config.ESP_Players and char and not tooFar then
                if not validHL(p) then
                    dropHighlight(p)
                    makeHighlight(p)
                end
                if espCache[p] then
                    local c = roleColor(getRole(p))
                    if espCache[p].FillColor ~= c then
                        espCache[p].FillColor = c
                        espCache[p].OutlineColor = c
                    end
                end
            else
                dropHighlight(p)
            end

            if Config.ESP_Name and char and not tooFar then
                if not validName(p) then
                    dropNameTag(p)
                    makeNameTag(p)
                end
                if nameCache[p] then
                    local c = roleColor(getRole(p))
                    local lbl = nameCache[p]:FindFirstChildOfClass("TextLabel")
                    if lbl and lbl.TextColor3 ~= c then lbl.TextColor3 = c end
                end
            else
                dropNameTag(p)
            end
        end
    end
end

-- ESP Gun
local gunESP = nil
local gunESPObj = nil

local function updateGunESP()
    if not Config.ESP_Gun then
        if gunESP then gunESP:Destroy() gunESP = nil gunESPObj = nil end
        return
    end
    local gun = findGunOnGround()
    if not gun then
        if gunESP then gunESP:Destroy() gunESP = nil gunESPObj = nil end
        return
    end

    local handle = gun
    if gun:IsA("Tool") then
        handle = gun:FindFirstChild("Handle") or gun:FindFirstChildWhichIsA("BasePart")
    end
    if not handle then
        if gunESP then gunESP:Destroy() gunESP = nil gunESPObj = nil end
        return
    end

    local my = myPos()
    if my then
        local d = handle.Position - my
        if d.X*d.X + d.Y*d.Y + d.Z*d.Z > Config.ESP_GunMaxDist * Config.ESP_GunMaxDist then
            if gunESP then gunESP:Destroy() gunESP = nil gunESPObj = nil end
            return
        end
    end

    if gunESPObj == gun and gunESP and gunESP.Parent then return end
    if gunESP then gunESP:Destroy() gunESP = nil end
    gunESPObj = gun

    gunESP = Instance.new("Highlight")
    gunESP.Adornee = handle
    gunESP.FillColor = Color3.fromRGB(255, 255, 0)
    gunESP.OutlineColor = Color3.fromRGB(255, 255, 0)
    gunESP.FillTransparency = 0.3
    gunESP.OutlineTransparency = 0
    gunESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    gunESP.Parent = handle
end

-- ESP Coin
local coinESPCache = {}

local function updateCoinESP()
    if not Config.ESP_Coin then
        for _, hl in pairs(coinESPCache) do pcall(function() hl:Destroy() end) end
        coinESPCache = {}
        return
    end
    local coins = findCoins()
    local active = {}
    for _, c in ipairs(coins) do
        active[c.obj] = true
        if not coinESPCache[c.obj] or not coinESPCache[c.obj].Parent then
            if coinESPCache[c.obj] then pcall(function() coinESPCache[c.obj]:Destroy() end) end
            local hl = Instance.new("Highlight")
            hl.Adornee = c.obj
            hl.FillColor = Color3.fromRGB(255, 215, 0)
            hl.OutlineColor = Color3.fromRGB(255, 215, 0)
            hl.FillTransparency = 0.35
            hl.OutlineTransparency = 0
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.Parent = c.obj
            coinESPCache[c.obj] = hl
        end
    end
    for obj, hl in pairs(coinESPCache) do
        if not active[obj] or not obj.Parent then
            pcall(function() hl:Destroy() end)
            coinESPCache[obj] = nil
        end
    end
end

-- Aimbot / Trigger
local function validTarget(p, teamCheck)
    if p == LocalPlayer then return false end
    local my = getRole(LocalPlayer)
    local t = getRole(p)
    if teamCheck and my == t then return false end
    if my == "Murderer" then return t ~= "Murderer" end
    return t == "Murderer"
end

local function aimTarget(fov)
    local best, bestD = nil, math.huge
    local fovSq = fov * fov
    local camPos = Camera.CFrame.Position
    local myChar = LocalPlayer.Character
    local center = screenCenter()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local char = p.Character
            if char then
                local head = char:FindFirstChild("Head")
                if head and validTarget(p, Config.Aimbot_TeamCheck) then
                    local sp, on = Camera:WorldToScreenPoint(head.Position)
                    if on then
                        local dx = sp.X - center.X
                        local dy = sp.Y - center.Y
                        local dSq = dx*dx + dy*dy
                        if dSq <= fovSq and dSq < bestD then
                            local wallOK = true
                            if Config.Aimbot_WallCheck then
                                wallOK = hasLOS(camPos, head.Position, myChar)
                            end
                            if wallOK then
                                bestD = dSq
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
local function triggerTick()
    if not Config.TriggerBot then return end
    if attacking then return end
    local now = tick()
    if not Config.TriggerBot_Instant and now - lastFire < Config.TriggerBot_Delay then return end

    local char = LocalPlayer.Character
    if not char then return end
    local myRole = getRole(LocalPlayer)
    local tool, isMelee
    if myRole == "Murderer" then
        tool = findTool(char, "knife", LocalPlayer)
        isMelee = true
    else
        tool = findTool(char, "gun", LocalPlayer)
        isMelee = false
    end
    if not tool then return end

    local myHRP = char:FindFirstChild("HumanoidRootPart")
    if not myHRP then return end
    local myP = myHRP.Position
    local center = screenCenter()
    local camPos = Camera.CFrame.Position

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local tChar = p.Character
            if tChar then
                local head = tChar:FindFirstChild("Head")
                local tHRP = tChar:FindFirstChild("HumanoidRootPart")
                if head and tHRP then
                    if validTarget(p, Config.TriggerBot_TeamCheck) then
                        local dist = (tHRP.Position - myP).Magnitude
                        local rangeOK = true
                        if isMelee then rangeOK = dist <= 18 end
                        if rangeOK then
                            local sp, on = Camera:WorldToScreenPoint(head.Position)
                            if on then
                                local dx = sp.X - center.X
                                local dy = sp.Y - center.Y
                                local dSq = dx*dx + dy*dy
                                if dSq <= Config.TriggerBot_FOV * Config.TriggerBot_FOV then
                                    local canFire = true
                                    if Config.TriggerBot_WallCheck then
                                        canFire = hasLOS(camPos, head.Position, char)
                                    end
                                    if canFire then
                                        if isMelee then
                                            attackWith(tool, tChar)
                                        else
                                            myHRP.CFrame = CFrame.lookAt(myHRP.Position, head.Position)
                                            task.wait(0.15)
                                            pcall(function() tool:Activate() end)
                                        end
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

-- Auto Kill
local function nearestMurderer()
    local myChar = LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("Head") then return nil end
    local myHead = myChar.Head.Position
    local best, bestD = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local char = p.Character
            if char and char:FindFirstChild("Head") and getRole(p) == "Murderer" then
                local tp = char.Head.Position
                local dx, dy, dz = tp.X - myHead.X, tp.Y - myHead.Y, tp.Z - myHead.Z
                local dSq = dx*dx + dy*dy + dz*dz
                if dSq < bestD then
                    if not Config.AutoKill_WallCheck or hasLOS(myHead, tp, char) then
                        bestD = dSq
                        best = char
                    end
                end
            end
        end
    end
    return best
end

local function nearestEnemy(range)
    local myChar = LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("Head") then return nil end
    local myHead = myChar.Head.Position
    local best, bestD = nil, range * range
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local char = p.Character
            if char and char:FindFirstChild("Head") and getRole(p) ~= "Murderer" then
                local tp = char.Head.Position
                local dx, dy, dz = tp.X - myHead.X, tp.Y - myHead.Y, tp.Z - myHead.Z
                local dSq = dx*dx + dy*dy + dz*dz
                if dSq <= bestD then
                    if not Config.AutoKill_WallCheck or hasLOS(myHead, tp, char) then
                        bestD = dSq
                        best = char
                    end
                end
            end
        end
    end
    return best
end

local lastAK = 0
local function autoKillTick()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return end
    local myRole = getRole(LocalPlayer)

    if myRole == "Murderer" then
        if not Config.AutoKill_Murder then return end
        local now = tick()
        if now - lastAK < Config.AutoKill_Delay then return end
        local knife = findTool(char, "knife", LocalPlayer)
        if not knife then return end
        local enemy = nearestEnemy(Config.AutoKill_Range)
        if enemy and enemy:FindFirstChild("HumanoidRootPart") then
            attackWith(knife, enemy)
            lastAK = now
        end
        return
    end

    if myRole == "Sheriff" or findTool(char, "gun", LocalPlayer) then
        if not Config.AutoKill_Sheriff then return end
        local now = tick()
        if now - lastAK < Config.AutoKill_Delay then return end
        local gun = findTool(char, "gun", LocalPlayer)
        if not gun then return end
        local m = nearestMurderer()
        if m and m:FindFirstChild("HumanoidRootPart") then
            local myHRP = char:FindFirstChild("HumanoidRootPart")
            local mHRP = m.HumanoidRootPart
            if myHRP then
                local d = (mHRP.Position - myHRP.Position).Magnitude
                if d <= Config.AutoKill_GunRange then
                    myHRP.CFrame = CFrame.lookAt(myHRP.Position, mHRP.Position)
                    attackWith(gun, nil)
                    lastAK = now
                end
            end
        end
    end
end

-- Loops gerais
UserInputService.JumpRequest:Connect(function()
    if Config.InfiniteJump then
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end
    end
end)

task.spawn(function()
    while task.wait(0.3) do
        if Config.AntiVoid then
            pcall(function()
                local c = LocalPlayer.Character
                if c then
                    local hrp = c:FindFirstChild("HumanoidRootPart")
                    if hrp and hrp.Position.Y < -50 then
                        hrp.CFrame = CFrame.new(hrp.Position.X, 50, hrp.Position.Z)
                        hrp.Velocity = Vector3.zero
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
                local c = LocalPlayer.Character
                if c then
                    for _, p in ipairs(c:GetDescendants()) do
                        if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.05) do
        if Config.TriggerBot then pcall(triggerTick) end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if Config.AutoKill_Murder or Config.AutoKill_Sheriff then pcall(autoKillTick) end
    end
end)

task.spawn(function()
    while task.wait(ESP_TICK) do pcall(updatePlayers) end
end)

task.spawn(function()
    while task.wait(0.5) do pcall(updateGunESP) end
end)

task.spawn(function()
    while task.wait(1) do pcall(updateCoinESP) end
end)

-- Extras
pcall(function()
    local SG = game:GetService("StarterGui")
    if hookfunction then
        local old = SG.SetCore
        hookfunction(old, function(self, ...)
            local args = {...}
            if args[1] == "SendNotification" then return old(self, ...) end
            if Config.AntiKick then return end
            return old(self, ...)
        end)
    end
end)

task.spawn(function()
    while task.wait(0.15) do
        if Config.AntiRagdoll then
            pcall(function()
                local c = LocalPlayer.Character
                if c then
                    local hum = c:FindFirstChildOfClass("Humanoid")
                    if hum then
                        local s = hum:GetState()
                        if s == Enum.HumanoidStateType.FallingDown
                            or s == Enum.HumanoidStateType.Ragdoll
                            or s == Enum.HumanoidStateType.Physics then
                            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
                            hum.PlatformStand = false
                            local hrp = c:FindFirstChild("HumanoidRootPart")
                            if hrp then hrp.AssemblyAngularVelocity = Vector3.zero end
                        end
                    end
                end
            end)
        end
    end
end)

local killHP = {}
task.spawn(function()
    while task.wait(0.5) do
        if Config.KillNotifier then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer then
                    local c = p.Character
                    if c then
                        local hum = c:FindFirstChildOfClass("Humanoid")
                        if hum then
                            local prev = killHP[p]
                            if prev and prev > 0 and hum.Health <= 0 then
                                Rayfield:Notify({
                                    Title = "Kill Notifier",
                                    Content = p.Name .. " (" .. getRole(p) .. ") morreu",
                                    Duration = 4,
                                })
                            end
                            killHP[p] = hum.Health
                        end
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.25) do
        if Config.AutoDodge then
            pcall(function()
                local c = LocalPlayer.Character
                if not c then return end
                local hrp = c:FindFirstChild("HumanoidRootPart")
                local hum = c:FindFirstChildOfClass("Humanoid")
                if not hrp or not hum or hum.Health <= 0 then return end
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and getRole(p) == "Murderer" then
                        local tc = p.Character
                        if tc then
                            local tHrp = tc:FindFirstChild("HumanoidRootPart")
                            if tHrp then
                                local diff = hrp.Position - tHrp.Position
                                local d = diff.Magnitude
                                if d < 18 and d > 1 then
                                    hrp.Velocity = diff.Unit * 90 + Vector3.new(0, 35, 0)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

local hbSaved = setmetatable({}, {__mode = "k"})
task.spawn(function()
    while task.wait(0.15) do
        if Config.HitboxExpander then
            pcall(function()
                local my = myPos()
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer then
                        local c = p.Character
                        if c then
                            local hrp = c:FindFirstChild("HumanoidRootPart")
                            local d = (my and hrp) and (hrp.Position - my).Magnitude or 0
                            if d <= Config.HitboxMaxDist then
                                for _, part in ipairs(c:GetDescendants()) do
                                    if part:IsA("BasePart") and (part.Name == "Head" or part.Name:find("Torso")) then
                                        if hbSaved[part] == nil then hbSaved[part] = part.Size end
                                        part.Size = Vector3.new(Config.HitboxSize, Config.HitboxSize, Config.HitboxSize)
                                        part.CanCollide = false
                                        part.Transparency = 0.5
                                    end
                                end
                            else
                                for _, part in ipairs(c:GetDescendants()) do
                                    if part:IsA("BasePart") and hbSaved[part] then
                                        part.Size = hbSaved[part]
                                        part.CanCollide = true
                                        part.Transparency = 0
                                        hbSaved[part] = nil
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        else
            for part, size in pairs(hbSaved) do
                if part and part.Parent then
                    part.Size = size
                    part.CanCollide = true
                    part.Transparency = 0
                end
            end
            hbSaved = setmetatable({}, {__mode = "k"})
        end
    end
end)

-- Radar
local radarGui = Instance.new("ScreenGui")
radarGui.Name = "MM2_Radar"
radarGui.ResetOnSpawn = false
radarGui.IgnoreGuiInset = true
pcall(function() radarGui.Parent = game.CoreGui end)

local radarFrame = Instance.new("Frame")
radarFrame.Size = UDim2.fromOffset(140, 140)
radarFrame.Position = UDim2.new(0.5, -70, 0, 10)
radarFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
radarFrame.BackgroundTransparency = 0.6
radarFrame.BorderSizePixel = 0
radarFrame.Visible = false
radarFrame.Parent = radarGui
Instance.new("UICorner", radarFrame).CornerRadius = UDim.new(1, 0)

local radarMe = Instance.new("Frame")
radarMe.Size = UDim2.fromOffset(6, 6)
radarMe.Position = UDim2.new(0.5, -3, 0.5, -3)
radarMe.BackgroundColor3 = Color3.new(1, 1, 1)
radarMe.BorderSizePixel = 0
radarMe.Parent = radarFrame
Instance.new("UICorner", radarMe).CornerRadius = UDim.new(1, 0)

local radarDots = {}
local RADAR_RANGE = 200

task.spawn(function()
    while task.wait(0.15) do
        radarFrame.Visible = Config.RadarHUD
        if Config.RadarHUD then
            local c = LocalPlayer.Character
            local hrp = c and c:FindFirstChild("HumanoidRootPart")
            if hrp then
                local my = hrp.Position
                local look = Camera.CFrame.LookVector
                local angle = math.atan2(look.X, look.Z)
                local used = {}
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer then
                        local tc = p.Character
                        local tHrp = tc and tc:FindFirstChild("HumanoidRootPart")
                        if tHrp then
                            local rel = tHrp.Position - my
                            if rel.Magnitude <= RADAR_RANGE then
                                local rx = rel.X * math.cos(-angle) - rel.Z * math.sin(-angle)
                                local rz = rel.X * math.sin(-angle) + rel.Z * math.cos(-angle)
                                local px = (rx / RADAR_RANGE) * 60 + 70
                                local py = -(rz / RADAR_RANGE) * 60 + 70
                                local dot = radarDots[p]
                                if not dot then
                                    dot = Instance.new("Frame")
                                    dot.Size = UDim2.fromOffset(8, 8)
                                    dot.BorderSizePixel = 0
                                    dot.Parent = radarFrame
                                    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
                                    radarDots[p] = dot
                                end
                                dot.Position = UDim2.fromOffset(px - 4, py - 4)
                                dot.BackgroundColor3 = roleColor(getRole(p))
                                used[p] = true
                            end
                        end
                    end
                end
                for p, dot in pairs(radarDots) do
                    if not used[p] then
                        dot:Destroy()
                        radarDots[p] = nil
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(60) do
        if Config.AntiAFK then
            pcall(function()
                local VU = game:GetService("VirtualUser")
                VU:CaptureController()
                VU:ClickButton2(Vector2.new(0, 0))
            end)
        end
    end
end)

local lastMD = 999
task.spawn(function()
    while task.wait(0.5) do
        if Config.MurdererAlert then
            pcall(function()
                local c = LocalPlayer.Character
                local hrp = c and c:FindFirstChild("HumanoidRootPart")
                if hrp then
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer and getRole(p) == "Murderer" then
                            local tc = p.Character
                            local tHrp = tc and tc:FindFirstChild("HumanoidRootPart")
                            if tHrp then
                                local d = (tHrp.Position - hrp.Position).Magnitude
                                if d <= Config.MurdererAlertRange and lastMD > Config.MurdererAlertRange then
                                    Rayfield:Notify({
                                        Title = "Alerta",
                                        Content = "Murderer perto. Distancia: " .. math.floor(d) .. " studs",
                                        Duration = 4,
                                    })
                                end
                                lastMD = d
                                break
                            end
                        end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.05) do
        if Config.LockCameraMurderer then
            pcall(function()
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and getRole(p) == "Murderer" then
                        local tc = p.Character
                        local head = tc and tc:FindFirstChild("Head")
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

-- Actions
local function showPlayerList()
    local msg = "Jogadores:\n"
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            msg = msg .. p.Name .. " - " .. getRole(p) .. "\n"
        end
    end
    Rayfield:Notify({Title = "Lista de Players", Content = msg, Duration = 10})
end

local function serverHop()
    Rayfield:Notify({Title = "Server Hop", Content = "Procurando servidor...", Duration = 3})
    task.spawn(function()
        pcall(function()
            local HS = game:GetService("HttpService")
            local TS = game:GetService("TeleportService")
            local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
            local res
            if syn and syn.request then
                res = syn.request({Url = url, Method = "GET"}).Body
            elseif request then
                res = request({Url = url, Method = "GET"}).Body
            else
                res = game:HttpGet(url)
            end
            local data = HS:JSONDecode(res)
            if data and data.data then
                for _, s in ipairs(data.data) do
                    if s.playing < s.maxPlayers and s.id ~= game.JobId then
                        TS:TeleportToPlaceInstance(game.PlaceId, s.id, LocalPlayer)
                        return
                    end
                end
            end
            Rayfield:Notify({Title = "Server Hop", Content = "Nenhum servidor encontrado", Duration = 3})
        end)
    end)
end

local function killAll()
    local char = LocalPlayer.Character
    if not char then return end
    local knife = findTool(char, "knife", LocalPlayer)
    if not knife then
        Rayfield:Notify({Title = "Kill All", Content = "Precisa ser Murderer com faca", Duration = 3})
        return
    end
    task.spawn(function()
        local myHrp = char:FindFirstChild("HumanoidRootPart")
        if not myHrp then return end
        local saved = myHrp.CFrame
        local count = 0
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                local tc = p.Character
                if tc then
                    local tHrp = tc:FindFirstChild("HumanoidRootPart")
                    local hum = tc:FindFirstChildOfClass("Humanoid")
                    if tHrp and hum and hum.Health > 0 then
                        myHrp.CFrame = CFrame.new(tHrp.Position)
                        myHrp.Velocity = Vector3.zero
                        task.wait(0.2)
                        if knife.Parent ~= char then knife.Parent = char end
                        local hum2 = char:FindFirstChildOfClass("Humanoid")
                        if hum2 and hum2:GetEquippedTool() ~= knife then
                            pcall(function() hum2:EquipTool(knife) end)
                            task.wait(0.1)
                        end
                        pcall(function() knife:Activate() end)
                        task.wait(0.15)
                        count = count + 1
                    end
                end
            end
        end
        myHrp.CFrame = saved
        local bp = LocalPlayer:FindFirstChildOfClass("Backpack")
        if bp then pcall(function() knife.Parent = bp end) end
        Rayfield:Notify({Title = "Kill All", Content = "Tentei matar " .. count .. " players", Duration = 4})
    end)
end

local function tpToRole(roleName)
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and getRole(p) == roleName then
            local c = p.Character
            if c then
                local hrp = c:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local myC = LocalPlayer.Character
                    if myC then
                        local myHrp = myC:FindFirstChild("HumanoidRootPart")
                        if myHrp then
                            myHrp.CFrame = CFrame.new(hrp.Position + Vector3.new(0, 3, 0))
                            Rayfield:Notify({
                                Title = "Teleporte",
                                Content = "Fui para " .. p.Name .. " (" .. roleName .. ")",
                                Duration = 3,
                            })
                            return
                        end
                    end
                end
            end
        end
    end
    Rayfield:Notify({Title = "Teleporte", Content = roleName .. " nao encontrado", Duration = 3})
end

-- Performance
local perfSaved = {}
local matSaved = setmetatable({}, {__mode = "k"})
local shadowSaved = setmetatable({}, {__mode = "k"})
local perfState = {nofog = false, noshadow = false, smooth = false, bright = false}

local function saveLight(key, props)
    if perfSaved[key] then return end
    perfSaved[key] = {}
    for _, p in ipairs(props) do perfSaved[key][p] = Lighting[p] end
end

local function restoreLight(key)
    if not perfSaved[key] then return end
    for p, v in pairs(perfSaved[key]) do
        pcall(function() Lighting[p] = v end)
    end
    perfSaved[key] = nil
end

local function applyPart(part)
    if not part:IsA("BasePart") then return end
    if perfState.noshadow then
        if shadowSaved[part] == nil then shadowSaved[part] = part.CastShadow end
        pcall(function() part.CastShadow = false end)
    end
    if perfState.smooth then
        if matSaved[part] == nil then matSaved[part] = part.Material end
        pcall(function() part.Material = Enum.Material.SmoothPlastic end)
    end
end

workspace.DescendantAdded:Connect(function(obj)
    if perfState.noshadow or perfState.smooth then
        pcall(applyPart, obj)
    end
end)

local function restoreMats()
    for obj, m in pairs(matSaved) do
        if obj and obj.Parent then pcall(function() obj.Material = m end) end
    end
end

local function restoreShadows()
    for obj, s in pairs(shadowSaved) do
        if obj and obj.Parent then pcall(function() obj.CastShadow = s end) end
    end
end

local function bulkApply()
    task.spawn(function()
        local n = 0
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                applyPart(obj)
                n = n + 1
                if n % 500 == 0 then task.wait() end
            end
        end
    end)
end

task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            if Config.Perf_FullBright and not perfState.bright then
                saveLight("bright", {"Brightness", "Ambient", "OutdoorAmbient", "ClockTime"})
                Lighting.Brightness = 3
                Lighting.ClockTime = 14
                Lighting.Ambient = Color3.fromRGB(200, 200, 200)
                Lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 200)
                perfState.bright = true
            elseif not Config.Perf_FullBright and perfState.bright then
                restoreLight("bright")
                perfState.bright = false
            end
            if Config.Perf_NoFog and not perfState.nofog then
                saveLight("fog", {"FogEnd", "FogStart", "FogColor"})
                Lighting.FogEnd = 100000
                Lighting.FogStart = 100000
                perfState.nofog = true
            elseif not Config.Perf_NoFog and perfState.nofog then
                restoreLight("fog")
                perfState.nofog = false
            end
            if Config.Perf_NoShadow and not perfState.noshadow then
                saveLight("shadow", {"GlobalShadows"})
                Lighting.GlobalShadows = false
                perfState.noshadow = true
                bulkApply()
            elseif not Config.Perf_NoShadow and perfState.noshadow then
                restoreLight("shadow")
                restoreShadows()
                perfState.noshadow = false
            end
            if Config.Perf_SmoothTexture and not perfState.smooth then
                perfState.smooth = true
                bulkApply()
            elseif not Config.Perf_SmoothTexture and perfState.smooth then
                restoreMats()
                perfState.smooth = false
            end
        end)
    end
end)

-- Anti-Fling
pcall(function()
    PhysicsService:RegisterCollisionGroup("MM2_Self")
    PhysicsService:RegisterCollisionGroup("MM2_Others")
    PhysicsService:CollisionGroupSetCollidable("MM2_Self", "MM2_Others", false)
end)

local function applySelf(part)
    if part:IsA("BasePart") and part.CollisionGroup ~= "MM2_Self" then
        pcall(function() part.CollisionGroup = "MM2_Self" end)
    end
end
local function applyOther(part)
    if part:IsA("BasePart") and part.CollisionGroup ~= "MM2_Others" then
        pcall(function() part.CollisionGroup = "MM2_Others" end)
    end
end
local function setSelf()
    local c = LocalPlayer.Character
    if not c then return end
    for _, p in ipairs(c:GetDescendants()) do applySelf(p) end
end
local function setOthers()
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= LocalPlayer and pl.Character then
            for _, p in ipairs(pl.Character:GetDescendants()) do applyOther(p) end
        end
    end
end
local function restoreGroups()
    local c = LocalPlayer.Character
    if c then
        for _, p in ipairs(c:GetDescendants()) do
            if p:IsA("BasePart") then pcall(function() p.CollisionGroup = "Default" end) end
        end
    end
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= LocalPlayer and pl.Character then
            for _, p in ipairs(pl.Character:GetDescendants()) do
                if p:IsA("BasePart") then pcall(function() p.CollisionGroup = "Default" end) end
            end
        end
    end
end

local function enableAntiFling()
    if not Config.AntiFling then return end
    local c = LocalPlayer.Character
    if not c then return end
    local hrp = c:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5, 1, 1) end
    pcall(setSelf)
    pcall(setOthers)
end

workspace.DescendantAdded:Connect(function(obj)
    if not Config.AntiFling then return end
    if not obj:IsA("BasePart") then return end
    task.spawn(function()
        local pc = obj:FindFirstAncestorOfClass("Model")
        if not pc then return end
        if pc == LocalPlayer.Character then applySelf(obj)
        else
            for _, pl in ipairs(Players:GetPlayers()) do
                if pl ~= LocalPlayer and pl.Character == pc then
                    applyOther(obj)
                    break
                end
            end
        end
    end)
end)

Players.PlayerAdded:Connect(function()
    task.wait(1)
    if Config.AntiFling then pcall(setSelf) pcall(setOthers) end
end)

Players.PlayerRemoving:Connect(function()
    if Config.AntiFling then pcall(setOthers) end
end)

RunService.Heartbeat:Connect(function()
    if not Config.AntiFling then return end
    pcall(function()
        local c = LocalPlayer.Character
        if not c then return end
        local hrp = c:FindFirstChild("HumanoidRootPart")
        local hum = c:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum or hum.Health <= 0 then return end
        if not hrp.CustomPhysicalProperties or hrp.CustomPhysicalProperties.Density ~= 0.7 then
            hrp.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5, 1, 1)
        end
        local v = hrp.AssemblyLinearVelocity
        local h = Vector3.new(v.X, 0, v.Z).Magnitude
        local a = hrp.AssemblyAngularVelocity.Magnitude
        if h > 160 or v.Y > 80 or a > 40 then
            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero
            hrp.Velocity = Vector3.zero
            hrp.RotVelocity = Vector3.zero
            local s = hum:GetState()
            if s == Enum.HumanoidStateType.FallingDown or s == Enum.HumanoidStateType.Ragdoll
                or s == Enum.HumanoidStateType.Physics then
                hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
            hum.PlatformStand = false
        end
    end)
end)

-- Invisible
local invisSeat = nil
local invisOn = false

local function invisCleanup()
    local e = workspace:FindFirstChild("invischair")
    if e then e:Destroy() end
    invisSeat = nil
end

local function invisOn_()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    invisCleanup()
    local saved = hrp.CFrame
    local tp = Vector3.new(0, Config.InvisibleY, 0)
    char:MoveTo(tp)
    task.wait(0.15)
    local seat = Instance.new("Seat")
    seat.Name = "invischair"
    seat.Anchored = false
    seat.CanCollide = false
    seat.Transparency = 1
    seat.Position = tp
    seat.Parent = workspace
    invisSeat = seat
    local weld = Instance.new("Weld")
    weld.Part0 = seat
    weld.Part1 = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
    weld.Parent = seat
    task.wait()
    seat.CFrame = saved
    for _, d in ipairs(char:GetDescendants()) do
        if d:IsA("BasePart") or d:IsA("Decal") then d.Transparency = 0.5 end
    end
end

local function invisOff()
    invisCleanup()
    if LocalPlayer.Character then
        for _, d in ipairs(LocalPlayer.Character:GetDescendants()) do
            if d:IsA("BasePart") or d:IsA("Decal") then d.Transparency = 0 end
        end
    end
end

local function invisToggle()
    invisOn = not invisOn
    Config.Invisible = invisOn
    if invisOn then invisOn_() else invisOff() end
end

task.spawn(function()
    while task.wait(0.5) do
        if invisOn and (not invisSeat or not invisSeat.Parent) then
            invisOn = false
            Config.Invisible = false
            invisOff()
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
    invisOn = false
    Config.Invisible = false
    invisCleanup()
    if Config.AntiFling then
        task.wait(0.5)
        enableAntiFling()
    end
end)

-- Teleport helpers
local function teleportTo(pos)
    local c = LocalPlayer.Character
    if not c then return end
    local hrp = c:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = CFrame.new(pos + Vector3.new(0, 5, 0))
        hrp.Velocity = Vector3.zero
    end
end

local function findObby()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name:lower():find("obby") then return obj.Position end
    end
    return nil
end

local function mapCenter()
    local sum, n = Vector3.zero, 0
    for _, p in ipairs(Players:GetPlayers()) do
        local c = p.Character
        if c and c:FindFirstChild("HumanoidRootPart") then
            sum = sum + c.HumanoidRootPart.Position
            n = n + 1
        end
    end
    if n > 0 then return sum / n end
    return Vector3.new(0, 10, 0)
end

-- Grab Gun (rapido)
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

    local gun = findGunOnGround()
    if not gun then return false end

    local handle
    if gun:IsA("Tool") then
        handle = gun:FindFirstChild("Handle") or gun:FindFirstChildWhichIsA("BasePart")
    elseif gun:IsA("BasePart") then
        handle = gun
    elseif gun:IsA("Model") then
        handle = gun.PrimaryPart or gun:FindFirstChildWhichIsA("BasePart")
    end
    if not handle then return false end

    grabbing = true
    local origCF = hrp.CFrame
    local origVel = hrp.Velocity

    -- Teleporta direto em cima do handle
    hrp.CFrame = CFrame.new(handle.Position + Vector3.new(0, 1, 0))
    hrp.Velocity = Vector3.zero

    -- 3 fire touches em sequencia rapida (redundancia)
    for i = 1, 3 do
        pcall(function()
            firetouchinterest(hrp, handle, 0)
            firetouchinterest(hrp, handle, 1)
        end)
        task.wait(0.04)
    end

    -- ProximityPrompt/ClickDetector (fallback)
    local prompt = gun:FindFirstChildOfClass("ProximityPrompt")
    if prompt then pcall(function() fireproximityprompt(prompt) end) end
    local cd = gun:FindFirstChildOfClass("ClickDetector")
    if cd then pcall(function() fireclickdetector(cd) end) end

    -- Volta instantaneo
    if hrp.Parent then
        hrp.CFrame = origCF
        hrp.Velocity = origVel
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
                    local has = false
                    for _, t in ipairs(char:GetChildren()) do
                        if t:IsA("Tool") and t.Name:lower():find("gun") then has = true break end
                    end
                    if not has and findGunOnGround() then pcall(grabGun) end
                end
            end
        end)
    end
end)

-- RenderStepped
RunService.RenderStepped:Connect(function()
    fovCircle.Visible = Config.Show_FOV
    if Config.Show_FOV then
        local sz = Config.Aimbot_FOV * 2
        if fovCircle.AbsoluteSize.X ~= sz then fovCircle.Size = UDim2.new(0, sz, 0, sz) end
        trigCircle.Visible = Config.TriggerBot
        if trigCircle.Visible then
            local tz = Config.TriggerBot_FOV * 2
            if trigCircle.AbsoluteSize.X ~= tz then trigCircle.Size = UDim2.new(0, tz, 0, tz) end
        end
    else
        trigCircle.Visible = false
    end

    if Config.Aimbot then
        local c = LocalPlayer.Character
        if c and c:FindFirstChild("HumanoidRootPart") then
            local t = aimTarget(Config.Aimbot_FOV)
            if t then
                local head = t:FindFirstChild("Head")
                if head then
                    local desired = CFrame.lookAt(Camera.CFrame.Position, head.Position)
                    local s = Config.Aimbot_Instant and 1 or Config.Aimbot_Smoothness
                    Camera.CFrame = Camera.CFrame:Lerp(desired, s)
                end
            end
        end
    end

    if Config.Fly then
        local c = LocalPlayer.Character
        if c then
            local hrp = c:FindFirstChild("HumanoidRootPart")
            if hrp then
                local d = Vector3.zero
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then d = d + Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then d = d - Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then d = d - Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then d = d + Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then d = d + Vector3.new(0, 1, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then d = d - Vector3.new(0, 1, 0) end
                if d.Magnitude > 0 then hrp.Velocity = d.Unit * Config.FlySpeed
                else hrp.Velocity = Vector3.zero end
            end
        end
    end
end)

-- Interface
local Window = Rayfield:CreateWindow({
    Name = "MM2 Hub v3",
    LoadingTitle = "Carregando",
    LoadingSubtitle = "MM2",
    ConfigurationSaving = {Enabled = false},
    Keybind = Enum.KeyCode.RightControl,
    Theme = "DarkBlue",
})

local VTab = Window:CreateTab("Visual", 4483362458)
VTab:CreateToggle({
    Name = "ESP Players",
    CurrentValue = false,
    Callback = function(v)
        Config.ESP_Players = v
        if not v then for p in pairs(espCache) do dropHighlight(p) end end
    end,
})
VTab:CreateToggle({
    Name = "ESP Nome",
    CurrentValue = false,
    Callback = function(v)
        Config.ESP_Name = v
        if not v then for p in pairs(nameCache) do dropNameTag(p) end end
    end,
})
VTab:CreateToggle({
    Name = "ESP Gun",
    CurrentValue = false,
    Callback = function(v) Config.ESP_Gun = v end,
})
VTab:CreateSlider({
    Name = "ESP Gun - Distancia",
    Range = {50, 2000}, Increment = 10, Suffix = " studs",
    CurrentValue = 500,
    Callback = function(v) Config.ESP_GunMaxDist = v end,
})
VTab:CreateToggle({
    Name = "ESP Coin",
    CurrentValue = false,
    Callback = function(v) Config.ESP_Coin = v end,
})
VTab:CreateSlider({
    Name = "ESP Coin - Distancia",
    Range = {30, 500}, Increment = 10, Suffix = " studs",
    CurrentValue = 150,
    Callback = function(v) Config.ESP_CoinMaxDist = v end,
})

local VPTab = Window:CreateTab("Visual+", 4483362458)
VPTab:CreateToggle({
    Name = "Radar HUD",
    CurrentValue = false,
    Callback = function(v) Config.RadarHUD = v end,
})
VPTab:CreateToggle({
    Name = "Hitbox Expander",
    CurrentValue = false,
    Callback = function(v) Config.HitboxExpander = v end,
})
VPTab:CreateSlider({
    Name = "Tamanho Hitbox",
    Range = {2, 20}, Increment = 1, CurrentValue = 5,
    Callback = function(v) Config.HitboxSize = v end,
})
VPTab:CreateSlider({
    Name = "Hitbox Range",
    Range = {50, 500}, Increment = 10, CurrentValue = 200,
    Callback = function(v) Config.HitboxMaxDist = v end,
})
VPTab:CreateToggle({
    Name = "Camera segue Murderer",
    CurrentValue = false,
    Callback = function(v) Config.LockCameraMurderer = v end,
})
VPTab:CreateButton({
    Name = "Debug ESP Gun",
    Callback = function()
        local gun = findGunOnGround()
        if gun then
            Rayfield:Notify({Title = "Debug Gun", Content = "Achou: " .. gun.Name, Duration = 6})
        else
            Rayfield:Notify({Title = "Debug Gun", Content = "Nao achou", Duration = 6})
        end
    end,
})

local ATab = Window:CreateTab("Aimbot", 4483362458)
ATab:CreateToggle({Name = "Aimbot", CurrentValue = false, Callback = function(v) Config.Aimbot = v end})
ATab:CreateToggle({Name = "Aimbot Instantaneo", CurrentValue = false, Callback = function(v) Config.Aimbot_Instant = v end})
ATab:CreateToggle({Name = "Aimbot Team Check", CurrentValue = false, Callback = function(v) Config.Aimbot_TeamCheck = v end})
ATab:CreateToggle({Name = "Aimbot Wall Check", CurrentValue = false, Callback = function(v) Config.Aimbot_WallCheck = v end})
ATab:CreateSlider({Name = "Suavidade", Range = {0.05, 1.0}, Increment = 0.05, CurrentValue = 0.2, Callback = function(v) Config.Aimbot_Smoothness = v end})
ATab:CreateSlider({Name = "FOV Aimbot", Range = {30, 500}, Increment = 5, CurrentValue = 150, Callback = function(v) Config.Aimbot_FOV = v end})
ATab:CreateToggle({Name = "Mostrar FOVs", CurrentValue = true, Callback = function(v) Config.Show_FOV = v end})
ATab:CreateToggle({Name = "Trigger Bot", CurrentValue = false, Callback = function(v) Config.TriggerBot = v end})
ATab:CreateToggle({Name = "Trigger Instantaneo", CurrentValue = false, Callback = function(v) Config.TriggerBot_Instant = v end})
ATab:CreateToggle({Name = "Trigger Team Check", CurrentValue = false, Callback = function(v) Config.TriggerBot_TeamCheck = v end})
ATab:CreateToggle({Name = "Trigger Wall Check", CurrentValue = false, Callback = function(v) Config.TriggerBot_WallCheck = v end})
ATab:CreateSlider({Name = "Trigger FOV", Range = {10, 300}, Increment = 5, CurrentValue = 40, Callback = function(v) Config.TriggerBot_FOV = v end})
ATab:CreateSlider({Name = "Trigger Delay", Range = {0, 0.5}, Increment = 0.01, CurrentValue = 0.25, Callback = function(v) Config.TriggerBot_Delay = v end})

local MTab = Window:CreateTab("Murder", 4483362458)
MTab:CreateButton({Name = "Kill All", Callback = function() killAll() end})
MTab:CreateToggle({Name = "Auto Kill Faca", CurrentValue = false, Callback = function(v) Config.AutoKill_Murder = v end})
MTab:CreateToggle({Name = "Wall Check", CurrentValue = true, Callback = function(v) Config.AutoKill_WallCheck = v end})
MTab:CreateSlider({Name = "Alcance Faca", Range = {5, 50}, Increment = 1, CurrentValue = 25, Callback = function(v) Config.AutoKill_Range = v end})
MTab:CreateSlider({Name = "Delay", Range = {0.1, 1.0}, Increment = 0.05, CurrentValue = 0.5, Callback = function(v) Config.AutoKill_Delay = v end})
MTab:CreateButton({Name = "Ir para Innocent", Callback = function() tpToRole("Innocent") end})
MTab:CreateButton({Name = "Ir para Sheriff", Callback = function() tpToRole("Sheriff") end})

local STab = Window:CreateTab("Sheriff", 4483362458)
STab:CreateButton({
    Name = "Grab Gun",
    Callback = function()
        local ok = grabGun()
        if ok then Rayfield:Notify({Title = "Grab Gun", Content = "Pegou a arma", Duration = 3})
        else Rayfield:Notify({Title = "Grab Gun", Content = "Nenhuma arma no chao", Duration = 3}) end
    end,
})
STab:CreateToggle({Name = "Auto Grab Gun", CurrentValue = false, Callback = function(v) Config.AutoGrabGun = v end})
STab:CreateToggle({Name = "Auto Kill Arma", CurrentValue = false, Callback = function(v) Config.AutoKill_Sheriff = v end})
STab:CreateToggle({Name = "Wall Check", CurrentValue = true, Callback = function(v) Config.AutoKill_WallCheck = v end})
STab:CreateSlider({Name = "Alcance Tiro", Range = {50, 1000}, Increment = 10, CurrentValue = 500, Callback = function(v) Config.AutoKill_GunRange = v end})
STab:CreateSlider({Name = "Delay", Range = {0.1, 1.0}, Increment = 0.05, CurrentValue = 0.5, Callback = function(v) Config.AutoKill_Delay = v end})
STab:CreateButton({Name = "Ir para Murderer", Callback = function() tpToRole("Murderer") end})

local PTab = Window:CreateTab("Player", 4483362458)
PTab:CreateSlider({
    Name = "Speed", Range = {16, 200}, Increment = 1, CurrentValue = 16,
    Callback = function(v)
        Config.Speed = v
        local c = LocalPlayer.Character
        if c and c:FindFirstChildOfClass("Humanoid") then c.Humanoid.WalkSpeed = v end
    end,
})
PTab:CreateSlider({
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
PTab:CreateToggle({Name = "Pulo Infinito [J]", CurrentValue = false, Callback = function(v) Config.InfiniteJump = v end})
PTab:CreateToggle({Name = "Anti Void [V]", CurrentValue = false, Callback = function(v) Config.AntiVoid = v end})
PTab:CreateToggle({
    Name = "Fly [F]", CurrentValue = false,
    Callback = function(v)
        Config.Fly = v
        if not v then
            local c = LocalPlayer.Character
            if c then
                local hrp = c:FindFirstChild("HumanoidRootPart")
                if hrp then hrp.Velocity = Vector3.zero end
            end
        end
    end,
})
PTab:CreateSlider({Name = "Fly Speed", Range = {10, 200}, Increment = 5, CurrentValue = 50, Callback = function(v) Config.FlySpeed = v end})
PTab:CreateToggle({
    Name = "Noclip [N]", CurrentValue = false,
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
PTab:CreateToggle({
    Name = "Invisible [I]", CurrentValue = false,
    Callback = function(v) task.spawn(function() invisToggle() end) end,
})
PTab:CreateSlider({Name = "Invisible Y", Range = {1000, 50000}, Increment = 100, CurrentValue = 5000, Callback = function(v) Config.InvisibleY = v end})

local PfTab = Window:CreateTab("Performance", 4483362458)
PfTab:CreateToggle({Name = "Sem Neblina", CurrentValue = false, Callback = function(v) Config.Perf_NoFog = v end})
PfTab:CreateToggle({Name = "Sem Sombras", CurrentValue = false, Callback = function(v) Config.Perf_NoShadow = v end})
PfTab:CreateToggle({Name = "Textura Lisa", CurrentValue = false, Callback = function(v) Config.Perf_SmoothTexture = v end})
PfTab:CreateToggle({Name = "Full Bright", CurrentValue = false, Callback = function(v) Config.Perf_FullBright = v end})
PfTab:CreateButton({
    Name = "Aplicar Tudo",
    Callback = function()
        Config.Perf_NoFog = true
        Config.Perf_NoShadow = true
        Config.Perf_FullBright = true
    end,
})
PfTab:CreateButton({
    Name = "Resetar",
    Callback = function()
        Config.Perf_NoFog = false
        Config.Perf_NoShadow = false
        Config.Perf_SmoothTexture = false
        Config.Perf_FullBright = false
        restoreLight("bright")
        restoreLight("fog")
        restoreLight("shadow")
        restoreMats()
        restoreShadows()
        perfState.bright = false
        perfState.nofog = false
        perfState.noshadow = false
        perfState.smooth = false
    end,
})

local ETab = Window:CreateTab("Extras", 4483362458)
ETab:CreateToggle({Name = "Anti-Kick", CurrentValue = false, Callback = function(v) Config.AntiKick = v end})
ETab:CreateToggle({Name = "Anti-Ragdoll", CurrentValue = false, Callback = function(v) Config.AntiRagdoll = v end})
ETab:CreateToggle({Name = "Kill Notifier", CurrentValue = false, Callback = function(v) Config.KillNotifier = v end})
ETab:CreateToggle({Name = "Auto Dodge", CurrentValue = false, Callback = function(v) Config.AutoDodge = v end})
ETab:CreateToggle({Name = "Anti-AFK", CurrentValue = false, Callback = function(v) Config.AntiAFK = v end})
ETab:CreateToggle({Name = "Murderer Alert", CurrentValue = false, Callback = function(v) Config.MurdererAlert = v end})
ETab:CreateSlider({Name = "Alerta Range", Range = {30, 200}, Increment = 10, CurrentValue = 80, Callback = function(v) Config.MurdererAlertRange = v end})
ETab:CreateButton({Name = "Lista de Players", Callback = function() showPlayerList() end})
ETab:CreateButton({Name = "Server Hop", Callback = function() serverHop() end})

local TTab = Window:CreateTab("Teleporte", 4483362458)
TTab:CreateButton({
    Name = "Ir para Obby",
    Callback = function()
        local p = findObby()
        if p then teleportTo(p)
        else Rayfield:Notify({Title = "Teleporte", Content = "Obby nao encontrado", Duration = 3}) end
    end,
})
TTab:CreateButton({
    Name = "Ir para o Centro",
    Callback = function() teleportTo(mapCenter()) end,
})

local PrTab = Window:CreateTab("Protecao", 4483362458)
PrTab:CreateToggle({
    Name = "Anti-Fling",
    CurrentValue = false,
    Callback = function(v)
        Config.AntiFling = v
        if v then enableAntiFling()
        else pcall(restoreGroups) end
    end,
})

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
    local k = input.KeyCode

    if k == Enum.KeyCode.F then
        Config.Fly = not Config.Fly
        if not Config.Fly then
            local c = LocalPlayer.Character
            if c then
                local hrp = c:FindFirstChild("HumanoidRootPart")
                if hrp then hrp.Velocity = Vector3.zero end
            end
        end
        Rayfield:Notify({Title = "Fly", Content = Config.Fly and "Ligado" or "Desligado", Duration = 2})
    end

    if k == Enum.KeyCode.N then
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

    if k == Enum.KeyCode.G then
        task.spawn(function()
            local ok = grabGun()
            Rayfield:Notify({Title = "Grab Gun", Content = ok and "Pegou" or "Nada no chao", Duration = 3})
        end)
    end

    if k == Enum.KeyCode.J then
        Config.InfiniteJump = not Config.InfiniteJump
        Rayfield:Notify({Title = "Pulo Infinito", Content = Config.InfiniteJump and "Ligado" or "Desligado", Duration = 2})
    end

    if k == Enum.KeyCode.V then
        Config.AntiVoid = not Config.AntiVoid
        Rayfield:Notify({Title = "Anti Void", Content = Config.AntiVoid and "Ligado" or "Desligado", Duration = 2})
    end

    if k == Enum.KeyCode.I then
        task.spawn(function()
            invisToggle()
            Rayfield:Notify({Title = "Invisible", Content = Config.Invisible and "Ligado" or "Desligado", Duration = 2})
        end)
    end
end)

Rayfield:Notify({
    Title = "MM2 Hub v3",
    Content = "Menu: RightCtrl | F=Fly N=Noclip G=GrabGun J=Jump V=AntiVoid I=Invisible",
    Duration = 7,
})

end)

if not okLoad then
    warn("[MM2 Hub] Erro:", tostring(errLoad))
end
