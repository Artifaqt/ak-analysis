local Players = game:GetService("Players")
local GroupService = game:GetService("GroupService")
local player = Players.LocalPlayer
local groupId = 36018037
if not player:IsInGroup(groupId) then
    GroupService:PromptJoinAsync(groupId)
else
end

