local ScreenGui = Instance.new('ScreenGui')
local Frame = Instance.new('Frame')
local TextLabel = Instance.new('TextLabel')
local UIStroke = Instance.new('UIStroke')
local BarFR = Instance.new('Frame')
local MainBT = Instance.new('TextButton')
local CustomBT = Instance.new('TextButton')
local LocalScript = Instance.new('LocalScript')
local MainFR = Instance.new('Frame')
local BrainrotGodFR = Instance.new('Frame')
local TextLabel_1 = Instance.new('TextLabel')
local UICorner = Instance.new('UICorner')
local ToggleBT = Instance.new('TextButton')
local UIStroke_1 = Instance.new('UIStroke')
local UICorner_1 = Instance.new('UICorner')
local Boll = Instance.new('Frame')
local UICorner_2 = Instance.new('UICorner')
local UIAspectRatioConstraint = Instance.new('UIAspectRatioConstraint')
local Animations = Instance.new('LocalScript')
local LocalScript_1 = Instance.new('LocalScript')
local BrainrotSecret = Instance.new('Frame')
local TextLabel_2 = Instance.new('TextLabel')
local UICorner_3 = Instance.new('UICorner')
local ToggleBT_1 = Instance.new('TextButton')
local UIStroke_2 = Instance.new('UIStroke')
local UICorner_4 = Instance.new('UICorner')
local Boll_1 = Instance.new('Frame')
local UICorner_5 = Instance.new('UICorner')
local UIAspectRatioConstraint_1 = Instance.new('UIAspectRatioConstraint')
local Animations_1 = Instance.new('LocalScript')
local LocalScript_2 = Instance.new('LocalScript')
local UICorner_6 = Instance.new('UICorner')
local CustomFR = Instance.new('Frame')
local Frame_1 = Instance.new('Frame')
local ScrollingFrame = Instance.new('ScrollingFrame')
local UIListLayout = Instance.new('UIListLayout')
local UIPadding = Instance.new('UIPadding')
local Toggle = Instance.new('TextButton')
local UIStroke_3 = Instance.new('UIStroke')
local UICorner_7 = Instance.new('UICorner')
local LocalScript_3 = Instance.new('LocalScript')
local ConfirmBtn = Instance.new('TextButton')
local UICorner_8 = Instance.new('UICorner')
local UIStroke_4 = Instance.new('UIStroke')
local TextLabel_3 = Instance.new('TextLabel')
local UICorner_9 = Instance.new('UICorner')
local ToggleBT_2 = Instance.new('TextButton')
local UIStroke_5 = Instance.new('UIStroke')
local UICorner_10 = Instance.new('UICorner')
local Boll_2 = Instance.new('Frame')
local UICorner_11 = Instance.new('UICorner')
local UIAspectRatioConstraint_2 = Instance.new('UIAspectRatioConstraint')
local UIStroke_6 = Instance.new('UIStroke')
local UIDragDetector = Instance.new('UIDragDetector')
ScreenGui.Parent = game:GetService('CoreGui')
Frame.BackgroundColor3 = Color3.new(0.000000, 0.000000, 0.000000)
Frame.BorderColor3 = Color3.new(0.000000, 0.000000, 0.000000)
Frame.BorderSizePixel = 0.000000
Frame.Position = UDim2.new(0.646526, 0, 0.249514, 0)
Frame.Size = UDim2.new(0.265269, 0, 0.604825, 0)
Frame.Parent = ScreenGui
TextLabel.BackgroundColor3 = Color3.new(0.000000, 0.000000, 0.000000)
TextLabel.BorderColor3 = Color3.new(0.000000, 0.000000, 0.000000)
TextLabel.BorderSizePixel = 0.000000
TextLabel.Position = UDim2.new(0.039894, 0, 0.020820, 0)
TextLabel.Size = UDim2.new(0.924202, 0, 0.173497, 0)
TextLabel.Font = Enum.Font.Arcade
TextLabel.Text = "SPXMENU"
TextLabel.TextColor3 = Color3.new(1.000000, 1.000000, 1.000000)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000000
TextLabel.TextWrapped = true
TextLabel.Parent = Frame
UIStroke.Thickness = 1.000000
UIStroke.Transparency = 0.000000
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
UIStroke.Color = Color3.new(0.000000, 0.000000, 0.000000)
UIStroke.Parent = TextLabel
BarFR.BackgroundColor3 = Color3.new(1.000000, 1.000000, 1.000000)
BarFR.BorderColor3 = Color3.new(0.000000, 0.000000, 0.000000)
BarFR.BorderSizePixel = 0.000000
BarFR.Name = "BarFR"
BarFR.Position = UDim2.new(0.000000, 0, 0.204726, 0)
BarFR.Size = UDim2.new(1.000000, 0, 0.121000, 0)
BarFR.Parent = Frame
MainBT.BackgroundColor3 = Color3.new(1.000000, 1.000000, 1.000000)
MainBT.BorderColor3 = Color3.new(0.000000, 0.000000, 0.000000)
MainBT.BorderSizePixel = 0.000000
MainBT.Name = "MainBT"
MainBT.Size = UDim2.new(0.507744, 0, 1.000000, 0)
MainBT.Font = Enum.Font.Arcade
MainBT.Text = "AutoBuy"
MainBT.TextColor3 = Color3.new(0.000000, 0.000000, 0.000000)
MainBT.TextScaled = true
MainBT.TextSize = 14.000000
MainBT.TextWrapped = true
MainBT.Parent = BarFR
CustomBT.BackgroundColor3 = Color3.new(1.000000, 1.000000, 1.000000)
CustomBT.BorderColor3 = Color3.new(0.000000, 0.000000, 0.000000)
CustomBT.BorderSizePixel = 0.000000
CustomBT.Name = "CustomBT"
CustomBT.Position = UDim2.new(0.507744, 0, 0.000000, 0)
CustomBT.Size = UDim2.new(0.490821, 0, 1.000000, 0)
CustomBT.Font = Enum.Font.Arcade
CustomBT.Text = "Custom"
CustomBT.TextColor3 = Color3.new(0.000000, 0.000000, 0.000000)
CustomBT.TextScaled = true
CustomBT.TextSize = 30.000000
CustomBT.TextWrapped = true
CustomBT.Parent = BarFR
LocalScript.Parent = BarFR
MainFR.BackgroundColor3 = Color3.new(0.301961, 0.301961, 0.301961)
MainFR.BackgroundTransparency = 1.000000
MainFR.BorderColor3 = Color3.new(0.000000, 0.000000, 0.000000)
MainFR.BorderSizePixel = 0.000000
MainFR.Name = "MainFR"
MainFR.Position = UDim2.new(0.000000, 0, 0.357404, 0)
MainFR.Size = UDim2.new(1.000000, 0, 0.600299, 0)
MainFR.Visible = false
MainFR.Parent = Frame
BrainrotGodFR.BackgroundColor3 = Color3.new(0.490196, 0.490196, 0.490196)
BrainrotGodFR.BackgroundTransparency = 1.000000
BrainrotGodFR.BorderColor3 = Color3.new(0.000000, 0.000000, 0.000000)
BrainrotGodFR.BorderSizePixel = 0.000000
BrainrotGodFR.Name = "BrainrotGodFR"
BrainrotGodFR.Position = UDim2.new(0.000031, 0, 0.118208, 0)
BrainrotGodFR.Size = UDim2.new(0.990753, 0, 0.349164, 0)
BrainrotGodFR.Parent = MainFR
TextLabel_1.BackgroundColor3 = Color3.new(1.000000, 1.000000, 1.000000)
TextLabel_1.BorderColor3 = Color3.new(0.000000, 0.000000, 0.000000)
TextLabel_1.BorderSizePixel = 0.000000
TextLabel_1.Position = UDim2.new(0.343333, 0, -0.120662, 0)
TextLabel_1.Size = UDim2.new(0.629729, 0, 0.650218, 0)
TextLabel_1.Font = Enum.Font.Arcade
TextLabel_1.Text = "Auto Buy     Brainrot God"
TextLabel_1.TextColor3 = Color3.new(0.000000, 0.000000, 0.000000)
TextLabel_1.TextScaled = true
TextLabel_1.TextSize = 14.000000
TextLabel_1.TextWrapped = true
TextLabel_1.Parent = BrainrotGodFR
UICorner.CornerRadius = UDim.new(0.000000, 8)
UICorner.Parent = TextLabel_1
ToggleBT.BackgroundColor3 = Color3.new(1.000000, 1.000000, 1.000000)
ToggleBT.BorderColor3 = Color3.new(0.000000, 0.000000, 0.000000)
ToggleBT.BorderSizePixel = 0.000000
ToggleBT.Name = "ToggleBT"
ToggleBT.Position = UDim2.new(0.042385, 0, -0.041183, 0)
ToggleBT.Size = UDim2.new(0.220000, 0, 0.380000, 0)
ToggleBT.Font = Enum.Font.SourceSans
ToggleBT.Text = ""
ToggleBT.TextColor3 = Color3.new(0.000000, 0.000000, 0.000000)
ToggleBT.TextSize = 14.000000
ToggleBT.Parent = BrainrotGodFR
UIStroke_1.Thickness = 1.000000
UIStroke_1.Transparency = 0.000000
UIStroke_1.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_1.Color = Color3.new(1.000000, 1.000000, 1.000000)
UIStroke_1.Parent = ToggleBT
UICorner_1.CornerRadius = UDim.new(0.000000, 85)
UICorner_1.Parent = ToggleBT
Boll.BackgroundColor3 = Color3.new(1.000000, 0.000000, 0.000000)
Boll.BorderColor3 = Color3.new(0.000000, 0.000000, 0.000000)
Boll.BorderSizePixel = 0.000000
Boll.Name = "Boll"
Boll.Position = UDim2.new(0.050000, 0, 0.018000, 0)
Boll.Size = UDim2.new(0.519000, 0, 0.962000, 0)
Boll.Parent = ToggleBT
UICorner_2.CornerRadius = UDim.new(0.000000, 85)
UICorner_2.Parent = Boll
UIAspectRatioConstraint.AspectRatio = 1.000000
UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Width
UIAspectRatioConstraint.AspectType = Enum.AspectType.FitWithinMaxSize
UIAspectRatioConstraint.Parent = Boll
Animations.Name = "Animations"
Animations.Parent = ToggleBT
LocalScript_1.Parent = ToggleBT
BrainrotSecret.BackgroundColor3 = Color3.new(0.490196, 0.490196, 0.490196)
BrainrotSecret.BackgroundTransparency = 1.000000
BrainrotSecret.BorderColor3 = Color3.new(0.000000, 0.000000, 0.000000)
BrainrotSecret.BorderSizePixel = 0.000000
BrainrotSecret.Name = "BrainrotSecret"
BrainrotSecret.Position = UDim2.new(0.000000, 0, 0.470178, 0)
BrainrotSecret.Size = UDim2.new(0.990753, 0, 0.363200, 0)
BrainrotSecret.Parent = MainFR
TextLabel_2.BackgroundColor3 = Color3.new(1.000000, 1.000000, 1.000000)
TextLabel_2.BorderColor3 = Color3.new(0.000000, 0.000000, 0.000000)
TextLabel_2.BorderSizePixel = 0.000000
TextLabel_2.Position = UDim2.new(0.343333, 0, -0.113355, 0)
TextLabel_2.Size = UDim2.new(0.626667, 0, 0.579028, 0)
TextLabel_2.Font = Enum.Font.Arcade
TextLabel_2.Text = "Auto Buy    Brainrot Secret"
TextLabel_2.TextColor3 = Color3.new(0.000000, 0.000000, 0.000000)
TextLabel_2.TextScaled = true
TextLabel_2.TextSize = 14.000000
TextLabel_2.TextWrapped = true
TextLabel_2.Parent = BrainrotSecret
UICorner_3.CornerRadius = UDim.new(0.000000, 8)
UICorner_3.Parent = TextLabel_2
ToggleBT_1.BackgroundColor3 = Color3.new(1.000000, 1.000000, 1.000000)
ToggleBT_1.BorderColor3 = Color3.new(0.000000, 0.000000, 0.000000)
ToggleBT_1.BorderSizePixel = 0.000000
ToggleBT_1.Name = "ToggleBT"
ToggleBT_1.Position = UDim2.new(0.042385, 0, -0.026677, 0)
ToggleBT_1.Size = UDim2.new(0.220000, 0, 0.380000, 0)
ToggleBT_1.Font = Enum.Font.SourceSans
ToggleBT_1.Text = ""
ToggleBT_1.TextColor3 = Color3.new(0.000000, 0.000000, 0.000000)
ToggleBT_1.TextSize = 14.000000
ToggleBT_1.Parent = BrainrotSecret
UIStroke_2.Thickness = 1.000000
UIStroke_2.Transparency = 0.000000
UIStroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_2.Color = Color3.new(1.000000, 1.000000, 1.000000)
UIStroke_2.Parent = ToggleBT_1
UICorner_4.CornerRadius = UDim.new(0.000000, 85)
UICorner_4.Parent = ToggleBT_1
Boll_1.BackgroundColor3 = Color3.new(1.000000, 0.000000, 0.000000)
Boll_1.BorderColor3 = Color3.new(0.000000, 0.000000, 0.000000)
Boll_1.BorderSizePixel = 0.000000
Boll_1.Name = "Boll"
Boll_1.Position = UDim2.new(0.050000, 0, 0.018000, 0)
Boll_1.Size = UDim2.new(0.518773, 0, 0.962248, 0)
Boll_1.Parent = ToggleBT_1
UICorner_5.CornerRadius = UDim.new(0.000000, 85)
UICorner_5.Parent = Boll_1
UIAspectRatioConstraint_1.AspectRatio = 1.000000
UIAspectRatioConstraint_1.DominantAxis = Enum.DominantAxis.Width
UIAspectRatioConstraint_1.AspectType = Enum.AspectType.FitWithinMaxSize
UIAspectRatioConstraint_1.Parent = Boll_1
Animations_1.Name = "Animations"
Animations_1.Parent = ToggleBT_1
LocalScript_2.Parent = ToggleBT_1
UICorner_6.CornerRadius = UDim.new(0.000000, 8)
UICorner_6.Parent = Frame
CustomFR.BackgroundColor3 = Color3.new(0.301961, 0.301961, 0.301961)
CustomFR.BackgroundTransparency = 1.000000
CustomFR.BorderColor3 = Color3.new(0.000000, 0.000000, 0.000000)
CustomFR.BorderSizePixel = 0.000000
CustomFR.Name = "CustomFR"
CustomFR.Position = UDim2.new(0.000000, 0, 0.357404, 0)
CustomFR.Size = UDim2.new(0.997340, 0, 0.600299, 0)
CustomFR.Parent = Frame
Frame_1.BackgroundColor3 = Color3.new(1.000000, 1.000000, 1.000000)
Frame_1.BackgroundTransparency = 1.000000
Frame_1.BorderColor3 = Color3.new(0.000000, 0.000000, 0.000000)
Frame_1.BorderSizePixel = 0.000000
Frame_1.Position = UDim2.new(0.003333, 0, 0.052023, 0)
Frame_1.Size = UDim2.new(0.993395, 0, 0.980576, 0)
Frame_1.Parent = CustomFR
ScrollingFrame.Active = true
ScrollingFrame.BackgroundColor3 = Color3.new(0.294118, 0.294118, 0.294118)
ScrollingFrame.BackgroundTransparency = 1.000000
ScrollingFrame.BorderColor3 = Color3.new(0.000000, 0.000000, 0.000000)
ScrollingFrame.BorderSizePixel = 0.000000
ScrollingFrame.Position = UDim2.new(0.036910, 0, 0.151405, 0)
ScrollingFrame.Size = UDim2.new(1.655000, 0, 0.854000, 0)
ScrollingFrame.SizeConstraint = Enum.SizeConstraint.RelativeYY
ScrollingFrame.CanvasSize = UDim2.new(0.000000, 0, 0.000000, 0)
ScrollingFrame.ScrollBarThickness = 0.000000
ScrollingFrame.SizeConstraint = Enum.SizeConstraint.RelativeYY
ScrollingFrame.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
ScrollingFrame.HorizontalScrollBarInset = Enum.ScrollBarInset.None
ScrollingFrame.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
ScrollingFrame.ScrollBarImageColor3 = Color3.new(0.000000, 0.000000, 0.000000)
ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y
ScrollingFrame.ScrollingEnabled = true
ScrollingFrame.TopImage = "rbxasset://textures/ui/Scroll/scroll-top.png"
ScrollingFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
ScrollingFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
ScrollingFrame.Parent = Frame_1
ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
UIListLayout.Padding = UDim.new(0.040000, 0)
UIListLayout.FillDirection = Enum.FillDirection.Vertical
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Wraps = false
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.HorizontalFlex = Enum.UIFlexAlignment.None
UIListLayout.ItemLineAlignment = Enum.ItemLineAlignment.Automatic
UIListLayout.VerticalFlex = Enum.UIFlexAlignment.None
UIListLayout.Parent = ScrollingFrame
UIPadding.PaddingTop = UDim.new(0.010000, 0)
UIPadding.PaddingBottom = UDim.new(0.000000, 0)
UIPadding.PaddingLeft = UDim.new(0.000000, 0)
UIPadding.PaddingRight = UDim.new(0.000000, 0)
UIPadding.Parent = ScrollingFrame
Toggle.BackgroundColor3 = Color3.new(0.231373, 0.231373, 0.231373)
Toggle.BackgroundTransparency = 0.550000
Toggle.BorderColor3 = Color3.new(0.000000, 0.000000, 0.000000)
Toggle.BorderSizePixel = 0.000000
Toggle.Name = "Toggle"
Toggle.Position = UDim2.new(0.035718, 0, -0.056726, 0)
Toggle.Size = UDim2.new(0.930687, 0, 0.175595, 0)
Toggle.Font = Enum.Font.Arcade
Toggle.Text = "Select Brainrot for       Auto buy Custom"
Toggle.TextColor3 = Color3.new(0.000000, 0.000000, 0.000000)
Toggle.TextScaled = true
Toggle.TextSize = 14.000000
Toggle.TextWrapped = true
Toggle.Parent = Frame_1
UIStroke_3.Thickness = 1.000000
UIStroke_3.Transparency = 0.000000
UIStroke_3.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
UIStroke_3.Color = Color3.new(1.000000, 1.000000, 1.000000)
UIStroke_3.Parent = Toggle
UICorner_7.CornerRadius = UDim.new(0.000000, 8)
UICorner_7.Parent = Toggle
LocalScript_3.Parent = Frame_1
ConfirmBtn.BackgroundColor3 = Color3.new(0.333333, 0.333333, 1.000000)
ConfirmBtn.BorderColor3 = Color3.new(0.000000, 0.000000, 0.000000)
ConfirmBtn.BorderSizePixel = 0.000000
ConfirmBtn.Name = "ConfirmBtn"
ConfirmBtn.Position = UDim2.new(0.043578, 0, 0.695746, 0)
ConfirmBtn.Size = UDim2.new(1.129091, 0, 0.143502, 0)
ConfirmBtn.Visible = false
ConfirmBtn.Font = Enum.Font.Arcade
ConfirmBtn.Text = "CONFIRMAR"
ConfirmBtn.TextColor3 = Color3.new(0.000000, 0.000000, 0.000000)
ConfirmBtn.TextScaled = true
ConfirmBtn.TextSize = 14.000000
ConfirmBtn.TextWrapped = true
ConfirmBtn.Parent = Frame_1
UICorner_8.CornerRadius = UDim.new(0.000000, 8)
UICorner_8.Parent = ConfirmBtn
UIStroke_4.Thickness = 1.000000
UIStroke_4.Transparency = 0.000000
UIStroke_4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_4.Color = Color3.new(0.000000, 0.000000, 0.000000)
UIStroke_4.Parent = ConfirmBtn
TextLabel_3.BackgroundColor3 = Color3.new(1.000000, 1.000000, 1.000000)
TextLabel_3.BorderColor3 = Color3.new(0.000000, 0.000000, 0.000000)
TextLabel_3.BorderSizePixel = 0.000000
TextLabel_3.Position = UDim2.new(0.360022, 0, 0.213847, 0)
TextLabel_3.Size = UDim2.new(0.590222, 0, 0.144807, 0)
TextLabel_3.Visible = false
TextLabel_3.Font = Enum.Font.Arcade
TextLabel_3.Text = "Auto Buy    Brainrot Custom"
TextLabel_3.TextColor3 = Color3.new(0.000000, 0.000000, 0.000000)
TextLabel_3.TextScaled = true
TextLabel_3.TextSize = 14.000000
TextLabel_3.TextWrapped = true
TextLabel_3.Parent = Frame_1
UICorner_9.CornerRadius = UDim.new(0.000000, 8)
UICorner_9.Parent = TextLabel_3
ToggleBT_2.BackgroundColor3 = Color3.new(1.000000, 1.000000, 1.000000)
ToggleBT_2.BorderColor3 = Color3.new(0.000000, 0.000000, 0.000000)
ToggleBT_2.BorderSizePixel = 0.000000
ToggleBT_2.Name = "ToggleBT"
ToggleBT_2.Position = UDim2.new(0.061642, 0, 0.211964, 0)
ToggleBT_2.Size = UDim2.new(0.244957, 0, 0.148085, 0)
ToggleBT_2.Visible = false
ToggleBT_2.Font = Enum.Font.SourceSans
ToggleBT_2.Text = ""
ToggleBT_2.TextColor3 = Color3.new(0.000000, 0.000000, 0.000000)
ToggleBT_2.TextSize = 14.000000
ToggleBT_2.Parent = Frame_1
UIStroke_5.Thickness = 1.000000
UIStroke_5.Transparency = 0.000000
UIStroke_5.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_5.Color = Color3.new(1.000000, 1.000000, 1.000000)
UIStroke_5.Parent = ToggleBT_2
UICorner_10.CornerRadius = UDim.new(0.000000, 85)
UICorner_10.Parent = ToggleBT_2
Boll_2.BackgroundColor3 = Color3.new(1.000000, 1.000000, 1.000000)
Boll_2.BorderColor3 = Color3.new(0.000000, 0.000000, 0.000000)
Boll_2.BorderSizePixel = 0.000000
Boll_2.Name = "Boll"
Boll_2.Position = UDim2.new(0.020000, 0, 0.018000, 0)
Boll_2.Size = UDim2.new(0.519000, 0, 0.962000, 0)
Boll_2.Parent = ToggleBT_2
UICorner_11.CornerRadius = UDim.new(0.000000, 85)
UICorner_11.Parent = Boll_2
UIAspectRatioConstraint_2.AspectRatio = 1.000000
UIAspectRatioConstraint_2.DominantAxis = Enum.DominantAxis.Width
UIAspectRatioConstraint_2.AspectType = Enum.AspectType.FitWithinMaxSize
UIAspectRatioConstraint_2.Parent = Boll_2
UIStroke_6.Thickness = 0.800000
UIStroke_6.Transparency = 0.000000
UIStroke_6.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_6.Color = Color3.new(0.000000, 0.000000, 0.000000)
UIStroke_6.Parent = Frame
UIDragDetector.BoundingBehavior = Enum.UIDragDetectorBoundingBehavior.Automatic
UIDragDetector.DragRelativity = Enum.UIDragDetectorDragRelativity.Absolute
UIDragDetector.DragSpace = Enum.UIDragDetectorDragSpace.Parent
UIDragDetector.DragStyle = Enum.UIDragDetectorDragStyle.TranslatePlane
UIDragDetector.Enabled = true
UIDragDetector.ResponseStyle = Enum.UIDragDetectorResponseStyle.Offset
UIDragDetector.SelectionModeRotateSpeed = 90.000000
UIDragDetector.UIDragSpeedAxisMapping = Enum.UIDragSpeedAxisMapping.XY
UIDragDetector.ActivatedCursorIcon = ""
UIDragDetector.CursorIcon = ""
UIDragDetector.MaxDragAngle = 0.000000
UIDragDetector.MaxDragTranslation = UDim2.new(0.000000, 0, 0.000000, 0)
UIDragDetector.MinDragAngle = 0.000000
UIDragDetector.MinDragTranslation = UDim2.new(0.000000, 0, 0.000000, 0)
UIDragDetector.DragRotation = 0.000000
UIDragDetector.Parent = Frame
local function LocalScript_generatedScript()
    local script = Instance.new('LocalScript')
    script.Name = "LocalScript"
    script.Parent = BarFR
    local bar = script.Parent
    local mainButton = bar:WaitForChild("MainBT")
    local customButton = bar:WaitForChild("CustomBT")
    local screenGui = bar.Parent
    local mainFrame = screenGui:WaitForChild("MainFR")
    local customFrame = screenGui:WaitForChild("CustomFR")
    local function showOnly(targetFrame)
    	mainFrame.Visible = false
    	customFrame.Visible = false
    	targetFrame.Visible = true
    end
    showOnly(mainFrame)
    mainButton.MouseButton1Click:Connect(function()
    	showOnly(mainFrame)
    end)
    customButton.MouseButton1Click:Connect(function()
    	showOnly(customFrame)
    end)
end
task.spawn(LocalScript_generatedScript)
local function Animations_generatedScript()
    local script = Instance.new('LocalScript')
    script.Name = "Animations"
    script.Parent = ToggleBT
    local toggle = script.Parent
    local boll = toggle:WaitForChild("Boll")
    local toggled = false
    local tweenService = game:GetService("TweenService")
    local tweenInfo = TweenInfo.new(
    	0.3,
    	Enum.EasingStyle.Sine,
    	Enum.EasingDirection.Out
    )
    local offPosition = UDim2.new(0.02, 0, 0.018, 0)
    local onPosition = UDim2.new(0.55, 0,0, 0)
    local offColor = Color3.fromRGB(255, 255, 255)
    local onColor = Color3.fromRGB(255, 255, 255)
    boll.Position = offPosition
    boll.BackgroundColor3 = offColor
    toggle.MouseButton1Click:Connect(function()
    	toggled = not toggled
    	local targetPosition = toggled and onPosition or offPosition
    	local targetColor = toggled and onColor or offColor
    	local moveTween = tweenService:Create(boll, tweenInfo, {Position = targetPosition})
    	local colorTween = tweenService:Create(boll, tweenInfo, {BackgroundColor3 = targetColor})
    	moveTween:Play()
    	colorTween:Play()
    end)
end
task.spawn(Animations_generatedScript)
local function LocalScript_1_generatedScript()
    local script = Instance.new('LocalScript')
    script.Name = "LocalScript"
    script.Parent = ToggleBT
    local toggleButton = script.Parent
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local ProximityPromptService = game:GetService("ProximityPromptService")
    local UserInputService = game:GetService("UserInputService")
    local VirtualInputManager = game:GetService("VirtualInputManager")
    local HttpService = game:GetService("HttpService")
    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local AUTO_ACTIVATE = false
    local SCRIPT_ACTIVE = false
    local MAX_DISTANCE = 15
    local ACTIVATION_DELAY = 0.1
    local BRAINROT_NAMES_URL = "https://github.com/SPIRALRBX-end/Steal-a-Brainrot/blob/main/return/god/brainrot_names.lua"
    local trackedPrompts = {}
    local lastActivation = {}
    local connections = {}
    local targetNames = {}
    local processedPrompts = {}
    local scanQueue = {}
    local targetNamesCache = {}
    local function updateButtonAppearance()
    	if AUTO_ACTIVATE then
    		toggleButton.Text = " "
    		toggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    		toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    	else
    		toggleButton.Text = " "
    		toggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    		toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    	end
    end
    local function loadBrainrotNames()
    	local success, result = pcall(function()
    		local loadstring_func = loadstring or load
    		if loadstring_func then
    			local code = game:HttpGet(BRAINROT_NAMES_URL)
    			local namesList = loadstring_func(code)()
    			return namesList
    		else
    			error("Loadstring não disponível")
    		end
    	end)
    	if success and result and type(result) == "table" then
    		targetNames = result
    		targetNamesCache = {}
    		for i, name in pairs(targetNames) do
    			targetNamesCache[i] = {
    				original = name,
    				lower = name:lower()
    			}
    		end
    		return true
    	else
    		targetNames = {
    			"Cocofanto Elefanto",
    			"Tralalero Tralala",
    			"Odin Din Din Dun",
    			"Girafa Celestre",
    			"Gattatino Nyanino",
    			"Trenostruzzo Turbo 3000",
    			"Matteo",
    			"Unclito Samito"
    		}
    		targetNamesCache = {}
    		for i, name in pairs(targetNames) do
    			targetNamesCache[i] = {
    				original = name,
    				lower = name:lower()
    			}
    		end
    		return false
    	end
    end
    local function getAnimalDisplayName(animalModel)
    	local success, displayName = pcall(function()
    		return animalModel.HumanoidRootPart.Info.AnimalOverhead.DisplayName.Text
    	end)
    	if success and displayName then
    		return displayName
    	end
    	return nil
    end
    local function isTargetAnimal(animalModel)
    	if not animalModel then return false end
    	local displayName = getAnimalDisplayName(animalModel)
    	if not displayName or displayName == "" then return false end
    	local displayNameLower = displayName:lower()
    	for _, nameData in pairs(targetNamesCache) do
    		if displayName:find(nameData.original) or displayNameLower:find(nameData.lower) then
    			return true, nameData.original
    		end
    	end
    	return false, nil
    end
    local function findAnimalModel(prompt)
    	local parent = prompt.Parent
    	-- Check if the parent is directly an animal model
    	if parent and parent.Parent and parent.Parent.Name == "MovingAnimals" then
    		return parent.Parent:FindFirstChild(parent.Name)
    	end
    	-- Traverse up to find the animal model
    	local current = parent
    	while current do
    		if current.Parent and current.Parent.Name == "MovingAnimals" then
    			return current
    		end
    		current = current.Parent
    	end
    	return nil
    end
    local function activateProximityPrompt(prompt)
    	if not prompt or not prompt.Parent or not AUTO_ACTIVATE then return end
    	local promptId = tostring(prompt)
    	local currentTime = tick()
    	if lastActivation[promptId] and currentTime - lastActivation[promptId] < 1 then
    		return
    	end
    	lastActivation[promptId] = currentTime
    	coroutine.wrap(function()
    		local success = pcall(function()
    			if fireproximityprompt then
    				fireproximityprompt(prompt)
    				return
    			end
    		end)
    		if success then return end
    		pcall(function()
    			if prompt.HoldDuration > 0 then
    				prompt:InputHoldBegin()
    				wait(math.min(prompt.HoldDuration + 0.05, 0.5))
    				prompt:InputHoldEnd()
    			else
    				prompt:InputHoldBegin()
    				wait(ACTIVATION_DELAY)
    				prompt:InputHoldEnd()
    			end
    		end)
    	end)()
    end
    local positionCache = {}
    local function getModelPosition(promptParent)
    	local cacheKey = tostring(promptParent)
    	local currentTime = tick()
    	if positionCache[cacheKey] and currentTime - positionCache[cacheKey].time < 0.5 then
    		return positionCache[cacheKey].position
    	end
    	local position = nil
    	if promptParent:IsA("BasePart") then
    		position = promptParent.Position
    	elseif promptParent:FindFirstChild("HumanoidRootPart") then
    		position = promptParent.HumanoidRootPart.Position
    	elseif promptParent:IsA("Model") and promptParent.PrimaryPart then
    		position = promptParent.PrimaryPart.Position
    	else
    		for i, child in pairs(promptParent:GetChildren()) do
    			if i > 10 then break end
    			if child:IsA("BasePart") then
    				position = child.Position
    				break
    			end
    		end
    	end
    	if position then
    		positionCache[cacheKey] = {
    			position = position,
    			time = currentTime
    		}
    	end
    	return position
    end
    local function processPromptsQueue()
    	if not AUTO_ACTIVATE then return end
    	local processed = 0
    	local maxPerFrame = 5
    	while #scanQueue > 0 and processed < maxPerFrame do
    		local prompt = table.remove(scanQueue, 1)
    		processed = processed + 1
    		if prompt and prompt.Parent then
    			local promptId = tostring(prompt)
    			if processedPrompts[promptId] and tick() - processedPrompts[promptId] < 2 then
    				continue
    			end
    			processedPrompts[promptId] = tick()
    			-- Find the animal model from the prompt
    			local animalModel = findAnimalModel(prompt)
    			local isTarget, foundName = isTargetAnimal(animalModel)
    			if isTarget and character and humanoidRootPart then
    				local playerPosition = humanoidRootPart.Position
    				local modelPosition = getModelPosition(prompt.Parent)
    				if modelPosition then
    					local distance = (playerPosition - modelPosition).Magnitude
    					if distance <= MAX_DISTANCE then
    						activateProximityPrompt(prompt)
    					end
    				end
    			end
    		end
    	end
    end
    local function scanExistingPrompts()
    	if not AUTO_ACTIVATE or not character or not humanoidRootPart then
    		return
    	end
    	-- Scan MovingAnimals folder specifically
    	local movingAnimals = game.Workspace:FindFirstChild("MovingAnimals")
    	if not movingAnimals then return end
    	for _, animalModel in pairs(movingAnimals:GetChildren()) do
    		if animalModel:IsA("Model") then
    			local success, prompt = pcall(function()
    				return animalModel.HumanoidRootPart.PromptAttachment.ProximityPrompt
    			end)
    			if success and prompt and prompt.Enabled then
    				table.insert(scanQueue, prompt)
    			end
    		end
    	end
    end
    local function startScript()
    	if SCRIPT_ACTIVE then return end
    	SCRIPT_ACTIVE = true
    	connections[#connections + 1] = ProximityPromptService.PromptShown:Connect(function(prompt, inputType)
    		if not AUTO_ACTIVATE then return end
    		local animalModel = findAnimalModel(prompt)
    		local isTarget, foundName = isTargetAnimal(animalModel)
    		if isTarget then
    			wait(0.1)
    			activateProximityPrompt(prompt)
    		end
    	end)
    	connections[#connections + 1] = ProximityPromptService.PromptHidden:Connect(function(prompt, inputType)
    		local promptId = tostring(prompt)
    		trackedPrompts[promptId] = nil
    		processedPrompts[promptId] = nil
    	end)
    	local lastScan = 0
    	local lastCleanup = 0
    	connections[#connections + 1] = RunService.Heartbeat:Connect(function()
    		if not AUTO_ACTIVATE then return end
    		local currentTime = tick()
    		if #scanQueue > 0 then
    			processPromptsQueue()
    		end
    		if currentTime - lastScan >= 3 then
    			lastScan = currentTime
    			if #scanQueue < 50 then
    				pcall(scanExistingPrompts)
    			end
    		end
    		if currentTime - lastCleanup >= 15 then
    			lastCleanup = currentTime
    			for promptId, time in pairs(lastActivation) do
    				if currentTime - time > 30 then
    					lastActivation[promptId] = nil
    				end
    			end
    			for promptId, time in pairs(processedPrompts) do
    				if currentTime - time > 10 then
    					processedPrompts[promptId] = nil
    				end
    			end
    			for key, data in pairs(positionCache) do
    				if currentTime - data.time > 2 then
    					positionCache[key] = nil
    				end
    			end
    		end
    	end)
    end
    local function stopScript()
    	if not SCRIPT_ACTIVE then return end
    	SCRIPT_ACTIVE = false
    	for _, connection in pairs(connections) do
    		if connection then
    			connection:Disconnect()
    		end
    	end
    	connections = {}
    	trackedPrompts = {}
    	lastActivation = {}
    	processedPrompts = {}
    	positionCache = {}
    	scanQueue = {}
    end
    local function toggleScript()
    	AUTO_ACTIVATE = not AUTO_ACTIVATE
    	updateButtonAppearance()
    	if AUTO_ACTIVATE then
    		startScript()
    	else
    		stopScript()
    	end
    end
    toggleButton.MouseButton1Click:Connect(toggleScript)
    local function onCharacterAdded(newCharacter)
    	character = newCharacter
    	humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    	if AUTO_ACTIVATE then
    		stopScript()
    		wait(1)
    		startScript()
    	end
    end
    player.CharacterAdded:Connect(onCharacterAdded)
    game.Players.PlayerRemoving:Connect(function(leavingPlayer)
    	if leavingPlayer == player then
    		stopScript()
    	end
    end)
    loadBrainrotNames()
    updateButtonAppearance()
    coroutine.wrap(function()
    	wait(2)
    	if AUTO_ACTIVATE then
    		scanExistingPrompts()
    	end
    end)()
end
task.spawn(LocalScript_1_generatedScript)
local function Animations_1_generatedScript()
    local script = Instance.new('LocalScript')
    script.Name = "Animations"
    script.Parent = ToggleBT_1
    local toggle = script.Parent
    local boll = toggle:WaitForChild("Boll")
    local toggled = false
    local tweenService = game:GetService("TweenService")
    local tweenInfo = TweenInfo.new(
    	0.3,
    	Enum.EasingStyle.Sine,
    	Enum.EasingDirection.Out
    )
    local offPosition = UDim2.new(0.02, 0, 0.018, 0)
    local onPosition = UDim2.new(0.55, 0,0, 0)
    local offColor = Color3.fromRGB(255, 255, 255)
    local onColor = Color3.fromRGB(255, 255, 255)
    boll.Position = offPosition
    boll.BackgroundColor3 = offColor
    toggle.MouseButton1Click:Connect(function()
    	toggled = not toggled
    	local targetPosition = toggled and onPosition or offPosition
    	local targetColor = toggled and onColor or offColor
    	local moveTween = tweenService:Create(boll, tweenInfo, {Position = targetPosition})
    	local colorTween = tweenService:Create(boll, tweenInfo, {BackgroundColor3 = targetColor})
    	moveTween:Play()
    	colorTween:Play()
    end)
end
task.spawn(Animations_1_generatedScript)
local function LocalScript_2_generatedScript()
    local script = Instance.new('LocalScript')
    script.Name = "LocalScript"
    script.Parent = ToggleBT_1
    local toggleButton = script.Parent
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local ProximityPromptService = game:GetService("ProximityPromptService")
    local UserInputService = game:GetService("UserInputService")
    local VirtualInputManager = game:GetService("VirtualInputManager")
    local HttpService = game:GetService("HttpService")
    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local AUTO_ACTIVATE = false
    local SCRIPT_ACTIVE = false
    local MAX_DISTANCE = 15
    local ACTIVATION_DELAY = 0.1
    local BRAINROT_NAMES_URL = "https://raw.githubusercontent.com/SPIRALRBX-end/Steal-a-Brainrot/refs/heads/main/return/secret/brainrot_names.lua"
    local trackedPrompts = {}
    local lastActivation = {}
    local connections = {}
    local targetNames = {}
    local processedPrompts = {}
    local scanQueue = {}
    local targetNamesCache = {}
    local function updateButtonAppearance()
    	if AUTO_ACTIVATE then
    		toggleButton.Text = " "
    		toggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    		toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    	else
    		toggleButton.Text = " "
    		toggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    		toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    	end
    end
    local function loadBrainrotNames()
    	local success, result = pcall(function()
    		local loadstring_func = loadstring or load
    		if loadstring_func then
    			local code = game:HttpGet(BRAINROT_NAMES_URL)
    			local namesList = loadstring_func(code)()
    			return namesList
    		else
    			error("Loadstring não disponível")
    		end
    	end)
    	if success and result and type(result) == "table" then
    		targetNames = result
    		targetNamesCache = {}
    		for i, name in pairs(targetNames) do
    			targetNamesCache[i] = {
    				original = name,
    				lower = name:lower()
    			}
    		end
    		return true
    	else
    		targetNames = {
    			"La Vacca Saturno Saturnita",
    			"Los Tralaleritos",
    			"Graipuss Medussi",
    			"La Grande Combinasion",
    			"Sammyni Spyderini",
    			"Garama and Madundung"
    		}
    		targetNamesCache = {}
    		for i, name in pairs(targetNames) do
    			targetNamesCache[i] = {
    				original = name,
    				lower = name:lower()
    			}
    		end
    		return false
    	end
    end
    local function getAnimalDisplayName(animalModel)
    	local success, displayName = pcall(function()
    		return animalModel.HumanoidRootPart.Info.AnimalOverhead.DisplayName.Text
    	end)
    	if success and displayName then
    		return displayName
    	end
    	return nil
    end
    local function isTargetAnimal(animalModel)
    	if not animalModel then return false end
    	local displayName = getAnimalDisplayName(animalModel)
    	if not displayName or displayName == "" then return false end
    	local displayNameLower = displayName:lower()
    	for _, nameData in pairs(targetNamesCache) do
    		if displayName:find(nameData.original) or displayNameLower:find(nameData.lower) then
    			return true, nameData.original
    		end
    	end
    	return false, nil
    end
    local function findAnimalModel(prompt)
    	local parent = prompt.Parent
    	-- Check if the parent is directly an animal model
    	if parent and parent.Parent and parent.Parent.Name == "MovingAnimals" then
    		return parent.Parent:FindFirstChild(parent.Name)
    	end
    	-- Traverse up to find the animal model
    	local current = parent
    	while current do
    		if current.Parent and current.Parent.Name == "MovingAnimals" then
    			return current
    		end
    		current = current.Parent
    	end
    	return nil
    end
    local function activateProximityPrompt(prompt)
    	if not prompt or not prompt.Parent or not AUTO_ACTIVATE then return end
    	local promptId = tostring(prompt)
    	local currentTime = tick()
    	if lastActivation[promptId] and currentTime - lastActivation[promptId] < 1 then
    		return
    	end
    	lastActivation[promptId] = currentTime
    	coroutine.wrap(function()
    		local success = pcall(function()
    			if fireproximityprompt then
    				fireproximityprompt(prompt)
    				return
    			end
    		end)
    		if success then return end
    		pcall(function()
    			if prompt.HoldDuration > 0 then
    				prompt:InputHoldBegin()
    				wait(math.min(prompt.HoldDuration + 0.05, 0.5))
    				prompt:InputHoldEnd()
    			else
    				prompt:InputHoldBegin()
    				wait(ACTIVATION_DELAY)
    				prompt:InputHoldEnd()
    			end
    		end)
    	end)()
    end
    local positionCache = {}
    local function getModelPosition(promptParent)
    	local cacheKey = tostring(promptParent)
    	local currentTime = tick()
    	if positionCache[cacheKey] and currentTime - positionCache[cacheKey].time < 0.5 then
    		return positionCache[cacheKey].position
    	end
    	local position = nil
    	if promptParent:IsA("BasePart") then
    		position = promptParent.Position
    	elseif promptParent:FindFirstChild("HumanoidRootPart") then
    		position = promptParent.HumanoidRootPart.Position
    	elseif promptParent:IsA("Model") and promptParent.PrimaryPart then
    		position = promptParent.PrimaryPart.Position
    	else
    		for i, child in pairs(promptParent:GetChildren()) do
    			if i > 10 then break end
    			if child:IsA("BasePart") then
    				position = child.Position
    				break
    			end
    		end
    	end
    	if position then
    		positionCache[cacheKey] = {
    			position = position,
    			time = currentTime
    		}
    	end
    	return position
    end
    local function processPromptsQueue()
    	if not AUTO_ACTIVATE then return end
    	local processed = 0
    	local maxPerFrame = 5
    	while #scanQueue > 0 and processed < maxPerFrame do
    		local prompt = table.remove(scanQueue, 1)
    		processed = processed + 1
    		if prompt and prompt.Parent then
    			local promptId = tostring(prompt)
    			if processedPrompts[promptId] and tick() - processedPrompts[promptId] < 2 then
    				continue
    			end
    			processedPrompts[promptId] = tick()
    			-- Find the animal model from the prompt
    			local animalModel = findAnimalModel(prompt)
    			local isTarget, foundName = isTargetAnimal(animalModel)
    			if isTarget and character and humanoidRootPart then
    				local playerPosition = humanoidRootPart.Position
    				local modelPosition = getModelPosition(prompt.Parent)
    				if modelPosition then
    					local distance = (playerPosition - modelPosition).Magnitude
    					if distance <= MAX_DISTANCE then
    						activateProximityPrompt(prompt)
    					end
    				end
    			end
    		end
    	end
    end
    local function scanExistingPrompts()
    	if not AUTO_ACTIVATE or not character or not humanoidRootPart then
    		return
    	end
    	-- Scan MovingAnimals folder specifically
    	local movingAnimals = game.Workspace:FindFirstChild("MovingAnimals")
    	if not movingAnimals then return end
    	for _, animalModel in pairs(movingAnimals:GetChildren()) do
    		if animalModel:IsA("Model") then
    			local success, prompt = pcall(function()
    				return animalModel.HumanoidRootPart.PromptAttachment.ProximityPrompt
    			end)
    			if success and prompt and prompt.Enabled then
    				table.insert(scanQueue, prompt)
    			end
    		end
    	end
    end
    local function startScript()
    	if SCRIPT_ACTIVE then return end
    	SCRIPT_ACTIVE = true
    	connections[#connections + 1] = ProximityPromptService.PromptShown:Connect(function(prompt, inputType)
    		if not AUTO_ACTIVATE then return end
    		local animalModel = findAnimalModel(prompt)
    		local isTarget, foundName = isTargetAnimal(animalModel)
    		if isTarget then
    			wait(0.1)
    			activateProximityPrompt(prompt)
    		end
    	end)
    	connections[#connections + 1] = ProximityPromptService.PromptHidden:Connect(function(prompt, inputType)
    		local promptId = tostring(prompt)
    		trackedPrompts[promptId] = nil
    		processedPrompts[promptId] = nil
    	end)
    	local lastScan = 0
    	local lastCleanup = 0
    	connections[#connections + 1] = RunService.Heartbeat:Connect(function()
    		if not AUTO_ACTIVATE then return end
    		local currentTime = tick()
    		if #scanQueue > 0 then
    			processPromptsQueue()
    		end
    		if currentTime - lastScan >= 3 then
    			lastScan = currentTime
    			if #scanQueue < 50 then
    				pcall(scanExistingPrompts)
    			end
    		end
    		if currentTime - lastCleanup >= 15 then
    			lastCleanup = currentTime
    			for promptId, time in pairs(lastActivation) do
    				if currentTime - time > 30 then
    					lastActivation[promptId] = nil
    				end
    			end
    			for promptId, time in pairs(processedPrompts) do
    				if currentTime - time > 10 then
    					processedPrompts[promptId] = nil
    				end
    			end
    			for key, data in pairs(positionCache) do
    				if currentTime - data.time > 2 then
    					positionCache[key] = nil
    				end
    			end
    		end
    	end)
    end
    local function stopScript()
    	if not SCRIPT_ACTIVE then return end
    	SCRIPT_ACTIVE = false
    	for _, connection in pairs(connections) do
    		if connection then
    			connection:Disconnect()
    		end
    	end
    	connections = {}
    	trackedPrompts = {}
    	lastActivation = {}
    	processedPrompts = {}
    	positionCache = {}
    	scanQueue = {}
    end
    local function toggleScript()
    	AUTO_ACTIVATE = not AUTO_ACTIVATE
    	updateButtonAppearance()
    	if AUTO_ACTIVATE then
    		startScript()
    	else
    		stopScript()
    	end
    end
    toggleButton.MouseButton1Click:Connect(toggleScript)
    local function onCharacterAdded(newCharacter)
    	character = newCharacter
    	humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    	if AUTO_ACTIVATE then
    		stopScript()
    		wait(1)
    		startScript()
    	end
    end
    player.CharacterAdded:Connect(onCharacterAdded)
    game.Players.PlayerRemoving:Connect(function(leavingPlayer)
    	if leavingPlayer == player then
    		stopScript()
    	end
    end)
    loadBrainrotNames()
    updateButtonAppearance()
    coroutine.wrap(function()
    	wait(2)
    	if AUTO_ACTIVATE then
    		scanExistingPrompts()
    	end
    end)()
end
task.spawn(LocalScript_2_generatedScript)
local function LocalScript_3_generatedScript()
    local script = Instance.new('LocalScript')
    script.Name = "LocalScript"
    script.Parent = Frame_1
	local container = script.Parent
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local TARGET_POSITION = Vector3.new(-410.752, -4.25, 78.906)
local DRAG_ACTIVE = false
local dragConnection = nil
local smoothDragConnection = nil
local currentVelocity = Vector3.new(0, 0, 0)
local lastPosition = nil
local dragStartTime = 0
local smoothFactor = 0.15
local maxSpeed = 25
local acceleration = 0.5
local deceleration = 0.85

local rarityTables = {
	common = {
		"Noobini Pizzanini",
		"Lirilì Larilà",
		"Tim Cheese",
		"Fluriflura",
		"Svinina Bombardino",
		"Talpa Di Fero",
		"Pipi Kiwi"
	},
	rare = {
		"Trippi Troppi",
		"Tung Tung Tung Sahur",
		"Gangster Footera",
		"Boneca Ambalabu",
		"Ta Ta Ta Ta Sahur",
		"Tric Trac Baraboom"
	},
	epic = {
		"Bandito Bobritto",
		"Cappuccino Assassino",
		"Brr Brr Patapim",
		"Trulimero Trulicina",
		"Bananita Dolphinita",
		"Brri Brri Bicus Dicus Bombicus",
		"Bambini Crostini",
		"Perochello Lemonchello",
		"Burbaloni Loliloli"
	},
	legendary = {
		"Chimpanzini Bananini",
		"Ballerina Cappuccina",
		"Chef Crabracadabra",
		"Glorbo Fruttodrillo",
		"Blueberrinni Octopusini",
		"Lionel Cactuseli"
	},
	mythic = {
		"Frigo Camelo",
		"Orangutini Ananassini",
		"Bombardiro Crocodilo",
		"Bombombini Gusini",
		"Rhino Toasterino",
		"Cavallo Virtuoso"
	},
	god = {
		"Cocofanto Elefanto",
		"Tralalero Tralala",
		"Odin Din Din Dun",
		"Girafa Celestre",
		"Gattatino Nyanino",
		"Trenostruzzo Turbo 3000",
		"Matteo",
		"Unclito Samito"
	},
	secret = {
		"La Vacca Saturno Saturnita",
		"Los Tralaleritos",
		"Graipuss Medussi",
		"La Grande Combinasion",
		"Sammyni Spyderini",
		"Garama and Madundung"
	}
}

local rarityColors = {
	common = {text = "COMUM", color = "#808080"},
	rare = {text = "RARO", color = "#4169E1"},
	epic = {text = "ÉPICO", color = "#9932CC"},
	legendary = {text = "LENDÁRIO", color = "#FFD700"},
	mythic = {text = "MÍTICO", color = "#FF1493"},
	god = {text = "DEUS", color = "#FF0000"},
	secret = {text = "SECRETO", color = "#00FF00"}
}

local function getRarityForName(name)
	for rarity, names in pairs(rarityTables) do
		for _, petName in ipairs(names) do
			if petName == name then
				return rarity
			end
		end
	end
	return "common"
end

local brainrotNames = {}
for rarity, names in pairs(rarityTables) do
	for _, name in ipairs(names) do
		table.insert(brainrotNames, name)
	end
end

local availableNames = {}
local selected = {}
local AUTO_ACTIVATE = false
local SCRIPT_ACTIVE = false
local MAX_DISTANCE = 15
local ACTIVATION_DELAY = 0.1
local trackedPrompts = {}
local lastActivation = {}
local connections = {}
local targetNames = {}
local processedPrompts = {}
local scanQueue = {}
local targetNamesCache = {}
local brainrotFolder = nil
local selectedNamesValue = nil
local lastKnownValue = ""
local SCRIPT_LOADED = false

local toggleBtn = container:WaitForChild("Toggle")
local autoBuyBtn = container:WaitForChild("ToggleBT") 
local scrollingFR = container:WaitForChild("ScrollingFrame")
local inf = container:WaitForChild('TextLabel')

local function startDrag()
	if DRAG_ACTIVE or not humanoidRootPart then return end
	
	DRAG_ACTIVE = true
	dragStartTime = tick()
	lastPosition = humanoidRootPart.Position
	currentVelocity = Vector3.new(0, 0, 0)
	
	if character and character:FindFirstChild("Humanoid") then
		character.Humanoid.PlatformStand = true
	end
	
	smoothDragConnection = RunService.Heartbeat:Connect(function()
		if not DRAG_ACTIVE or not humanoidRootPart then return end
		
		local currentPos = humanoidRootPart.Position
		local targetOffset = TARGET_POSITION - currentPos
		local distance = targetOffset.Magnitude
		
		if distance > 0.5 then
			local direction = targetOffset.Unit
			local timeElapsed = tick() - dragStartTime
			local speedMultiplier = math.min(1, timeElapsed * 0.5)
			
			currentVelocity = currentVelocity + direction * acceleration * speedMultiplier
			currentVelocity = currentVelocity * deceleration
			
			if currentVelocity.Magnitude > maxSpeed then
				currentVelocity = currentVelocity.Unit * maxSpeed
			end
			
			local newPosition = currentPos + currentVelocity * smoothFactor
			
			local bodyVelocity = humanoidRootPart:FindFirstChild("BodyVelocity")
			if not bodyVelocity then
				bodyVelocity = Instance.new("BodyVelocity")
				bodyVelocity.MaxForce = Vector3.new(4000, 0, 4000)
				bodyVelocity.Parent = humanoidRootPart
			end
			
			bodyVelocity.Velocity = (newPosition - currentPos) * 50
			
			if not humanoidRootPart:FindFirstChild("BodyPosition") then
				local bodyPosition = Instance.new("BodyPosition")
				bodyPosition.MaxForce = Vector3.new(2000, 8000, 2000)
				bodyPosition.P = 1200
				bodyPosition.D = 800
				bodyPosition.Position = newPosition
				bodyPosition.Parent = humanoidRootPart
			else
				humanoidRootPart.BodyPosition.Position = newPosition
			end
		else
			currentVelocity = currentVelocity * 0.8
			if currentVelocity.Magnitude < 0.1 then
				currentVelocity = Vector3.new(0, 0, 0)
			end
		end
		
		lastPosition = currentPos
	end)
end

local function stopDrag()
	if not DRAG_ACTIVE then return end
	
	DRAG_ACTIVE = false
	
	if smoothDragConnection then
		smoothDragConnection:Disconnect()
		smoothDragConnection = nil
	end
	
	if humanoidRootPart then
		for _, child in pairs(humanoidRootPart:GetChildren()) do
			if child:IsA("BodyPosition") or child:IsA("BodyVelocity") or child:IsA("BodyAngularVelocity") then
				child:Destroy()
			end
		end
	end
	
	if character and character:FindFirstChild("Humanoid") then
		character.Humanoid.PlatformStand = false
	end
	
	currentVelocity = Vector3.new(0, 0, 0)
end

local function scanForAvailableNames()
	local foundNames = {}
	for _, name in ipairs(brainrotNames) do
		table.insert(foundNames, name)
	end
	table.sort(foundNames)
	return foundNames
end

local function updateAvailableNames()
	availableNames = scanForAvailableNames()
end

local function setupCommunicationSystem()
	brainrotFolder = ReplicatedStorage:FindFirstChild("BrainrotSystem")
	if not brainrotFolder then
		brainrotFolder = Instance.new("Folder")
		brainrotFolder.Name = "BrainrotSystem"
		brainrotFolder.Parent = ReplicatedStorage
	end

	selectedNamesValue = brainrotFolder:FindFirstChild("SelectedNames")
	if not selectedNamesValue then
		selectedNamesValue = Instance.new("StringValue")
		selectedNamesValue.Name = "SelectedNames"
		selectedNamesValue.Value = ""
		selectedNamesValue.Parent = brainrotFolder
	end
end

local function saveSelectedNames()
	if not selectedNamesValue then return end

	local selectedList = {}
	for name in pairs(selected) do
		table.insert(selectedList, name)
	end

	local joinedNames = table.concat(selectedList, "|||")
	selectedNamesValue.Value = joinedNames
	lastKnownValue = joinedNames
end

local function loadSavedSelection()
	if not selectedNamesValue then return end

	selected = {}
	if selectedNamesValue.Value ~= "" then
		local savedNames = string.split(selectedNamesValue.Value, "|||")
		for _, name in ipairs(savedNames) do
			if name and name ~= "" then
				selected[name] = true
			end
		end
	end
end

local function waitForCommunicationSystem()
	local attempts = 0
	while attempts < 50 do
		brainrotFolder = ReplicatedStorage:FindFirstChild("BrainrotSystem")
		if brainrotFolder then break end
		attempts = attempts + 1
		wait(0.2)
	end

	if not brainrotFolder then return false end

	attempts = 0
	while attempts < 25 do
		selectedNamesValue = brainrotFolder:FindFirstChild("SelectedNames")
		if selectedNamesValue then break end
		attempts = attempts + 1
		wait(0.2)
	end

	return selectedNamesValue ~= nil
end

local function loadSelectedNames()
	if not selectedNamesValue then
		if not waitForCommunicationSystem() then
			return {}
		end
	end

	local currentValue = selectedNamesValue.Value
	if currentValue == "" then
		return {}
	end

	local selectedNames = string.split(currentValue, "|||")
	local validNames = {}

	for _, name in ipairs(selectedNames) do
		if name and name ~= "" then
			table.insert(validNames, name)
		end
	end

	lastKnownValue = currentValue
	return validNames
end

local function isTargetAnimal(animalModel)
	if not animalModel or not animalModel:FindFirstChild("HumanoidRootPart") then 
		return false, nil 
	end

	local humanoidRootPart = animalModel:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then return false, nil end

	local info = humanoidRootPart:FindFirstChild("Info")
	if not info then return false, nil end

	local animalOverhead = info:FindFirstChild("AnimalOverhead")
	if not animalOverhead then return false, nil end

	local displayName = animalOverhead:FindFirstChild("DisplayName")
	if not displayName or not displayName.Text then return false, nil end

	local animalName = displayName.Text

	-- Verifica se o nome está atualmente selecionado
	if selected[animalName] then
		return true, animalName
	end

	return false, nil
end

local function getAnimalProximityPrompt(animalModel)
	if not animalModel or not animalModel:FindFirstChild("HumanoidRootPart") then 
		return nil 
	end

	local humanoidRootPart = animalModel:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then return nil end

	local promptAttachment = humanoidRootPart:FindFirstChild("PromptAttachment")
	if not promptAttachment then return nil end

	local proximityPrompt = promptAttachment:FindFirstChild("ProximityPrompt")
	return proximityPrompt
end

local function activateProximityPrompt(prompt)
	if not prompt or not prompt.Parent or not AUTO_ACTIVATE or #targetNames == 0 then return end

	-- Verificação adicional do modelo do animal
	local animalModel = prompt.Parent.Parent.Parent
	if not animalModel then return end

	-- Verifica novamente se o animal ainda é um alvo válido
	local isTarget, _ = isTargetAnimal(animalModel)
	if not isTarget then return end

	local promptId = tostring(prompt)
	local currentTime = tick()

	if lastActivation[promptId] and currentTime - lastActivation[promptId] < 1 then
		return
	end

	lastActivation[promptId] = currentTime

	coroutine.wrap(function()
		local success = pcall(function()
			if fireproximityprompt then
				fireproximityprompt(prompt)
				return
			end
		end)

		if success then return end

		pcall(function()
			if prompt.HoldDuration > 0 then
				prompt:InputHoldBegin()
				wait(math.min(prompt.HoldDuration + 0.05, 0.5))
				prompt:InputHoldEnd()
			else
				prompt:InputHoldBegin()
				wait(ACTIVATION_DELAY)
				prompt:InputHoldEnd()
			end
		end)
	end)()
end

local positionCache = {}
local function getModelPosition(promptParent)
	local cacheKey = tostring(promptParent)
	local currentTime = tick()

	if positionCache[cacheKey] and currentTime - positionCache[cacheKey].time < 0.5 then
		return positionCache[cacheKey].position
	end

	local position = nil
	if promptParent:IsA("BasePart") then
		position = promptParent.Position
	elseif promptParent:FindFirstChild("HumanoidRootPart") then
		position = promptParent.HumanoidRootPart.Position
	elseif promptParent:IsA("Model") and promptParent.PrimaryPart then
		position = promptParent.PrimaryPart.Position
	else
		for i, child in pairs(promptParent:GetChildren()) do
			if i > 10 then break end
			if child:IsA("BasePart") then
				position = child.Position
				break
			end
		end
	end

	if position then
		positionCache[cacheKey] = {
			position = position,
			time = currentTime
		}
	end

	return position
end

local function scanMovingAnimals()
	if not AUTO_ACTIVATE or not character or not humanoidRootPart or #targetNames == 0 then
		return
	end

	local movingAnimals = workspace:FindFirstChild("MovingAnimals")
	if not movingAnimals then return end

	local playerPosition = humanoidRootPart.Position

	for _, animalModel in pairs(movingAnimals:GetChildren()) do
		if animalModel:IsA("Model") then
			local isTarget, foundName = isTargetAnimal(animalModel)
			if isTarget then
				local proximityPrompt = getAnimalProximityPrompt(animalModel)
				if proximityPrompt then
					local modelPosition = getModelPosition(animalModel)
					if modelPosition then
						local distance = (playerPosition - modelPosition).Magnitude
						if distance <= MAX_DISTANCE then
							activateProximityPrompt(proximityPrompt)
						end
					end
				end
			end
		end
	end
end

local function startScript()
	if SCRIPT_ACTIVE or #targetNames == 0 then return end

	SCRIPT_ACTIVE = true

	connections[#connections + 1] = ProximityPromptService.PromptShown:Connect(function(prompt, inputType)
		if not AUTO_ACTIVATE or #targetNames == 0 then return end

		local animalModel = prompt.Parent.Parent.Parent
		if animalModel and animalModel.Parent and animalModel.Parent.Name == "MovingAnimals" then
			local isTarget, foundName = isTargetAnimal(animalModel)
			if isTarget then
				wait(0.1)
				activateProximityPrompt(prompt)
			end
		end
	end)

	connections[#connections + 1] = ProximityPromptService.PromptHidden:Connect(function(prompt, inputType)
		local promptId = tostring(prompt)
		trackedPrompts[promptId] = nil
		processedPrompts[promptId] = nil
	end)

	local lastScan = 0
	local lastCleanup = 0

	connections[#connections + 1] = RunService.Heartbeat:Connect(function()
		if not AUTO_ACTIVATE or #targetNames == 0 then return end

		local currentTime = tick()

		if currentTime - lastScan >= 2 then
			lastScan = currentTime
			pcall(scanMovingAnimals)
		end

		if currentTime - lastCleanup >= 15 then
			lastCleanup = currentTime
			for promptId, time in pairs(lastActivation) do
				if currentTime - time > 30 then
					lastActivation[promptId] = nil
				end
			end
			for promptId, time in pairs(processedPrompts) do
				if currentTime - time > 10 then
					processedPrompts[promptId] = nil
				end
			end
			for key, data in pairs(positionCache) do
				if currentTime - data.time > 2 then
					positionCache[key] = nil
				end
			end
		end
	end)
end

local function stopScript()
	if not SCRIPT_ACTIVE then return end

	SCRIPT_ACTIVE = false

	for _, connection in pairs(connections) do
		if connection then
			connection:Disconnect()
		end
	end

	connections = {}
	trackedPrompts = {}
	lastActivation = {}
	processedPrompts = {}
	positionCache = {}
	scanQueue = {}
end

local function toggleScript()
	updateTargetNames()

	if #targetNames == 0 then
		AUTO_ACTIVATE = false
		updateButtonAppearance()
		return
	end

	AUTO_ACTIVATE = not AUTO_ACTIVATE
	updateButtonAppearance()

	if AUTO_ACTIVATE then
		startDrag()
		wait(2)
		startScript()
	else
		stopScript()
		stopDrag()
	end
end

local function updateCompleteUI()
	local count = 0
	for _ in pairs(selected) do count = count + 1 end

	if count > 0 then
		toggleBtn.Text = "🎯 SELECTED (" .. count .. ")"
		toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
	else
		toggleBtn.Text = "🎯 SELECT ITEMS"
		toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	end

	updateTargetNames()
	updateButtonAppearance()
end

local function hideElementsForSelection()
	autoBuyBtn.Visible = false
	inf.Visible = false
end

local function showElementsAfterSelection()
	autoBuyBtn.Visible = true
	inf.Visible = true
end

local function populateScrolling()
	for _, child in pairs(scrollingFR:GetChildren()) do
		if child:IsA("TextButton") or child:IsA("Frame") then
			child:Destroy()
		end
	end

	local y = 0
	for _, name in ipairs(availableNames) do
		local btn = Instance.new("TextButton")
		local UICorner = Instance.new('UICorner')
		local UIStroke = Instance.new('UIStroke')
		local UIPadding = Instance.new('UIPadding')

		btn.Name = name
		btn.Position = UDim2.new(0, 0, 0, 0)
		btn.Size = UDim2.new(0.973592997, 0, 0.115199991, 0)
		btn.BackgroundColor3 = Color3.new(0.580392, 0.580392, 0.580392)
		btn.BackgroundTransparency = 0.800000
		btn.BorderColor3 = Color3.new(0.000000, 0.000000, 0.000000)
		btn.BorderSizePixel = 0
		btn.Font = Enum.Font.Arcade
		btn.TextColor3 = Color3.new(1.000000, 1.000000, 1.000000)
		btn.TextScaled = true  -- Mudança: ativei TextScaled para ajustar automaticamente
		btn.TextSize = 12
		btn.TextWrapped = true  -- Mudança: ativei TextWrapped para quebrar linha se necessário
		btn.TextXAlignment = Enum.TextXAlignment.Left
		btn.RichText = true

		UICorner.CornerRadius = UDim.new(0, 8)
		UICorner.Parent = btn

		UIStroke.Thickness = 1
		UIStroke.Transparency = 0
		UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UIStroke.Color = Color3.new(1, 1, 1)
		UIStroke.Parent = btn

		UIPadding.PaddingLeft = UDim.new(0, 8)
		UIPadding.PaddingRight = UDim.new(0, 8)
		UIPadding.PaddingTop = UDim.new(0, 4)
		UIPadding.PaddingBottom = UDim.new(0, 4)
		UIPadding.Parent = btn

		btn.Parent = scrollingFR

		local rarity = getRarityForName(name)
		local rarityInfo = rarityColors[rarity]
		local rarityText = '<font color="' .. rarityInfo.color .. '">' .. rarityInfo.text .. '</font>'

		-- Mudança: Formatação unificada do texto com tamanho consistente
		local statusIcon = selected[name] and '🟢' or '🔴'
		local formattedText = '<font size="12">' .. statusIcon .. ' ' .. name .. ' - ' .. rarityText .. '</font>'

		if selected[name] then
			btn.BackgroundTransparency = 0.7
			btn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
			btn.Text = formattedText
		else
			btn.BackgroundTransparency = 0.35
			btn.BackgroundColor3 = Color3.new(0, 0, 0)
			btn.Text = formattedText
		end

		btn.MouseButton1Click:Connect(function()
			-- Atualizar o estado de seleção
			selected[name] = not selected[name]
			
			-- Atualizar aparência do botão
			local newStatusIcon = selected[name] and '🟢' or '🔴'
			local newFormattedText = '<font size="12">' .. newStatusIcon .. ' ' .. name .. ' - ' .. rarityText .. '</font>'
			
			if selected[name] then
				btn.BackgroundTransparency = 0.7
				btn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
				btn.Text = newFormattedText
			else
				btn.BackgroundTransparency = 0.35
				btn.BackgroundColor3 = Color3.new(0, 0, 0)
				btn.Text = newFormattedText
			end

			saveSelectedNames()

			-- Contar itens selecionados
			local count = 0
			for _ in pairs(selected) do count = count + 1 end

			-- Atualizar botão de toggle
			if count > 0 then
				toggleBtn.Text = "🎯 SELECTED (" .. count .. ")"
				toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
			else
				toggleBtn.Text = "🎯 SELECT ITEMS"
				toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			end

			updateTargetNames()
			updateButtonAppearance()
		end)

		y = y + 32
	end

	-- Adicionar frames de espaçamento
	for i = 1, 3 do
		local zzz = Instance.new('Frame')
		zzz.BackgroundColor3 = Color3.new(0.000000, 0.000000, 0.000000)
		zzz.BackgroundTransparency = 0.350000
		zzz.BorderColor3 = Color3.new(0.000000, 0.000000, 0.000000)
		zzz.BorderSizePixel = 0.000000
		zzz.Name = "zzz" .. i
		zzz.Size = UDim2.new(0.973593, 0, 0.115200, 0)
		zzz.Parent = scrollingFR
		
		y = y + 32
	end

	scrollingFR.CanvasSize = UDim2.new(0, 0, 0, 0)
end

local function showLoadingStatus()
	toggleBtn.Text = "⏳ LOADING..."
	toggleBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 0)
	autoBuyBtn.Visible = true
	inf.Visible = true
end

local function finishLoading()
	SCRIPT_LOADED = true
	updateCompleteUI()
end

toggleBtn.MouseButton1Click:Connect(function()
	if not SCRIPT_LOADED then
		toggleBtn.Text = "⚠️ WAIT FOR LOADING!"
		toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
		wait(1.5)
		if SCRIPT_LOADED then
			finishLoading()
		else
			showLoadingStatus()
		end
		return
	end

	if scrollingFR.Visible then
		scrollingFR.Visible = false
		showElementsAfterSelection()
		updateCompleteUI()
	else
		updateAvailableNames()
		hideElementsForSelection()
		scrollingFR.Visible = true

		local count = 0
		for _ in pairs(selected) do count = count + 1 end

		if count > 0 then
			toggleBtn.Text = "🎯 SELECTED (" .. count .. ") - CLICK TO CLOSE"
		else
			toggleBtn.Text = "🎯 SELECT ITEMS - CLICK TO CLOSE"
		end
		toggleBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)

		populateScrolling()
	end
end)

autoBuyBtn.MouseButton1Click:Connect(function()
	if not SCRIPT_LOADED then
		return
	end
	toggleScript()
end)

local function onCharacterAdded(newCharacter)
	character = newCharacter
	humanoidRootPart = character:WaitForChild("HumanoidRootPart")
	
	if DRAG_ACTIVE then
		stopDrag()
		wait(1)
		startDrag()
	end
	
	if AUTO_ACTIVATE then
		stopScript()
		wait(1)
		startScript()
	end
end

player.CharacterAdded:Connect(onCharacterAdded)

game.Players.PlayerRemoving:Connect(function(leavingPlayer)
	if leavingPlayer == player then
		stopScript()
		stopDrag()
	end
end)

coroutine.wrap(function()
	showLoadingStatus()
	
	setupCommunicationSystem()
	wait(0.5)
	
	loadSavedSelection()
	wait(0.5)
	
	updateAvailableNames()
	wait(0.5)
	
	updateTargetNames()
	wait(0.5)
	
	setupChangeMonitoring()
	updateButtonAppearance()
	wait(0.5)
	
	finishLoading()
	
	wait(2)
	if AUTO_ACTIVATE and #targetNames > 0 then
		scanMovingAnimals()
	end
end)()
end
task.spawn(LocalScript_3_generatedScript)
