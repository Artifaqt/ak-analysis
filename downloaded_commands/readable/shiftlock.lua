local plrs = game:GetService("Players")
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local ts = game:GetService("TweenService")
local sg = game:GetService("StarterGui")

local plr = plrs.LocalPlayer
local cam = workspace.CurrentCamera
local locked = false
local shiftDown = false

local imgOff = "http://www.roblox.com/asset/?id=115666586415476"
local imgOn = "http://www.roblox.com/asset/?id=135221094902079"

local function makeButton()
    pcall(function()
        sg:SetCore("TopbarEnabled", true)
    end)
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "ShiftLockGui"
    gui.ResetOnSpawn = false
    gui.Parent = game:GetService("CoreGui")
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 100, 0, 100)
    frame.Position = UDim2.new(0.8, 0, 0.7, 0)
    frame.BackgroundTransparency = 1
    frame.Parent = gui
    
    local btn = Instance.new("ImageButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.Position = UDim2.new(0, 0, 0, 0)
    btn.BackgroundColor3 = locked and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(30, 30, 30)
    btn.AutoButtonColor = false
    btn.BorderSizePixel = 0
    btn.BackgroundTransparency = 1
    btn.Parent = frame
    

    
    local round = Instance.new("UICorner")
    round.CornerRadius = UDim.new(1, 0)
    round.Parent = btn
    
    local outline = Instance.new("UIStroke")
    outline.Color = Color3.fromRGB(255, 255, 255)
    outline.Transparency =1
    outline.Thickness = 1
    outline.Parent = btn
    
    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0.6, 0, 0.6, 0)
    icon.Position = UDim2.new(0.2, 0, 0.2, 0)
    icon.Image = locked and imgOn or imgOff
    icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    icon.BackgroundTransparency = 1
    icon.Parent = btn
    
    local glow = Instance.new("ImageLabel")
    glow.Size = UDim2.new(0.9, 0, 0.9, 0)
    glow.Position = UDim2.new(0.05, 0, 0.05, 0)
    glow.Image = ""
    glow.ImageColor3 = Color3.fromRGB(255, 255, 255)
    glow.ImageTransparency = locked and 0.7 or 0.9
    glow.BackgroundTransparency = 1
    glow.ZIndex = -1
    glow.Parent = btn
    
    local tweenClick = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    local tweenSpin = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    
    local function toggle()
        locked = not locked
        local newImg = locked and imgOn or imgOff
        icon.Image = newImg
    end
    

    
    local function rotateChar(hrp)
        if locked and hrp then
            local lookDir = cam.CFrame.LookVector
            local flatDir = Vector3.new(lookDir.X, 0, lookDir.Z).Unit
            local targetPos = hrp.Position + flatDir
            hrp.CFrame = CFrame.new(hrp.Position, targetPos)
        end
    end
    
    local function updateFrame()
        local char = plr.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            rotateChar(hrp)
        end
    end
    
    btn.MouseButton1Click:Connect(toggle)
    
    uis.InputBegan:Connect(function(input, processed)
        if not processed and input.KeyCode == Enum.KeyCode.LeftShift and not shiftDown then
            shiftDown = true
            toggle()
        end
    end)

    uis.InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.LeftShift then
            shiftDown = false
        end
    end)
    
    rs.RenderStepped:Connect(updateFrame)
end

makeButton()

plr.CharacterAdded:Connect(function()
    shiftDown = false
    wait(1)
    makeButton()
end)
