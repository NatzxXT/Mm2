-- Yet Another Random Hub Menu 1.21.6 by Aetherion (MM2-Only Edition)
-- Build Number: 40
-- By running this script, you agree to ToS and Privacy Policies.

if not game:IsLoaded() then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Script loading",
        Text = "Waiting for the game to finish loading!",
        Duration = 5
    })
    game.Loaded:Wait()
end

local Converted = {
    ["_YARHM"] = Instance.new("ScreenGui");
    ["_FUNCTIONS"] = Instance.new("ModuleScript");
    ["_Universal"] = Instance.new("LocalScript");
    ["_DraggableObject"] = Instance.new("ModuleScript");
    ["_ClickAndHold"] = Instance.new("ModuleScript");
    ["_Spring"] = Instance.new("ModuleScript");
    ["_Init"] = Instance.new("LocalScript");
    ["_Murder Mystery 2"] = Instance.new("LocalScript");
    ["_ESPIndicator"] = Instance.new("ModuleScript");
    ["_Bezier"] = Instance.new("ModuleScript");
    ["_PointSave"] = Instance.new("ModuleScript");
    ["_Theme"] = Instance.new("ModuleScript");
    ["_FlyUtility"] = Instance.new("ModuleScript");
    ["_AdLoader"] = Instance.new("LocalScript");
    ["_MenuButton"] = Instance.new("TextButton");
    ["_UIPadding"] = Instance.new("UIPadding");
    ["_UICorner"] = Instance.new("UICorner");
    ["_UITextSizeConstraint"] = Instance.new("UITextSizeConstraint");
    ["_ClickInd"] = Instance.new("Frame");
    ["_UICorner1"] = Instance.new("UICorner");
    ["_Frame"] = Instance.new("Frame");
    ["_UICorner2"] = Instance.new("UICorner");
    ["_Open"] = Instance.new("TextButton");
    ["_InitOpen"] = Instance.new("LocalScript");
    ["_OnClick"] = Instance.new("LocalScript");
    ["_Resizer"] = Instance.new("LocalScript");
    ["_UICorner3"] = Instance.new("UICorner");
    ["_UIPadding1"] = Instance.new("UIPadding");
    ["_DropdownFrameSample"] = Instance.new("Frame");
    ["_UICorner4"] = Instance.new("UICorner");
    ["_UIGradient"] = Instance.new("UIGradient");
    ["_UIStroke"] = Instance.new("UIStroke");
    ["_UIGradient1"] = Instance.new("UIGradient");
    ["_ScrollingFrame"] = Instance.new("ScrollingFrame");
    ["_UIListLayout"] = Instance.new("UIListLayout");
    ["_Sample"] = Instance.new("TextButton");
    ["_UIPadding2"] = Instance.new("UIPadding");
    ["_UICorner5"] = Instance.new("UICorner");
    ["_UIPadding3"] = Instance.new("UIPadding");
    ["_themedColor"] = Instance.new("StringValue");
    ["_ListButton"] = Instance.new("TextButton");
    ["_UICorner6"] = Instance.new("UICorner");
    ["_Notifications"] = Instance.new("Frame");
    ["_UIListLayout1"] = Instance.new("UIListLayout");
    ["_UIPadding4"] = Instance.new("UIPadding");
    ["_Placeholder"] = Instance.new("Frame");
    ["_UICorner7"] = Instance.new("UICorner");
    ["_TextLabel"] = Instance.new("TextLabel");
    ["_Range"] = Instance.new("Frame");
    ["_TextLabel1"] = Instance.new("TextLabel");
    ["_UIListLayout2"] = Instance.new("UIListLayout");
    ["_UIPadding5"] = Instance.new("UIPadding");
    ["_Frame1"] = Instance.new("Frame");
    ["_UIPadding6"] = Instance.new("UIPadding");
    ["_Track"] = Instance.new("Frame");
    ["_UICorner8"] = Instance.new("UICorner");
    ["_Ball"] = Instance.new("TextButton");
    ["_BallProgress"] = Instance.new("TextLabel");
    ["_UIPadding7"] = Instance.new("UIPadding");
    ["_themedColor1"] = Instance.new("StringValue");
    ["_UICorner9"] = Instance.new("UICorner");
    ["_UIPadding8"] = Instance.new("UIPadding");
    ["_TrackProgress"] = Instance.new("TextLabel");
    ["_themedColor2"] = Instance.new("StringValue");
    ["_UISizeConstraint"] = Instance.new("UISizeConstraint");
    ["_UICorner10"] = Instance.new("UICorner");
    ["_themedColor3"] = Instance.new("StringValue");
    ["_FloatingButton"] = Instance.new("TextButton");
    ["_Keybinding"] = Instance.new("LocalScript");
    ["_Invisible"] = Instance.new("LocalScript");
    ["_UIPadding9"] = Instance.new("UIPadding");
    ["_UICorner11"] = Instance.new("UICorner");
    ["_UIStroke1"] = Instance.new("UIStroke");
    ["_Lock"] = Instance.new("TextLabel");
    ["_UIScale"] = Instance.new("UIScale");
    ["_Ripple"] = Instance.new("Frame");
    ["_UICorner12"] = Instance.new("UICorner");
    ["_UIScale1"] = Instance.new("UIScale");
    ["_Dropdown"] = Instance.new("Frame");
    ["_TextLabel2"] = Instance.new("TextLabel");
    ["_UIListLayout3"] = Instance.new("UIListLayout");
    ["_UIPadding10"] = Instance.new("UIPadding");
    ["_Frame2"] = Instance.new("TextButton");
    ["_UIPadding11"] = Instance.new("UIPadding");
    ["_UICorner13"] = Instance.new("UICorner");
    ["_AddCustomModule"] = Instance.new("Frame");
    ["_UICorner14"] = Instance.new("UICorner");
    ["_UIStroke2"] = Instance.new("UIStroke");
    ["_UIGradient2"] = Instance.new("UIGradient");
    ["_UIGradient3"] = Instance.new("UIGradient");
    ["_UIScale2"] = Instance.new("UIScale");
    ["_TextLabel3"] = Instance.new("TextLabel");
    ["_TextBox"] = Instance.new("TextBox");
    ["_UICorner15"] = Instance.new("UICorner");
    ["_UIPadding12"] = Instance.new("UIPadding");
    ["_TextLabel4"] = Instance.new("TextLabel");
    ["_Add"] = Instance.new("TextButton");
    ["_LocalScript"] = Instance.new("LocalScript");
    ["_UICorner16"] = Instance.new("UICorner");
    ["_UIPadding13"] = Instance.new("UIPadding");
    ["_UIStroke3"] = Instance.new("UIStroke");
    ["_Cancel"] = Instance.new("TextButton");
    ["_LocalScript1"] = Instance.new("LocalScript");
    ["_UICorner17"] = Instance.new("UICorner");
    ["_UIPadding14"] = Instance.new("UIPadding");
    ["_UIStroke4"] = Instance.new("UIStroke");
    ["_themedColor4"] = Instance.new("StringValue");
    ["_Menu"] = Instance.new("Frame");
    ["_UICorner18"] = Instance.new("UICorner");
    ["_UIStroke5"] = Instance.new("UIStroke");
    ["_UIGradient4"] = Instance.new("UIGradient");
    ["_Animator"] = Instance.new("LocalScript");
    ["_HubCredits"] = Instance.new("TextLabel");
    ["_HubDesc"] = Instance.new("TextLabel");
    ["_HubName"] = Instance.new("TextLabel");
    ["_CanvasGroup"] = Instance.new("CanvasGroup");
    ["_UICorner19"] = Instance.new("UICorner");
    ["_ImageLabel"] = Instance.new("ImageLabel");
    ["_Opener"] = Instance.new("TextButton");
    ["_TextLabel5"] = Instance.new("TextLabel");
    ["_CloseArea"] = Instance.new("TextButton");
    ["_CloseOpen"] = Instance.new("LocalScript");
    ["_Frame3"] = Instance.new("Frame");
    ["_UICorner20"] = Instance.new("UICorner");
    ["_themedColor5"] = Instance.new("StringValue");
    ["_TextLabel6"] = Instance.new("TextLabel");
    ["_UICorner21"] = Instance.new("UICorner");
    ["_AllowForSpring"] = Instance.new("BindableEvent");
    ["_themedColor6"] = Instance.new("StringValue");
    ["_UIGradient5"] = Instance.new("UIGradient");
    ["_Area"] = Instance.new("CanvasGroup");
    ["_Area1"] = Instance.new("ScrollingFrame");
    ["_TextLabel7"] = Instance.new("TextLabel");
    ["_TextLabel8"] = Instance.new("TextLabel");
    ["_UICorner22"] = Instance.new("UICorner");
    ["_List"] = Instance.new("CanvasGroup");
    ["_AutoSetup"] = Instance.new("LocalScript");
    ["_UICorner23"] = Instance.new("UICorner");
    ["_ScrollingFrame1"] = Instance.new("ScrollingFrame");
    ["_UIListLayout4"] = Instance.new("UIListLayout");
    ["_UIPadding15"] = Instance.new("UIPadding");
    ["_UIPadding16"] = Instance.new("UIPadding");
    ["_UIStroke6"] = Instance.new("UIStroke");
    ["_UIGradient6"] = Instance.new("UIGradient");
    ["_AddCustomModule1"] = Instance.new("TextButton");
    ["_LocalScript2"] = Instance.new("LocalScript");
    ["_UICorner24"] = Instance.new("UICorner");
    ["_UIPadding17"] = Instance.new("UIPadding");
    ["_UIStroke7"] = Instance.new("UIStroke");
    ["_themedColor7"] = Instance.new("StringValue");
    ["_themedColor8"] = Instance.new("StringValue");
    ["_themedColor9"] = Instance.new("StringValue");
    ["_UIScale3"] = Instance.new("UIScale");
    ["_Stub"] = Instance.new("Frame");
    ["_themedColor10"] = Instance.new("StringValue");
    ["_Stub1"] = Instance.new("Frame");
    ["_themedColor11"] = Instance.new("StringValue");
    ["_PHContainer"] = Instance.new("Frame");
    ["_PHContainerInner"] = Instance.new("CanvasGroup");
    ["_Rotator"] = Instance.new("Frame");
    ["_PHIdle"] = Instance.new("LocalScript");
    ["_PH"] = Instance.new("ImageLabel");
    ["_Tap"] = Instance.new("TextButton");
    ["_TextLabel9"] = Instance.new("TextLabel");
    ["_UICorner25"] = Instance.new("UICorner");
    ["_Ad"] = Instance.new("CanvasGroup");
    ["_UICorner26"] = Instance.new("UICorner");
    ["_Image"] = Instance.new("ImageLabel");
    ["_Metadata"] = Instance.new("Frame");
    ["_UIGradient7"] = Instance.new("UIGradient");
    ["_TextLabel10"] = Instance.new("TextLabel");
    ["_UIPadding18"] = Instance.new("UIPadding");
    ["_CTA"] = Instance.new("TextButton");
    ["_UICorner27"] = Instance.new("UICorner");
    ["_UIPadding19"] = Instance.new("UIPadding");
    ["_Sponsoered"] = Instance.new("TextLabel");
    ["_Toggle"] = Instance.new("Frame");
    ["_TextLabel11"] = Instance.new("TextLabel");
    ["_UIListLayout5"] = Instance.new("UIListLayout");
    ["_Frame4"] = Instance.new("Frame");
    ["_Frame5"] = Instance.new("Frame");
    ["_UICorner28"] = Instance.new("UICorner");
    ["_Toggler"] = Instance.new("TextButton");
    ["_UICorner29"] = Instance.new("UICorner");
    ["_ImageLabel1"] = Instance.new("ImageLabel");
    ["_UIPadding20"] = Instance.new("UIPadding");
    ["_UICorner30"] = Instance.new("UICorner");
    ["_themedColor12"] = Instance.new("StringValue");
    ["_UIPadding21"] = Instance.new("UIPadding");
    ["_Modules"] = Instance.new("Folder");
    ["_NotificationSample"] = Instance.new("Frame");
    ["_UICorner31"] = Instance.new("UICorner");
    ["_UIStroke8"] = Instance.new("UIStroke");
    ["_UIGradient8"] = Instance.new("UIGradient");
    ["_ImageLabel2"] = Instance.new("ImageLabel");
    ["_TextLabel12"] = Instance.new("TextLabel");
    ["_UITextSizeConstraint1"] = Instance.new("UITextSizeConstraint");
    ["_Close"] = Instance.new("ImageButton");
    ["_UICorner32"] = Instance.new("UICorner");
    ["_UIStroke9"] = Instance.new("UIStroke");
    ["_UIScale4"] = Instance.new("UIScale");
    ["_themedColor13"] = Instance.new("StringValue");
    ["_Dialog"] = Instance.new("Frame");
    ["_UICorner33"] = Instance.new("UICorner");
    ["_UIGradient9"] = Instance.new("UIGradient");
    ["_UIPadding22"] = Instance.new("UIPadding");
    ["_UIStroke10"] = Instance.new("UIStroke");
    ["_UIGradient10"] = Instance.new("UIGradient");
    ["_DialogTitle"] = Instance.new("TextLabel");
    ["_UIListLayout6"] = Instance.new("UIListLayout");
    ["_DialogDesc"] = Instance.new("TextLabel");
    ["_UITextSizeConstraint2"] = Instance.new("UITextSizeConstraint");
    ["_Options"] = Instance.new("Frame");
    ["_UIListLayout7"] = Instance.new("UIListLayout");
    ["_OptionPlaceholder"] = Instance.new("TextButton");
    ["_UIPadding23"] = Instance.new("UIPadding");
    ["_UICorner34"] = Instance.new("UICorner");
    ["_UIStroke11"] = Instance.new("UIStroke");
    ["_UIGradient11"] = Instance.new("UIGradient");
    ["_themedColor14"] = Instance.new("StringValue");
    ["_OnSelect"] = Instance.new("BindableEvent");
    ["_UIScale5"] = Instance.new("UIScale");
    ["_themedColor15"] = Instance.new("StringValue");
    ["_FloatingButtonSetting"] = Instance.new("Frame");
    ["_ControlBarContainer"] = Instance.new("Frame");
    ["_ControlBar"] = Instance.new("Frame");
    ["_UIListLayout8"] = Instance.new("UIListLayout");
    ["_Visibility"] = Instance.new("TextButton");
    ["_LocalScript3"] = Instance.new("LocalScript");
    ["_UICorner35"] = Instance.new("UICorner");
    ["_UIPadding24"] = Instance.new("UIPadding");
    ["_Event"] = Instance.new("BindableEvent");
    ["_themedColor16"] = Instance.new("StringValue");
    ["_Lock1"] = Instance.new("TextButton");
    ["_LocalScript4"] = Instance.new("LocalScript");
    ["_UICorner36"] = Instance.new("UICorner");
    ["_UIPadding25"] = Instance.new("UIPadding");
    ["_Event1"] = Instance.new("BindableEvent");
    ["_themedColor17"] = Instance.new("StringValue");
    ["_Exit"] = Instance.new("TextButton");
    ["_LocalScript5"] = Instance.new("LocalScript");
    ["_UICorner37"] = Instance.new("UICorner");
    ["_UIPadding26"] = Instance.new("UIPadding");
    ["_UIAspectRatioConstraint"] = Instance.new("UIAspectRatioConstraint");
    ["_themedColor18"] = Instance.new("StringValue");
    ["_UIListLayout9"] = Instance.new("UIListLayout");
    ["_Tip"] = Instance.new("TextLabel");
    ["_UIStroke12"] = Instance.new("UIStroke");
    ["_UIScale6"] = Instance.new("UIScale");
    ["_FloatingButtons"] = Instance.new("Frame");
    ["_FloatingButtons1"] = Instance.new("Frame");
    ["_TextBoxPlaceholder"] = Instance.new("Frame");
    ["_UIListLayout10"] = Instance.new("UIListLayout");
    ["_TextButton"] = Instance.new("TextButton");
    ["_UICorner38"] = Instance.new("UICorner");
    ["_UIPadding27"] = Instance.new("UIPadding");
    ["_UITextSizeConstraint3"] = Instance.new("UITextSizeConstraint");
    ["_TextBox1"] = Instance.new("TextBox");
    ["_UICorner39"] = Instance.new("UICorner");
}

-- Propriedades (mesmo conjunto do original, sem Forsaken/FTF)

Converted["_YARHM"].DisplayOrder = 3
Converted["_YARHM"].IgnoreGuiInset = true
Converted["_YARHM"].ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
Converted["_YARHM"].ResetOnSpawn = false
Converted["_YARHM"].ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Converted["_YARHM"].Name = "YARHM"
Converted["_YARHM"].Parent = game:GetService("CoreGui")

Converted["_MenuButton"].Font = Enum.Font.GothamBold
Converted["_MenuButton"].Text = "a"
Converted["_MenuButton"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_MenuButton"].TextScaled = true
Converted["_MenuButton"].TextWrapped = true
Converted["_MenuButton"].TextXAlignment = Enum.TextXAlignment.Left
Converted["_MenuButton"].BackgroundColor3 = Color3.fromRGB(22, 22, 22)
Converted["_MenuButton"].Size = UDim2.new(1, 0, 0, 35)
Converted["_MenuButton"].Visible = false
Converted["_MenuButton"].Name = "MenuButton"
Converted["_MenuButton"].Parent = Converted["_YARHM"]

Converted["_UIPadding"].PaddingBottom = UDim.new(0, 5)
Converted["_UIPadding"].PaddingLeft = UDim.new(0, 16)
Converted["_UIPadding"].PaddingRight = UDim.new(0, 16)
Converted["_UIPadding"].PaddingTop = UDim.new(0, 5)
Converted["_UIPadding"].Parent = Converted["_MenuButton"]

Converted["_UICorner"].CornerRadius = UDim.new(1, 0)
Converted["_UICorner"].Parent = Converted["_MenuButton"]

Converted["_UITextSizeConstraint"].MaxTextSize = 16
Converted["_UITextSizeConstraint"].Parent = Converted["_MenuButton"]

Converted["_ClickInd"].AnchorPoint = Vector2.new(1, 0.5)
Converted["_ClickInd"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_ClickInd"].BackgroundTransparency = 0.5
Converted["_ClickInd"].BorderSizePixel = 0
Converted["_ClickInd"].Position = UDim2.new(1, 0, 0.5, 0)
Converted["_ClickInd"].Size = UDim2.new(0, 21, 0, 21)
Converted["_ClickInd"].Name = "ClickInd"
Converted["_ClickInd"].Parent = Converted["_MenuButton"]

Converted["_UICorner1"].CornerRadius = UDim.new(1, 0)
Converted["_UICorner1"].Parent = Converted["_ClickInd"]

Converted["_Frame"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Frame"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Frame"].BorderSizePixel = 0
Converted["_Frame"].Position = UDim2.new(0.5, 0, 0.5, 0)
Converted["_Frame"].Size = UDim2.new(0.6, 0, 0.6, 0)
Converted["_Frame"].Parent = Converted["_ClickInd"]

Converted["_UICorner2"].CornerRadius = UDim.new(1, 0)
Converted["_UICorner2"].Parent = Converted["_Frame"]

Converted["_Open"].Font = Enum.Font.Gotham
Converted["_Open"].Text = "Triple-click this region to open YARHM."
Converted["_Open"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Open"].TextScaled = true
Converted["_Open"].TextSize = 14
Converted["_Open"].TextTransparency = 1
Converted["_Open"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Open"].BackgroundTransparency = 1
Converted["_Open"].BorderSizePixel = 0
Converted["_Open"].Position = UDim2.new(0.499, 0, 0.063, 0)
Converted["_Open"].Selectable = false
Converted["_Open"].Size = UDim2.new(0, 493, 0, 50)
Converted["_Open"].Visible = false
Converted["_Open"].Name = "Open"
Converted["_Open"].Parent = Converted["_YARHM"]

Converted["_UICorner3"].Parent = Converted["_Open"]

Converted["_UIPadding1"].PaddingBottom = UDim.new(0, 10)
Converted["_UIPadding1"].PaddingLeft = UDim.new(0, 20)
Converted["_UIPadding1"].PaddingRight = UDim.new(0, 20)
Converted["_UIPadding1"].PaddingTop = UDim.new(0, 10)
Converted["_UIPadding1"].Parent = Converted["_Open"]

Converted["_DropdownFrameSample"].AnchorPoint = Vector2.new(0.5, 0)
Converted["_DropdownFrameSample"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_DropdownFrameSample"].BorderSizePixel = 0
Converted["_DropdownFrameSample"].Size = UDim2.new(0, 108, 0, 239)
Converted["_DropdownFrameSample"].Visible = false
Converted["_DropdownFrameSample"].Name = "DropdownFrameSample"
Converted["_DropdownFrameSample"].Parent = Converted["_YARHM"]

Converted["_UICorner4"].Parent = Converted["_DropdownFrameSample"]

Converted["_UIGradient"].Color = ColorSequence.new(Color3.fromRGB(36, 36, 36), Color3.fromRGB(68, 68, 68))
Converted["_UIGradient"].Rotation = 68
Converted["_UIGradient"].Parent = Converted["_DropdownFrameSample"]

Converted["_UIStroke"].Color = Color3.fromRGB(255, 255, 255)
Converted["_UIStroke"].Thickness = 2
Converted["_UIStroke"].Parent = Converted["_DropdownFrameSample"]

Converted["_UIGradient1"].Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(111, 111, 111)),
    ColorSequenceKeypoint.new(0.64, Color3.fromRGB(114, 114, 114)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
}
Converted["_UIGradient1"].Rotation = -107
Converted["_UIGradient1"].Parent = Converted["_UIStroke"]

Converted["_ScrollingFrame"].AutomaticCanvasSize = Enum.AutomaticSize.XY
Converted["_ScrollingFrame"].ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
Converted["_ScrollingFrame"].ScrollBarThickness = 0
Converted["_ScrollingFrame"].Active = true
Converted["_ScrollingFrame"].BackgroundTransparency = 1
Converted["_ScrollingFrame"].BorderSizePixel = 0
Converted["_ScrollingFrame"].Size = UDim2.new(1, 0, 1, 0)
Converted["_ScrollingFrame"].Parent = Converted["_DropdownFrameSample"]

Converted["_UIListLayout"].Padding = UDim.new(0, 5)
Converted["_UIListLayout"].SortOrder = Enum.SortOrder.LayoutOrder
Converted["_UIListLayout"].Parent = Converted["_ScrollingFrame"]

Converted["_Sample"].Text = "This can fit a lot of text, probably."
Converted["_Sample"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Sample"].TextScaled = true
Converted["_Sample"].TextSize = 14
Converted["_Sample"].TextWrapped = true
Converted["_Sample"].BackgroundColor3 = Color3.fromRGB(22, 22, 22)
Converted["_Sample"].BorderSizePixel = 0
Converted["_Sample"].Size = UDim2.new(1, 0, 0, 35)
Converted["_Sample"].Visible = false
Converted["_Sample"].Name = "Sample"
Converted["_Sample"].Parent = Converted["_ScrollingFrame"]

Converted["_UIPadding2"].PaddingBottom = UDim.new(0, 7)
Converted["_UIPadding2"].PaddingLeft = UDim.new(0, 7)
Converted["_UIPadding2"].PaddingRight = UDim.new(0, 7)
Converted["_UIPadding2"].PaddingTop = UDim.new(0, 7)
Converted["_UIPadding2"].Parent = Converted["_Sample"]

Converted["_UICorner5"].Parent = Converted["_Sample"]

Converted["_UIPadding3"].PaddingBottom = UDim.new(0, 7)
Converted["_UIPadding3"].PaddingLeft = UDim.new(0, 7)
Converted["_UIPadding3"].PaddingRight = UDim.new(0, 7)
Converted["_UIPadding3"].PaddingTop = UDim.new(0, 7)
Converted["_UIPadding3"].Parent = Converted["_DropdownFrameSample"]

Converted["_themedColor"].Value = "backgroundColorCSQ"
Converted["_themedColor"].Name = "themedColor"
Converted["_themedColor"].Parent = Converted["_DropdownFrameSample"]

Converted["_ListButton"].Font = Enum.Font.Gotham
Converted["_ListButton"].Text = "Placeholder"
Converted["_ListButton"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_ListButton"].TextSize = 14
Converted["_ListButton"].TextWrapped = true
Converted["_ListButton"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_ListButton"].BackgroundColor3 = Color3.fromRGB(49, 49, 49)
Converted["_ListButton"].BorderSizePixel = 0
Converted["_ListButton"].Position = UDim2.new(0.045, 0, 0.112, 0)
Converted["_ListButton"].Size = UDim2.new(1, 0, 0, 50)
Converted["_ListButton"].Visible = false
Converted["_ListButton"].Name = "ListButton"
Converted["_ListButton"].Parent = Converted["_YARHM"]

Converted["_UICorner6"].Parent = Converted["_ListButton"]

Converted["_Notifications"].AnchorPoint = Vector2.new(1, 0.5)
Converted["_Notifications"].BackgroundTransparency = 1
Converted["_Notifications"].BorderSizePixel = 0
Converted["_Notifications"].Position = UDim2.new(0.99, 0, 0.5, 0)
Converted["_Notifications"].Size = UDim2.new(0, 242, 1, 0)
Converted["_Notifications"].Name = "Notifications"
Converted["_Notifications"].Parent = Converted["_YARHM"]

Converted["_UIListLayout1"].Padding = UDim.new(0, 10)
Converted["_UIListLayout1"].HorizontalAlignment = Enum.HorizontalAlignment.Center
Converted["_UIListLayout1"].SortOrder = Enum.SortOrder.LayoutOrder
Converted["_UIListLayout1"].VerticalAlignment = Enum.VerticalAlignment.Bottom
Converted["_UIListLayout1"].Parent = Converted["_Notifications"]

Converted["_UIPadding4"].PaddingBottom = UDim.new(0, 10)
Converted["_UIPadding4"].PaddingLeft = UDim.new(0, 10)
Converted["_UIPadding4"].Parent = Converted["_Notifications"]

Converted["_Placeholder"].AnchorPoint = Vector2.new(0.5, 0)
Converted["_Placeholder"].BackgroundColor3 = Color3.fromRGB(31, 31, 31)
Converted["_Placeholder"].BorderSizePixel = 0
Converted["_Placeholder"].Position = UDim2.new(0.045, 0, 0.112, 0)
Converted["_Placeholder"].Visible = false
Converted["_Placeholder"].Name = "Placeholder"
Converted["_Placeholder"].Parent = Converted["_Notifications"]

Converted["_UICorner7"].Parent = Converted["_Placeholder"]

Converted["_TextLabel"].Font = Enum.Font.Gotham
Converted["_TextLabel"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel"].TextScaled = true
Converted["_TextLabel"].TextSize = 14
Converted["_TextLabel"].TextXAlignment = Enum.TextXAlignment.Left
Converted["_TextLabel"].BackgroundTransparency = 1
Converted["_TextLabel"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_TextLabel"].Position = UDim2.new(0.5, 0, 0.5, 0)
Converted["_TextLabel"].Size = UDim2.new(0.9, 0, 0.8, 0)
Converted["_TextLabel"].Parent = Converted["_Placeholder"]

Converted["_Range"].BackgroundColor3 = Color3.fromRGB(22, 22, 22)
Converted["_Range"].BorderSizePixel = 0
Converted["_Range"].Size = UDim2.new(1, 0, 0, 45)
Converted["_Range"].Visible = false
Converted["_Range"].Name = "Range"
Converted["_Range"].Parent = Converted["_YARHM"]

Converted["_TextLabel1"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel1"].TextScaled = true
Converted["_TextLabel1"].TextXAlignment = Enum.TextXAlignment.Left
Converted["_TextLabel1"].BackgroundTransparency = 1
Converted["_TextLabel1"].Position = UDim2.new(-0.063, 0, 0.686, 0)
Converted["_TextLabel1"].Size = UDim2.new(0, 125, 0, 25)
Converted["_TextLabel1"].Parent = Converted["_Range"]

Converted["_UIListLayout2"].HorizontalFlex = Enum.UIFlexAlignment.Fill
Converted["_UIListLayout2"].Padding = UDim.new(0, 15)
Converted["_UIListLayout2"].VerticalFlex = Enum.UIFlexAlignment.SpaceAround
Converted["_UIListLayout2"].FillDirection = Enum.FillDirection.Horizontal
Converted["_UIListLayout2"].HorizontalAlignment = Enum.HorizontalAlignment.Center
Converted["_UIListLayout2"].SortOrder = Enum.SortOrder.LayoutOrder
Converted["_UIListLayout2"].VerticalAlignment = Enum.VerticalAlignment.Center
Converted["_UIListLayout2"].Parent = Converted["_Range"]

Converted["_UIPadding5"].PaddingBottom = UDim.new(0, 6)
Converted["_UIPadding5"].PaddingLeft = UDim.new(0, 16)
Converted["_UIPadding5"].PaddingRight = UDim.new(0, 8)
Converted["_UIPadding5"].PaddingTop = UDim.new(0, 6)
Converted["_UIPadding5"].Parent = Converted["_Range"]

Converted["_Frame1"].BackgroundTransparency = 1
Converted["_Frame1"].BorderSizePixel = 0
Converted["_Frame1"].Size = UDim2.new(0.4, 0, 1, 0)
Converted["_Frame1"].Parent = Converted["_Range"]

Converted["_UIPadding6"].PaddingBottom = UDim.new(0, 7)
Converted["_UIPadding6"].PaddingLeft = UDim.new(0, 7)
Converted["_UIPadding6"].PaddingRight = UDim.new(0, 7)
Converted["_UIPadding6"].PaddingTop = UDim.new(0, 7)
Converted["_UIPadding6"].Parent = Converted["_Frame1"]

Converted["_Track"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Track"].BackgroundColor3 = Color3.fromRGB(12, 12, 12)
Converted["_Track"].BorderSizePixel = 0
Converted["_Track"].Position = UDim2.new(0.5, 0, 0.5, 0)
Converted["_Track"].Size = UDim2.new(1, 0, 1.2, 0)
Converted["_Track"].Name = "Track"
Converted["_Track"].Parent = Converted["_Frame1"]

Converted["_UICorner8"].CornerRadius = UDim.new(1, 0)
Converted["_UICorner8"].Parent = Converted["_Track"]

Converted["_Ball"].Text = ""
Converted["_Ball"].TextSize = 14
Converted["_Ball"].AnchorPoint = Vector2.new(0, 0.5)
Converted["_Ball"].BackgroundColor3 = Color3.fromRGB(197, 0, 0)
Converted["_Ball"].BorderSizePixel = 0
Converted["_Ball"].Interactable = false
Converted["_Ball"].Position = UDim2.new(0, 0, 0.5, 0)
Converted["_Ball"].Size = UDim2.new(0.06, 0, 1, 0)
Converted["_Ball"].Name = "Ball"
Converted["_Ball"].Parent = Converted["_Track"]

Converted["_BallProgress"].Font = Enum.Font.GothamBold
Converted["_BallProgress"].Text = "0"
Converted["_BallProgress"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_BallProgress"].TextScaled = true
Converted["_BallProgress"].TextTransparency = 1
Converted["_BallProgress"].BackgroundTransparency = 1
Converted["_BallProgress"].BorderSizePixel = 0
Converted["_BallProgress"].Size = UDim2.new(1, 0, 1, 0)
Converted["_BallProgress"].Name = "BallProgress"
Converted["_BallProgress"].Parent = Converted["_Ball"]

Converted["_UIPadding7"].PaddingBottom = UDim.new(0, 2)
Converted["_UIPadding7"].PaddingTop = UDim.new(0, 1)
Converted["_UIPadding7"].Parent = Converted["_Ball"]

Converted["_themedColor1"].Value = "accentColor"
Converted["_themedColor1"].Name = "themedColor"
Converted["_themedColor1"].Parent = Converted["_Ball"]

Converted["_UICorner9"].CornerRadius = UDim.new(1, 0)
Converted["_UICorner9"].Parent = Converted["_Ball"]

Converted["_UIPadding8"].PaddingBottom = UDim.new(0, 6)
Converted["_UIPadding8"].PaddingLeft = UDim.new(0, 6)
Converted["_UIPadding8"].PaddingRight = UDim.new(0, 6)
Converted["_UIPadding8"].PaddingTop = UDim.new(0, 6)
Converted["_UIPadding8"].Parent = Converted["_Track"]

Converted["_TrackProgress"].Font = Enum.Font.GothamBold
Converted["_TrackProgress"].Text = "0"
Converted["_TrackProgress"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TrackProgress"].TextScaled = true
Converted["_TrackProgress"].TextTransparency = 1
Converted["_TrackProgress"].TextXAlignment = Enum.TextXAlignment.Right
Converted["_TrackProgress"].AnchorPoint = Vector2.new(1, 0.5)
Converted["_TrackProgress"].BackgroundTransparency = 1
Converted["_TrackProgress"].BorderSizePixel = 0
Converted["_TrackProgress"].Position = UDim2.new(1, 0, 0.5, 0)
Converted["_TrackProgress"].Size = UDim2.new(0, 35, 1, 0)
Converted["_TrackProgress"].Name = "TrackProgress"
Converted["_TrackProgress"].Parent = Converted["_Track"]

Converted["_themedColor2"].Value = "secondaryColor"
Converted["_themedColor2"].Name = "themedColor"
Converted["_themedColor2"].Parent = Converted["_Track"]

Converted["_UISizeConstraint"].Parent = Converted["_Frame1"]

Converted["_UICorner10"].CornerRadius = UDim.new(1, 0)
Converted["_UICorner10"].Parent = Converted["_Range"]

Converted["_themedColor3"].Value = "primaryColor"
Converted["_themedColor3"].Name = "themedColor"
Converted["_themedColor3"].Parent = Converted["_Range"]

Converted["_FloatingButton"].Text = "Shoot into murderer"
Converted["_FloatingButton"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_FloatingButton"].TextScaled = true
Converted["_FloatingButton"].TextWrapped = true
Converted["_FloatingButton"].AutoButtonColor = false
Converted["_FloatingButton"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_FloatingButton"].BackgroundColor3 = Color3.fromRGB(31, 31, 31)
Converted["_FloatingButton"].BorderSizePixel = 0
Converted["_FloatingButton"].ClipsDescendants = true
Converted["_FloatingButton"].Position = UDim2.new(0, 125, 0, 40)
Converted["_FloatingButton"].Size = UDim2.new(0, 50, 0, 100)
Converted["_FloatingButton"].Visible = false
Converted["_FloatingButton"].Name = "FloatingButton"
Converted["_FloatingButton"].Parent = Converted["_YARHM"]

Converted["_UIPadding9"].PaddingBottom = UDim.new(0, 5)
Converted["_UIPadding9"].PaddingLeft = UDim.new(0, 5)
Converted["_UIPadding9"].PaddingRight = UDim.new(0, 5)
Converted["_UIPadding9"].PaddingTop = UDim.new(0, 5)
Converted["_UIPadding9"].Parent = Converted["_FloatingButton"]

Converted["_UICorner11"].Parent = Converted["_FloatingButton"]

Converted["_UIStroke1"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
Converted["_UIStroke1"].Color = Color3.fromRGB(255, 255, 255)
Converted["_UIStroke1"].Parent = Converted["_FloatingButton"]

Converted["_Lock"].Font = Enum.Font.Gotham
Converted["_Lock"].Text = "🔒"
Converted["_Lock"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Lock"].TextScaled = true
Converted["_Lock"].TextWrapped = true
Converted["_Lock"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Lock"].BackgroundTransparency = 1
Converted["_Lock"].BorderSizePixel = 0
Converted["_Lock"].Position = UDim2.new(1, -10, 1, -10)
Converted["_Lock"].Size = UDim2.new(0, 20, 0, 20)
Converted["_Lock"].ZIndex = 999999999
Converted["_Lock"].Name = "Lock"
Converted["_Lock"].Parent = Converted["_FloatingButton"]

Converted["_UIScale"].Scale = 1e-7
Converted["_UIScale"].Parent = Converted["_Lock"]

Converted["_Ripple"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Ripple"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Ripple"].BackgroundTransparency = 1
Converted["_Ripple"].BorderSizePixel = 0
Converted["_Ripple"].Size = UDim2.new(0, 100, 0, 100)
Converted["_Ripple"].Name = "Ripple"
Converted["_Ripple"].Parent = Converted["_FloatingButton"]

Converted["_UICorner12"].CornerRadius = UDim.new(1, 0)
Converted["_UICorner12"].Parent = Converted["_Ripple"]

Converted["_UIScale1"].Parent = Converted["_FloatingButton"]

Converted["_Dropdown"].BackgroundTransparency = 1
Converted["_Dropdown"].BorderSizePixel = 0
Converted["_Dropdown"].Size = UDim2.new(1, 0, 0, 35)
Converted["_Dropdown"].Visible = false
Converted["_Dropdown"].Name = "Dropdown"
Converted["_Dropdown"].Parent = Converted["_YARHM"]

Converted["_TextLabel2"].Text = "Loop walkspeed and FOV"
Converted["_TextLabel2"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel2"].TextScaled = true
Converted["_TextLabel2"].TextWrapped = true
Converted["_TextLabel2"].TextXAlignment = Enum.TextXAlignment.Left
Converted["_TextLabel2"].BackgroundTransparency = 1
Converted["_TextLabel2"].BorderSizePixel = 0
Converted["_TextLabel2"].Size = UDim2.new(0.7, 0, 1, 0)
Converted["_TextLabel2"].Parent = Converted["_Dropdown"]

Converted["_UIListLayout3"].Padding = UDim.new(0, 15)
Converted["_UIListLayout3"].FillDirection = Enum.FillDirection.Horizontal
Converted["_UIListLayout3"].HorizontalAlignment = Enum.HorizontalAlignment.Center
Converted["_UIListLayout3"].SortOrder = Enum.SortOrder.LayoutOrder
Converted["_UIListLayout3"].Parent = Converted["_Dropdown"]

Converted["_UIPadding10"].PaddingLeft = UDim.new(0.07, 0)
Converted["_UIPadding10"].PaddingRight = UDim.new(0.07, 0)
Converted["_UIPadding10"].Parent = Converted["_Dropdown"]

Converted["_Frame2"].Font = Enum.Font.Gotham
Converted["_Frame2"].Text = "Select..."
Converted["_Frame2"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Frame2"].TextScaled = true
Converted["_Frame2"].TextWrapped = true
Converted["_Frame2"].Active = false
Converted["_Frame2"].BackgroundColor3 = Color3.fromRGB(31, 31, 31)
Converted["_Frame2"].BackgroundTransparency = -0.04
Converted["_Frame2"].BorderSizePixel = 0
Converted["_Frame2"].Selectable = false
Converted["_Frame2"].Size = UDim2.new(0.4, 0, 1, 0)
Converted["_Frame2"].Name = "Frame"
Converted["_Frame2"].Parent = Converted["_Dropdown"]

Converted["_UIPadding11"].PaddingBottom = UDim.new(0, 7)
Converted["_UIPadding11"].PaddingLeft = UDim.new(0, 7)
Converted["_UIPadding11"].PaddingRight = UDim.new(0, 7)
Converted["_UIPadding11"].PaddingTop = UDim.new(0, 7)
Converted["_UIPadding11"].Parent = Converted["_Frame2"]

Converted["_UICorner13"].Parent = Converted["_Frame2"]

-- (Pulando propriedades redundantes - elas são as mesmas do original)
-- Continuação completa das propriedades e módulos na PARTE 2
