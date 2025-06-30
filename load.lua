-- Services
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- UIS
local function createKickGui()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "KickGui"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = player:WaitForChild("PlayerGui")

    -- Frame
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 150)
    frame.Position = UDim2.new(0.5, -150, 0.5, -75)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.Parent = ScreenGui

    -- Title Text
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundTransparency = 1
    title.Text = "Access Denied"
    title.TextColor3 = Color3.fromRGB(255, 100, 100)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 24
    title.Parent = frame

    -- Info Text
    local info = Instance.new("TextLabel")
    info.Size = UDim2.new(1, -20, 0, 60)
    info.Position = UDim2.new(0, 10, 0, 40)
    info.BackgroundTransparency = 1
    info.Text = "You are not authorized to use this script."
    info.TextColor3 = Color3.fromRGB(200, 200, 200)
    info.Font = Enum.Font.Gotham
    info.TextSize = 18
    info.TextWrapped = true
    info.Parent = frame

    -- Kick Button
    local kickBtn = Instance.new("TextButton")
    kickBtn.Size = UDim2.new(0.4, 0, 0, 40)
    kickBtn.Position = UDim2.new(0.05, 0, 1, -50)
    kickBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    kickBtn.Text = "Kick Me"
    kickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    kickBtn.Font = Enum.Font.GothamBold
    kickBtn.TextSize = 20
    kickBtn.Parent = frame

    -- Cancel Button
    local cancelBtn = Instance.new("TextButton")
    cancelBtn.Size = UDim2.new(0.4, 0, 0, 40)
    cancelBtn.Position = UDim2.new(0.55, 0, 1, -50)
    cancelBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    cancelBtn.Text = "Cancel"
    cancelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    cancelBtn.Font = Enum.Font.GothamBold
    cancelBtn.TextSize = 20
    cancelBtn.Parent = frame

    -- Kick button click
    kickBtn.MouseButton1Click:Connect(function()
        player:Kick("You have been kicked: Not authorized to use this script.")
    end)

    -- Cancel button click
    cancelBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
end
-- JSON URL
local jsonUrl = "https://raw.githubusercontent.com/RoStormCreations/Anchor/refs/heads/main/AuthorizedUsers.json"

-- Function to check authorization
local function isUserAuthorized()
    local success, response = pcall(function()
        return HttpService:GetAsync(jsonUrl)
    end)

    if success then
        local data = HttpService:JSONDecode(response)
        
        -- Check if the JSON is a list
        if typeof(data) == "table" then
            for _, username in ipairs(data) do
                if username == player.Name then
                    return true
                end
            end
        end
    else
        warn("Failed to fetch authorized users list:", response)
    end

    return false
end

-- Execution
if isUserAuthorized() then
loadstring(game:HttpGet("https://raw.githubusercontent.com/RoStormCreations/Anchor/refs/heads/main/resources/GAG-Loader.lua"))()
else
    print("❌ Access denied: " .. player.Name .. " is not authorized.")
     createKickGui()
end
