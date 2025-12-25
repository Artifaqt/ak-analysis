-- Compact Invisible Toggle GUI
-- Fixed rapid toggle issues with proper state management

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local speaker = LocalPlayer

-- Random string generator
local function randomString()
    local chars = {}
    for i = 1, math.random(10, 20) do
        chars[i] = string.char(math.random(32, 126))
    end
    return table.concat(chars)
end

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = randomString()
ScreenGui.ResetOnSpawn = false

-- Parent detection
if get_hidden_gui or gethui then
    ScreenGui.Parent = (get_hidden_gui or gethui)()
elseif syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
else
    ScreenGui.Parent = CoreGui
end

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = randomString()
MainFrame.Parent = ScreenGui
MainFrame.Active = true
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BackgroundTransparency = 0.7
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -50)
MainFrame.Size = UDim2.new(0, 200, 0, 100)
MainFrame.ZIndex = 10

-- Corner rounding
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 8)
Corner.Parent = MainFrame

-- Title
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 5)
Title.Size = UDim2.new(1, -40, 0, 20)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Invisible"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Center
Title.ZIndex = 11

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
CloseButton.BackgroundTransparency = 0.5
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -25, 0, 5)
CloseButton.Size = UDim2.new(0, 18, 0, 18)
CloseButton.Font = Enum.Font.SourceSans
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.TextSize = 10
CloseButton.ZIndex = 11

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 4)
CloseCorner.Parent = CloseButton

-- Minimize Button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = MainFrame
MinimizeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MinimizeButton.BackgroundTransparency = 0.5
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(1, -50, 0, 5)
MinimizeButton.Size = UDim2.new(0, 18, 0, 18)
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.Text = "−"
MinimizeButton.TextColor3 = Color3.new(1, 1, 1)
MinimizeButton.TextSize = 12
MinimizeButton.ZIndex = 11

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 4)
MinCorner.Parent = MinimizeButton

-- Toggle Button
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = MainFrame
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.BackgroundTransparency = 0.5
ToggleButton.BorderSizePixel = 0
ToggleButton.Position = UDim2.new(0, 10, 0, 35)
ToggleButton.Size = UDim2.new(0, 120, 0, 30)
ToggleButton.Font = Enum.Font.SourceSans
ToggleButton.Text = "Make Invisible"
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.TextSize = 12
ToggleButton.ZIndex = 11

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 6)
ToggleCorner.Parent = ToggleButton

-- Keybind Label
local KeybindLabel = Instance.new("TextLabel")
KeybindLabel.Name = "KeybindLabel"
KeybindLabel.Parent = MainFrame
KeybindLabel.BackgroundTransparency = 1
KeybindLabel.Position = UDim2.new(0, 135, 0, 25)
KeybindLabel.Size = UDim2.new(0, 55, 0, 10)
KeybindLabel.Font = Enum.Font.SourceSans
KeybindLabel.Text = "Keybind"
KeybindLabel.TextColor3 = Color3.new(1, 1, 1)
KeybindLabel.TextSize = 9
KeybindLabel.TextXAlignment = Enum.TextXAlignment.Center
KeybindLabel.ZIndex = 11

-- Keybind Button
local KeybindButton = Instance.new("TextButton")
KeybindButton.Name = "KeybindButton"
KeybindButton.Parent = MainFrame
KeybindButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
KeybindButton.BackgroundTransparency = 0.5
KeybindButton.BorderSizePixel = 0
KeybindButton.Position = UDim2.new(0, 135, 0, 35)
KeybindButton.Size = UDim2.new(0, 55, 0, 30)
KeybindButton.Font = Enum.Font.SourceSans
KeybindButton.Text = "None"
KeybindButton.TextColor3 = Color3.new(0.8, 0.8, 0.8)
KeybindButton.TextSize = 10
KeybindButton.ZIndex = 11

local KeybindCorner = Instance.new("UICorner")
KeybindCorner.CornerRadius = UDim.new(0, 4)
KeybindCorner.Parent = KeybindButton

-- Universal dragging system
local function makeDraggable(gui)
    local dragging = false
    local dragInput = nil
    local dragStart = nil
    local startPos = nil

    local function update(input)
        local delta = input.Position - dragStart
        local newPosition = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        TweenService:Create(gui, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = newPosition}):Play()
    end

    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    gui.InputChanged:Connect(function(input)
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

makeDraggable(MainFrame)

-- Minimize functionality
local isMinimized = false
local originalSize = UDim2.new(0, 200, 0, 70)

local function toggleMinimize()
    if isMinimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = originalSize}):Play()
        MinimizeButton.Text = "−"
        ToggleButton.Visible = true
        KeybindButton.Visible = true
        KeybindLabel.Visible = true
        isMinimized = false
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = UDim2.new(0, 200, 0, 30)}):Play()
        MinimizeButton.Text = "+"
        ToggleButton.Visible = false
        KeybindButton.Visible = false
        KeybindLabel.Visible = false
        isMinimized = true
    end
end

-- Keybind system
local currentKeybind = nil
local isBinding = false

local function setKeybind(key)
    currentKeybind = key
    KeybindButton.Text = key.Name
    KeybindButton.TextColor3 = Color3.new(1, 1, 1)
end

-- Notification system
local function notify(title, text)
    print("[" .. title .. "] " .. text)
end

-- Camera fix function
local function execCmd(cmd)
    if cmd == 'fixcam' then
        workspace.CurrentCamera.CameraSubject = LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
    end
end

-- Invisible system variables
local Player = speaker
local Character
local IsInvis = false
local IsRunning = true
local InvisibleCharacter
local Void
local CF
local invisFix
local invisDied
local invisRunning = false
local TurnVisible
local isToggling = false -- NEW: Prevent rapid toggling
local lastToggleTime = 0 -- NEW: Track last toggle time

-- FIXED INFINITE YIELD INVISIBLE FUNCTION
local function MakeInvisible()
    -- Prevent rapid toggling
    if isToggling or (tick() - lastToggleTime < 1) then 
        notify('Invisible', 'Please wait before toggling again')
        return 
    end
    
    isToggling = true
    lastToggleTime = tick()
    
    Player = speaker
    repeat wait(.1) until Player.Character
    Character = Player.Character
    
    -- Store original position before doing anything
    local originalCFrame = Character.HumanoidRootPart.CFrame
    
    Character.Archivable = true
    IsInvis = false
    IsRunning = true
    InvisibleCharacter = Character:Clone()
    InvisibleCharacter.Parent = Lighting
    Void = workspace.FallenPartsDestroyHeight
    InvisibleCharacter.Name = "" -- Keep clone invisible
    
    invisFix = RunService.Stepped:Connect(function()
        pcall(function()
            if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then return end
            
            local IsInteger
            if tostring(Void):find'-' then
                IsInteger = true
            else
                IsInteger = false
            end
            local Pos = Player.Character.HumanoidRootPart.Position
            local Pos_String = tostring(Pos)
            local Pos_Seperate = Pos_String:split(', ')
            local X = tonumber(Pos_Seperate[1])
            local Y = tonumber(Pos_Seperate[2])
            local Z = tonumber(Pos_Seperate[3])
            if IsInteger == true then
                if Y <= Void then
                    Respawn()
                end
            elseif IsInteger == false then
                if Y >= Void then
                    Respawn()
                end
            end
        end)
    end)
    
    for i,v in pairs(InvisibleCharacter:GetDescendants())do
        if v:IsA("BasePart") then
            if v.Name == "HumanoidRootPart" then
                v.Transparency = 1
            else
                v.Transparency = .5
            end
        end
    end
    
    function Respawn()
        IsRunning = false
        if IsInvis == true then
            pcall(function()
                Player.Character = Character
                wait()
                Character.Parent = workspace
                Character:FindFirstChildWhichIsA'Humanoid':Destroy()
                IsInvis = false
                if InvisibleCharacter then
                    InvisibleCharacter.Parent = nil
                end
                invisRunning = false
            end)
        elseif IsInvis == false then
            pcall(function()
                Player.Character = Character
                wait()
                Character.Parent = workspace
                Character:FindFirstChildWhichIsA'Humanoid':Destroy()
                if TurnVisible then
                    TurnVisible()
                end
            end)
        end
    end
    
    invisDied = InvisibleCharacter:FindFirstChildOfClass'Humanoid'.Died:Connect(function()
        Respawn()
        invisDied:Disconnect()
    end)
    
    if IsInvis == true then 
        isToggling = false
        return 
    end
    IsInvis = true
    CF = workspace.CurrentCamera.CFrame
    
    -- Use original position instead of character's current position
    local CF_1 = originalCFrame
    
    -- Safe teleportation with position validation
    pcall(function()
        Character:MoveTo(Vector3.new(0,math.pi*1000000,0))
        workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
    end)
    
    wait(.3) -- Increased wait time for stability
    
    pcall(function()
        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
        Character.Parent = Lighting
        InvisibleCharacter.Parent = workspace
        InvisibleCharacter.HumanoidRootPart.CFrame = CF_1
        Player.Character = InvisibleCharacter
        execCmd('fixcam')
        Player.Character.Animate.Disabled = true
        Player.Character.Animate.Disabled = false
    end)
    
    function TurnVisible()
        if IsInvis == false or isToggling then return end
        
        isToggling = true
        
        pcall(function()
            if invisFix then invisFix:Disconnect() end
            if invisDied then invisDied:Disconnect() end
        end)
        
        CF = workspace.CurrentCamera.CFrame
        Character = Character
        
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Character and Character:FindFirstChild("HumanoidRootPart") then
            local CF_1 = Player.Character.HumanoidRootPart.CFrame
            Character.HumanoidRootPart.CFrame = CF_1
        end
        
        pcall(function()
            if InvisibleCharacter then
                InvisibleCharacter:Destroy()
            end
        end)
        
        Player.Character = Character
        Character.Parent = workspace
        IsInvis = false
        
        pcall(function()
            Player.Character.Animate.Disabled = true
            Player.Character.Animate.Disabled = false
        end)
        
        invisDied = Character:FindFirstChildOfClass'Humanoid'.Died:Connect(function()
            Respawn()
            invisDied:Disconnect()
        end)
        
        invisRunning = false
        isToggling = false
    end
    
    invisRunning = true
    isToggling = false
    notify('Invisible','You now appear invisible to other players')
end

-- Fixed toggle invisibility function
local function toggleInvisibility()
    -- Prevent rapid toggling
    if isToggling then
        notify('Invisible', 'Already processing, please wait...')
        return
    end
    
    if invisRunning and IsInvis then
        if TurnVisible then
            TurnVisible()
            ToggleButton.Text = "Make Invisible"
            ToggleButton.BackgroundTransparency = 0.5
        end
    else
        MakeInvisible()
        wait(0.5) -- Small delay to ensure state is set
        if IsInvis then
            ToggleButton.Text = "Make Visible"
            ToggleButton.BackgroundTransparency = 0.3
        end
    end
end

-- Event connections
ToggleButton.MouseButton1Click:Connect(toggleInvisibility)

CloseButton.MouseButton1Click:Connect(function()
    if invisRunning and IsInvis and TurnVisible then
        TurnVisible()
    end
    ScreenGui:Destroy()
end)

MinimizeButton.MouseButton1Click:Connect(toggleMinimize)

KeybindButton.MouseButton1Click:Connect(function()
    if isBinding then return end
    isBinding = true
    KeybindButton.Text = "..."
    KeybindButton.TextColor3 = Color3.new(1, 1, 0)
    
    local connection
    connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard then
            setKeybind(input.KeyCode)
            isBinding = false
            connection:Disconnect()
        end
    end)
end)

-- Keybind detection with rapid toggle protection
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and currentKeybind and input.KeyCode == currentKeybind and not isToggling then
        toggleInvisibility()
    end
end)

-- Cleanup on destroy
ScreenGui.AncestryChanged:Connect(function()
    if not ScreenGui.Parent then
        if invisRunning and IsInvis and TurnVisible then
            TurnVisible()
        end
    end
end)

print("Fixed Compact Invisible Toggle GUI loaded!")
