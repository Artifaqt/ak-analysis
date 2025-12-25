local ac = false

local sg = Instance.new("ScreenGui")
sg.Parent = game:GetService("Players").LocalPlayer.PlayerGui
sg.ResetOnSpawn = false

local fr = Instance.new("Frame")
fr.Size = UDim2.new(0, 400, 0, 100)
fr.Position = UDim2.new(0.5, -200, 0, 20)
fr.BackgroundColor3 = Color3.new(0, 0, 0)
fr.BackgroundTransparency = 0.5
fr.BorderSizePixel = 0
fr.Parent = sg

local cr = Instance.new("UICorner")
cr.CornerRadius = UDim.new(0, 8)
cr.Parent = fr

local tt = Instance.new("TextLabel")
tt.Size = UDim2.new(1, -10, 0, 20)
tt.Position = UDim2.new(0, 10, 0, 5)
tt.BackgroundTransparency = 1
tt.Text = "AK ADMIN"
tt.TextColor3 = Color3.new(1, 1, 1)
tt.Font = Enum.Font.GothamBold
tt.TextSize = 14
tt.TextXAlignment = Enum.TextXAlignment.Left
tt.Parent = fr

local tx = Instance.new("TextLabel")
tx.Size = UDim2.new(1, -20, 0, 20)
tx.Position = UDim2.new(0, 10, 0, 28)
tx.BackgroundTransparency = 1
tx.Text = "to use this equip the torso of this bundle (R15 only)"
tx.TextColor3 = Color3.new(1, 1, 1)
tx.Font = Enum.Font.Gotham
tx.TextSize = 12
tx.TextWrapped = true
tx.Parent = fr

local lb = Instance.new("TextBox")
lb.Size = UDim2.new(0, 300, 0, 22)
lb.Position = UDim2.new(0.5, -150, 0, 52)
lb.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
lb.BackgroundTransparency = 0.3
lb.Text = "https://www.roblox.com/bundles/28334386015043"
lb.TextColor3 = Color3.fromRGB(85, 170, 255)
lb.Font = Enum.Font.Gotham
lb.TextSize = 10
lb.ClearTextOnFocus = false
lb.TextEditable = false
lb.Parent = fr

local lc = Instance.new("UICorner")
lc.CornerRadius = UDim.new(0, 4)
lc.Parent = lb

local bt = Instance.new("TextButton")
bt.Size = UDim2.new(0, 80, 0, 20)
bt.Position = UDim2.new(1, -90, 1, -25)
bt.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
bt.Text = "Copy Link"
bt.TextColor3 = Color3.new(1, 1, 1)
bt.Font = Enum.Font.Gotham
bt.TextSize = 11
bt.Parent = fr

local bc = Instance.new("UICorner")
bc.CornerRadius = UDim.new(0, 4)
bc.Parent = bt

bt.MouseButton1Click:Connect(function()
	setclipboard("https://www.roblox.com/bundles/148351107651039/pro-builder-very-old-and-outdated")
	bt.Text = "Copied!"
	task.wait(1)
	bt.Text = "Copy Link"
end)

local cl = Instance.new("TextButton")
cl.Size = UDim2.new(0, 20, 0, 20)
cl.Position = UDim2.new(1, -25, 0, 5)
cl.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
cl.Text = "X"
cl.TextColor3 = Color3.new(1, 1, 1)
cl.Font = Enum.Font.GothamBold
cl.TextSize = 14
cl.Parent = fr

local cc = Instance.new("UICorner")
cc.CornerRadius = UDim.new(0, 4)
cc.Parent = cl

cl.MouseButton1Click:Connect(function()
	sg:Destroy()
end)

local tl = Instance.new("Tool")
tl.Name = "Sky Master"
tl.RequiresHandle = false
tl.Parent = game:GetService("Players").LocalPlayer.Backpack

tl.Equipped:Connect(function()
	tl:WaitForChild("Humanoid", 0.1)
	task.wait()
	tl.Parent = game:GetService("Players").LocalPlayer.Backpack
	
	if ac then return end
	ac = true
	
	local pl = game:GetService("Players").LocalPlayer
	local ch = pl.Character or pl.CharacterAdded:Wait()
	local hm = ch:WaitForChild("Humanoid")
	local rp = ch:WaitForChild("HumanoidRootPart")
	local cm = game:GetService("Workspace").CurrentCamera

	local a1 = Instance.new("Animation")
	a1.AnimationId = "rbxassetid://674871189"
	local a2 = Instance.new("Animation")
	a2.AnimationId = "rbxassetid://70883871260184"

	local t1 = hm:LoadAnimation(a1)
	local t2 = hm:LoadAnimation(a2)

	local s1 = Instance.new("Sound")
	s1.SoundId = "rbxassetid://125769978282211"
	s1.Parent = rp
	local s2 = Instance.new("Sound")
	s2.SoundId = "rbxassetid://126397142477715"
	s2.Parent = rp

	local hl = Instance.new("Highlight")
	hl.Parent = ch
	hl.FillTransparency = 1
	hl.OutlineTransparency = 1

	local bl = Instance.new("BlurEffect")
	bl.Parent = cm
	bl.Size = 0

	task.wait(0.5)

	t1:Play()
	t1.Looped = true
	s1:Play()

	for i = 0, 1, 0.05 do
		hl.FillTransparency = 1 - i * 0.5
		hl.OutlineTransparency = 1 - i
		bl.Size = i * 15
		task.wait()
	end

	task.wait(3)

	t1.Looped = false
	t1:Stop()

	for i = 1, 0, -0.1 do
		hl.FillTransparency = 1 - i * 0.5
		hl.OutlineTransparency = 1 - i
		bl.Size = i * 15
		task.wait()
	end

	hl:Destroy()
	bl:Destroy()

	for _, tr in pairs(hm:GetPlayingAnimationTracks()) do
		if tr ~= t2 then
			tr:Stop()
		end
	end

	s2:Play()
	t2:Play()
	task.wait(4)

	t2:Stop()
	s2:Stop()
	
	ac = false
end)
