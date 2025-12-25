-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Player References
local LocalPlayer = Players.LocalPlayer

-- State Variables
local State = {
    FlingAll = false,
    Spectate = false,
    Targets = {},
    SavedPosition = nil,
    SavedCamera = nil
}

-- UI Configuration
local Config = {
    Colors = {
        Background = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.7,
        ButtonTransparency = 0.6,
        ButtonNormal = Color3.fromRGB(0, 0, 0),
        ButtonSelected = Color3.fromRGB(80, 80, 80),
        TextColor = Color3.fromRGB(255, 255, 255)
    }
}

-- Create Screen GUI
local function createScreenGui()
    local screenGui = Instance.new("ScreenGui")
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Name = "FlingUI"
    
    if RunService:IsStudio() then
        screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    else
        screenGui.Parent = game:GetService("CoreGui")
    end
    
    return screenGui
end

-- Make Frame Draggable (PC and Mobile)
local function makeDraggable(frame)
    local dragging = false
    local dragInput, dragStart, startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
    
    frame.InputBegan:Connect(function(input)
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
    
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- Create Main UI Frame
local function createMainUI(parent)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 220, 0, 340)
    frame.Position = UDim2.new(0.5, -110, 0.5, -170)
    frame.BackgroundColor3 = Config.Colors.Background
    frame.BackgroundTransparency = Config.Colors.BackgroundTransparency
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    -- AK ADMIN Label (Top Left)
    local adminLabel = Instance.new("TextLabel")
    adminLabel.Size = UDim2.new(0, 70, 0, 15)
    adminLabel.Position = UDim2.new(0, 8, 0, 6)
    adminLabel.BackgroundTransparency = 1
    adminLabel.Text = "AK ADMIN"
    adminLabel.TextColor3 = Config.Colors.TextColor
    adminLabel.Font = Enum.Font.GothamBold
    adminLabel.TextSize = 8
    adminLabel.TextXAlignment = Enum.TextXAlignment.Left
    adminLabel.Parent = frame
    
    -- Close Button (Top Right)
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 18, 0, 18)
    closeBtn.Position = UDim2.new(1, -24, 0, 5)
    closeBtn.BackgroundColor3 = Config.Colors.ButtonNormal
    closeBtn.BackgroundTransparency = Config.Colors.ButtonTransparency
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Config.Colors.TextColor
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 11
    closeBtn.BorderSizePixel = 0
    closeBtn.Parent = frame
    
    local closeBtnCorner = Instance.new("UICorner")
    closeBtnCorner.CornerRadius = UDim.new(0, 4)
    closeBtnCorner.Parent = closeBtn
    
    -- FLING Title (Center)
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 22)
    title.Position = UDim2.new(0, 0, 0, 24)
    title.BackgroundTransparency = 1
    title.Text = "FLING"
    title.TextColor3 = Config.Colors.TextColor
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.Parent = frame
    
    -- Button Container
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Size = UDim2.new(1, -16, 0, 32)
    buttonContainer.Position = UDim2.new(0, 8, 0, 50)
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.Parent = frame
    
    -- Fling All Button
    local flingAllBtn = Instance.new("TextButton")
    flingAllBtn.Size = UDim2.new(0.5, -2, 1, 0)
    flingAllBtn.Position = UDim2.new(0, 0, 0, 0)
    flingAllBtn.BackgroundColor3 = Config.Colors.ButtonNormal
    flingAllBtn.BackgroundTransparency = Config.Colors.ButtonTransparency
    flingAllBtn.Text = "ALL: OFF"
    flingAllBtn.TextColor3 = Config.Colors.TextColor
    flingAllBtn.Font = Enum.Font.GothamBold
    flingAllBtn.TextSize = 11
    flingAllBtn.BorderSizePixel = 0
    flingAllBtn.Parent = buttonContainer
    
    local flingAllCorner = Instance.new("UICorner")
    flingAllCorner.CornerRadius = UDim.new(0, 6)
    flingAllCorner.Parent = flingAllBtn
    
    -- Spectate Button
    local spectateBtn = Instance.new("TextButton")
    spectateBtn.Size = UDim2.new(0.5, -2, 1, 0)
    spectateBtn.Position = UDim2.new(0.5, 2, 0, 0)
    spectateBtn.BackgroundColor3 = Config.Colors.ButtonNormal
    spectateBtn.BackgroundTransparency = Config.Colors.ButtonTransparency
    spectateBtn.Text = "SPECTATE: OFF"
    spectateBtn.TextColor3 = Config.Colors.TextColor
    spectateBtn.Font = Enum.Font.GothamBold
    spectateBtn.TextSize = 10
    spectateBtn.BorderSizePixel = 0
    spectateBtn.Parent = buttonContainer
    
    local spectateCorner = Instance.new("UICorner")
    spectateCorner.CornerRadius = UDim.new(0, 6)
    spectateCorner.Parent = spectateBtn
    
    -- Player List Title
    local playerListTitle = Instance.new("TextLabel")
    playerListTitle.Size = UDim2.new(1, 0, 0, 18)
    playerListTitle.Position = UDim2.new(0, 0, 0, 86)
    playerListTitle.BackgroundTransparency = 1
    playerListTitle.Text = "PLAYERS"
    playerListTitle.TextColor3 = Config.Colors.TextColor
    playerListTitle.Font = Enum.Font.GothamBold
    playerListTitle.TextSize = 11
    playerListTitle.Parent = frame
    
    -- Scrolling Frame for Players
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -16, 1, -112)
    scrollFrame.Position = UDim2.new(0, 8, 0, 104)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 3
    scrollFrame.ScrollBarImageColor3 = Config.Colors.TextColor
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.Parent = frame
    
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.Name
    layout.Padding = UDim.new(0, 4)
    layout.Parent = scrollFrame
    
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 4)
    end)
    
    makeDraggable(frame)
    
    return {
        Frame = frame,
        CloseButton = closeBtn,
        FlingAllButton = flingAllBtn,
        SpectateButton = spectateBtn,
        ScrollFrame = scrollFrame,
        Layout = layout
    }
end

-- Create Player Entry
local function createPlayerEntry(player, parent)
    local entry = Instance.new("Frame")
    entry.Size = UDim2.new(1, 0, 0, 36)
    entry.BackgroundColor3 = Config.Colors.ButtonNormal
    entry.BackgroundTransparency = Config.Colors.ButtonTransparency
    entry.BorderSizePixel = 0
    entry.Name = tostring(player.UserId)
    entry.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = entry
    
    -- Make entire entry clickable for targeting
    local selectBtn = Instance.new("TextButton")
    selectBtn.Size = UDim2.new(1, 0, 1, 0)
    selectBtn.Position = UDim2.new(0, 0, 0, 0)
    selectBtn.BackgroundTransparency = 1
    selectBtn.Text = ""
    selectBtn.Parent = entry
    
    -- Thumbnail
    local thumb = Instance.new("ImageLabel")
    thumb.Size = UDim2.new(0, 26, 0, 26)
    thumb.Position = UDim2.new(0, 5, 0.5, -13)
    thumb.BackgroundTransparency = 1
    thumb.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
    thumb.Parent = entry
    
    local thumbCorner = Instance.new("UICorner")
    thumbCorner.CornerRadius = UDim.new(1, 0)
    thumbCorner.Parent = thumb
    
    -- Name Label
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, -40, 1, 0)
    nameLabel.Position = UDim2.new(0, 36, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = Config.Colors.TextColor
    nameLabel.Font = Enum.Font.GothamMedium
    nameLabel.TextSize = 10
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.TextTruncate = Enum.TextTruncate.AtEnd
    nameLabel.Parent = entry
    
    return {
        Entry = entry,
        SelectButton = selectBtn
    }
end

-- Fling Function
local function flingPlayer(target)
    local char = LocalPlayer.Character
    if not char then return end
    
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    
    local root = humanoid.RootPart
    if not root then return end
    
    local targetChar = target.Character
    if not targetChar then return end
    
    local targetHum = targetChar:FindFirstChildOfClass("Humanoid")
    if not targetHum then return end
    
    local targetRoot = targetHum.RootPart
    local targetHead = targetChar:FindFirstChild("Head")
    
    if not targetRoot and not targetHead then return end
    
    local function applyFling(part)
        root.CFrame = CFrame.new(part.Position) * CFrame.new(0, 1.5, 0)
        root.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
    end
    
    local function executeFling(part)
        local startTime = tick()
        local duration = 0.134
        
        workspace.FallenPartsDestroyHeight = 0/0
        
        local bodyvelocity = Instance.new("BodyVelocity")
        bodyvelocity.Velocity = Vector3.new(-9e99, 9e99, -9e99)
        bodyvelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bodyvelocity.Parent = root
        
        repeat
            if part and part.Parent and root and root.Parent then
                if part.Velocity.Magnitude < 30 then
                    applyFling(part)
                    RunService.Heartbeat:Wait()
                else
                    root.CFrame = CFrame.new(part.Position) * CFrame.new(0, -1.5, 0)
                    RunService.Heartbeat:Wait()
                end
            else
                break
            end
        until part.Velocity.Magnitude > 1000 or 
              tick() > startTime + duration or 
              (#State.Targets == 0 and not State.FlingAll) or
              not targetChar.Parent or
              not char.Parent or
              humanoid.Health <= 0
        
        bodyvelocity:Destroy()
        
        if State.SavedPosition and root then
            root.CFrame = State.SavedPosition
        end
        
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Velocity = Vector3.new()
                part.RotVelocity = Vector3.new()
            end
        end
        
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end
    
    if targetRoot and targetHead then
        if (targetRoot.Position - targetHead.Position).Magnitude > 5 then
            executeFling(targetHead)
        else
            executeFling(targetRoot)
        end
    elseif targetRoot then
        executeFling(targetRoot)
    elseif targetHead then
        executeFling(targetHead)
    end
end

-- Main Loop
local function startFlingLoop()
    coroutine.wrap(function()
        while #State.Targets > 0 or State.FlingAll do
            task.wait()
            pcall(function()
                if #State.Targets > 0 then
                    for _, target in ipairs(State.Targets) do
                        if target and target.Parent and target.Character then
                            local humanoid = target.Character:FindFirstChildOfClass("Humanoid")
                            local root = humanoid and humanoid.RootPart
                            
                            if root and not humanoid.Sit and root.Velocity.Magnitude < 30 then
                                flingPlayer(target)
                            end
                        end
                    end
                elseif State.FlingAll then
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character then
                            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                            local root = humanoid and humanoid.RootPart
                            
                            if root and not humanoid.Sit and root.Velocity.Magnitude < 30 then
                                flingPlayer(player)
                            end
                        end
                    end
                end
            end)
        end
    end)()
end

-- Camera Control
local function updateCamera()
    RunService.RenderStepped:Connect(function()
        if State.Spectate and #State.Targets > 0 then
            for _, player in ipairs(State.Targets) do
                if player and player.Parent and player.Character then
                    local head = player.Character:FindFirstChild("Head")
                    if head then
                        workspace.CurrentCamera.CameraSubject = head
                        break
                    end
                end
            end
        else
            if LocalPlayer.Character then
                local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    workspace.CurrentCamera.CameraSubject = humanoid
                end
            end
        end
    end)
end

-- Initialize UI
local ScreenGui = createScreenGui()
local MainUI = createMainUI(ScreenGui)

-- Player Entry Management
local playerEntries = {}

-- Event Connections
MainUI.CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

MainUI.FlingAllButton.MouseButton1Click:Connect(function()
    State.FlingAll = not State.FlingAll
    
    if State.FlingAll then
        State.Targets = {}
        
        for _, entry in pairs(playerEntries) do
            entry.Entry.BackgroundColor3 = Config.Colors.ButtonNormal
        end
        
        local char = LocalPlayer.Character
        if char then
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                State.SavedPosition = root.CFrame
                State.SavedCamera = workspace.CurrentCamera.CFrame
            end
        end
        
        MainUI.FlingAllButton.Text = "ALL: ON"
        MainUI.FlingAllButton.BackgroundColor3 = Config.Colors.ButtonSelected
        startFlingLoop()
    else
        task.wait(0.1)
        
        local char = LocalPlayer.Character
        if State.SavedPosition and char then
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                root.CFrame = State.SavedPosition
            end
        end
        
        if State.SavedCamera then
            workspace.CurrentCamera.CFrame = State.SavedCamera
        end
        
        MainUI.FlingAllButton.Text = "ALL: OFF"
        MainUI.FlingAllButton.BackgroundColor3 = Config.Colors.ButtonNormal
    end
end)

MainUI.SpectateButton.MouseButton1Click:Connect(function()
    State.Spectate = not State.Spectate
    
    if State.Spectate then
        MainUI.SpectateButton.Text = "SPECTATE: ON"
        MainUI.SpectateButton.BackgroundColor3 = Config.Colors.ButtonSelected
    else
        MainUI.SpectateButton.Text = "SPECTATE: OFF"
        MainUI.SpectateButton.BackgroundColor3 = Config.Colors.ButtonNormal
        
        if LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                workspace.CurrentCamera.CameraSubject = humanoid
            end
        end
    end
end)

-- Clean up when player leaves
Players.PlayerRemoving:Connect(function(player)
    if playerEntries[player] then
        playerEntries[player].Entry:Destroy()
        playerEntries[player] = nil
    end
    
    local idx = table.find(State.Targets, player)
    if idx then
        table.remove(State.Targets, idx)
    end
end)

-- Add new player when they join
Players.PlayerAdded:Connect(function(player)
    if player == LocalPlayer then return end
    
    task.wait(1)
    
    if not playerEntries[player] then
        local entry = createPlayerEntry(player, MainUI.ScrollFrame)
        playerEntries[player] = entry
        
        entry.SelectButton.MouseButton1Click:Connect(function()
            local idx = table.find(State.Targets, player)
            if idx then
                table.remove(State.Targets, idx)
                entry.Entry.BackgroundColor3 = Config.Colors.ButtonNormal
                
                if #State.Targets == 0 then
                    task.wait(0.1)
                    local char = LocalPlayer.Character
                    if State.SavedPosition and char then
                        local root = char:FindFirstChild("HumanoidRootPart")
                        if root then
                            root.CFrame = State.SavedPosition
                        end
                    end
                    
                    if State.SavedCamera then
                        workspace.CurrentCamera.CFrame = State.SavedCamera
                    end
                end
            else
                table.insert(State.Targets, player)
                entry.Entry.BackgroundColor3 = Config.Colors.ButtonSelected
                
                if #State.Targets == 1 then
                    local char = LocalPlayer.Character
                    if char then
                        local root = char:FindFirstChild("HumanoidRootPart")
                        if root then
                            State.SavedPosition = root.CFrame
                            State.SavedCamera = workspace.CurrentCamera.CFrame
                        end
                    end
                    startFlingLoop()
                end
            end
        end)
    end
end)

-- Initialize - only once at start
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer and not playerEntries[player] then
        local entry = createPlayerEntry(player, MainUI.ScrollFrame)
        playerEntries[player] = entry
        
        entry.SelectButton.MouseButton1Click:Connect(function()
            local idx = table.find(State.Targets, player)
            if idx then
                table.remove(State.Targets, idx)
                entry.Entry.BackgroundColor3 = Config.Colors.ButtonNormal
                
                if #State.Targets == 0 then
                    task.wait(0.1)
                    local char = LocalPlayer.Character
                    if State.SavedPosition and char then
                        local root = char:FindFirstChild("HumanoidRootPart")
                        if root then
                            root.CFrame = State.SavedPosition
                        end
                    end
                    
                    if State.SavedCamera then
                        workspace.CurrentCamera.CFrame = State.SavedCamera
                    end
                end
            else
                table.insert(State.Targets, player)
                entry.Entry.BackgroundColor3 = Config.Colors.ButtonSelected
                
                if #State.Targets == 1 then
                    local char = LocalPlayer.Character
                    if char then
                        local root = char:FindFirstChild("HumanoidRootPart")
                        if root then
                            State.SavedPosition = root.CFrame
                            State.SavedCamera = workspace.CurrentCamera.CFrame
                        end
                    end
                    startFlingLoop()
                end
            end
        end)
    end
end

updateCamera()
