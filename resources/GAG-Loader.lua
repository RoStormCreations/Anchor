local Anchor = loadstring(game:HttpGet("https://raw.githubusercontent.com/RoStormCreations/Anchor/refs/heads/main/resources/library.lua"))()
local Window = Anchor:CreateWindow("Anchor - GAG")

Window:SetTheme({
	Main = Color3.fromRGB(10, 10, 10),
	Second = Color3.fromRGB(30, 30, 30),
	Accent = Color3.fromRGB(255, 100, 100),
	Stroke = Color3.fromRGB(80, 80, 80),
	Text = Color3.fromRGB(255, 255, 255),
	TextDark = Color3.fromRGB(150, 150, 150)
})

local HomeTab = Window:AddTab("Home")
HomeTab:AddLabel("Welcome to Anchor UI")

local mainTab = Window:AddTab("Main")
mainTab:AddToggle("Enable Feature", function(state)
    print("Toggle is now:", state)
end)
