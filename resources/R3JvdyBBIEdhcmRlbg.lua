local Anchor = loadstring(game:HttpGet("https://raw.githubusercontent.com/RoStormCreations/Anchor/refs/heads/main/resources/library.lua"))()
local Window = Anchor:CreateWindow("Anchor - GAG")

Window:SetTheme({
    Main = Color3.fromRGB(34, 49, 24),      -- Dark moss green
    Second = Color3.fromRGB(64, 85, 43),    -- Olive green
    Accent = Color3.fromRGB(120, 180, 90),  -- Fresh leaf green
    Stroke = Color3.fromRGB(46, 64, 29),    -- Deep forest green (border)
    Text = Color3.fromRGB(230, 240, 210),   -- Light cream (text)
    TextDark = Color3.fromRGB(170, 190, 150) -- Muted sage green (dark text)
})

local HomeTab = Window:AddTab("Home")
HomeTab:AddLabel("Welcome to Anchor UI")

local mainTab = Window:AddTab("Main")
mainTab:AddToggle("Enable Feature", function(state)
    print("Toggle is now:", state)
end)
