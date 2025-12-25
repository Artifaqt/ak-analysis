local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")

local THEME = {
    BACKGROUND = Color3.fromRGB(0, 0, 0),
    SECONDARY = Color3.fromRGB(0, 0, 0),
    ACCENT = Color3.fromRGB(20, 20, 20),
    ACCENT_HOVER = Color3.fromRGB(35, 35, 35),
    TEXT = Color3.fromRGB(255, 255, 255),
    TEXT_SECONDARY = Color3.fromRGB(160, 160, 170),
    SUCCESS = Color3.fromRGB(34, 197, 94),
    ERROR = Color3.fromRGB(239, 68, 68),
    WARNING = Color3.fromRGB(245, 158, 11)
}

local CONFIG = {
    GUI_WIDTH = 250,
    GUI_HEIGHT = 320,
    ENTRY_HEIGHT = 50,
    CORNER_RADIUS = 15,
    BUTTON_RADIUS = 8,
    TWEEN_SPEED = 0.15,
    TRANSPARENCY = 0.3
}

-- Animation name cache
local animationNameCache = {}
local isMinimized = false

local function createTween(instance, properties, duration)
    return TweenService:Create(
        instance,
        TweenInfo.new(duration or CONFIG.TWEEN_SPEED, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        properties
    ):Play()
end

local function getAnimationName(animationId)
    if animationNameCache[animationId] then
        return animationNameCache[animationId]
    end
    
    local numericId = animationId:match("rbxassetid://(%d+)") or animationId:match("(%d+)")
    if not numericId then
        return "Unknown Animation"
    end
    
    local success, result = pcall(function()
        return MarketplaceService:GetProductInfo(tonumber(numericId), Enum.InfoType.Asset)
    end)
    
    if success and result and result.Name then
        animationNameCache[animationId] = result.Name
        return result.Name
    else
        animationNameCache[animationId] = "Animation " .. numericId
        return "Animation " .. numericId
    end
end

-- GUI Creation
local gui = Instance.new("ScreenGui")
gui.Name = "PremiumAnimationLogger"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, CONFIG.GUI_WIDTH, 0, CONFIG.GUI_HEIGHT)
frame.Position = UDim2.new(1, -CONFIG.GUI_WIDTH - 20, 0.5, -CONFIG.GUI_HEIGHT/2)
frame.BackgroundColor3 = THEME.BACKGROUND
frame.BackgroundTransparency = CONFIG.TRANSPARENCY
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, CONFIG.CORNER_RADIUS)

-- Header Section
local headerFrame = Instance.new("Frame")
headerFrame.Size = UDim2.new(1, 0, 0, 35)
headerFrame.Position = UDim2.new(0, 0, 0, 0)
headerFrame.BackgroundTransparency = 1
headerFrame.Parent = frame

-- Title (centered)
local title = Instance.new("TextLabel")
title.Text = "Animation Logger"
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.Size = UDim2.new(0, 120, 1, 0)
title.Position = UDim2.new(0.5, -60, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = THEME.TEXT
title.TextXAlignment = Enum.TextXAlignment.Center
title.Parent = headerFrame

-- Clear Button (left)
local clearButton = Instance.new("TextButton")
clearButton.Text = "Clear"
clearButton.Font = Enum.Font.GothamMedium
clearButton.TextSize = 10
clearButton.Size = UDim2.new(0, 30, 0, 20)
clearButton.Position = UDim2.new(0, 8, 0.5, -10)
clearButton.BackgroundColor3 = THEME.ACCENT
clearButton.BackgroundTransparency = CONFIG.TRANSPARENCY
clearButton.TextColor3 = THEME.TEXT
clearButton.AutoButtonColor = false
clearButton.Parent = headerFrame

Instance.new("UICorner", clearButton).CornerRadius = UDim.new(0, CONFIG.BUTTON_RADIUS)

-- Minimize Button (right side)
local minimizeButton = Instance.new("TextButton")
minimizeButton.Text = "─"
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 12
minimizeButton.Size = UDim2.new(0, 20, 0, 20)
minimizeButton.Position = UDim2.new(1, -48, 0.5, -10)
minimizeButton.BackgroundColor3 = THEME.WARNING
minimizeButton.BackgroundTransparency = CONFIG.TRANSPARENCY
minimizeButton.TextColor3 = THEME.TEXT
minimizeButton.AutoButtonColor = false
minimizeButton.Parent = headerFrame

Instance.new("UICorner", minimizeButton).CornerRadius = UDim.new(0, CONFIG.BUTTON_RADIUS)

-- Close Button (right)
local closeButton = Instance.new("TextButton")
closeButton.Text = "X"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 11
closeButton.Size = UDim2.new(0, 20, 0, 20)
closeButton.Position = UDim2.new(1, -24, 0.5, -10)
closeButton.BackgroundColor3 = THEME.ERROR
closeButton.BackgroundTransparency = CONFIG.TRANSPARENCY
closeButton.TextColor3 = THEME.TEXT
closeButton.AutoButtonColor = false
closeButton.Parent = headerFrame

Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, CONFIG.BUTTON_RADIUS)

-- Scrolling Container
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Position = UDim2.new(0, 8, 0, 40)
scrollFrame.Size = UDim2.new(1, -16, 1, -48)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 3
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
scrollFrame.ScrollBarImageTransparency = 0.4
scrollFrame.BorderSizePixel = 0
scrollFrame.Parent = frame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 6)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = scrollFrame

-- Animation Tracking
local loggedAnimations = {}
local entryCount = 0

local function createLogEntry(track)
    local animId = track.Animation.AnimationId
    if loggedAnimations[animId] then return end
    loggedAnimations[animId] = true
    entryCount = entryCount + 1
    
    local entry = Instance.new("Frame")
    entry.Size = UDim2.new(1, 0, 0, CONFIG.ENTRY_HEIGHT)
    entry.BackgroundColor3 = THEME.SECONDARY
    entry.BackgroundTransparency = CONFIG.TRANSPARENCY
    entry.LayoutOrder = entryCount
    entry.Parent = scrollFrame
    
    Instance.new("UICorner", entry).CornerRadius = UDim.new(0, 10)
    
    -- Get actual animation name
    local actualAnimName = getAnimationName(animId)
    
    local animName = Instance.new("TextLabel")
    animName.Text = actualAnimName
    animName.Font = Enum.Font.GothamSemibold
    animName.TextSize = 12
    animName.Size = UDim2.new(1, -50, 0, 20)
    animName.Position = UDim2.new(0, 10, 0, 8)
    animName.BackgroundTransparency = 1
    animName.TextColor3 = THEME.TEXT
    animName.TextXAlignment = Enum.TextXAlignment.Left
    animName.TextTruncate = Enum.TextTruncate.AtEnd
    animName.Parent = entry
    
    local idLabel = Instance.new("TextLabel")
    idLabel.Text = "ID: " .. (animId:match("rbxassetid://(.+)") or animId)
    idLabel.Font = Enum.Font.Gotham
    idLabel.TextSize = 9
    idLabel.Size = UDim2.new(1, -50, 0, 14)
    idLabel.Position = UDim2.new(0, 10, 1, -22)
    idLabel.BackgroundTransparency = 1
    idLabel.TextColor3 = THEME.TEXT_SECONDARY
    idLabel.TextXAlignment = Enum.TextXAlignment.Left
    idLabel.TextTruncate = Enum.TextTruncate.AtEnd
    idLabel.Parent = entry
    
    local copyButton = Instance.new("TextButton")
    copyButton.Text = "Copy"
    copyButton.Font = Enum.Font.GothamMedium
    copyButton.TextSize = 9
    copyButton.Size = UDim2.new(0, 35, 0, 25)
    copyButton.Position = UDim2.new(1, -42, 0.5, -12.5)
    copyButton.BackgroundColor3 = THEME.ACCENT
    copyButton.BackgroundTransparency = CONFIG.TRANSPARENCY
    copyButton.TextColor3 = THEME.TEXT
    copyButton.AutoButtonColor = false
    copyButton.Parent = entry
    
    Instance.new("UICorner", copyButton).CornerRadius = UDim.new(0, 6)
    
    -- Button Events
    copyButton.MouseEnter:Connect(function()
        createTween(copyButton, {BackgroundColor3 = THEME.ACCENT_HOVER, BackgroundTransparency = 0.15})
    end)
    
    copyButton.MouseLeave:Connect(function()
        createTween(copyButton, {BackgroundColor3 = THEME.ACCENT, BackgroundTransparency = CONFIG.TRANSPARENCY})
    end)
    
    copyButton.MouseButton1Click:Connect(function()
        setclipboard(animId:match("%d+"))
        createTween(copyButton, {BackgroundColor3 = THEME.SUCCESS, BackgroundTransparency = 0.15})
        copyButton.Text = "✓"
        task.wait(0.8)
        copyButton.Text = "Copy"
        createTween(copyButton, {BackgroundColor3 = THEME.ACCENT, BackgroundTransparency = CONFIG.TRANSPARENCY})
    end)
    
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
end

-- Character Hook
local function hookCharacter(char)
    local humanoid = char:WaitForChild("Humanoid")
    local animator = humanoid:WaitForChild("Animator")
    animator.AnimationPlayed:Connect(createLogEntry)
end

-- Initialize
local player = Players.LocalPlayer
if player.Character then hookCharacter(player.Character) end
player.CharacterAdded:Connect(hookCharacter)

-- Dragging System
local dragging, dragStart, startPos, dragInput

headerFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or
       input.UserInputType == Enum.UserInputType.Touch then
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

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or
       input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

RunService.RenderStepped:Connect(function()
    if dragging and dragInput then
        local delta = dragInput.Position - dragStart
        createTween(frame, {
            Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        }, 0.05)
    end
end)

-- Button Events
local function addButtonHover(button, hoverColor, normalColor)
    button.MouseEnter:Connect(function()
        createTween(button, {BackgroundColor3 = hoverColor, BackgroundTransparency = 0.15})
    end)
    
    button.MouseLeave:Connect(function()
        createTween(button, {BackgroundColor3 = normalColor, BackgroundTransparency = CONFIG.TRANSPARENCY})
    end)
end

addButtonHover(clearButton, THEME.ACCENT_HOVER, THEME.ACCENT)
addButtonHover(closeButton, Color3.fromRGB(255, 90, 90), THEME.ERROR)
addButtonHover(minimizeButton, Color3.fromRGB(255, 180, 50), THEME.WARNING)

-- Minimize functionality
minimizeButton.MouseButton1Click:Connect(function()
    if isMinimized then
        createTween(frame, {Size = UDim2.new(0, CONFIG.GUI_WIDTH, 0, CONFIG.GUI_HEIGHT)})
        minimizeButton.Text = "─"
        isMinimized = false
    else
        createTween(frame, {Size = UDim2.new(0, CONFIG.GUI_WIDTH, 0, 35)})
        minimizeButton.Text = "□"
        isMinimized = true
    end
end)

clearButton.MouseButton1Click:Connect(function()
    for _, child in ipairs(scrollFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    loggedAnimations = {}
    entryCount = 0
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
end)

closeButton.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Initialize GUI
gui.Parent = player:WaitForChild("PlayerGui")
