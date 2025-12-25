-- Anti Kidnap Script with Clean GUI
-- Place this in StarterPlayerScripts

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Variables
local antiKidnapEnabled = false
local heartbeatConnection = nil
local isMinimized = false

-- Create GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AntiKidnapGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 180, 0, 80)
mainFrame.Position = UDim2.new(0, 20, 0, 20)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BackgroundTransparency = 0.3
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Rounded corners for main frame
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- Taskbar
local taskbar = Instance.new("Frame")
taskbar.Name = "Taskbar"
taskbar.Size = UDim2.new(1, 0, 0, 30)
taskbar.Position = UDim2.new(0, 0, 0, 0)
taskbar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
taskbar.BackgroundTransparency = 0.2
taskbar.BorderSizePixel = 0
taskbar.Parent = mainFrame

-- Taskbar rounded corners
local taskbarCorner = Instance.new("UICorner")
taskbarCorner.CornerRadius = UDim.new(0, 12)
taskbarCorner.Parent = taskbar

-- Fix taskbar bottom corners
local taskbarFix = Instance.new("Frame")
taskbarFix.Size = UDim2.new(1, 0, 0, 12)
taskbarFix.Position = UDim2.new(0, 0, 1, -12)
taskbarFix.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
taskbarFix.BackgroundTransparency = 0.2
taskbarFix.BorderSizePixel = 0
taskbarFix.Parent = taskbar

-- Taskbar Title
local taskbarTitle = Instance.new("TextLabel")
taskbarTitle.Name = "TaskbarTitle"
taskbarTitle.Size = UDim2.new(1, -80, 1, 0)
taskbarTitle.Position = UDim2.new(0, 12, 0, 0)
taskbarTitle.BackgroundTransparency = 1
taskbarTitle.Text = "Anti Kidnap"
taskbarTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
taskbarTitle.TextSize = 14
taskbarTitle.TextXAlignment = Enum.TextXAlignment.Left
taskbarTitle.Font = Enum.Font.GothamSemibold
taskbarTitle.Parent = taskbar

-- Minimize Button
local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 25, 0, 20)
minimizeButton.Position = UDim2.new(1, -55, 0.5, -10)
minimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
minimizeButton.BackgroundTransparency = 0.3
minimizeButton.BorderSizePixel = 0
minimizeButton.Text = "−"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.TextSize = 16
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.Parent = taskbar

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 4)
minimizeCorner.Parent = minimizeButton

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 25, 0, 20)
closeButton.Position = UDim2.new(1, -25, 0.5, -10)
closeButton.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeButton.BackgroundTransparency = 0.2
closeButton.BorderSizePixel = 0
closeButton.Text = "×"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 16
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = taskbar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 4)
closeCorner.Parent = closeButton

-- Content Frame
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -10, 1, -35)
contentFrame.Position = UDim2.new(0, 5, 0, 30)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Toggle Button (small)
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 80, 0, 25)
toggleButton.Position = UDim2.new(0.5, -40, 0.5, -12.5)
toggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
toggleButton.BorderSizePixel = 0
toggleButton.Text = "Enable"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 11
toggleButton.Font = Enum.Font.GothamMedium
toggleButton.Parent = contentFrame

-- Rounded corners for toggle button
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 8)
buttonCorner.Parent = toggleButton

-- Smooth dragging functionality
local dragging = false
local dragStart = nil
local startPos = nil
local dragConnection = nil

local function updateInput(input)
    if dragging and dragStart and startPos then
        local delta = input.Position - dragStart
        local newPos = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
        
        -- Smooth position update
        local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        local tween = TweenService:Create(mainFrame, tweenInfo, {Position = newPos})
        tween:Play()
    end
end

taskbar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        if dragConnection then
            dragConnection:Disconnect()
        end
        
        dragConnection = UserInputService.InputChanged:Connect(function(input2)
            if input2.UserInputType == Enum.UserInputType.MouseMovement or input2.UserInputType == Enum.UserInputType.Touch then
                if dragging then
                    updateInput(input2)
                end
            end
        end)
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                if dragConnection then
                    dragConnection:Disconnect()
                    dragConnection = nil
                end
            end
        end)
    end
end)

-- Button hover effects
local function addHoverEffect(button, hoverColor, normalColor)
    button.MouseEnter:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundColor3 = hoverColor})
        tween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundColor3 = normalColor})
        tween:Play()
    end)
end

addHoverEffect(minimizeButton, Color3.fromRGB(80, 80, 80), Color3.fromRGB(60, 60, 60))
addHoverEffect(closeButton, Color3.fromRGB(220, 70, 70), Color3.fromRGB(180, 50, 50))

-- Toggle button hover effect
toggleButton.MouseEnter:Connect(function()
    if not antiKidnapEnabled then
        local tween = TweenService:Create(toggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(90, 90, 90)})
        tween:Play()
    else
        local tween = TweenService:Create(toggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(120, 220, 120)})
        tween:Play()
    end
end)

toggleButton.MouseLeave:Connect(function()
    if not antiKidnapEnabled then
        local tween = TweenService:Create(toggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(70, 70, 70)})
        tween:Play()
    else
        local tween = TweenService:Create(toggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(100, 200, 100)})
        tween:Play()
    end
end)

-- Minimize functionality
local function toggleMinimize()
    isMinimized = not isMinimized
    local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    
    if isMinimized then
        local tween = TweenService:Create(mainFrame, tweenInfo, {Size = UDim2.new(0, 180, 0, 30)})
        tween:Play()
        contentFrame.Visible = false
    else
        local tween = TweenService:Create(mainFrame, tweenInfo, {Size = UDim2.new(0, 180, 0, 80)})
        tween:Play()
        contentFrame.Visible = true
    end
end

minimizeButton.MouseButton1Click:Connect(toggleMinimize)

-- Close functionality
closeButton.MouseButton1Click:Connect(function()
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
    local tween = TweenService:Create(mainFrame, tweenInfo, {
        Size = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1
    })
    tween:Play()
    
    tween.Completed:Connect(function()
        screenGui:Destroy()
        if heartbeatConnection then
            heartbeatConnection:Disconnect()
        end
    end)
end)

-- Anti-kidnap functionality
local function disableSitting()
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            -- Disable seated state
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
            
            -- Monitor and force unseat if somehow seated
            if heartbeatConnection then
                heartbeatConnection:Disconnect()
            end
            
            heartbeatConnection = RunService.Heartbeat:Connect(function()
                if humanoid.Sit then
                    humanoid.Sit = false
                end
                
                -- Check if somehow still in seated state
                if humanoid:GetState() == Enum.HumanoidStateType.Seated then
                    humanoid:ChangeState(Enum.HumanoidStateType.Running)
                end
                
                -- Destroy any seat welds
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    local seatWeld = rootPart:FindFirstChild("SeatWeld")
                    if seatWeld then
                        seatWeld:Destroy()
                    end
                end
            end)
        end
    end
end

local function enableSitting()
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            -- Re-enable seated state
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        end
    end
    
    -- Disconnect monitoring
    if heartbeatConnection then
        heartbeatConnection:Disconnect()
        heartbeatConnection = nil
    end
end

local function updateToggleVisuals()
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    
    if antiKidnapEnabled then
        -- Change to enabled state
        local buttonTween = TweenService:Create(toggleButton, tweenInfo, {
            BackgroundColor3 = Color3.fromRGB(100, 200, 100),
            TextColor3 = Color3.fromRGB(255, 255, 255)
        })
        
        buttonTween:Play()
        
        toggleButton.Text = "Disable"
    else
        -- Change to disabled state
        local buttonTween = TweenService:Create(toggleButton, tweenInfo, {
            BackgroundColor3 = Color3.fromRGB(70, 70, 70),
            TextColor3 = Color3.fromRGB(255, 255, 255)
        })
        
        buttonTween:Play()
        
        toggleButton.Text = "Enable"
    end
end

-- Toggle button functionality
toggleButton.MouseButton1Click:Connect(function()
    antiKidnapEnabled = not antiKidnapEnabled
    
    if antiKidnapEnabled then
        disableSitting()
    else
        enableSitting()
    end
    
    updateToggleVisuals()
end)

-- Handle character respawning
player.CharacterAdded:Connect(function()
    wait(1) -- Wait for character to fully load
    if antiKidnapEnabled then
        disableSitting()
    end
end)

-- Initial setup
if player.Character then
    if antiKidnapEnabled then
        disableSitting()
    end
end
