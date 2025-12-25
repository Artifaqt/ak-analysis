local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local http = game:GetService("HttpService")
local sg2 = game:GetService("StarterGui")
local rs = game:GetService("RunService")
local TextChatService = game:GetService("TextChatService")
local PhysicsService = game:GetService("PhysicsService")
local me = Players.LocalPlayer

local hp = {}
local mp = {}
local md = {}
local od = {}

local state = {
	hsc = nil,
	hst = nil,
	bsc = nil,
	bst = nil
}

-- Setup collision groups once
pcall(function()
	PhysicsService:CreateCollisionGroup("MorphedPlayers")
	PhysicsService:CollisionGroupSetCollidable("MorphedPlayers", "MorphedPlayers", false)
end)

local function fp(n)
	n = n:lower():match("^%s*(.-)%s*$")
	for _,p in ipairs(Players:GetPlayers()) do
		if p ~= me and (p.Name:lower() == n or p.DisplayName:lower() == n) then
			return p
		end
	end
	for _,p in ipairs(Players:GetPlayers()) do
		if p ~= me and (p.Name:lower():find(n,1,true) or p.DisplayName:lower():find(n,1,true)) then
			return p
		end
	end
end

local function ca(a0,a1,pr)
	local ap = Instance.new("AlignPosition")
	ap.Attachment0 = a0
	ap.Attachment1 = a1
	ap.MaxForce = math.huge
	ap.MaxVelocity = math.huge
	ap.Responsiveness = 200
	ap.Parent = pr

	local ao = Instance.new("AlignOrientation")
	ao.Attachment0 = a0
	ao.Attachment1 = a1
	ao.MaxTorque = math.huge
	ao.MaxAngularVelocity = math.huge
	ao.Responsiveness = 200
	ao.Parent = pr

	return ap,ao
end

local function cu(ch,an)
	if not ch then return end
	local hr = ch:FindFirstChild("HumanoidRootPart")
	if not hr then return end
	if hr:FindFirstChild("AlignPosition") then hr.AlignPosition:Destroy() end
	if hr:FindFirstChild("AlignOrientation") then hr.AlignOrientation:Destroy() end
	if hr:FindFirstChild(an) then hr[an]:Destroy() end
end

local function hs(t)
	if not t or not t.Character or not me.Character then return end
	local th = t.Character:FindFirstChild("Head")
	local hr = me.Character:FindFirstChild("HumanoidRootPart")
	local hm = me.Character:FindFirstChild("Humanoid")
	if not th or not hr or not hm then return end
	
	if state.hsc then state.hsc:Disconnect() end
	cu(me.Character, "PlayerHeadsitAttachment")
	
	state.hst = t
	hr.CFrame = CFrame.new(th.Position + Vector3.new(0,2,0))
	
	local ta = Instance.new("Attachment")
	ta.Name = "HeadsitAttachment"
	ta.Position = Vector3.new(0,1.5,0)
	ta.Parent = th
	
	local pa = Instance.new("Attachment")
	pa.Name = "PlayerHeadsitAttachment"
	pa.Parent = hr
	
	local ap,ao = ca(pa,ta,hr)
	hm.Sit = true
	
	state.hsc = rs.Heartbeat:Connect(function()
		if not state.hst or not state.hst.Character or not state.hst.Character:FindFirstChild("Head") or
		   not me.Character or not me.Character:FindFirstChild("HumanoidRootPart") then
			ap:Destroy()
			ao:Destroy()
			ta:Destroy()
			pa:Destroy()
			state.hsc:Disconnect()
			state.hsc = nil
			state.hst = nil
		elseif hm and not hm.Sit then
			hm.Sit = true
		end
	end)
end

local function uhs()
	if state.hsc then
		state.hsc:Disconnect()
		state.hsc = nil
	end
	cu(me.Character, "PlayerHeadsitAttachment")
	if me.Character and me.Character:FindFirstChild("Humanoid") then
		me.Character.Humanoid.Sit = false
	end
	if state.hst and state.hst.Character then
		local h = state.hst.Character:FindFirstChild("Head")
		if h and h:FindFirstChild("HeadsitAttachment") then
			h.HeadsitAttachment:Destroy()
		end
	end
	state.hst = nil
end

local function bp(t)
	if not t or not t.Character or not me.Character then return end
	local tr = t.Character:FindFirstChild("HumanoidRootPart")
	local hr = me.Character:FindFirstChild("HumanoidRootPart")
	local hm = me.Character:FindFirstChild("Humanoid")
	if not tr or not hr or not hm then return end
	
	if state.bsc then state.bsc:Disconnect() end
	cu(me.Character, "PlayerBackpackAttachment")
	
	state.bst = t
	hr.CFrame = CFrame.new(tr.Position + Vector3.new(0,0,2))
	
	local ta = Instance.new("Attachment")
	ta.Name = "BackpackAttachment"
	ta.Position = Vector3.new(0,0,1)
	ta.Orientation = Vector3.new(0,180,0)
	ta.Parent = tr
	
	local pa = Instance.new("Attachment")
	pa.Name = "PlayerBackpackAttachment"
	pa.Parent = hr
	
	local ap,ao = ca(pa,ta,hr)
	hm.Sit = true
	
	state.bsc = rs.Heartbeat:Connect(function()
		if not state.bst or not state.bst.Character or not state.bst.Character:FindFirstChild("HumanoidRootPart") or
		   not me.Character or not me.Character:FindFirstChild("HumanoidRootPart") then
			ap:Destroy()
			ao:Destroy()
			ta:Destroy()
			pa:Destroy()
			state.bsc:Disconnect()
			state.bsc = nil
			state.bst = nil
		elseif hm and not hm.Sit then
			hm.Sit = true
		end
	end)
end

local function ubp()
	if state.bsc then
		state.bsc:Disconnect()
		state.bsc = nil
	end
	cu(me.Character, "PlayerBackpackAttachment")
	if me.Character and me.Character:FindFirstChild("Humanoid") then
		me.Character.Humanoid.Sit = false
	end
	if state.bst and state.bst.Character then
		local tr = state.bst.Character:FindFirstChild("HumanoidRootPart")
		if tr and tr:FindFirstChild("BackpackAttachment") then
			tr.BackpackAttachment:Destroy()
		end
	end
	state.bst = nil
end

local function inspectPlayer(tp)
	if tp then
		pcall(function()
			GuiService:InspectPlayerFromUserId(tp.UserId)
		end)
	end
end

local function mutePlayer(pl)
	if not pl then return false end
	local ad = pl:FindFirstChildOfClass("AudioDeviceInput")
	if ad then
		ad.Muted = true
		ad.Volume = 0
		mp[pl.UserId] = true
		return true
	else
		return false
	end
end

local function unmutePlayer(pl)
	if not pl then return false end
	local ad = pl:FindFirstChildOfClass("AudioDeviceInput")
	if ad then
		ad.Muted = false
		ad.Volume = 1
		mp[pl.UserId] = nil
		return true
	else
		return false
	end
end

local function hidePlayer(tp)
	if tp then
		hp[tp.UserId] = true
		if tp.Character then
			tp.Character.Parent = nil
		end
		mutePlayer(tp)
	end
end

local function unhidePlayer(tp)
	if tp then
		hp[tp.UserId] = nil
		if tp.Character and not tp.Character.Parent then
			tp.Character.Parent = workspace
		end
		unmutePlayer(tp)
	end
end

local function ae(ch)
	local rt = ch:FindFirstChild("HumanoidRootPart")
	if not rt then return end
	local em = Instance.new("ParticleEmitter")
	em.Texture = "rbxassetid://243098098"
	em.Rate = 50
	em.Lifetime = NumberRange.new(0.5, 1)
	em.Speed = NumberRange.new(5, 10)
	em.SpreadAngle = Vector2.new(360, 360)
	em.Parent = rt
	task.delay(2, function()
		em.Enabled = false
		task.delay(1, function()
			em:Destroy()
		end)
	end)
end

local function so(pl)
	if not od[pl.UserId] then
		local ch = pl.Character
		if ch then
			local hm = ch:FindFirstChild("Humanoid")
			if hm then
				local ok, ds = pcall(function()
					return hm:GetAppliedDescription()
				end)
				if ok and ds then
					od[pl.UserId] = ds
				end
			end
		end
	end
end

local function nc(ch)
	-- Much more efficient: just set all parts to a collision group
	for _, pt in ipairs(ch:GetDescendants()) do
		if pt:IsA("BasePart") then
			pcall(function()
				PhysicsService:SetPartCollisionGroup(pt, "MorphedPlayers")
			end)
		end
	end
end

local function rc(ch)
	-- Remove from collision group (set back to default)
	for _, pt in ipairs(ch:GetDescendants()) do
		if pt:IsA("BasePart") then
			pcall(function()
				PhysicsService:SetPartCollisionGroup(pt, "Default")
			end)
		end
	end
end

local function mc(username, pl)
	-- Save original appearance first
	so(pl)
	
	local ok, userId = pcall(function()
		return Players:GetUserIdFromNameAsync(username)
	end)
	if not ok or not userId or userId == pl.UserId then return end
	
	md[pl.UserId] = username
	
	local character = pl.Character
	if not character then return end
	
	local humanoid = character:FindFirstChild("Humanoid")
	if not humanoid then return end
	
	local ok2, desc = pcall(function()
		return Players:GetHumanoidDescriptionFromUserId(userId)
	end)
	if not ok2 or not desc then return end
	
	for _, v in ipairs(character:GetChildren()) do
		if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") or v:IsA("BodyColors") then
			pcall(function() v:Destroy() end)
		end
	end
	
	local head = character:FindFirstChild("Head")
	if head then
		for _, d in ipairs(head:GetChildren()) do
			if d:IsA("Decal") then
				pcall(function() d:Destroy() end)
			end
		end
	end
	
	pcall(function()
		humanoid:ApplyDescriptionClientServer(desc)
	end)
	
	nc(character)
	ae(character)
end

local function uc(pl)
	md[pl.UserId] = nil
	
	local character = pl.Character
	if not character then return end
	
	local humanoid = character:FindFirstChild("Humanoid")
	if not humanoid then return end
	
	-- Use saved original appearance if available
	local desc
	if od[pl.UserId] then
		desc = od[pl.UserId]
	else
		local ok, fetchedDesc = pcall(function()
			return Players:GetHumanoidDescriptionFromUserId(pl.UserId)
		end)
		if not ok or not fetchedDesc then return end
		desc = fetchedDesc
	end
	
	for _, v in ipairs(character:GetChildren()) do
		if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") or v:IsA("BodyColors") then
			pcall(function() v:Destroy() end)
		end
	end
	
	local head = character:FindFirstChild("Head")
	if head then
		for _, d in ipairs(head:GetChildren()) do
			if d:IsA("Decal") then
				pcall(function() d:Destroy() end)
			end
		end
	end
	
	pcall(function()
		humanoid:ApplyDescriptionClientServer(desc)
	end)
	
	rc(character)
	ae(character)
end

for _, pl in pairs(Players:GetPlayers()) do
	if pl ~= me then
		pl.CharacterAdded:Connect(function(ch)
			task.wait(0.5)
			so(pl)
			if hp[pl.UserId] then
				task.wait()
				hidePlayer(pl)
			end
			if mp[pl.UserId] then
				task.wait(2)
				mutePlayer(pl)
			end
			if md[pl.UserId] then
				task.wait(0.5)
				mc(md[pl.UserId], pl)
			end
		end)
		
		if pl.Character then
			so(pl)
		end
	end
end

Players.PlayerAdded:Connect(function(pl)
	pl.CharacterAdded:Connect(function(ch)
		task.wait(0.5)
		so(pl)
		if hp[pl.UserId] then
			task.wait()
			hidePlayer(pl)
		end
		if mp[pl.UserId] then
			task.wait(2)
			mutePlayer(pl)
		end
		if md[pl.UserId] then
			task.wait(0.5)
			mc(md[pl.UserId], pl)
		end
	end)
	
	if pl.Character then
		so(pl)
	end
end)

me.CharacterAdded:Connect(function(ch)
	task.wait(0.5)
	so(me)
	if md[me.UserId] then
		task.wait(0.5)
		mc(md[me.UserId], me)
	end
end)

-- Listen to chat messages from other players
TextChatService.OnIncomingMessage = function(message)
	-- Only process messages from other players
	if not message.TextSource then return end
	if message.TextSource.UserId == me.UserId then return end
	
	local player = Players:GetPlayerByUserId(message.TextSource.UserId)
	if not player then return end
	
	local text = message.Text
	
	-- Check if message starts with !char
	if text:match("^!char%s+(.+)") then
		local username = text:match("^!char%s+(.+)")
		if username then
			mc(username, player)
		end
	-- Check if message is !unchar
	elseif text == "!unchar" then
		uc(player)
	end
end

return {
	["!to"] = function(a)
		local t = fp(a)
		if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") and
		   me.Character and me.Character:FindFirstChild("HumanoidRootPart") then
			me.Character.HumanoidRootPart.CFrame = CFrame.new(t.Character.HumanoidRootPart.Position + Vector3.new(0,5,0))
		end
	end,
	["!headsit"] = function(a) hs(fp(a)) end,
	["!unheadsit"] = function() uhs() end,
	["!backpack"] = function(a) bp(fp(a)) end,
	["!unbackpack"] = function() ubp() end,
	["!friend"] = function(a)
		local t = fp(a)
		if t then sg2:SetCore("PromptSendFriendRequest", t) end
	end,
	["!unfriend"] = function(a)
		local t = fp(a)
		if t then sg2:SetCore("PromptUnfriend", t) end
	end,
	["!block"] = function(a)
		local t = fp(a)
		if t then sg2:SetCore("PromptBlockPlayer", t) end
	end,
	["!unblock"] = function(a)
		local t = fp(a)
		if t then sg2:SetCore("PromptUnblockPlayer", t) end
	end,
	["!inspect"] = function(a) inspectPlayer(fp(a)) end,
	["!hide"] = function(a) hidePlayer(fp(a)) end,
	["!unhide"] = function(a) unhidePlayer(fp(a)) end,
	["!mute"] = function(a) mutePlayer(fp(a)) end,
	["!unmute"] = function(a) unmutePlayer(fp(a)) end,
	["!char"] = function(a, pl) 
		local tp = pl or me
		mc(a, tp)
	end,
	["!unchar"] = function(a, pl) 
		local tp = pl or me
		uc(tp)
	end,
	["!rj"] = function()
		pcall(function()
			loadstring(game:HttpGet("https://akadmin-bzk.pages.dev/gtarejoin.lua"))()
		end)
	end
}
