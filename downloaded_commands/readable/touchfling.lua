-- TouchFling - Enhanced Character Physics Control
-- Sleek transparent GUI with centered title

-- Core Service Initialization
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Enhanced Configuration
local Config = {
    GUI_COLORS = {
        BACKGROUND = Color3.fromRGB(0, 0, 0),
        BACKGROUND_TRANSPARENCY = 0.6,
        BUTTON_OFF = Color3.fromRGB(15, 15, 15),
        BUTTON_ON = Color3.fromRGB(0, 180, 80),
        ACCENT = Color3.fromRGB(255, 255, 255),
        TEXT = Color3.fromRGB(255, 255, 255),
        BORDER = Color3.fromRGB(40, 40, 40)
    },
    FLING = {
        STRENGTH = 500000,
        MOVEMENT_DELTA = 0.1
    }
}

-- Persistent State Management
local State = {
    isAlive = true,
    isResetting = false,
    flingEnabled = false,
    collisionEnabled = false,
    character = nil,
    root = nil,
    humanoid = nil,
    velocity = nil,
    guiCreated = false,
    ui = nil,
    isMinimized = false,
    isVisible = true
}

-- Enhanced UI Components Creation
local function createEnhancedUI()
    -- Clean up existing GUI first
    local existingGui = Players.LocalPlayer.PlayerGui:FindFirstChild("TouchFlingGUI")
    if existingGui then
        existingGui:Destroy()
    end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "TouchFlingGUI"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Main Control Panel with increased transparency
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 220, 0, 160)
    mainFrame.Position = UDim2.new(0.01, 0, 0.7, 0)
    mainFrame.BackgroundColor3 = Config.GUI_COLORS.BACKGROUND
    mainFrame.BackgroundTransparency = Config.GUI_COLORS.BACKGROUND_TRANSPARENCY
    mainFrame.BorderSizePixel = 0
    mainFrame.Name = "ControlPanel"
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui

    -- Main frame border
    local mainStroke = Instance.new("UIStroke")
    mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    mainStroke.Color = Config.GUI_COLORS.BORDER
    mainStroke.Thickness = 1
    mainStroke.Transparency = 0.7
    mainStroke.Parent = mainFrame

    -- Title Bar (invisible but keeps title)
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 35)
    titleBar.BackgroundTransparency = 1
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame

    -- Title text (centered)
    local titleText = Instance.new("TextLabel")
    titleText.Size = UDim2.new(1, -60, 1, 0)
    titleText.Position = UDim2.new(0, 30, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = "TouchFling"
    titleText.TextColor3 = Config.GUI_COLORS.TEXT
    titleText.Font = Enum.Font.GothamBold
    titleText.TextSize = 16
    titleText.TextXAlignment = Enum.TextXAlignment.Center
    titleText.Parent = titleBar

    -- Control buttons container
    local controlsFrame = Instance.new("Frame")
    controlsFrame.Size = UDim2.new(0, 50, 1, 0)
    controlsFrame.Position = UDim2.new(1, -50, 0, 0)
    controlsFrame.BackgroundTransparency = 1
    controlsFrame.Parent = titleBar

    -- Minimize Button
    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Size = UDim2.new(0, 20, 0, 20)
    minimizeButton.Position = UDim2.new(0, 5, 0.5, -10)
    minimizeButton.BackgroundColor3 = Config.GUI_COLORS.BUTTON_OFF
    minimizeButton.BackgroundTransparency = 0.6
    minimizeButton.Text = "−"
    minimizeButton.TextColor3 = Config.GUI_COLORS.TEXT
    minimizeButton.Font = Enum.Font.GothamBold
    minimizeButton.TextSize = 14
    minimizeButton.Parent = controlsFrame

    -- Close Button
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 20, 0, 20)
    closeButton.Position = UDim2.new(0, 27, 0.5, -10)
    closeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    closeButton.BackgroundTransparency = 0.6
    closeButton.Text = "×"
    closeButton.TextColor3 = Config.GUI_COLORS.TEXT
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextSize = 14
    closeButton.Parent = controlsFrame

    -- Content Frame (for the buttons)
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, 0, 1, -35)
    contentFrame.Position = UDim2.new(0, 0, 0, 35)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Name = "ContentFrame"
    contentFrame.Parent = mainFrame

    -- Rounded Corners
    local function addCorners(instance, radius)
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, radius or 8)
        corner.Parent = instance
    end

    addCorners(mainFrame, 12)
    addCorners(minimizeButton, 4)
    addCorners(closeButton, 4)

    -- Create Enhanced Toggle Button Function
    local function createToggleButton(title, position)
        local buttonFrame = Instance.new("Frame")
        buttonFrame.Size = UDim2.new(0.9, 0, 0, 40)
        buttonFrame.Position = position
        buttonFrame.BackgroundTransparency = 1
        buttonFrame.Parent = contentFrame
        
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, 0, 1, 0)
        button.BackgroundColor3 = Config.GUI_COLORS.BUTTON_OFF
        button.BackgroundTransparency = 0.5
        button.Text = ""
        button.Parent = buttonFrame
        
        -- Button gradient
        local buttonGradient = Instance.new("UIGradient")
        buttonGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 25)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 10))
        }
        buttonGradient.Rotation = 90
        buttonGradient.Transparency = NumberSequence.new(0.5)
        buttonGradient.Parent = button
        
        -- Button border
        local buttonStroke = Instance.new("UIStroke")
        buttonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        buttonStroke.Color = Config.GUI_COLORS.BORDER
        buttonStroke.Thickness = 1
        buttonStroke.Transparency = 0.6
        buttonStroke.Parent = button
        
        -- Text Label (centered)
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, -20, 1, 0)
        textLabel.Position = UDim2.new(0, 10, 0, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = title
        textLabel.TextColor3 = Config.GUI_COLORS.TEXT
        textLabel.Font = Enum.Font.GothamSemibold
        textLabel.TextSize = 14
        textLabel.TextXAlignment = Enum.TextXAlignment.Center
        textLabel.Parent = button
        
        -- Status Indicator
        local statusDot = Instance.new("Frame")
        statusDot.Size = UDim2.new(0, 8, 0, 8)
        statusDot.Position = UDim2.new(1, -18, 0.5, -4)
        statusDot.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        statusDot.BackgroundTransparency = 0.3
        statusDot.BorderSizePixel = 0
        statusDot.Parent = button
        
        addCorners(button, 8)
        addCorners(statusDot, 4)
        
        return {
            button = button,
            textLabel = textLabel,
            statusDot = statusDot
        }
    end

    -- Create Buttons
    local flingButton = createToggleButton("Fling: OFF", UDim2.new(0.05, 0, 0.05, 0))
    local collisionButton = createToggleButton("No-Clip: OFF", UDim2.new(0.05, 0, 0.42, 0))

    return {
        screenGui = screenGui,
        mainFrame = mainFrame,
        contentFrame = contentFrame,
        minimizeButton = minimizeButton,
        closeButton = closeButton,
        flingButton = flingButton,
        collisionButton = collisionButton
    }
end

-- Enhanced Button State Management
local function updateButtonState(buttonObj, enabled, onText, offText)
    local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    
    -- Button background tween
    local buttonGoal = {
        BackgroundColor3 = enabled and Config.GUI_COLORS.BUTTON_ON or Config.GUI_COLORS.BUTTON_OFF
    }
    
    -- Status dot tween
    local dotGoal = {
        BackgroundColor3 = enabled and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 50, 50)
    }
    
    TweenService:Create(buttonObj.button, tweenInfo, buttonGoal):Play()
    TweenService:Create(buttonObj.statusDot, tweenInfo, dotGoal):Play()
    
    buttonObj.textLabel.Text = enabled and onText or offText
end

-- Character Management Functions
local function setupCharacter()
    State.character = Players.LocalPlayer.Character
    if State.character then
        State.root = State.character:FindFirstChild("HumanoidRootPart")
        State.humanoid = State.character:FindFirstChild("Humanoid")
        
        if State.humanoid then
            State.humanoid.Died:Connect(function()
                State.isAlive = false
            end)
        end
    end
end

-- Collision Handler
local function handleCollisions()
    if not State.collisionEnabled then return end
    
    for _, player in next, Players:GetPlayers() do
        if player ~= Players.LocalPlayer and player.Character then
            pcall(function()
                for _, part in next, player.Character:GetChildren() do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                        if part.Name == "Torso" then
                            part.Massless = true
                        end
                        part.Velocity = Vector3.new()
                        part.RotVelocity = Vector3.new()
                    end
                end
            end)
        end
    end
end

-- Fling Handler
local function handleFling()
    if not State.flingEnabled or State.isResetting or not State.isAlive then return end
    
    if not (State.character and State.character.Parent and State.root and State.root.Parent) then return end
    
    if not State.humanoid or State.humanoid.Health <= 0 then
        State.isAlive = false
        return
    end
    
    State.velocity = State.root.Velocity
    State.root.Velocity = State.velocity * Config.FLING.STRENGTH + Vector3.new(0, Config.FLING.STRENGTH, 0)
    RunService.RenderStepped:Wait()
    
    if State.character and State.character.Parent and State.root and State.root.Parent then
        State.root.Velocity = State.velocity
    end
    
    RunService.Stepped:Wait()
    
    if State.character and State.character.Parent and State.root and State.root.Parent then
        State.root.Velocity = State.velocity + Vector3.new(0, Config.FLING.MOVEMENT_DELTA, 0)
        Config.FLING.MOVEMENT_DELTA = Config.FLING.MOVEMENT_DELTA * -1
    end
end

-- GUI Control Functions
local function toggleMinimize()
    if not State.ui then return end
    
    State.isMinimized = not State.isMinimized
    
    local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    local newSize = State.isMinimized and UDim2.new(0, 220, 0, 35) or UDim2.new(0, 220, 0, 160)
    
    -- Tween the main frame size
    TweenService:Create(State.ui.mainFrame, tweenInfo, {Size = newSize}):Play()
    
    -- Hide/show content frame
    State.ui.contentFrame.Visible = not State.isMinimized
    
    -- Update minimize button text
    State.ui.minimizeButton.Text = State.isMinimized and "+" or "−"
end

local function toggleVisibility()
    if not State.ui then return end
    
    State.isVisible = not State.isVisible
    State.ui.screenGui.Enabled = State.isVisible
    
    -- If closing, save the state
    if not State.isVisible then
        saveState()
    end
end

-- Hotkey to reopen GUI (Ctrl + T)
local function setupHotkeys()
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.T and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            if not State.isVisible then
                toggleVisibility()
            end
        end
    end)
end

local function saveState()
    -- Save current toggle states
    _G.TouchFlingState = {
        flingEnabled = State.flingEnabled,
        collisionEnabled = State.collisionEnabled
    }
end

local function loadState()
    -- Restore previous toggle states
    if _G.TouchFlingState then
        State.flingEnabled = _G.TouchFlingState.flingEnabled or false
        State.collisionEnabled = _G.TouchFlingState.collisionEnabled or false
    end
end

-- Main Initialization
local function initialize()
    -- Load previous state
    loadState()
    
    -- Create UI
    State.ui = createEnhancedUI()
    State.guiCreated = true
    
    -- Apply loaded state to UI
    if State.ui then
        -- Set visibility
        State.ui.screenGui.Enabled = State.isVisible
        
        -- Set minimize state
        if State.isMinimized then
            State.ui.mainFrame.Size = UDim2.new(0, 220, 0, 35)
            State.ui.contentFrame.Visible = false
            State.ui.minimizeButton.Text = "+"
        end
        
        updateButtonState(State.ui.flingButton, State.flingEnabled, "Fling: ON", "Fling: OFF")
        updateButtonState(State.ui.collisionButton, State.collisionEnabled, "No-Clip: ON", "No-Clip: OFF")
    end
    
    -- Setup hotkeys
    setupHotkeys()
    
    -- Setup Character
    setupCharacter()
    
    -- Character respawn handler
    Players.LocalPlayer.CharacterAdded:Connect(function(newCharacter)
        State.isResetting = true
        
        -- Small delay to ensure character is properly loaded
        wait(0.2)
        
        if newCharacter == Players.LocalPlayer.Character then
            setupCharacter()
            State.isAlive = true
            
            -- Recreate UI if it was destroyed
            if not State.ui or not State.ui.screenGui or not State.ui.screenGui.Parent then
                State.ui = createEnhancedUI()
                
                -- Apply loaded state to recreated UI
                if State.ui then
                    -- Set visibility
                    State.ui.screenGui.Enabled = State.isVisible
                    
                    -- Set minimize state
                    if State.isMinimized then
                        State.ui.mainFrame.Size = UDim2.new(0, 220, 0, 35)
                        State.ui.contentFrame.Visible = false
                        State.ui.minimizeButton.Text = "+"
                    end
                    
                    updateButtonState(State.ui.flingButton, State.flingEnabled, "Fling: ON", "Fling: OFF")
                    updateButtonState(State.ui.collisionButton, State.collisionEnabled, "No-Clip: ON", "No-Clip: OFF")
                end
                
                -- Reconnect button events
                connectButtonEvents()
            end
        end
        
        State.isResetting = false
    end)
    
    -- Initial button event connection
    connectButtonEvents()
    
    -- Main Loop Connections
    RunService.Heartbeat:Connect(handleFling)
    RunService.Stepped:Connect(handleCollisions)
    
    -- Save state periodically
    spawn(function()
        while wait(1) do
            saveState()
        end
    end)
end

-- Button Event Connection Function
function connectButtonEvents()
    if not State.ui then return end
    
    -- Minimize Button
    State.ui.minimizeButton.MouseButton1Click:Connect(function()
        toggleMinimize()
        saveState()
    end)
    
    -- Close Button
    State.ui.closeButton.MouseButton1Click:Connect(function()
        toggleVisibility()
    end)
    
    -- Fling Button
    State.ui.flingButton.button.MouseButton1Click:Connect(function()
        State.flingEnabled = not State.flingEnabled
        updateButtonState(State.ui.flingButton, State.flingEnabled, "Fling: ON", "Fling: OFF")
        saveState()
    end)
    
    -- Collision Button
    State.ui.collisionButton.button.MouseButton1Click:Connect(function()
        State.collisionEnabled = not State.collisionEnabled
        updateButtonState(State.ui.collisionButton, State.collisionEnabled, "No-Clip: ON", "No-Clip: OFF")
        saveState()
    end)
end

-- Execute Initialization
initialize()
