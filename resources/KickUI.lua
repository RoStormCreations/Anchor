local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")

local jsonUrl = "https://raw.githubusercontent.com/RoStormCreations/Anchor/refs/heads/main/AuthorizedUsers.json"
local discordInvite = "https://discord.gg/YOUR_DISCORD_LINK" -- Replace with your Discord invite link

-- Function to fetch and check authorization
local function isUserAuthorized()
    local success, response = pcall(function()
        return HttpService:GetAsync(jsonUrl)
    end)
    if success then
        local data = HttpService:JSONDecode(response)
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

-- Function to create the kick GUI
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

    -- Purchase Button
    local purchaseBtn = Instance.new("TextButton")
    purchaseBtn.Size = UDim2.new(0.4, 0, 0, 40)
    purchaseBtn.Position = UDim2.new(0.55, 0, 1, -50)
    purchaseBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 250)
    purchaseBtn.Text = "Purchase"
    purchaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    purchaseBtn.Font = Enum.Font.GothamBold
    purchaseBtn.TextSize = 20
    purchaseBtn.Parent = frame

    -- Kick button click
    kickBtn.MouseButton1Click:Connect(function()
        player:Kick("You have been kicked: Not authorized to use this script.")
    end)
    purchaseBtn.MouseButton1Click:Connect(function()
        if RunService:IsClient() then
            local success, result = pcall(function()
                return GuiService:PromptBrowserWindow(discordInvite)
            end)
            if not success then
                warn("Failed to open Discord invite link:", result)
            end
        end
    end)
end

createKickGui()
