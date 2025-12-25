local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Player = Players.LocalPlayer
local Character, Humanoid, RootPart
local Camera = workspace.CurrentCamera
local IsVoiding = false

-- Prevent objects from being destroyed by the void
workspace.FallenPartsDestroyHeight = math.huge * -1

-- Create Main GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local TitleBar = Instance.new("Frame")
local TitleCorner = Instance.new("UICorner")
local TitleLabel = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local CloseCorner = Instance.new("UICorner")
local Method1Button = Instance.new("TextButton")
local Method1Corner = Instance.new("UICorner")
local Method2Button = Instance.new("TextButton")
local Method2Corner = Instance.new("UICorner")

ScreenGui.Parent = Player:WaitForChild("PlayerGui")
ScreenGui.Name = "VoidGui"
ScreenGui.ResetOnSpawn = false

-- Main Frame Setup
MainFrame.Parent = ScreenGui
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 180, 0, 100)
MainFrame.Position = UDim2.new(0.5, -90, 0.5, -50)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BackgroundTransparency = 0.6
MainFrame.BorderSizePixel = 0

UICorner.Parent = MainFrame
UICorner.CornerRadius = UDim.new(0, 12)

-- Title Bar (Completely Invisible)
TitleBar.Parent = MainFrame
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 25)
TitleBar.BackgroundTransparency = 1
TitleBar.BorderSizePixel = 0

TitleCorner.Parent = TitleBar
TitleCorner.CornerRadius = UDim.new(0, 12)

TitleLabel.Parent = TitleBar
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Anti All"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.Arial
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Center

-- Close Button
CloseButton.Parent = TitleBar
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Position = UDim2.new(1, -23, 0, 2.5)
CloseButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
CloseButton.BackgroundTransparency = 0.5
CloseButton.BorderSizePixel = 0
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.Arial
CloseButton.TextSize = 16

CloseCorner.Parent = CloseButton
CloseCorner.CornerRadius = UDim.new(0, 6)

-- Method 1 Button (Void Method)
Method1Button.Parent = MainFrame
Method1Button.Name = "Method1Button"
Method1Button.Size = UDim2.new(0, 160, 0, 28)
Method1Button.Position = UDim2.new(0, 10, 0, 32)
Method1Button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Method1Button.BackgroundTransparency = 0.7
Method1Button.BorderSizePixel = 0
Method1Button.Text = "Method 1"
Method1Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Method1Button.Font = Enum.Font.Arial
Method1Button.TextSize = 14

Method1Corner.Parent = Method1Button
Method1Corner.CornerRadius = UDim.new(0, 8)

-- Method 2 Button
Method2Button.Parent = MainFrame
Method2Button.Name = "Method2Button"
Method2Button.Size = UDim2.new(0, 160, 0, 28)
Method2Button.Position = UDim2.new(0, 10, 0, 65)
Method2Button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Method2Button.BackgroundTransparency = 0.7
Method2Button.BorderSizePixel = 0
Method2Button.Text = "Method 2"
Method2Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Method2Button.Font = Enum.Font.Arial
Method2Button.TextSize = 14

Method2Corner.Parent = Method2Button
Method2Corner.CornerRadius = UDim.new(0, 8)

-- Dragging System (Works for PC and Mobile)
local dragging = false
local dragInput, dragStart, startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateInput(input)
    end
end)

-- Close Button Function
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Method 1: Void Teleport Function
local function VoidTeleport()
    workspace.Camera.CameraType = Enum.CameraType.Fixed
    local HRoot = Player.Character.Humanoid.RootPart
    local Pos = HRoot.CFrame
    HRoot.CFrame = Pos + Vector3.new(0, -1e3, 0)
    task.wait(0.5)
    HRoot.CFrame = Pos
    workspace.Camera.CameraType = Enum.CameraType.Custom
end

local function Method1()
    Character = Player.Character
    Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid")
    RootPart = Humanoid and Humanoid.RootPart
    
    if RootPart and Humanoid and not IsVoiding then
        IsVoiding = true
        VoidTeleport()
        task.wait(0.5)
        IsVoiding = false
    end
end

-- Method 2: Teleport to Specific Position and Fling
local function Method2()
    Character = Player.Character
    Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid")
    RootPart = Humanoid and Humanoid.RootPart
    
    if RootPart and Humanoid and not IsVoiding then
        IsVoiding = true
        workspace.Camera.CameraType = Enum.CameraType.Fixed
        
        -- Teleport to extremely far position
        RootPart.CFrame = CFrame.new(-999999999, 999999999, -999999999)
        task.wait(0.1)
        
        -- Create ABSOLUTELY INSANE fling force with loop until death
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Parent = RootPart
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        
        local flingLoop = RunService.Heartbeat:Connect(function()
            if not Character or not Character.Parent or Humanoid.Health <= 0 then
                flingLoop:Disconnect()
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
                workspace.Camera.CameraType = Enum.CameraType.Custom
                IsVoiding = false
                return
            end
            
            -- Apply ABSOLUTELY MAXIMUM strength random velocity every frame
            bodyVelocity.Velocity = Vector3.new(
                math.random(-9999999999, 9999999999),
                math.random(9999999999, 99999999999),
                math.random(-9999999999, 9999999999)
            )
        end)
    end
end

-- Fix camera on respawn
Player.CharacterAdded:Connect(function(newCharacter)
    workspace.Camera.CameraType = Enum.CameraType.Custom
    IsVoiding = false
    Character = newCharacter
    Humanoid = newCharacter:WaitForChild("Humanoid")
    RootPart = newCharacter:WaitForChild("HumanoidRootPart")
end)

-- Method 1 Button Click
Method1Button.MouseButton1Click:Connect(Method1)

-- Method 2 Button Click
Method2Button.MouseButton1Click:Connect(Method2)
