-- Anchor Library v2 - Polished, Animated, and Modular
local Anchor = {}
Anchor.__index = Anchor

--// Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

--// Instance shorthand
local function New(inst, props)
	local obj = Instance.new(inst)
	for k, v in pairs(props or {}) do
		obj[k] = v
	end
	return obj
end

--// Theme
local DefaultTheme = {
	Main = Color3.fromRGB(25, 25, 25),
	Second = Color3.fromRGB(32, 32, 32),
	Accent = Color3.fromRGB(85, 170, 255),
	Stroke = Color3.fromRGB(60, 60, 60),
	Text = Color3.fromRGB(240, 240, 240),
	TextDark = Color3.fromRGB(140, 140, 140)
}

--// Draggable Function
local function MakeDraggable(frame, handle)
	local dragging, dragStart, startPos = false, nil, nil
	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
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
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

--// Create Window
function Anchor:CreateWindow(title)
	title = title or "Anchor"
	local self = setmetatable({}, Anchor)
	self.Theme = DefaultTheme

	local gui = New("ScreenGui", {
		Name = "AnchorLibrary",
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
	})

	local main = New("Frame", {
		Size = UDim2.new(0, 480, 0, 310),
		Position = UDim2.new(0.5, -240, 0.5, -155),
		BackgroundColor3 = self.Theme.Main,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Parent = gui
	})
	New("UICorner", { CornerRadius = UDim.new(0, 8), Parent = main })

	local topBar = New("TextLabel", {
		Size = UDim2.new(1, 0, 0, 35),
		BackgroundTransparency = 1,
		Text = title,
		Font = Enum.Font.GothamBold,
		TextColor3 = self.Theme.Text,
		TextSize = 18,
		Parent = main
	})
	MakeDraggable(main, topBar)

	local tabHolder = New("Frame", {
		Size = UDim2.new(0, 130, 1, -35),
		Position = UDim2.new(0, 0, 0, 35),
		BackgroundColor3 = self.Theme.Second,
		BorderSizePixel = 0,
		Parent = main
	})
	New("UICorner", { CornerRadius = UDim.new(0, 8), Parent = tabHolder })
	New("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Parent = tabHolder })

	local contentFrame = New("Frame", {
		Size = UDim2.new(1, -140, 1, -45),
		Position = UDim2.new(0, 140, 0, 40),
		BackgroundTransparency = 1,
		Parent = main
	})

	local tabs = {}

	function self:AddTab(tabName)
		local tabBtn = New("TextButton", {
			Size = UDim2.new(1, 0, 0, 30),
			BackgroundTransparency = 1,
			Text = tabName,
			Font = Enum.Font.GothamSemibold,
			TextColor3 = self.Theme.TextDark,
			TextSize = 14,
			Parent = tabHolder
		})

		local tabFrame = New("Frame", {
			Name = tabName,
			Size = UDim2.new(1, 0, 1, 0),
			Visible = false,
			BackgroundTransparency = 1,
			Parent = contentFrame
		})
		New("UIListLayout", { Padding = UDim.new(0, 6), Parent = tabFrame })
		tabs[tabName] = tabFrame

		tabBtn.MouseButton1Click:Connect(function()
			for name, frame in pairs(tabs) do
				frame.Visible = (name == tabName)
			end
			for _, btn in pairs(tabHolder:GetChildren()) do
				if btn:IsA("TextButton") then
					TweenService:Create(btn, TweenInfo.new(0.2), { TextColor3 = self.Theme.TextDark }):Play()
				end
			end
			TweenService:Create(tabBtn, TweenInfo.new(0.2), { TextColor3 = self.Theme.Text }):Play()
		end)

		local elements = {}

		elements.AddLabel = function(_, text)
			New("TextLabel", {
				Size = UDim2.new(1, 0, 0, 25),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamSemibold,
				TextColor3 = self.Theme.Text,
				TextSize = 14,
				Text = text,
				Parent = tabFrame
			})
		end

		elements.AddButton = function(_, text, callback)
			local btn = New("TextButton", {
				Size = UDim2.new(1, 0, 0, 30),
				BackgroundColor3 = self.Theme.Second,
				Text = text,
				Font = Enum.Font.Gotham,
				TextColor3 = self.Theme.Text,
				TextSize = 14,
				Parent = tabFrame
			})
			New("UICorner", { CornerRadius = UDim.new(0, 6), Parent = btn })
			btn.MouseButton1Click:Connect(function()
				TweenService:Create(btn, TweenInfo.new(0.1), { BackgroundColor3 = self.Theme.Accent }):Play()
				pcall(callback)
				wait(0.15)
				TweenService:Create(btn, TweenInfo.new(0.2), { BackgroundColor3 = self.Theme.Second }):Play()
			end)
		end

		elements.AddToggle = function(_, text, callback)
			local state = false
			local container = New("Frame", {
				Size = UDim2.new(1, 0, 0, 30),
				BackgroundTransparency = 1,
				Parent = tabFrame
			})

			local toggleBtn = New("TextButton", {
				Size = UDim2.new(0, 30, 1, 0),
				BackgroundColor3 = self.Theme.Second,
				Text = "✖",
				Font = Enum.Font.GothamBold,
				TextSize = 14,
				TextColor3 = self.Theme.Text,
				Parent = container
			})
			New("UICorner", { CornerRadius = UDim.new(0, 6), Parent = toggleBtn })

			local label = New("TextLabel", {
				Size = UDim2.new(1, -35, 1, 0),
				Position = UDim2.new(0, 35, 0, 0),
				BackgroundTransparency = 1,
				Text = text,
				Font = Enum.Font.Gotham,
				TextSize = 14,
				TextColor3 = self.Theme.Text,
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = container
			})

			toggleBtn.MouseButton1Click:Connect(function()
				state = not state
				toggleBtn.Text = state and "✔" or "✖"
				pcall(callback, state)
			end)
		end

		return elements
	end

	function self:SetTheme(newTheme)
		self.Theme = newTheme
		main.BackgroundColor3 = self.Theme.Main
		tabHolder.BackgroundColor3 = self.Theme.Second
		topBar.TextColor3 = self.Theme.Text
		for _, btn in pairs(tabHolder:GetChildren()) do
			if btn:IsA("TextButton") then
				btn.TextColor3 = self.Theme.TextDark
			end
		end
	end

	return self
end

return Anchor
