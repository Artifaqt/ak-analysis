local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local akAdminFolder = CoreGui:FindFirstChild("AK ADMIN")
if not akAdminFolder then
    akAdminFolder = Instance.new("Folder")
    akAdminFolder.Name = "AK ADMIN"
    akAdminFolder.Parent = CoreGui
end

local adminGUI = CoreGui:FindFirstChild("AdminActiveGUI")
local mainContainer = adminGUI:FindFirstChild("MainContainer")
local originalPosition = mainContainer.Position

if adminGUI.Parent ~= akAdminFolder then
    adminGUI.Parent = akAdminFolder
end

local function getCurrentElements()
    local elements = {}
    
    for _, container in pairs({CoreGui, akAdminFolder, player.PlayerGui}) do
        for _, child in pairs(container:GetChildren()) do
            if child.Name == "NametagToggleGui" and not elements.nametagButton then
                child.Parent = akAdminFolder
                local nametagButton = child:FindFirstChild("ImageButton")
                if nametagButton and nametagButton.Parent then
                    elements.nametagButton = nametagButton
                end
            elseif child.Name == "UsersJoinerGui" and (not elements.usersJoinerFrame or not elements.usersJoinerTextButton) then
                child.Parent = akAdminFolder
                local usersJoinerFrame = child:FindFirstChild("Frame")
                local usersJoinerTextButton = child:FindFirstChild("TextButton")
                if usersJoinerFrame and usersJoinerFrame.Parent and not elements.usersJoinerFrame then
                    elements.usersJoinerFrame = usersJoinerFrame
                end
                if usersJoinerTextButton and usersJoinerTextButton.Parent and not elements.usersJoinerTextButton then
                    elements.usersJoinerTextButton = usersJoinerTextButton
                end
            elseif child.Name == "PremiumCommandBar" then
                pcall(function()
                    child.Parent = akAdminFolder
                    for _, frame in pairs(child:GetChildren()) do
                        if frame:IsA("Frame") and frame.Parent then
                            local alreadyExists = false
                            for _, existingFrame in pairs(elements.premiumFrames or {}) do
                                if existingFrame == frame then
                                    alreadyExists = true
                                    break
                                end
                            end
                            if not alreadyExists then
                                elements.premiumFrames = elements.premiumFrames or {}
                                table.insert(elements.premiumFrames, frame)
                            end
                        end
                    end
                end)
            end
        end
    end
    
    elements.premiumFrames = elements.premiumFrames or {}
    return elements
end

local arrowButton = Instance.new("TextButton")
arrowButton.Name = "AdminArrowButton"
arrowButton.Size = UDim2.new(0, 80, 0, 15)
arrowButton.Position = UDim2.new(0.5, -40, 1, 5)
arrowButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
arrowButton.BackgroundTransparency = 0.6
arrowButton.BorderSizePixel = 0
arrowButton.Text = "▼"
arrowButton.TextColor3 = Color3.fromRGB(255, 255, 255)
arrowButton.TextSize = 14
arrowButton.Font = Enum.Font.SourceSansBold
arrowButton.Parent = mainContainer

local arrowCorner = Instance.new("UICorner")
arrowCorner.CornerRadius = UDim.new(0, 4)
arrowCorner.Parent = arrowButton

local isExpanded = false
local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local storedOriginalPositions = {}

local function moveAllElementsDown()
    local currentElements = getCurrentElements()
    
    storedOriginalPositions = {}
    storedOriginalPositions.mainContainer = originalPosition
    
    if currentElements.nametagButton then
        storedOriginalPositions.nametagButton = currentElements.nametagButton.Position
    end
    if currentElements.usersJoinerFrame then
        storedOriginalPositions.usersJoinerFrame = currentElements.usersJoinerFrame.Position
    end
    if currentElements.usersJoinerTextButton then
        storedOriginalPositions.usersJoinerTextButton = currentElements.usersJoinerTextButton.Position
    end
    
    storedOriginalPositions.premiumFrames = {}
    for i, frame in ipairs(currentElements.premiumFrames) do
        pcall(function() 
            storedOriginalPositions.premiumFrames[i] = frame.Position 
        end)
    end
    
    local targetPosition = UDim2.new(originalPosition.X.Scale, originalPosition.X.Offset, originalPosition.Y.Scale + 1.0, originalPosition.Y.Offset)
    TweenService:Create(mainContainer, tweenInfo, {Position = targetPosition}):Play()
    
    if currentElements.nametagButton then
        local nametagTargetPos = UDim2.new(currentElements.nametagButton.Position.X.Scale, currentElements.nametagButton.Position.X.Offset, currentElements.nametagButton.Position.Y.Scale + 1.0, currentElements.nametagButton.Position.Y.Offset)
        pcall(function()
            TweenService:Create(currentElements.nametagButton, tweenInfo, {Position = nametagTargetPos}):Play()
        end)
    end
    
    if currentElements.usersJoinerFrame then
        local usersJoinerTargetPos = UDim2.new(currentElements.usersJoinerFrame.Position.X.Scale, currentElements.usersJoinerFrame.Position.X.Offset, currentElements.usersJoinerFrame.Position.Y.Scale + 1.0, currentElements.usersJoinerFrame.Position.Y.Offset)
        pcall(function()
            TweenService:Create(currentElements.usersJoinerFrame, tweenInfo, {Position = usersJoinerTargetPos}):Play()
        end)
    end
    
    if currentElements.usersJoinerTextButton then
        local usersJoinerTextButtonTargetPos = UDim2.new(currentElements.usersJoinerTextButton.Position.X.Scale, currentElements.usersJoinerTextButton.Position.X.Offset, currentElements.usersJoinerTextButton.Position.Y.Scale + 1.0, currentElements.usersJoinerTextButton.Position.Y.Offset)
        pcall(function()
            TweenService:Create(currentElements.usersJoinerTextButton, tweenInfo, {Position = usersJoinerTextButtonTargetPos}):Play()
        end)
    end
    
    for i, frame in ipairs(currentElements.premiumFrames) do
        pcall(function()
            local currentPos = frame.Position
            local premiumTargetPos = UDim2.new(currentPos.X.Scale, currentPos.X.Offset, currentPos.Y.Scale + 1.0, currentPos.Y.Offset)
            TweenService:Create(frame, tweenInfo, {Position = premiumTargetPos}):Play()
        end)
    end
    
    TweenService:Create(arrowButton, tweenInfo, {Position = UDim2.new(0.5, -40, 0, -20)}):Play()
    arrowButton.Text = "▲"
    isExpanded = true
end

local function moveAllElementsUp()
    TweenService:Create(mainContainer, tweenInfo, {Position = originalPosition}):Play()
    
    if storedOriginalPositions.nametagButton then
        local currentElements = getCurrentElements()
        if currentElements.nametagButton then
            pcall(function()
                TweenService:Create(currentElements.nametagButton, tweenInfo, {Position = storedOriginalPositions.nametagButton}):Play()
            end)
        end
    end
    
    if storedOriginalPositions.usersJoinerFrame then
        local currentElements = getCurrentElements()
        if currentElements.usersJoinerFrame then
            pcall(function()
                TweenService:Create(currentElements.usersJoinerFrame, tweenInfo, {Position = storedOriginalPositions.usersJoinerFrame}):Play()
            end)
        end
    end
    
    if storedOriginalPositions.usersJoinerTextButton then
        local currentElements = getCurrentElements()
        if currentElements.usersJoinerTextButton then
            pcall(function()
                TweenService:Create(currentElements.usersJoinerTextButton, tweenInfo, {Position = storedOriginalPositions.usersJoinerTextButton}):Play()
            end)
        end
    end
    
    local currentElements = getCurrentElements()
    for i, frame in ipairs(currentElements.premiumFrames) do
        if storedOriginalPositions.premiumFrames[i] then
            pcall(function()
                TweenService:Create(frame, tweenInfo, {Position = storedOriginalPositions.premiumFrames[i]}):Play()
            end)
        end
    end
    
    TweenService:Create(arrowButton, tweenInfo, {Position = UDim2.new(0.5, -40, 1, 5)}):Play()
    arrowButton.Text = "▼"
    isExpanded = false
end

arrowButton.MouseButton1Click:Connect(function()
    if isExpanded then 
        moveAllElementsUp() 
    else 
        moveAllElementsDown() 
    end
end)

arrowButton.MouseEnter:Connect(function()
    TweenService:Create(arrowButton, TweenInfo.new(0.2), {BackgroundTransparency = 0.3}):Play()
end)

arrowButton.MouseLeave:Connect(function()
    TweenService:Create(arrowButton, TweenInfo.new(0.2), {BackgroundTransparency = 0.6}):Play()
end)

getCurrentElements()

wait(7)
loadstring(game:HttpGet("https://akadmin-bzk.pages.dev/akqueu.lua"))()

