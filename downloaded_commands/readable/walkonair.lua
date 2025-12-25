local Ps = game:GetService("Players")
local Rs = game:GetService("RunService")
local Ui = game:GetService("UserInputService")
local Pr = Ps.LocalPlayer
local Aw = true
local Iv = false
local Mu = false
local Md = false

local function Cb()
    local bp = Instance.new("Part")
    bp.Name = "InvisibleBaseplate"
    bp.Size = Vector3.new(math.huge, 1, math.huge)
    bp.Position = Vector3.new(0, 0, 0)
    bp.Transparency = 1
    bp.Anchored = true
    bp.CanCollide = true
    bp.Material = Enum.Material.Neon
    bp.Color = Color3.fromRGB(70, 200, 255)
    bp.Parent = workspace
    return bp
end

local bp = Cb()

local Sg = Instance.new("ScreenGui")
local Mf = Instance.new("Frame")
local Uc = Instance.new("UICorner")
local Tb = Instance.new("Frame")
local Tc = Instance.new("UICorner")
local Tl = Instance.new("TextLabel")
local Xb = Instance.new("TextButton")
local Xc = Instance.new("UICorner")
local Ob = Instance.new("TextButton")
local Oc = Instance.new("UICorner")
local Ub = Instance.new("TextButton")
local Uc2 = Instance.new("UICorner")
local Db = Instance.new("TextButton")
local Dc = Instance.new("UICorner")
local Vb = Instance.new("TextButton")
local Vc = Instance.new("UICorner")

Sg.Parent = Pr:WaitForChild("PlayerGui")
Sg.Name = "AirwalkGui"
Sg.ResetOnSpawn = false

Mf.Parent = Sg
Mf.Name = "MainFrame"
Mf.Size = UDim2.new(0, 240, 0, 100)
Mf.Position = UDim2.new(1, -250, 1, -110)
Mf.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Mf.BackgroundTransparency = 0.6
Mf.BorderSizePixel = 0

Uc.Parent = Mf
Uc.CornerRadius = UDim.new(0, 12)

Tb.Parent = Mf
Tb.Name = "TitleBar"
Tb.Size = UDim2.new(1, 0, 0, 25)
Tb.BackgroundTransparency = 1
Tb.BorderSizePixel = 0

Tc.Parent = Tb
Tc.CornerRadius = UDim.new(0, 12)

local Al = Instance.new("TextLabel")

Al.Parent = Tb
Al.Size = UDim2.new(0, 80, 1, 0)
Al.Position = UDim2.new(0, 5, 0, 0)
Al.BackgroundTransparency = 1
Al.Text = "AK ADMIN"
Al.TextColor3 = Color3.fromRGB(255, 255, 255)
Al.Font = Enum.Font.Arial
Al.TextSize = 10
Al.TextXAlignment = Enum.TextXAlignment.Left

Tl.Parent = Tb
Tl.Size = UDim2.new(1, 0, 1, 0)
Tl.Position = UDim2.new(0, 0, 0, 0)
Tl.BackgroundTransparency = 1
Tl.Text = "Walk on Air"
Tl.TextColor3 = Color3.fromRGB(255, 255, 255)
Tl.Font = Enum.Font.Arial
Tl.TextSize = 16
Tl.TextXAlignment = Enum.TextXAlignment.Center

Xb.Parent = Tb
Xb.Name = "CloseButton"
Xb.Size = UDim2.new(0, 20, 0, 20)
Xb.Position = UDim2.new(1, -23, 0, 2.5)
Xb.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Xb.BackgroundTransparency = 0.5
Xb.BorderSizePixel = 0
Xb.Text = "×"
Xb.TextColor3 = Color3.fromRGB(255, 255, 255)
Xb.Font = Enum.Font.Arial
Xb.TextSize = 16

Xc.Parent = Xb
Xc.CornerRadius = UDim.new(0, 6)

Ob.Parent = Mf
Ob.Name = "OnOffButton"
Ob.Size = UDim2.new(0, 65, 0, 28)
Ob.Position = UDim2.new(0, 10, 0, 32)
Ob.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
Ob.BackgroundTransparency = 0.7
Ob.BorderSizePixel = 0
Ob.Text = "ON"
Ob.TextColor3 = Color3.fromRGB(255, 255, 255)
Ob.Font = Enum.Font.Arial
Ob.TextSize = 14

Oc.Parent = Ob
Oc.CornerRadius = UDim.new(0, 8)

Ub.Parent = Mf
Ub.Name = "UpButton"
Ub.Size = UDim2.new(0, 65, 0, 28)
Ub.Position = UDim2.new(0, 85, 0, 32)
Ub.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Ub.BackgroundTransparency = 0.7
Ub.BorderSizePixel = 0
Ub.Text = "▲"
Ub.TextColor3 = Color3.fromRGB(255, 255, 255)
Ub.Font = Enum.Font.Arial
Ub.TextSize = 14

Uc2.Parent = Ub
Uc2.CornerRadius = UDim.new(0, 8)

Db.Parent = Mf
Db.Name = "DownButton"
Db.Size = UDim2.new(0, 65, 0, 28)
Db.Position = UDim2.new(0, 160, 0, 32)
Db.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Db.BackgroundTransparency = 0.7
Db.BorderSizePixel = 0
Db.Text = "▼"
Db.TextColor3 = Color3.fromRGB(255, 255, 255)
Db.Font = Enum.Font.Arial
Db.TextSize = 14

Dc.Parent = Db
Dc.CornerRadius = UDim.new(0, 8)

Vb.Parent = Mf
Vb.Name = "VisibilityButton"
Vb.Size = UDim2.new(0, 220, 0, 28)
Vb.Position = UDim2.new(0, 10, 0, 65)
Vb.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Vb.BackgroundTransparency = 0.7
Vb.BorderSizePixel = 0
Vb.Text = "Show Platform"
Vb.TextColor3 = Color3.fromRGB(255, 255, 255)
Vb.Font = Enum.Font.Arial
Vb.TextSize = 14

Vc.Parent = Vb
Vc.CornerRadius = UDim.new(0, 8)

local dg = false
local di, ds, sp

local function Ud(input)
    local dt = input.Position - ds
    Mf.Position = UDim2.new(
        sp.X.Scale,
        sp.X.Offset + dt.X,
        sp.Y.Scale,
        sp.Y.Offset + dt.Y
    )
end

Tb.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dg = true
        ds = input.Position
        sp = Mf.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dg = false
            end
        end)
    end
end)

Tb.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        di = input
    end
end)

Ui.InputChanged:Connect(function(input)
    if input == di and dg then
        Ud(input)
    end
end)

Xb.MouseButton1Click:Connect(function()
    Sg:Destroy()
end)

local function Rp()
    local ch = Pr.Character
    if ch then
        local hr = ch:FindFirstChild("HumanoidRootPart")
        if hr then
            bp.Position = Vector3.new(
                hr.Position.X,
                bp.Position.Y,
                hr.Position.Z
            )
        end
    end
end

local function Tv()
    Iv = not Iv
    bp.Transparency = Iv and 0.3 or 1
    
    if Iv then
        bp.Material = Enum.Material.Neon
        Vb.Text = "Hide Platform"
    else
        bp.Material = Enum.Material.SmoothPlastic
        Vb.Text = "Show Platform"
    end
end

local function Ta()
    Aw = not Aw
    if Aw then
        Ob.Text = "ON"
        Ob.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        if not bp:IsDescendantOf(workspace) then
            bp = Cb()
        end
    else
        Ob.Text = "OFF"
        Ob.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        bp:Destroy()
    end
end

Rs.Heartbeat:Connect(function()
    if Mu then
        bp.Position = bp.Position + Vector3.new(0, 0.5, 0)
    elseif Md then
        bp.Position = bp.Position - Vector3.new(0, 0.5, 0)
    end
end)

Ob.MouseButton1Click:Connect(Ta)
Vb.MouseButton1Click:Connect(Tv)

Ub.MouseButton1Down:Connect(function() Mu = true end)
Ub.MouseButton1Up:Connect(function() Mu = false end)
Ub.MouseLeave:Connect(function() Mu = false end)

Db.MouseButton1Down:Connect(function() Md = true end)
Db.MouseButton1Up:Connect(function() Md = false end)
Db.MouseLeave:Connect(function() Md = false end)

Rs.Heartbeat:Connect(function()
    local ch = Pr.Character
    if ch and Aw then
        local hr = ch:FindFirstChild("HumanoidRootPart")
        if hr then
            bp.Position = Vector3.new(
                hr.Position.X,
                bp.Position.Y,
                hr.Position.Z
            )
        end
    end
end)

Rp()

Pr.CharacterAdded:Connect(function(character)
    wait(0.5)
    Rp()
end)

Sg.DescendantRemoving:Connect(function(descendant)
    if descendant == Mf then
        Mf.Parent = Sg
    end
end)
