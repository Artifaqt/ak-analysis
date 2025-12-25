local players = game:GetService("Players")
local tweenService = game:GetService("TweenService")
local userInputService = game:GetService("UserInputService")
local textChatService = game:GetService("TextChatService")
local httpService = game:GetService("HttpService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name="ChatLoggerGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local frame = Instance.new("Frame")
frame.Name="MainFrame"
frame.Size = UDim2.new(0,300,0,350)
frame.Position = UDim2.new(0.5,-150,0.5,-175)
frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
frame.BackgroundTransparency = 0.65
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,10)
corner.Parent = frame

local mainFrame = Instance.new("Frame")
mainFrame.Name="TitleBar"
mainFrame.Size = UDim2.new(1,0,0,35)
mainFrame.BackgroundTransparency = 1
mainFrame.BorderSizePixel = 0
mainFrame.Parent = frame

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1,-80,1,0)
textLabel.Position = UDim2.new(0,12,0,0)
textLabel.BackgroundTransparency = 1
textLabel.Text="Chat Logs"
textLabel.TextColor3 = Color3.fromRGB(255,255,255)
textLabel.TextTransparency = 0.1
textLabel.TextSize = 14
textLabel.Font = Enum.Font.GothamBold
textLabel.TextXAlignment = Enum.TextXAlignment.Left
textLabel.Parent = mainFrame

local button = Instance.new("TextButton")
button.Name="MinMaxButton"
button.Size = UDim2.new(0,25,0,25)
button.Position = UDim2.new(1,-60,0,5)
button.BackgroundColor3 = Color3.fromRGB(0,0,0)
button.BackgroundTransparency = 0.6
button.BorderSizePixel = 0
button.Text="–"
button.TextColor3 = Color3.fromRGB(255,255,255)
button.TextSize = 16
button.Font = Enum.Font.GothamBold
button.Parent = mainFrame

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,8)
corner.Parent = button

local button = Instance.new("TextButton")
button.Name="CloseButton"
button.Size = UDim2.new(0,25,0,25)
button.Position = UDim2.new(1,-30,0,5)
button.BackgroundColor3 = Color3.fromRGB(0,0,0)
button.BackgroundTransparency = 0.6
button.BorderSizePixel = 0
button.Text="×"
button.TextColor3 = Color3.fromRGB(255,255,255)
button.TextSize = 16
button.Font = Enum.Font.GothamBold
button.Parent = mainFrame

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,8)
corner.Parent = button

local mainFrame = Instance.new("Frame")
mainFrame.Name="WebhookFrame"
mainFrame.Size = UDim2.new(1,-16,0,30)
mainFrame.Position = UDim2.new(0,8,0,40)
mainFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
mainFrame.BackgroundTransparency = 0.7
mainFrame.BorderSizePixel = 0
mainFrame.Parent = frame

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,8)
corner.Parent = mainFrame

local textBox = Instance.new("TextBox")
textBox.Name="WebhookInput"
textBox.Size = UDim2.new(1,-10,1,-4)
textBox.Position = UDim2.new(0,5,0,2)
textBox.BackgroundTransparency = 1
textBox.Text=""
textBox.PlaceholderText="Discord Webhook URL"
textBox.TextColor3 = Color3.fromRGB(255,255,255)
textBox.PlaceholderColor3 = Color3.fromRGB(150,150,150)
textBox.TextSize = 11
textBox.Font = Enum.Font.Gotham
textBox.TextXAlignment = Enum.TextXAlignment.Left
textBox.ClearTextOnFocus = false
textBox.Parent = mainFrame

local frame = Instance.new("ScrollingFrame")
frame.Name="ScrollFrame"
frame.Size = UDim2.new(1,-16,1,-85)
frame.Position = UDim2.new(0,8,0,75)
frame.BackgroundTransparency = 1
frame.BorderSizePixel = 0
frame.ScrollBarThickness = 3
frame.ScrollBarImageColor3 = Color3.fromRGB(50,50,50)
frame.ScrollBarImageTransparency = 0.3
frame.CanvasSize = UDim2.new(0,0,0,0)
frame.Parent = frame

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0,5)
padding.PaddingBottom = UDim.new(0,5)
padding.Parent = frame

local listLayout = Instance.new("UIListLayout")
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0,4)
listLayout.Parent = frame

local wh=""

textBox.FocusLost:Connect(function()
wh = textBox.Text
end)

local function sendMessage(pl,msg)
if wh=="" or not string.find(wh,"discord.com/api/webhooks") then
return
end

local thu=""
local s,r = pcall(function()
return httpService:GetAsync("https://thumbnails.roblox.com/v1/users/avatar - headshot?userIds="..pl.UserId.."&size = 420x420&format = Png&isCircular = false")
end)

if s and r then
local dec = httpService:JSONDecode(r)
if dec.data and dec.data[1] and dec.data[1].imageUrl then
thu = dec.data[1].imageUrl
end
end

local config={
["username"]="AK ADMIN Chat logs",
["avatar_url"]="https://cdn.discordapp.com/attachments/1425353680399634464/1442209621275181066/574B62BE - F582 - 47A5 - 98C5 - 2B79C07B51D3.png?ex = 692499e0&is = 69234860&hm = 9c05d354f6b309cab6851c780aeff7af6018bcdb48073b6672579c3605375f01&",
["embeds"]={{
["color"]=0x202020,
["author"]={
["name"]=pl.DisplayName.." (@"..pl.Name..")"
},
["description"]=msg,
["thumbnail"]={
["url"]=thu
}
}}
}

local j = httpService:JSONEncode(config)

pcall(function()
return request({
Url = wh,
Method="POST",
Headers={
["Content - Type"]="application/json"
},
Body = j
})
end)
end

local function cm(pl,msg)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(1,-8,0,45)
mainFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
mainFrame.BackgroundTransparency = 0.7
mainFrame.BorderSizePixel = 0

local uigradient = Instance.new("UIGradient")
uigradient.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.fromRGB(15,15,15)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(0,0,0))
})
uigradient.Transparency = NumberSequence.new(0.7)
uigradient.Parent = mainFrame

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,8)
corner.Parent = mainFrame

local imagelabel = Instance.new("ImageLabel")
imagelabel.Size = UDim2.new(0,25,0,25)
imagelabel.Position = UDim2.new(0,8,0,10)
imagelabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
imagelabel.BackgroundTransparency = 0.5
imagelabel.BorderSizePixel = 0
imagelabel.Image = players:GetUserThumbnailAsync(pl.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size48x48)
imagelabel.ImageTransparency = 0.1

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1,0)
corner.Parent = imagelabel
imagelabel.Parent = mainFrame

local textBox2 = Instance.new("TextBox")
textBox2.Size = UDim2.new(1,-130,0,20)
textBox2.Position = UDim2.new(0,40,0,3)
textBox2.BackgroundTransparency = 1
textBox2.Text = pl.Name or pl.DisplayName
textBox2.TextColor3 = Color3.fromRGB(255,255,255)
textBox2.TextTransparency = 0.1
textBox2.TextSize = 13
textBox2.Font = Enum.Font.GothamBold
textBox2.TextXAlignment = Enum.TextXAlignment.Left
textBox2.TextEditable = false
textBox2.ClearTextOnFocus = false
textBox2.Parent = mainFrame

local textBox3 = Instance.new("TextBox")
textBox3.Size = UDim2.new(1,-130,0,20)
textBox3.Position = UDim2.new(0,40,0,22)
textBox3.BackgroundTransparency = 1
textBox3.Text = msg
textBox3.TextColor3 = Color3.fromRGB(200,200,200)
textBox3.TextTransparency = 0.2
textBox3.TextSize = 12
textBox3.Font = Enum.Font.Gotham
textBox3.TextXAlignment = Enum.TextXAlignment.Left
textBox3.TextWrapped = true
textBox3.TextEditable = false
textBox3.ClearTextOnFocus = false
textBox3.MultiLine = true
textBox3.Parent = mainFrame

local button = Instance.new("TextButton")
button.Size = UDim2.new(0,25,0,25)
button.Position = UDim2.new(1,-33,0,10)
button.BackgroundColor3 = Color3.fromRGB(0,0,0)
button.BackgroundTransparency = 0.7
button.BorderSizePixel = 0
button.Text="📋"
button.TextColor3 = Color3.fromRGB(255,255,255)
button.TextSize = 12
button.Font = Enum.Font.Gotham
button.Parent = mainFrame

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,8)
corner.Parent = button

button.MouseEnter:Connect(function()
tweenService:Create(button,TweenInfo.new(0.2),{BackgroundTransparency = 0.5}):Play()
end)

button.MouseLeave:Connect(function()
tweenService:Create(button,TweenInfo.new(0.2),{BackgroundTransparency = 0.7}):Play()
end)

button.MouseButton1Click:Connect(function()
setclipboard(msg)
local ot = button.Text
button.Text="✓"
wait(1)
button.Text = ot
end)

sendMessage(pl,msg)

return mainFrame
end

local function ed(position,hdl)
local dr,di,ds,padding

local function ui(input)
local config = input.Position - ds
local np = UDim2.new(padding.X.Scale,padding.X.Offset + config.X,padding.Y.Scale,padding.Y.Offset + config.Y)
position.Position = np
end

hdl.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
dr = true
ds = input.Position
padding = position.Position

input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then
dr = false
end
end)
end
end)

hdl.InputChanged:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
di = input
end
end)

userInputService.InputChanged:Connect(function(input)
if input == di and dr then
ui(input)
end
end)
end

ed(frame,mainFrame)

local flag = false
button.MouseButton1Click:Connect(function()
flag = not flag
local ts = flag and UDim2.new(0,300,0,35) or UDim2.new(0,300,0,350)

button.Text = flag and "+" or "–"

tweenService:Create(frame,TweenInfo.new(0.3,Enum.EasingStyle.Quad),{Size = ts}):Play()

frame.ClipsDescendants = flag
end)

button.MouseEnter:Connect(function()
tweenService:Create(button,TweenInfo.new(0.2),{BackgroundTransparency = 0.4}):Play()
end)

button.MouseLeave:Connect(function()
tweenService:Create(button,TweenInfo.new(0.2),{BackgroundTransparency = 0.6}):Play()
end)

button.MouseEnter:Connect(function()
tweenService:Create(button,TweenInfo.new(0.2),{BackgroundTransparency = 0.4}):Play()
end)

button.MouseLeave:Connect(function()
tweenService:Create(button,TweenInfo.new(0.2),{BackgroundTransparency = 0.6}):Play()
end)

button.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)

local function scl()
local s,tc = pcall(function()
return textChatService.TextChannels
end)

if s and tc then
local gc = tc:FindFirstChild("RBXGeneral")

if gc then
gc.MessageReceived:Connect(function(tcm)
if string.find(tcm.Text,"#") then
return
end

local pl = players:GetPlayerByUserId(tcm.TextSource.UserId)

if pl then
local chm = cm(pl,tcm.Text)
chm.Parent = frame

local cs = listLayout.AbsoluteContentSize
frame.CanvasSize = UDim2.new(0,0,0,cs.Y)

local cy = frame.CanvasSize.Y.Offset
local wy = frame.AbsoluteWindowSize.Y
local cuy = frame.CanvasPosition.Y
local value = 10

if cuy>=(cy - wy - value) then
tweenService:Create(frame,TweenInfo.new(0.3),{CanvasPosition = Vector2.new(0,cs.Y)}):Play()
end
end
end)
end
else
players.PlayerChatted:Connect(function(ct,pl,msg)
if string.find(msg,"#") then
return
end

local chm = cm(pl,msg)
chm.Parent = frame

local cs = listLayout.AbsoluteContentSize
frame.CanvasSize = UDim2.new(0,0,0,cs.Y)

local cy = frame.CanvasSize.Y.Offset
local wy = frame.AbsoluteWindowSize.Y
local cuy = frame.CanvasPosition.Y
local value = 10

if cuy>=(cy - wy - value) then
tweenService:Create(frame,TweenInfo.new(0.3),{CanvasPosition = Vector2.new(0,cs.Y)}):Play()
end
end)
end
end

local function opa(pl)
if pl == players.LocalPlayer then
screenGui.Parent = pl.PlayerGui
scl()
end
end

players.PlayerAdded:Connect(opa)
for _,pl in ipairs(players:GetPlayers()) do
opa(pl)
end
