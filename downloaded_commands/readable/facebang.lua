local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local targetHead = nil
local targetPlayer = nil

local FOLLOW_DISTANCE = -0.7
local HEIGHT_OFFSET = 0.8
local MOVEMENT_SPEED = 0.8
local THRUST_SPEED = 0.8
local THRUST_DISTANCE = 1.9

local THRUST_FORWARD_TIME = 0.1
local THRUST_BACKWARD_TIME = 0.1

getgenv().facefuckactive = false
getgenv().currentKeybind = Enum.KeyCode.Z

local function disableAllAnimations(character)
    if not character then return end
    
    local animate = character:FindFirstChild("Animate")
    if animate then
        animate.Disabled = true
    end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid then
        for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
            track:Stop()
            track:Destroy()
        end
        humanoid.PlatformStand = true
        humanoid.AutoRotate = false
        humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    end
    
    workspace.Gravity = 0
end

local function enableAllAnimations(character)
    if not character then return end
    
    local animate = character:FindFirstChild("Animate")
    if animate then
        animate.Disabled = false
    end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.PlatformStand = false
        humanoid.AutoRotate = true
        humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
    end
    
    workspace.Gravity = 192.2
end

local function setupCharacterTracking()
    LocalPlayer.CharacterAdded:Connect(function(newCharacter)
        Character = newCharacter
        HumanoidRootPart = newCharacter:WaitForChild("HumanoidRootPart")
        
        if getgenv().facefuckactive then
            disableAllAnimations(newCharacter)
            targetHead = findNearestPlayer()
            if targetHead then
                task.spawn(function()
                    faceBang(targetHead)
                end)
            end
        end
    end)
end

local function findNearestPlayer()
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Head") then
        return targetPlayer.Character.Head
    end

    local nearestPlayer = nil
    local shortestDistance = math.huge

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local head = player.Character:FindFirstChild("Head")
            if head then
                local distance = (HumanoidRootPart.Position - head.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    nearestPlayer = head
                    targetPlayer = player
                end
            end
        end
    end

    if targetPlayer then
        targetPlayer.CharacterAdded:Connect(function(newCharacter)
            if getgenv().facefuckactive then
                local head = newCharacter:WaitForChild("Head")
                targetHead = head
                faceBang(head)
            end
        end)
    end

    return nearestPlayer
end

local function setupAnimationPrevention()
    RunService.Heartbeat:Connect(function()
        if getgenv().facefuckactive and LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid then
                for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                    track:Stop()
                end
                humanoid.PlatformStand = true
                humanoid:ChangeState(Enum.HumanoidStateType.Physics)
            end
        end
    end)
end

local function easeInOutSine(t)
    return -(math.cos(math.pi * t) - 1) / 2
end

local function smoothLerp(start, target, alpha, easingFunc)
    local easedAlpha = easingFunc(alpha)
    return start:Lerp(target, easedAlpha)
end

local function faceBang(head)
    while getgenv().facefuckactive do
        if not head or not head:IsDescendantOf(workspace) then
            if targetPlayer and targetPlayer.Character then
                head = targetPlayer.Character:WaitForChild("Head")
                targetHead = head
            else
                head = findNearestPlayer()
                if not head then
                    task.wait(1)
                    continue
                end
            end
        end

        disableAllAnimations(LocalPlayer.Character)

        local distanceToTarget = (head.Position - HumanoidRootPart.Position).Magnitude
        local isTooFar = distanceToTarget > 10
        
        if isTooFar then
            local approachCFrame = head.CFrame * CFrame.new(0, HEIGHT_OFFSET, FOLLOW_DISTANCE + 1) * CFrame.Angles(0, math.rad(180), 0)
            HumanoidRootPart.CFrame = approachCFrame
            RunService.RenderStepped:Wait()
            continue
        end
        
        local basePosition = head.CFrame * CFrame.new(0, HEIGHT_OFFSET, FOLLOW_DISTANCE) * CFrame.Angles(0, math.rad(180), 0)
        local thrustPosition = head.CFrame * CFrame.new(0, HEIGHT_OFFSET, FOLLOW_DISTANCE - THRUST_DISTANCE) * CFrame.Angles(0, math.rad(180), 0)
        
        local thrustStartTime = tick()
        local thrustDuration = THRUST_FORWARD_TIME
        while (tick() - thrustStartTime) < thrustDuration and getgenv().facefuckactive do
            basePosition = head.CFrame * CFrame.new(0, HEIGHT_OFFSET, FOLLOW_DISTANCE) * CFrame.Angles(0, math.rad(180), 0)
            thrustPosition = head.CFrame * CFrame.new(0, HEIGHT_OFFSET, FOLLOW_DISTANCE - THRUST_DISTANCE) * CFrame.Angles(0, math.rad(180), 0)
            
            local progress = math.min((tick() - thrustStartTime) / thrustDuration, 1)
            local currentThrust = smoothLerp(basePosition, thrustPosition, progress, easeInOutSine)
            HumanoidRootPart.CFrame = currentThrust
            
            RunService.RenderStepped:Wait()
        end
        
        local returnStartTime = tick()
        local returnDuration = THRUST_BACKWARD_TIME
        while (tick() - returnStartTime) < returnDuration and getgenv().facefuckactive do
            basePosition = head.CFrame * CFrame.new(0, HEIGHT_OFFSET, FOLLOW_DISTANCE) * CFrame.Angles(0, math.rad(180), 0)
            thrustPosition = head.CFrame * CFrame.new(0, HEIGHT_OFFSET, FOLLOW_DISTANCE - THRUST_DISTANCE) * CFrame.Angles(0, math.rad(180), 0)
            
            local progress = math.min((tick() - returnStartTime) / returnDuration, 1)
            local currentReturn = smoothLerp(thrustPosition, basePosition, progress, easeInOutSine)
            HumanoidRootPart.CFrame = currentReturn
            
            RunService.RenderStepped:Wait()
        end
    end

    enableAllAnimations(LocalPlayer.Character)
end

local function toggleMovement()
    if not getgenv().facefuckactive then
        targetPlayer = nil
        targetHead = findNearestPlayer()
        
        if targetHead then
            getgenv().facefuckactive = true
            disableAllAnimations(LocalPlayer.Character)
            task.spawn(function()
                faceBang(targetHead)
            end)
        end
    else
        getgenv().facefuckactive = false
        targetPlayer = nil
        targetHead = nil
        enableAllAnimations(LocalPlayer.Character)
    end
end

local function createGUI()
    if PlayerGui:FindFirstChild("FaceBangGui") then
        PlayerGui.FaceBangGui:Destroy()
    end

    local screengui = Instance.new("ScreenGui")
    screengui.Name = "FaceBangGui"
    screengui.ResetOnSpawn = false
    screengui.Parent = PlayerGui

    -- Main Frame (Compact size)
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 200, 0, 180)
    mainFrame.Position = UDim2.new(0.5, -100, 0.5, -90)
    mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    mainFrame.BackgroundTransparency = 0.6
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screengui

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 8)
    mainCorner.Parent = mainFrame

    -- Invisible Title Bar for dragging
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 25)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundTransparency = 1
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame

    -- AK ADMIN Label (Top Left)
    local akAdminLabel = Instance.new("TextLabel")
    akAdminLabel.Name = "AKAdminLabel"
    akAdminLabel.Size = UDim2.new(0, 80, 0, 15)
    akAdminLabel.Position = UDim2.new(0, 8, 0, 5)
    akAdminLabel.BackgroundTransparency = 1
    akAdminLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    akAdminLabel.Text = "AK ADMIN"
    akAdminLabel.TextSize = 9
    akAdminLabel.Font = Enum.Font.GothamBold
    akAdminLabel.TextXAlignment = Enum.TextXAlignment.Left
    akAdminLabel.Parent = mainFrame

    -- Minimize Button
    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Name = "MinimizeButton"
    minimizeButton.Size = UDim2.new(0, 18, 0, 18)
    minimizeButton.Position = UDim2.new(1, -42, 0, 5)
    minimizeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    minimizeButton.BackgroundTransparency = 0.6
    minimizeButton.BorderSizePixel = 0
    minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeButton.Text = "-"
    minimizeButton.TextSize = 14
    minimizeButton.Font = Enum.Font.GothamBold
    minimizeButton.Parent = mainFrame

    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 4)
    minimizeCorner.Parent = minimizeButton

    -- Close Button
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 18, 0, 18)
    closeButton.Position = UDim2.new(1, -20, 0, 5)
    closeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    closeButton.BackgroundTransparency = 0.6
    closeButton.BorderSizePixel = 0
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.Text = "X"
    closeButton.TextSize = 12
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = mainFrame

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 4)
    closeCorner.Parent = closeButton

    -- Face Bang Title (Center)
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(0, 150, 0, 20)
    titleLabel.Position = UDim2.new(0.5, -75, 0, 25)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Text = "Face Bang"
    titleLabel.TextSize = 16
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.Parent = mainFrame

    -- Speed Slider Section
    local speedLabel = Instance.new("TextLabel")
    speedLabel.Name = "SpeedLabel"
    speedLabel.Size = UDim2.new(0, 100, 0, 15)
    speedLabel.Position = UDim2.new(0, 10, 0, 50)
    speedLabel.BackgroundTransparency = 1
    speedLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    speedLabel.Text = "Speed: 0.10"
    speedLabel.TextSize = 10
    speedLabel.Font = Enum.Font.GothamBold
    speedLabel.TextXAlignment = Enum.TextXAlignment.Left
    speedLabel.Parent = mainFrame

    local speedSlider = Instance.new("Frame")
    speedSlider.Name = "SpeedSlider"
    speedSlider.Size = UDim2.new(0, 180, 0, 6)
    speedSlider.Position = UDim2.new(0, 10, 0, 70)
    speedSlider.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    speedSlider.BackgroundTransparency = 0.6
    speedSlider.BorderSizePixel = 0
    speedSlider.Parent = mainFrame

    local speedSliderCorner = Instance.new("UICorner")
    speedSliderCorner.CornerRadius = UDim.new(0, 3)
    speedSliderCorner.Parent = speedSlider

    local speedHandle = Instance.new("TextButton")
    speedHandle.Name = "SpeedHandle"
    speedHandle.Size = UDim2.new(0, 14, 0, 14)
    speedHandle.Position = UDim2.new(0, 0, 0, -4)
    speedHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    speedHandle.BorderSizePixel = 0
    speedHandle.Text = ""
    speedHandle.Parent = speedSlider

    local speedHandleCorner = Instance.new("UICorner")
    speedHandleCorner.CornerRadius = UDim.new(1, 0)
    speedHandleCorner.Parent = speedHandle

    -- Distance Slider Section
    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.Name = "DistanceLabel"
    distanceLabel.Size = UDim2.new(0, 100, 0, 15)
    distanceLabel.Position = UDim2.new(0, 10, 0, 85)
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    distanceLabel.Text = "Distance: 1.9"
    distanceLabel.TextSize = 10
    distanceLabel.Font = Enum.Font.GothamBold
    distanceLabel.TextXAlignment = Enum.TextXAlignment.Left
    distanceLabel.Parent = mainFrame

    local distanceSlider = Instance.new("Frame")
    distanceSlider.Name = "DistanceSlider"
    distanceSlider.Size = UDim2.new(0, 180, 0, 6)
    distanceSlider.Position = UDim2.new(0, 10, 0, 105)
    distanceSlider.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    distanceSlider.BackgroundTransparency = 0.6
    distanceSlider.BorderSizePixel = 0
    distanceSlider.Parent = mainFrame

    local distanceSliderCorner = Instance.new("UICorner")
    distanceSliderCorner.CornerRadius = UDim.new(0, 3)
    distanceSliderCorner.Parent = distanceSlider

    local distanceHandle = Instance.new("TextButton")
    distanceHandle.Name = "DistanceHandle"
    distanceHandle.Size = UDim2.new(0, 14, 0, 14)
    distanceHandle.Position = UDim2.new(0, 0, 0, -4)
    distanceHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    distanceHandle.BorderSizePixel = 0
    distanceHandle.Text = ""
    distanceHandle.Parent = distanceSlider

    local distanceHandleCorner = Instance.new("UICorner")
    distanceHandleCorner.CornerRadius = UDim.new(1, 0)
    distanceHandleCorner.Parent = distanceHandle

    -- Toggle Button
    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "ToggleButton"
    toggleButton.Size = UDim2.new(0, 85, 0, 28)
    toggleButton.Position = UDim2.new(0, 10, 0, 130)
    toggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    toggleButton.BackgroundTransparency = 0.6
    toggleButton.BorderSizePixel = 0
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.Text = "OFF"
    toggleButton.TextSize = 12
    toggleButton.Font = Enum.Font.GothamBold
    toggleButton.Parent = mainFrame

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 6)
    toggleCorner.Parent = toggleButton

    -- Keybind Button
    local keybindButton = Instance.new("TextButton")
    keybindButton.Name = "KeybindButton"
    keybindButton.Size = UDim2.new(0, 85, 0, 28)
    keybindButton.Position = UDim2.new(0, 105, 0, 130)
    keybindButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    keybindButton.BackgroundTransparency = 0.6
    keybindButton.BorderSizePixel = 0
    keybindButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    keybindButton.Text = "Key: Z"
    keybindButton.TextSize = 12
    keybindButton.Font = Enum.Font.GothamBold
    keybindButton.Parent = mainFrame

    local keybindCorner = Instance.new("UICorner")
    keybindCorner.CornerRadius = UDim.new(0, 6)
    keybindCorner.Parent = keybindButton

    -- Minimized Frame (Just toggle button and maximize button)
    local minimizedFrame = Instance.new("Frame")
    minimizedFrame.Name = "MinimizedFrame"
    minimizedFrame.Size = UDim2.new(0, 95, 0, 35)
    minimizedFrame.Position = mainFrame.Position
    minimizedFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    minimizedFrame.BackgroundTransparency = 0.6
    minimizedFrame.BorderSizePixel = 0
    minimizedFrame.Visible = false
    minimizedFrame.Parent = screengui

    local minimizedCorner = Instance.new("UICorner")
    minimizedCorner.CornerRadius = UDim.new(0, 8)
    minimizedCorner.Parent = minimizedFrame

    local minimizedToggle = Instance.new("TextButton")
    minimizedToggle.Name = "MinimizedToggle"
    minimizedToggle.Size = UDim2.new(0, 50, 0, 25)
    minimizedToggle.Position = UDim2.new(0, 5, 0, 5)
    minimizedToggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    minimizedToggle.BackgroundTransparency = 0.6
    minimizedToggle.BorderSizePixel = 0
    minimizedToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizedToggle.Text = "OFF"
    minimizedToggle.TextSize = 11
    minimizedToggle.Font = Enum.Font.GothamBold
    minimizedToggle.Parent = minimizedFrame

    local minimizedToggleCorner = Instance.new("UICorner")
    minimizedToggleCorner.CornerRadius = UDim.new(0, 5)
    minimizedToggleCorner.Parent = minimizedToggle

    local maximizeButton = Instance.new("TextButton")
    maximizeButton.Name = "MaximizeButton"
    maximizeButton.Size = UDim2.new(0, 30, 0, 25)
    maximizeButton.Position = UDim2.new(0, 60, 0, 5)
    maximizeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    maximizeButton.BackgroundTransparency = 0.6
    maximizeButton.BorderSizePixel = 0
    maximizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    maximizeButton.Text = "+"
    maximizeButton.TextSize = 16
    maximizeButton.Font = Enum.Font.GothamBold
    maximizeButton.Parent = minimizedFrame

    local maximizeCorner = Instance.new("UICorner")
    maximizeCorner.CornerRadius = UDim.new(0, 5)
    maximizeCorner.Parent = maximizeButton

    -- Slider Functions
    local function updateSlider(slider, handle, value, minValue, maxValue)
        local percentage = (value - minValue) / (maxValue - minValue)
        local newPosition = math.clamp(percentage * (slider.AbsoluteSize.X - handle.AbsoluteSize.X), 0, slider.AbsoluteSize.X - handle.AbsoluteSize.X)
        handle.Position = UDim2.new(0, newPosition, 0, -4)
    end

    local function setupSlider(slider, handle, minValue, maxValue, initialValue, callback)
        local dragging = false
        
        handle.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local relativeX = input.Position.X - slider.AbsolutePosition.X
                local percentage = math.clamp(relativeX / slider.AbsoluteSize.X, 0, 1)
                local value = minValue + (maxValue - minValue) * percentage
                
                updateSlider(slider, handle, value, minValue, maxValue)
                callback(value)
            end
        end)
        
        updateSlider(slider, handle, initialValue, minValue, maxValue)
    end

    setupSlider(speedSlider, speedHandle, 0.01, 0.5, THRUST_FORWARD_TIME, function(value)
        THRUST_FORWARD_TIME = value
        THRUST_BACKWARD_TIME = value
        speedLabel.Text = "Speed: " .. string.format("%.2f", value)
    end)

    setupSlider(distanceSlider, distanceHandle, 0.5, 5.0, THRUST_DISTANCE, function(value)
        THRUST_DISTANCE = value
        distanceLabel.Text = "Distance: " .. string.format("%.1f", value)
    end)

    -- Update both toggle buttons
    local function updateToggleButtons()
        if getgenv().facefuckactive then
            toggleButton.Text = "ON"
            toggleButton.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
            toggleButton.BackgroundTransparency = 0.4
            minimizedToggle.Text = "ON"
            minimizedToggle.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
            minimizedToggle.BackgroundTransparency = 0.4
        else
            toggleButton.Text = "OFF"
            toggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            toggleButton.BackgroundTransparency = 0.6
            minimizedToggle.Text = "OFF"
            minimizedToggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            minimizedToggle.BackgroundTransparency = 0.6
        end
    end

    -- Toggle Button Function
    toggleButton.MouseButton1Click:Connect(function()
        toggleMovement()
        updateToggleButtons()
    end)

    -- Minimized Toggle Button Function
    minimizedToggle.MouseButton1Click:Connect(function()
        toggleMovement()
        updateToggleButtons()
    end)

    -- Minimize Button Function
    minimizeButton.MouseButton1Click:Connect(function()
        mainFrame.Visible = false
        minimizedFrame.Visible = true
        minimizedFrame.Position = mainFrame.Position
    end)

    -- Maximize Button Function
    maximizeButton.MouseButton1Click:Connect(function()
        mainFrame.Position = minimizedFrame.Position
        mainFrame.Visible = true
        minimizedFrame.Visible = false
    end)

    -- Restore when clicking minimized frame
    minimizedFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mousePos = input.Position
            local framePos = minimizedFrame.AbsolutePosition
            local frameSize = minimizedFrame.AbsoluteSize
            
            -- Check if click is outside the toggle button
            if mousePos.X < framePos.X or mousePos.X > framePos.X + frameSize.X or
               mousePos.Y < framePos.Y or mousePos.Y > framePos.Y + frameSize.Y then
                return
            end
        end
    end)

    -- Keybind Button Function
    local waitingForKey = false
    keybindButton.MouseButton1Click:Connect(function()
        if not waitingForKey then
            waitingForKey = true
            keybindButton.Text = "Press..."
            keybindButton.BackgroundColor3 = Color3.fromRGB(100, 100, 0)
            keybindButton.BackgroundTransparency = 0.4
            
            local connection
            connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard then
                    getgenv().currentKeybind = input.KeyCode
                    keybindButton.Text = "Key: " .. input.KeyCode.Name
                    keybindButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                    keybindButton.BackgroundTransparency = 0.6
                    waitingForKey = false
                    connection:Disconnect()
                end
            end)
        end
    end)

    -- Close Button Function
    closeButton.MouseButton1Click:Connect(function()
        if getgenv().facefuckactive then
            toggleMovement()
        end
        screengui:Destroy()
    end)

    -- Dragging Functionality for Main Frame (Only title bar)
    local dragStart
    local startPos
    local dragging = false
    
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    -- Dragging Functionality for Minimized Frame
    local dragStartMin
    local startPosMin
    local draggingMin = false
    
    minimizedFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingMin = true
            dragStartMin = input.Position
            startPosMin = minimizedFrame.Position
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingMin = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if draggingMin and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStartMin
            minimizedFrame.Position = UDim2.new(
                startPosMin.X.Scale, 
                startPosMin.X.Offset + delta.X,
                startPosMin.Y.Scale,
                startPosMin.Y.Offset + delta.Y
            )
        end
    end)
end

-- Keybind Handler
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == getgenv().currentKeybind then
        toggleMovement()
        
        local playerGui = PlayerGui:FindFirstChild("FaceBangGui")
        if playerGui then
            if playerGui:FindFirstChild("MainFrame") and playerGui.MainFrame.Visible then
                local toggleButton = playerGui.MainFrame.ToggleButton
                if getgenv().facefuckactive then
                    toggleButton.Text = "ON"
                    toggleButton.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
                    toggleButton.BackgroundTransparency = 0.4
                else
                    toggleButton.Text = "OFF"
                    toggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                    toggleButton.BackgroundTransparency = 0.6
                end
            end
            if playerGui:FindFirstChild("MinimizedFrame") and playerGui.MinimizedFrame.Visible then
                local minimizedToggle = playerGui.MinimizedFrame.MinimizedToggle
                if getgenv().facefuckactive then
                    minimizedToggle.Text = "ON"
                    minimizedToggle.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
                    minimizedToggle.BackgroundTransparency = 0.4
                else
                    minimizedToggle.Text = "OFF"
                    minimizedToggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                    minimizedToggle.BackgroundTransparency = 0.6
                end
            end
        end
    end
end)

setupCharacterTracking()
setupAnimationPrevention()
createGUI()
