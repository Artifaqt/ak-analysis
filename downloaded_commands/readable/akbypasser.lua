local tc = game:GetService("TextChatService")
local ch = game:GetService("Chat")
local pl = game:GetService("Players")
local co = game:GetService("CoreGui")
local rs = game:GetService("ReplicatedStorage")
local ui = game:GetService("UserInputService")
local ts = game:GetService("TweenService")

local lp = pl.LocalPlayer
local st = {ab = false, wr = false, sp = "", ph = {}}
local mp = {q="q", w="w", e="e", r="ғ", t="t", y="y", u="ษ", i="เ่", o="o", p="p", a="ล", s="ร", d="d", f="f", g="g", h="Іา", j="ϳ", k="k", l="ӏ", z="z", x="ӿ", c="ჺ", v="v", b="b", n="ค", m="ทา", [" "] = st.sp}
local wt = {boobs = "Ꙏoobs"}
local hs = game:GetService("HttpService")

local sg = Instance.new("ScreenGui")
sg.Name = "CB"
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.Parent = co

local mf = Instance.new("Frame")
mf.Size = UDim2.new(0, 400, 0, 350)
mf.Position = UDim2.new(0.5, -200, 0.5, -175)
mf.BackgroundColor3 = Color3.new(0, 0, 0)
mf.BackgroundTransparency = 0.7
mf.BorderSizePixel = 0
mf.Parent = sg

local cr = Instance.new("UICorner")
cr.CornerRadius = UDim.new(0, 12)
cr.Parent = mf

local tb = Instance.new("Frame")
tb.Size = UDim2.new(1, 0, 0, 40)
tb.BackgroundTransparency = 1
tb.Parent = mf

local tl = Instance.new("TextLabel")
tl.Size = UDim2.new(0, 120, 0, 20)
tl.Position = UDim2.new(0, 10, 0, 5)
tl.BackgroundTransparency = 1
tl.Text = "AK ADMIN"
tl.TextColor3 = Color3.new(1, 1, 1)
tl.TextSize = 12
tl.Font = Enum.Font.GothamBold
tl.TextXAlignment = Enum.TextXAlignment.Left
tl.Parent = tb

local mt = Instance.new("TextLabel")
mt.Size = UDim2.new(1, 0, 1, 0)
mt.BackgroundTransparency = 1
mt.Text = "CHAT BYPASSER"
mt.TextColor3 = Color3.new(1, 1, 1)
mt.TextSize = 16
mt.Font = Enum.Font.GothamBold
mt.Parent = tb

local mn = Instance.new("TextButton")
mn.Size = UDim2.new(0, 30, 0, 30)
mn.Position = UDim2.new(1, -70, 0, 5)
mn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
mn.BackgroundTransparency = 0.5
mn.Text = "-"
mn.TextColor3 = Color3.new(1, 1, 1)
mn.TextSize = 20
mn.Font = Enum.Font.GothamBold
mn.BorderSizePixel = 0
mn.Parent = tb

local mc = Instance.new("UICorner")
mc.CornerRadius = UDim.new(0, 6)
mc.Parent = mn

local cl = Instance.new("TextButton")
cl.Size = UDim2.new(0, 30, 0, 30)
cl.Position = UDim2.new(1, -35, 0, 5)
cl.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
cl.BackgroundTransparency = 0.3
cl.Text = "X"
cl.TextColor3 = Color3.new(1, 1, 1)
cl.TextSize = 16
cl.Font = Enum.Font.GothamBold
cl.BorderSizePixel = 0
cl.Parent = tb

local cc = Instance.new("UICorner")
cc.CornerRadius = UDim.new(0, 6)
cc.Parent = cl

local cf = Instance.new("Frame")
cf.Size = UDim2.new(1, -20, 1, -60)
cf.Position = UDim2.new(0, 10, 0, 50)
cf.BackgroundTransparency = 1
cf.Parent = mf

local t1 = Instance.new("TextLabel")
t1.Size = UDim2.new(1, 0, 0, 30)
t1.BackgroundTransparency = 1
t1.Text = "Auto Bypass"
t1.TextColor3 = Color3.new(1, 1, 1)
t1.TextSize = 14
t1.Font = Enum.Font.Gotham
t1.TextXAlignment = Enum.TextXAlignment.Left
t1.Parent = cf

local b1 = Instance.new("TextButton")
b1.Size = UDim2.new(0, 50, 0, 25)
b1.Position = UDim2.new(1, -55, 0, 2.5)
b1.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
b1.Text = "OFF"
b1.TextColor3 = Color3.new(1, 1, 1)
b1.TextSize = 12
b1.Font = Enum.Font.GothamBold
b1.BorderSizePixel = 0
b1.Parent = t1

local c1 = Instance.new("UICorner")
c1.CornerRadius = UDim.new(0, 6)
c1.Parent = b1

local t2 = Instance.new("TextLabel")
t2.Size = UDim2.new(1, 0, 0, 30)
t2.Position = UDim2.new(0, 0, 0, 40)
t2.BackgroundTransparency = 1
t2.Text = "Wrappers"
t2.TextColor3 = Color3.new(1, 1, 1)
t2.TextSize = 14
t2.Font = Enum.Font.Gotham
t2.TextXAlignment = Enum.TextXAlignment.Left
t2.Parent = cf

local b2 = Instance.new("TextButton")
b2.Size = UDim2.new(0, 50, 0, 25)
b2.Position = UDim2.new(1, -55, 0, 2.5)
b2.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
b2.Text = "OFF"
b2.TextColor3 = Color3.new(1, 1, 1)
b2.TextSize = 12
b2.Font = Enum.Font.GothamBold
b2.BorderSizePixel = 0
b2.Parent = t2

local c2 = Instance.new("UICorner")
c2.CornerRadius = UDim.new(0, 6)
c2.Parent = b2

local b5 = Instance.new("TextButton")
b5.Size = UDim2.new(1, 0, 0, 30)
b5.Position = UDim2.new(0, 0, 0, 75)
b5.BackgroundColor3 = Color3.new(0.9, 0.5, 0.2)
b5.BackgroundTransparency = 0.3
b5.Text = "Fix Tags"
b5.TextColor3 = Color3.new(1, 1, 1)
b5.TextSize = 14
b5.Font = Enum.Font.GothamBold
b5.BorderSizePixel = 0
b5.Parent = cf

local c5 = Instance.new("UICorner")
c5.CornerRadius = UDim.new(0, 6)
c5.Parent = b5

local ss = Instance.new("TextLabel")
ss.Size = UDim2.new(1, 0, 0, 20)
ss.Position = UDim2.new(0, 0, 1, -25)
ss.BackgroundTransparency = 1
ss.Text = ""
ss.TextColor3 = Color3.new(1, 0.3, 0.3)
ss.TextSize = 12
ss.Font = Enum.Font.GothamBold
ss.Parent = mf

local t3 = Instance.new("TextLabel")
t3.Size = UDim2.new(1, 0, 0, 30)
t3.Position = UDim2.new(0, 0, 0, 110)
t3.BackgroundTransparency = 1
t3.Text = "Saved Phrase"
t3.TextColor3 = Color3.new(1, 1, 1)
t3.TextSize = 14
t3.Font = Enum.Font.Gotham
t3.TextXAlignment = Enum.TextXAlignment.Left
t3.Parent = cf

local b3 = Instance.new("TextBox")
b3.Size = UDim2.new(1, -65, 0, 25)
b3.Position = UDim2.new(0, 0, 0, 145)
b3.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
b3.BackgroundTransparency = 0.5
b3.Text = ""
b3.PlaceholderText = "Enter phrase..."
b3.TextColor3 = Color3.new(1, 1, 1)
b3.TextSize = 12
b3.Font = Enum.Font.Gotham
b3.BorderSizePixel = 0
b3.ClearTextOnFocus = false
b3.Parent = cf

local c3 = Instance.new("UICorner")
c3.CornerRadius = UDim.new(0, 6)
c3.Parent = b3

local b4 = Instance.new("TextButton")
b4.Size = UDim2.new(0, 55, 0, 25)
b4.Position = UDim2.new(1, -55, 0, 145)
b4.BackgroundColor3 = Color3.new(0.3, 0.6, 0.9)
b4.BackgroundTransparency = 0.3
b4.Text = "ADD"
b4.TextColor3 = Color3.new(1, 1, 1)
b4.TextSize = 12
b4.Font = Enum.Font.GothamBold
b4.BorderSizePixel = 0
b4.Parent = cf

local c4 = Instance.new("UICorner")
c4.CornerRadius = UDim.new(0, 6)
c4.Parent = b4

local sf = Instance.new("ScrollingFrame")
sf.Size = UDim2.new(1, 0, 0, 105)
sf.Position = UDim2.new(0, 0, 0, 180)
sf.BackgroundTransparency = 1
sf.BorderSizePixel = 0
sf.ScrollBarThickness = 4
sf.Parent = cf

local ul = Instance.new("UIListLayout")
ul.Padding = UDim.new(0, 5)
ul.Parent = sf

local function gb()
    local pg = lp:FindFirstChild("PlayerGui")
    local ec = co:FindFirstChild("ExperienceChat")
    return (ec and ec:FindFirstChild("TextBox", true)) or (pg and pg:FindFirstChild("Chat") and pg.Chat:FindFirstChild("TextBox", true))
end

local function sd(ms)
    if tc.ChatVersion == Enum.ChatVersion.TextChatService then
        pcall(function() tc.TextChannels.RBXGeneral:SendAsync(ms) end)
    else
        pcall(function() rs.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(ms, "All") end)
    end
end

local function it(ms)
    local s, r = pcall(ch.FilterStringForBroadcast, ch, ms, lp)
    return s and r ~= ms
end

local function hn(ms)
    local nw = ms
    for wd, rp in pairs(wt) do
        nw = nw:gsub(wd, rp)
    end
    nw = nw:gsub(".", function(c) return mp[c:lower()] or c end)
    local fn = st.wr and ("˹🕆Ო " .. nw .. " Ო🕆˼") or nw
    if not it(fn) then 
        sd(fn)
        ss.Text = ""
    else
        ss.Text = "Tagged!"
        task.delay(3, function() ss.Text = "" end)
    end
end

local function lf()
    if isfile("cb_phrase.txt") then
        local dt = readfile("cb_phrase.txt")
        local ok, rs = pcall(function() return hs:JSONDecode(dt) end)
        if ok and type(rs) == "table" then
            st.ph = rs
        end
    end
end

local function sv()
    local ok, rs = pcall(function() return hs:JSONEncode(st.ph) end)
    if ok then
        writefile("cb_phrase.txt", rs)
    end
end

local function up()
    for _, ch in pairs(sf:GetChildren()) do
        if ch:IsA("TextButton") then ch:Destroy() end
    end
    
    for i, ph in ipairs(st.ph) do
        local pb = Instance.new("TextButton")
        pb.Size = UDim2.new(1, -15, 0, 30)
        pb.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        pb.BackgroundTransparency = 0.3
        pb.Text = ph
        pb.TextColor3 = Color3.new(1, 1, 1)
        pb.TextSize = 12
        pb.Font = Enum.Font.Gotham
        pb.BorderSizePixel = 0
        pb.TextTruncate = Enum.TextTruncate.AtEnd
        pb.TextXAlignment = Enum.TextXAlignment.Left
        pb.Parent = sf
        
        local pd = Instance.new("UIPadding")
        pd.PaddingLeft = UDim.new(0, 10)
        pd.Parent = pb
        
        local pc = Instance.new("UICorner")
        pc.CornerRadius = UDim.new(0, 6)
        pc.Parent = pb
        
        local dl = Instance.new("TextButton")
        dl.Size = UDim2.new(0, 30, 0, 30)
        dl.Position = UDim2.new(1, -30, 0, 0)
        dl.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
        dl.BackgroundTransparency = 0.3
        dl.Text = "X"
        dl.TextColor3 = Color3.new(1, 1, 1)
        dl.TextSize = 14
        dl.Font = Enum.Font.GothamBold
        dl.BorderSizePixel = 0
        dl.Parent = pb
        
        local dc = Instance.new("UICorner")
        dc.CornerRadius = UDim.new(0, 6)
        dc.Parent = dl
        
        pb.MouseButton1Click:Connect(function()
            hn(ph)
        end)
        
        dl.MouseButton1Click:Connect(function()
            table.remove(st.ph, i)
            sv()
            up()
        end)
    end
    
    sf.CanvasSize = UDim2.new(0, 0, 0, #st.ph * 35 + 5)
end

lf()
up()

b1.MouseButton1Click:Connect(function()
    st.ab = not st.ab
    b1.Text = st.ab and "ON" or "OFF"
    b1.BackgroundColor3 = st.ab and Color3.new(0.2, 0.8, 0.3) or Color3.new(0.3, 0.3, 0.3)
end)

b2.MouseButton1Click:Connect(function()
    st.wr = not st.wr
    b2.Text = st.wr and "ON" or "OFF"
    b2.BackgroundColor3 = st.wr and Color3.new(0.2, 0.8, 0.3) or Color3.new(0.3, 0.3, 0.3)
end)

b5.MouseButton1Click:Connect(function()
    local nw = "Abcdefg()*!"
    local fn = "˹㍹🕆Ო " .. nw .. " Ო🕆㍹˼"
    if not it(fn) then
        sd(fn)
        ss.Text = ""
    else
        ss.Text = "Tagged!"
        task.delay(3, function() ss.Text = "" end)
    end
end)

b3.FocusLost:Connect(function()
end)

b4.MouseButton1Click:Connect(function()
    if b3.Text ~= "" then
        table.insert(st.ph, b3.Text)
        sv()
        up()
        b3.Text = ""
    end
end)

local mi = false
mn.MouseButton1Click:Connect(function()
    mi = not mi
    if mi then
        ts:Create(mf, TweenInfo.new(0.3), {Size = UDim2.new(0, 400, 0, 40)}):Play()
        cf.Visible = false
        mn.Text = "+"
    else
        ts:Create(mf, TweenInfo.new(0.3), {Size = UDim2.new(0, 400, 0, 350)}):Play()
        task.wait(0.3)
        cf.Visible = true
        mn.Text = "-"
    end
end)

cl.MouseButton1Click:Connect(function()
    sg:Destroy()
end)

local dr = false
local ix, iy

tb.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        dr = true
        local px = inp.Position.X
        local py = inp.Position.Y
        ix = px - mf.AbsolutePosition.X
        iy = py - mf.AbsolutePosition.Y
        
        inp.Changed:Connect(function()
            if inp.UserInputState == Enum.UserInputState.End then
                dr = false
            end
        end)
    end
end)

tb.InputChanged:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
        if dr then
            local px = inp.Position.X - ix
            local py = inp.Position.Y - iy
            mf.Position = UDim2.new(0, px, 0, py)
        end
    end
end)

local bx = gb()
if bx then
    bx.FocusLost:Connect(function(en)
        if en and st.ab and bx.Text ~= "" then
            local tx = bx.Text
            bx.Text = ""
            hn(tx)
        end
    end)
end
