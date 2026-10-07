-- MM2 Hub v3 + YARHM (5 abas)
local PLACE_IDS = {142823291, 1990777535, 321010323}
local function isMM2()
    for _, id in ipairs(PLACE_IDS) do if game.PlaceId == id then return true end end
    local n = (game.Name or ""):lower()
    return n == "murder mystery 2" or n == "mm2"
end

if not isMM2() then
    local gui = Instance.new("ScreenGui")
    gui.ResetOnSpawn=false; gui.IgnoreGuiInset=true; gui.DisplayOrder=9999
    pcall(function() gui.Parent = game:GetService("CoreGui") end)
    local f = Instance.new("Frame", gui)
    f.AnchorPoint=Vector2.new(0.5,0.5); f.Position=UDim2.new(0.5,0,0.5,0)
    f.Size=UDim2.fromOffset(420,130); f.BackgroundColor3=Color3.fromRGB(25,25,35); f.BorderSizePixel=0
    Instance.new("UICorner", f).CornerRadius=UDim.new(0,12)
    local s = Instance.new("UIStroke", f); s.Color=Color3.fromRGB(255,70,70); s.Thickness=2
    local t = Instance.new("TextLabel", f)
    t.Size=UDim2.new(1,-20,0,40); t.Position=UDim2.fromOffset(10,10); t.BackgroundTransparency=1
    t.Font=Enum.Font.GothamBold; t.TextSize=20; t.TextColor3=Color3.fromRGB(255,90,90)
    t.Text="Jogo Incompativel"
    local m = Instance.new("TextLabel", f)
    m.Size=UDim2.new(1,-20,0,70); m.Position=UDim2.fromOffset(10,45); m.BackgroundTransparency=1
    m.Font=Enum.Font.Gotham; m.TextSize=14; m.TextColor3=Color3.fromRGB(230,230,240)
    m.TextWrapped=true
    m.Text="Este script funciona apenas no Murder Mystery 2.\nJogo atual: "..tostring(game.Name).."\nPlaceId: "..tostring(game.PlaceId)
    task.delay(4, function() pcall(function() gui:Destroy() end) end)
    return
end

local okLoad, errLoad = pcall(function()

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local PhysicsService = game:GetService("PhysicsService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local Config = {
    ESP_Players=false, ESP_Name=false, ESP_Gun=false, ESP_Coin=false,
    ESP_CoinMaxDist=150, ESP_GunMaxDist=500,
    ESP_Color_Innocent=Color3.fromRGB(0,255,0),
    ESP_Color_Sheriff=Color3.fromRGB(0,150,255),
    ESP_Color_Murderer=Color3.fromRGB(255,0,0),
    Aimbot=false, Aimbot_Smoothness=0.2, Aimbot_FOV=150,
    Aimbot_WallCheck=false, Aimbot_TeamCheck=false, Aimbot_Instant=false,
    Show_FOV=true,
    TriggerBot=false, TriggerBot_TeamCheck=false, TriggerBot_Delay=0.25,
    TriggerBot_FOV=40, TriggerBot_WallCheck=false, TriggerBot_Instant=false,
    AutoKill_Murder=false, AutoKill_Sheriff=false, AutoKill_Range=25,
    AutoKill_GunRange=500, AutoKill_Delay=0.5, AutoKill_WallCheck=true,
    Speed=16, JumpPower=50, InfiniteJump=false, InfJumpOnlyTwo=false,
    Fly=false, FlySpeed=50, OPFly=false, OPFlySpeed=50,
    Noclip=false, AntiVoid=false, AntiFling=false,
    Invisible=false, InvisibleY=5000,
    AutoGrabGun=false, AutoGrabGun_Delay=1.0,
    AutoGetDroppedGun=false, GunDropTakeExp=false,
    Perf_NoFog=false, Perf_NoShadow=false, Perf_SmoothTexture=false, Perf_FullBright=false,
    AntiKick=false, AntiRagdoll=false, KillNotifier=false, AutoDodge=false,
    HitboxExpander=false, HitboxSize=5, HitboxMaxDist=200, HitboxAggressive=false,
    RadarHUD=false, AntiAFK=false, MurdererAlert=false, MurdererAlertRange=80,
    LockCameraMurderer=false,
    LoopWS_FOV=false, LoopWS=16, LoopFOV=70, WSInc=2,
    CtrlClickTP=false, AutoKnifeThrow=false, SpawnKnifeNearPlayer=false,
    IgnoreKnifeThrows=false, InstakillShoot=false,
    FlingTarget=nil,
}

-- ============ FINDERS ============
local function findSheriff()
    for _, p in ipairs(Players:GetPlayers()) do
        local bp = p:FindFirstChildOfClass("Backpack")
        if bp and bp:FindFirstChild("Gun") then return p end
        if p.Character and p.Character:FindFirstChild("Gun") then return p end
    end
end
local function findMurderer()
    for _, p in ipairs(Players:GetPlayers()) do
        local bp = p:FindFirstChildOfClass("Backpack")
        if bp and bp:FindFirstChild("Knife") then return p end
        if p.Character and p.Character:FindFirstChild("Knife") then return p end
    end
end
local function findNearestPlayer()
    local best, bd = nil, math.huge
    local myC = LocalPlayer.Character
    local myH = myC and myC:FindFirstChild("HumanoidRootPart")
    if not myH then return nil end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local h = p.Character:FindFirstChild("HumanoidRootPart")
            if h then
                local d = (h.Position - myH.Position).Magnitude
                if d < bd then bd = d; best = p end
            end
        end
    end
    return best
end

-- ============ OP FLY ============
local FlyUtil = {}
do
    local FLY_MAX = 50
    local FLY_ACCEL = 2
    local active = false
    local cur = 0
    local dir = Vector3.new()
    local gyro, vel, conn
    local function flyStop()
        if conn then conn:Disconnect(); conn = nil end
        if gyro then gyro:Destroy(); gyro = nil end
        if vel then vel:Destroy(); vel = nil end
        local c = LocalPlayer.Character
        if c then
            local h = c:FindFirstChildOfClass("Humanoid")
            if h then h.PlatformStand = false end
        end
        active = false
        cur = 0
    end
    local function flyStep()
        local c = LocalPlayer.Character
        if not active or not c then FlyUtil:Stop() return end
        local hum = c:FindFirstChildOfClass("Humanoid")
        local hrp = c:FindFirstChild("HumanoidRootPart")
        local cam = workspace.CurrentCamera
        if not hum or hum.Health <= 0 or not hrp or not cam then FlyUtil:Stop() return end
        local md = hum.MoveDirection
        if md.Magnitude > 0.01 then
            cur = math.min(FLY_MAX, cur + FLY_ACCEL)
            dir = md.Unit
        else
            cur = math.max(0, cur - FLY_ACCEL)
        end
        local flat = Vector3.new(dir.X, 0, dir.Z)
        local v = Vector3.zero
        if flat.Magnitude > 0 then v = flat.Unit * cur end
        local look = cam.CFrame.LookVector.Unit
        local dot = dir:Dot(look)
        local sign = dot < 0 and -1 or 1
        local flatLook = Vector3.new(look.X, 0, look.Z)
        if flatLook.Magnitude > 0 then flatLook = flatLook.Unit end
        local facing = math.abs(dir:Dot(flatLook))
        local yVel = look.Y * sign * facing * cur
        vel.Velocity = Vector3.new(v.X, yVel, v.Z)
        local lean = (cur / FLY_MAX) * 30
        local pitch = -math.rad(dot * lean)
        gyro.CFrame = CFrame.new(hrp.Position, hrp.Position + look) * CFrame.Angles(pitch, 0, 0)
    end
    function FlyUtil:Start()
        if active then return end
        local c = LocalPlayer.Character; if not c then return end
        local hum = c:FindFirstChildOfClass("Humanoid")
        local hrp = c:FindFirstChild("HumanoidRootPart")
        if not hum or not hrp then return end
        active = true
        gyro = Instance.new("BodyGyro")
        gyro.P = 100000
        gyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        gyro.CFrame = hrp.CFrame
        gyro.Parent = hrp
        vel = Instance.new("BodyVelocity")
        vel.P = 10000
        vel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        vel.Velocity = Vector3.zero
        vel.Parent = hrp
        hum.PlatformStand = true
        conn = RunService.Heartbeat:Connect(flyStep)
    end
    function FlyUtil:Stop() if active then flyStop() end end
    function FlyUtil:SetMaxSpeed(v) if type(v) == "number" and v >= 0 then FLY_MAX = v end end
    function FlyUtil:IsFlying() return active end
    LocalPlayer.CharacterRemoving:Connect(function() if active then FlyUtil:Stop() end end)
end

-- ============ ROLE DETECTION ============
local roleCache, ROLE_TTL = {}, 0.5
local MURD_KW = {"knife","dagger","blade"}
local SHER_KW = {"gun","revolver","pistol"}
local function getRoleRaw(p)
    local c = p.Character; if not c then return "Innocent" end
    local function scan(ct)
        if not ct then return nil end
        for _, o in ipairs(ct:GetChildren()) do
            if o:IsA("Tool") then
                local n = o.Name:lower()
                for _, k in ipairs(MURD_KW) do if n:find(k) then return "Murderer" end end
                for _, k in ipairs(SHER_KW) do if n:find(k) then return "Sheriff" end end
            end
        end
    end
    return scan(c) or scan(p:FindFirstChildOfClass("Backpack")) or "Innocent"
end
local function getRole(p)
    local c = roleCache[p]; local now = tick()
    if c and now - c.time < ROLE_TTL then return c.role end
    local r = getRoleRaw(p)
    roleCache[p] = {role = r, time = now}
    return r
end
local function roleColor(r)
    if r == "Murderer" then return Config.ESP_Color_Murderer end
    if r == "Sheriff" then return Config.ESP_Color_Sheriff end
    return Config.ESP_Color_Innocent
end
Players.PlayerRemoving:Connect(function(p) roleCache[p] = nil end)

-- ============ FOV CIRCLES ============
local fovGui = Instance.new("ScreenGui")
fovGui.IgnoreGuiInset = true; fovGui.ResetOnSpawn = false
pcall(function() fovGui.Parent = game.CoreGui end)
local function mkCircle(color, size)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(0, size, 0, size)
    f.Position = UDim2.new(0.5, 0, 0.5, 0)
    f.AnchorPoint = Vector2.new(0.5, 0.5)
    f.BackgroundTransparency = 1
    f.Parent = fovGui
    local st = Instance.new("UIStroke", f)
    st.Thickness = 1.5; st.Color = color; st.Transparency = 0.3
    Instance.new("UICorner", f).CornerRadius = UDim.new(1, 0)
    return f
end
local fovCircle = mkCircle(Color3.fromRGB(0, 200, 255), Config.Aimbot_FOV * 2)
local trigCircle = mkCircle(Color3.fromRGB(255, 100, 100), Config.TriggerBot_FOV * 2)
local function screenCenter()
    return Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
end

-- ============ HELPERS ============
local function findTool(char, kw, player)
    if not char then return nil end
    for _, t in ipairs(char:GetChildren()) do
        if t:IsA("Tool") and t.Name:lower():find(kw) then return t end
    end
    if player then
        local bp = player:FindFirstChildOfClass("Backpack")
        if bp then
            for _, t in ipairs(bp:GetChildren()) do
                if t:IsA("Tool") and t.Name:lower():find(kw) then return t end
            end
        end
    end
end
local function isInPlayerInventory(o)
    for _, p in ipairs(Players:GetPlayers()) do
        local c = p.Character
        if c and o:IsDescendantOf(c) then return true end
        local bp = p:FindFirstChildOfClass("Backpack")
        if bp and o:IsDescendantOf(bp) then return true end
    end
end
local function hasLOS(from, to, tChar)
    local pr = RaycastParams.new()
    pr.FilterType = Enum.RaycastFilterType.Exclude
    pr.IgnoreWater = true
    local f = {}
    if LocalPlayer.Character then table.insert(f, LocalPlayer.Character) end
    if tChar then table.insert(f, tChar) end
    pr.FilterDescendantsInstances = f
    return workspace:Raycast(from, to - from, pr) == nil
end
local function myPos()
    local c = LocalPlayer.Character
    local h = c and c:FindFirstChild("HumanoidRootPart")
    return h and h.Position
end

-- ============ ATTACK ============
local attacking = false
local function attackWith(tool, tChar)
    if attacking or not tool then return end
    attacking = true
    task.spawn(function()
        local c = LocalPlayer.Character
        local h = c and c:FindFirstChildOfClass("Humanoid")
        if not c or not h then attacking = false return end
        if tChar then
            local t = tChar:FindFirstChild("HumanoidRootPart")
            local m = c:FindFirstChild("HumanoidRootPart")
            if t and m then
                m.CFrame = CFrame.new(t.Position)
                m.Velocity = Vector3.zero
            end
        end
        if tool.Parent ~= c then tool.Parent = c end
        if h:GetEquippedTool() ~= tool then pcall(function() h:EquipTool(tool) end) end
        task.wait(0.2)
        pcall(function() tool:Activate() end)
        task.wait(0.05)
        local bp = LocalPlayer:FindFirstChildOfClass("Backpack")
        if bp then pcall(function() tool.Parent = bp end) end
        attacking = false
    end)
end

-- ============ GUN DROP ============
local function isGunName(n)
    if not n then return false end
    n = tostring(n):lower()
    return n:find("gun") or n:find("revolver") or n:find("pistol")
        or n:find("weapon") or n:find("handgun") or n:find("firearm")
end
local function getGunContainer(o)
    if not o then return nil end
    if o:IsA("Tool") then return o:FindFirstChild("Handle") or o:FindFirstChildWhichIsA("BasePart")
    elseif o:IsA("BasePart") or o:IsA("MeshPart") then return o
    elseif o:IsA("Model") then return o.PrimaryPart or o:FindFirstChildWhichIsA("BasePart") end
end
local function getAllGunDrops()
    local list, seen = {}, {}
    local function add(o) if o and not seen[o] then seen[o] = true; list[#list+1] = o end end
    local n = workspace:FindFirstChild("Normal")
    if n then add(n:FindFirstChild("GunDrop")) end
    add(workspace:FindFirstChild("GunDrop"))
    if #list > 0 then return list end
    for _, o in ipairs(workspace:GetChildren()) do
        if (o:IsA("Tool") or o:IsA("Model")) and isGunName(o.Name) and not isInPlayerInventory(o) then add(o) end
    end
    return list
end
local function findGunOnGround() return getAllGunDrops()[1] end
local function getMap()
    for _, o in ipairs(workspace:GetChildren()) do
        if o:FindFirstChild("CoinContainer") and o:FindFirstChild("Spawns") then return o end
    end
end
local function findCoins()
    local out, seen = {}, {}
    local my = myPos(); if not my then return out end
    local mx = Config.ESP_CoinMaxDist * Config.ESP_CoinMaxDist
    local function add(o)
        if seen[o] or isInPlayerInventory(o) then return end
        local p = o.Position
        local dx, dy, dz = p.X - my.X, p.Y - my.Y, p.Z - my.Z
        if dx*dx + dy*dy + dz*dz > mx then return end
        seen[o] = true
        out[#out+1] = {obj = o, pos = p}
    end
    for _, n in ipairs({"Coins","Coin","CoinFolder","Money","Rewards","Pickups","Drops"}) do
        local f = workspace:FindFirstChild(n)
        if f then
            for _, o in ipairs(f:GetDescendants()) do
                if o:IsA("BasePart") or o:IsA("MeshPart") then add(o) end
            end
        end
    end
    if #out == 0 then
        for _, o in ipairs(workspace:GetDescendants()) do
            if o:IsA("BasePart") or o:IsA("MeshPart") then
                local n = o.Name:lower()
                if n:find("coin") or n:find("money") then add(o) end
            end
        end
    end
    return out
end

-- ============ ESP PLAYERS ============
local espCache, nameCache = {}, {}
local ESP_MAX = 400
local function dropHL(p) if espCache[p] then espCache[p]:Destroy(); espCache[p] = nil end end
local function dropNT(p) if nameCache[p] then nameCache[p]:Destroy(); nameCache[p] = nil end end
local function mkHL(p)
    local c = p.Character; if not c then return end
    local h = Instance.new("Highlight")
    h.Name = "MM2_ESP"; h.Adornee = c
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.FillTransparency = 0.5; h.OutlineTransparency = 0
    local col = roleColor(getRole(p))
    h.FillColor = col; h.OutlineColor = col
    h.Parent = c
    espCache[p] = h
end
local function mkNT(p)
    local c = p.Character; if not c then return end
    local head = c:FindFirstChild("Head"); if not head then return end
    if nameCache[p] then nameCache[p]:Destroy() end
    local bg = Instance.new("BillboardGui")
    bg.Size = UDim2.new(0, 160, 0, 22)
    bg.StudsOffset = Vector3.new(0, 3, 0)
    bg.Adornee = head
    bg.AlwaysOnTop = true
    bg.MaxDistance = ESP_MAX
    bg.Parent = head
    local l = Instance.new("TextLabel", bg)
    l.Size = UDim2.new(1, 0, 1, 0)
    l.BackgroundTransparency = 1
    l.Text = p.Name
    l.TextStrokeTransparency = 0
    l.TextScaled = true
    l.Font = Enum.Font.GothamBold
    l.TextColor3 = roleColor(getRole(p))
    nameCache[p] = bg
end
local function validHL(p)
    local h = espCache[p]; if not h or not h.Parent then return false end
    return h.Adornee == p.Character
end
local function validNT(p)
    local b = nameCache[p]; if not b or not b.Parent then return false end
    local h = p.Character and p.Character:FindFirstChild("Head")
    return b.Adornee == h
end
local function updatePlayers()
    local my = myPos()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local c = p.Character
            local hrp = c and c:FindFirstChild("HumanoidRootPart")
            local far = false
            if my and hrp then
                local d = hrp.Position - my
                if d.X*d.X + d.Y*d.Y + d.Z*d.Z > ESP_MAX*ESP_MAX then far = true end
            end
            if Config.ESP_Players and c and not far then
                if not validHL(p) then dropHL(p); mkHL(p) end
                if espCache[p] then
                    local col = roleColor(getRole(p))
                    if espCache[p].FillColor ~= col then
                        espCache[p].FillColor = col
                        espCache[p].OutlineColor = col
                    end
                end
            else dropHL(p) end
            if Config.ESP_Name and c and not far then
                if not validNT(p) then dropNT(p); mkNT(p) end
                if nameCache[p] then
                    local l = nameCache[p]:FindFirstChildOfClass("TextLabel")
                    local col = roleColor(getRole(p))
                    if l and l.TextColor3 ~= col then l.TextColor3 = col end
                end
            else dropNT(p) end
        end
    end
end

local gunESPCache = {}
local function updateGunESP()
    if not Config.ESP_Gun then
        for _, h in pairs(gunESPCache) do pcall(function() h:Destroy() end) end
        gunESPCache = {}; return
    end
    local my = myPos()
    local active = {}
    local mx = Config.ESP_GunMaxDist * Config.ESP_GunMaxDist
    for _, g in ipairs(getAllGunDrops()) do
        local h = getGunContainer(g) or g
        if h then
            local ok = true
            if my then
                local d = h.Position - my
                if d.X*d.X + d.Y*d.Y + d.Z*d.Z > mx then ok = false end
            end
            if ok then
                active[h] = true
                if not gunESPCache[h] or not gunESPCache[h].Parent then
                    if gunESPCache[h] then pcall(function() gunESPCache[h]:Destroy() end) end
                    local hl = Instance.new("Highlight")
                    hl.Adornee = h
                    hl.FillColor = Color3.fromRGB(255, 255, 0)
                    hl.OutlineColor = Color3.fromRGB(255, 255, 0)
                    hl.FillTransparency = 0.3
                    hl.OutlineTransparency = 0
                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    hl.Parent = h
                    gunESPCache[h] = hl
                end
            end
        end
    end
    for h, hl in pairs(gunESPCache) do
        if not active[h] or not h.Parent then
            pcall(function() hl:Destroy() end)
            gunESPCache[h] = nil
        end
    end
end
local coinESPCache = {}
local function updateCoinESP()
    if not Config.ESP_Coin then
        for _, h in pairs(coinESPCache) do pcall(function() h:Destroy() end) end
        coinESPCache = {}; return
    end
    local active = {}
    for _, c in ipairs(findCoins()) do
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
    for o, hl in pairs(coinESPCache) do
        if not active[o] or not o.Parent then
            pcall(function() hl:Destroy() end)
            coinESPCache[o] = nil
        end
    end
end

-- ============ AIMBOT / TRIGGER ============
local function validTarget(p, tc)
    if p == LocalPlayer then return false end
    local my = getRole(LocalPlayer)
    local t = getRole(p)
    if tc and my == t then return false end
    if my == "Murderer" then return t ~= "Murderer" end
    return t == "Murderer"
end
local function aimTarget(fov)
    local best, bestD = nil, math.huge
    local fs = fov * fov
    local cp = Camera.CFrame.Position
    local myC = LocalPlayer.Character
    local c = screenCenter()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local ch = p.Character
            local head = ch and ch:FindFirstChild("Head")
            if head and validTarget(p, Config.Aimbot_TeamCheck) then
                local sp, on = Camera:WorldToScreenPoint(head.Position)
                if on then
                    local dx, dy = sp.X - c.X, sp.Y - c.Y
                    local ds = dx*dx + dy*dy
                    if ds <= fs and ds < bestD then
                        local w = true
                        if Config.Aimbot_WallCheck then w = hasLOS(cp, head.Position, myC) end
                        if w then bestD = ds; best = ch end
                    end
                end
            end
        end
    end
    return best
end
local lastFire = 0
local function triggerTick()
    if not Config.TriggerBot or attacking then return end
    local now = tick()
    if not Config.TriggerBot_Instant and now - lastFire < Config.TriggerBot_Delay then return end
    local ch = LocalPlayer.Character; if not ch then return end
    local myRole = getRole(LocalPlayer)
    local tool, melee
    if myRole == "Murderer" then tool = findTool(ch, "knife", LocalPlayer); melee = true
    else tool = findTool(ch, "gun", LocalPlayer); melee = false end
    if not tool then return end
    local myHrp = ch:FindFirstChild("HumanoidRootPart"); if not myHrp then return end
    local mp = myHrp.Position
    local c = screenCenter()
    local cp = Camera.CFrame.Position
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local tC = p.Character
            local head = tC and tC:FindFirstChild("Head")
            local tHrp = tC and tC:FindFirstChild("HumanoidRootPart")
            if head and tHrp and validTarget(p, Config.TriggerBot_TeamCheck) then
                local dist = (tHrp.Position - mp).Magnitude
                local ok = melee and dist <= 18 or true
                if ok then
                    local sp, on = Camera:WorldToScreenPoint(head.Position)
                    if on then
                        local dx, dy = sp.X - c.X, sp.Y - c.Y
                        if dx*dx + dy*dy <= Config.TriggerBot_FOV * Config.TriggerBot_FOV then
                            local fire = true
                            if Config.TriggerBot_WallCheck then fire = hasLOS(cp, head.Position, ch) end
                            if fire then
                                if melee then attackWith(tool, tC)
                                else
                                    myHrp.CFrame = CFrame.lookAt(myHrp.Position, head.Position)
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

-- ============ AUTO KILL ============
local function nearestMurderer()
    local myC = LocalPlayer.Character
    local h = myC and myC:FindFirstChild("Head")
    if not h then return end
    local mp = h.Position
    local best, bestD = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local c = p.Character
            local th = c and c:FindFirstChild("Head")
            if th and getRole(p) == "Murderer" then
                local tp = th.Position
                local dx, dy, dz = tp.X - mp.X, tp.Y - mp.Y, tp.Z - mp.Z
                local d = dx*dx + dy*dy + dz*dz
                if d < bestD then
                    if not Config.AutoKill_WallCheck or hasLOS(mp, tp, c) then
                        bestD = d; best = c
                    end
                end
            end
        end
    end
    return best
end
local function nearestEnemy(r)
    local myC = LocalPlayer.Character
    local h = myC and myC:FindFirstChild("Head")
    if not h then return end
    local mp = h.Position
    local best, bestD = nil, r * r
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local c = p.Character
            local th = c and c:FindFirstChild("Head")
            if th and getRole(p) ~= "Murderer" then
                local tp = th.Position
                local dx, dy, dz = tp.X - mp.X, tp.Y - mp.Y, tp.Z - mp.Z
                local d = dx*dx + dy*dy + dz*dz
                if d <= bestD then
                    if not Config.AutoKill_WallCheck or hasLOS(mp, tp, c) then
                        bestD = d; best = c
                    end
                end
            end
        end
    end
    return best
end
local lastAK = 0
local function autoKillTick()
    local c = LocalPlayer.Character
    local h = c and c:FindFirstChildOfClass("Humanoid")
    if not c or not h or h.Health <= 0 then return end
    local myRole = getRole(LocalPlayer)
    if myRole == "Murderer" then
        if not Config.AutoKill_Murder then return end
        if tick() - lastAK < Config.AutoKill_Delay then return end
        local k = findTool(c, "knife", LocalPlayer); if not k then return end
        local e = nearestEnemy(Config.AutoKill_Range)
        if e and e:FindFirstChild("HumanoidRootPart") then
            attackWith(k, e); lastAK = tick()
        end
        return
    end
    if myRole == "Sheriff" or findTool(c, "gun", LocalPlayer) then
        if not Config.AutoKill_Sheriff then return end
        if tick() - lastAK < Config.AutoKill_Delay then return end
        local g = findTool(c, "gun", LocalPlayer); if not g then return end
        local m = nearestMurderer()
        if m and m:FindFirstChild("HumanoidRootPart") then
            local mh = c:FindFirstChild("HumanoidRootPart")
            local mhrp = m.HumanoidRootPart
            if mh and (mhrp.Position - mh.Position).Magnitude <= Config.AutoKill_GunRange then
                mh.CFrame = CFrame.lookAt(mh.Position, mhrp.Position)
                attackWith(g, nil); lastAK = tick()
            end
        end
    end
end

-- ============ INFINITE JUMP ============
local infJumps = 0
local infDeb = false
local infLanded = true
local infLandConn = nil
local function setupInfLand()
    if infLandConn then infLandConn:Disconnect() end
    local c = LocalPlayer.Character
    local h = c and c:FindFirstChildOfClass("Humanoid")
    if not h then return end
    infLandConn = h.StateChanged:Connect(function(_, s)
        if s == Enum.HumanoidStateType.Landed or s == Enum.HumanoidStateType.Running then
            infLanded = true
            infJumps = 0
        end
    end)
end
UserInputService.JumpRequest:Connect(function()
    if Config.InfiniteJump then
        local c = LocalPlayer.Character
        local h = c and c:FindFirstChildOfClass("Humanoid")
        if not h then return end
        if Config.InfJumpOnlyTwo and infJumps >= 2 and not infLanded then return end
        if not infDeb then
            infDeb = true
            h:ChangeState(Enum.HumanoidStateType.Jumping)
            infJumps = infJumps + 1
            infLanded = false
            task.wait(0.1)
            infDeb = false
        end
    end
end)

-- ============ HITBOX EXPANDER ============
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
                                local function exp(part)
                                    if part:IsA("BasePart") then
                                        if hbSaved[part] == nil then hbSaved[part] = part.Size end
                                        part.Size = Vector3.new(Config.HitboxSize, Config.HitboxSize, Config.HitboxSize)
                                        part.Massless = true
                                    end
                                end
                                if Config.HitboxAggressive then
                                    for _, part in ipairs(c:GetDescendants()) do exp(part) end
                                else
                                    for _, part in ipairs(c:GetDescendants()) do
                                        if part.Name == "Head" or part.Name:find("Torso") or part.Name == "HumanoidRootPart" then
                                            exp(part)
                                        end
                                    end
                                end
                            else
                                for _, part in ipairs(c:GetDescendants()) do
                                    if part:IsA("BasePart") and hbSaved[part] then
                                        part.Size = hbSaved[part]
                                        part.Massless = false
                                        hbSaved[part] = nil
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        else
            for part, sz in pairs(hbSaved) do
                if part and part.Parent then part.Size = sz; part.Massless = false end
            end
            hbSaved = setmetatable({}, {__mode = "k"})
        end
    end
end)

-- ============ FLING ============
local function skidFling(targetPlayer)
    if not targetPlayer then return end
    local Character = LocalPlayer.Character
    local Hum = Character and Character:FindFirstChildOfClass("Humanoid")
    local Root = Hum and Hum.RootPart
    local TC = targetPlayer.Character; if not TC then return end
    local TH = TC:FindFirstChildOfClass("Humanoid")
    local TR = TH and TH.RootPart
    local THead = TC:FindFirstChild("Head")
    local Acc = TC:FindFirstChildOfClass("Accessory")
    local Hnd = Acc and Acc:FindFirstChild("Handle")
    if not (Character and Hum and Root) then return end
    if Root.Velocity.Magnitude < 50 then getgenv().OldPos = Root.CFrame end
    if THead then workspace.CurrentCamera.CameraSubject = THead
    elseif Hnd then workspace.CurrentCamera.CameraSubject = Hnd
    elseif TH and TR then workspace.CurrentCamera.CameraSubject = TH end
    if not TC:FindFirstChildWhichIsA("BasePart") then return end
    local function FPos(bp, pos, ang)
        Root.CFrame = CFrame.new(bp.Position) * pos * ang
        Character:SetPrimaryPartCFrame(CFrame.new(bp.Position) * pos * ang)
        Root.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
        Root.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
    end
    local function SF(bp)
        local tWait = 2; local t = tick(); local a = 0
        repeat
            if Root and TH then
                if bp.Velocity.Magnitude < 50 then
                    a = a + 100
                    FPos(bp, CFrame.new(0, 1.5, 0) + TH.MoveDirection * bp.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(a), 0, 0)); task.wait()
                    FPos(bp, CFrame.new(0, -1.5, 0) + TH.MoveDirection * bp.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(a), 0, 0)); task.wait()
                    FPos(bp, CFrame.new(2.25, 1.5, -2.25) + TH.MoveDirection * bp.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(a), 0, 0)); task.wait()
                    FPos(bp, CFrame.new(-2.25, -1.5, 2.25) + TH.MoveDirection * bp.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(a), 0, 0)); task.wait()
                else
                    FPos(bp, CFrame.new(0, 1.5, TH.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0)); task.wait()
                    FPos(bp, CFrame.new(0, -1.5, -TH.WalkSpeed), CFrame.Angles(0, 0, 0)); task.wait()
                    FPos(bp, CFrame.new(0, 1.5, TR.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0)); task.wait()
                    FPos(bp, CFrame.new(0, -1.5, -TR.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0)); task.wait()
                end
            else break end
        until bp.Velocity.Magnitude > 500 or bp.Parent ~= TC
            or targetPlayer.Parent ~= Players or targetPlayer.Character ~= TC
            or TH.Sit or Hum.Health <= 0 or tick() > t + tWait
    end
    workspace.FallenPartsDestroyHeight = 0 / 0
    local bv = Instance.new("BodyVelocity")
    bv.Parent = Root
    bv.Velocity = Vector3.new(9e8, 9e8, 9e8)
    bv.MaxForce = Vector3.new(1 / 0, 1 / 0, 1 / 0)
    Hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    if TR and THead then
        if (TR.CFrame.p - THead.CFrame.p).Magnitude > 5 then SF(THead) else SF(TR) end
    elseif TR then SF(TR)
    elseif THead then SF(THead)
    elseif Acc and Hnd then SF(Hnd)
    else Rayfield:Notify({Title = "Fling", Content = "Sem parte valida", Duration = 3}) end
    bv:Destroy()
    Hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
    workspace.CurrentCamera.CameraSubject = Hum
    repeat
        Root.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
        Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
        Hum:ChangeState("GettingUp")
        for _, x in ipairs(Character:GetChildren()) do
            if x:IsA("BasePart") then x.Velocity = Vector3.zero; x.RotVelocity = Vector3.zero end
        end
        task.wait()
    until (Root.Position - getgenv().OldPos.p).Magnitude < 25
end

-- ============ CTRL+Click TP ============
local function rayHit()
    local m = LocalPlayer:GetMouse(); if not m then return end
    local ur = workspace.CurrentCamera:ScreenPointToRay(m.X, m.Y)
    local r = Ray.new(ur.Origin, ur.Direction * 1000)
    local p, pos = workspace:FindPartOnRay(r, LocalPlayer.Character)
    if p then return pos end
end
UserInputService.InputBegan:Connect(function(inp, proc)
    if proc then return end
    if Config.CtrlClickTP and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl)
        and inp.UserInputType == Enum.UserInputType.MouseButton1 then
        local pos = rayHit()
        if not pos then
            Rayfield:Notify({Title = "CTP", Content = "Nada pra tp", Duration = 3})
            return
        end
        local c = LocalPlayer.Character
        local h = c and c:FindFirstChild("HumanoidRootPart")
        if h then h.CFrame = CFrame.new(pos) end
    end
end)

-- ============ LOOP WS + FOV ============
RunService.RenderStepped:Connect(function()
    if Config.LoopWS_FOV then
        workspace.CurrentCamera.FieldOfView = Config.LoopFOV
        local c = LocalPlayer.Character
        local h = c and c:FindFirstChild("Humanoid")
        if h then h.WalkSpeed = Config.LoopWS end
    end
end)

-- ============ SPECTATE / AIM LOCK ============
local spectateLoop = nil
local function spectatePlayer(name)
    local list = Players:GetPlayers(); local idx = 1
    for i, p in ipairs(list) do if p.Name == name then idx = i; break end end
    local cp = list[idx]
    if not cp or not cp.Character then
        Rayfield:Notify({Title = "Spectate", Content = "Nao achou", Duration = 3})
        return
    end
    if spectateLoop then task.cancel(spectateLoop) end
    spectateLoop = task.spawn(function()
        while task.wait(0.5) do
            if not cp.Character or not cp.Character:FindFirstChildOfClass("Humanoid") then break end
            workspace.CurrentCamera.CameraSubject = cp.Character:FindFirstChildOfClass("Humanoid")
        end
    end)
end
local function stopSpectate()
    if spectateLoop then task.cancel(spectateLoop); spectateLoop = nil end
    local c = LocalPlayer.Character
    if c and c:FindFirstChildOfClass("Humanoid") then
        workspace.CurrentCamera.CameraSubject = c:FindFirstChildOfClass("Humanoid")
    end
end
local aimLockCon = nil
local function startAimLock(name)
    local t = Players:FindFirstChild(name)
    if not t then
        Rayfield:Notify({Title = "AimLock", Content = "Nao achou", Duration = 3})
        return
    end
    if aimLockCon then aimLockCon:Disconnect() end
    aimLockCon = RunService.RenderStepped:Connect(function()
        if not t.Character then return end
        local hrp = t.Character:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        local cam = workspace.CurrentCamera
        cam.CFrame = CFrame.new(cam.CFrame.Position, hrp.Position)
    end)
end
local function stopAimLock() if aimLockCon then aimLockCon:Disconnect(); aimLockCon = nil end end

-- ============ FPS BOOST ============
local function fpsBoost()
    local Ter = workspace:FindFirstChildOfClass('Terrain')
    if Ter then
        Ter.WaterWaveSize = 0; Ter.WaterWaveSpeed = 0
        Ter.WaterReflectance = 0; Ter.WaterTransparency = 0
    end
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    pcall(function() settings().Rendering.QualityLevel = 1 end)
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart")
            or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
            v.Material = "Plastic"; v.Reflectance = 0
        elseif v:IsA("Decal") then v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Lifetime = NumberRange.new(0)
        elseif v:IsA("Explosion") then v.BlastPressure = 1; v.BlastRadius = 1 end
    end
    for _, v in pairs(Lighting:GetDescendants()) do
        if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect")
            or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then v.Enabled = false end
    end
end

-- ============ LOOPS GERAIS ============
task.spawn(function()
    while task.wait(0.3) do
        if Config.AntiVoid then
            pcall(function()
                local c = LocalPlayer.Character
                local h = c and c:FindFirstChild("HumanoidRootPart")
                if h and h.Position.Y < -50 then
                    h.CFrame = CFrame.new(h.Position.X, 50, h.Position.Z)
                    h.Velocity = Vector3.zero
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
task.spawn(function() while task.wait(0.05) do if Config.TriggerBot then pcall(triggerTick) end end end)
task.spawn(function() while task.wait(0.10) do if Config.AutoKill_Murder or Config.AutoKill_Sheriff then pcall(autoKillTick) end end end)
task.spawn(function() while task.wait(0.35) do pcall(updatePlayers) end end)
task.spawn(function() while task.wait(0.50) do pcall(updateGunESP) end end)
task.spawn(function() while task.wait(1.00) do pcall(updateCoinESP) end end)

task.spawn(function()
    while task.wait(0.15) do
        if Config.AntiRagdoll then
            pcall(function()
                local c = LocalPlayer.Character
                local h = c and c:FindFirstChildOfClass("Humanoid")
                if h then
                    local s = h:GetState()
                    if s == Enum.HumanoidStateType.FallingDown or s == Enum.HumanoidStateType.Ragdoll
                        or s == Enum.HumanoidStateType.Physics then
                        h:ChangeState(Enum.HumanoidStateType.GettingUp)
                        h.PlatformStand = false
                        local hrp = c:FindFirstChild("HumanoidRootPart")
                        if hrp then hrp.AssemblyAngularVelocity = Vector3.zero end
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
                    local h = c and c:FindFirstChildOfClass("Humanoid")
                    if h then
                        local prev = killHP[p]
                        if prev and prev > 0 and h.Health <= 0 then
                            Rayfield:Notify({Title = "Kill", Content = p.Name.." ("..getRole(p)..") morreu", Duration = 4})
                        end
                        killHP[p] = h.Health
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
                local hrp = c and c:FindFirstChild("HumanoidRootPart")
                local h = c and c:FindFirstChildOfClass("Humanoid")
                if not hrp or not h or h.Health <= 0 then return end
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and getRole(p) == "Murderer" then
                        local tH = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
                        if tH then
                            local diff = hrp.Position - tH.Position
                            local d = diff.Magnitude
                            if d < 18 and d > 1 then
                                hrp.Velocity = diff.Unit * 90 + Vector3.new(0, 35, 0)
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- Radar
local radarGui = Instance.new("ScreenGui")
radarGui.ResetOnSpawn = false; radarGui.IgnoreGuiInset = true
pcall(function() radarGui.Parent = game.CoreGui end)
local radarFrame = Instance.new("Frame", radarGui)
radarFrame.Size = UDim2.fromOffset(140, 140)
radarFrame.Position = UDim2.new(0.5, -70, 0, 10)
radarFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
radarFrame.BackgroundTransparency = 0.6
radarFrame.BorderSizePixel = 0
radarFrame.Visible = false
Instance.new("UICorner", radarFrame).CornerRadius = UDim.new(1, 0)
local radarMe = Instance.new("Frame", radarFrame)
radarMe.Size = UDim2.fromOffset(6, 6)
radarMe.Position = UDim2.new(0.5, -3, 0.5, -3)
radarMe.BackgroundColor3 = Color3.new(1, 1, 1)
radarMe.BorderSizePixel = 0
Instance.new("UICorner", radarMe).CornerRadius = UDim.new(1, 0)
local radarDots = {}
local RADAR_R = 200
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
                        local tH = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
                        if tH then
                            local rel = tH.Position - my
                            if rel.Magnitude <= RADAR_R then
                                local rx = rel.X * math.cos(-angle) - rel.Z * math.sin(-angle)
                                local rz = rel.X * math.sin(-angle) + rel.Z * math.cos(-angle)
                                local px = (rx / RADAR_R) * 60 + 70
                                local py = -(rz / RADAR_R) * 60 + 70
                                local dot = radarDots[p]
                                if not dot then
                                    dot = Instance.new("Frame", radarFrame)
                                    dot.Size = UDim2.fromOffset(8, 8)
                                    dot.BorderSizePixel = 0
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
                    if not used[p] then dot:Destroy(); radarDots[p] = nil end
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
                            local tH = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
                            if tH then
                                local d = (tH.Position - hrp.Position).Magnitude
                                if d <= Config.MurdererAlertRange and lastMD > Config.MurdererAlertRange then
                                    Rayfield:Notify({Title = "Alerta", Content = "Murderer perto: "..math.floor(d).." studs", Duration = 4})
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
                        local head = p.Character and p.Character:FindFirstChild("Head")
                        if head then
                            local des = CFrame.lookAt(Camera.CFrame.Position, head.Position)
                            Camera.CFrame = Camera.CFrame:Lerp(des, 0.3)
                        end
                        break
                    end
                end
            end)
        end
    end
end)

-- ============ MM2 EXTRAS ============
local function shootMurderer(silent)
    if findSheriff() ~= LocalPlayer and not silent then
        Rayfield:Notify({Title = "Shoot", Content = "Voce nao e sheriff", Duration = 3})
        return
    end
    local m = findMurderer(); if not m then return end
    local mHrp = m.Character and m.Character:FindFirstChild("HumanoidRootPart")
    if not mHrp then return end
    local c = LocalPlayer.Character
    local h = c:FindFirstChildOfClass("Humanoid")
    if not c:FindFirstChild("Gun") then
        local bk = LocalPlayer.Backpack:FindFirstChild("Gun")
        if bk then h:EquipTool(bk) else return end
    end
    local args
    if Config.InstakillShoot then
        args = {CFrame.new(mHrp.Position + Vector3.new(0, 1, 0)), CFrame.new(mHrp.Position)}
    else
        args = {CFrame.new(c.RightHand.Position), CFrame.new(mHrp.Position)}
    end
    c:WaitForChild("Gun"):WaitForChild("Shoot"):FireServer(unpack(args))
end

local function knifeThrow(silent)
    if findMurderer() ~= LocalPlayer then
        if silent then return end
        Rayfield:Notify({Title = "Knife", Content = "Voce nao e murderer", Duration = 3})
        return
    end
    local c = LocalPlayer.Character
    if not c:FindFirstChild("Knife") then
        local bk = LocalPlayer.Backpack:FindFirstChild("Knife")
        if bk then c:FindFirstChildOfClass("Humanoid"):EquipTool(bk)
        else
            if silent then return end
            Rayfield:Notify({Title = "Knife", Content = "Sem faca", Duration = 3})
            return
        end
    end
    local np = findNearestPlayer()
    if not np or not np.Character then return end
    local tH = np.Character:FindFirstChild("HumanoidRootPart"); if not tH then return end
    local a1 = CFrame.new(c.RightHand.Position)
    local a2 = CFrame.new(tH.Position + tH.AssemblyLinearVelocity * 0.5)
    if Config.SpawnKnifeNearPlayer then
        a1 = CFrame.new(tH.Position + tH.CFrame.LookVector * 5)
    end
    c:WaitForChild("Knife"):WaitForChild("Events"):WaitForChild("KnifeThrown"):FireServer(a1, a2)
end
task.spawn(function() while task.wait(1.5) do if Config.AutoKnifeThrow then knifeThrow(true) end end end)

local killAuraCon = nil
local function setKillAura(on)
    if on and not killAuraCon then
        killAuraCon = RunService.Heartbeat:Connect(function()
            if findMurderer() ~= LocalPlayer then return end
            local c = LocalPlayer.Character
            if not c or not c:FindFirstChild("Knife") then return end
            local mp = myPos(); if not mp then return end
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local h = p.Character:FindFirstChild("HumanoidRootPart")
                    if h and (h.Position - mp).Magnitude < 7 then
                        h.Anchored = true
                        h.CFrame = c:FindFirstChild("HumanoidRootPart").CFrame + c:FindFirstChild("HumanoidRootPart").CFrame.LookVector * 2
                        task.wait(0.1)
                        c.Knife.Stab:FireServer("Slash")
                        return
                    end
                end
            end
        end)
    elseif not on and killAuraCon then
        killAuraCon:Disconnect(); killAuraCon = nil
    end
end

workspace.ChildAdded:Connect(function(ch)
    if ch.Name == "ThrowingKnife" and Config.IgnoreKnifeThrows then
        task.wait()
        ch:Destroy()
    end
end)

workspace.DescendantAdded:Connect(function(ch)
    if ch.Name == "GunDrop" and Config.AutoGetDroppedGun then
        task.wait(1)
        local map = getMap(); if not map then return end
        if Config.GunDropTakeExp then
            local c = LocalPlayer.Character
            local rp = c and c:FindFirstChild("HumanoidRootPart")
            local gd = map:FindFirstChild("GunDrop")
            if gd and rp and firetouchinterest then
                local tp = gd:FindFirstChild("Handle") or gd
                gd:PivotTo(rp.CFrame)
                firetouchinterest(rp, tp, 0); task.wait(); firetouchinterest(rp, tp, 1)
            end
            return
        end
        local gd = map:FindFirstChild("GunDrop")
        if gd then
            local c = LocalPlayer.Character
            if c then
                local prev = c:GetPivot()
                c:MoveTo(gd.Position)
                LocalPlayer.Backpack.ChildAdded:Wait()
                c:PivotTo(prev)
            end
        end
    end
end)

-- ============ PERFORMANCE ============
local perfSaved = {}
local matSaved = setmetatable({}, {__mode = "k"})
local shadowSaved = setmetatable({}, {__mode = "k"})
local perfState = {nofog = false, noshadow = false, smooth = false, bright = false}
local function saveL(k, props)
    if perfSaved[k] then return end
    perfSaved[k] = {}
    for _, p in ipairs(props) do perfSaved[k][p] = Lighting[p] end
end
local function restL(k)
    if not perfSaved[k] then return end
    for p, v in pairs(perfSaved[k]) do pcall(function() Lighting[p] = v end) end
    perfSaved[k] = nil
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
workspace.DescendantAdded:Connect(function(o)
    if perfState.noshadow or perfState.smooth then pcall(applyPart, o) end
end)
local function restMats()
    for o, m in pairs(matSaved) do
        if o and o.Parent then pcall(function() o.Material = m end) end
    end
end
local function restShadows()
    for o, s in pairs(shadowSaved) do
        if o and o.Parent then pcall(function() o.CastShadow = s end) end
    end
end
local function bulkApply()
    task.spawn(function()
        local n = 0
        for _, o in ipairs(workspace:GetDescendants()) do
            if o:IsA("BasePart") then
                applyPart(o)
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
                saveL("bright", {"Brightness", "Ambient", "OutdoorAmbient", "ClockTime"})
                Lighting.Brightness = 3; Lighting.ClockTime = 14
                Lighting.Ambient = Color3.fromRGB(200, 200, 200)
                Lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 200)
                perfState.bright = true
            elseif not Config.Perf_FullBright and perfState.bright then
                restL("bright"); perfState.bright = false
            end
            if Config.Perf_NoFog and not perfState.nofog then
                saveL("fog", {"FogEnd", "FogStart", "FogColor"})
                Lighting.FogEnd = 100000; Lighting.FogStart = 100000
                perfState.nofog = true
            elseif not Config.Perf_NoFog and perfState.nofog then
                restL("fog"); perfState.nofog = false
            end
            if Config.Perf_NoShadow and not perfState.noshadow then
                saveL("shadow", {"GlobalShadows"})
                Lighting.GlobalShadows = false
                perfState.noshadow = true
                bulkApply()
            elseif not Config.Perf_NoShadow and perfState.noshadow then
                restL("shadow"); restShadows(); perfState.noshadow = false
            end
            if Config.Perf_SmoothTexture and not perfState.smooth then
                perfState.smooth = true; bulkApply()
            elseif not Config.Perf_SmoothTexture and perfState.smooth then
                restMats(); perfState.smooth = false
            end
        end)
    end
end)

-- ============ ANTI-FLING ============
pcall(function() PhysicsService:RegisterCollisionGroup("MM2_Self") end)
pcall(function() PhysicsService:RegisterCollisionGroup("MM2_Others") end)
pcall(function() PhysicsService:CollisionGroupSetCollidable("MM2_Self", "MM2_Others", false) end)
local function applySelf(p)
    if p:IsA("BasePart") and p.CollisionGroup ~= "MM2_Self" then
        pcall(function() p.CollisionGroup = "MM2_Self" end)
    end
end
local function applyOther(p)
    if p:IsA("BasePart") and p.CollisionGroup ~= "MM2_Others" then
        pcall(function() p.CollisionGroup = "MM2_Others" end)
    end
end
local function setSelf()
    local c = LocalPlayer.Character; if not c then return end
    for _, p in ipairs(c:GetDescendants()) do applySelf(p) end
end
local function setOthers()
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= LocalPlayer and pl.Character then
            for _, p in ipairs(pl.Character:GetDescendants()) do applyOther(p) end
        end
    end
end
local function restGroups()
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
    local c = LocalPlayer.Character; if not c then return end
    local hrp = c:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5, 1, 1) end
    pcall(setSelf); pcall(setOthers)
end
RunService.Heartbeat:Connect(function()
    if not Config.AntiFling then return end
    pcall(function()
        local c = LocalPlayer.Character; if not c then return end
        local hrp = c:FindFirstChild("HumanoidRootPart")
        local h = c:FindFirstChildOfClass("Humanoid")
        if not hrp or not h or h.Health <= 0 then return end
        if not hrp.CustomPhysicalProperties or hrp.CustomPhysicalProperties.Density ~= 0.7 then
            hrp.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5, 1, 1)
        end
        local v = hrp.AssemblyLinearVelocity
        local hv = Vector3.new(v.X, 0, v.Z).Magnitude
        local a = hrp.AssemblyAngularVelocity.Magnitude
        if hv > 160 or v.Y > 80 or a > 40 then
            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero
            hrp.Velocity = Vector3.zero
            hrp.RotVelocity = Vector3.zero
            local s = h:GetState()
            if s == Enum.HumanoidStateType.FallingDown or s == Enum.HumanoidStateType.Ragdoll
                or s == Enum.HumanoidStateType.Physics then
                h:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
            h.PlatformStand = false
        end
    end)
end)

-- ============ INVISIBLE ============
local invisSeat, invisOn, invisToggleUI = nil, false, nil
local function invisCleanup()
    local e = workspace:FindFirstChild("invischair")
    if e then e:Destroy() end
    invisSeat = nil
end
local function invisOnFn()
    local c = LocalPlayer.Character; if not c then return end
    local hrp = c:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    invisCleanup()
    local saved = hrp.CFrame
    local tp = Vector3.new(0, Config.InvisibleY, 0)
    c:MoveTo(tp); task.wait(0.15)
    local seat = Instance.new("Seat")
    seat.Name = "invischair"; seat.Anchored = false; seat.CanCollide = false
    seat.Transparency = 1; seat.Position = tp; seat.Parent = workspace
    invisSeat = seat
    local w = Instance.new("Weld")
    w.Part0 = seat; w.Part1 = c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso")
    w.Parent = seat
    task.wait()
    seat.CFrame = saved
    for _, d in ipairs(c:GetDescendants()) do
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
local function setInvisible(v)
    if invisOn == v then return end
    invisOn = v; Config.Invisible = v
    if v then task.spawn(invisOnFn) else invisOff() end
end
task.spawn(function()
    while task.wait(0.5) do
        if invisOn and (not invisSeat or not invisSeat.Parent) then
            invisOn = false; Config.Invisible = false; invisOff()
            if invisToggleUI then pcall(function() invisToggleUI:Set(false) end) end
        end
    end
end)

-- ============ GRAB GUN ============
local grabbing = false
local function grabGun()
    if grabbing then return false end
    local c = LocalPlayer.Character; if not c then return false end
    local hrp = c:FindFirstChild("HumanoidRootPart")
    local h = c:FindFirstChildOfClass("Humanoid")
    if not hrp or not h then return false end
    for _, t in ipairs(c:GetChildren()) do
        if t:IsA("Tool") and t.Name:lower():find("gun") then return false end
    end
    local g = findGunOnGround(); if not g then return false end
    local handle = getGunContainer(g) or g
    if not handle or not handle:IsA("BasePart") then return false end
    grabbing = true
    local oc = hrp.CFrame; local ov = hrp.Velocity
    pcall(function() c:PivotTo(CFrame.new(handle.Position + Vector3.new(0, 2, 0))) end)
    hrp.Velocity = Vector3.zero
    task.wait(0.1)
    if firetouchinterest then
        local parts = {hrp}
        for _, p in ipairs(c:GetDescendants()) do
            if p:IsA("BasePart") then table.insert(parts, p) end
        end
        for _, part in ipairs(parts) do
            pcall(function()
                firetouchinterest(part, handle, 0); task.wait(); firetouchinterest(part, handle, 1)
            end)
        end
    end
    local prompt = g:FindFirstChildOfClass("ProximityPrompt")
    if prompt and fireproximityprompt then pcall(function() fireproximityprompt(prompt) end) end
    local cd = g:FindFirstChildOfClass("ClickDetector")
    if cd and fireclickdetector then pcall(function() fireclickdetector(cd) end) end
    task.wait(0.15)
    if hrp.Parent then hrp.CFrame = oc; hrp.Velocity = ov end
    grabbing = false
    return true
end
task.spawn(function()
    while task.wait(Config.AutoGrabGun_Delay) do
        pcall(function()
            if Config.AutoGrabGun and not grabbing then
                local c = LocalPlayer.Character
                if c and getRole(LocalPlayer) ~= "Murderer" then
                    local has = false
                    for _, t in ipairs(c:GetChildren()) do
                        if t:IsA("Tool") and t.Name:lower():find("gun") then has = true; break end
                    end
                    if not has and findGunOnGround() then pcall(grabGun) end
                end
            end
        end)
    end
end)

LocalPlayer.CharacterAdded:Connect(function(ch)
    task.wait(1)
    local h = ch:FindFirstChildOfClass("Humanoid")
    if h then
        h.WalkSpeed = Config.Speed
        h.UseJumpPower = true
        h.JumpPower = Config.JumpPower
    end
    invisOn = false; Config.Invisible = false; invisCleanup()
    if invisToggleUI then pcall(function() invisToggleUI:Set(false) end) end
    if Config.AntiFling then task.wait(0.5); enableAntiFling() end
    setupInfLand()
end)

-- ============ TELEPORT HELPERS ============
local function teleportTo(pos)
    local c = LocalPlayer.Character
    local hrp = c and c:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame = CFrame.new(pos + Vector3.new(0, 5, 0)); hrp.Velocity = Vector3.zero end
end
local function findObby()
    for _, o in ipairs(workspace:GetDescendants()) do
        if o:IsA("BasePart") and o.Name:lower():find("obby") then return o.Position end
    end
end
local function mapCenter()
    local s, n = Vector3.zero, 0
    for _, p in ipairs(Players:GetPlayers()) do
        local c = p.Character
        if c and c:FindFirstChild("HumanoidRootPart") then
            s = s + c.HumanoidRootPart.Position; n = n + 1
        end
    end
    return n > 0 and s / n or Vector3.new(0, 10, 0)
end

-- ============ RENDERSTEPPED ============
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
                    local des = CFrame.lookAt(Camera.CFrame.Position, head.Position)
                    local s = Config.Aimbot_Instant and 1 or Config.Aimbot_Smoothness
                    Camera.CFrame = Camera.CFrame:Lerp(des, s)
                end
            end
        end
    end
    if Config.Fly then
        local c = LocalPlayer.Character
        local hrp = c and c:FindFirstChild("HumanoidRootPart")
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
end)

-- ============================================================
-- UI — 5 ABAS (Visual | Aimbot | Combat | Player | Misc)
-- ============================================================
local Window = Rayfield:CreateWindow({
    Name = "MM2 Hub v3 + YARHM",
    LoadingTitle = "Carregando",
    LoadingSubtitle = "MM2 completo",
    ConfigurationSaving = {Enabled = false},
    Keybind = Enum.KeyCode.RightControl,
    Theme = "DarkBlue",
})

-- ABA 1: VISUAL
local VTab = Window:CreateTab("Visual", 4483362458)
VTab:CreateToggle({Name = "ESP Players", CurrentValue = false, Callback = function(v)
    Config.ESP_Players = v
    if not v then for p in pairs(espCache) do dropHL(p) end end
end})
VTab:CreateToggle({Name = "ESP Nome", CurrentValue = false, Callback = function(v)
    Config.ESP_Name = v
    if not v then for p in pairs(nameCache) do dropNT(p) end end
end})
VTab:CreateToggle({Name = "ESP Gun", CurrentValue = false, Callback = function(v) Config.ESP_Gun = v end})
VTab:CreateSlider({Name = "ESP Gun Dist", Range = {50, 2000}, Increment = 10, Suffix = " studs",
    CurrentValue = 500, Callback = function(v) Config.ESP_GunMaxDist = v end})
VTab:CreateToggle({Name = "ESP Coin", CurrentValue = false, Callback = function(v) Config.ESP_Coin = v end})
VTab:CreateSlider({Name = "ESP Coin Dist", Range = {30, 500}, Increment = 10, Suffix = " studs",
    CurrentValue = 150, Callback = function(v) Config.ESP_CoinMaxDist = v end})
VTab:CreateToggle({Name = "Radar HUD", CurrentValue = false, Callback = function(v) Config.RadarHUD = v end})
VTab:CreateToggle({Name = "Hitbox Expander", CurrentValue = false, Callback = function(v) Config.HitboxExpander = v end})
VTab:CreateToggle({Name = "Hitbox Agressivo", CurrentValue = false, Callback = function(v) Config.HitboxAggressive = v end})
VTab:CreateSlider({Name = "Tamanho Hitbox", Range = {2, 20}, Increment = 1, CurrentValue = 5, Callback = function(v) Config.HitboxSize = v end})
VTab:CreateSlider({Name = "Hitbox Range", Range = {50, 500}, Increment = 10, CurrentValue = 200, Callback = function(v) Config.HitboxMaxDist = v end})
VTab:CreateToggle({Name = "Camera segue Murderer", CurrentValue = false, Callback = function(v) Config.LockCameraMurderer = v end})

-- ABA 2: AIMBOT
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
ATab:CreateInput({Name = "Aim Lock Target", CurrentValue = "", Placeholder = "Nome",
    Callback = function(v) if v and v ~= "" then startAimLock(v) end end})
ATab:CreateButton({Name = "Parar Aim Lock", Callback = function() stopAimLock() end})

-- ABA 3: COMBAT
local CTab = Window:CreateTab("Combat", 4483362458)
CTab:CreateButton({Name = "Kill All", Callback = function()
    local c = LocalPlayer.Character
    local k = findTool(c, "knife", LocalPlayer)
    if not k then Rayfield:Notify({Title = "Kill All", Content = "Precisa ser Murderer", Duration = 3}); return end
    task.spawn(function()
        local myH = c:FindFirstChild("HumanoidRootPart"); if not myH then return end
        local sv = myH.CFrame; local n = 0
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                local tC = p.Character
                local tH = tC and tC:FindFirstChild("HumanoidRootPart")
                local h = tC and tC:FindFirstChildOfClass("Humanoid")
                if tH and h and h.Health > 0 then
                    myH.CFrame = CFrame.new(tH.Position); myH.Velocity = Vector3.zero
                    task.wait(0.2)
                    if k.Parent ~= c then k.Parent = c end
                    local h2 = c:FindFirstChildOfClass("Humanoid")
                    if h2 and h2:GetEquippedTool() ~= k then
                        pcall(function() h2:EquipTool(k) end); task.wait(0.1)
                    end
                    pcall(function() k:Activate() end); task.wait(0.15); n = n + 1
                end
            end
        end
        myH.CFrame = sv
        local bp = LocalPlayer:FindFirstChildOfClass("Backpack")
        if bp then pcall(function() k.Parent = bp end) end
        Rayfield:Notify({Title = "Kill All", Content = "Tentei: "..n, Duration = 4})
    end)
end})
CTab:CreateToggle({Name = "Auto Kill Faca (murderer)", CurrentValue = false, Callback = function(v) Config.AutoKill_Murder = v end})
CTab:CreateToggle({Name = "Auto Kill Arma (sheriff)", CurrentValue = false, Callback = function(v) Config.AutoKill_Sheriff = v end})
CTab:CreateToggle({Name = "Wall Check", CurrentValue = true, Callback = function(v) Config.AutoKill_WallCheck = v end})
CTab:CreateSlider({Name = "Alcance Faca", Range = {5, 50}, Increment = 1, CurrentValue = 25, Callback = function(v) Config.AutoKill_Range = v end})
CTab:CreateSlider({Name = "Alcance Tiro", Range = {50, 1000}, Increment = 10, CurrentValue = 500, Callback = function(v) Config.AutoKill_GunRange = v end})
CTab:CreateSlider({Name = "Delay", Range = {0.1, 1.0}, Increment = 0.05, CurrentValue = 0.5, Callback = function(v) Config.AutoKill_Delay = v end})
CTab:CreateButton({Name = "Shoot murderer (1x)", Callback = function() task.spawn(function() shootMurderer() end) end})
CTab:CreateToggle({Name = "Instakill (shoot)", CurrentValue = false, Callback = function(v) Config.InstakillShoot = v end})
CTab:CreateButton({Name = "Knife throw to closest", Callback = function() task.spawn(function() knifeThrow() end) end})
CTab:CreateToggle({Name = "Auto knife throw", CurrentValue = false, Callback = function(v) Config.AutoKnifeThrow = v end})
CTab:CreateToggle({Name = "Spawn knife near target", CurrentValue = false, Callback = function(v) Config.SpawnKnifeNearPlayer = v end})
CTab:CreateToggle({Name = "Murderer Kill Aura", CurrentValue = false, Callback = function(v) setKillAura(v) end})
CTab:CreateButton({Name = "Kill closest (murderer)", Callback = function()
    if findMurderer() ~= LocalPlayer then Rayfield:Notify({Title = "Kill", Content = "Nao e murderer", Duration = 3}); return end
    local c = LocalPlayer.Character
    if not c:FindFirstChild("Knife") then
        local bk = LocalPlayer.Backpack:FindFirstChild("Knife")
        if bk then c:FindFirstChildOfClass("Humanoid"):EquipTool(bk) else return end
    end
    local np = findNearestPlayer(); if not np or not np.Character then return end
    local tH = np.Character:FindFirstChild("HumanoidRootPart")
    if tH and c:FindFirstChild("HumanoidRootPart") then
        tH.Anchored = true
        tH.CFrame = c.HumanoidRootPart.CFrame + c.HumanoidRootPart.CFrame.LookVector * 2
        task.wait(0.1); c.Knife.Stab:FireServer("Slash")
    end
end})
CTab:CreateButton({Name = "Kill EVERYONE (murderer)", Callback = function()
    if findMurderer() ~= LocalPlayer then Rayfield:Notify({Title = "Kill", Content = "Nao e murderer", Duration = 3}); return end
    local c = LocalPlayer.Character
    if not c:FindFirstChild("Knife") then
        local bk = LocalPlayer.Backpack:FindFirstChild("Knife")
        if bk then c:FindFirstChildOfClass("Humanoid"):EquipTool(bk) else return end
    end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local h = p.Character:FindFirstChild("HumanoidRootPart")
            if h then h.Anchored = true; h.CFrame = c.HumanoidRootPart.CFrame + c.HumanoidRootPart.CFrame.LookVector * 1 end
        end
    end
    c.Knife.Stab:FireServer("Slash")
end})
CTab:CreateButton({Name = "Hold everyone hostage", Callback = function()
    if findMurderer() ~= LocalPlayer then Rayfield:Notify({Title = "Hold", Content = "Nao e murderer", Duration = 3}); return end
    local c = LocalPlayer.Character
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local h = p.Character:FindFirstChild("HumanoidRootPart")
            if h then h.Anchored = true; h.CFrame = c.HumanoidRootPart.CFrame + c.HumanoidRootPart.CFrame.LookVector * 5 end
        end
    end
    Rayfield:Notify({Title = "Hold", Content = "Todos no mesmo lugar!", Duration = 4})
end})
CTab:CreateButton({Name = "Chat: Sheriff + Murderer", Callback = function()
    local tc = game:GetService("TextChatService"):WaitForChild("TextChannels")
    for _, ch in ipairs(tc:GetChildren()) do
        if ch.Name ~= "RBXSystem" then
            local m = findMurderer(); local s = findSheriff()
            local mn = m and m.Name or "-"; local sn = s and s.Name or "-"
            ch:SendAsync("Murderer: "..mn.." | Sheriff: "..sn.." | <<YARHM>>")
        end
    end
end})
CTab:CreateInput({Name = "Fling Target", CurrentValue = "", Placeholder = "Nome", Callback = function(v)
    if not v or v == "" then return end
    local t = Players:FindFirstChild(v)
    if not t then Rayfield:Notify({Title = "Fling", Content = "Nao achou", Duration = 3}); return end
    Config.FlingTarget = t
    Rayfield:Notify({Title = "Fling", Content = "Alvo: "..t.Name, Duration = 3})
end})
CTab:CreateButton({Name = "Fling (target)", Callback = function()
    if not Config.FlingTarget then Rayfield:Notify({Title = "Fling", Content = "Escolha alvo", Duration = 3}); return end
    task.spawn(function() skidFling(Config.FlingTarget) end)
end})
CTab:CreateButton({Name = "Fling Sheriff", Callback = function()
    local s = findSheriff(); if not s then Rayfield:Notify({Title = "Fling", Content = "Sem sheriff", Duration = 3}); return end
    task.spawn(function() skidFling(s) end)
end})
CTab:CreateButton({Name = "Fling Murderer", Callback = function()
    local m = findMurderer(); if not m then Rayfield:Notify({Title = "Fling", Content = "Sem murderer", Duration = 3}); return end
    task.spawn(function() skidFling(m) end)
end})
CTab:CreateButton({Name = "Grab Gun", Callback = function()
    local ok = grabGun()
    Rayfield:Notify({Title = "Grab Gun", Content = ok and "Pegou" or "Nada", Duration = 3})
end})
CTab:CreateToggle({Name = "Auto Grab Gun", CurrentValue = false, Callback = function(v) Config.AutoGrabGun = v end})
CTab:CreateToggle({Name = "Auto Get Dropped Gun", CurrentValue = false, Callback = function(v) Config.AutoGetDroppedGun = v end})
CTab:CreateToggle({Name = "Exp. take via touch", CurrentValue = false, Callback = function(v) Config.GunDropTakeExp = v end})
CTab:CreateButton({Name = "Teleport to dropped gun", Callback = function()
    local map = getMap(); if not map then return end
    local g = map:FindFirstChild("GunDrop")
    if not g then Rayfield:Notify({Title = "TP", Content = "Sem gun drop", Duration = 3}); return end
    local c = LocalPlayer.Character; if not c then return end
    if Config.GunDropTakeExp then
        local rp = c:FindFirstChild("HumanoidRootPart")
        if rp and firetouchinterest then
            local tp = g:FindFirstChild("Handle") or g
            g:PivotTo(rp.CFrame)
            firetouchinterest(rp, tp, 0); task.wait(); firetouchinterest(rp, tp, 1)
        end
        return
    end
    local prev = c:GetPivot()
    c:MoveTo(g.Position)
    LocalPlayer.Backpack.ChildAdded:Wait()
    c:PivotTo(prev)
end})
CTab:CreateButton({Name = "Copy sheriff username", Callback = function()
    local s = findSheriff()
    if s and setclipboard then setclipboard(s.Name) end
end})
CTab:CreateButton({Name = "Copy murderer username", Callback = function()
    local m = findMurderer()
    if m and setclipboard then setclipboard(m.Name) end
end})
CTab:CreateToggle({Name = "Anti-Fling", CurrentValue = false, Callback = function(v)
    Config.AntiFling = v
    if v then enableAntiFling() else pcall(restGroups) end
end})

-- ABA 4: PLAYER
local PTab = Window:CreateTab("Player", 4483362458)
PTab:CreateSlider({Name = "Speed", Range = {16, 200}, Increment = 1, CurrentValue = 16, Callback = function(v)
    Config.Speed = v
    local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if h then h.WalkSpeed = v end
end})
PTab:CreateSlider({Name = "Jump Power", Range = {50, 300}, Increment = 5, CurrentValue = 50, Callback = function(v)
    Config.JumpPower = v
    local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if h then h.UseJumpPower = true; h.JumpPower = v end
end})
PTab:CreateToggle({Name = "Pulo Infinito [J]", CurrentValue = false, Callback = function(v)
    Config.InfiniteJump = v
    if v then setupInfLand() end
end})
PTab:CreateToggle({Name = "Limitar a 2 pulos", CurrentValue = false, Callback = function(v) Config.InfJumpOnlyTwo = v end})
PTab:CreateToggle({Name = "Anti Void [V]", CurrentValue = false, Callback = function(v) Config.AntiVoid = v end})
PTab:CreateToggle({Name = "Fly Simples [F]", CurrentValue = false, Callback = function(v)
    Config.Fly = v
    if not v then
        local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if h then h.Velocity = Vector3.zero end
    end
end})
PTab:CreateSlider({Name = "Fly Speed", Range = {10, 200}, Increment = 5, CurrentValue = 50, Callback = function(v) Config.FlySpeed = v end})
PTab:CreateToggle({Name = "OP Fly (YARHM)", CurrentValue = false, Callback = function(v)
    Config.OPFly = v
    if v then FlyUtil:Start() else FlyUtil:Stop() end
end})
PTab:CreateSlider({Name = "OP Fly Speed", Range = {10, 500}, Increment = 5, CurrentValue = 50, Callback = function(v) FlyUtil:SetMaxSpeed(v) end})
PTab:CreateToggle({Name = "Noclip [N]", CurrentValue = false, Callback = function(v)
    Config.Noclip = v
    if not v then
        local c = LocalPlayer.Character
        if c then
            for _, p in ipairs(c:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = true end
            end
        end
    end
end})
invisToggleUI = PTab:CreateToggle({Name = "Invisible [I]", CurrentValue = false, Callback = function(v) setInvisible(v) end})
PTab:CreateSlider({Name = "Invisible Y", Range = {1000, 50000}, Increment = 100, CurrentValue = 5000, Callback = function(v) Config.InvisibleY = v end})
PTab:CreateToggle({Name = "CTRL+Click Teleport", CurrentValue = false, Callback = function(v) Config.CtrlClickTP = v end})
PTab:CreateInput({Name = "Teleport to Player", CurrentValue = "", Placeholder = "Nome", Callback = function(v)
    if not v or v == "" then return end
    local p = Players:FindFirstChild(v)
    if not p or not p.Character then return end
    local h = p.Character:FindFirstChild("HumanoidRootPart")
    if h then teleportTo(h.Position) end
end})
PTab:CreateInput({Name = "Spectate", CurrentValue = "", Placeholder = "Nome", Callback = function(v)
    if v and v ~= "" then spectatePlayer(v) end
end})
PTab:CreateButton({Name = "Parar Spectate", Callback = function() stopSpectate() end})
PTab:CreateButton({Name = "Ir para Obby", Callback = function()
    local p = findObby()
    if p then teleportTo(p) else Rayfield:Notify({Title = "TP", Content = "Sem obby", Duration = 3}) end
end})
PTab:CreateButton({Name = "Ir para Centro", Callback = function() teleportTo(mapCenter()) end})
PTab:CreateButton({Name = "Ir para Lobby", Callback = function()
    local lb = workspace:FindFirstChild("Lobby")
    if lb and lb:FindFirstChild("Spawns") then
        local s = lb.Spawns:FindFirstChildWhichIsA("SpawnLocation")
        if s then LocalPlayer.Character:MoveTo(s.Position) end
    end
end})
PTab:CreateButton({Name = "Ir para Map (random)", Callback = function()
    local m = getMap(); if not m then return end
    local sp = m:FindFirstChild("Spawns")
    if sp then
        local list = sp:GetChildren()
        if #list > 0 then LocalPlayer.Character:MoveTo(list[math.random(1, #list)].Position) end
    end
end})
PTab:CreateInput({Name = "Loop WS", CurrentValue = "16", Placeholder = "Valor", Callback = function(v) Config.LoopWS = tonumber(v) or 16 end})
PTab:CreateInput({Name = "Loop FOV", CurrentValue = "70", Placeholder = "Valor", Callback = function(v) Config.LoopFOV = tonumber(v) or 70 end})
PTab:CreateToggle({Name = "Loop WS + FOV", CurrentValue = false, Callback = function(v) Config.LoopWS_FOV = v end})
PTab:CreateInput({Name = "Set FOV", CurrentValue = "70", Placeholder = "Valor", Callback = function(v)
    local f = tonumber(v) or 70
    TweenService:Create(workspace.CurrentCamera, TweenInfo.new(1), {FieldOfView = f}):Play()
end})
PTab:CreateInput({Name = "WS Incremento", CurrentValue = "2", Placeholder = "Valor", Callback = function(v)
    Config.WSInc = tonumber(v) or 2
end})
PTab:CreateButton({Name = "Aumentar WS", Callback = function()
    local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if h then
        Config.Speed = Config.Speed + Config.WSInc
        h.WalkSpeed = h.WalkSpeed + Config.WSInc
    end
end})
PTab:CreateButton({Name = "Diminuir WS", Callback = function()
    local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if h then
        Config.Speed = Config.Speed - Config.WSInc
        h.WalkSpeed = h.WalkSpeed - Config.WSInc
    end
end})
PTab:CreateButton({Name = "Get Ping", Callback = function()
    Rayfield:Notify({Title = "Ping", Content = math.floor(LocalPlayer:GetNetworkPing() * 1000).."ms", Duration = 3})
end})
PTab:CreateButton({Name = "FPS Boost", Callback = function()
    pcall(fpsBoost)
    Rayfield:Notify({Title = "FPS", Content = "Aplicado!", Duration = 3})
end})
PTab:CreateButton({Name = "Developer Console", Callback = function()
    game.StarterGui:SetCore("DevConsoleVisible", true)
end})
PTab:CreateButton({Name = "God Mode (instavel)", Callback = function()
    local Cam = workspace.CurrentCamera
    local Pos, Char = Cam.CFrame, LocalPlayer.Character
    local Hum = Char and Char:FindFirstChildWhichIsA("Humanoid")
    if not Hum then return end
    local nH = Hum:Clone()
    nH.Parent, LocalPlayer.Character = Char, nil
    nH:SetStateEnabled(15, false); nH:SetStateEnabled(1, false); nH:SetStateEnabled(0, false)
    nH.BreakJointsOnDeath = true; Hum:Destroy()
    LocalPlayer.Character, Cam.CameraSubject, Cam.CFrame = Char, nH, Pos
    nH.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    local s = Char:FindFirstChild("Animate")
    if s then s.Disabled = true; task.wait(); s.Disabled = false end
    nH.Health = nH.MaxHealth
end})

-- ABA 5: MISC
local MTab2 = Window:CreateTab("Misc", 4483362458)
MTab2:CreateToggle({Name = "Sem Neblina", CurrentValue = false, Callback = function(v) Config.Perf_NoFog = v end})
MTab2:CreateToggle({Name = "Sem Sombras", CurrentValue = false, Callback = function(v) Config.Perf_NoShadow = v end})
MTab2:CreateToggle({Name = "Textura Lisa", CurrentValue = false, Callback = function(v) Config.Perf_SmoothTexture = v end})
MTab2:CreateToggle({Name = "Full Bright", CurrentValue = false, Callback = function(v) Config.Perf_FullBright = v end})
MTab2:CreateButton({Name = "Resetar Performance", Callback = function()
    Config.Perf_NoFog = false; Config.Perf_NoShadow = false
    Config.Perf_SmoothTexture = false; Config.Perf_FullBright = false
    restL("bright"); restL("fog"); restL("shadow"); restMats(); restShadows()
    perfState.bright = false; perfState.nofog = false
    perfState.noshadow = false; perfState.smooth = false
end})
MTab2:CreateToggle({Name = "Anti-Kick", CurrentValue = false, Callback = function(v) Config.AntiKick = v end})
MTab2:CreateToggle({Name = "Anti-Ragdoll", CurrentValue = false, Callback = function(v) Config.AntiRagdoll = v end})
MTab2:CreateToggle({Name = "Kill Notifier", CurrentValue = false, Callback = function(v) Config.KillNotifier = v end})
MTab2:CreateToggle({Name = "Auto Dodge", CurrentValue = false, Callback = function(v) Config.AutoDodge = v end})
MTab2:CreateToggle({Name = "Anti-AFK", CurrentValue = false, Callback = function(v) Config.AntiAFK = v end})
MTab2:CreateToggle({Name = "Murderer Alert", CurrentValue = false, Callback = function(v) Config.MurdererAlert = v end})
MTab2:CreateSlider({Name = "Alerta Range", Range = {30, 200}, Increment = 10, CurrentValue = 80, Callback = function(v) Config.MurdererAlertRange = v end})
MTab2:CreateToggle({Name = "Ignore knife throws", CurrentValue = false, Callback = function(v) Config.IgnoreKnifeThrows = v end})
MTab2:CreateButton({Name = "Lista de Players", Callback = function()
    local msg = ""
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then msg = msg..p.Name.." - "..getRole(p).."\n" end
    end
    Rayfield:Notify({Title = "Players", Content = msg, Duration = 10})
end})
MTab2:CreateButton({Name = "Server Hop", Callback = function()
    task.spawn(function()
        pcall(function()
            local HS = game:GetService("HttpService")
            local TS = game:GetService("TeleportService")
            local url = "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"
            local res
            if syn and syn.request then res = syn.request({Url = url, Method = "GET"}).Body
            elseif request then res = request({Url = url, Method = "GET"}).Body
            else res = game:HttpGet(url) end
            local data = HS:JSONDecode(res)
            if data and data.data then
                for _, s in ipairs(data.data) do
                    if s.playing < s.maxPlayers and s.id ~= game.JobId then
                        TS:TeleportToPlaceInstance(game.PlaceId, s.id, LocalPlayer)
                        return
                    end
                end
            end
        end)
    end)
end})

-- ============================================================
-- KEYBINDS
-- ============================================================
UserInputService.InputBegan:Connect(function(inp, gp)
    if gp then return end
    if inp.UserInputType ~= Enum.UserInputType.Keyboard then return end
    local k = inp.KeyCode
    if k == Enum.KeyCode.F then
        Config.Fly = not Config.Fly
        if not Config.Fly then
            local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if h then h.Velocity = Vector3.zero end
        end
        Rayfield:Notify({Title = "Fly", Content = Config.Fly and "ON" or "OFF", Duration = 2})
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
        Rayfield:Notify({Title = "Noclip", Content = Config.Noclip and "ON" or "OFF", Duration = 2})
    end
    if k == Enum.KeyCode.G then task.spawn(function() grabGun() end) end
    if k == Enum.KeyCode.J then
        Config.InfiniteJump = not Config.InfiniteJump
        if Config.InfiniteJump then setupInfLand() end
        Rayfield:Notify({Title = "Inf Jump", Content = Config.InfiniteJump and "ON" or "OFF", Duration = 2})
    end
    if k == Enum.KeyCode.V then
        Config.AntiVoid = not Config.AntiVoid
        Rayfield:Notify({Title = "Anti Void", Content = Config.AntiVoid and "ON" or "OFF", Duration = 2})
    end
    if k == Enum.KeyCode.I then
        setInvisible(not invisOn)
        if invisToggleUI then pcall(function() invisToggleUI:Set(invisOn) end) end
        Rayfield:Notify({Title = "Invisible", Content = invisOn and "ON" or "OFF", Duration = 2})
    end
end)

Rayfield:Notify({
    Title = "MM2 Hub v3 + YARHM",
    Content = "RightCtrl | F=Fly N=Noclip G=GrabGun J=Jump V=AntiVoid I=Invisible",
    Duration = 7,
})

end)

if not okLoad then
    warn("[MM2 Hub+YARHM] Erro:", tostring(errLoad))
end
