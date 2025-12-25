local players = game.Players.LocalPlayer
local playerGui = players:WaitForChild("PlayerGui")
local character = players.Character or players.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local animator = humanoid:WaitForChild("Animator")
local tweenService = game:GetService("TweenService")
local userInputService = game:GetService("UserInputService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DomainExpansionGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 280, 0, 108)
frame.Position = UDim2.new(0.5, -140, 0.5, -54)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.7
frame.BorderSizePixel = 0
frame.Active = true
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local mainFrame = Instance.new("Frame")
mainFrame.Name = "TitleBar"
mainFrame.Size = UDim2.new(1, 0, 0, 28)
mainFrame.BackgroundTransparency = 1
mainFrame.Active = true
mainFrame.Parent = frame

-- GUI DRAGGING (TITLEBAR ONLY - FIXED FOR MOBILE + PC)
local dragging = false
local dragStart = nil
local startPos = nil

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(0, 70, 0, 16)
textLabel.Position = UDim2.new(0, 6, 0, 6)
textLabel.BackgroundTransparency = 1
textLabel.Text = "AK ADMIN"
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.TextSize = 10
textLabel.Font = Enum.Font.Gotham
textLabel.TextXAlignment = Enum.TextXAlignment.Left
textLabel.Parent = mainFrame

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(0, 150, 0, 22)
textLabel.Position = UDim2.new(0.5, -75, 0, 3)
textLabel.BackgroundTransparency = 1
textLabel.Text = "Domain Expansion"
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.TextSize = 15
textLabel.Font = Enum.Font.GothamBold
textLabel.Parent = mainFrame

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 22, 0, 22)
button.Position = UDim2.new(1, -52, 0, 3)
button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
button.BackgroundTransparency = 0.5
button.Text = "-"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextSize = 16
button.Font = Enum.Font.GothamBold
button.BorderSizePixel = 0
button.Parent = mainFrame

local corner2 = Instance.new("UICorner")
corner2.CornerRadius = UDim.new(0, 6)
corner2.Parent = button

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 22, 0, 22)
button.Position = UDim2.new(1, -26, 0, 3)
button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
button.BackgroundTransparency = 0.5
button.Text = "X"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextSize = 14
button.Font = Enum.Font.GothamBold
button.BorderSizePixel = 0
button.Parent = mainFrame

local corner3 = Instance.new("UICorner")
corner3.CornerRadius = UDim.new(0, 6)
corner3.Parent = button

local mainFrame = Instance.new("Frame")
mainFrame.Name = "ContentFrame"
mainFrame.Size = UDim2.new(1, -16, 1, -36)
mainFrame.Position = UDim2.new(0, 8, 0, 32)
mainFrame.BackgroundTransparency = 1
mainFrame.Parent = frame

local mainFrame = Instance.new("Frame")
mainFrame.Name = "HipHeightFrame"
mainFrame.Size = UDim2.new(1, 0, 0, 28)
mainFrame.Position = UDim2.new(0, 0, 0, 0)
mainFrame.BackgroundTransparency = 1
mainFrame.Parent = mainFrame

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(0, 70, 0, 20)
textLabel.Position = UDim2.new(0, 0, 0, 4)
textLabel.BackgroundTransparency = 1
textLabel.Text = "Hip Height:"
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.TextSize = 11
textLabel.Font = Enum.Font.Gotham
textLabel.TextXAlignment = Enum.TextXAlignment.Left
textLabel.Parent = mainFrame

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(0, 30, 0, 20)
textLabel.Position = UDim2.new(1, -30, 0, 4)
textLabel.BackgroundTransparency = 1
textLabel.Text = "0"
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.TextSize = 11
textLabel.Font = Enum.Font.GothamBold
textLabel.TextXAlignment = Enum.TextXAlignment.Right
textLabel.Parent = mainFrame

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(1, -110, 0, 6)
mainFrame.Position = UDim2.new(0, 75, 0, 11)
mainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Parent = mainFrame

local corner4 = Instance.new("UICorner")
corner4.CornerRadius = UDim.new(0, 3)
corner4.Parent = mainFrame

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 0, 1, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = mainFrame

local corner5 = Instance.new("UICorner")
corner5.CornerRadius = UDim.new(0, 3)
corner5.Parent = mainFrame

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 14, 0, 14)
button.Position = UDim2.new(0, -7, 0.5, -7)
button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
button.Text = ""
button.BorderSizePixel = 0
button.Active = true
button.Parent = mainFrame

local corner6 = Instance.new("UICorner")
corner6.CornerRadius = UDim.new(1, 0)
corner6.Parent = button

local mainFrame = Instance.new("Frame")
mainFrame.Name = "ButtonFrame"
mainFrame.Size = UDim2.new(1, 0, 0, 32)
mainFrame.Position = UDim2.new(0, 0, 1, -32)
mainFrame.BackgroundTransparency = 1
mainFrame.Parent = mainFrame

local button = Instance.new("TextButton")
button.Size = UDim2.new(0.32, -4, 1, 0)
button.Position = UDim2.new(0, 0, 0, 0)
button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
button.BackgroundTransparency = 0.5
button.Text = "Start"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextSize = 11
button.Font = Enum.Font.Gotham
button.BorderSizePixel = 0
button.Parent = mainFrame

local corner7 = Instance.new("UICorner")
corner7.CornerRadius = UDim.new(0, 8)
corner7.Parent = button

local button2 = Instance.new("TextButton")
button2.Size = UDim2.new(0.32, -4, 1, 0)
button2.Position = UDim2.new(0.34, 0, 0, 0)
button2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
button2.BackgroundTransparency = 0.5
button2.Text = "Reverse"
button2.TextColor3 = Color3.fromRGB(255, 255, 255)
button2.TextSize = 11
button2.Font = Enum.Font.Gotham
button2.BorderSizePixel = 0
button2.Parent = mainFrame

local corner8 = Instance.new("UICorner")
corner8.CornerRadius = UDim.new(0, 8)
corner8.Parent = button2

local button3 = Instance.new("TextButton")
button3.Size = UDim2.new(0.32, -4, 1, 0)
button3.Position = UDim2.new(0.68, 0, 0, 0)
button3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
button3.BackgroundTransparency = 0.5
button3.Text = "Pause"
button3.TextColor3 = Color3.fromRGB(255, 255, 255)
button3.TextSize = 11
button3.Font = Enum.Font.Gotham
button3.BorderSizePixel = 0
button3.Parent = mainFrame

local corner9 = Instance.new("UICorner")
corner9.CornerRadius = UDim.new(0, 8)
corner9.Parent = button3

-- NOTIFICATION GUI (TOP CENTER)
local notifFrame = Instance.new("Frame")
notifFrame.Name = "NotificationFrame"
notifFrame.Size = UDim2.new(0, 600, 0, 70)
notifFrame.Position = UDim2.new(0.5, -300, 0, 10)
notifFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
notifFrame.BackgroundTransparency = 0.7
notifFrame.BorderSizePixel = 0
notifFrame.Parent = screenGui

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

local bundleLink = "https://www.roblox.com/bundles/148351107651039/pro - builder - very - old - and - outdated"

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

local animation = Instance.new("Animation")
animation.AnimationId = "rbxassetid://70883871260184"

local tr = nil
local flag = false
local flag = false
local flag = false
local flag = false

-- SLIDER DRAGGING (FIXED FOR MOBILE + PC)
local sliderDragging = false

local originalHipHeight = humanoid.HipHeight

local function updateHipHeight(value)
    local pc = math.clamp(value, 0, 1)
    local ht = math.floor(originalHipHeight + (pc * 80))
    humanoid.HipHeight = ht
    textLabel.Text = tostring(ht)
    mainFrame.Size = UDim2.new(pc, 0, 1, 0)
    button.Position = UDim2.new(pc, -7, 0.5, -7)
end

-- Knob dragging
button.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        sliderDragging = true
    end
end)

-- Track InputChanged for continuous dragging
button.InputChanged:Connect(function(input)
    if sliderDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local mx = input.Position.X
        local frame5 = mainFrame.AbsolutePosition.X
        local frame6 = mainFrame.AbsoluteSize.X
        local rp = (mx - frame5) / frame6
        updateHipHeight(rp)
    end
end)

-- Global input end to stop dragging
userInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        sliderDragging = false
    end
end)

-- Global input changed for when dragging outside the knob
userInputService.InputChanged:Connect(function(input)
    if sliderDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local mx = input.Position.X
        local frame5 = mainFrame.AbsolutePosition.X
        local frame6 = mainFrame.AbsoluteSize.X
        local rp = (mx - frame5) / frame6
        updateHipHeight(rp)
    end
end)

-- Click on slider bar to jump
mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        local mx = input.Position.X
        local frame5 = mainFrame.AbsolutePosition.X
        local frame6 = mainFrame.AbsoluteSize.X
        local rp = (mx - frame5) / frame6
        updateHipHeight(rp)
        sliderDragging = true
    end
end)

updateHipHeight((humanoid.HipHeight - originalHipHeight) / 80)

local function ld()
    if tr then
        tr:Stop()
    end
    tr = animator:LoadAnimation(animation)
    tr.Looped = true
    tr.Priority = Enum.AnimationPriority.Action
    tr:Play(0.05)
    tr:AdjustSpeed(flag and -0.0001 or 0.0001)
end

local function updateDisplay()
    if not tr then return end
    local value = 0.0001
    if flag then value = -value end
    if flag then value = 0 end
    tr:AdjustSpeed(value)
end

button.MouseButton1Click:Connect(function()
    flag = not flag
    if flag then
        button.Text = "Stop"
        ld()
    else
        button.Text = "Start"
        if tr then
            tr:Stop()
            tr = nil
        end
        flag = false
        flag = false
        button2.Text = "Reverse"
        button3.Text = "Pause"
    end
end)

button2.MouseButton1Click:Connect(function()
    if not flag then return end
    flag = not flag
    if flag then
        button2.Text = "Forward"
    else
        button2.Text = "Reverse"
    end
    updateDisplay()
end)

button3.MouseButton1Click:Connect(function()
    if not flag then return end
    flag = not flag
    if flag then
        button3.Text = "Unpause"
    else
        button3.Text = "Pause"
    end
    updateDisplay()
end)

button.MouseButton1Click:Connect(function()
    flag = not flag
    local tweenInfo = tweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = flag and UDim2.new(0, 280, 0, 28) or UDim2.new(0, 280, 0, 108)
    })
    tweenInfo:Play()
    mainFrame.Visible = not flag
    button.Text = flag and "+" or "-"
end)

button.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

animator.AnimationPlayed:Connect(function(tk)
    task.defer(function()
        if flag and tk == tr then
            pcall(function() updateDisplay() end)
        end
    end)
end)
