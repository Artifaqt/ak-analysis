local players = game:GetService("Players")
local runservice = game:GetService("RunService")
local userinputservice = game:GetService("UserInputService")
local localPlayer = players.LocalPlayer
local flag = true
local flag2 = false
local flag3 = false
local flag4 = false

local function Cb()
    local part = Instance.new("Part")
    part.Name = "InvisibleBaseplate"
    part.Size = Vector3.new(math.huge, 1, math.huge)
    part.Position = Vector3.new(0, 0, 0)
    part.Transparency = 1
    part.Anchored = true
    part.CanCollide = true
    part.Material = Enum.Material.Neon
    part.Color = Color3.fromRGB(70, 200, 255)
    part.Parent = workspace
    return part
end

local part = Cb()

local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local corner = Instance.new("UICorner")
local frame2 = Instance.new("Frame")
local corner2 = Instance.new("UICorner")
local textLabel = Instance.new("TextLabel")
local button = Instance.new("TextButton")
local corner3 = Instance.new("UICorner")
local button2 = Instance.new("TextButton")
local corner4 = Instance.new("UICorner")
local button3 = Instance.new("TextButton")
local corner5 = Instance.new("UICorner")
local button4 = Instance.new("TextButton")
local corner6 = Instance.new("UICorner")
local button5 = Instance.new("TextButton")
local corner7 = Instance.new("UICorner")

screenGui.Parent = localPlayer:WaitForChild("PlayerGui")
screenGui.Name = "AirwalkGui"
screenGui.ResetOnSpawn = false

frame.Parent = screenGui
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 240, 0, 100)
frame.Position = UDim2.new(1, -250, 1, -110)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.6
frame.BorderSizePixel = 0

corner.Parent = frame
corner.CornerRadius = UDim.new(0, 12)

frame2.Parent = frame
frame2.Name = "TitleBar"
frame2.Size = UDim2.new(1, 0, 0, 25)
frame2.BackgroundTransparency = 1
frame2.BorderSizePixel = 0

corner2.Parent = frame2
corner2.CornerRadius = UDim.new(0, 12)

local textLabel2 = Instance.new("TextLabel")

textLabel2.Parent = frame2
textLabel2.Size = UDim2.new(0, 80, 1, 0)
textLabel2.Position = UDim2.new(0, 5, 0, 0)
textLabel2.BackgroundTransparency = 1
textLabel2.Text = "AK ADMIN"
textLabel2.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel2.Font = Enum.Font.Arial
textLabel2.TextSize = 10
textLabel2.TextXAlignment = Enum.TextXAlignment.Left

textLabel.Parent = frame2
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.Position = UDim2.new(0, 0, 0, 0)
textLabel.BackgroundTransparency = 1
textLabel.Text = "Walk on Air"
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.Font = Enum.Font.Arial
textLabel.TextSize = 16
textLabel.TextXAlignment = Enum.TextXAlignment.Center

button.Parent = frame2
button.Name = "CloseButton"
button.Size = UDim2.new(0, 20, 0, 20)
button.Position = UDim2.new(1, -23, 0, 2.5)
button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
button.BackgroundTransparency = 0.5
button.BorderSizePixel = 0
button.Text = "×"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.Arial
button.TextSize = 16

corner3.Parent = button
corner3.CornerRadius = UDim.new(0, 6)

button2.Parent = frame
button2.Name = "OnOffButton"
button2.Size = UDim2.new(0, 65, 0, 28)
button2.Position = UDim2.new(0, 10, 0, 32)
button2.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
button2.BackgroundTransparency = 0.7
button2.BorderSizePixel = 0
button2.Text = "ON"
button2.TextColor3 = Color3.fromRGB(255, 255, 255)
button2.Font = Enum.Font.Arial
button2.TextSize = 14

corner4.Parent = button2
corner4.CornerRadius = UDim.new(0, 8)

button3.Parent = frame
button3.Name = "UpButton"
button3.Size = UDim2.new(0, 65, 0, 28)
button3.Position = UDim2.new(0, 85, 0, 32)
button3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
button3.BackgroundTransparency = 0.7
button3.BorderSizePixel = 0
button3.Text = "▲"
button3.TextColor3 = Color3.fromRGB(255, 255, 255)
button3.Font = Enum.Font.Arial
button3.TextSize = 14

corner5.Parent = button3
corner5.CornerRadius = UDim.new(0, 8)

button4.Parent = frame
button4.Name = "DownButton"
button4.Size = UDim2.new(0, 65, 0, 28)
button4.Position = UDim2.new(0, 160, 0, 32)
button4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
button4.BackgroundTransparency = 0.7
button4.BorderSizePixel = 0
button4.Text = "▼"
button4.TextColor3 = Color3.fromRGB(255, 255, 255)
button4.Font = Enum.Font.Arial
button4.TextSize = 14

corner6.Parent = button4
corner6.CornerRadius = UDim.new(0, 8)

button5.Parent = frame
button5.Name = "VisibilityButton"
button5.Size = UDim2.new(0, 220, 0, 28)
button5.Position = UDim2.new(0, 10, 0, 65)
button5.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
button5.BackgroundTransparency = 0.7
button5.BorderSizePixel = 0
button5.Text = "Show Platform"
button5.TextColor3 = Color3.fromRGB(255, 255, 255)
button5.Font = Enum.Font.Arial
button5.TextSize = 14

corner7.Parent = button5
corner7.CornerRadius = UDim.new(0, 8)

local flag = false
local di, ds, sp

local function Ud(input)
    local dt = input.Position - ds
    frame.Position = UDim2.new(
        sp.X.Scale,
        sp.X.Offset + dt.X,
        sp.Y.Scale,
        sp.Y.Offset + dt.Y
    )
end

frame2.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        flag = true
        ds = input.Position
        sp = frame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                flag = false
            end
        end)
    end
end)

frame2.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        di = input
    end
end)

userinputservice.InputChanged:Connect(function(input)
    if input == di and flag then
        Ud(input)
    end
end)

button.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

local function Rp()
    local character = localPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("HumanoidRootPart")
        if humanoid then
            part.Position = Vector3.new(
                humanoid.Position.X,
                part.Position.Y,
                humanoid.Position.Z
            )
        end
    end
end

local function Tv()
    flag2 = not flag2
    part.Transparency = flag2 and 0.3 or 1
    
    if flag2 then
        part.Material = Enum.Material.Neon
        button5.Text = "Hide Platform"
    else
        part.Material = Enum.Material.SmoothPlastic
        button5.Text = "Show Platform"
    end
end

local function Ta()
    flag = not flag
    if flag then
        button2.Text = "ON"
        button2.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        if not part:IsDescendantOf(workspace) then
            part = Cb()
        end
    else
        button2.Text = "OFF"
        button2.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        part:Destroy()
    end
end

runservice.Heartbeat:Connect(function()
    if flag3 then
        part.Position = part.Position + Vector3.new(0, 0.5, 0)
    elseif flag4 then
        part.Position = part.Position - Vector3.new(0, 0.5, 0)
    end
end)

button2.MouseButton1Click:Connect(Ta)
button5.MouseButton1Click:Connect(Tv)

button3.MouseButton1Down:Connect(function() flag3 = true end)
button3.MouseButton1Up:Connect(function() flag3 = false end)
button3.MouseLeave:Connect(function() flag3 = false end)

button4.MouseButton1Down:Connect(function() flag4 = true end)
button4.MouseButton1Up:Connect(function() flag4 = false end)
button4.MouseLeave:Connect(function() flag4 = false end)

runservice.Heartbeat:Connect(function()
    local character = localPlayer.Character
    if character and flag then
        local humanoid = character:FindFirstChild("HumanoidRootPart")
        if humanoid then
            part.Position = Vector3.new(
                humanoid.Position.X,
                part.Position.Y,
                humanoid.Position.Z
            )
        end
    end
end)

Rp()

localPlayer.CharacterAdded:Connect(function(character)
    wait(0.5)
    Rp()
end)

screenGui.DescendantRemoving:Connect(function(descendant)
    if descendant == frame then
        frame.Parent = screenGui
    end
end)
