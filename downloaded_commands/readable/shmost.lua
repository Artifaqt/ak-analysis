-- Enhanced Auto Teleport to Highest Population Server Script
-- Features: Sleek black transparent UI, smooth animations, optimized server selection
-- Prioritizes actual highest player counts with intelligent filtering

local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Configuration
local visitedServersFileName = "VisitedServers_" .. game.PlaceId .. ".json"
local minimumAcceptablePlayerCount = 8 -- Minimum players to consider
local maximumPreferredPlayerCount = math.floor(Players.MaxPlayers * 0.95) -- Don't join nearly full servers
local minimumSpaceRequired = 1 -- Minimum open slots needed
local maxRetries = 15 -- Maximum attempts 
local maxServerPages = 8 -- How many pages of servers to fetch (more comprehensive search)
local serverBlacklist = {} -- Servers to avoid

-- Animation settings
local ANIMATION_SPEED = 0.6
local EASE_STYLE = Enum.EasingStyle.Quart
local EASE_DIRECTION = Enum.EasingDirection.Out

-- Create sleek GUI with black transparency
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TeleportStatusGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game:GetService("CoreGui")

-- Main container with backdrop blur effect simulation
local BackdropFrame = Instance.new("Frame")
BackdropFrame.Name = "BackdropFrame"
BackdropFrame.Size = UDim2.new(0, 380, 0, 140)
BackdropFrame.Position = UDim2.new(0.5, -190, 0.1, 0)
BackdropFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BackdropFrame.BackgroundTransparency = 0.3
BackdropFrame.BorderSizePixel = 0
BackdropFrame.Parent = ScreenGui

local BackdropCorner = Instance.new("UICorner")
BackdropCorner.CornerRadius = UDim.new(0, 16)
BackdropCorner.Parent = BackdropFrame

-- Subtle border glow
local BorderFrame = Instance.new("Frame")
BorderFrame.Name = "BorderFrame"
BorderFrame.Size = UDim2.new(1, 2, 1, 2)
BorderFrame.Position = UDim2.new(0, -1, 0, -1)
BorderFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BorderFrame.BackgroundTransparency = 0.9
BorderFrame.BorderSizePixel = 0
BorderFrame.Parent = BackdropFrame

local BorderCorner = Instance.new("UICorner")
BorderCorner.CornerRadius = UDim.new(0, 17)
BorderCorner.Parent = BorderFrame

-- Content frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -24, 1, -24)
ContentFrame.Position = UDim2.new(0, 12, 0, 12)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = BackdropFrame

-- Title with subtle animation
local TitleText = Instance.new("TextLabel")
TitleText.Name = "TitleText"
TitleText.Size = UDim2.new(1, -40, 0, 24)
TitleText.Position = UDim2.new(0, 0, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "3-5 Slot Server Finder"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 18
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.TextTransparency = 0.1
TitleText.Parent = ContentFrame

-- Status text with smooth updates
local StatusText = Instance.new("TextLabel")
StatusText.Name = "StatusText"
StatusText.Size = UDim2.new(1, -40, 0, 40)
StatusText.Position = UDim2.new(0, 0, 0, 28)
StatusText.BackgroundTransparency = 1
StatusText.Text = "Initializing advanced server search..."
StatusText.TextColor3 = Color3.fromRGB(220, 220, 220)
StatusText.TextSize = 14
StatusText.Font = Enum.Font.Gotham
StatusText.TextWrapped = true
StatusText.TextYAlignment = Enum.TextYAlignment.Top
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.TextTransparency = 0.2
StatusText.Parent = ContentFrame

-- Enhanced stats display
local StatsText = Instance.new("TextLabel")
StatsText.Name = "StatsText"
StatsText.Size = UDim2.new(1, -40, 0, 16)
StatsText.Position = UDim2.new(0, 0, 0, 72)
StatsText.BackgroundTransparency = 1
StatsText.Text = "Servers analyzed: 0 | Highest found: 0 players"
StatsText.TextColor3 = Color3.fromRGB(180, 180, 180)
StatsText.TextSize = 12
StatsText.Font = Enum.Font.Gotham
StatsText.TextXAlignment = Enum.TextXAlignment.Left
StatsText.TextTransparency = 0.3
StatsText.Parent = ContentFrame

-- Sleek progress bar with glow effect
local ProgressContainer = Instance.new("Frame")
ProgressContainer.Name = "ProgressContainer"
ProgressContainer.Size = UDim2.new(1, -40, 0, 6)
ProgressContainer.Position = UDim2.new(0, 0, 1, -20)
ProgressContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ProgressContainer.BackgroundTransparency = 0.4
ProgressContainer.BorderSizePixel = 0
ProgressContainer.Parent = ContentFrame

local ProgressCorner = Instance.new("UICorner")
ProgressCorner.CornerRadius = UDim.new(1, 0)
ProgressCorner.Parent = ProgressContainer

local ProgressBar = Instance.new("Frame")
ProgressBar.Name = "ProgressBar"
ProgressBar.Size = UDim2.new(0, 0, 1, 0)
ProgressBar.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
ProgressBar.BorderSizePixel = 0
ProgressBar.Parent = ProgressContainer

local ProgressBarCorner = Instance.new("UICorner")
ProgressBarCorner.CornerRadius = UDim.new(1, 0)
ProgressBarCorner.Parent = ProgressBar

-- Glow effect for progress bar
local ProgressGlow = Instance.new("Frame")
ProgressGlow.Name = "ProgressGlow"
ProgressGlow.Size = UDim2.new(1, 4, 1, 4)
ProgressGlow.Position = UDim2.new(0, -2, 0, -2)
ProgressGlow.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
ProgressGlow.BackgroundTransparency = 0.7
ProgressGlow.BorderSizePixel = 0
ProgressGlow.Parent = ProgressBar

local GlowCorner = Instance.new("UICorner")
GlowCorner.CornerRadius = UDim.new(1, 0)
GlowCorner.Parent = ProgressGlow

-- Sleek close button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 24, 0, 24)
CloseButton.Position = UDim2.new(1, -24, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseButton.BackgroundTransparency = 0.8
CloseButton.BorderSizePixel = 0
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextTransparency = 0.2
CloseButton.Parent = ContentFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton

-- Close button animations
CloseButton.MouseEnter:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2, EASE_STYLE, EASE_DIRECTION), {BackgroundTransparency = 0.3}):Play()
end)

CloseButton.MouseLeave:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2, EASE_STYLE, EASE_DIRECTION), {BackgroundTransparency = 0.8}):Play()
end)

CloseButton.MouseButton1Click:Connect(function()
    local fadeOut = TweenService:Create(BackdropFrame, TweenInfo.new(0.3, EASE_STYLE, EASE_DIRECTION), {
        Size = UDim2.new(0, 320, 0, 100),
        Position = UDim2.new(0.5, -160, 0.1, 20),
        BackgroundTransparency = 1
    })
    
    local contentFade = TweenService:Create(ContentFrame, TweenInfo.new(0.2, EASE_STYLE, EASE_DIRECTION), {
        Position = UDim2.new(0, 12, 0, 32)
    })
    
    fadeOut:Play()
    contentFade:Play()
    
    fadeOut.Completed:Connect(function()
        ScreenGui:Destroy()
    end)
end)

-- Smooth animation functions
local function AnimateStatus(message, progress)
    -- Animate text change
    local textFade = TweenService:Create(StatusText, TweenInfo.new(0.2, EASE_STYLE, EASE_DIRECTION), {TextTransparency = 0.8})
    textFade:Play()
    
    textFade.Completed:Connect(function()
        StatusText.Text = message
        TweenService:Create(StatusText, TweenInfo.new(0.2, EASE_STYLE, EASE_DIRECTION), {TextTransparency = 0.2}):Play()
    end)
    
    -- Animate progress bar
    local progressTween = TweenService:Create(ProgressBar, TweenInfo.new(ANIMATION_SPEED, EASE_STYLE, EASE_DIRECTION), {
        Size = UDim2.new(math.max(0.02, progress), 0, 1, 0)
    })
    progressTween:Play()
    
    -- Animate glow intensity based on progress
    local glowIntensity = 0.9 - (progress * 0.2)
    TweenService:Create(ProgressGlow, TweenInfo.new(ANIMATION_SPEED, EASE_STYLE, EASE_DIRECTION), {
        BackgroundTransparency = glowIntensity
    }):Play()
end

local function AnimateStats(serversChecked, highestPlayerCount)
    local statsFade = TweenService:Create(StatsText, TweenInfo.new(0.15, EASE_STYLE, EASE_DIRECTION), {TextTransparency = 0.6})
    statsFade:Play()
    
    statsFade.Completed:Connect(function()
        StatsText.Text = "Servers analyzed: " .. serversChecked .. " | Highest found: " .. highestPlayerCount .. " players"
        TweenService:Create(StatsText, TweenInfo.new(0.15, EASE_STYLE, EASE_DIRECTION), {TextTransparency = 0.3}):Play()
    end)
end

-- Enhanced server storage functions
local function LoadVisitedServers()
    local success, result = pcall(function()
        if not isfolder("ServerHistory") then
            makefolder("ServerHistory")
        end
        
        local filePath = "ServerHistory/" .. visitedServersFileName
        if isfile(filePath) then
            return HttpService:JSONDecode(readfile(filePath))
        else
            return {}
        end
    end)
    
    return success and result or {}
end

local function SaveVisitedServers(visitedServers)
    pcall(function()
        if not isfolder("ServerHistory") then
            makefolder("ServerHistory")
        end
        
        local filePath = "ServerHistory/" .. visitedServersFileName
        writefile(filePath, HttpService:JSONEncode(visitedServers))
    end)
end

local function AddCurrentServerToVisited(visitedServers)
    local currentServerGuid = game.JobId
    if currentServerGuid ~= "" then
        visitedServers[currentServerGuid] = {
            timestamp = os.time(),
            playerCount = #Players:GetPlayers()
        }
        SaveVisitedServers(visitedServers)
    end
end

-- Enhanced server fetching with better error handling
local function GetAllServers()
    local allServers = {}
    local cursor = ""
    local pageCount = 0
    local maxRetryAttempts = 3
    
    repeat
        local success, result = false, nil
        local retryCount = 0
        
        -- Retry mechanism for each page
        repeat
            retryCount = retryCount + 1
            success, result = pcall(function()
                local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"
                if cursor ~= "" then
                    url = url .. "&cursor=" .. cursor
                end
                return HttpService:JSONDecode(game:HttpGet(url))
            end)
            
            if not success then
                wait(retryCount * 0.5) -- Exponential backoff
            end
        until success or retryCount >= maxRetryAttempts
        
        if success and result and result.data then
            for _, server in ipairs(result.data) do
                -- Only add servers with valid data
                if server.id and server.playing and server.maxPlayers then
                    table.insert(allServers, server)
                end
            end
            
            cursor = result.nextPageCursor or ""
            pageCount = pageCount + 1
            
            AnimateStatus("Fetching server data... Page " .. pageCount .. "/" .. maxServerPages, 
                         0.1 + (pageCount / maxServerPages) * 0.3)
            wait(0.1)
        else
            cursor = ""
        end
    until cursor == "" or pageCount >= maxServerPages
    
    return allServers
end

-- Optimized server selection algorithm focused on highest player counts
local function FindHighestPopulationServer(serverList, visitedServers, excludeServerIds)
    excludeServerIds = excludeServerIds or {}
    local bestServer = nil
    local highestPlayerCount = 0
    local serversChecked = 0
    local candidates = {}
    
    -- First pass: collect all viable servers
    for _, server in pairs(serverList) do
        serversChecked = serversChecked + 1
        
        -- Skip excluded servers
        if excludeServerIds[server.id] or serverBlacklist[server.id] or server.id == game.JobId then
            continue
        end
        
        local playerCount = server.playing or 0
        local maxPlayers = server.maxPlayers or Players.MaxPlayers
        local spaceAvailable = maxPlayers - playerCount
        
        -- Basic filtering
        if playerCount < minimumAcceptablePlayerCount or spaceAvailable < minimumSpaceRequired then
            continue
        end
        
        -- Avoid nearly full servers that might reject us
        if playerCount > maximumPreferredPlayerCount then
            continue
        end
        
        -- Update highest count found
        if playerCount > highestPlayerCount then
            highestPlayerCount = playerCount
        end
        
        -- Add to candidates with priority scoring
        local priority = playerCount * 100  -- Base score from player count
        
        -- Recently visited penalty (but don't completely exclude)
        if visitedServers[server.id] then
            local timeAgo = os.time() - visitedServers[server.id].timestamp
            if timeAgo < 1800 then -- 30 minutes
                priority = priority - 500
            elseif timeAgo < 3600 then -- 1 hour
                priority = priority - 200
            end
        else
            priority = priority + 100 -- Bonus for unvisited servers
        end
        
        -- Small bonus for having reasonable space (not too empty, not too full)
        local idealOccupancy = maxPlayers * 0.7
        if math.abs(playerCount - idealOccupancy) < maxPlayers * 0.2 then
            priority = priority + 50
        end
        
        table.insert(candidates, {
            server = server,
            priority = priority,
            playerCount = playerCount
        })
        
        -- Update stats periodically
        if serversChecked % 20 == 0 then
            AnimateStats(serversChecked, highestPlayerCount)
        end
    end
    
    -- Sort candidates by priority (highest first)
    table.sort(candidates, function(a, b)
        return a.priority > b.priority
    end)
    
    -- Return the top candidate
    if #candidates > 0 then
        bestServer = candidates[1].server
        AnimateStats(serversChecked, highestPlayerCount)
        return bestServer, candidates[1].priority, highestPlayerCount
    end
    
    AnimateStats(serversChecked, highestPlayerCount)
    return nil, 0, highestPlayerCount
end

-- Enhanced teleport handling
local failedTeleports = {}
local teleportTarget = nil
local retryCount = 0

TeleportService.TeleportInitFailed:Connect(function(player, teleportResult, errorMessage)
    if player == LocalPlayer then
        local failReason = teleportResult.Name
        
        if failReason == "GameEnded" or failReason == "GameFull" or failReason == "Unauthorized" then
            if retryCount < maxRetries then
                retryCount = retryCount + 1
                AnimateStatus("Server unavailable. Finding alternative... (Attempt " .. retryCount .. "/" .. maxRetries .. ")", 0.4)
                
                if teleportTarget and teleportTarget.id then
                    failedTeleports[teleportTarget.id] = true
                end
                
                spawn(function()
                    wait(1)
                    TeleportToHighestPopulationServer()
                end)
            else
                AnimateStatus("Unable to find available server after " .. maxRetries .. " attempts.", 1)
            end
        else
            AnimateStatus("Teleport failed: " .. failReason, 1)
        end
    end
end)

-- Main teleport function with enhanced algorithm
function TeleportToHighestPopulationServer()
    AnimateStatus("Initializing enhanced server search...", 0.05)
    
    local visitedServers = LoadVisitedServers()
    AddCurrentServerToVisited(visitedServers)
    
    AnimateStatus("Fetching comprehensive server list...", 0.1)
    
    local allServers = GetAllServers()
    if #allServers == 0 then
        AnimateStatus("No servers available. Please try again later.", 1)
        return
    end
    
    AnimateStatus("Analyzing " .. #allServers .. " servers for highest population...", 0.4)
    
    local targetServer, serverPriority, highestFound = FindHighestPopulationServer(allServers, visitedServers, failedTeleports)
    
    -- Fallback attempts with relaxed criteria
    local attempts = 0
    while not targetServer and attempts < 3 do
        attempts = attempts + 1
        AnimateStatus("Expanding search criteria... (Attempt " .. attempts .. "/3)", 0.6)
        
        if attempts >= 2 then
            visitedServers = {} -- Clear visited history
        end
        
        -- Relax minimum player count for fallback
        local originalMin = minimumAcceptablePlayerCount
        minimumAcceptablePlayerCount = math.max(1, minimumAcceptablePlayerCount - (attempts * 3))
        
        targetServer, serverPriority, highestFound = FindHighestPopulationServer(allServers, visitedServers, failedTeleports)
        
        minimumAcceptablePlayerCount = originalMin
    end
    
    if targetServer then
        local playerCount = targetServer.playing
        local spaceAvailable = (targetServer.maxPlayers or Players.MaxPlayers) - playerCount
        
        AnimateStatus("Found optimal server: " .. playerCount .. " players (" .. spaceAvailable .. " slots available)", 0.9)
        
        teleportTarget = targetServer
        
        wait(0.8) -- Show status briefly
        
        AnimateStatus("Joining high population server...", 1)
        
        local teleportSuccess, teleportError = pcall(function()
            TeleportService:TeleportToPlaceInstance(game.PlaceId, targetServer.id, LocalPlayer)
        end)
        
        if not teleportSuccess and retryCount < maxRetries then
            retryCount = retryCount + 1
            failedTeleports[targetServer.id] = true
            AnimateStatus("Connection failed. Trying next server...", 0.5)
            
            spawn(function()
                wait(1)
                TeleportToHighestPopulationServer()
            end)
        end
    else
        AnimateStatus("No suitable high-population servers found at this time.", 1)
    end
end

-- Retry button with sleek design
local RetryButton = Instance.new("TextButton")
RetryButton.Name = "RetryButton"
RetryButton.Size = UDim2.new(0, 120, 0, 32)
RetryButton.Position = UDim2.new(0.5, -60, 1, 15)
RetryButton.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
RetryButton.BackgroundTransparency = 0.2
RetryButton.BorderSizePixel = 0
RetryButton.Text = "Search Again"
RetryButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RetryButton.TextSize = 14
RetryButton.Font = Enum.Font.GothamSemibold
RetryButton.TextTransparency = 0.1
RetryButton.Parent = BackdropFrame

local RetryCorner = Instance.new("UICorner")
RetryCorner.CornerRadius = UDim.new(0, 8)
RetryCorner.Parent = RetryButton

-- Retry button animations
RetryButton.MouseEnter:Connect(function()
    TweenService:Create(RetryButton, TweenInfo.new(0.2, EASE_STYLE, EASE_DIRECTION), {
        BackgroundTransparency = 0.1,
        Size = UDim2.new(0, 125, 0, 34)
    }):Play()
end)

RetryButton.MouseLeave:Connect(function()
    TweenService:Create(RetryButton, TweenInfo.new(0.2, EASE_STYLE, EASE_DIRECTION), {
        BackgroundTransparency = 0.2,
        Size = UDim2.new(0, 120, 0, 32)
    }):Play()
end)

RetryButton.MouseButton1Click:Connect(function()
    retryCount = 0
    failedTeleports = {}
    AnimateStatus("Restarting enhanced server search...", 0.05)
    spawn(TeleportToHighestPopulationServer)
end)

-- Initial entrance animation
BackdropFrame.Size = UDim2.new(0, 300, 0, 100)
BackdropFrame.Position = UDim2.new(0.5, -150, 0.1, 30)
BackdropFrame.BackgroundTransparency = 1

local entranceAnim = TweenService:Create(BackdropFrame, TweenInfo.new(0.8, EASE_STYLE, EASE_DIRECTION), {
    Size = UDim2.new(0, 380, 0, 140),
    Position = UDim2.new(0.5, -190, 0.1, 0),
    BackgroundTransparency = 0.3
})

entranceAnim:Play()

-- Start the enhanced teleport process
spawn(function()
    wait(0.5) -- Allow entrance animation to complete
    TeleportToHighestPopulationServer()
end)
