-- R6 Avatar Save Script
local players = game:GetService("Players")
local avatar_editor_service = game:GetService("AvatarEditorService")
local tween_service = game:GetService("TweenService")
local self = players.LocalPlayer

-- Function to create notification GUI
local function createNotification(message)
    local player_gui = self:WaitForChild("PlayerGui")
    
    -- Create ScreenGui
    local screen_gui = Instance.new("ScreenGui")
    screen_gui.Name = "NotificationGui"
    screen_gui.ResetOnSpawn = false
    screen_gui.Parent = player_gui
    
    -- Create main frame
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 350, 0, 100)
    frame.Position = UDim2.new(0.5, -175, 0, -120)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent = screen_gui
    
    -- Create rounded corners
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame
    
    -- Create title label
    local title_label = Instance.new("TextLabel")
    title_label.Size = UDim2.new(0, 80, 0, 20)
    title_label.Position = UDim2.new(1, -90, 0, 5)
    title_label.BackgroundTransparency = 1
    title_label.Text = "AK ADMIN"
    title_label.TextColor3 = Color3.fromRGB(255, 255, 255)
    title_label.TextSize = 12
    title_label.Font = Enum.Font.GothamBold
    title_label.TextXAlignment = Enum.TextXAlignment.Right
    title_label.Parent = frame
    
    -- Create text label
    local text_label = Instance.new("TextLabel")
    text_label.Size = UDim2.new(1, -20, 1, -45)
    text_label.Position = UDim2.new(0, 10, 0, 35)
    text_label.BackgroundTransparency = 1
    text_label.Text = message
    text_label.TextColor3 = Color3.fromRGB(255, 255, 255)
    text_label.TextSize = 14
    text_label.Font = Enum.Font.Gotham
    text_label.TextWrapped = true
    text_label.TextXAlignment = Enum.TextXAlignment.Left
    text_label.TextYAlignment = Enum.TextYAlignment.Top
    text_label.Parent = frame
    
    -- Animate in
    local tween_in = tween_service:Create(
        frame,
        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Position = UDim2.new(0.5, -175, 0, 50)}
    )
    tween_in:Play()
    
    -- Wait and animate out
    wait(3)
    local tween_out = tween_service:Create(
        frame,
        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        {Position = UDim2.new(0.5, -175, 0, -120)}
    )
    tween_out:Play()
    
    tween_out.Completed:Connect(function()
        screen_gui:Destroy()
    end)
end

-- Check if PromptSaveAvatar is supported
if not avatar_editor_service.PromptSaveAvatar then
    createNotification("This feature only works on better executors like Volcano or Wave.")
    return
end

if self.Character and self.Character:FindFirstChildWhichIsA("Humanoid") then
    local humanoid = self.Character:FindFirstChildWhichIsA("Humanoid")
    
    local success, error_message = pcall(function()
        avatar_editor_service:PromptSaveAvatar(humanoid.HumanoidDescription, Enum.HumanoidRigType.R15)
    end)
    
    if not success then
        createNotification("This feature only works on better executors like Volcano or Wave.")
        return
    end
    
    if avatar_editor_service.PromptSaveAvatarCompleted:Wait() == Enum.AvatarPromptResult.Success then
        if self.Character then
            self.Character:BreakJoints()
        end
    end
end
