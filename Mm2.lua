-- YARHM Lightweight Edition (Simple UI) by Aetherion (Adaptado)

if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- ==========================================
-- 1. SISTEMA DE UI SIMPLIFICADO
-- ==========================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SimpleYARHM"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 500, 0, 300)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(197, 0, 0)
Instance.new("UIStroke", MainFrame).Thickness = 2

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "YARHM Lite | MM2"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 35, 1, 0)
CloseBtn.Position = UDim2.new(1, -35, 0, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 65, 65)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.Parent = TopBar

local TabContainer = Instance.new("ScrollingFrame")
TabContainer.Name = "TabContainer"
TabContainer.Size = UDim2.new(0, 120, 1, -40)
TabContainer.Position = UDim2.new(0, 5, 0, 35)
TabContainer.BackgroundTransparency = 1
TabContainer.BorderSizePixel = 0
TabContainer.ScrollBarThickness = 2
TabContainer.Parent = MainFrame
Instance.new("UIListLayout", TabContainer).Padding = UDim.new(0, 5)

local ContentContainer = Instance.new("ScrollingFrame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Size = UDim2.new(1, -135, 1, -45)
ContentContainer.Position = UDim2.new(0, 130, 0, 40)
ContentContainer.BackgroundTransparency = 1
ContentContainer.BorderSizePixel = 0
ContentContainer.ScrollBarThickness = 2
ContentContainer.Parent = MainFrame
local ContentLayout = Instance.new("UIListLayout", ContentContainer)
ContentLayout.Padding = UDim.new(0, 6)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Arrastar a UI
local dragging, dragInput, dragStart, startPos
TopBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)
TopBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- ==========================================
-- 2. FUNÇÕES DE CRIAÇÃO DE UI
-- ==========================================

local CurrentTab = nil
local Tabs = {}

local function CreateTab(name)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 30)
	btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 12
	btn.Parent = TabContainer
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	
	local page = Instance.new("Frame")
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.Visible = false
	page.Parent = ContentContainer
	
	Tabs[name] = {Button = btn, Page = page}
	
	btn.MouseButton1Click:Connect(function()
		for _, tab in pairs(Tabs) do
			tab.Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			tab.Page.Visible = false
		end
		btn.BackgroundColor3 = Color3.fromRGB(197, 0, 0)
		page.Visible = true
		CurrentTab = name
	end)
	
	return page
end

local function CreateButton(parent, text, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 30)
	btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 12
	btn.Parent = parent
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	btn.MouseButton1Click:Connect(callback)
	return btn
end

local function CreateToggle(parent, text, default, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 30)
	btn.BackgroundColor3 = default and Color3.fromRGB(197, 0, 0) or Color3.fromRGB(45, 45, 45)
	btn.Text = text .. (default and " [ON]" or " [OFF]")
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 12
	btn.Parent = parent
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	
	local state = default
	btn.MouseButton1Click:Connect(function()
		state = not state
		btn.BackgroundColor3 = state and Color3.fromRGB(197, 0, 0) or Color3.fromRGB(45, 45, 45)
		btn.Text = text .. (state and " [ON]" or " [OFF]")
		callback(state)
	end)
	return btn
end

local function CreateInput(parent, placeholder, buttonText, callback)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, 0, 0, 30)
	frame.BackgroundTransparency = 1
	frame.Parent = parent
	
	local box = Instance.new("TextBox")
	box.Size = UDim2.new(0.65, 0, 1, 0)
	box.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	box.PlaceholderText = placeholder
	box.Text = ""
	box.TextColor3 = Color3.fromRGB(255, 255, 255)
	box.Font = Enum.Font.Gotham
	box.TextSize = 12
	box.Parent = frame
	Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)
	
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.33, 0, 1, 0)
	btn.Position = UDim2.new(0.67, 0, 0, 0)
	btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	btn.Text = buttonText
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 12
	btn.Parent = frame
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	
	btn.MouseButton1Click:Connect(function() callback(box.Text) end)
end

-- ==========================================
-- 3. CRIAÇÃO DAS ABAS
-- ==========================================

local UniversalTab = CreateTab("Universal")
local MM2Tab = CreateTab("Murder Mystery 2")

-- ==========================================
-- 4. FUNÇÕES UNIVERSAIS (Do script original)
-- ==========================================

local loopFovWs = false
local ws, fov = 16, 70

CreateToggle(UniversalTab, "Loop Walkspeed & FOV", false, function(state)
	loopFovWs = state
end)

CreateInput(UniversalTab, "Walkspeed", "Set", function(text)
	local num = tonumber(text)
	if num and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
		ws = num
		LocalPlayer.Character.Humanoid.WalkSpeed = num
	end
end)

CreateInput(UniversalTab, "FOV", "Set", function(text)
	local num = tonumber(text)
	if num then
		fov = num
		workspace.CurrentCamera.FieldOfView = num
	end
end)

RunService.RenderStepped:Connect(function()
	if loopFovWs then
		workspace.CurrentCamera.FieldOfView = fov
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
			LocalPlayer.Character.Humanoid.WalkSpeed = ws
		end
	end
end)

-- Inf Jump
local infJump = false
UserInputService.JumpRequest:Connect(function()
	if infJump and LocalPlayer.Character then
		local hum = LocalPlayer.Character:FindFirstChild("Humanoid")
		if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
	end
end)

CreateToggle(UniversalTab, "Infinite Jump", false, function(state) infJump = state end)

-- Noclip
local noclip = false
RunService.Stepped:Connect(function()
	if noclip and LocalPlayer.Character then
		for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
			if part:IsA("BasePart") then part.CanCollide = false end
		end
	end
end)

CreateToggle(UniversalTab, "Noclip", false, function(state) 
	noclip = state
	if not state and LocalPlayer.Character then
		for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
			if part:IsA("BasePart") then part.CanCollide = true end
		end
	end
end)

-- Fly Simplificado
local flying = false
local flySpeed = 50
local flyBodyVel, flyBodyGyro
local flyConn

local function startFly()
	if flying then return end
	local char = LocalPlayer.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	
	flying = true
	flyBodyVel = Instance.new("BodyVelocity", hrp)
	flyBodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	flyBodyGyro = Instance.new("BodyGyro", hrp)
	flyBodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
	flyBodyGyro.P = 10000
	
	flyConn = RunService.RenderStepped:Connect(function()
		local cam = workspace.CurrentCamera
		local moveDir = LocalPlayer.Character.Humanoid.MoveDirection
		flyBodyVel.Velocity = moveDir * flySpeed + Vector3.new(0, (UserInputService:IsKeyDown(Enum.KeyCode.Space) and flySpeed or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and flySpeed or 0), 0)
		flyBodyGyro.CFrame = cam.CFrame
	end)
end

local function stopFly()
	flying = false
	if flyConn then flyConn:Disconnect() end
	if flyBodyVel then flyBodyVel:Destroy() end
	if flyBodyGyro then flyBodyGyro:Destroy() end
end

CreateToggle(UniversalTab, "Fly (WASD + Space/Shift)", false, function(state)
	if state then startFly() else stopFly() end
end)

CreateInput(UniversalTab, "Fly Speed", "Set", function(text)
	local num = tonumber(text)
	if num then flySpeed = num end
end)

-- ==========================================
-- 5. FUNÇÕES DO MM2 (Do script original)
-- ==========================================

local espEnabled = false
local highlights = {}

local function toggleESP(state)
	espEnabled = state
	if not state then
		for _, hl in pairs(highlights) do hl:Destroy() end
		highlights = {}
		return
	end
	
	task.spawn(function()
		while espEnabled do
			task.wait(1)
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr ~= LocalPlayer and plr.Character then
					if not highlights[plr] or not highlights[plr].Parent then
						local hl = Instance.new("Highlight")
						hl.Adornee = plr.Character
						hl.FillTransparency = 0.5
						hl.OutlineTransparency = 0
						hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
						hl.Parent = ScreenGui
						highlights[plr] = hl
						
						-- Lógica de cores (Murderer/Sheriff)
						local isMurd = false
						local isSher = false
						if plr.Backpack:FindFirstChild("Knife") or (plr.Character and plr.Character:FindFirstChild("Knife")) then
							isMurd = true
						elseif plr.Backpack:FindFirstChild("Gun") or (plr.Character and plr.Character:FindFirstChild("Gun")) then
							isSher = true
						end
						
						if isMurd then
							hl.FillColor = Color3.fromRGB(255, 0, 0)
							hl.OutlineColor = Color3.fromRGB(255, 0, 0)
						elseif isSher then
							hl.FillColor = Color3.fromRGB(0, 150, 255)
							hl.OutlineColor = Color3.fromRGB(0, 150, 255)
						else
							hl.FillColor = Color3.fromRGB(0, 255, 0)
							hl.OutlineColor = Color3.fromRGB(0, 255, 0)
						end
					end
				end
			end
		end
	end)
end

CreateToggle(MM2Tab, "Player ESP (Highlight)", false, toggleESP)

-- Auto Shoot (Sheriff)
local autoShoot = false
local shootOffset = 2.8

local function getPredictedPosition(targetPlayer)
	if not targetPlayer.Character then return Vector3.new(0,0,0) end
	local hrp = targetPlayer.Character:FindFirstChild("HumanoidRootPart") or targetPlayer.Character:FindFirstChild("UpperTorso")
	local hum = targetPlayer.Character:FindFirstChild("Humanoid")
	if not hrp or not hum then return Vector3.new(0,0,0) end
	
	local velocity = hrp.AssemblyLinearVelocity
	local moveDir = hum.MoveDirection
	local predicted = hrp.Position + ((velocity * Vector3.new(0.75, 0.5, 0.75))) * (shootOffset / 15) + moveDir * shootOffset
	return predicted
end

task.spawn(function()
	while task.wait(0.5) do
		if autoShoot and LocalPlayer.Character then
			local isSheriff = LocalPlayer.Backpack:FindFirstChild("Gun") or LocalPlayer.Character:FindFirstChild("Gun")
			if isSheriff then
				local murderer = nil
				for _, plr in ipairs(Players:GetPlayers()) do
					if plr ~= LocalPlayer and (plr.Backpack:FindFirstChild("Knife") or (plr.Character and plr.Character:FindFirstChild("Knife"))) then
						murderer = plr
						break
					end
				end
				
				if murderer and murderer.Character then
					local gun = LocalPlayer.Character:FindFirstChild("Gun")
					if not gun then
						gun = LocalPlayer.Backpack:FindFirstChild("Gun")
						if gun then LocalPlayer.Character.Humanoid:EquipTool(gun) end
					end
					
					if gun then
						local targetPos = getPredictedPosition(murderer)
						local args = {
							CFrame.new(LocalPlayer.Character.RightHand.Position),
							CFrame.new(targetPos)
						}
						gun:FindFirstChild("Shoot"):FireServer(unpack(args))
					end
				end
			end
		end
	end
end)

CreateToggle(MM2Tab, "Auto Shoot Sheriff", false, function(state) autoShoot = state end)

-- Auto Throw Knife (Murderer)
local autoThrow = false

local function throwKnife()
	if not LocalPlayer.Character then return end
	local isMurd = LocalPlayer.Backpack:FindFirstChild("Knife") or LocalPlayer.Character:FindFirstChild("Knife")
	if not isMurd then return end
	
	local knife = LocalPlayer.Character:FindFirstChild("Knife")
	if not knife then
		knife = LocalPlayer.Backpack:FindFirstChild("Knife")
		if knife then LocalPlayer.Character.Humanoid:EquipTool(knife) end
	end
	
	if knife then
		local closest = nil
		local dist = math.huge
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
				local d = (plr.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
				if d < dist then
					dist = d
					closest = plr
				end
			end
		end
		
		if closest then
			local targetPos = getPredictedPosition(closest)
			local args = {
				CFrame.new(LocalPlayer.Character.RightHand.Position),
				CFrame.new(targetPos)
			}
			knife:FindFirstChild("Events"):FindFirstChild("KnifeThrown"):FireServer(unpack(args))
		end
	end
end

task.spawn(function()
	while task.wait(1.5) do
		if autoThrow then
			throwKnife()
		end
	end
end)

CreateToggle(MM2Tab, "Auto Throw Knife", false, function(state) autoThrow = state end)

-- Fling
local function flingPlayer(targetPlayer)
	if not targetPlayer or not targetPlayer.Character then return end
	local char = LocalPlayer.Character
	if not char then return end
	
	local hrp = char:FindFirstChild("HumanoidRootPart")
	local tChar = targetPlayer.Character
	local tHRP = tChar:FindFirstChild("HumanoidRootPart")
	
	if hrp and tHRP then
		local bv = Instance.new("BodyVelocity")
		bv.Parent = hrp
		bv.Velocity = Vector3.new(9e9, 9e9, 9e9)
		bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		
		task.wait(0.1)
		
		hrp.CFrame = tHRP.CFrame
		
		task.wait(0.1)
		bv:Destroy()
	end
end

CreateButton(MM2Tab, "Fling Closest Player", function()
	local closest = nil
	local dist = math.huge
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			local d = (plr.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
			if d < dist then
				dist = d
				closest = plr
			end
		end
	end
	if closest then flingPlayer(closest) end
end)

-- Teleport to Map/Lobby
CreateButton(MM2Tab, "Teleport to Map", function()
	for _, v in ipairs(workspace:GetChildren()) do
		if v:FindFirstChild("Spawns") and v:FindFirstChild("CoinContainer") then
			local spawns = v.Spawns:GetChildren()
			if #spawns > 0 then
				LocalPlayer.Character:MoveTo(spawns[math.random(1, #spawns)].Position)
			end
			break
		end
	end
end)

CreateButton(MM2Tab, "Teleport to Lobby", function()
	local lobby = workspace:FindFirstChild("Lobby")
	if lobby and lobby:FindFirstChild("Spawns") then
		local spawns = lobby.Spawns:GetChildren()
		if #spawns > 0 then
			LocalPlayer.Character:MoveTo(spawns[1].Position)
		end
	end
end)

-- Inicializa a primeira aba
if Tabs["Universal"] then
	Tabs["Universal"].Button.BackgroundColor3 = Color3.fromRGB(197, 0, 0)
	Tabs["Universal"].Page.Visible = true
	CurrentTab = "Universal"
end

-- Notificação simples
game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "YARHM Lite",
	Text = "Script carregado com sucesso!",
	Duration = 5
})
