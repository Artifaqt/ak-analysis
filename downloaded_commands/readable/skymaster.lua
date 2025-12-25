local flag = false

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game:GetService("Players").LocalPlayer.PlayerGui
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 100)
frame.Position = UDim2.new(0.5, -200, 0, 20)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BackgroundTransparency = 0.5
frame.BorderSizePixel = 0
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, -10, 0, 20)
textLabel.Position = UDim2.new(0, 10, 0, 5)
textLabel.BackgroundTransparency = 1
textLabel.Text = "AK ADMIN"
textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.Font = Enum.Font.GothamBold
textLabel.TextSize = 14
textLabel.TextXAlignment = Enum.TextXAlignment.Left
textLabel.Parent = frame

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, -20, 0, 20)
textLabel.Position = UDim2.new(0, 10, 0, 28)
textLabel.BackgroundTransparency = 1
textLabel.Text = "to use this equip the torso of this bundle (R15 only)"
textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.Font = Enum.Font.Gotham
textLabel.TextSize = 12
textLabel.TextWrapped = true
textLabel.Parent = frame

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0, 300, 0, 22)
textBox.Position = UDim2.new(0.5, -150, 0, 52)
textBox.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
textBox.BackgroundTransparency = 0.3
textBox.Text = "https://www.roblox.com/bundles/28334386015043"
textBox.TextColor3 = Color3.fromRGB(85, 170, 255)
textBox.Font = Enum.Font.Gotham
textBox.TextSize = 10
textBox.ClearTextOnFocus = false
textBox.TextEditable = false
textBox.Parent = frame

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 4)
corner.Parent = textBox

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 80, 0, 20)
button.Position = UDim2.new(1, -90, 1, -25)
button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
button.Text = "Copy Link"
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.Gotham
button.TextSize = 11
button.Parent = frame

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 4)
corner.Parent = button

button.MouseButton1Click:Connect(function()
	setclipboard("https://www.roblox.com/bundles/148351107651039/pro - builder - very - old - and - outdated")
	button.Text = "Copied!"
	task.wait(1)
	button.Text = "Copy Link"
end)

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 20, 0, 20)
button.Position = UDim2.new(1, -25, 0, 5)
button.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
button.Text = "X"
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.GothamBold
button.TextSize = 14
button.Parent = frame

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 4)
corner.Parent = button

button.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

local tool = Instance.new("Tool")
tool.Name = "Sky Master"
tool.RequiresHandle = false
tool.Parent = game:GetService("Players").LocalPlayer.Backpack

tool.Equipped:Connect(function()
	tool:WaitForChild("Humanoid", 0.1)
	task.wait()
	tool.Parent = game:GetService("Players").LocalPlayer.Backpack
	
	if flag then return end
	flag = true
	
	local players = game:GetService("Players").LocalPlayer
	local character = players.Character or players.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	local humanoid = character:WaitForChild("HumanoidRootPart")
	local workspace = game:GetService("Workspace").CurrentCamera

	local animation = Instance.new("Animation")
	animation.AnimationId = "rbxassetid://674871189"
	local animation2 = Instance.new("Animation")
	animation2.AnimationId = "rbxassetid://70883871260184"

	local animation3 = humanoid:LoadAnimation(animation)
	local animation4 = humanoid:LoadAnimation(animation2)

	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://125769978282211"
	sound.Parent = humanoid
	local sound2 = Instance.new("Sound")
	sound2.SoundId = "rbxassetid://126397142477715"
	sound2.Parent = humanoid

	local highlight = Instance.new("Highlight")
	highlight.Parent = character
	highlight.FillTransparency = 1
	highlight.OutlineTransparency = 1

	local blureffect = Instance.new("BlurEffect")
	blureffect.Parent = workspace
	blureffect.Size = 0

	task.wait(0.5)

	animation3:Play()
	animation3.Looped = true
	sound:Play()

	for i = 0, 1, 0.05 do
		highlight.FillTransparency = 1 - i * 0.5
		highlight.OutlineTransparency = 1 - i
		blureffect.Size = i * 15
		task.wait()
	end

	task.wait(3)

	animation3.Looped = false
	animation3:Stop()

	for i = 1, 0, -0.1 do
		highlight.FillTransparency = 1 - i * 0.5
		highlight.OutlineTransparency = 1 - i
		blureffect.Size = i * 15
		task.wait()
	end

	highlight:Destroy()
	blureffect:Destroy()

	for _, tr in pairs(humanoid:GetPlayingAnimationTracks()) do
		if tr ~= animation4 then
			tr:Stop()
		end
	end

	sound2:Play()
	animation4:Play()
	task.wait(4)

	animation4:Stop()
	sound2:Stop()
	
	flag = false
end)
