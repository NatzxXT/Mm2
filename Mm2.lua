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
-- Routine Module Scripts:

local routine_module_scripts = {}

do -- StarterGui.YARHM.FUNCTIONS
    local script = Instance.new("ModuleScript")
    script.Name = "FUNCTIONS"
    script.Parent = Converted["_YARHM"]
    local function module_script()
    -- © Aetherion 2026
        local FUNCTIONSmodule = {}
        FUNCTIONSmodule.__v = "1.21.6"
        local ts = game:GetService("TweenService")
        local https = game:GetService("HttpService")
        function DraggableObjectf()
            local function a(b,c)local d=c.AbsoluteSize;local e=c.AbsolutePosition;local f=b.X.Scale*d.X+b.X.Offset;local g=b.Y.Scale*d.Y+b.Y.Offset;local h=math.clamp(f,0,d.X)local i=math.clamp(g,0,d.Y)local j=UDim2.new(b.X.Scale,h-b.X.Scale*d.X,b.Y.Scale,i-b.Y.Scale*d.Y)return j end;local k=UDim2.new;local l=game:GetService("UserInputService")local m=game:GetService("TweenService")local n={}n.__index=n;function n.new(o,p,q,r)local self={}self.Object=o;self.ToMove=p;self.Smooth=q;self.CallbackOnly=r;self.CanBeDragged=false;self.DragStarted=nil;self.DragEnded=nil;self.Dragged=nil;self.Dragging=false;self.LastPosition=nil;self.Velocity=Vector2.new(0,0)setmetatable(self,n)return self end;function n:Enable()self.CanBeDragged=true;local s=self.Object;local t=self.ToMove;local u=nil;local v=nil;local w=nil;local x=false;local function y(z)local A=z.Position-v;local B=UDim2.new(w.X.Scale,w.X.Offset+A.X,w.Y.Scale,w.Y.Offset+A.Y)if self.CallbackOnly then else B=a(B,self.Object:FindFirstAncestorWhichIsA("ScreenGui"))if(self.Smooth==nil or self.Smooth==true)and self.Smooth~=false then m:Create(t and t or s,TweenInfo.new(0.5,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out),{Position=B}):Play()else local C=t and t or s;C.Position=B end end;return B end;self.InputBegan=s.InputBegan:Connect(function(z)if z.UserInputType==Enum.UserInputType.MouseButton1 or z.UserInputType==Enum.UserInputType.Touch then x=true;local D;D=z.Changed:Connect(function()if z.UserInputState==Enum.UserInputState.End and(self.Dragging or x)then self.Dragging=false;D:Disconnect()if self.DragEnded and not x then self.DragEnded(self.Velocity)end;x=false end end)end end)self.InputChanged=s.InputChanged:Connect(function(z)if z.UserInputType==Enum.UserInputType.MouseMovement or z.UserInputType==Enum.UserInputType.Touch then u=z end end)self.InputChanged2=l.InputChanged:Connect(function(z)if s.Parent==nil then self:Disable()return end;if x then x=false;if self.DragStarted then self.DragStarted()end;self.Dragging=true;v=z.Position;if t then w=t.Position else w=s.Position end;self.LastPosition=z.Position end;if z==u and self.Dragging then local B=y(z)self.Velocity=z.Position-self.LastPosition;self.LastPosition=z.Position;if self.Dragged then self.Dragged(B)end end end)end;function n:Disable()self.CanBeDragged=false;self.InputBegan:Disconnect()self.InputChanged:Disconnect()self.InputChanged2:Disconnect()if self.Dragging then self.Dragging=false;if self.DragEnded then self.DragEnded(self.Velocity)end end end;return n
        end
        local DraggableObject = DraggableObjectf()
        function ClickAndHoldf()
            local a={}a.__index=a;local b=game:GetService("UserInputService")function a.new(c,d)local self=setmetatable({},a)self.textButton=c;self.holdTime=d or 0.5;self.holdTask=nil;self.initialPosition=nil;self.Holded=Instance.new("BindableEvent")local function e(f,g)return math.sqrt((g.X-f.X)^2+(g.Y-f.Y)^2)end;self.textButton.MouseButton1Down:Connect(function(h,i)self.initialPosition=Vector2.new(h,i)self.holdTask=task.spawn(function()task.wait(self.holdTime)if self.holdTask then self.Holded:Fire()end end)end)b.InputChanged:Connect(function(j)if j.UserInputType==Enum.UserInputType.MouseMovement or j.UserInputType==Enum.UserInputType.Touch then if self.holdTask and self.initialPosition then local k=j.Position;local l=e(self.initialPosition,k)if l>10 then coroutine.close(self.holdTask)self.holdTask=nil end end end end)b.InputEnded:Connect(function(j)if j.UserInputType==Enum.UserInputType.MouseButton1 or j.UserInputType==Enum.UserInputType.Touch then if self.holdTask then coroutine.close(self.holdTask)self.holdTask=nil end;self.initialPosition=nil end end)return self end;return a
        end
        local ClickAndHold = ClickAndHoldf()
        function PointSavef()
            local _=false local function d(...)if _ then print("[PointSave DEBUG]:",...)end end getgenv()._FOLDERS=getgenv()._FOLDERS or{} getgenv()._FILES=getgenv()._FILES or{} isfolder=isfolder or function(_)d("Checking if folder exists:",_) return getgenv()._FOLDERS[_]~=nil end makefolder=makefolder or function(_)d("Creating folder:",_) getgenv()._FOLDERS[_]={} return getgenv()._FOLDERS[_]end isfile=isfile or function(_)d("Checking if file exists:",_) return getgenv()._FILES[_]~=nil end writefile=writefile or function(a,_)d("Writing file:",a,"with content:",_) getgenv()._FILES[a]=_ return getgenv()._FILES[a]end readfile=readfile or function(_)d("Reading file:",_) return getgenv()._FILES[_]end delfile=delfile or function(_)d("Deleting file:",_) getgenv()._FILES[_]=nil end listfiles=listfiles or function(c)d("Listing files in folder:",c) local _=getgenv()._FOLDERS[c] if _ then local a={} for b,_ in pairs(getgenv()._FILES)do if b:sub(1,#c+1)==c.."/"then local _=b:sub(#c+2) d("Found file in folder:",_) table.insert(a,_)end end return a end d("Folder does not exist:",c) return{}end local b={} b.__index=b local c="PointSaveData" local function _()if not isfolder(c)then d("Base folder not found, creating:",c) makefolder(c)else d("Base folder already exists:",c)end end function b.new(a)d("Initializing new PointSave instance for namespace:",a) _() local _=setmetatable({},b) _.namespace=a _.folderPath=c.."/"..a if not isfolder(_.folderPath)then d("Namespace folder does not exist, creating:",_.folderPath) makefolder(_.folderPath)else d("Namespace folder already exists:",_.folderPath)end return _ end function b:set(b,a)local _=self.folderPath.."/"..b..".txt" d("Setting value for key:",b,"->",a) writefile(_,tostring(a))end function b:get(a)local _=self.folderPath.."/"..a..".txt" d("Getting value for key:",a) if isfile(_)then local _=readfile(_) d("Found value for key:",a,"->",_) return _ end d("Key not found:",a) return nil end function b:remove(a)local _=self.folderPath.."/"..a..".txt" d("Removing key:",a) if isfile(_)then delfile(_) d("Removed file for key:",a)else d("File for key does not exist:",a)end end function b:clear()d("Clearing all keys in namespace:",self.namespace) local _=listfiles(self.folderPath) for _,_ in ipairs(_)do local _=self.folderPath.."/".._ if isfile(_)then d("Deleting file:",_) delfile(_)end end end function b.deleteNamespace(a)local b=c.."/"..a d("Deleting namespace:",a) local _=listfiles(b) for _,_ in ipairs(_)do local _=b.."/".._ if isfile(_)then d("Deleting file from namespace:",_) delfile(_)end end getgenv()._FOLDERS[b]=nil d("Deleted folder for namespace:",a)end function b.listNamespaces()d("Listing all namespaces") _() local b={} for a,_ in pairs(getgenv()._FOLDERS)do if a:sub(1,#c+1)==c.."/"then local _=a:sub(#c+2) d("Found namespace:",_) table.insert(b,_)end end return b end return b
        end
        local PointSave = PointSavef()
        function SBTf()
            local a=function()local a=function()local a={}local function b(c,d,e,f,g,h)local i=d*d-4*e/c;local j=-0.5;local k=d+math.sqrt(i)local l=d-math.sqrt(i)local m,n=j*k,j*l;local o,p=(n*f-g)/(n-m),(m*f-g)/(m-n)local q=h/e;return{Offset=function(r)return o*math.exp(m*r)+p*math.exp(n*r)+q end,Velocity=function(r)return o*m*math.exp(m*r)+p*n*math.exp(n*r)end,Acceleration=function(r)return o*m*m*math.exp(m*r)+p*n*n*math.exp(n*r)end}end;local function s(c,d,e,f,g,h)local i=-d/2;local j,k=f,g-i*f;local l=h/e;return{Offset=function(m)return math.exp(i*m)*(j+k*m)+l end,Velocity=function(m)return math.exp(i*m)*(k*i*m+j*i+k)end,Acceleration=function(m)return i*math.exp(i*m)*(k*i*m+j*i+2*k)end}end;local function t(c,d,e,f,g,h)local i=d*d-4*e/c;local j=-d/2;local k=math.sqrt(-i)local l,m=f,(g-j*f)/k;local n=h/e;return{Offset=function(o)return math.exp(j*o)*(l*math.cos(k*o)+m*math.sin(k*o))+n end,Velocity=function(o)return-math.exp(j*o)*((l*k-m*j)*math.sin(k*o)+(-m*k-l*j)*math.cos(k*o))end,Acceleration=function(o)return-math.exp(j*o)*((m*k*k+2*l*j*k-m*j*j)*math.sin(k*o)+(l*k*k-2*m*j*k-l*j*j)*math.cos(k*o))end}end;function a.F(c)local d,e,f=c.InitialOffset,c.InitialVelocity,c.ExternalForce;local g,h,i=c.Mass,c.Damping,c.Constant;local j=h*h-4*i/g;if j>0 then return b(g,h,i,d,e,f)elseif j==0 then return s(g,h,i,d,e,f)else return t(g,h,i,d,e,f)end end;return a end;local c=a()local d=math.sqrt;local e=math.pi;local f={OFFSET="Offset",VELOCITY="Velocity",ACCELERATION="Acceleration",GOAL="Goal",FREQUENCY="Frequency"}local g=""local h=""local i={}local j={}j.__index=function(k,l)local m={[f.OFFSET]=function()local m=tick()-k.StartTick;local n=k.F;local o=n.Offset(m)return o end,[f.VELOCITY]=function()local m=tick()-k.StartTick;local n=k.F;local o=n.Velocity(m)return o end,[f.ACCELERATION]=function()local m=tick()-k.StartTick;local n=k.F;local o=n.Acceleration(m)return o end,[f.GOAL]=function()local m=k.ExternalForce;local n=k.Constant;return m/n end,[f.FREQUENCY]=function()local m=k.Damping;local n=k.Constant;local o=k.Mass;return d(-m*m+4*n/o)/(2*e)end}local n=rawget(k,l)if n~=nil then return n end;local o=m[l]if o~=nil then return o()end;return j[l]end;j.__tostring=function(k)local l=tick()-k.StartTick;local m=k.F;local n=k.AdvancedObjectStringEnabled;local o;if not n then o=string.format(g,m.Offset(l),m.Velocity(l),m.Acceleration(l))else o=string.format(h,k.Mass,k.Damping,k.Constant,k.Goal,k.Frequency,k.InitialOffset,k.InitialVelocity,k.ExternalForce,k.StartTick,m.Offset(l),m.Velocity(l),m.Acceleration(l))end;return o end;function i.fromDurationAndBounce(k,l)local m=1;local n=(2*math.pi/k)^2*m;local o=2*l*math.sqrt(m*n)return{m,o,n}end;function i.new(k,l,m,n,o,p)assert(k>0,"Mass for spring system cannot be less than or equal to 0")assert(m>0,"Spring constant for spring system cannot be less than or equal to 0")n=n or 0;o=o or 0;p=p or 0;local q=p*m;local r={Mass=k,Damping=l,Constant=m,InitialOffset=n-p,InitialVelocity=o,ExternalForce=q,AdvancedObjectStringEnabled=false,StartTick=0}setmetatable(r,j)r:Reset()return r end;function i.fromFrequency(k,l,m,n,o,p)assert(k>0,"Mass for spring system cannot be less than or equal to 0")assert(m>0,"Spring frequency for spring system cannot be less than or equal to 0")local q=0.25*k*(4*e*e*m*m+l*l)n=n or 0;o=o or 0;p=p or 0;local r=p*q;local u={Mass=k,Damping=l,Constant=q,InitialOffset=n-p,InitialVelocity=o,ExternalForce=r,AdvancedObjectStringEnabled=false,StartTick=0}setmetatable(u,j)u:Reset()return u end;function j.Reset(k)k.F=c.F(k)k.StartTick=tick()end;function j.SetExternalForce(k,l)k.ExternalForce=l;k.InitialOffset=k.Offset-l/k.Constant;k.InitialVelocity=k.Velocity;k:Reset()end;function j.SetGoal(k,l)k.ExternalForce=l*k.Constant;k.InitialOffset=k.Offset-l;k.InitialVelocity=k.Velocity;k:Reset()end;function j.SetFrequency(k,l)k.Constant=0.25*k.Mass*(4*e*e*l*l+k.Damping*k.Damping)k.InitialOffset=k.Offset;k.InitialVelocity=k.Velocity;k:Reset()end;function j.SnapToCriticalDamping(k)k.Damping=2*d(k.Constant/k.Mass)k.InitialOffset=k.Offset;k.InitialVelocity=k.Velocity;k:Reset()end;function j.SetOffset(k,l,m)k.InitialOffset=l-k.Goal;k.InitialVelocity=m and 0 or k.Velocity;k:Reset()end;function j.AddOffset(k,l)k.InitialOffset=k.Offset+l;k.InitialVelocity=k.Velocity;k:Reset()end;function j.SetVelocity(k,l)k.InitialOffset=k.Offset;k.InitialVelocity=l;k:Reset()end;function j.AddVelocity(k,l)k.InitialOffset=k.Offset;k.InitialVelocity=k.Velocity+l;k:Reset()end;function j.Print(k)local l=tostring(k)print(l)end;return i end;local c=a()local d=game:GetService"RunService"local e={}e.__index=e;function e.fromDurationAndBounce(f,g)local h=1;local i=(2*math.pi/f)^2*h;local j=2*(1-g)*math.sqrt(h*i)return{h,j,i}end;local f={number=function(f,g,h,i,j)local k=c.new(h,i,j,f[g],0,f[g])return{springType="number",springSet={k},updateFunc=function()f[g]=k.Offset end,setGoal=function(l)k:SetGoal(l)end}end,UDim2=function(f,g,h,i,j)local k=c.new(h,i,j,f[g].X.Offset,0,f[g].X.Offset)local l=c.new(h,i,j,f[g].X.Scale,0,f[g].X.Scale)local m=c.new(h,i,j,f[g].Y.Offset,0,f[g].Y.Offset)local n=c.new(h,i,j,f[g].Y.Scale,0,f[g].Y.Scale)return{springType="UDim2",springSet={XOffset=k,XScale=l,YOffset=m,YScale=n},updateFunc=function()f[g]=UDim2.new(l.Offset,k.Offset,n.Offset,m.Offset)end,setGoal=function(o)k:SetGoal(o.X.Offset)l:SetGoal(o.X.Scale)m:SetGoal(o.Y.Offset)n:SetGoal(o.Y.Scale)end}end,Vector2=function(f,g,h,i,j)local k=c.new(h,i,j,f[g].X,0,f[g].X)local l=c.new(h,i,j,f[g].Y,0,f[g].Y)return{springType="Vector2",springSet={X=k,Y=l},updateFunc=function()f[g]=Vector2.new(k.Offset,l.Offset)end,setGoal=function(m)k:SetGoal(m.X)l:SetGoal(m.Y)end}end,Vector3=function(f,g,h,i,j)local k=c.new(h,i,j,f[g].X,0,f[g].X)local l=c.new(h,i,j,f[g].Y,0,f[g].Y)local m=c.new(h,i,j,f[g].Z,0,f[g].Z)return{springType="Vector3",springSet={k,l,m},updateFunc=function()f[g]=Vector3.new(k.Offset,l.Offset,m.Offset)end,setGoal=function(n)k:SetTarget(n.X)l:SetTarget(n.Y)m:SetTarget(n.Z)end}end}function e.new(g,h,i,j,k)assert(g[h],"Property does not exist on object")local l=typeof(g[h])local m=f[l]if m then local n=setmetatable({},e)n.obj=g;n.propertyName=h;n.updater=nil;local o=m(g,h,i,j,k)n.springType=o.springType;n.springSet=o.springSet;n.updateFunc=o.updateFunc;n.setGoal=o.setGoal;return n else error("Type not supported: "..l)end end;function e.Start(g)if g.updater then return end;for h,i in pairs(g.springSet)do i:Reset()end;g.updater=d.RenderStepped:Connect(function(h)g.updateFunc()end)end;function e.Stop(g)if g.updater then g.updater:Disconnect()g.updater=nil end end;function e.SetGoal(g,h)g.setGoal(h)end;function e.SetParameters(g,h,i,j)for k,l in pairs(g.springSet)do l.Mass=h;l.Stiffness=i;l.Damping=j;l:Reset()end end;return e
        end
        local SBT = SBTf()
        local YARHMPointSave = PointSave.new("YARHM")
        local States = {}
        local toggleStates = {}
        local rangeValueStates = {}
        local AREA = script.Parent.Menu.Area.Area
        local AREACONTAINER = script.Parent.Menu.Area
        local AREAModuleSelected = nil
        local fBSF = script.Parent.FloatingButtonSetting
        local adState = false
        local function udim2Serializer(value)
            if typeof(value) == "UDim2" then
                return string.format("%g,%g,%g,%g", value.X.Scale, value.X.Offset, value.Y.Scale, value.Y.Offset)
            elseif typeof(value) == "string" then
                local xScale, xOffset, yScale, yOffset = string.match(value, "([^,]+),([^,]+),([^,]+),([^,]+)")
                assert(xScale and xOffset and yScale and yOffset, "Invalid UDim2 string format")
                return UDim2.new(tonumber(xScale), tonumber(xOffset), tonumber(yScale), tonumber(yOffset))
            end
        end
        local function lrp(a,b,t) return a + (b - a) * t end
        function roundNumber(num, numDecimalPlaces) return tonumber(string.format("%." .. numDecimalPlaces .. "f", num)) end
        
        FUNCTIONSmodule.theme = {
            font = Enum.Font.Montserrat,
            textColor = Color3.fromRGB(255, 255, 255),
            accentColor = Color3.fromRGB(197, 0, 0),
            primaryColor = Color3.fromRGB(22, 22, 22),
            secondaryColor = Color3.fromRGB(12, 12, 12),
            backgroundColorCSQ = ColorSequence.new(Color3.fromRGB(36, 36, 36), Color3.fromRGB(68, 68, 68)),
            strokeColorCSQ = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(53, 53, 53)),
                ColorSequenceKeypoint.new(0.152, Color3.fromRGB(50.69, 50.69, 50.69)),
                ColorSequenceKeypoint.new(0.472, Color3.fromRGB(255, 0, 4)),
                ColorSequenceKeypoint.new(0.758, Color3.fromRGB(50.13, 50.13, 50.13)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(48, 48, 48))
            },
        }
        function FUNCTIONSmodule.getTheme()
            if getgenv then return getgenv().YARHM_THEME or FUNCTIONSmodule.theme else return FUNCTIONSmodule.theme end
        end
        function FUNCTIONSmodule.setTheme(t)
            FUNCTIONSmodule.theme = t
            if getgenv then getgenv().YARHM_THEME = t end
        end
        local floatingButtonObjects = {}
        local floatingButtonDraggers = {}
        local floatingButtonKeybinds = {}
        local floatingButtonConnections = {}
        local fBSFResizeDragger = nil
        getgenv().fBSFButton = nil
        getgenv().fBSFRealButton = nil
        getgenv().fBSF_ButtonDragger = nil
        local selected = Instance.new("ObjectValue")
        selected.Parent = script.Parent
        selected.Name = "Selected"
        local icons = {
            info = "rbxassetid://11780939099",
            x = "rbxassetid://10002373478",
            cross = "rbxassetid://10002373478",
            check = "rbxassetid://11604833061"
        }
        incomingNotif = false
        function FUNCTIONSmodule.to_base64(data)
            local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
            return ((data:gsub('.', function(x) 
                local r,b='',x:byte()
                for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
                return r;
            end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
                if (#x < 6) then return '' end
                local c=0
                for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
                return b:sub(c+1,c+1)
            end)..({ '', '==', '=' })[#data%3+1])
        end
        function FUNCTIONSmodule.from_base64(data)
            local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
            data = string.gsub(data, '[^'..b..'=]', '')
            return (data:gsub('.', function(x)
                if (x == '=') then return '' end
                local r,f='',(b:find(x)-1)
                for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
                return r;
            end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
                if (#x ~= 8) then return '' end
                local c=0
                for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
                return string.char(c)
            end))
        end
        function FUNCTIONSmodule.notification(s, color, icon)
            incomingNotif = true
            task.spawn(function()
                s = tostring(s)
                local notif = script.Parent.NotificationSample:Clone()
                notif.Parent = script.Parent
                notif.Position = UDim2.fromScale(0.5, -0.1)
                notif.UIScale.Scale = 0.5
                notif.Visible = true
                notif.Name = s
                if color and typeof(icon) == "Color3" then
                    notif.UIStroke.Color = color
                    notif.ImageLabel.ImageColor3 = color
                end
                if icon then
                    if icons[icon] then notif.ImageLabel.Image = icons[icon] else
                        if tonumber(icon) then notif.ImageLabel.Image = "rbxassetid://" .. tonumber(icon)
                        else notif.ImageLabel.Image = icon end
                    end
                end
                notif.TextLabel.MaxVisibleGraphemes = 0
                notif.TextLabel.Text = s
                notif:SetAttribute("close", false)
                ts:Create(notif, TweenInfo.new(0.7, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 0, 0, 10)}):Play()
                ts:Create(notif.UIScale, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Scale = 0.8}):Play()
                ts:Create(notif.TextLabel, TweenInfo.new(0.7, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {MaxVisibleGraphemes = #s}):Play()
                notif.Close.MouseButton1Click:Connect(function() notif:SetAttribute("close", true) end)
                task.wait()
                incomingNotif = false
                local lastclock = os.clock()
                repeat task.wait() until os.clock()-lastclock > 5 or incomingNotif or notif:GetAttribute("close")
                local finish = ts:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0.5, -0.1)})
                finish:Play()
                finish.Completed:Connect(function() notif:Destroy() end)
            end)
        end
        local lockMode = false
        function FUNCTIONSmodule.lockModeSet(s) lockMode = s end
        function FUNCTIONSmodule.closeFinetuneFB()
            for _, b in ipairs(script.Parent.FloatingButtons:GetChildren()) do
                if b:IsA("TextButton") and b:FindFirstChildWhichIsA("UIScale") then
                    local buttonScale = b:FindFirstChildWhichIsA("UIScale")
                    ts:Create(buttonScale, TweenInfo.new(0.3), {Scale = 1}):Play()
                end
            end
            local buttonScale = getgenv().fBSFButton:FindFirstChildWhichIsA("UIScale") or Instance.new("UIScale", getgenv().fBSFButton)
            ts:Create(buttonScale, TweenInfo.new(0.3), {Scale = 0}):Play()
            ts:Create(fBSF, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
            local done = ts:Create(fBSF.ControlBarContainer.UIScale, TweenInfo.new(0.3), {Scale = 0})
            done:Play()
            done.Completed:Wait()
            getgenv().fBSFButton:Destroy()
            fBSF.Visible = false
            getgenv().fBSFButton = nil
            getgenv().fBSFRealButton = nil
            getgenv().fBSF_ButtonDragger = nil
        end
        function FUNCTIONSmodule.finetuneFloatingButton(button, dragger)
            if getgenv().fBSFRealButton then return end
            getgenv().fBSFRealButton = button
            for _, b in ipairs(script.Parent.FloatingButtons:GetChildren()) do
                if b:IsA("TextButton") and b:FindFirstChildWhichIsA("UIScale") then
                    local buttonScale = b:FindFirstChildWhichIsA("UIScale")
                    ts:Create(buttonScale, TweenInfo.new(0.3), {Scale = 0}):Play()
                end
            end
            local finetuningButton = button:Clone()
            getgenv().fBSFButton = finetuningButton
            finetuningButton.Parent = fBSF
            finetuningButton.Name = "fBSFButton"
            finetuningButton.AnchorPoint = Vector2.new(0, 0)
            finetuningButton.Position = UDim2.fromOffset(button.AbsolutePosition.X, button.AbsolutePosition.Y + game:GetService("GuiService"):GetGuiInset().Y)
            fBSFResizeDragger = DraggableObject.new(finetuningButton, nil, nil, true)
            getgenv().fBSF_ButtonDragger = dragger
            local startingSize = finetuningButton.Size
            fBSFResizeDragger.DragStarted = function() startingSize = finetuningButton.Size end
            fBSFResizeDragger.Dragged = function(pos)
                local newSize = UDim2.fromOffset(math.clamp(startingSize.X.Offset + pos.X.Offset, 30, 500), math.clamp(startingSize.Y.Offset + pos.Y.Offset, 10, 350))
                ts:Create(finetuningButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = newSize}):Play()
                button.Size = newSize
                YARHMPointSave:set(string.gsub(button.Name, "_", ""), udim2Serializer(button.Position) .. "|" .. udim2Serializer(button.Size) .. "|" .. tostring(button.Visible) .. "|" .. tostring(dragger.CanBeDragged))
            end
            fBSFResizeDragger:Enable()
            fBSF.ControlBarContainer.UIScale.Scale = 0
            fBSF.BackgroundTransparency = 1
            fBSF.Visible = true
            ts:Create(fBSF, TweenInfo.new(0.3), {BackgroundTransparency = 0.5}):Play()
            ts:Create(fBSF.ControlBarContainer.UIScale, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
            ts:Create(finetuningButton, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5)}):Play()
            if finetuningButton.BackgroundTransparency == 1 then
                finetuningButton.Lock.TextTransparency = 0
                ts:Create(finetuningButton, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {BackgroundTransparency = 0.5, TextTransparency = 0.5}):Play()
                ts:Create(finetuningButton.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {Transparency = 0.5}):Play()
            end
        end
        function FUNCTIONSmodule.ftToggleLock()
            if getgenv().fBSF_ButtonDragger.CanBeDragged then
                getgenv().fBSF_ButtonDragger:Disable()
                getgenv().fBSFRealButton.Lock.UIScale.Scale = 1
                ts:Create(getgenv().fBSFButton.Lock.UIScale, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
            else
                getgenv().fBSF_ButtonDragger:Enable()
                getgenv().fBSFRealButton.Lock.UIScale.Scale = 0
                ts:Create(getgenv().fBSFButton.Lock.UIScale, TweenInfo.new(0.3), {Scale = 0}):Play()
            end
            YARHMPointSave:set(string.gsub(getgenv().fBSFRealButton.Name, "_", ""), udim2Serializer(getgenv().fBSFRealButton.Position) .. "|" .. udim2Serializer(getgenv().fBSFRealButton.Size) .. "|" .. tostring(getgenv().fBSFRealButton.Visible) .. "|" .. tostring(getgenv().fBSF_ButtonDragger.CanBeDragged))
        end
        function FUNCTIONSmodule.ftToggleVisibility()
            if getgenv().fBSFButton.BackgroundTransparency == 0 then
                getgenv().fBSFRealButton.BackgroundTransparency = 1
                getgenv().fBSFRealButton.TextTransparency = 1
                getgenv().fBSFRealButton.UIStroke.Transparency = 1
                getgenv().fBSFRealButton.Lock.TextTransparency = 1
                ts:Create(getgenv().fBSFButton, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {BackgroundTransparency = 0.5, TextTransparency = 0.5}):Play()
                ts:Create(getgenv().fBSFButton.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {Transparency = 0.5}):Play()
            else
                getgenv().fBSFRealButton.BackgroundTransparency = 0
                getgenv().fBSFRealButton.TextTransparency = 0
                getgenv().fBSFRealButton.UIStroke.Transparency = 0
                getgenv().fBSFRealButton.Lock.TextTransparency = 0
                ts:Create(getgenv().fBSFButton, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {BackgroundTransparency = 0, TextTransparency = 0}):Play()
                ts:Create(getgenv().fBSFButton.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {Transparency = 0}):Play()
            end
            YARHMPointSave:set(string.gsub(getgenv().fBSFRealButton.Name, "_", ""), udim2Serializer(getgenv().fBSFRealButton.Position) .. "|" .. udim2Serializer(getgenv().fBSFRealButton.Size) .. "|" .. tostring(getgenv().fBSFRealButton.Visible) .. "|" .. tostring(getgenv().fBSF_ButtonDragger.CanBeDragged))
        end
        function FUNCTIONSmodule.createFloatingButton(item,button,buttonname,fromload)
            if not getgenv().YARHM.FloatingButtons:FindFirstChild(string.gsub(buttonname, "_", "")) then
                local UserInputService = game:GetService("UserInputService")
                if not fromload then YARHMPointSave:set(string.gsub(buttonname, "_", ""), udim2Serializer(UDim2.fromOffset(125, 90)) .. "|" .. udim2Serializer(UDim2.fromOffset(200,50)) .. "|true|true") end
                local newFloatingButton = getgenv().YARHM.FloatingButton:Clone()
                newFloatingButton.Parent = getgenv().YARHM.FloatingButtons
                newFloatingButton.Name = string.gsub(buttonname, "_", "")
                newFloatingButton.Text = string.gsub(buttonname, "_", " ")
                newFloatingButton.BackgroundColor3 = FUNCTIONSmodule.getTheme().primaryColor
                local themedColor = Instance.new("StringValue", newFloatingButton)
                themedColor.Name = "themedColor"
                themedColor.Value = "primaryColor"
                newFloatingButton.Visible = true
                newFloatingButton.Font = Enum.Font.Montserrat
                table.insert(floatingButtonObjects, newFloatingButton)
                local floatingButtonObjectSelf = floatingButtonObjects[#floatingButtonObjects]
                newFloatingButton.MouseButton1Click:Connect(function()
                    if typeof(item["Args"][2]) == "function" then item["Args"][2](button)
                    else item["Args"][2][buttonname](button) end
                end)
                local ripple
                newFloatingButton.MouseButton1Down:Connect(function(x, y)
                    ts:Create(newFloatingButton.UIScale, TweenInfo.new(0.1), {Scale = 0.95}):Play()
                    ripple = newFloatingButton.Ripple:Clone()
                    ripple.BackgroundColor3 = FUNCTIONSmodule.getTheme().textColor
                    ripple.Parent = newFloatingButton
                    ripple.Position = UDim2.fromOffset(x - newFloatingButton.AbsolutePosition.X, (y - newFloatingButton.AbsolutePosition.Y) - game:GetService("GuiService"):GetGuiInset().Y)
                    ts:Create(ripple, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {BackgroundTransparency = 0.6, Size = UDim2.fromOffset(50, 50)}):Play()
                end)
                local function closeRipple()
                    if not getgenv().fBSFRealButton then ts:Create(newFloatingButton.UIScale, TweenInfo.new(0.1), {Scale = 1}):Play() end
                    if ripple then
                        task.spawn(function()
                            local rippleToRemove = ripple
                            local fade = ts:Create(rippleToRemove, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {BackgroundTransparency = 1, Size = UDim2.fromOffset(150, 150)})
                            fade:Play()
                            fade.Completed:Once(function() rippleToRemove:Destroy() end)
                        end)
                    end
                end
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then closeRipple() end
                end)
                local shouldBeDraggable = true
                if not fromload then newFloatingButton.Position = UDim2.fromOffset(-125, 90)
                elseif YARHMPointSave:get(string.gsub(buttonname, "_", "")) then
                    local data = YARHMPointSave:get(string.gsub(buttonname, "_", "")):split("|")
                    newFloatingButton.Position = udim2Serializer(data[1])
                    ts:Create(newFloatingButton, TweenInfo.new(2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Size = udim2Serializer(data[2])}):Play()
                    newFloatingButton.Visible = (data[3] == "true")
                    if data[4] == "false" then newFloatingButton.Lock.UIScale.Scale = 1; shouldBeDraggable = false end
                end
                task.spawn(function()
                    if not fromload then
                        ts:Create(newFloatingButton, TweenInfo.new(2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(200, 50)}):Play()
                        ts:Create(newFloatingButton, TweenInfo.new(0.7, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Position = UDim2.fromOffset(125, 90)}):Play()
                    end
                end)
                floatingButtonDraggers[string.gsub(buttonname, "_", "")] = DraggableObject.new(newFloatingButton)
                if shouldBeDraggable then floatingButtonDraggers[string.gsub(buttonname, "_", "")]:Enable() end
                floatingButtonDraggers[string.gsub(buttonname, "_", "")].Dragged = function(newPos)
                    YARHMPointSave:set(string.gsub(buttonname, "_", ""), udim2Serializer(newPos) .. "|" .. udim2Serializer(newFloatingButton.Size) .. "|" .. tostring(newFloatingButton.Visible) .. "|" .. tostring(floatingButtonDraggers[string.gsub(buttonname, "_", "")].CanBeDragged))
                end
                local holder = ClickAndHold.new(newFloatingButton)
                holder.Holded.Event:Connect(function()
                    if floatingButtonDraggers[string.gsub(buttonname, "_", "")].Dragging then return end
                    if ripple then ripple:Destroy() end
                    FUNCTIONSmodule.finetuneFloatingButton(floatingButtonObjectSelf, floatingButtonDraggers[string.gsub(buttonname, "_", "")])
                end)
                newFloatingButton.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton2 then
                        FUNCTIONSmodule.notification("Press a key to bind " .. string.gsub(buttonname, "_", "") .. " to...")
                        local keytobind; local result
                        repeat
                            result = UserInputService.InputBegan:Wait()
                            if result.UserInputType == Enum.UserInputType.Keyboard then keytobind = result.KeyCode end
                        until keytobind
                        FUNCTIONSmodule.notification(string.gsub(buttonname, "_", "") .. " binded to key " .. result.KeyCode.Name .. "!")
                        task.wait(0.1) floatingButtonKeybinds[string.gsub(buttonname, "_", "")] = keytobind
                    end
                end)
                local uis = game:GetService("UserInputService")
                if uis.KeyboardEnabled and uis.MouseEnabled then
                    floatingButtonConnections[string.gsub(buttonname, "_", "")] = uis.InputBegan:Connect(function(inp, processed)
                        if processed then return end
                        if inp.KeyCode == floatingButtonKeybinds[string.gsub(buttonname, "_", "")] then
                            if typeof(item["Args"][2]) == "function" then item["Args"][2](button)
                            else item["Args"][2][buttonname](button) end
                        end
                    end)
                end
            else
                floatingButtonKeybinds[string.gsub(buttonname, "_", "")] = nil
                if floatingButtonConnections[string.gsub(buttonname, "_", "")] then floatingButtonConnections[string.gsub(buttonname, "_", "")]:Disconnect() end
                YARHMPointSave:remove(string.gsub(buttonname, "_", ""))
                task.spawn(function()
                    local buttontodestroy = getgenv().YARHM.FloatingButtons:FindFirstChild(string.gsub(buttonname, "_", ""))
                    local btdtween = ts:Create(buttontodestroy, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Size = UDim2.new(0,0,0,0)})
                    btdtween:Play()
                    btdtween.Completed:Wait()
                    buttontodestroy:Destroy()
                end)
            end
        end
        function FUNCTIONSmodule.loadFloatingButtons()
            repeat task.wait() until getgenv().Modules
            for _, module in ipairs(getgenv().Modules) do
                for _, item in ipairs(module) do
                    if item["Type"] == "Button" then
                        local key = string.gsub(item["Args"][1], "_", "")
                        local saved = YARHMPointSave:get(key)
                        if saved then FUNCTIONSmodule.createFloatingButton(item, Instance.new("TextButton"), item["Args"][1], true) end
                    end
                end
            end
        end
        function FUNCTIONSmodule.loader(module)
            local AREAframes = {}
            for _, i in ipairs(AREA:GetChildren()) do if i:IsA("Frame") then table.insert(AREAframes, i) end end
            if #AREAframes > 5 then
                ts:Create(AREA, TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {CanvasPosition = Vector2.zero}):Play()
                for i=1, math.min(7, #AREAframes) do
                    task.wait(0.01)
                    ts:Create(AREAframes[i]:GetChildren()[1], TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {Position = UDim2.fromScale(2, 0)}):Play()
                end
                task.wait(0.18)
            end
            AREA:ClearAllChildren()
            if not adState then
                adState = true
                ts:Create(script.Parent.Menu.Ad, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {AnchorPoint = Vector2.new(1,0), Position = UDim2.fromScale(1,0), Size = UDim2.new(0.68, 0, 0.18, 0)}):Play()
                ts:Create(script.Parent.Menu.Ad.UICorner, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {BottomLeftRadius = UDim.new(0, 8), BottomRightRadius = UDim.new(0, 0), TopLeftRadius = UDim.new(0, 0), TopRightRadius = UDim.new(0, 16)}):Play()
            end
            local listlayout = Instance.new("UIListLayout")
            listlayout.Parent = AREA
            listlayout.Padding = UDim.new(0, 16)
            listlayout.FillDirection = Enum.FillDirection.Vertical
            listlayout.SortOrder = Enum.SortOrder.LayoutOrder
            listlayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            for _, item in ipairs(module) do
                local frameHolder = Instance.new("Frame")
                frameHolder.Name = "Holder"
                frameHolder.BackgroundTransparency = 1
                frameHolder.Size = UDim2.new(1,0,0,0)
                frameHolder.AutomaticSize = Enum.AutomaticSize.XY
                frameHolder.Parent = AREA
                if item["Type"] == "Text" then
                    local text = Instance.new("TextLabel", frameHolder)
                    text.BackgroundTransparency = 1
                    text.Text = item["Args"][1]
                    text.TextScaled = true
                    text.TextColor3 = FUNCTIONSmodule.getTheme().textColor
                    text.Font = Enum.Font.GothamBold
                    text.Size = UDim2.new(1,0,0,20)
                    text.TextXAlignment = item["Args"][2] == "center" and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left
                    text.RichText = true
                elseif item["Type"] == "Button" then
                    local button = getgenv().YARHM.MenuButton:Clone()
                    button.Visible = true
                    button.Parent = frameHolder
                    button.BackgroundColor3 = FUNCTIONSmodule.getTheme().primaryColor
                    button.Text = item["Args"][1]
                    button.TextColor3 = FUNCTIONSmodule.getTheme().textColor
                    button.MouseButton1Click:Connect(function() item["Args"][2](button) end)
                    local cah = ClickAndHold.new(button, 0.5)
                    cah.Holded.Event:Connect(function() FUNCTIONSmodule.createFloatingButton(item, button, item["Args"][1]) end)
                elseif item["Type"] == "ButtonGrid" then
                    local frame = Instance.new("Frame", frameHolder)
                    frame.Size = UDim2.new(1, 0, 0, 0)
                    frame.AutomaticSize = Enum.AutomaticSize.Y
                    frame.BackgroundTransparency = 1
                    local gridlayout = Instance.new("UIGridLayout", frame)
                    gridlayout.CellSize = UDim2.new((1 / item["Args"][1]) - 0.03, 0, 0, 30)
                    for buttonname, args in item["Args"][2] do
                        local button = Instance.new("TextButton", frame)
                        button.BackgroundColor3 = FUNCTIONSmodule.getTheme().primaryColor
                        if States[buttonname .. module.Name] then button.BackgroundColor3 = FUNCTIONSmodule.getTheme().accentColor end
                        button.Text = string.gsub(buttonname, "_", " ")
                        button.TextScaled = true
                        button.TextColor3 = FUNCTIONSmodule.getTheme().textColor
                        button.Font = Enum.Font.GothamBold
                        local padding = Instance.new("UIPadding", button)
                        padding.PaddingTop = UDim.new(0, 5)
                        padding.PaddingBottom = UDim.new(0, 5)
                        padding.PaddingLeft = UDim.new(0, 8)
                        padding.PaddingRight = UDim.new(0, 8)
                        Instance.new("UICorner", button).CornerRadius = UDim.new(1, 0)
                        button.MouseButton1Click:Connect(function()
                            if item["Toggleable"] then
                                item["Args"][2][buttonname](button)
                                if States[buttonname .. module.Name] then
                                    ts:Create(button, TweenInfo.new(0.3), {BackgroundColor3 = FUNCTIONSmodule.getTheme().primaryColor}):Play()
                                    States[buttonname .. module.Name] = false
                                else
                                    ts:Create(button, TweenInfo.new(0.3), {BackgroundColor3 = FUNCTIONSmodule.getTheme().accentColor}):Play()
                                    States[buttonname .. module.Name] = true
                                end
                            else item["Args"][2][buttonname](button) end
                        end)
                        local cah = ClickAndHold.new(button, 0.5)
                        cah.Holded.Event:Connect(function() FUNCTIONSmodule.createFloatingButton(item, button, buttonname) end)
                    end
                elseif item["Type"] == "Input" then
                    local cloneinput = getgenv().YARHM.TextBoxPlaceholder:Clone()
                    cloneinput.Parent = frameHolder
                    cloneinput.Visible = true
                    cloneinput.TextBox.PlaceholderText = item["Args"][1]
                    cloneinput.TextButton.Text = item["Args"][2]
                    cloneinput.TextBox.TextColor3 = FUNCTIONSmodule.getTheme().textColor
                    cloneinput.TextButton.TextColor3 = FUNCTIONSmodule.getTheme().textColor
                    cloneinput.TextBox.BackgroundColor3 = FUNCTIONSmodule.getTheme().primaryColor
                    cloneinput.TextButton.BackgroundColor3 = FUNCTIONSmodule.getTheme().primaryColor
                    cloneinput.TextButton.MouseButton1Click:Connect(function() item["Args"][3](cloneinput.TextButton, cloneinput.TextBox.Text) end)
                elseif item["Type"] == "Toggle" then
                    local clonetoggle = getgenv().YARHM.Toggle:Clone()
                    clonetoggle.Parent = frameHolder
                    clonetoggle.Visible = true
                    clonetoggle.TextLabel.Text = item["Args"][1]
                    clonetoggle.TextLabel.TextColor3 = FUNCTIONSmodule.getTheme().textColor
                    clonetoggle.TextLabel.Font = Enum.Font.Montserrat
                    local clonetoggletoggler = clonetoggle.Frame.Frame.Toggler
                    clonetoggletoggler.ImageLabel.Image = "rbxassetid://5959696880"
                    clonetoggletoggler.ImageLabel.ImageTransparency = 1
                    clonetoggletoggler.ImageLabel.ImageColor3 = FUNCTIONSmodule.getTheme().accentColor
                    clonetoggletoggler.Parent.BackgroundColor3 = FUNCTIONSmodule.getTheme().secondaryColor
                    if toggleStates[item["Args"][1] .. module.Name] then
                        clonetoggletoggler.Position = UDim2.fromScale(1, 0.5)
                        clonetoggletoggler.AnchorPoint = Vector2.new(1, 0.5)
                        clonetoggletoggler.ImageLabel.ImageTransparency = 0
                    end
                    clonetoggletoggler.MouseButton1Click:Connect(function()
                        if toggleStates[item["Args"][1] .. module.Name] then
                            toggleStates[item["Args"][1] .. module.Name] = false
                            ts:Create(clonetoggletoggler, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0, 0.5), AnchorPoint = Vector2.new(0, 0.5)}):Play()
                            ts:Create(clonetoggletoggler.ImageLabel, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
                        else
                            toggleStates[item["Args"][1] .. module.Name] = true
                            ts:Create(clonetoggletoggler, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Position = UDim2.fromScale(1, 0.5), AnchorPoint = Vector2.new(1, 0.5)}):Play()
                            ts:Create(clonetoggletoggler.ImageLabel, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
                        end
                        item["Args"][2](clonetoggletoggler, toggleStates[item["Args"][1] .. module.Name])
                    end)
                elseif item["Type"] == "Dropdown" then
                    local clonedropdown = getgenv().YARHM.Dropdown:Clone()
                    local dropdownFrame = getgenv().YARHM.DropdownFrameSample
                    clonedropdown.Parent = frameHolder
                    clonedropdown.Visible = true
                    clonedropdown.TextLabel.Text = item["Args"][1]
                    clonedropdown.Frame.MouseButton1Click:Connect(function()
                        for _, v in ipairs(dropdownFrame.ScrollingFrame:GetChildren()) do if v:IsA("TextButton") and v.Name ~= "Sample" then v:Destroy() end end
                        local mouse = game.Players.LocalPlayer:GetMouse()
                        dropdownFrame.Position = UDim2.fromOffset(mouse.X, mouse.Y - 55)
                        dropdownFrame.Size = UDim2.new(0,108/2,0,0)
                        dropdownFrame.Visible = true
                        ts:Create(dropdownFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(108, 239)}):Play()
                        local items
                        if typeof(item["Args"][2]) == "function" then items = item["Args"][2]() else items = item["Args"][2] end
                        for _, v in ipairs(items) do
                            local clonedropdownbutton = dropdownFrame.ScrollingFrame.Sample:Clone()
                            clonedropdownbutton.Parent = dropdownFrame.ScrollingFrame
                            clonedropdownbutton.Name = v
                            clonedropdownbutton.Visible = true
                            clonedropdownbutton.Text = v
                            clonedropdownbutton.MouseButton1Click:Connect(function()
                                clonedropdown.Frame.Text = v
                                item["Args"][3](clonedropdown.Frame, v)
                                local after = ts:Create(dropdownFrame, TweenInfo.new(0.1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(108/2, 0)})
                                after:Play()
                                after.Completed:Once(function() dropdownFrame.Visible = false end)
                            end)
                        end
                    end)
                elseif item["Type"] == "Range" then
                    local clonerange = getgenv().YARHM.Range:Clone()
                    clonerange.Parent = frameHolder
                    clonerange.Visible = true
                    clonerange.TextLabel.Text = item["Args"][1]
                    clonerange.TextLabel.TextColor3 = FUNCTIONSmodule.getTheme().textColor
                    clonerange.TextLabel.Font = Enum.Font.Montserrat
                    clonerange.Frame.Track.Ball.BackgroundColor3 = FUNCTIONSmodule.getTheme().accentColor
                    clonerange.Frame.Track.BackgroundColor3 = FUNCTIONSmodule.getTheme().secondaryColor
                    if not rangeValueStates[item["Args"][1] .. module.Name] then rangeValueStates[item["Args"][1] .. module.Name] = item["Args"][2] end
                    clonerange.Frame.Track.Ball.Size = UDim2.new(lrp(0.06, 1, rangeValueStates[item["Args"][1] .. module.Name] / item["Args"][3]), 0, 1, 0)
                    local slider = DraggableObject.new(clonerange.Frame, nil, false, true)
                    slider:Enable()
                    local relativeSlide = nil
                    slider.Dragged = function(pos)
                        if not relativeSlide then relativeSlide = pos end
                        local dragDistance = pos - relativeSlide
                        local resolvedVal = rangeValueStates[item["Args"][1] .. module.Name]
                        local deltaChange = dragDistance.X.Offset
                        if math.abs(deltaChange) * 2 > item["Args"][4] then
                            resolvedVal = math.clamp(resolvedVal + deltaChange, 0, item["Args"][3])
                            relativeSlide = pos
                            if item["Args"][4] > 1 then resolvedVal = math.round(resolvedVal) end
                            rangeValueStates[item["Args"][1] .. module.Name] = resolvedVal
                        end
                        clonerange.Frame.Track.Ball.Size = UDim2.new(lrp(0.06, 1, resolvedVal / item["Args"][3]), 0, 1, 0)
                        clonerange.Frame.Track.Ball.BallProgress.Text = roundNumber(resolvedVal, 2)
                        clonerange.Frame.Track.TrackProgress.Text = tostring(resolvedVal, 2)
                        if resolvedVal > item["Args"][3] / 2 then
                            ts:Create(clonerange.Frame.Track.Ball.BallProgress, TweenInfo.new(0.2), {TextTransparency = 0, TextStrokeTransparency = 0}):Play()
                            ts:Create(clonerange.Frame.Track.TrackProgress, TweenInfo.new(0.2), {TextTransparency = 1, TextStrokeTransparency = 1}):Play()
                        else
                            ts:Create(clonerange.Frame.Track.Ball.BallProgress, TweenInfo.new(0.2), {TextTransparency = 1, TextStrokeTransparency = 1}):Play()
                            ts:Create(clonerange.Frame.Track.TrackProgress, TweenInfo.new(0.2), {TextTransparency = 0, TextStrokeTransparency = 0}):Play()
                        end
                        rangeValueStates[item["Args"][1] .. module.Name] = resolvedVal
                        if item["Args"][5] then item["Args"][5](clonerange, resolvedVal) end
                    end
                    slider.DragEnded = function()
                        relativeSlide = nil
                        ts:Create(clonerange.Frame.Track.Ball.BallProgress, TweenInfo.new(0.2), {TextTransparency = 1, TextStrokeTransparency = 1}):Play()
                        ts:Create(clonerange.Frame.Track.TrackProgress, TweenInfo.new(0.2), {TextTransparency = 1, TextStrokeTransparency = 1}):Play()
                    end
                end
            end
            AREACONTAINER.Area.Position = UDim2.fromScale(0.5, 0.5)
            ts:Create(AREACONTAINER.Area, TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0.5, 0.5)}):Play()
            ts:Create(listlayout, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Padding = UDim.new(0, 7)}):Play()
        end
        function FUNCTIONSmodule.refreshlist()
            for _, v in ipairs(script.Parent.Menu.List.ScrollingFrame:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
            local dense = {}
            for _, module in pairs(getgenv().Modules) do if module then table.insert(dense, module) end end
            if not AREAModuleSelected then AREAModuleSelected = dense[1] end
            for i, module in ipairs(dense) do
                local success, err = pcall(function()
                    local listbutton = getgenv().YARHM.ListButton:Clone()
                    listbutton.Parent = script.Parent.Menu.List.ScrollingFrame
                    listbutton.Name = module.Name
                    listbutton.Text = module.Name
                    listbutton.BackgroundColor3 = FUNCTIONSmodule.getTheme().primaryColor
                    listbutton.Visible = true
                    local themedColor = Instance.new("StringValue", listbutton)
                    themedColor.Name = "themedColor"
                    themedColor.Value = "primaryColor"
                    listbutton.MouseButton1Click:Connect(function()
                        if selected.Value then ts:Create(selected.Value, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = FUNCTIONSmodule.getTheme().primaryColor, TextColor3 = FUNCTIONSmodule.getTheme().textColor}):Play() end
                        selected.Value = listbutton
                        AREAModuleSelected = module
                        ts:Create(selected.Value, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(255,255,255), TextColor3 = Color3.fromRGB(0,0,0)}):Play()
                        FUNCTIONSmodule.loader(module)
                    end)
                    listbutton.MouseButton1Down:Connect(function() ts:Create(listbutton, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1, -10, 0, 40)}):Play() end)
                    listbutton.MouseButton1Up:Connect(function() ts:Create(listbutton, TweenInfo.new(1.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 50)}):Play() end)
                    listbutton.MouseLeave:Connect(function() ts:Create(listbutton, TweenInfo.new(1.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 50)}):Play() end)
                end)
                if not success then warn(("[YARHM] Error loading module %q: %s"):format(module.Name, err)) end
            end
        end
        function FUNCTIONSmodule.refresharea() FUNCTIONSmodule.loader(AREAModuleSelected) end
        function FUNCTIONSmodule.dialog(title, description, buttons)
            local dialog = script.Parent.Dialog
            dialog.DialogTitle.Text = title
            dialog.DialogDesc.Text = description
            for _,v in ipairs(dialog.Options:GetChildren()) do if v:IsA("TextButton") and v.Name ~= "OptionPlaceholder" then v:Destroy() end end
            for _, button in buttons do
                local newButton = dialog.Options.OptionPlaceholder:Clone()
                newButton.Visible = true
                newButton.Name = button
                newButton.Text = button
                newButton.Parent = dialog.Options
                newButton.MouseButton1Click:Connect(function() newButton.Parent.Parent.OnSelect:Fire(newButton.Name) end)
            end
            ts:Create(dialog, TweenInfo.new(1.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out),{Size = UDim2.fromOffset(313, 147)}):Play()
            ts:Create(dialog.UIScale, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out),{Scale = 1}):Play()
        end
        function FUNCTIONSmodule.closedialog()
            local dialog = script.Parent.Dialog
            ts:Create(dialog, TweenInfo.new(1.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),{Size = UDim2.fromOffset(0, 147)}):Play()
            ts:Create(dialog.UIScale, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out),{Scale = 0}):Play()
        end
        function FUNCTIONSmodule.waitfordialog() return script.Parent.Dialog.OnSelect.Event:Wait() end
        getgenv().YARHMFUNCTIONS = FUNCTIONSmodule
        return FUNCTIONSmodule
    end
    routine_module_scripts[script] = module_script
end

do -- StarterGui.YARHM.DraggableObject
    local script = Instance.new("ModuleScript")
    script.Name = "DraggableObject"
    script.Parent = Converted["_YARHM"]
    local function module_script()
    -- © Aetherion 2026
        local function a(b,c)local d=c.AbsoluteSize;local e=c.AbsolutePosition;local f=b.X.Scale*d.X+b.X.Offset;local g=b.Y.Scale*d.Y+b.Y.Offset;local h=math.clamp(f,0,d.X)local i=math.clamp(g,0,d.Y)local j=UDim2.new(b.X.Scale,h-b.X.Scale*d.X,b.Y.Scale,i-b.Y.Scale*d.Y)return j end;local k=UDim2.new;local l=game:GetService("UserInputService")local m=game:GetService("TweenService")local n={}n.__index=n;function n.new(o,p,q,r)local self={}self.Object=o;self.ToMove=p;self.Smooth=q;self.CallbackOnly=r;self.DragStarted=nil;self.DragEnded=nil;self.Dragged=nil;self.Dragging=false;self.LastPosition=nil;self.Velocity=Vector2.new(0,0)setmetatable(self,n)return self end;function n:Enable()local s=self.Object;local t=self.ToMove;local u=nil;local v=nil;local w=nil;local x=false;local function y(z)local A=z.Position-v;local B=UDim2.new(w.X.Scale,w.X.Offset+A.X,w.Y.Scale,w.Y.Offset+A.Y)if self.CallbackOnly then else B=a(B,self.Object:FindFirstAncestorWhichIsA("ScreenGui"))if(self.Smooth==nil or self.Smooth==true)and self.Smooth~=false then m:Create(t and t or s,TweenInfo.new(0.5,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out),{Position=B}):Play()else local C=t and t or s;C.Position=B end end;return B end;self.InputBegan=s.InputBegan:Connect(function(z)if z.UserInputType==Enum.UserInputType.MouseButton1 or z.UserInputType==Enum.UserInputType.Touch then x=true;local D;D=z.Changed:Connect(function()if z.UserInputState==Enum.UserInputState.End and(self.Dragging or x)then self.Dragging=false;D:Disconnect()if self.DragEnded and not x then self.DragEnded(self.Velocity)end;x=false end end)end end)self.InputChanged=s.InputChanged:Connect(function(z)if z.UserInputType==Enum.UserInputType.MouseMovement or z.UserInputType==Enum.UserInputType.Touch then u=z end end)self.InputChanged2=l.InputChanged:Connect(function(z)if s.Parent==nil then self:Disable()return end;if x then x=false;if self.DragStarted then self.DragStarted()end;self.Dragging=true;v=z.Position;if t then w=t.Position else w=s.Position end;self.LastPosition=z.Position end;if z==u and self.Dragging then local B=y(z)self.Velocity=z.Position-self.LastPosition;self.LastPosition=z.Position;if self.Dragged then self.Dragged(B)end end end)end;function n:Disable()self.InputBegan:Disconnect()self.InputChanged:Disconnect()self.InputChanged2:Disconnect()if self.Dragging then self.Dragging=false;if self.DragEnded then self.DragEnded(self.Velocity)end end end;return n
    end
    routine_module_scripts[script] = module_script
end

do -- StarterGui.YARHM.ClickAndHold
    local script = Instance.new("ModuleScript")
    script.Name = "ClickAndHold"
    script.Parent = Converted["_YARHM"]
    local function module_script()
    -- © Aetherion 2026
        local a={}a.__index=a;local b=game:GetService("UserInputService")function a.new(c,d)local self=setmetatable({},a)self.textButton=c;self.holdTime=d or 0.5;self.holdTask=nil;self.initialPosition=nil;self.Holded=Instance.new("BindableEvent")local function e(f,g)return math.sqrt((g.X-f.X)^2+(g.Y-f.Y)^2)end;self.textButton.MouseButton1Down:Connect(function(h,i)self.initialPosition=Vector2.new(h,i)self.holdTask=task.spawn(function()task.wait(self.holdTime)if self.holdTask then self.Holded:Fire()end end)end)b.InputChanged:Connect(function(j)if j.UserInputType==Enum.UserInputType.MouseMovement or j.UserInputType==Enum.UserInputType.Touch then if self.holdTask and self.initialPosition then local k=j.Position;local l=e(self.initialPosition,k)if l>10 then coroutine.close(self.holdTask)self.holdTask=nil end end end end)b.InputEnded:Connect(function(j)if j.UserInputType==Enum.UserInputType.MouseButton1 or j.UserInputType==Enum.UserInputType.Touch then if self.holdTask then coroutine.close(self.holdTask)self.holdTask=nil end;self.initialPosition=nil end end)return self end;return a
    end
    routine_module_scripts[script] = module_script
end

do -- StarterGui.YARHM.Spring
    local script = Instance.new("ModuleScript")
    script.Name = "Spring"
    script.Parent = Converted["_YARHM"]
    local function module_script()
    -- © Aetherion 2026
        local a=game:GetService("RunService")local b={}function OverDamping(c,d,e,f,g,h)local i=d*d-4*e/c;local j=-1/2;local k=d+math.sqrt(i)local l=d-math.sqrt(i)local m,n=j*k,j*l;local o,p=(n*f-g)/(n-m),(m*f-g)/(m-n)local q=h/e;return{Offset=function(r)return o*math.exp(m*r)+p*math.exp(n*r)+q end,Velocity=function(r)return o*m*math.exp(m*r)+p*n*math.exp(n*r)end,Acceleration=function(r)return o*m*m*math.exp(m*r)+p*n*n*math.exp(n*r)end}end;function CriticalDamping(c,d,e,f,g,h)local s=-d/2;local o,p=f,g-s*f;local q=h/e;return{Offset=function(r)return math.exp(s*r)*(o+p*r)+q end,Velocity=function(r)return math.exp(s*r)*(p*s*r+o*s+p)end,Acceleration=function(r)return s*math.exp(s*r)*(p*s*r+o*s+2*p)end}end;function UnderDamping(c,d,e,f,g,h)local i=d*d-4*e/c;local s=-d/2;local t=math.sqrt(-i)local o,p=f,(g-s*f)/t;local q=h/e;return{Offset=function(r)return math.exp(s*r)*(o*math.cos(t*r)+p*math.sin(t*r))+q end,Velocity=function(r)return-math.exp(s*r)*((o*t-p*s)*math.sin(t*r)+(-p*t-o*s)*math.cos(t*r))end,Acceleration=function(r)return-math.exp(s*r)*((p*t*t+2*o*s*t-p*s*s)*math.sin(t*r)+(o*t*t-2*p*s*t-o*s*s)*math.cos(t*r))end}end;function b.F(u)local f,g,h=u.InitialOffset,u.InitialVelocity,u.ExternalForce;local c,d,e=u.Mass,u.Damping,u.Constant;local i=d*d-4*e/c;if i>0 then return OverDamping(c,d,e,f,g,h)elseif i==0 then return CriticalDamping(c,d,e,f,g,h)else return UnderDamping(c,d,e,f,g,h)end end;local v=b;local w=math.sqrt;local x=math.pi;local y={OFFSET="Offset",VELOCITY="Velocity",ACCELERATION="Acceleration",GOAL="Goal",FREQUENCY="Frequency"}local z=[[.]]local A=[[.]]local u={}local B={}B.__index=function(self,C)local D={[y.OFFSET]=function()local r=tick()-self.StartTick;local E=self.F;local F=E.Offset(r)return F end,[y.VELOCITY]=function()local r=tick()-self.StartTick;local E=self.F;local G=E.Velocity(r)return G end,[y.ACCELERATION]=function()local r=tick()-self.StartTick;local E=self.F;local H=E.Acceleration(r)return H end,[y.GOAL]=function()local I=self.ExternalForce;local J=self.Constant;return I/J end,[y.FREQUENCY]=function()local K=self.Damping;local L=self.Constant;local M=self.Mass;return w(-K*K+4*L/M)/(2*x)end}local N=rawget(self,C)if N~=nil then return N end;local O=D[C]if O~=nil then return O()end;return B[C]end;B.__tostring=function(self)local r=tick()-self.StartTick;local E=self.F;local P=self.AdvancedObjectStringEnabled;local Q;if P==false then Q=string.format(z,E.Offset(r),E.Velocity(r),E.Acceleration(r))elseif P==true then Q=string.format(A,self.Mass,self.Damping,self.Constant,self.Goal,self.Frequency,self.InitialOffset,self.InitialVelocity,self.ExternalForce,self.StartTick,E.Offset(r),E.Velocity(r),E.Acceleration(r))end;return Q end;function u.new(M,K,L,f,g,R)assert(M>0,"Mass for spring system cannot be less than or equal to 0")assert(L>0,"Spring constant for spring system cannot be less than or equal to 0")f=f or 0;g=g or 0;R=R or 0;local S=R*L;local T={Mass=M,Damping=K,Constant=L,InitialOffset=f-R,InitialVelocity=g,ExternalForce=S,AdvancedObjectStringEnabled=false,StartTick=0}setmetatable(T,B)T:Reset()return T end;function u.fromFrequency(M,K,U,f,g,R)assert(M>0,"Mass for spring system cannot be less than or equal to 0")assert(U>0,"Spring frequency for spring system cannot be less than or equal to 0")local L=0.25*M*(4*x*x*U*U+K*K)f=f or 0;g=g or 0;R=R or 0;local S=R*L;local T={Mass=M,Damping=K,Constant=L,InitialOffset=f-R,InitialVelocity=g,ExternalForce=S,AdvancedObjectStringEnabled=false,StartTick=0}setmetatable(T,B)T:Reset()return T end;function B:Reset()self.F=v.F(self)self.StartTick=tick()end;function B:SetExternalForce(V)self.ExternalForce=V;self.InitialOffset=self.Offset-V/self.Constant;self.InitialVelocity=self.Velocity;self:Reset()end;function B:SetGoal(R)self.ExternalForce=R*self.Constant;self.InitialOffset=self.Offset-R;self.InitialVelocity=self.Velocity;self:Reset()end;function B:SetFrequency(U)self.Constant=0.25*self.Mass*(4*x*x*U*U+self.Damping*self.Damping)self.InitialOffset=self.Offset;self.InitialVelocity=self.Velocity;self:Reset()end;function B:SnapToCriticalDamping()self.Damping=2*w(self.Constant/self.Mass)self.InitialOffset=self.Offset;self.InitialVelocity=self.Velocity;self:Reset()end;function B:SetOffset(F,W)self.InitialOffset=F-self.Goal;self.InitialVelocity=W and 0 or self.Velocity;self:Reset()end;function B:AddOffset(F)self.InitialOffset=self.Offset+F;self.InitialVelocity=self.Velocity;self:Reset()end;function B:SetVelocity(G)self.InitialOffset=self.Offset;self.InitialVelocity=G;self:Reset()end;function B:AddVelocity(G)self.InitialOffset=self.Offset;self.InitialVelocity=self.Velocity+G;self:Reset()end;function B:Print()local X=tostring(self)print(X)end;return u
    end
    routine_module_scripts[script] = module_script
end

do -- StarterGui.YARHM.ESPIndicator
    local script = Instance.new("ModuleScript")
    script.Name = "ESPIndicator"
    script.Parent = Converted["_YARHM"]
    local function module_script()
    -- © Aetherion 2026
        local e={} e.__index=e local a=game:GetService("RunService") local _=game:GetService("Players") local b=game:GetService("HttpService") local l=game:GetService("TweenService") e.Groups={} e.TargetIndex={} e.Defaults={AccentColor=Color3.new(1,1,0),HighlightFillTransparency=0.7,HighlightOutlineTransparency=0,HighlightDepthMode=Enum.HighlightDepthMode.AlwaysOnTop,ArrowShow=false,ArrowEdgePadding=50,ArrowMinDistance=0,ArrowSize=UDim2.new(0,30,0,30),ArrowImage="rbxassetid://97136202386756",ArrowShowDistanceText=true,ArrowDistanceFont=Enum.Font.Montserrat,ArrowDistanceTextSize=18,ShowLabel=false,LabelText="Target",LabelMaxDistance=99999,LabelOffset=Vector3.new(0,2,0),Parent=game:GetService("CoreGui")} function e.new(b)local c=setmetatable({},e) c.Settings={} for a,_ in pairs(e.Defaults)do c.Settings[a]=(b and b[a]~=nil)and b[a]or _ end local _=c.Settings.Parent or _.LocalPlayer:WaitForChild("PlayerGui") c.ScreenGui=Instance.new("ScreenGui") c.ScreenGui.Name="ESPIndicators" c.ScreenGui.IgnoreGuiInset=true c.ScreenGui.ResetOnSpawn=false c.ScreenGui.Parent=_ c.ArrowTemplate=Instance.new("ImageLabel") c.ArrowTemplate.Name="ArrowTemplate" c.ArrowTemplate.Size=c.Settings.ArrowSize c.ArrowTemplate.AnchorPoint=Vector2.new(0.5,0.5) c.ArrowTemplate.BackgroundTransparency=1 c.ArrowTemplate.Image=c.Settings.ArrowImage c.ArrowTemplate.ImageColor3=c.Settings.AccentColor c.ArrowTemplate.Visible=false c.ArrowTemplate.Parent=c.ScreenGui c.Scaler=Instance.new("UIScale") c.Scaler.Name="Scaler" c.Scaler.Scale=0 c.Scaler.Parent=c.ArrowTemplate c.Indicators={} c._updateConn=a.RenderStepped:Connect(function()c:_update()end) c._cleanupConn=a.Heartbeat:Connect(function()c:_cleanupOrphanedArrows() c:_cleanupOrphanedHighlights() c:_cleanupOrphanedLabels()end) return c end function e:AddGroup(_)local a=e.Groups[_] if not a then a={enabled=true,properties={},targets={}} e.Groups[_]=a end return a end function e:GetGroup(_)return e.Groups[_]end function e:RemoveGroup(b)local _=e.Groups[b] if not _ then return false end for _,_ in ipairs(_.targets)do local c=e.TargetIndex[_] if c then for _,a in ipairs(c)do if a==b then table.remove(c,_) break end end if#c==0 then e.TargetIndex[_]=nil end end if not e.TargetIndex[_]then self:Remove(_)end end e.Groups[b]=nil return true end function e:ClearAllGroups()for a,_ in pairs(e.Groups)do self:RemoveGroup(a)end end function e:ToggleGroup(_,a)local b=e.Groups[_] if not b then return end b.enabled=(a~=nil)and a or not b.enabled for _,_ in ipairs(b.targets)do local _=self.Indicators[_] if _ then if _.Highlight then _.Highlight.Enabled=b.enabled end if _.Arrow then _.Arrow.Visible=b.enabled and self.Settings.ArrowShow end if _.Label then _.Label.Enabled=b.enabled end end end return b.enabled end function e:SetGroupProperty(_,a,b)local _=self:AddGroup(_) _.properties[a]=b for _,_ in ipairs(_.targets)do local _=self.Indicators[_] if _ then if a=="AccentColor"then if _.Highlight then _.Highlight.FillColor=b _.Highlight.OutlineColor=b end if _.Arrow then _.Arrow.ImageColor3=b end if _.DistanceLabel then _.DistanceLabel.TextColor3=b end if _.Label and _.Label:FindFirstChild("TextLabel")then _.Label.TextLabel.TextColor3=b end end end end end function e:Add(a,g)assert(a,"ESPIndicator:Add requires a non-nil target") g=g or{} local d=Instance.new("Highlight") d.Name="Highlight_"..b:GenerateGUID(false) d.Adornee=a d.FillTransparency=g.HighlightFillTransparency or self.Settings.HighlightFillTransparency d.FillColor=g.AccentColor or self.Settings.AccentColor d.OutlineColor=g.AccentColor or self.Settings.AccentColor d.OutlineTransparency=g.HighlightOutlineTransparency or self.Settings.HighlightOutlineTransparency d.DepthMode=g.HighlightDepthMode or self.Settings.HighlightDepthMode d.Parent=self.ScreenGui local c,_,e if(g.ArrowShow or self.Settings.ArrowShow)then c=self.ArrowTemplate:Clone() c.Name="Arrow_"..b:GenerateGUID(false) c.ImageColor3=g.AccentColor or self.Settings.AccentColor c.Visible=true c.Parent=self.ScreenGui _=c:FindFirstChild("Scaler") if(g.ArrowShowDistanceText or self.Settings.ArrowShowDistanceText)then e=Instance.new("TextLabel") e.Name="DistanceLabel" e.AnchorPoint=Vector2.new(0.5,0) e.BackgroundTransparency=1 e.Font=g.ArrowDistanceFont or self.Settings.ArrowDistanceFont e.TextSize=g.ArrowDistanceTextSize or self.Settings.ArrowDistanceTextSize e.TextColor3=g.AccentColor or self.Settings.AccentColor e.Parent=c end end local f if(g.ShowLabel or self.Settings.ShowLabel)then f=Instance.new("BillboardGui") f.Name="Label_"..b:GenerateGUID(false) f.AlwaysOnTop=true f.MaxDistance=self.Settings.LabelMaxDistance f.Size=UDim2.new(0,70,0,70) f.StudsOffset=self.Settings.LabelOffset f.Adornee=a f.Parent=self.ScreenGui local _=Instance.new("TextLabel") _.Name="TextLabel" _.Size=UDim2.new(1,0,1,0) _.AnchorPoint=Vector2.new(0.5,0.5) _.Position=UDim2.new(0.5,0,0.5,0) _.BackgroundTransparency=1 _.Font=Enum.Font.SourceSansBold _.TextScaled=true _.TextWrapped=true _.TextSize=14 _.TextColor3=g.AccentColor or self.Settings.AccentColor _.Text=g.LabelText or self.Settings.LabelText _.Parent=f Instance.new("UIStroke",_)end self.Indicators[a]={Highlight=d,Arrow=c,Scaler=_,DistanceLabel=e,Label=f,Options=g} local _=g.GroupName or self.Settings.GroupName if _ then self:AddToGroup(a,_)end end function e:Remove(c)local _=self.Indicators[c] if not _ then return end if _.Highlight then _.Highlight.Adornee=nil _.Highlight:Destroy()end if _.Arrow then _.Arrow:Destroy()end if _.Label then _.Label:Destroy()end local _=e.TargetIndex[c] if _ then for _,_ in ipairs(_)do local b=e.Groups[_] if b then for a,_ in ipairs(b.targets)do if _==c then table.remove(b.targets,a) break end end end end e.TargetIndex[c]=nil end self.Indicators[c]=nil end function e:AddToGroup(c,b)local _=self:AddGroup(b) if not table.find(_.targets,c)then table.insert(_.targets,c)end local a=e.TargetIndex[c] if not a then a={} e.TargetIndex[c]=a end if not table.find(a,b)then table.insert(a,b)end for a,_ in pairs(_.properties)do self:SetGroupProperty(b,a,_)end if not _.enabled then local _=self.Indicators[c] if _ and _.Highlight then _.Highlight.Enabled=false end end return true end function e:RemoveFromGroup(d,b)local c=e.Groups[b] if not c then return false end if table.find(c.targets,d)then for _,a in ipairs(c.targets)do if a==d then table.remove(c.targets,_) break end end else return false end local c=e.TargetIndex[d] if c then for a,_ in ipairs(c)do if _==b then table.remove(c,a) break end end if#c==0 then e.TargetIndex[d]=nil end end return true end function e:GetGroupTargets(_)local _=e.Groups[_] return _ and _.targets or{}end function e:GetTargetGroups(_)return e.TargetIndex[_]or{}end function e:_cleanupOrphanedHighlights()for _,_ in ipairs(self.ScreenGui:GetChildren())do if _:IsA("Highlight")and not table.find(self:_allHighlights(),_)then _.Adornee=nil _:Destroy()end end end function e:_allHighlights()local a={} for _,_ in pairs(self.Indicators)do if _.Highlight then table.insert(a,_.Highlight)end end return a end function e:_cleanupOrphanedArrows()for _,_ in ipairs(self.ScreenGui:GetChildren())do if _:IsA("ImageLabel")and _.Name:match("^Arrow_")then if not table.find(self:_allArrows(),_)then _:Destroy()end end end end function e:_allArrows()local a={} for _,_ in pairs(self.Indicators)do if _.Arrow then table.insert(a,_.Arrow)end end return a end function e:_cleanupOrphanedLabels()for _,_ in ipairs(self.ScreenGui:GetChildren())do if _:IsA("BillboardGui")and _.Name:match("^Label_")then if not table.find(self:_allLabels(),_)then _.Adornee=nil _:Destroy()end end end end function e:_allLabels()local a={} for _,_ in pairs(self.Indicators)do if _.Label then table.insert(a,_.Label)end end return a end function e:_update()local a=workspace.CurrentCamera local _=a.ViewportSize local f,i=_.X,_.Y for _,p in pairs(self.Indicators)do local j=p.Options local h=p.Arrow local k=p.Scaler if((not h)or(not k))and self.Settings.ArrowShow then self:Remove(_) continue end if not h then continue end local n if _:IsA("Model")then n=(_.PrimaryPart and _.PrimaryPart.Position)or _:GetModelCFrame().p elseif _:IsA("BasePart")then n=_.Position else continue end local m,e=a:WorldToViewportPoint(n) local c=(a.CFrame.p-n).Magnitude local _=j.ArrowMinDistance or self.Settings.ArrowMinDistance local o=j.ArrowEdgePadding or self.Settings.ArrowEdgePadding if e and c>_ then l:Create(k,TweenInfo.new(0.1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=0}):Play()else l:Create(k,TweenInfo.new(0.1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=1}):Play() local d,g=f-o*2,i-o*2 local b=a.CFrame local _=math.sqrt((d/2)^2+(g/2)^2) local a=n-b.Position local a=b:VectorToObjectSpace(a) local n=Vector2.new(a.X,a.Y).Unit local a=math.clamp(m.X,o,f-o) local b=math.clamp(m.Y,o,i-o) if a==m.X and b==m.Y and e then l:Create(k,TweenInfo.new(0.1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=0}):Play()else local _=n*_ local b if math.abs(_.Y)>g/2 then b=n*math.abs((g/2)/n.Y)else b=n*math.abs((d/2)/n.X)end local a=f/2+b.X local _=i/2-b.Y local b=math.atan2(n.X,n.Y) l:Create(h,TweenInfo.new(0.1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.fromOffset(a,_),Rotation=math.deg(b)}):Play()end if p.DistanceLabel then p.DistanceLabel.Text=string.format("%dm",math.round(c)) local _=(j.ArrowSize and j.ArrowSize.Y.Offset or self.Settings.ArrowSize.Y.Offset)+16 p.DistanceLabel.Position=UDim2.new(0.5,0,0,_)end end end end function e:Destroy()if self._updateConn then self._updateConn:Disconnect()end if self._cleanupConn then self._cleanupConn:Disconnect()end self:ClearAllGroups() for _,_ in pairs(self.Indicators)do if _.Highlight then _.Highlight:Destroy()end if _.Arrow then _.Arrow:Destroy()end if _.Label then _.Label:Destroy()end end self.ScreenGui:Destroy() self.Indicators={} e.Groups={} e.TargetIndex={}end return e
    end
    routine_module_scripts[script] = module_script
end

do -- StarterGui.YARHM.Bezier
    local script = Instance.new("ModuleScript")
    script.Name = "Bezier"
    script.Parent = Converted["_YARHM"]
    local function module_script()
    -- © Aetherion 2026
        local h={} h.__index=h function h.new(...)local k={...} assert(#k>=3,"Must have at least 3 points") local e=(#k==3) local _=(#k==4) local j={} local d=Vector3.new local b=d().lerp local f=nil local i={} local c=0 local a=nil local function g(_)local _={_.X,_.Y,_.Z} function _:ToVector3()return d(self[1],self[2],self[3])end function _:lerp(_,a)return b(self:ToVector3(),_:ToVector3(),a)end return _ end if(not e and not _)then for _=1,#k-1 do local a=g(k[_]) local _=g(k[_+1]) local _={a,_,g(a)} i[#i+1]=_ end local b=i for _=#i,2,-1 do local a={} for c=1,_-1 do local b,_=b[c],b[c+1] local _={b[3],_[3],g(b[3])} a[c]=_ i[#i+1]=_ end b=a end a=b[1] c=#i end if(e)then local b,c,_=k[1],k[2],k[3] function j:Get(d,a)if(a)then d=(d<0 and 0 or d>1 and 1 or d)end return(1-d)*(1-d)*b+2*(1-d)*d*c+d*d*_ end elseif(_)then local _,a,c,b=k[1],k[2],k[3],k[4] function j:Get(e,d)if(d)then e=(e<0 and 0 or e>1 and 1 or e)end return(1-e)*(1-e)*(1-e)*_+3*(1-e)*(1-e)*e*a+3*(1-e)*e*e*c+e*e*e*b end else function j:Get(b,_)if(_)then b=(b<0 and 0 or b>1 and 1 or b)end for _=1,c do local _=i[_] local a=_[1]:lerp(_[2],b) local _=_[3] _[1],_[2],_[3]=a.X,a.Y,a.Z end return a[3]:ToVector3()end end function j:GetLength(_)if(not f)then local a=self:GetPath(_ or 0.1) local b=0 for _=2,#a do local _=(a[_-1]-a[_]).Magnitude b=(b+_)end f=b end return f end function j:GetPath(_)assert(type(_)=="number","Must provide a step increment") assert(_>0 and _<1,"Step out of domain; should be between 0 and 1 (exclusive)") local b={} local a=0 for _=0,1,_ do a=_ b[#b+1]=self:Get(_)end if(a<1)then local _=((1-a)<(_*0.5)) b[#b+(_ and 0 or 1)]=self:Get(1)end return b end function j:GetPathByNumberSegments(_)assert(type(_)=="number","Must provide number of segments") assert(_>0,"Number of segments must be greater than 0") return self:GetPath(1/_)end function j:GetPathBySegmentLength(a)assert(type(a)=="number","Must provide a segment length") assert(a>0,"Segment length must be greater than 0") local _=self:GetLength() local _=_/a return self:GetPathByNumberSegments(math.floor(_+0.5))end function j:GetPoints()return k end return setmetatable(j,h)end return h
    end
    routine_module_scripts[script] = module_script
end

do -- StarterGui.YARHM.PointSave
    local script = Instance.new("ModuleScript")
    script.Name = "PointSave"
    script.Parent = Converted["_YARHM"]
    local function module_script()
    -- © Aetherion 2026
        local _=false local function d(...)if _ then print("[PointSave DEBUG]:",...)end end getgenv()._FOLDERS=getgenv()._FOLDERS or{} getgenv()._FILES=getgenv()._FILES or{} isfolder=isfolder or function(_)d("Checking if folder exists:",_) return getgenv()._FOLDERS[_]~=nil end makefolder=makefolder or function(_)d("Creating folder:",_) getgenv()._FOLDERS[_]={} return getgenv()._FOLDERS[_]end isfile=isfile or function(_)d("Checking if file exists:",_) return getgenv()._FILES[_]~=nil end writefile=writefile or function(a,_)d("Writing file:",a,"with content:",_) getgenv()._FILES[a]=_ return getgenv()._FILES[a]end readfile=readfile or function(_)d("Reading file:",_) return getgenv()._FILES[_]end delfile=delfile or function(_)d("Deleting file:",_) getgenv()._FILES[_]=nil end listfiles=listfiles or function(c)d("Listing files in folder:",c) local _=getgenv()._FOLDERS[c] if _ then local a={} for b,_ in pairs(getgenv()._FILES)do if b:sub(1,#c+1)==c.."/"then local _=b:sub(#c+2) d("Found file in folder:",_) table.insert(a,_)end end return a end d("Folder does not exist:",c) return{}end local b={} b.__index=b local c="PointSaveData" local function _()if not isfolder(c)then d("Base folder not found, creating:",c) makefolder(c)else d("Base folder already exists:",c)end end function b.new(a)d("Initializing new PointSave instance for namespace:",a) _() local _=setmetatable({},b) _.namespace=a _.folderPath=c.."/"..a if not isfolder(_.folderPath)then d("Namespace folder does not exist, creating:",_.folderPath) makefolder(_.folderPath)else d("Namespace folder already exists:",_.folderPath)end return _ end function b:set(b,a)local _=self.folderPath.."/"..b..".txt" d("Setting value for key:",b,"->",a) writefile(_,tostring(a))end function b:get(a)local _=self.folderPath.."/"..a..".txt" d("Getting value for key:",a) if isfile(_)then local _=readfile(_) d("Found value for key:",a,"->",_) return _ end d("Key not found:",a) return nil end function b:remove(a)local _=self.folderPath.."/"..a..".txt" d("Removing key:",a) if isfile(_)then delfile(_) d("Removed file for key:",a)else d("File for key does not exist:",a)end end function b:clear()d("Clearing all keys in namespace:",self.namespace) local _=listfiles(self.folderPath) for _,_ in ipairs(_)do local _=self.folderPath.."/".._ if isfile(_)then d("Deleting file:",_) delfile(_)end end end function b.deleteNamespace(a)local b=c.."/"..a d("Deleting namespace:",a) local _=listfiles(b) for _,_ in ipairs(_)do local _=b.."/".._ if isfile(_)then d("Deleting file from namespace:",_) delfile(_)end end getgenv()._FOLDERS[b]=nil d("Deleted folder for namespace:",a)end function b.listNamespaces()d("Listing all namespaces") _() local b={} for a,_ in pairs(getgenv()._FOLDERS)do if a:sub(1,#c+1)==c.."/"then local _=a:sub(#c+2) d("Found namespace:",_) table.insert(b,_)end end return b end return b
    end
    routine_module_scripts[script] = module_script
end

do -- StarterGui.YARHM.Theme
    local script = Instance.new("ModuleScript")
    script.Name = "Theme"
    script.Parent = Converted["_YARHM"]
    local function module_script()
    -- © Aetherion 2026
        local YARHMRoot = getgenv().YARHM
        local api = {
            colors = {
                font = Enum.Font.Montserrat,
                textColor = Color3.fromRGB(255, 255, 255),
                accentColor = Color3.fromRGB(197, 0, 0),
                primaryColor = Color3.fromRGB(22, 22, 22),
                secondaryColor = Color3.fromRGB(12, 12, 12),
                backgroundColorCSQ = ColorSequence.new(Color3.fromRGB(36, 36, 36), Color3.fromRGB(68, 68, 68)),
                strokeColorCSQ = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(53, 53, 53)),
                    ColorSequenceKeypoint.new(0.152, Color3.fromRGB(50.69, 50.69, 50.69)),
                    ColorSequenceKeypoint.new(0.472, Color3.fromRGB(255, 0, 4)),
                    ColorSequenceKeypoint.new(0.758, Color3.fromRGB(50.13, 50.13, 50.13)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(48, 48, 48))
                },
            }
        }
        local themeObjects = {font={},textColor={},primaryColor={},secondaryColor={},backgroundColorCSQ={},strokeColorCSQ={}}
        function api:sortObjects(gui)
            for _, obj in next, gui:getDescendants() do
                if obj:FindFirstChild("themedColor") then
                    if obj:FindFirstChild("themedColor").Value == "primaryColor" then table.insert(themeObjects.primaryColor, obj)
                    elseif obj:FindFirstChild("themedColor").Value == "secondaryColor" then table.insert(themeObjects.secondaryColor, obj)
                    elseif obj:FindFirstChild("themedColor").Value == "backgroundColorCSQ" then
                        for _, find in ipairs(obj:GetChildren()) do
                            if find:IsA("UIGradient") then table.insert(themeObjects.backgroundColorCSQ, find) break end
                        end
                    end
                end
                if obj:IsA("TextLabel") or obj:IsA("TextButton") then
                    table.insert(themeObjects.font, obj)
                    table.insert(themeObjects.textColor, obj)
                end
                if obj:IsA("UIStroke") and obj:FindFirstChildWhichIsA("UIGradient") then
                    table.insert(themeObjects.strokeColorCSQ, obj:FindFirstChildWhichIsA("UIGradient"))
                end
            end
        end
        function api:updateColor(colorType, newColor)
            if colorType == "textColor" then
                for _, obj in next, themeObjects.textColor do obj.TextColor3 = newColor end
            elseif colorType == "primaryColor" then
                for _, obj in next, themeObjects.primaryColor do
                    local s=pcall(function() obj.Color = newColor end) if s then return end
                    obj.BackgroundColor3 = newColor
                end
            elseif colorType == "secondaryColor" then
                for _, obj in next, themeObjects.secondaryColor do
                    local s=pcall(function() obj.Color = newColor end) if s then return end
                    obj.BackgroundColor3 = newColor
                end
            elseif colorType == "backgroundColorCSQ" then
                for _, obj in next, themeObjects.backgroundColorCSQ do obj.Color = newColor end
            elseif colorType == "strokeColorCSQ" then
                for _, obj in next, themeObjects.strokeColorCSQ do obj.Color = newColor end
            end
        end
        function api:setColorTable(t) api.colors = t; if getgenv then getgenv().YARHM_THEME = t end end
        function api:init(p)
            api:sortObjects(p)
            for colorKey, color in api.colors do
                local s, e = pcall(function() api:updateColor(colorKey, color) end)
                if not s then warn(e) end
            end
        end
        getgenv().ThemeManager = api
        getgenv().ThemeObjects = themeObjects
        getgenv().ThemeManagerModuleObject = script
        return api
    end
    routine_module_scripts[script] = module_script
end

do -- StarterGui.YARHM.FlyUtility
    local script = Instance.new("ModuleScript")
    script.Name = "FlyUtility"
    script.Parent = Converted["_YARHM"]
    local function module_script()
    -- © Aetherion 2026
        local l={} local _=game:GetService("Players") local b=game:GetService("RunService") local d=_.LocalPlayer local h=false local e=50 local c=2 local i=0 local g=Vector3.new() local j=nil local k=nil local f=nil local function _()if f then f:Disconnect() f=nil end if j then j:Destroy() j=nil end if k then k:Destroy() k=nil end local _=d.Character if _ then local _=_:FindFirstChildOfClass("Humanoid") if _ then _.PlatformStand=false end end h=false i=0 end local function a(_)local a=d.Character if not h or not a then l:Stop() return end local _=a:FindFirstChildOfClass("Humanoid") local d=a:FindFirstChild("HumanoidRootPart") local a=workspace.CurrentCamera if not _ or _.Health<=0 or not d or not a then l:Stop() return end local _=_.MoveDirection if _.Magnitude>0.01 then i=math.min(e,i+c) g=_.Unit else i=math.max(0,i-c)end local _=Vector3.new(g.X,0,g.Z) local c=Vector3.zero if _.Magnitude>0 then c=_.Unit*i end local f=a.CFrame.LookVector.Unit local b=g:Dot(f) local _=b<0 and-1 or 1 local a=Vector3.new(f.X,0,f.Z) if a.Magnitude>0 then a=a.Unit end local a=math.abs(g:Dot(a)) local _=f.Y*_*a local _=_*i k.Velocity=Vector3.new(c.X,_,c.Z) local _=(i/e)*30 local _=-math.rad(b*_) j.CFrame=CFrame.new(d.Position,d.Position+f)*CFrame.Angles(_,0,0)end function l:Start()if h then return end local c=d.Character if not c then return end local _=c:FindFirstChildOfClass("Humanoid") local c=c:FindFirstChild("HumanoidRootPart") if not _ or not c then return end h=true j=Instance.new("BodyGyro") j.P=100000 j.MaxTorque=Vector3.new(math.huge,math.huge,math.huge) j.CFrame=c.CFrame j.Parent=c k=Instance.new("BodyVelocity") k.P=10000 k.MaxForce=Vector3.new(math.huge,math.huge,math.huge) k.Velocity=Vector3.new(0,0,0) k.Parent=c _.PlatformStand=true f=b.Heartbeat:Connect(a)end function l:Stop()if not h then return end _()end function l:SetMaxSpeed(_)if type(_)=="number"and _>=0 then e=_ else warn("FlyModule:SetMaxSpeed requires a non-negative number.")end end function l:GetMaxSpeed()return e end function l:IsFlying()return h end d.CharacterRemoving:Connect(function(_)if h then l:Stop()end end) return l
    end
    routine_module_scripts[script] = module_script
end
