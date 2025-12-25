local plrs = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local sg = game:GetService("StarterGui")

local localPlayer = plrs.LocalPlayer
local cam = workspace.CurrentCamera
local locked = false
local shiftDown = false

local imgOff = "http://www.roblox.com/asset/?id = 115666586415476"
local imgOn = "http://www.roblox.com/asset/?id = 135221094902079"

local function makeButton()
    pcall(function()
        sg:SetCore("TopbarEnabled", true)
    end)
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ShiftLockGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game:GetService("CoreGui")
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 100, 0, 100)
    frame.Position = UDim2.new(0.8, 0, 0.7, 0)
    frame.BackgroundTransparency = 1
    frame.Parent = screenGui
    
    local imagebutton = Instance.new("ImageButton")
    imagebutton.Size = UDim2.new(1, 0, 1, 0)
    imagebutton.Position = UDim2.new(0, 0, 0, 0)
    imagebutton.BackgroundColor3 = locked and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(30, 30, 30)
    imagebutton.AutoButtonColor = false
    imagebutton.BorderSizePixel = 0
    imagebutton.BackgroundTransparency = 1
    imagebutton.Parent = frame
    

    
    local round = Instance.new("UICorner")
    round.CornerRadius = UDim.new(1, 0)
    round.Parent = imagebutton
    
    local outline = Instance.new("UIStroke")
    outline.Color = Color3.fromRGB(255, 255, 255)
    outline.Transparency =1
    outline.Thickness = 1
    outline.Parent = imagebutton
    
    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0.6, 0, 0.6, 0)
    icon.Position = UDim2.new(0.2, 0, 0.2, 0)
    icon.Image = locked and imgOn or imgOff
    icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    icon.BackgroundTransparency = 1
    icon.Parent = imagebutton
    
    local glow = Instance.new("ImageLabel")
    glow.Size = UDim2.new(0.9, 0, 0.9, 0)
    glow.Position = UDim2.new(0.05, 0, 0.05, 0)
    glow.Image = ""
    glow.ImageColor3 = Color3.fromRGB(255, 255, 255)
    glow.ImageTransparency = locked and 0.7 or 0.9
    glow.BackgroundTransparency = 1
    glow.ZIndex = -1
    glow.Parent = imagebutton
    
    local tweenClick = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    local tweenSpin = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    
    local function toggle()
        locked = not locked
        local newImg = locked and imgOn or imgOff
        icon.Image = newImg
    end
    

    
    local function rotateChar(humanoid)
        if locked and humanoid then
            local lookDir = cam.CFrame.LookVector
            local flatDir = Vector3.new(lookDir.X, 0, lookDir.Z).Unit
            local targetPos = humanoid.Position + flatDir
            humanoid.CFrame = CFrame.new(humanoid.Position, targetPos)
        end
    end
    
    local function updateFrame()
        local char = localPlayer.Character
        if char then
            local humanoid = char:FindFirstChild("HumanoidRootPart")
            rotateChar(humanoid)
        end
    end
    
    imagebutton.MouseButton1Click:Connect(toggle)
    
    userInputService.InputBegan:Connect(function(input, processed)
        if not processed and input.KeyCode == Enum.KeyCode.LeftShift and not shiftDown then
            shiftDown = true
            toggle()
        end
    end)

    userInputService.InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.LeftShift then
            shiftDown = false
        end
    end)
    
    runService.RenderStepped:Connect(updateFrame)
end

makeButton()

localPlayer.CharacterAdded:Connect(function()
    shiftDown = false
    wait(1)
    makeButton()
end)
