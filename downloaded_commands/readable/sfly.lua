local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")
local originalGravity = Workspace.Gravity

local flying = false
local flySpeed = 120 -- Default speed
local isMinimized = false

local currentAnim = nil
local currentAnimTrack = nil
local lastDirection = "none"
local animateScriptDisabled = false

local dragging = false
local dragStartPos, dragStartMousePos
local sliderDragging = false

local function createElement(className, properties, parent)
	local obj = Instance.new(className)
	for prop, val in pairs(properties) do
		obj[prop] = val
	end
	if parent then
		obj.Parent = parent
	end
	return obj
end

local function PlayAnim(id, time, speed)
	pcall(function()
		-- Stop current animation first
		if currentAnimTrack then
			currentAnimTrack:Stop(0.1)
			currentAnimTrack = nil
		end
		
		-- Disable animate script only once when flying starts
		if not animateScriptDisabled and flying then
			if player.Character:FindFirstChild("Animate") then
				player.Character.Animate.Disabled = true
				animateScriptDisabled = true
			end
		end
		
		-- Stop all playing animations
		local animTracks = humanoid:GetPlayingAnimationTracks()
		for i, track in pairs(animTracks) do
			track:Stop(0.1)
		end
		
		-- Create and play new animation
		local anim = Instance.new("Animation")
		anim.AnimationId = "rbxassetid://" .. tostring(id)
		
		local animTrack = humanoid:LoadAnimation(anim)
		animTrack:Play()
		
		if time then
			animTrack.TimePosition = time
		end
		if speed then
			animTrack:AdjustSpeed(speed)
		end
		
		currentAnimTrack = animTrack
		currentAnim = anim
		
		-- Clean up when animation stops
		animTrack.Stopped:Connect(function()
			if currentAnimTrack == animTrack then
				currentAnimTrack = nil
			end
		end)
	end)
end

local function StopAnim()
	-- Stop current custom animation
	if currentAnimTrack then
		currentAnimTrack:Stop(0.1)
		currentAnimTrack = nil
	end
	
	-- Re-enable animate script
	if animateScriptDisabled and player.Character:FindFirstChild("Animate") then
		player.Character.Animate.Disabled = false
		animateScriptDisabled = false
	end
	
	-- Stop all playing animations
	local animTracks = humanoid:GetPlayingAnimationTracks()
	for i, track in pairs(animTracks) do
		track:Stop(0.1)
	end
end

local PlayerModule = require(player.PlayerScripts:WaitForChild("PlayerModule"))
local Controls = PlayerModule:GetControls()

-- Create GUI using the first script's style
local flyGui = createElement("ScreenGui", {Name = "FlyGui", ResetOnSpawn = false}, player:WaitForChild("PlayerGui"))

local mainFrame = createElement("Frame", {
	Name = "MainFrame",
	Size = UDim2.new(0, 200, 0, 105), -- Reduced height since no keybind button
	Position = UDim2.new(0.5, -100, 0.5, -52),
	BackgroundColor3 = Color3.fromRGB(0, 0, 0),
	BackgroundTransparency = 0.6,
	BorderSizePixel = 0,
	Active = true
}, flyGui)
createElement("UICorner", {CornerRadius = UDim.new(0, 10)}, mainFrame)

local titleLabel = createElement("TextLabel", {
	Name = "TitleLabel",
	Size = UDim2.new(1, -60, 0, 30),
	Position = UDim2.new(0, 5, 0, 5),
	BackgroundTransparency = 1,
	Text = "Superman Fly",
	Font = Enum.Font.GothamBold,
	TextSize = 12,
	TextColor3 = Color3.new(1, 1, 1),
	TextXAlignment = Enum.TextXAlignment.Center
}, mainFrame)

local toggleButton = createElement("TextButton", {
	Name = "ToggleButton",
	Size = UDim2.new(0, 190, 0, 25),
	Position = UDim2.new(0, 5, 0, 35),
	BackgroundColor3 = Color3.fromRGB(0, 0, 0),
	BackgroundTransparency = 0.6,
	Text = "FLY: OFF",
	Font = Enum.Font.GothamBold,
	TextSize = 12,
	TextColor3 = Color3.new(1, 1, 1),
	BorderSizePixel = 0
}, mainFrame)
createElement("UICorner", {CornerRadius = UDim.new(0, 5)}, toggleButton)

local speedFrame = createElement("Frame", {
	Name = "SpeedFrame",
	Size = UDim2.new(0, 190, 0, 25),
	Position = UDim2.new(0, 5, 0, 65),
	BackgroundTransparency = 1
}, mainFrame)

local speedLabel = createElement("TextLabel", {
	Name = "SpeedLabel",
	Size = UDim2.new(0, 50, 0, 25),
	Position = UDim2.new(0, 0, 0, 0),
	BackgroundTransparency = 1,
	Text = "SPEED: " .. tostring(flySpeed),
	Font = Enum.Font.GothamBold,
	TextSize = 12,
	TextColor3 = Color3.new(1, 1, 1),
	TextScaled = true
}, speedFrame)

local speedSlider = createElement("Frame", {
	Name = "SpeedSlider",
	Size = UDim2.new(0, 135, 0, 10),
	Position = UDim2.new(0, 55, 0, 8),
	BackgroundColor3 = Color3.fromRGB(50, 50, 50),
	BackgroundTransparency = 0.6,
	BorderSizePixel = 0
}, speedFrame)
createElement("UICorner", {CornerRadius = UDim.new(0, 5)}, speedSlider)

local speedKnob = createElement("Frame", {
	Name = "SpeedKnob",
	Size = UDim2.new(0, 15, 0, 10),
	Position = UDim2.new((flySpeed - 10) / 390, -7.5, 0, 0), -- Updated calculation for 400 max
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 0.2,
	BorderSizePixel = 0
}, speedSlider)
createElement("UICorner", {CornerRadius = UDim.new(0, 5)}, speedKnob)

local minimizeButton = createElement("TextButton", {
	Name = "MinimizeButton",
	Size = UDim2.new(0, 25, 0, 25),
	Position = UDim2.new(1, -55, 0, 5),
	BackgroundColor3 = Color3.fromRGB(0, 0, 0),
	BackgroundTransparency = 0.6,
	Text = "—",
	Font = Enum.Font.GothamBold,
	TextSize = 12,
	TextColor3 = Color3.new(1, 1, 1),
	BorderSizePixel = 0
}, mainFrame)
createElement("UICorner", {CornerRadius = UDim.new(0, 5)}, minimizeButton)

local closeButton = createElement("TextButton", {
	Name = "CloseButton",
	Size = UDim2.new(0, 25, 0, 25),
	Position = UDim2.new(1, -30, 0, 5),
	BackgroundColor3 = Color3.fromRGB(0, 0, 0),
	BackgroundTransparency = 0.6,
	Text = "X",
	Font = Enum.Font.GothamBold,
	TextSize = 12,
	TextColor3 = Color3.new(1, 1, 1),
	BorderSizePixel = 0
}, mainFrame)
createElement("UICorner", {CornerRadius = UDim.new(0, 5)}, closeButton)

-- Dragging functionality
titleLabel.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStartPos = mainFrame.Position
		dragStartMousePos = input.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStartMousePos
		mainFrame.Position = UDim2.new(dragStartPos.X.Scale, dragStartPos.X.Offset + delta.X, dragStartPos.Y.Scale, dragStartPos.Y.Offset + delta.Y)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
		sliderDragging = false
	end
end)

-- Slider functionality
local function updateSlider(mousePos)
	local sliderPos = speedSlider.AbsolutePosition
	local sliderSize = speedSlider.AbsoluteSize
	local relativeX = mousePos.X - sliderPos.X
	local percentage = math.clamp(relativeX / sliderSize.X, 0, 1)
	
	flySpeed = math.floor(10 + (percentage * 390)) -- Speed range: 10-400
	speedLabel.Text = "SPEED: " .. tostring(flySpeed)
	speedKnob.Position = UDim2.new(percentage, -7.5, 0, 0)
end

speedSlider.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		sliderDragging = true
		updateSlider(input.Position)
	end
end)

speedKnob.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		sliderDragging = true
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if sliderDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		updateSlider(input.Position)
	end
end)

-- Minimize functionality
minimizeButton.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	
	local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	
	if isMinimized then
		local tween = TweenService:Create(mainFrame, tweenInfo, {
			Size = UDim2.new(0, 200, 0, 35)
		})
		tween:Play()
		
		toggleButton.Visible = false
		speedFrame.Visible = false
		minimizeButton.Text = "+"
	else
		local tween = TweenService:Create(mainFrame, tweenInfo, {
			Size = UDim2.new(0, 200, 0, 105)
		})
		tween:Play()
		
		wait(0.1)
		toggleButton.Visible = true
		speedFrame.Visible = true
		minimizeButton.Text = "—"
	end
end)

-- Movement state tracking
local moveState = {
	forward = 0,
	backward = 0,
	left = 0,
	right = 0
}

-- Input connections storage
local inputConnections = {}

-- Flight functionality
local function toggleFlight()
	flying = not flying
	toggleButton.Text = flying and "FLY: ON" or "FLY: OFF"
	-- Keep button black with transparency change only
	toggleButton.BackgroundTransparency = flying and 0.4 or 0.6
	
	if flying then
		-- Make character jump before starting flight
		humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		wait(0.1) -- Small delay to let jump start
		
		Workspace.Gravity = 0
		humanoid.PlatformStand = true
		
		-- Start with idle animation
		lastDirection = "idle"
		PlayAnim(10714347256, 4, 0)
		
		local bg = Instance.new("BodyGyro")
		bg.Name = "FlyGyro"
		bg.P = 90000
		bg.maxTorque = Vector3.new(8999999488, 8999999488, 8999999488)
		bg.CFrame = rootPart.CFrame
		bg.Parent = rootPart
		
		local bv = Instance.new("BodyVelocity")
		bv.Name = "FlyVelocity"
		bv.Velocity = Vector3.new(0, 0.1, 0)
		bv.MaxForce = Vector3.new(8999999488, 8999999488, 8999999488)
		bv.Parent = rootPart
		
		-- Input handling for both PC and Mobile
		local function onInputBegan(input, gameProcessed)
			if gameProcessed then return end
			if input.UserInputType == Enum.UserInputType.Keyboard then
				if input.KeyCode == Enum.KeyCode.W then
					moveState.forward = 1
				elseif input.KeyCode == Enum.KeyCode.S then
					moveState.backward = 1
				elseif input.KeyCode == Enum.KeyCode.A then
					moveState.left = 1
				elseif input.KeyCode == Enum.KeyCode.D then
					moveState.right = 1
				end
			end
		end
		
		local function onInputEnded(input, gameProcessed)
			if input.UserInputType == Enum.UserInputType.Keyboard then
				if input.KeyCode == Enum.KeyCode.W then
					moveState.forward = 0
				elseif input.KeyCode == Enum.KeyCode.S then
					moveState.backward = 0
				elseif input.KeyCode == Enum.KeyCode.A then
					moveState.left = 0
				elseif input.KeyCode == Enum.KeyCode.D then
					moveState.right = 0
				end
			end
		end
		
		-- Store connections for cleanup
		inputConnections.inputBegan = UserInputService.InputBegan:Connect(onInputBegan)
		inputConnections.inputEnded = UserInputService.InputEnded:Connect(onInputEnded)
		
		RunService:BindToRenderStep("Fly", Enum.RenderPriority.Camera.Value, function(dt)
			local camera = Workspace.CurrentCamera
			
			-- Get movement from both touch controls and keyboard
			local moveVector = Controls:GetMoveVector()
			local fwd = moveState.forward - moveState.backward + (-moveVector.Z)
			local side = moveState.right - moveState.left + moveVector.X
			
			-- Check if we're actually moving (more sensitive detection)
			local isMoving = math.abs(fwd) > 0.05 or math.abs(side) > 0.05
			
			-- Update animations based on movement with proper state management
			local newDirection = "idle"
			
			if isMoving then
				if fwd > 0.05 then
					newDirection = "forward"
				elseif fwd < -0.05 then
					newDirection = "backward"
				elseif math.abs(side) > 0.05 then
					newDirection = "strafe"
				end
			end
			
			-- Only change animation if direction actually changed
			if newDirection ~= lastDirection then
				lastDirection = newDirection
				
				if newDirection == "forward" then
					PlayAnim(10714177846, 4.65, 0)
				elseif newDirection == "backward" then
					PlayAnim(10147823318, 4.11, 0)
				elseif newDirection == "strafe" then
					PlayAnim(10714177846, 4.65, 0)
				else -- idle
					PlayAnim(10714347256, 4, 0)
				end
			end
			
			-- Calculate movement
			local inputVec = (camera.CFrame.LookVector * fwd) + (camera.CFrame.RightVector * side)
			
			local targetVelocity
			if inputVec.Magnitude > 0 then
				targetVelocity = inputVec.Unit * flySpeed
				-- Add slight upward movement when going forward
				if fwd > 0 then
					targetVelocity = targetVelocity + Vector3.new(0, fwd * 0.2 * flySpeed, 0)
				end
			else
				-- Floating animation when idle - made more noticeable
				local t = tick()
				local floatOffset = math.sin(t * 3) * 2 -- Increased amplitude and frequency
				targetVelocity = Vector3.new(0, 0.1 + floatOffset, 0)
			end
			
			-- Less smooth movement - reduced lerp factor for velocity
			bv.Velocity = bv.Velocity:Lerp(targetVelocity, 0.25) -- Increased from 0.1 to 0.25
			
			-- Body rotation - less smooth
			local forwardTilt = 0
			local sideTilt = side * -45
			
			if fwd > 0.05 then
				forwardTilt = -90
			elseif fwd < -0.05 then
				forwardTilt = 45
			end
			
			local targetCFrame = camera.CFrame * CFrame.Angles(math.rad(forwardTilt), 0, math.rad(sideTilt))
			-- Less smooth rotation - increased lerp factor
			bg.CFrame = bg.CFrame:Lerp(targetCFrame, 0.2) -- Increased from 0.1 to 0.2
		end)
		
	else
		Workspace.Gravity = originalGravity
		humanoid.PlatformStand = false
		lastDirection = "none"
		moveState = {forward = 0, backward = 0, left = 0, right = 0}
		StopAnim()
		
		-- Clean up connections
		for name, connection in pairs(inputConnections) do
			if connection then
				connection:Disconnect()
			end
		end
		inputConnections = {}
		
		if rootPart:FindFirstChild("FlyGyro") then rootPart.FlyGyro:Destroy() end
		if rootPart:FindFirstChild("FlyVelocity") then rootPart.FlyVelocity:Destroy() end
		RunService:UnbindFromRenderStep("Fly")
	end
end

-- Connect toggle button
toggleButton.MouseButton1Click:Connect(toggleFlight)

-- Close button functionality
closeButton.MouseButton1Click:Connect(function()
	if flying then
		toggleFlight() -- Turn off fly if it's on
	end
	flyGui:Destroy()
end)

-- Character respawn handling
player.CharacterAdded:Connect(function(newCharacter)
	character = newCharacter
	humanoid = character:WaitForChild("Humanoid")
	rootPart = character:WaitForChild("HumanoidRootPart")
	animateScriptDisabled = false
	currentAnim = nil
	currentAnimTrack = nil
	lastDirection = "none"
	
	if flying then
		flying = false
		toggleButton.Text = "FLY: OFF"
		toggleButton.BackgroundTransparency = 0.6
		Workspace.Gravity = originalGravity
		
		-- Clean up connections
		for name, connection in pairs(inputConnections) do
			if connection then
				connection:Disconnect()
			end
		end
		inputConnections = {}
		
		RunService:UnbindFromRenderStep("Fly")
	end
end)


--[[
=======================
DESKTOP VERSION BELOW
=======================
]]--

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")
local originalGravity = Workspace.Gravity

local isFlying = false
local flightSpeed = 120 -- Default speed increased from 50 to 120
local toggleKey = Enum.KeyCode.X
local waitingForKeybind = false
local isMinimized = false

local moveState = {
	forward = 0,
	backward = 0,
	left = 0,
	right = 0
}

local currentCF = nil
local currentRoll = 0
local maxRoll = 45
local lerpCoef = 0.2 -- Increased from 0.1 for less smooth movement

local slideDamping = 0.05
local currentVelocity = Vector3.new(0, 0, 0)

local bobbingFrequency = 3 -- Increased from 1 for more noticeable bobbing
local bobbingAmplitude = 2 -- Increased from 0.5 for more noticeable bobbing

local flightConns = {}
local globalConns = {}

local currentAnimTrack = nil

local function disableDefaultAnimate()
	local animate = character:FindFirstChild("Animate")
	if animate then
		animate.Disabled = true
	end
end

local function enableDefaultAnimate()
	local animate = character:FindFirstChild("Animate")
	if animate then
		animate.Disabled = false
	end
end

local function playAnimation(animId, startTime, speed)
	if currentAnimTrack then
		currentAnimTrack:Stop(0.1)
		currentAnimTrack = nil
	end
	disableDefaultAnimate()
	for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
		track:Stop()
	end
	local anim = Instance.new("Animation")
	anim.AnimationId = "rbxassetid://" .. tostring(animId)
	currentAnimTrack = humanoid:LoadAnimation(anim)
	currentAnimTrack:Play()
	currentAnimTrack.TimePosition = startTime
	currentAnimTrack:AdjustSpeed(speed)
end

local function stopAnimation()
	if currentAnimTrack then
		currentAnimTrack:Stop(0.1)
		currentAnimTrack = nil
	end
	enableDefaultAnimate()
	for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
		track:Stop()
	end
end

local function createElement(className, properties, parent)
	local obj = Instance.new(className)
	for prop, val in pairs(properties) do
		obj[prop] = val
	end
	if parent then
		obj.Parent = parent
	end
	return obj
end

local flyGui = createElement("ScreenGui", {Name = "FlyGui", ResetOnSpawn = false}, player:WaitForChild("PlayerGui"))

local mainFrame = createElement("Frame", {
	Name = "MainFrame",
	Size = UDim2.new(0, 200, 0, 135),
	Position = UDim2.new(0.5, -100, 0.5, -67),
	BackgroundColor3 = Color3.fromRGB(0, 0, 0),
	BackgroundTransparency = 0.6,
	BorderSizePixel = 0,
	Active = true
}, flyGui)
createElement("UICorner", {CornerRadius = UDim.new(0, 10)}, mainFrame)

local titleLabel = createElement("TextLabel", {
	Name = "TitleLabel",
	Size = UDim2.new(1, -60, 0, 30),
	Position = UDim2.new(0, 5, 0, 5),
	BackgroundTransparency = 1,
	Text = "Superman Fly",
	Font = Enum.Font.GothamBold,
	TextSize = 12,
	TextColor3 = Color3.new(1, 1, 1),
	TextXAlignment = Enum.TextXAlignment.Center
}, mainFrame)

local toggleButton = createElement("TextButton", {
	Name = "ToggleButton",
	Size = UDim2.new(0, 190, 0, 25),
	Position = UDim2.new(0, 5, 0, 35),
	BackgroundColor3 = Color3.fromRGB(0, 0, 0),
	BackgroundTransparency = 0.6,
	Text = "FLY: OFF",
	Font = Enum.Font.GothamBold,
	TextSize = 12,
	TextColor3 = Color3.new(1, 1, 1),
	BorderSizePixel = 0
}, mainFrame)
createElement("UICorner", {CornerRadius = UDim.new(0, 5)}, toggleButton)

local speedFrame = createElement("Frame", {
	Name = "SpeedFrame",
	Size = UDim2.new(0, 190, 0, 25),
	Position = UDim2.new(0, 5, 0, 65),
	BackgroundTransparency = 1
}, mainFrame)

local speedLabel = createElement("TextLabel", {
	Name = "SpeedLabel",
	Size = UDim2.new(0, 50, 0, 25),
	Position = UDim2.new(0, 0, 0, 0),
	BackgroundTransparency = 1,
	Text = "SPEED: " .. tostring(flightSpeed),
	Font = Enum.Font.GothamBold,
	TextSize = 12,
	TextColor3 = Color3.new(1, 1, 1),
	TextScaled = true
}, speedFrame)

local speedSlider = createElement("Frame", {
	Name = "SpeedSlider",
	Size = UDim2.new(0, 135, 0, 10),
	Position = UDim2.new(0, 55, 0, 8),
	BackgroundColor3 = Color3.fromRGB(50, 50, 50),
	BackgroundTransparency = 0.6,
	BorderSizePixel = 0
}, speedFrame)
createElement("UICorner", {CornerRadius = UDim.new(0, 5)}, speedSlider)

local speedKnob = createElement("Frame", {
	Name = "SpeedKnob",
	Size = UDim2.new(0, 15, 0, 10),
	Position = UDim2.new((flightSpeed - 10) / 390, -7.5, 0, 0), -- Updated calculation for 400 max
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 0.2,
	BorderSizePixel = 0
}, speedSlider)
createElement("UICorner", {CornerRadius = UDim.new(0, 5)}, speedKnob)

local keybindButton = createElement("TextButton", {
	Name = "KeybindButton",
	Size = UDim2.new(0, 190, 0, 25),
	Position = UDim2.new(0, 5, 0, 95),
	BackgroundColor3 = Color3.fromRGB(0, 0, 0),
	BackgroundTransparency = 0.6,
	Text = "KEYBIND: " .. toggleKey.Name,
	Font = Enum.Font.GothamBold,
	TextSize = 12,
	TextColor3 = Color3.new(1, 1, 1),
	BorderSizePixel = 0
}, mainFrame)
createElement("UICorner", {CornerRadius = UDim.new(0, 5)}, keybindButton)

local minimizeButton = createElement("TextButton", {
	Name = "MinimizeButton",
	Size = UDim2.new(0, 25, 0, 25),
	Position = UDim2.new(1, -55, 0, 5),
	BackgroundColor3 = Color3.fromRGB(0, 0, 0),
	BackgroundTransparency = 0.6,
	Text = "—",
	Font = Enum.Font.GothamBold,
	TextSize = 12,
	TextColor3 = Color3.new(1, 1, 1),
	BorderSizePixel = 0
}, mainFrame)
createElement("UICorner", {CornerRadius = UDim.new(0, 5)}, minimizeButton)

local closeButton = createElement("TextButton", {
	Name = "CloseButton",
	Size = UDim2.new(0, 25, 0, 25),
	Position = UDim2.new(1, -30, 0, 5),
	BackgroundColor3 = Color3.fromRGB(0, 0, 0),
	BackgroundTransparency = 0.6,
	Text = "X",
	Font = Enum.Font.GothamBold,
	TextSize = 12,
	TextColor3 = Color3.new(1, 1, 1),
	BorderSizePixel = 0
}, mainFrame)
createElement("UICorner", {CornerRadius = UDim.new(0, 5)}, closeButton)

local dragging = false
local dragStartPos, dragStartMousePos
local sliderDragging = false

titleLabel.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStartPos = mainFrame.Position
		dragStartMousePos = input.Position
	end
end)

titleLabel.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStartMousePos
		mainFrame.Position = UDim2.new(dragStartPos.X.Scale, dragStartPos.X.Offset + delta.X, dragStartPos.Y.Scale, dragStartPos.Y.Offset + delta.Y)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
		sliderDragging = false
	end
end)

local function updateSlider(mousePos)
	local sliderPos = speedSlider.AbsolutePosition
	local sliderSize = speedSlider.AbsoluteSize
	local relativeX = mousePos.X - sliderPos.X
	local percentage = math.clamp(relativeX / sliderSize.X, 0, 1)
	
	flightSpeed = math.floor(10 + (percentage * 390)) -- Speed range: 10-400
	speedLabel.Text = "SPEED: " .. tostring(flightSpeed)
	speedKnob.Position = UDim2.new(percentage, -7.5, 0, 0)
end

speedSlider.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		sliderDragging = true
		updateSlider(input.Position)
	end
end)

speedKnob.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		sliderDragging = true
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if sliderDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		updateSlider(input.Position)
	end
end)

keybindButton.MouseButton1Click:Connect(function()
	waitingForKeybind = true
	keybindButton.Text = "PRESS ANY KEY..."
				keybindButton.BackgroundTransparency = 0.4
end)

minimizeButton.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	
	local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	
	if isMinimized then
		local tween = TweenService:Create(mainFrame, tweenInfo, {
			Size = UDim2.new(0, 200, 0, 35)
		})
		tween:Play()
		
		toggleButton.Visible = false
		speedFrame.Visible = false
		keybindButton.Visible = false
		minimizeButton.Text = "+"
	else
		local tween = TweenService:Create(mainFrame, tweenInfo, {
			Size = UDim2.new(0, 200, 0, 135)
		})
		tween:Play()
		
		wait(0.1)
		toggleButton.Visible = true
		speedFrame.Visible = true
		keybindButton.Visible = true
		minimizeButton.Text = "—"
	end
end)

local function onGlobalInput(input, gameProcessed)
	if gameProcessed then return end
	if input.UserInputType == Enum.UserInputType.Keyboard then
		if waitingForKeybind then
			local ignored = {
				Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift,
				Enum.KeyCode.LeftControl, Enum.KeyCode.RightControl,
				Enum.KeyCode.LeftAlt, Enum.KeyCode.RightAlt,
				Enum.KeyCode.LeftSuper, Enum.KeyCode.RightSuper,
				Enum.KeyCode.Unknown
			}
			for _, key in ipairs(ignored) do
				if input.KeyCode == key then
					return
				end
			end
			waitingForKeybind = false
			toggleKey = input.KeyCode
			keybindButton.Text = "KEYBIND: " .. toggleKey.Name
			keybindButton.BackgroundTransparency = 0.6
		elseif input.KeyCode == toggleKey then
			if not isFlying then
				-- Make character jump before starting flight
				humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				wait(0.1) -- Small delay to let jump start
				
				isFlying = true
				toggleButton.Text = "FLY: ON"
				toggleButton.BackgroundTransparency = 0.4
				
				Workspace.Gravity = 0
				humanoid.PlatformStand = true
				playAnimation(10714347256, 4, 0)
				
				local gyro = Instance.new("BodyGyro")
				gyro.Name = "FlyGyro"
				gyro.Parent = hrp
				gyro.P = 90000
				gyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
				gyro.CFrame = hrp.CFrame
				
				local bv = Instance.new("BodyVelocity")
				bv.Name = "FlyVelocity"
				bv.Parent = hrp
				bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
				bv.Velocity = Vector3.new(0, 0.1, 0)
				
				currentVelocity = Vector3.new(0, 0, 0)
				
				local flightUpdate = RunService.RenderStepped:Connect(function(deltaTime)
					local cam = Workspace.CurrentCamera
					
					local fwd = moveState.forward - moveState.backward
					local side = moveState.right - moveState.left
					
					local inputVec = (cam.CFrame.LookVector * fwd) + (cam.CFrame.RightVector * side)
					
					if fwd ~= 0 then
						inputVec = inputVec + Vector3.new(0, 0.2 * fwd, 0)
					end
					
					local bobbing = math.sin(tick() * bobbingFrequency) * bobbingAmplitude
					local desiredVelocity = Vector3.new(0, 0, 0)
					if inputVec.Magnitude > 0 then
						desiredVelocity = inputVec.Unit * flightSpeed
					else
						desiredVelocity = Vector3.new(0, bobbing, 0)
					end
					
					-- Less smooth movement - increased lerp factor
					currentVelocity = currentVelocity:Lerp(desiredVelocity, 0.25) -- Increased from 0.1
					bv.Velocity = currentVelocity
					
					local desiredCF
					if fwd > 0 then
						desiredCF = cam.CFrame * CFrame.Angles(math.rad(-90), 0, math.rad(currentRoll))
					else
						desiredCF = cam.CFrame * CFrame.Angles(math.rad(-45 * fwd), 0, math.rad(currentRoll))
					end
					if currentCF then
						currentCF = currentCF:Lerp(desiredCF, lerpCoef)
					else
						currentCF = desiredCF
					end
					gyro.CFrame = currentCF
				end)
				table.insert(flightConns, flightUpdate)
				
				local function onFlyInputBegan(input, gameProc)
					if gameProc then return end
					if input.UserInputType == Enum.UserInputType.Keyboard then
						local key = input.KeyCode
						if key == Enum.KeyCode.W then
							moveState.forward = 1
							playAnimation(10714177846, 4.65, 0)
						elseif key == Enum.KeyCode.S then
							moveState.backward = 1
							playAnimation(10714347256, 4, 0)
						elseif key == Enum.KeyCode.A then
							moveState.left = 1
							if moveState.forward > 0 then
								playAnimation(10714177846, 4.65, 0)
							end
						elseif key == Enum.KeyCode.D then
							moveState.right = 1
							if moveState.forward > 0 then
								playAnimation(10714177846, 4.65, 0)
							end
						end
					end
				end
				local flyBegan = UserInputService.InputBegan:Connect(onFlyInputBegan)
				table.insert(flightConns, flyBegan)
				
				local function onFlyInputEnded(input, gameProc)
					if input.UserInputType == Enum.UserInputType.Keyboard then
						local key = input.KeyCode
						if key == Enum.KeyCode.W then
							moveState.forward = 0
							playAnimation(10714347256, 4, 0)
						elseif key == Enum.KeyCode.S then
							moveState.backward = 0
							playAnimation(10714347256, 4, 0)
						elseif key == Enum.KeyCode.A then
							moveState.left = 0
							if moveState.forward > 0 then
								playAnimation(10714177846, 4.65, 0)
							end
						elseif key == Enum.KeyCode.D then
							moveState.right = 0
							if moveState.forward > 0 then
								playAnimation(10714177846, 4.65, 0)
							end
						end
					end
				end
				local flyEnded = UserInputService.InputEnded:Connect(onFlyInputEnded)
				table.insert(flightConns, flyEnded)
				
			else
				isFlying = false
				toggleButton.Text = "FLY: OFF"
				toggleButton.BackgroundTransparency = 0.6
				
				Workspace.Gravity = originalGravity
				humanoid.PlatformStand = false
				stopAnimation()
				if hrp:FindFirstChild("FlyGyro") then hrp.FlyGyro:Destroy() end
				if hrp:FindFirstChild("FlyVelocity") then hrp.FlyVelocity:Destroy() end
				for _, conn in ipairs(flightConns) do
					if conn.Connected then conn:Disconnect() end
				end
				flightConns = {}
				moveState = {forward = 0, backward = 0, left = 0, right = 0}
			end
		end
	end
end
local globalInputConn = UserInputService.InputBegan:Connect(onGlobalInput)
table.insert(globalConns, globalInputConn)

toggleButton.MouseButton1Click:Connect(function()
	onGlobalInput({KeyCode = toggleKey, UserInputType = Enum.UserInputType.Keyboard}, false)
end)

player.CharacterAdded:Connect(function(newChar)
	character = newChar
	humanoid = character:WaitForChild("Humanoid")
	hrp = character:WaitForChild("HumanoidRootPart")
	if isFlying then
		isFlying = false
		toggleButton.Text = "FLY: OFF"
		toggleButton.BackgroundTransparency = 0.6
		Workspace.Gravity = originalGravity
		humanoid.PlatformStand = false
		stopAnimation()
		if hrp:FindFirstChild("FlyGyro") then hrp.FlyGyro:Destroy() end
		if hrp:FindFirstChild("FlyVelocity") then hrp.FlyVelocity:Destroy() end
		for _, conn in ipairs(flightConns) do
			if conn.Connected then conn:Disconnect() end
		end
		flightConns = {}
		moveState = {forward = 0, backward = 0, left = 0, right = 0}
	end
end)

closeButton.MouseButton1Click:Connect(function()
	if isFlying then
		isFlying = false
		Workspace.Gravity = originalGravity
		humanoid.PlatformStand = false
		stopAnimation()
		if hrp:FindFirstChild("FlyGyro") then hrp.FlyGyro:Destroy() end
		if hrp:FindFirstChild("FlyVelocity") then hrp.FlyVelocity:Destroy() end
		for _, conn in ipairs(flightConns) do
			if conn.Connected then conn:Disconnect() end
		end
		flightConns = {}
	end
	for _, conn in ipairs(globalConns) do
		if conn.Connected then conn:Disconnect() end
	end
	flyGui:Destroy()
	script:Destroy()
end)
