-- ============================================================
--  MM2 CHECK HUB  |  ESP + AIMBOT POR ROLE + MOVIMENTO
--  Otimizado para mobile (Rayfield UI)
-- ============================================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- ======================== CONFIGURAÇÕES ========================
local Config = {
    -- Visual
    ESP_Players = false,
    ESP_Gun = false,
    ESP_Color_Innocent = Color3.fromRGB(0, 255, 0),   -- verde
    ESP_Color_Sheriff = Color3.fromRGB(0, 150, 255),   -- azul
    ESP_Color_Murderer = Color3.fromRGB(255, 0, 0),    -- vermelho

    -- Movimento
    Speed = 16,
    JumpPower = 50,
    Fly = false,
    FlySpeed = 50,
    Noclip = false,

    -- Combate
    Aimbot = false,
    Aimbot_Smoothness = 0.15,
    AntiFling = false,
}

-- ======================== DETECÇÃO DE ROLE ========================
-- Retorna "Murderer", "Sheriff" ou "Innocent" para qualquer jogador
local function getRole(player)
    local char = player.Character
    if not char then return "Innocent" end

    if char:FindFirstChild("Knife") then
        return "Murderer"
    elseif char:FindFirstChild("Gun") then
        return "Sheriff"
    else
        return "Innocent"
    end
end

-- Retorna a cor do ESP conforme o role
local function getRoleColor(role)
    if role == "Murderer" then
        return Config.ESP_Color_Murderer
    elseif role == "Sheriff" then
        return Config.ESP_Color_Sheriff
    else
        return Config.ESP_Color_Innocent
    end
end

-- ======================== ESP ========================
local espCache = {}   -- [player] = Highlight

local function createHighlight(player)
    local char = player.Character
    if not char then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "MM2_ESP"
    highlight.Adornee = char
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0

    local role = getRole(player)
    local color = getRoleColor(role)
    highlight.FillColor = color
    highlight.OutlineColor = color

    highlight.Parent = char
    espCache[player] = highlight
end

local function removeHighlight(player)
    if espCache[player] then
        espCache[player]:Destroy()
        espCache[player] = nil
    end
end

local function updateESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if Config.ESP_Players then
                if not espCache[player] or not espCache[player].Adornee then
                    createHighlight(player)
                end
                -- Atualiza a cor caso o role tenha mudado
                local role = getRole(player)
                local color = getRoleColor(role)
                if espCache[player] then
                    espCache[player].FillColor = color
                    espCache[player].OutlineColor = color
                end
            else
                removeHighlight(player)
            end
        end
    end
end

-- ESP para a arma caída (Gun)
local gunESP = nil
local function updateGunESP()
    if not Config.ESP_Gun then
        if gunESP then gunESP:Destroy() gunESP = nil end
        return
    end

    -- Procura por "Gun" no workspace (arma dropada)
    local gun = workspace:FindFirstChild("Gun", true)
    if gun and gun:IsA("BasePart") then
        if not gunESP or gunESP.Adornee ~= gun then
            if gunESP then gunESP:Destroy() end
            gunESP = Instance.new("Highlight")
            gunESP.Name = "MM2_GunESP"
            gunESP.Adornee = gun
            gunESP.FillColor = Color3.fromRGB(255, 255, 0)
            gunESP.OutlineColor = Color3.fromRGB(255, 255, 0)
            gunESP.FillTransparency = 0.3
            gunESP.OutlineTransparency = 0
            gunESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            gunESP.Parent = gun
        end
    else
        if gunESP then gunESP:Destroy() gunESP = nil end
    end
end

-- ======================== AIMBOT POR ROLE ========================
local function getTargetByRole()
    local myRole = getRole(LocalPlayer)
    local bestTarget = nil
    local bestDist = math.huge

    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local char = player.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then continue end

        local targetRole = getRole(player)
        local shouldTarget = false

        if myRole == "Murderer" then
            -- Murder mira em todos (prioriza Sheriff)
            shouldTarget = true
        elseif myRole == "Sheriff" or myRole == "Innocent" then
            -- Sheriff e Innocent miram apenas no Murderer
            if targetRole == "Murderer" then
                shouldTarget = true
            end
        end

        if shouldTarget then
            local dist = (char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if dist < bestDist then
                bestDist = dist
                bestTarget = char
            end
        end
    end

    return bestTarget
end

-- ======================== LOOP PRINCIPAL ========================
RunService.RenderStepped:Connect(function()
    -- Atualiza ESP
    updateESP()
    updateGunESP()

    -- Aimbot
    if Config.Aimbot and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local target = getTargetByRole()
        if target and target:FindFirstChild("Head") then
            local targetPos = target.Head.Position
            local cameraPos = Camera.CFrame.Position
            local desiredCFrame = CFrame.lookAt(cameraPos, targetPos)
            Camera.CFrame = Camera.CFrame:Lerp(desiredCFrame, Config.Aimbot_Smoothness)
        end
    end

    -- Fly
    if Config.Fly and LocalPlayer.Character then
        local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
        if hrp and humanoid then
            local moveDir = Vector3.new()
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir += Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir -= Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir -= Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir += Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir -= Vector3.new(0, 1, 0) end

            if moveDir.Magnitude > 0 then
                hrp.Velocity = moveDir.Unit * Config.FlySpeed
            else
                hrp.Velocity = Vector3.new(0, 0, 0)
            end
        end
    end

    -- Noclip
    if Config.Noclip and LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

-- ======================== ANTI-FLING ========================
-- Protege o personagem local contra arremessos
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
    if Config.AntiFling then
        enableAntiFling()
    end
    -- Reaplica speed/jump
    local humanoid = char:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = Config.Speed
        humanoid.JumpPower = Config.JumpPower
        humanoid.UseJumpPower = true
    end
end)

-- ======================== INTERFACE (RAYFIELD) ========================
local Window = Rayfield:CreateWindow({
    Name = "MM2 Check Hub",
    LoadingTitle = "Carregando...",
    LoadingSubtitle = "por Check",
    ConfigurationSaving = {
        Enabled = false,
    },
    Theme = "DarkBlue",  -- Tema Check (escuro com detalhes azuis)
})

-- Aba Visual
local VisualTab = Window:CreateTab("Visual", 4483362458)
VisualTab:CreateToggle({
    Name = "ESP Players (cores por role)",
    CurrentValue = false,
    Flag = "ESP_Players",
    Callback = function(value)
        Config.ESP_Players = value
        if not value then
            for player, _ in pairs(espCache) do
                removeHighlight(player)
            end
        end
    end,
})

VisualTab:CreateToggle({
    Name = "ESP Gun (arma caída)",
    CurrentValue = false,
    Flag = "ESP_Gun",
    Callback = function(value)
        Config.ESP_Gun = value
    end,
})

-- Aba Movimento
local MoveTab = Window:CreateTab("Movimento", 4483362458)
MoveTab:CreateSlider({
    Name = "Speed",
    Range = {16, 200},
    Increment = 1,
    Suffix = " studs",
    CurrentValue = 16,
    Flag = "Speed",
    Callback = function(value)
        Config.Speed = value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = value
        end
    end,
})

MoveTab:CreateSlider({
    Name = "Jump Power",
    Range = {50, 300},
    Increment = 5,
    Suffix = "",
    CurrentValue = 50,
    Flag = "JumpPower",
    Callback = function(value)
        Config.JumpPower = value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.UseJumpPower = true
            LocalPlayer.Character.Humanoid.JumpPower = value
        end
    end,
})

MoveTab:CreateToggle({
    Name = "Fly (WASD + Space/Ctrl)",
    CurrentValue = false,
    Flag = "Fly",
    Callback = function(value)
        Config.Fly = value
        if not value and LocalPlayer.Character then
            local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.Velocity = Vector3.new(0, 0, 0) end
        end
    end,
})

MoveTab:CreateSlider({
    Name = "Fly Speed",
    Range = {10, 200},
    Increment = 5,
    Suffix = "",
    CurrentValue = 50,
    Flag = "FlySpeed",
    Callback = function(value)
        Config.FlySpeed = value
    end,
})

MoveTab:CreateToggle({
    Name = "Noclip (atravessa paredes)",
    CurrentValue = false,
    Flag = "Noclip",
    Callback = function(value)
        Config.Noclip = value
        if not value and LocalPlayer.Character then
            for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end,
})

-- Aba Combate
local CombatTab = Window:CreateTab("Combate", 4483362458)
CombatTab:CreateToggle({
    Name = "Aimbot por Role",
    CurrentValue = false,
    Flag = "Aimbot",
    Callback = function(value)
        Config.Aimbot = value
    end,
})

CombatTab:CreateSlider({
    Name = "Aimbot Suavidade",
    Range = {0.05, 0.5},
    Increment = 0.01,
    Suffix = "",
    CurrentValue = 0.15,
    Flag = "AimbotSmooth",
    Callback = function(value)
        Config.Aimbot_Smoothness = value
    end,
})

CombatTab:CreateToggle({
    Name = "Anti-Fling",
    CurrentValue = false,
    Flag = "AntiFling",
    Callback = function(value)
        Config.AntiFling = value
        if value then
            enableAntiFling()
        end
    end,
})

-- Notificação inicial
Rayfield:Notify({
    Title = "MM2 Check Hub",
    Content = "Script carregado! Use com responsabilidade.",
    Duration = 5,
    Image = 4483362458,
})
