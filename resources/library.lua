-- Anchor Library
-- Misc Functions
local function GS(name)
	local service = game:GetService(name)
	return if cloneref then cloneref(service) else service
end
-- Abbreviations
A_IT = instance.new
-- Game Services
local Players = getService("Players")
local CoreGui = getService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
	
-- Library
local Gate = {}
Anchor.__index = Anchor

local Theme = {
	Main = Color3.fromRGB(25, 25, 25),
	Second = Color3.fromRGB(32, 32, 32),
	Accent = Color3.fromRGB(85, 170, 255),
	Stroke = Color3.fromRGB(60, 60, 60),
	Text = Color3.fromRGB(240, 240, 240),
	TextDark = Color3.fromRGB(140, 140, 140)
}

local function MakeDraggable(Frame, DragHandle)
	local dragging, dragStart, startPos = false, nil, nil
	DragHandle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = Frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

function Anchor:CreateWindow(title)
	local ScreenGui = A_IT("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
	ScreenGui.Name = "AnchorLibrary"
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	local MainFrame = A_IT("Frame", ScreenGui)
	MainFrame.Size = UDim2.new(0, 450, 0, 300)
	MainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
	MainFrame.BackgroundColor3 = Theme.Main
	MainFrame.BorderSizePixel = 0
	MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)

	local UICorner = A_IT("UICorner", MainFrame)
	UICorner.CornerRadius = UDim.new(0, 8)

	local TitleBar = A_IT("TextLabel", MainFrame)
	TitleBar.Size = UDim2.new(1, 0, 0, 30)
	TitleBar.BackgroundTransparency = 1
	TitleBar.Text = title or "Anchor"
	TitleBar.Font = Enum.Font.GothamBold
	TitleBar.TextColor3 = Theme.Text
	TitleBar.TextSize = 18
	MakeDraggable(MainFrame, TitleBar)

	local TabHolder = A_IT("Frame", MainFrame)
	TabHolder.Position = UDim2.new(0, 0, 0, 30)
	TabHolder.Size = UDim2.new(0, 120, 1, -30)
	TabHolder.BackgroundColor3 = Theme.Second
	TabHolder.BorderSizePixel = 0
	Instance.new("UICorner", TabHolder).CornerRadius = UDim.new(0, 8)
	local UIListLayout = Instance.new("UIListLayout", TabHolder)
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

	local ContentFrame = A_IT("Frame", MainFrame)
	ContentFrame.Position = UDim2.new(0, 125, 0, 35)
	ContentFrame.Size = UDim2.new(1, -130, 1, -40)
	ContentFrame.BackgroundTransparency = 1
	local tabs = {}

	function Anchor:AddTab(tabName)
		local Button = A_IT("TextButton", TabHolder)
		Button.Size = UDim2.new(1, 0, 0, 30)
		Button.BackgroundTransparency = 1
		Button.Text = tabName
		Button.Font = Enum.Font.GothamSemibold
		Button.TextColor3 = Theme.TextDark
		Button.TextSize = 14
		local TabFrame = A_IT("Frame", ContentFrame)
		TabFrame.Name = tabName
		TabFrame.Size = UDim2.new(1, 0, 1, 0)
		TabFrame.BackgroundTransparency = 1
		TabFrame.Visible = false
		local Layout = A_IT("UIListLayout", TabFrame)
		Layout.Padding = UDim.new(0, 6)
		tabs[tabName] = TabFrame
		Button.MouseButton1Click:Connect(function()
			for name, tab in pairs(tabs) do
				tab.Visible = (name == tabName)
			end
			for _, btn in pairs(TabHolder:GetChildren()) do
				if btn:IsA("TextButton") then
					btn.TextColor3 = Theme.TextDark
				end
			end
			Button.TextColor3 = Theme.Text
		end)

		local elements = {}

		elements.AddLabel = function(_, text)
			local Label = A_IT("TextLabel", TabFrame)
			Label.Size = UDim2.new(1, 0, 0, 25)
			Label.BackgroundTransparency = 1
			Label.Font = Enum.Font.GothamSemibold
			Label.TextColor3 = Theme.Text
			Label.TextSize = 14
			Label.Text = text
		end

		elements.AddButton = function(_, text, callback)
			local Btn = A_IT("TextButton", TabFrame)
			Btn.Size = UDim2.new(1, 0, 0, 30)
			Btn.BackgroundColor3 = Theme.Second
			Btn.Text = text
			Btn.Font = Enum.Font.Gotham
			Btn.TextColor3 = Theme.Text
			Btn.TextSize = 14
			Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
			Btn.MouseButton1Click:Connect(function() pcall(callback) end)
		end
		elements.AddParagraph = function(_, text, callback)
			local pgh = A_IT("TextLabel", TabFrame)
			pgh.Size = UDim2.new(1, 0, 0, 30)
			pgh.BackgroundColor3 = Theme.Second
			pgh.Text = text
			pgh.Font = Enum.Font.Gotham
			pgh.TextColor3 = Theme.Text
			pgh.TextSize = 12
			Instance.new("UICorner", pgh).CornerRadius = UDim.new(0, 6)
		end
		elements.AddToggle = function(_, text, callback)
			local Toggle = A_IT("TextButton", TabFrame)
			Toggle.Size = UDim2.new(1, 0, 0, 30)
			Toggle.BackgroundColor3 = Theme.Second
			Toggle.Font = Enum.Font.Gotham
			Toggle.TextColor3 = Theme.Text
			Toggle.TextSize = 14
			Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0, 6)
			local State = false
			local function updateText() Toggle.Text = (State and "[✔] " or "[ ] ") .. text end
			updateText()
			Toggle.MouseButton1Click:Connect(function()
				State = not State
				updateText()
				pcall(callback, State)
			end)
		end

		return elements
	end

	return Anchor
	-- Theme Applier
	local function ChangeTheme(Theme)
	if typeof(Theme) == 'string' then
		SelectedTheme = Anchor.Theme[Theme]
	elseif typeof(Theme) == 'table' then
		SelectedTheme = Theme
	end
		Rayfield.Main.BackgroundColor3 = SelectedTheme.Background
	Rayfield.Main.Topbar.BackgroundColor3 = SelectedTheme.Topbar
	Rayfield.Main.Topbar.CornerRepair.BackgroundColor3 = SelectedTheme.Topbar
	Rayfield.Main.Shadow.Image.ImageColor3 = SelectedTheme.Shadow

	Rayfield.Main.Topbar.ChangeSize.ImageColor3 = SelectedTheme.TextColor
	Rayfield.Main.Topbar.Hide.ImageColor3 = SelectedTheme.TextColor
	Rayfield.Main.Topbar.Search.ImageColor3 = SelectedTheme.TextColor
	end
end

return Anchor
