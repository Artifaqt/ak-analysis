local p=game:GetService("Players")
local t=game:GetService("TweenService")
local u=game:GetService("UserInputService")
local c=game:GetService("TextChatService")
local h=game:GetService("HttpService")

local sg=Instance.new("ScreenGui")
sg.Name="ChatLoggerGUI"
sg.ResetOnSpawn=false
sg.ZIndexBehavior=Enum.ZIndexBehavior.Sibling

local mf=Instance.new("Frame")
mf.Name="MainFrame"
mf.Size=UDim2.new(0,300,0,350)
mf.Position=UDim2.new(0.5,-150,0.5,-175)
mf.BackgroundColor3=Color3.fromRGB(0,0,0)
mf.BackgroundTransparency=0.65
mf.BorderSizePixel=0
mf.ClipsDescendants=true
mf.Parent=sg

local cr=Instance.new("UICorner")
cr.CornerRadius=UDim.new(0,10)
cr.Parent=mf

local tb=Instance.new("Frame")
tb.Name="TitleBar"
tb.Size=UDim2.new(1,0,0,35)
tb.BackgroundTransparency=1
tb.BorderSizePixel=0
tb.Parent=mf

local tt=Instance.new("TextLabel")
tt.Size=UDim2.new(1,-80,1,0)
tt.Position=UDim2.new(0,12,0,0)
tt.BackgroundTransparency=1
tt.Text="Chat Logs"
tt.TextColor3=Color3.fromRGB(255,255,255)
tt.TextTransparency=0.1
tt.TextSize=14
tt.Font=Enum.Font.GothamBold
tt.TextXAlignment=Enum.TextXAlignment.Left
tt.Parent=tb

local mb=Instance.new("TextButton")
mb.Name="MinMaxButton"
mb.Size=UDim2.new(0,25,0,25)
mb.Position=UDim2.new(1,-60,0,5)
mb.BackgroundColor3=Color3.fromRGB(0,0,0)
mb.BackgroundTransparency=0.6
mb.BorderSizePixel=0
mb.Text="–"
mb.TextColor3=Color3.fromRGB(255,255,255)
mb.TextSize=16
mb.Font=Enum.Font.GothamBold
mb.Parent=tb

local mc=Instance.new("UICorner")
mc.CornerRadius=UDim.new(0,8)
mc.Parent=mb

local cb=Instance.new("TextButton")
cb.Name="CloseButton"
cb.Size=UDim2.new(0,25,0,25)
cb.Position=UDim2.new(1,-30,0,5)
cb.BackgroundColor3=Color3.fromRGB(0,0,0)
cb.BackgroundTransparency=0.6
cb.BorderSizePixel=0
cb.Text="×"
cb.TextColor3=Color3.fromRGB(255,255,255)
cb.TextSize=16
cb.Font=Enum.Font.GothamBold
cb.Parent=tb

local cc=Instance.new("UICorner")
cc.CornerRadius=UDim.new(0,8)
cc.Parent=cb

local wf=Instance.new("Frame")
wf.Name="WebhookFrame"
wf.Size=UDim2.new(1,-16,0,30)
wf.Position=UDim2.new(0,8,0,40)
wf.BackgroundColor3=Color3.fromRGB(0,0,0)
wf.BackgroundTransparency=0.7
wf.BorderSizePixel=0
wf.Parent=mf

local wc=Instance.new("UICorner")
wc.CornerRadius=UDim.new(0,8)
wc.Parent=wf

local wi=Instance.new("TextBox")
wi.Name="WebhookInput"
wi.Size=UDim2.new(1,-10,1,-4)
wi.Position=UDim2.new(0,5,0,2)
wi.BackgroundTransparency=1
wi.Text=""
wi.PlaceholderText="Discord Webhook URL"
wi.TextColor3=Color3.fromRGB(255,255,255)
wi.PlaceholderColor3=Color3.fromRGB(150,150,150)
wi.TextSize=11
wi.Font=Enum.Font.Gotham
wi.TextXAlignment=Enum.TextXAlignment.Left
wi.ClearTextOnFocus=false
wi.Parent=wf

local sf=Instance.new("ScrollingFrame")
sf.Name="ScrollFrame"
sf.Size=UDim2.new(1,-16,1,-85)
sf.Position=UDim2.new(0,8,0,75)
sf.BackgroundTransparency=1
sf.BorderSizePixel=0
sf.ScrollBarThickness=3
sf.ScrollBarImageColor3=Color3.fromRGB(50,50,50)
sf.ScrollBarImageTransparency=0.3
sf.CanvasSize=UDim2.new(0,0,0,0)
sf.Parent=mf

local sp=Instance.new("UIPadding")
sp.PaddingTop=UDim.new(0,5)
sp.PaddingBottom=UDim.new(0,5)
sp.Parent=sf

local ll=Instance.new("UIListLayout")
ll.SortOrder=Enum.SortOrder.LayoutOrder
ll.Padding=UDim.new(0,4)
ll.Parent=sf

local wh=""

wi.FocusLost:Connect(function()
wh=wi.Text
end)

local function sd(pl,msg)
if wh=="" or not string.find(wh,"discord.com/api/webhooks") then
return
end

local thu=""
local s,r=pcall(function()
return h:GetAsync("https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds="..pl.UserId.."&size=420x420&format=Png&isCircular=false")
end)

if s and r then
local dec=h:JSONDecode(r)
if dec.data and dec.data[1] and dec.data[1].imageUrl then
thu=dec.data[1].imageUrl
end
end

local d={
["username"]="AK ADMIN Chat logs",
["avatar_url"]="https://cdn.discordapp.com/attachments/1425353680399634464/1442209621275181066/574B62BE-F582-47A5-98C5-2B79C07B51D3.png?ex=692499e0&is=69234860&hm=9c05d354f6b309cab6851c780aeff7af6018bcdb48073b6672579c3605375f01&",
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

local j=h:JSONEncode(d)

pcall(function()
return request({
Url=wh,
Method="POST",
Headers={
["Content-Type"]="application/json"
},
Body=j
})
end)
end

local function cm(pl,msg)
local mfr=Instance.new("Frame")
mfr.Size=UDim2.new(1,-8,0,45)
mfr.BackgroundColor3=Color3.fromRGB(0,0,0)
mfr.BackgroundTransparency=0.7
mfr.BorderSizePixel=0

local mg=Instance.new("UIGradient")
mg.Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.fromRGB(15,15,15)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(0,0,0))
})
mg.Transparency=NumberSequence.new(0.7)
mg.Parent=mfr

local mcr=Instance.new("UICorner")
mcr.CornerRadius=UDim.new(0,8)
mcr.Parent=mfr

local pi=Instance.new("ImageLabel")
pi.Size=UDim2.new(0,25,0,25)
pi.Position=UDim2.new(0,8,0,10)
pi.BackgroundColor3=Color3.fromRGB(0,0,0)
pi.BackgroundTransparency=0.5
pi.BorderSizePixel=0
pi.Image=p:GetUserThumbnailAsync(pl.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size48x48)
pi.ImageTransparency=0.1

local ic=Instance.new("UICorner")
ic.CornerRadius=UDim.new(1,0)
ic.Parent=pi
pi.Parent=mfr

local pn=Instance.new("TextBox")
pn.Size=UDim2.new(1,-130,0,20)
pn.Position=UDim2.new(0,40,0,3)
pn.BackgroundTransparency=1
pn.Text=pl.Name or pl.DisplayName
pn.TextColor3=Color3.fromRGB(255,255,255)
pn.TextTransparency=0.1
pn.TextSize=13
pn.Font=Enum.Font.GothamBold
pn.TextXAlignment=Enum.TextXAlignment.Left
pn.TextEditable=false
pn.ClearTextOnFocus=false
pn.Parent=mfr

local mt=Instance.new("TextBox")
mt.Size=UDim2.new(1,-130,0,20)
mt.Position=UDim2.new(0,40,0,22)
mt.BackgroundTransparency=1
mt.Text=msg
mt.TextColor3=Color3.fromRGB(200,200,200)
mt.TextTransparency=0.2
mt.TextSize=12
mt.Font=Enum.Font.Gotham
mt.TextXAlignment=Enum.TextXAlignment.Left
mt.TextWrapped=true
mt.TextEditable=false
mt.ClearTextOnFocus=false
mt.MultiLine=true
mt.Parent=mfr

local cpb=Instance.new("TextButton")
cpb.Size=UDim2.new(0,25,0,25)
cpb.Position=UDim2.new(1,-33,0,10)
cpb.BackgroundColor3=Color3.fromRGB(0,0,0)
cpb.BackgroundTransparency=0.7
cpb.BorderSizePixel=0
cpb.Text="📋"
cpb.TextColor3=Color3.fromRGB(255,255,255)
cpb.TextSize=12
cpb.Font=Enum.Font.Gotham
cpb.Parent=mfr

local cpc=Instance.new("UICorner")
cpc.CornerRadius=UDim.new(0,8)
cpc.Parent=cpb

cpb.MouseEnter:Connect(function()
t:Create(cpb,TweenInfo.new(0.2),{BackgroundTransparency=0.5}):Play()
end)

cpb.MouseLeave:Connect(function()
t:Create(cpb,TweenInfo.new(0.2),{BackgroundTransparency=0.7}):Play()
end)

cpb.MouseButton1Click:Connect(function()
setclipboard(msg)
local ot=cpb.Text
cpb.Text="✓"
wait(1)
cpb.Text=ot
end)

sd(pl,msg)

return mfr
end

local function ed(g,hdl)
local dr,di,ds,sp

local function ui(inp)
local d=inp.Position-ds
local np=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)
g.Position=np
end

hdl.InputBegan:Connect(function(inp)
if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
dr=true
ds=inp.Position
sp=g.Position

inp.Changed:Connect(function()
if inp.UserInputState==Enum.UserInputState.End then
dr=false
end
end)
end
end)

hdl.InputChanged:Connect(function(inp)
if inp.UserInputType==Enum.UserInputType.MouseMovement or inp.UserInputType==Enum.UserInputType.Touch then
di=inp
end
end)

u.InputChanged:Connect(function(inp)
if inp==di and dr then
ui(inp)
end
end)
end

ed(mf,tb)

local m=false
mb.MouseButton1Click:Connect(function()
m=not m
local ts=m and UDim2.new(0,300,0,35) or UDim2.new(0,300,0,350)

mb.Text=m and "+" or "–"

t:Create(mf,TweenInfo.new(0.3,Enum.EasingStyle.Quad),{Size=ts}):Play()

mf.ClipsDescendants=m
end)

mb.MouseEnter:Connect(function()
t:Create(mb,TweenInfo.new(0.2),{BackgroundTransparency=0.4}):Play()
end)

mb.MouseLeave:Connect(function()
t:Create(mb,TweenInfo.new(0.2),{BackgroundTransparency=0.6}):Play()
end)

cb.MouseEnter:Connect(function()
t:Create(cb,TweenInfo.new(0.2),{BackgroundTransparency=0.4}):Play()
end)

cb.MouseLeave:Connect(function()
t:Create(cb,TweenInfo.new(0.2),{BackgroundTransparency=0.6}):Play()
end)

cb.MouseButton1Click:Connect(function()
sg:Destroy()
end)

local function scl()
local s,tc=pcall(function()
return c.TextChannels
end)

if s and tc then
local gc=tc:FindFirstChild("RBXGeneral")

if gc then
gc.MessageReceived:Connect(function(tcm)
if string.find(tcm.Text,"#") then
return
end

local pl=p:GetPlayerByUserId(tcm.TextSource.UserId)

if pl then
local chm=cm(pl,tcm.Text)
chm.Parent=sf

local cs=ll.AbsoluteContentSize
sf.CanvasSize=UDim2.new(0,0,0,cs.Y)

local cy=sf.CanvasSize.Y.Offset
local wy=sf.AbsoluteWindowSize.Y
local cuy=sf.CanvasPosition.Y
local tol=10

if cuy>=(cy-wy-tol) then
t:Create(sf,TweenInfo.new(0.3),{CanvasPosition=Vector2.new(0,cs.Y)}):Play()
end
end
end)
end
else
p.PlayerChatted:Connect(function(ct,pl,msg)
if string.find(msg,"#") then
return
end

local chm=cm(pl,msg)
chm.Parent=sf

local cs=ll.AbsoluteContentSize
sf.CanvasSize=UDim2.new(0,0,0,cs.Y)

local cy=sf.CanvasSize.Y.Offset
local wy=sf.AbsoluteWindowSize.Y
local cuy=sf.CanvasPosition.Y
local tol=10

if cuy>=(cy-wy-tol) then
t:Create(sf,TweenInfo.new(0.3),{CanvasPosition=Vector2.new(0,cs.Y)}):Play()
end
end)
end
end

local function opa(pl)
if pl==p.LocalPlayer then
sg.Parent=pl.PlayerGui
scl()
end
end

p.PlayerAdded:Connect(opa)
for _,pl in ipairs(p:GetPlayers()) do
opa(pl)
end
