local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local jsonUrl = "https://raw.githubusercontent.com/RoStormCreations/Anchor/refs/heads/main/AuthorizedUsers.json"
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
-- Execution
if isUserAuthorized() then
loadstring(game:HttpGet("https://raw.githubusercontent.com/RoStormCreations/Anchor/refs/heads/main/resources/R3JvdyBBIEdhcmRlbg.lua"))()
else
loadstring(game:HttpGet("https://raw.githubusercontent.com/RoStormCreations/Anchor/refs/heads/main/resources/KickUI.lua"))()
end
