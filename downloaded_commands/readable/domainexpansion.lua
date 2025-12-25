local pl = game.Players.LocalPlayer
local pg = pl:WaitForChild("PlayerGui")
local ch = pl.Character or pl.CharacterAdded:Wait()
local hm = ch:WaitForChild("Humanoid")
local an = hm:WaitForChild("Animator")
local ts = game:GetService("TweenService")
local ui = game:GetService("UserInputService")

local sg = Instance.new("ScreenGui")
sg.Name = "DomainExpansionGUI"
sg.ResetOnSpawn = false
sg.Parent = pg

local mf = Instance.new("Frame")
mf.Name = "MainFrame"
mf.Size = UDim2.new(0, 280, 0, 108)
mf.Position = UDim2.new(0.5, -140, 0.5, -54)
mf.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mf.BackgroundTransparency = 0.7
mf.BorderSizePixel = 0
mf.Active = true
mf.Parent = sg

local c1 = Instance.new("UICorner")
c1.CornerRadius = UDim.new(0, 12)
c1.Parent = mf

local tb = Instance.new("Frame")
tb.Name = "TitleBar"
tb.Size = UDim2.new(1, 0, 0, 28)
tb.BackgroundTransparency = 1
tb.Active = true
tb.Parent = mf

-- GUI DRAGGING (TITLEBAR ONLY - FIXED FOR MOBILE + PC)
local dragging = false
local dragStart = nil
local startPos = nil

tb.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mf.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

tb.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        mf.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

local ak = Instance.new("TextLabel")
ak.Size = UDim2.new(0, 70, 0, 16)
ak.Position = UDim2.new(0, 6, 0, 6)
ak.BackgroundTransparency = 1
ak.Text = "AK ADMIN"
ak.TextColor3 = Color3.fromRGB(255, 255, 255)
ak.TextSize = 10
ak.Font = Enum.Font.Gotham
ak.TextXAlignment = Enum.TextXAlignment.Left
ak.Parent = tb

local tt = Instance.new("TextLabel")
tt.Size = UDim2.new(0, 150, 0, 22)
tt.Position = UDim2.new(0.5, -75, 0, 3)
tt.BackgroundTransparency = 1
tt.Text = "Domain Expansion"
tt.TextColor3 = Color3.fromRGB(255, 255, 255)
tt.TextSize = 15
tt.Font = Enum.Font.GothamBold
tt.Parent = tb

local mb = Instance.new("TextButton")
mb.Size = UDim2.new(0, 22, 0, 22)
mb.Position = UDim2.new(1, -52, 0, 3)
mb.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mb.BackgroundTransparency = 0.5
mb.Text = "-"
mb.TextColor3 = Color3.fromRGB(255, 255, 255)
mb.TextSize = 16
mb.Font = Enum.Font.GothamBold
mb.BorderSizePixel = 0
mb.Parent = tb

local c2 = Instance.new("UICorner")
c2.CornerRadius = UDim.new(0, 6)
c2.Parent = mb

local cb = Instance.new("TextButton")
cb.Size = UDim2.new(0, 22, 0, 22)
cb.Position = UDim2.new(1, -26, 0, 3)
cb.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
cb.BackgroundTransparency = 0.5
cb.Text = "X"
cb.TextColor3 = Color3.fromRGB(255, 255, 255)
cb.TextSize = 14
cb.Font = Enum.Font.GothamBold
cb.BorderSizePixel = 0
cb.Parent = tb

local c3 = Instance.new("UICorner")
c3.CornerRadius = UDim.new(0, 6)
c3.Parent = cb

local cf = Instance.new("Frame")
cf.Name = "ContentFrame"
cf.Size = UDim2.new(1, -16, 1, -36)
cf.Position = UDim2.new(0, 8, 0, 32)
cf.BackgroundTransparency = 1
cf.Parent = mf

local hf = Instance.new("Frame")
hf.Name = "HipHeightFrame"
hf.Size = UDim2.new(1, 0, 0, 28)
hf.Position = UDim2.new(0, 0, 0, 0)
hf.BackgroundTransparency = 1
hf.Parent = cf

local hl = Instance.new("TextLabel")
hl.Size = UDim2.new(0, 70, 0, 20)
hl.Position = UDim2.new(0, 0, 0, 4)
hl.BackgroundTransparency = 1
hl.Text = "Hip Height:"
hl.TextColor3 = Color3.fromRGB(255, 255, 255)
hl.TextSize = 11
hl.Font = Enum.Font.Gotham
hl.TextXAlignment = Enum.TextXAlignment.Left
hl.Parent = hf

local hv = Instance.new("TextLabel")
hv.Size = UDim2.new(0, 30, 0, 20)
hv.Position = UDim2.new(1, -30, 0, 4)
hv.BackgroundTransparency = 1
hv.Text = "0"
hv.TextColor3 = Color3.fromRGB(255, 255, 255)
hv.TextSize = 11
hv.Font = Enum.Font.GothamBold
hv.TextXAlignment = Enum.TextXAlignment.Right
hv.Parent = hf

local sb = Instance.new("Frame")
sb.Size = UDim2.new(1, -110, 0, 6)
sb.Position = UDim2.new(0, 75, 0, 11)
sb.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
sb.BorderSizePixel = 0
sb.Active = true
sb.Parent = hf

local c4 = Instance.new("UICorner")
c4.CornerRadius = UDim.new(0, 3)
c4.Parent = sb

local sf = Instance.new("Frame")
sf.Size = UDim2.new(0, 0, 1, 0)
sf.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
sf.BorderSizePixel = 0
sf.Parent = sb

local c5 = Instance.new("UICorner")
c5.CornerRadius = UDim.new(0, 3)
c5.Parent = sf

local sk = Instance.new("TextButton")
sk.Size = UDim2.new(0, 14, 0, 14)
sk.Position = UDim2.new(0, -7, 0.5, -7)
sk.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
sk.Text = ""
sk.BorderSizePixel = 0
sk.Active = true
sk.Parent = sb

local c6 = Instance.new("UICorner")
c6.CornerRadius = UDim.new(1, 0)
c6.Parent = sk

local bf = Instance.new("Frame")
bf.Name = "ButtonFrame"
bf.Size = UDim2.new(1, 0, 0, 32)
bf.Position = UDim2.new(0, 0, 1, -32)
bf.BackgroundTransparency = 1
bf.Parent = cf

local t1 = Instance.new("TextButton")
t1.Size = UDim2.new(0.32, -4, 1, 0)
t1.Position = UDim2.new(0, 0, 0, 0)
t1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
t1.BackgroundTransparency = 0.5
t1.Text = "Start"
t1.TextColor3 = Color3.fromRGB(255, 255, 255)
t1.TextSize = 11
t1.Font = Enum.Font.Gotham
t1.BorderSizePixel = 0
t1.Parent = bf

local c7 = Instance.new("UICorner")
c7.CornerRadius = UDim.new(0, 8)
c7.Parent = t1

local t2 = Instance.new("TextButton")
t2.Size = UDim2.new(0.32, -4, 1, 0)
t2.Position = UDim2.new(0.34, 0, 0, 0)
t2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
t2.BackgroundTransparency = 0.5
t2.Text = "Reverse"
t2.TextColor3 = Color3.fromRGB(255, 255, 255)
t2.TextSize = 11
t2.Font = Enum.Font.Gotham
t2.BorderSizePixel = 0
t2.Parent = bf

local c8 = Instance.new("UICorner")
c8.CornerRadius = UDim.new(0, 8)
c8.Parent = t2

local t3 = Instance.new("TextButton")
t3.Size = UDim2.new(0.32, -4, 1, 0)
t3.Position = UDim2.new(0.68, 0, 0, 0)
t3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
t3.BackgroundTransparency = 0.5
t3.Text = "Pause"
t3.TextColor3 = Color3.fromRGB(255, 255, 255)
t3.TextSize = 11
t3.Font = Enum.Font.Gotham
t3.BorderSizePixel = 0
t3.Parent = bf

local c9 = Instance.new("UICorner")
c9.CornerRadius = UDim.new(0, 8)
c9.Parent = t3

-- NOTIFICATION GUI (TOP CENTER)
local notifFrame = Instance.new("Frame")
notifFrame.Name = "NotificationFrame"
notifFrame.Size = UDim2.new(0, 600, 0, 70)
notifFrame.Position = UDim2.new(0.5, -300, 0, 10)
notifFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
notifFrame.BackgroundTransparency = 0.7
notifFrame.BorderSizePixel = 0
notifFrame.Parent = sg

local notifCorner = Instance.new("UICorner")
notifCorner.CornerRadius = UDim.new(0, 10)
notifCorner.Parent = notifFrame

local notifAK = Instance.new("TextLabel")
notifAK.Size = UDim2.new(0, 70, 0, 16)
notifAK.Position = UDim2.new(0, 8, 0, 6)
notifAK.BackgroundTransparency = 1
notifAK.Text = "AK ADMIN"
notifAK.TextColor3 = Color3.fromRGB(255, 255, 255)
notifAK.TextSize = 10
notifAK.Font = Enum.Font.Gotham
notifAK.TextXAlignment = Enum.TextXAlignment.Left
notifAK.Parent = notifFrame

local notifClose = Instance.new("TextButton")
notifClose.Size = UDim2.new(0, 20, 0, 20)
notifClose.Position = UDim2.new(1, -26, 0, 6)
notifClose.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
notifClose.BackgroundTransparency = 0.5
notifClose.Text = "X"
notifClose.TextColor3 = Color3.fromRGB(255, 255, 255)
notifClose.TextSize = 12
notifClose.Font = Enum.Font.GothamBold
notifClose.BorderSizePixel = 0
notifClose.Parent = notifFrame

local notifCloseCorner = Instance.new("UICorner")
notifCloseCorner.CornerRadius = UDim.new(0, 6)
notifCloseCorner.Parent = notifClose

local notifText = Instance.new("TextLabel")
notifText.Size = UDim2.new(1, -20, 0, 16)
notifText.Position = UDim2.new(0, 10, 0, 26)
notifText.BackgroundTransparency = 1
notifText.Text = "You must equip the torso from the bundle below or it won't work!"
notifText.TextColor3 = Color3.fromRGB(255, 255, 255)
notifText.TextSize = 11
notifText.Font = Enum.Font.Gotham
notifText.TextWrapped = true
notifText.TextXAlignment = Enum.TextXAlignment.Left
notifText.Parent = notifFrame

local bundleLink = "https://www.roblox.com/bundles/148351107651039/pro-builder-very-old-and-outdated"

local linkText = Instance.new("TextLabel")
linkText.Size = UDim2.new(1, -90, 0, 16)
linkText.Position = UDim2.new(0, 10, 0, 46)
linkText.BackgroundTransparency = 1
linkText.Text = bundleLink
linkText.TextColor3 = Color3.fromRGB(255, 255, 255)
linkText.TextSize = 10
linkText.Font = Enum.Font.Gotham
linkText.TextXAlignment = Enum.TextXAlignment.Left
linkText.Parent = notifFrame

local copyBtn = Instance.new("TextButton")
copyBtn.Size = UDim2.new(0, 60, 0, 20)
copyBtn.Position = UDim2.new(1, -70, 0, 44)
copyBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
copyBtn.BackgroundTransparency = 0.5
copyBtn.Text = "Copy"
copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
copyBtn.TextSize = 10
copyBtn.Font = Enum.Font.Gotham
copyBtn.BorderSizePixel = 0
copyBtn.Parent = notifFrame

local copyCorner = Instance.new("UICorner")
copyCorner.CornerRadius = UDim.new(0, 6)
copyCorner.Parent = copyBtn

copyBtn.MouseButton1Click:Connect(function()
    setclipboard(bundleLink)
    copyBtn.Text = "Copied!"
    task.wait(2)
    copyBtn.Text = "Copy"
end)

notifClose.MouseButton1Click:Connect(function()
    notifFrame:Destroy()
end)

local ao = Instance.new("Animation")
ao.AnimationId = "rbxassetid://70883871260184"

local tr = nil
local py = false
local rv = false
local ps = false
local mn = false

-- SLIDER DRAGGING (FIXED FOR MOBILE + PC)
local sliderDragging = false

local originalHipHeight = hm.HipHeight

local function updateHipHeight(value)
    local pc = math.clamp(value, 0, 1)
    local ht = math.floor(originalHipHeight + (pc * 80))
    hm.HipHeight = ht
    hv.Text = tostring(ht)
    sf.Size = UDim2.new(pc, 0, 1, 0)
    sk.Position = UDim2.new(pc, -7, 0.5, -7)
end

-- Knob dragging
sk.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        sliderDragging = true
    end
end)

-- Track InputChanged for continuous dragging
sk.InputChanged:Connect(function(input)
    if sliderDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local mx = input.Position.X
        local bx = sb.AbsolutePosition.X
        local bw = sb.AbsoluteSize.X
        local rp = (mx - bx) / bw
        updateHipHeight(rp)
    end
end)

-- Global input end to stop dragging
ui.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        sliderDragging = false
    end
end)

-- Global input changed for when dragging outside the knob
ui.InputChanged:Connect(function(input)
    if sliderDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local mx = input.Position.X
        local bx = sb.AbsolutePosition.X
        local bw = sb.AbsoluteSize.X
        local rp = (mx - bx) / bw
        updateHipHeight(rp)
    end
end)

-- Click on slider bar to jump
sb.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        local mx = input.Position.X
        local bx = sb.AbsolutePosition.X
        local bw = sb.AbsoluteSize.X
        local rp = (mx - bx) / bw
        updateHipHeight(rp)
        sliderDragging = true
    end
end)

updateHipHeight((hm.HipHeight - originalHipHeight) / 80)

local function ld()
    if tr then
        tr:Stop()
    end
    tr = an:LoadAnimation(ao)
    tr.Looped = true
    tr.Priority = Enum.AnimationPriority.Action
    tr:Play(0.05)
    tr:AdjustSpeed(rv and -0.0001 or 0.0001)
end

local function up()
    if not tr then return end
    local sp = 0.0001
    if rv then sp = -sp end
    if ps then sp = 0 end
    tr:AdjustSpeed(sp)
end

t1.MouseButton1Click:Connect(function()
    py = not py
    if py then
        t1.Text = "Stop"
        ld()
    else
        t1.Text = "Start"
        if tr then
            tr:Stop()
            tr = nil
        end
        rv = false
        ps = false
        t2.Text = "Reverse"
        t3.Text = "Pause"
    end
end)

t2.MouseButton1Click:Connect(function()
    if not py then return end
    rv = not rv
    if rv then
        t2.Text = "Forward"
    else
        t2.Text = "Reverse"
    end
    up()
end)

t3.MouseButton1Click:Connect(function()
    if not py then return end
    ps = not ps
    if ps then
        t3.Text = "Unpause"
    else
        t3.Text = "Pause"
    end
    up()
end)

mb.MouseButton1Click:Connect(function()
    mn = not mn
    local tw = ts:Create(mf, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = mn and UDim2.new(0, 280, 0, 28) or UDim2.new(0, 280, 0, 108)
    })
    tw:Play()
    cf.Visible = not mn
    mb.Text = mn and "+" or "-"
end)

cb.MouseButton1Click:Connect(function()
    sg:Destroy()
end)

an.AnimationPlayed:Connect(function(tk)
    task.defer(function()
        if py and tk == tr then
            pcall(function() up() end)
        end
    end)
end)
