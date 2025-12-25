local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local me = Players.LocalPlayer

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local fileName = "savedPosition.txt"

if isfile(fileName) then
	local savedData = readfile(fileName)
	local x, y, z = savedData:match("([^,]+),([^,]+),([^,]+)")
	
	if x and y and z then
		humanoidRootPart.CFrame = CFrame.new(tonumber(x), tonumber(y), tonumber(z))
		print("Teleported to saved position: " .. savedData)
		
		delfile(fileName)
		print("Deleted saved position file")
	else
		print("Error: Could not parse saved position data")
	end
else
	print("No saved position found. File does not exist.")
end

local commands = {
	["!tprj"] = function()
		local pos = humanoidRootPart.Position
		local posString = tostring(pos.X) .. "," .. tostring(pos.Y) .. "," .. tostring(pos.Z)
		writefile(fileName, posString)
		print("Saved position: " .. posString)
		
		task.wait(0.5)
		loadstring(game:HttpGet("https://akadmin-bzk.pages.dev/gtarejoin.lua"))()
	end
}

TextChatService.MessageReceived:Connect(function(message)
	if message.TextSource and message.TextSource.UserId == me.UserId then
		local msg = message.Text:lower()
		local cmd = msg:match("^%S+")
		if commands[cmd] then
			commands[cmd]()
		end
	end
end)
