local textChatService = game:GetService("TextChatService")
local chat = game:GetService("Chat")
local players = game:GetService("Players")
local coregui = game:GetService("CoreGui")
local replicatedStorage = game:GetService("ReplicatedStorage")
local userInputService = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")

local localPlayer = players.LocalPlayer
local config = {ab = false, wr = false, sp = "", ph = {}}
local config2 = {q="q", w="w", e="e", r="ғ", t="t", y="y", u="ษ", i="เ่", o="o", p="p", a="ล", s="ร", d="d", f="f", g="g", h="Іา", j="ϳ", k="k", l="ӏ", z="z", x="ӿ", c="ჺ", v="v", b="b", n="ค", m="ทา", [" "] = config.sp}
local config3 = {boobs = "Ꙏoobs"}
local httpService = game:GetService("HttpService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CB"
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = coregui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 350)
frame.Position = UDim2.new(0.5, -200, 0.5, -175)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BackgroundTransparency = 0.7
frame.BorderSizePixel = 0
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local frame = Instance.new("Frame")
frame.Size = UDim2.new(1, 0, 0, 40)
frame.BackgroundTransparency = 1
frame.Parent = frame

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(0, 120, 0, 20)
textLabel.Position = UDim2.new(0, 10, 0, 5)
textLabel.BackgroundTransparency = 1
textLabel.Text = "AK ADMIN"
textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.TextSize = 12
textLabel.Font = Enum.Font.GothamBold
textLabel.TextXAlignment = Enum.TextXAlignment.Left
textLabel.Parent = frame

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.BackgroundTransparency = 1
textLabel.Text = "CHAT BYPASSER"
textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.TextSize = 16
textLabel.Font = Enum.Font.GothamBold
textLabel.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 30, 0, 30)
button.Position = UDim2.new(1, -70, 0, 5)
button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
button.BackgroundTransparency = 0.5
button.Text = "-"
button.TextColor3 = Color3.new(1, 1, 1)
button.TextSize = 20
button.Font = Enum.Font.GothamBold
button.BorderSizePixel = 0
button.Parent = frame

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = button

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 30, 0, 30)
button.Position = UDim2.new(1, -35, 0, 5)
button.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
button.BackgroundTransparency = 0.3
button.Text = "X"
button.TextColor3 = Color3.new(1, 1, 1)
button.TextSize = 16
button.Font = Enum.Font.GothamBold
button.BorderSizePixel = 0
button.Parent = frame

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = button

local frame = Instance.new("Frame")
frame.Size = UDim2.new(1, -20, 1, -60)
frame.Position = UDim2.new(0, 10, 0, 50)
frame.BackgroundTransparency = 1
frame.Parent = frame

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 0, 30)
textLabel.BackgroundTransparency = 1
textLabel.Text = "Auto Bypass"
textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.TextSize = 14
textLabel.Font = Enum.Font.Gotham
textLabel.TextXAlignment = Enum.TextXAlignment.Left
textLabel.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 50, 0, 25)
button.Position = UDim2.new(1, -55, 0, 2.5)
button.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
button.Text = "OFF"
button.TextColor3 = Color3.new(1, 1, 1)
button.TextSize = 12
button.Font = Enum.Font.GothamBold
button.BorderSizePixel = 0
button.Parent = textLabel

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = button

local textLabel2 = Instance.new("TextLabel")
textLabel2.Size = UDim2.new(1, 0, 0, 30)
textLabel2.Position = UDim2.new(0, 0, 0, 40)
textLabel2.BackgroundTransparency = 1
textLabel2.Text = "Wrappers"
textLabel2.TextColor3 = Color3.new(1, 1, 1)
textLabel2.TextSize = 14
textLabel2.Font = Enum.Font.Gotham
textLabel2.TextXAlignment = Enum.TextXAlignment.Left
textLabel2.Parent = frame

local button2 = Instance.new("TextButton")
button2.Size = UDim2.new(0, 50, 0, 25)
button2.Position = UDim2.new(1, -55, 0, 2.5)
button2.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
button2.Text = "OFF"
button2.TextColor3 = Color3.new(1, 1, 1)
button2.TextSize = 12
button2.Font = Enum.Font.GothamBold
button2.BorderSizePixel = 0
button2.Parent = textLabel2

local corner2 = Instance.new("UICorner")
corner2.CornerRadius = UDim.new(0, 6)
corner2.Parent = button2

local button3 = Instance.new("TextButton")
button3.Size = UDim2.new(1, 0, 0, 30)
button3.Position = UDim2.new(0, 0, 0, 75)
button3.BackgroundColor3 = Color3.new(0.9, 0.5, 0.2)
button3.BackgroundTransparency = 0.3
button3.Text = "Fix Tags"
button3.TextColor3 = Color3.new(1, 1, 1)
button3.TextSize = 14
button3.Font = Enum.Font.GothamBold
button3.BorderSizePixel = 0
button3.Parent = frame

local corner3 = Instance.new("UICorner")
corner3.CornerRadius = UDim.new(0, 6)
corner3.Parent = button3

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 0, 20)
textLabel.Position = UDim2.new(0, 0, 1, -25)
textLabel.BackgroundTransparency = 1
textLabel.Text = ""
textLabel.TextColor3 = Color3.new(1, 0.3, 0.3)
textLabel.TextSize = 12
textLabel.Font = Enum.Font.GothamBold
textLabel.Parent = frame

local textLabel3 = Instance.new("TextLabel")
textLabel3.Size = UDim2.new(1, 0, 0, 30)
textLabel3.Position = UDim2.new(0, 0, 0, 110)
textLabel3.BackgroundTransparency = 1
textLabel3.Text = "Saved Phrase"
textLabel3.TextColor3 = Color3.new(1, 1, 1)
textLabel3.TextSize = 14
textLabel3.Font = Enum.Font.Gotham
textLabel3.TextXAlignment = Enum.TextXAlignment.Left
textLabel3.Parent = frame

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(1, -65, 0, 25)
textBox.Position = UDim2.new(0, 0, 0, 145)
textBox.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
textBox.BackgroundTransparency = 0.5
textBox.Text = ""
textBox.PlaceholderText = "Enter phrase..."
textBox.TextColor3 = Color3.new(1, 1, 1)
textBox.TextSize = 12
textBox.Font = Enum.Font.Gotham
textBox.BorderSizePixel = 0
textBox.ClearTextOnFocus = false
textBox.Parent = frame

local corner4 = Instance.new("UICorner")
corner4.CornerRadius = UDim.new(0, 6)
corner4.Parent = textBox

local button4 = Instance.new("TextButton")
button4.Size = UDim2.new(0, 55, 0, 25)
button4.Position = UDim2.new(1, -55, 0, 145)
button4.BackgroundColor3 = Color3.new(0.3, 0.6, 0.9)
button4.BackgroundTransparency = 0.3
button4.Text = "ADD"
button4.TextColor3 = Color3.new(1, 1, 1)
button4.TextSize = 12
button4.Font = Enum.Font.GothamBold
button4.BorderSizePixel = 0
button4.Parent = frame

local corner5 = Instance.new("UICorner")
corner5.CornerRadius = UDim.new(0, 6)
corner5.Parent = button4

local frame = Instance.new("ScrollingFrame")
frame.Size = UDim2.new(1, 0, 0, 105)
frame.Position = UDim2.new(0, 0, 0, 180)
frame.BackgroundTransparency = 1
frame.BorderSizePixel = 0
frame.ScrollBarThickness = 4
frame.Parent = frame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 5)
listLayout.Parent = frame

local function getTextBox()
    local playerGui = localPlayer:FindFirstChild("PlayerGui")
    local ec = coregui:FindFirstChild("ExperienceChat")
    return (ec and ec:FindFirstChild("TextBox", true)) or (playerGui and playerGui:FindFirstChild("Chat") and playerGui.Chat:FindFirstChild("TextBox", true))
end

local function sendMessage(message)
    if textChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        pcall(function() textChatService.TextChannels.RBXGeneral:SendAsync(message) end)
    else
        pcall(function() replicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All") end)
    end
end

local function isTagged(message)
    local s, r = pcall(chat.FilterStringForBroadcast, chat, message, localPlayer)
    return s and r ~= message
end

local function handleMessage(message)
    local nw = message
    for wd, rp in pairs(config3) do
        nw = nw:gsub(wd, rp)
    end
    nw = nw:gsub(".", function(c) return config2[c:lower()] or c end)
    local fn = config.wr and ("˹🕆Ო " .. nw .. " Ო🕆˼") or nw
    if not isTagged(fn) then 
        sendMessage(fn)
        textLabel.Text = ""
    else
        textLabel.Text = "Tagged!"
        task.delay(3, function() textLabel.Text = "" end)
    end
end

local function loadFromFile()
    if isfile("cb_phrase.txt") then
        local dt = readfile("cb_phrase.txt")
        local ok, replicatedStorage = pcall(function() return httpService:JSONDecode(dt) end)
        if ok and type(replicatedStorage) == "table" then
            config.ph = replicatedStorage
        end
    end
end

local function saveToFile()
    local ok, replicatedStorage = pcall(function() return httpService:JSONEncode(config.ph) end)
    if ok then
        writefile("cb_phrase.txt", replicatedStorage)
    end
end

local function updateDisplay()
    for _, chat in pairs(frame:GetChildren()) do
        if chat:IsA("TextButton") then chat:Destroy() end
    end
    
    for i, ph in ipairs(config.ph) do
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, -15, 0, 30)
        button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        button.BackgroundTransparency = 0.3
        button.Text = ph
        button.TextColor3 = Color3.new(1, 1, 1)
        button.TextSize = 12
        button.Font = Enum.Font.Gotham
        button.BorderSizePixel = 0
        button.TextTruncate = Enum.TextTruncate.AtEnd
        button.TextXAlignment = Enum.TextXAlignment.Left
        button.Parent = frame
        
        local padding = Instance.new("UIPadding")
        padding.PaddingLeft = UDim.new(0, 10)
        padding.Parent = button
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = button
        
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0, 30, 0, 30)
        button.Position = UDim2.new(1, -30, 0, 0)
        button.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
        button.BackgroundTransparency = 0.3
        button.Text = "X"
        button.TextColor3 = Color3.new(1, 1, 1)
        button.TextSize = 14
        button.Font = Enum.Font.GothamBold
        button.BorderSizePixel = 0
        button.Parent = button
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = button
        
        button.MouseButton1Click:Connect(function()
            handleMessage(ph)
        end)
        
        button.MouseButton1Click:Connect(function()
            table.remove(config.ph, i)
            saveToFile()
            updateDisplay()
        end)
    end
    
    frame.CanvasSize = UDim2.new(0, 0, 0, #config.ph * 35 + 5)
end

loadFromFile()
updateDisplay()

button.MouseButton1Click:Connect(function()
    config.ab = not config.ab
    button.Text = config.ab and "ON" or "OFF"
    button.BackgroundColor3 = config.ab and Color3.new(0.2, 0.8, 0.3) or Color3.new(0.3, 0.3, 0.3)
end)

button2.MouseButton1Click:Connect(function()
    config.wr = not config.wr
    button2.Text = config.wr and "ON" or "OFF"
    button2.BackgroundColor3 = config.wr and Color3.new(0.2, 0.8, 0.3) or Color3.new(0.3, 0.3, 0.3)
end)

button3.MouseButton1Click:Connect(function()
    local nw = "Abcdefg()*!"
    local fn = "˹㍹🕆Ო " .. nw .. " Ო🕆㍹˼"
    if not isTagged(fn) then
        sendMessage(fn)
        textLabel.Text = ""
    else
        textLabel.Text = "Tagged!"
        task.delay(3, function() textLabel.Text = "" end)
    end
end)

textBox.FocusLost:Connect(function()
end)

button4.MouseButton1Click:Connect(function()
    if textBox.Text ~= "" then
        table.insert(config.ph, textBox.Text)
        saveToFile()
        updateDisplay()
        textBox.Text = ""
    end
end)

local flag = false
button.MouseButton1Click:Connect(function()
    flag = not flag
    if flag then
        tweenService:Create(frame, TweenInfo.new(0.3), {Size = UDim2.new(0, 400, 0, 40)}):Play()
        frame.Visible = false
        button.Text = "+"
    else
        tweenService:Create(frame, TweenInfo.new(0.3), {Size = UDim2.new(0, 400, 0, 350)}):Play()
        task.wait(0.3)
        frame.Visible = true
        button.Text = "-"
    end
end)

button.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

local flag = false
local ix, iy

frame.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        flag = true
        local px = inp.Position.X
        local py = inp.Position.Y
        ix = px - frame.AbsolutePosition.X
        iy = py - frame.AbsolutePosition.Y
        
        inp.Changed:Connect(function()
            if inp.UserInputState == Enum.UserInputState.End then
                flag = false
            end
        end)
    end
end)

frame.InputChanged:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
        if flag then
            local px = inp.Position.X - ix
            local py = inp.Position.Y - iy
            frame.Position = UDim2.new(0, px, 0, py)
        end
    end
end)

local bx = getTextBox()
if bx then
    bx.FocusLost:Connect(function(en)
        if en and config.ab and bx.Text ~= "" then
            local tx = bx.Text
            bx.Text = ""
            handleMessage(tx)
        end
    end)
end
