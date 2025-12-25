local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ANIMATION_IDS = {
    R6 = {
        "rbxassetid://225975820",
        "rbxassetid://283545583"
    },
    R15 = {
        "rbxassetid://6082224617",
        "rbxassetid://4940563117"
    }
}

local State = {
    isHugging = false,
    animations = {},
    defaultGravity = workspace.Gravity,
    targetPlayer = nil,
    manualTargeting = false
}

local function setupAnimations()
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    local animationIds = humanoid.RigType == Enum.HumanoidRigType.R15 and ANIMATION_IDS.R15 or ANIMATION_IDS.R6
    
    for _, anim in pairs(State.animations) do
        if anim.AnimationTrack then
            anim.AnimationTrack:Stop()
            anim.AnimationTrack:Destroy()
        end
    end
    
    State.animations = {}
    
    for _, id in ipairs(animationIds) do
        local animation = Instance.new("Animation")
        animation.AnimationId = id
        local animationTrack = humanoid:LoadAnimation(animation)
        
        if humanoid.RigType == Enum.HumanoidRigType.R15 then
            animationTrack.TimePosition = 0
            task.delay(0.3, function()
                if animationTrack.IsPlaying then
                    animationTrack:AdjustSpeed(0)
                end
            end)
        end
        
        table.insert(State.animations, {
            Animation = animation,
            AnimationTrack = animationTrack
        })
    end
end

local function findNearestPlayer()
    local character = LocalPlayer.Character
    if not character then return end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    
    local nearestPlayer = nil
    local minDistance = math.huge
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local targetCharacter = player.Character
            if targetCharacter then
                local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")
                if targetRoot then
                    local distance = (rootPart.Position - targetRoot.Position).Magnitude
                    if distance < minDistance then
                        minDistance = distance
                        nearestPlayer = player
                    end
                end
            end
        end
    end
    
    return nearestPlayer
end

local function attachToTarget(rootPart, targetRootPart)
    local attachment = Instance.new("Attachment")
    attachment.Parent = rootPart
    
    local targetAttachment = Instance.new("Attachment")
    targetAttachment.CFrame = CFrame.new(0, 0, 1)
    targetAttachment.Parent = targetRootPart
    
    local alignPosition = Instance.new("AlignPosition")
    alignPosition.Attachment0 = attachment
    alignPosition.Attachment1 = targetAttachment
    alignPosition.MaxForce = 100000
    alignPosition.MaxVelocity = 500
    alignPosition.Responsiveness = 200
    alignPosition.Parent = rootPart
    
    local alignOrientation = Instance.new("AlignOrientation")
    alignOrientation.Attachment0 = attachment
    alignOrientation.Attachment1 = targetAttachment
    alignOrientation.MaxTorque = 100000
    alignOrientation.Responsiveness = 200
    alignOrientation.Parent = rootPart
end

local function cleanupAttachments()
    local character = LocalPlayer.Character
    if not character then return end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    
    for _, child in ipairs(rootPart:GetChildren()) do
        if child:IsA("Attachment") or child:IsA("AlignPosition") or child:IsA("AlignOrientation") then
            child:Destroy()
        end
    end
end

local function toggleHug(targetPlayer)
    State.isHugging = not State.isHugging
    
    if State.isHugging then
        workspace.Gravity = 0
        local target = targetPlayer or State.targetPlayer or findNearestPlayer()
        
        if target and target.Character then
            local character = LocalPlayer.Character
            if character then
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                local targetRootPart = target.Character:FindFirstChild("HumanoidRootPart")
                
                if rootPart and targetRootPart then
                    setupAnimations()
                    for _, anim in pairs(State.animations) do
                        if anim.AnimationTrack then
                            anim.AnimationTrack:Play()
                        end
                    end
                    attachToTarget(rootPart, targetRootPart)
                end
            end
        end
    else
        workspace.Gravity = State.defaultGravity
        for _, anim in pairs(State.animations) do
            if anim.AnimationTrack then
                anim.AnimationTrack:Stop()
                anim.AnimationTrack:AdjustSpeed(1)
            end
        end
        cleanupAttachments()
    end
end

local function switchTarget(targetPlayer)
    if State.isHugging and targetPlayer then
        cleanupAttachments()
        
        local character = LocalPlayer.Character
        if character and targetPlayer.Character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            local targetRootPart = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            
            if rootPart and targetRootPart then
                attachToTarget(rootPart, targetRootPart)
                State.targetPlayer = targetPlayer
            end
        end
    else
        toggleHug(targetPlayer)
    end
end

local function createGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.ResetOnSpawn = false
    screenGui.DisplayOrder = 999
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    
    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 200, 0, 140)
    mainFrame.Position = UDim2.new(0.5, -100, 0.5, -70)
    mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    mainFrame.BackgroundTransparency = 0.7
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 12)
    mainCorner.Parent = mainFrame
    
    -- AK ADMIN label (top left of GUI)
    local akLabel = Instance.new("TextLabel")
    akLabel.Size = UDim2.new(0, 100, 0, 20)
    akLabel.Position = UDim2.new(0, 8, 0, 5)
    akLabel.BackgroundTransparency = 1
    akLabel.Text = "AK ADMIN"
    akLabel.TextSize = 10
    akLabel.Font = Enum.Font.GothamBold
    akLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    akLabel.TextXAlignment = Enum.TextXAlignment.Left
    akLabel.Parent = mainFrame
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Position = UDim2.new(0, 0, 0, 8)
    title.BackgroundTransparency = 1
    title.Text = "HUG"
    title.TextSize = 16
    title.Font = Enum.Font.GothamBold
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Parent = mainFrame
    
    -- Close Button
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 25, 0, 25)
    closeButton.Position = UDim2.new(1, -30, 0, 2.5)
    closeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    closeButton.BackgroundTransparency = 0.5
    closeButton.Text = "×"
    closeButton.TextSize = 18
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.BorderSizePixel = 0
    closeButton.Parent = mainFrame
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 4)
    closeCorner.Parent = closeButton
    
    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    
    -- Nearest Player Button
    local nearestButton = Instance.new("TextButton")
    nearestButton.Size = UDim2.new(0, 170, 0, 35)
    nearestButton.Position = UDim2.new(0, 15, 0, 45)
    nearestButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    nearestButton.BackgroundTransparency = 0.5
    nearestButton.Text = "Hug Nearest"
    nearestButton.TextSize = 14
    nearestButton.Font = Enum.Font.GothamBold
    nearestButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    nearestButton.BorderSizePixel = 0
    nearestButton.Parent = mainFrame
    
    local nearestCorner = Instance.new("UICorner")
    nearestCorner.CornerRadius = UDim.new(0, 8)
    nearestCorner.Parent = nearestButton
    
    nearestButton.MouseButton1Click:Connect(function()
        toggleHug(findNearestPlayer())
    end)
    
    -- Click to Target Toggle Button
    local targetButton = Instance.new("TextButton")
    targetButton.Size = UDim2.new(0, 170, 0, 35)
    targetButton.Position = UDim2.new(0, 15, 0, 90)
    targetButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    targetButton.BackgroundTransparency = 0.5
    targetButton.Text = "Click to Target: OFF"
    targetButton.TextSize = 14
    targetButton.Font = Enum.Font.GothamBold
    targetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    targetButton.BorderSizePixel = 0
    targetButton.Parent = mainFrame
    
    local targetCorner = Instance.new("UICorner")
    targetCorner.CornerRadius = UDim.new(0, 8)
    targetCorner.Parent = targetButton
    
    targetButton.MouseButton1Click:Connect(function()
        State.manualTargeting = not State.manualTargeting
        if State.manualTargeting then
            targetButton.Text = "Click to Target: ON"
            targetButton.BackgroundTransparency = 0.3
        else
            targetButton.Text = "Click to Target: OFF"
            targetButton.BackgroundTransparency = 0.5
            State.targetPlayer = nil
            -- Turn off hug when disabling click to target
            if State.isHugging then
                toggleHug()
            end
        end
    end)
    
    -- Make frame draggable
    local dragging = false
    local dragInput, mousePos, framePos
    
    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mousePos = input.Position
            framePos = mainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    mainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            mainFrame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)
end

local function setupInput()
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.H then
            toggleHug()
        end
    end)
    
    -- Manual targeting with click
    local mouse = LocalPlayer:GetMouse()
    mouse.Button1Down:Connect(function()
        if State.manualTargeting then
            local target = mouse.Target
            if target then
                local player = Players:GetPlayerFromCharacter(target.Parent)
                if player and player ~= LocalPlayer then
                    State.targetPlayer = player
                    switchTarget(player)
                end
            end
        end
    end)
end

createGUI()
setupInput()

