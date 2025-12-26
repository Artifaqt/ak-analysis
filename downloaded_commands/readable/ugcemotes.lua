local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local HttpService = game:GetService("HttpService");
local TweenService = game:GetService("TweenService");
local localPlayer = Players.LocalPlayer;
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: playerGui (ref)
    if playerGui:FindFirstChild("UGCEmotes") then
        playerGui:FindFirstChild("UGCEmotes"):Destroy();
    end;
end);
local screenGui = Instance.new("ScreenGui");
screenGui.Name = "UGCEmotes";
screenGui.Parent = playerGui;
local mainFrame = Instance.new("Frame");
mainFrame.Size = UDim2.new(0, 280, 0, 350);
mainFrame.Position = UDim2.new(0.5, -140, 0.5, -175);
mainFrame.BackgroundColor3 = Color3.new(0, 0, 0);
mainFrame.BackgroundTransparency = 0.6;
mainFrame.BorderSizePixel = 0;
mainFrame.Parent = screenGui;
local l_UICorner_0 = Instance.new("UICorner");
l_UICorner_0.CornerRadius = UDim.new(0, 15);
l_UICorner_0.Parent = mainFrame;
local titleBar = Instance.new("Frame");
titleBar.Size = UDim2.new(1, 0, 0, 30);
titleBar.Position = UDim2.new(0, 0, 0, 0);
titleBar.BackgroundTransparency = 1;
titleBar.BorderSizePixel = 0;
titleBar.Parent = mainFrame;
local titleLabel = Instance.new("TextLabel");
titleLabel.Size = UDim2.new(1, -60, 1, 0);
titleLabel.Position = UDim2.new(0, 30, 0, 0);
titleLabel.BackgroundTransparency = 1;
titleLabel.Text = "UGC Emotes";
titleLabel.TextColor3 = Color3.new(1, 1, 1);
titleLabel.TextSize = 16;
titleLabel.Font = Enum.Font.Gotham;
titleLabel.TextXAlignment = Enum.TextXAlignment.Center;
titleLabel.Parent = titleBar;
local minimizeButton = Instance.new("TextButton");
minimizeButton.Size = UDim2.new(0, 22, 0, 22);
minimizeButton.Position = UDim2.new(1, -48, 0, 4);
minimizeButton.BackgroundColor3 = Color3.new(0, 0, 0);
minimizeButton.BackgroundTransparency = 0.7;
minimizeButton.Text = "\226\136\146";
minimizeButton.TextColor3 = Color3.new(1, 1, 1);
minimizeButton.TextScaled = true;
minimizeButton.Font = Enum.Font.Gotham;
minimizeButton.BorderSizePixel = 0;
minimizeButton.Parent = titleBar;
local l_UICorner_1 = Instance.new("UICorner");
l_UICorner_1.CornerRadius = UDim.new(0, 10);
l_UICorner_1.Parent = minimizeButton;
local closeButton = Instance.new("TextButton");
closeButton.Size = UDim2.new(0, 22, 0, 22);
closeButton.Position = UDim2.new(1, -24, 0, 4);
closeButton.BackgroundColor3 = Color3.new(0, 0, 0);
closeButton.BackgroundTransparency = 0.7;
closeButton.Text = "\195\151";
closeButton.TextColor3 = Color3.new(1, 1, 1);
closeButton.TextScaled = true;
closeButton.Font = Enum.Font.Gotham;
closeButton.BorderSizePixel = 0;
closeButton.Parent = titleBar;
local l_UICorner_2 = Instance.new("UICorner");
l_UICorner_2.CornerRadius = UDim.new(0, 10);
l_UICorner_2.Parent = closeButton;
local statusLabel = Instance.new("TextLabel");
statusLabel.Size = UDim2.new(1, -16, 0, 12);
statusLabel.Position = UDim2.new(0, 8, 0, 32);
statusLabel.BackgroundTransparency = 1;
statusLabel.Text = "Loading...";
statusLabel.TextColor3 = Color3.new(0.7, 0.7, 0.7);
statusLabel.TextSize = 10;
statusLabel.Font = Enum.Font.Gotham;
statusLabel.Parent = mainFrame;
local tabBar = Instance.new("Frame");
tabBar.Size = UDim2.new(1, -16, 0, 25);
tabBar.Position = UDim2.new(0, 8, 0, 48);
tabBar.BackgroundTransparency = 1;
tabBar.Parent = mainFrame;
local tabAllButton = Instance.new("TextButton");
tabAllButton.Size = UDim2.new(0.33, -2, 1, 0);
tabAllButton.Position = UDim2.new(0, 0, 0, 0);
tabAllButton.BackgroundColor3 = Color3.new(0, 0, 0);
tabAllButton.BackgroundTransparency = 0.7;
tabAllButton.Text = "All";
tabAllButton.TextColor3 = Color3.new(1, 1, 1);
tabAllButton.TextSize = 12;
tabAllButton.Font = Enum.Font.Gotham;
tabAllButton.BorderSizePixel = 0;
tabAllButton.Parent = tabBar;
local tabFavoritesButton = Instance.new("TextButton");
tabFavoritesButton.Size = UDim2.new(0.33, -2, 1, 0);
tabFavoritesButton.Position = UDim2.new(0.33, 2, 0, 0);
tabFavoritesButton.BackgroundColor3 = Color3.new(0, 0, 0);
tabFavoritesButton.BackgroundTransparency = 0.8;
tabFavoritesButton.Text = "Favorites";
tabFavoritesButton.TextColor3 = Color3.new(1, 1, 1);
tabFavoritesButton.TextSize = 12;
tabFavoritesButton.Font = Enum.Font.Gotham;
tabFavoritesButton.BorderSizePixel = 0;
tabFavoritesButton.Parent = tabBar;
local tabCustomButton = Instance.new("TextButton");
tabCustomButton.Size = UDim2.new(0.33, -2, 1, 0);
tabCustomButton.Position = UDim2.new(0.66, 4, 0, 0);
tabCustomButton.BackgroundColor3 = Color3.new(0, 0, 0);
tabCustomButton.BackgroundTransparency = 0.8;
tabCustomButton.Text = "Custom";
tabCustomButton.TextColor3 = Color3.new(1, 1, 1);
tabCustomButton.TextSize = 12;
tabCustomButton.Font = Enum.Font.Gotham;
tabCustomButton.BorderSizePixel = 0;
tabCustomButton.Parent = tabBar;
local l_UICorner_3 = Instance.new("UICorner");
l_UICorner_3.CornerRadius = UDim.new(0, 10);
l_UICorner_3.Parent = tabAllButton;
local l_UICorner_4 = Instance.new("UICorner");
l_UICorner_4.CornerRadius = UDim.new(0, 10);
l_UICorner_4.Parent = tabFavoritesButton;
local l_UICorner_5 = Instance.new("UICorner");
l_UICorner_5.CornerRadius = UDim.new(0, 10);
l_UICorner_5.Parent = tabCustomButton;
local searchBox = Instance.new("TextBox");
searchBox.Size = UDim2.new(1, -16, 0, 22);
searchBox.Position = UDim2.new(0, 8, 0, 78);
searchBox.BackgroundColor3 = Color3.new(0, 0, 0);
searchBox.BackgroundTransparency = 0.5;
searchBox.Text = "";
searchBox.PlaceholderText = "Search...";
searchBox.TextColor3 = Color3.new(1, 1, 1);
searchBox.PlaceholderColor3 = Color3.new(0.7, 0.7, 0.7);
searchBox.TextSize = 11;
searchBox.Font = Enum.Font.Gotham;
searchBox.BorderSizePixel = 0;
searchBox.Parent = mainFrame;
local l_UICorner_6 = Instance.new("UICorner");
l_UICorner_6.CornerRadius = UDim.new(0, 10);
l_UICorner_6.Parent = searchBox;
local customAddPanel = Instance.new("Frame");
customAddPanel.Size = UDim2.new(1, -16, 0, 50);
customAddPanel.Position = UDim2.new(0, 8, 0, 105);
customAddPanel.BackgroundTransparency = 1;
customAddPanel.Visible = false;
customAddPanel.Parent = mainFrame;
local customNameBox = Instance.new("TextBox");
customNameBox.Size = UDim2.new(1, 0, 0, 20);
customNameBox.Position = UDim2.new(0, 0, 0, 0);
customNameBox.BackgroundColor3 = Color3.new(0, 0, 0);
customNameBox.BackgroundTransparency = 0.5;
customNameBox.Text = "";
customNameBox.PlaceholderText = "Animation Name...";
customNameBox.TextColor3 = Color3.new(1, 1, 1);
customNameBox.PlaceholderColor3 = Color3.new(0.7, 0.7, 0.7);
customNameBox.TextSize = 11;
customNameBox.Font = Enum.Font.Gotham;
customNameBox.BorderSizePixel = 0;
customNameBox.Parent = customAddPanel;
local l_UICorner_7 = Instance.new("UICorner");
l_UICorner_7.CornerRadius = UDim.new(0, 10);
l_UICorner_7.Parent = customNameBox;
local customIdBox = Instance.new("TextBox");
customIdBox.Size = UDim2.new(0.7, -2, 0, 20);
customIdBox.Position = UDim2.new(0, 0, 0, 25);
customIdBox.BackgroundColor3 = Color3.new(0, 0, 0);
customIdBox.BackgroundTransparency = 0.5;
customIdBox.Text = "";
customIdBox.PlaceholderText = "Animation ID...";
customIdBox.TextColor3 = Color3.new(1, 1, 1);
customIdBox.PlaceholderColor3 = Color3.new(0.7, 0.7, 0.7);
customIdBox.TextSize = 11;
customIdBox.Font = Enum.Font.Gotham;
customIdBox.BorderSizePixel = 0;
customIdBox.Parent = customAddPanel;
local l_UICorner_8 = Instance.new("UICorner");
l_UICorner_8.CornerRadius = UDim.new(0, 10);
l_UICorner_8.Parent = customIdBox;
local customAddButton = Instance.new("TextButton");
customAddButton.Size = UDim2.new(0.3, 0, 0, 20);
customAddButton.Position = UDim2.new(0.7, 2, 0, 25);
customAddButton.BackgroundColor3 = Color3.new(0, 0.5, 0);
customAddButton.BackgroundTransparency = 0.3;
customAddButton.Text = "Add";
customAddButton.TextColor3 = Color3.new(1, 1, 1);
customAddButton.TextSize = 11;
customAddButton.Font = Enum.Font.Gotham;
customAddButton.BorderSizePixel = 0;
customAddButton.Parent = customAddPanel;
local l_UICorner_9 = Instance.new("UICorner");
l_UICorner_9.CornerRadius = UDim.new(0, 10);
l_UICorner_9.Parent = customAddButton;
local listScrollFrame = Instance.new("ScrollingFrame");
listScrollFrame.Size = UDim2.new(1, -16, 1, -140);
listScrollFrame.Position = UDim2.new(0, 8, 0, 105);
listScrollFrame.BackgroundTransparency = 1;
listScrollFrame.ScrollBarThickness = 4;
listScrollFrame.ScrollBarImageColor3 = Color3.new(1, 1, 1);
listScrollFrame.ScrollBarImageTransparency = 0.5;
listScrollFrame.BorderSizePixel = 0;
listScrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y;
listScrollFrame.Parent = mainFrame;
local listLayout = Instance.new("UIListLayout");
listLayout.Padding = UDim.new(0, 3);
listLayout.SortOrder = Enum.SortOrder.LayoutOrder;
listLayout.Parent = listScrollFrame;
local speedBar = Instance.new("Frame");
speedBar.Size = UDim2.new(1, -16, 0, 25);
speedBar.Position = UDim2.new(0, 8, 1, -30);
speedBar.BackgroundTransparency = 1;
speedBar.Parent = mainFrame;
local speedLabel = Instance.new("TextLabel");
speedLabel.Size = UDim2.new(0, 40, 1, 0);
speedLabel.Position = UDim2.new(0, 0, 0, 0);
speedLabel.BackgroundTransparency = 1;
speedLabel.Text = "Speed:";
speedLabel.TextColor3 = Color3.new(1, 1, 1);
speedLabel.TextSize = 10;
speedLabel.Font = Enum.Font.Gotham;
speedLabel.TextXAlignment = Enum.TextXAlignment.Left;
speedLabel.Parent = speedBar;
local speedSliderTrack = Instance.new("Frame");
speedSliderTrack.Size = UDim2.new(1, -130, 0, 4);
speedSliderTrack.Position = UDim2.new(0, 45, 0.5, -2);
speedSliderTrack.BackgroundColor3 = Color3.new(0, 0, 0);
speedSliderTrack.BackgroundTransparency = 0.5;
speedSliderTrack.BorderSizePixel = 0;
speedSliderTrack.Parent = speedBar;
local l_UICorner_10 = Instance.new("UICorner");
l_UICorner_10.CornerRadius = UDim.new(0, 2);
l_UICorner_10.Parent = speedSliderTrack;
local speedSliderKnob = Instance.new("Frame");
speedSliderKnob.Size = UDim2.new(0, 12, 0, 12);
speedSliderKnob.Position = UDim2.new(0.5, -6, 0.5, -6);
speedSliderKnob.BackgroundColor3 = Color3.new(1, 1, 1);
speedSliderKnob.BackgroundTransparency = 0.2;
speedSliderKnob.BorderSizePixel = 0;
speedSliderKnob.Parent = speedSliderTrack;
local l_UICorner_11 = Instance.new("UICorner");
l_UICorner_11.CornerRadius = UDim.new(0, 6);
l_UICorner_11.Parent = speedSliderKnob;
local speedValueLabel = Instance.new("TextLabel");
speedValueLabel.Size = UDim2.new(0, 35, 1, 0);
speedValueLabel.Position = UDim2.new(1, -70, 0, 0);
speedValueLabel.BackgroundTransparency = 1;
speedValueLabel.Text = "1.0x";
speedValueLabel.TextColor3 = Color3.new(1, 1, 1);
speedValueLabel.TextSize = 10;
speedValueLabel.Font = Enum.Font.Gotham;
speedValueLabel.TextXAlignment = Enum.TextXAlignment.Right;
speedValueLabel.Parent = speedBar;
local speedResetButton = Instance.new("TextButton");
speedResetButton.Size = UDim2.new(0, 30, 0, 16);
speedResetButton.Position = UDim2.new(1, -30, 0.5, -8);
speedResetButton.BackgroundColor3 = Color3.new(0, 0, 0);
speedResetButton.BackgroundTransparency = 0.5;
speedResetButton.Text = "Reset";
speedResetButton.TextColor3 = Color3.new(1, 1, 1);
speedResetButton.TextSize = 8;
speedResetButton.Font = Enum.Font.Gotham;
speedResetButton.BorderSizePixel = 0;
speedResetButton.Parent = speedBar;
local l_UICorner_12 = Instance.new("UICorner");
l_UICorner_12.CornerRadius = UDim.new(0, 8);
l_UICorner_12.Parent = speedResetButton;
local emoteCatalog = {};
local favoriteById = {};
local keybindById = {};
local customEmotes = {};
local activeTab = "all";
local activeEmoteId = nil;
local activeEmoteTrack = nil;
local playbackSpeed = 1;
local isMinimized = false;
local isMinimizeTweening = false;
local contentWidgets = {
    statusLabel, 
    tabBar, 
    searchBox, 
    listScrollFrame, 
    speedBar, 
    customAddPanel
};
local function saveFavoritesToDisk() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: favoriteById (ref), HttpService (ref)
    pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
        -- upvalues: favoriteById (ref), HttpService (ref)
        if writefile then
            local favoritesToSaveById = {};
            for emoteIdKey, isFavorite in pairs(favoriteById) do
                if isFavorite then
                    favoritesToSaveById[tostring(emoteIdKey)] = true;
                end;
            end;
            local favoritesJson = HttpService:JSONEncode(favoritesToSaveById);
            writefile("ugc_emotes_favorites.json", favoritesJson);
        end;
    end);
end;
local function saveCustomToDisk() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: HttpService (ref), customEmotes (ref)
    pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
        -- upvalues: HttpService (ref), customEmotes (ref)
        if writefile then
            local customEmotesJson = HttpService:JSONEncode(customEmotes);
            writefile("ugc_emotes_custom.json", customEmotesJson);
        end;
    end);
end;
local function loadFavoritesFromDisk() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: HttpService (ref), favoriteById (ref)
    pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
        -- upvalues: HttpService (ref), favoriteById (ref)
        if readfile and isfile and isfile("ugc_emotes_favorites.json") then
            local favoritesFileContents = readfile("ugc_emotes_favorites.json");
            do
                local l_v61_0 = favoritesFileContents;
                if l_v61_0 and l_v61_0 ~= "" and l_v61_0 ~= "null" then
                    local l_status_0, l_result_0 = pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
                        -- upvalues: HttpService (ref), l_v61_0 (ref)
                        return HttpService:JSONDecode(l_v61_0);
                    end);
                    if l_status_0 and type(l_result_0) == "table" then
                        favoriteById = {};
                        for savedEmoteIdKey, savedIsFavorite in pairs(l_result_0) do
                            if savedIsFavorite then
                                favoriteById[tonumber(savedEmoteIdKey) or savedEmoteIdKey] = true;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end);
end;
local function loadCustomFromDisk() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: HttpService (ref), customEmotes (ref)
    pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
        -- upvalues: HttpService (ref), customEmotes (ref)
        if readfile and isfile and isfile("ugc_emotes_custom.json") then
            local customFileContents = readfile("ugc_emotes_custom.json");
            do
                local l_v68_0 = customFileContents;
                if l_v68_0 and l_v68_0 ~= "" and l_v68_0 ~= "null" then
                    local l_status_1, l_result_1 = pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
                        -- upvalues: HttpService (ref), l_v68_0 (ref)
                        return HttpService:JSONDecode(l_v68_0);
                    end);
                    if l_status_1 and type(l_result_1) == "table" then
                        customEmotes = l_result_1;
                    end;
                end;
            end;
        end;
    end);
end;
loadFavoritesFromDisk();
loadCustomFromDisk();
local function togglePlayEmote(emoteId, emoteName) --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: localPlayer (ref), statusLabel (ref), activeEmoteId (ref), activeEmoteTrack (ref), playbackSpeed (ref)
    local l_Character_0 = localPlayer.Character;
    local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid");
    if not l_Character_0 or not humanoid then
        statusLabel.Text = "No character";
        statusLabel.TextColor3 = Color3.new(1, 0.5, 0.5);
        return;
    elseif activeEmoteId == emoteId then
        for _, animTrackOrNil in pairs(humanoid:GetPlayingAnimationTracks()) do
            if animTrackOrNil.Priority == Enum.AnimationPriority.Action then
                animTrackOrNil:Stop();
            end;
        end;
        activeEmoteId = nil;
        activeEmoteTrack = nil;
        statusLabel.Text = "Stopped: " .. emoteName;
        statusLabel.TextColor3 = Color3.new(1, 1, 0.5);
        spawn(function() --[[ Line: 0 ]] --[[ Name:  ]]
            -- upvalues: statusLabel (ref)
            wait(2);
            statusLabel.Text = "Ready";
            statusLabel.TextColor3 = Color3.new(0.7, 0.7, 0.7);
        end);
        return;
    else
        for _, animationObj in pairs(humanoid:GetPlayingAnimationTracks()) do
            if animationObj.Priority == Enum.AnimationPriority.Action then
                animationObj:Stop();
            end;
        end;
        pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
            -- upvalues: emoteId (ref), humanoid (ref), playbackSpeed (ref), activeEmoteId (ref), activeEmoteTrack (ref), statusLabel (ref), emoteName (ref)
            local l_Animation_0 = Instance.new("Animation");
            l_Animation_0.AnimationId = "rbxassetid://" .. emoteId;
            local emoteTrack = humanoid:LoadAnimation(l_Animation_0);
            emoteTrack.Priority = Enum.AnimationPriority.Action;
            emoteTrack.Looped = true;
            emoteTrack:Play();
            emoteTrack:AdjustSpeed(playbackSpeed);
            emoteTrack.TimePosition = 0.1;
            activeEmoteId = emoteId;
            activeEmoteTrack = emoteTrack;
            statusLabel.Text = "Playing: " .. emoteName .. " (" .. string.format("%.2fx", playbackSpeed) .. ")";
            statusLabel.TextColor3 = Color3.new(0.5, 1, 0.5);
            spawn(function() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: statusLabel (ref)
                wait(2);
                statusLabel.Text = "Ready";
                statusLabel.TextColor3 = Color3.new(0.7, 0.7, 0.7);
            end);
            l_Animation_0:Destroy();
        end);
        return;
    end;
end;
local function createEmoteRow(rowEmote, showDeleteButton) --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: listScrollFrame (ref), favoriteById (ref), keybindById (ref), togglePlayEmote (ref), saveFavoritesToDisk (ref), activeTab (ref), statusLabel (ref), UserInputService (ref), customEmotes (ref), saveCustomToDisk (ref)
    local l_Frame_7 = Instance.new("Frame");
    l_Frame_7.Size = UDim2.new(1, 0, 0, 35);
    l_Frame_7.BackgroundTransparency = 1;
    l_Frame_7.Parent = listScrollFrame;
    local mainButtonSize = showDeleteButton and UDim2.new(1, -100, 1, 0) or UDim2.new(1, -70, 1, 0);
    local l_TextButton_7 = Instance.new("TextButton");
    l_TextButton_7.Size = mainButtonSize;
    l_TextButton_7.Position = UDim2.new(0, 0, 0, 0);
    l_TextButton_7.BackgroundColor3 = Color3.new(0, 0, 0);
    l_TextButton_7.BackgroundTransparency = 0.5;
    l_TextButton_7.Text = " " .. rowEmote.name;
    l_TextButton_7.TextColor3 = Color3.new(1, 1, 1);
    l_TextButton_7.TextSize = 12;
    l_TextButton_7.Font = Enum.Font.Gotham;
    l_TextButton_7.TextXAlignment = Enum.TextXAlignment.Left;
    l_TextButton_7.BorderSizePixel = 0;
    l_TextButton_7.Parent = l_Frame_7;
    local l_UICorner_13 = Instance.new("UICorner");
    l_UICorner_13.CornerRadius = UDim.new(0, 12);
    l_UICorner_13.Parent = l_TextButton_7;
    local l_TextButton_8 = Instance.new("TextButton");
    l_TextButton_8.Size = UDim2.new(0, 32, 1, 0);
    l_TextButton_8.Position = UDim2.new(1, showDeleteButton and -98 or -66, 0, 0);
    l_TextButton_8.BackgroundTransparency = 1;
    l_TextButton_8.Text = favoriteById[rowEmote.id] and "\226\152\133" or "\226\152\134";
    l_TextButton_8.TextColor3 = favoriteById[rowEmote.id] and Color3.new(1, 0.8, 0) or Color3.new(0.7, 0.7, 0.7);
    l_TextButton_8.TextSize = 16;
    l_TextButton_8.BorderSizePixel = 0;
    l_TextButton_8.Parent = l_Frame_7;
    local l_TextButton_9 = Instance.new("TextButton");
    l_TextButton_9.Size = UDim2.new(0, 32, 1, 0);
    l_TextButton_9.Position = UDim2.new(1, showDeleteButton and -64 or -32, 0, 0);
    l_TextButton_9.BackgroundTransparency = 1;
    l_TextButton_9.Text = keybindById[rowEmote.id] and keybindById[rowEmote.id].Name:gsub("KeyCode%.", ""):sub(1, 3) or "Bind";
    l_TextButton_9.TextColor3 = Color3.new(0.8, 0.8, 0.8);
    l_TextButton_9.TextSize = 8;
    l_TextButton_9.Font = Enum.Font.Gotham;
    l_TextButton_9.BorderSizePixel = 0;
    l_TextButton_9.Parent = l_Frame_7;
    local deleteButton = nil;
    if showDeleteButton then
        deleteButton = Instance.new("TextButton");
        deleteButton.Size = UDim2.new(0, 30, 1, 0);
        deleteButton.Position = UDim2.new(1, -30, 0, 0);
        deleteButton.BackgroundColor3 = Color3.new(0.5, 0, 0);
        deleteButton.BackgroundTransparency = 0.3;
        deleteButton.Text = "Del";
        deleteButton.TextColor3 = Color3.new(1, 1, 1);
        deleteButton.TextSize = 8;
        deleteButton.Font = Enum.Font.Gotham;
        deleteButton.BorderSizePixel = 0;
        deleteButton.Parent = l_Frame_7;
        local l_UICorner_14 = Instance.new("UICorner");
        l_UICorner_14.CornerRadius = UDim.new(0, 12);
        l_UICorner_14.Parent = deleteButton;
    end;
    l_TextButton_7.MouseEnter:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
        -- upvalues: l_TextButton_7 (ref)
        l_TextButton_7.BackgroundTransparency = 0.3;
    end);
    l_TextButton_7.MouseLeave:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
        -- upvalues: l_TextButton_7 (ref)
        l_TextButton_7.BackgroundTransparency = 0.5;
    end);
    l_TextButton_7.MouseButton1Click:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
        -- upvalues: togglePlayEmote (ref), rowEmote (ref)
        togglePlayEmote(rowEmote.id, rowEmote.name);
    end);
    l_TextButton_8.MouseButton1Click:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
        -- upvalues: favoriteById (ref), rowEmote (ref), l_TextButton_8 (ref), saveFavoritesToDisk (ref), activeTab (ref)
        if favoriteById[rowEmote.id] then
            favoriteById[rowEmote.id] = nil;
            l_TextButton_8.Text = "\226\152\134";
            l_TextButton_8.TextColor3 = Color3.new(0.7, 0.7, 0.7);
        else
            favoriteById[rowEmote.id] = true;
            l_TextButton_8.Text = "\226\152\133";
            l_TextButton_8.TextColor3 = Color3.new(1, 0.8, 0);
        end;
        saveFavoritesToDisk();
        if activeTab == "favorites" then
            spawn(function() --[[ Line: 0 ]] --[[ Name:  ]]
                wait(0.1);
                loadGUI();
            end);
        end;
    end);
    l_TextButton_9.MouseButton1Click:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
        -- upvalues: statusLabel (ref), UserInputService (ref), keybindById (ref), rowEmote (ref), l_TextButton_9 (ref)
        statusLabel.Text = "Press any key to bind...";
        statusLabel.TextColor3 = Color3.new(1, 1, 0.5);
        local keybindCaptureConnection = nil;
        keybindCaptureConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed) --[[ Line: 0 ]] --[[ Name:  ]]
            -- upvalues: keybindById (ref), rowEmote (ref), l_TextButton_9 (ref), statusLabel (ref), keybindCaptureConnection (ref)
            if gameProcessed then
                return;
            else
                if input.KeyCode ~= Enum.KeyCode.Unknown then
                    keybindById[rowEmote.id] = input.KeyCode;
                    l_TextButton_9.Text = input.KeyCode.Name:gsub("KeyCode%.", ""):sub(1, 3);
                    l_TextButton_9.TextColor3 = Color3.new(1, 1, 1);
                    statusLabel.Text = "Bound to " .. input.KeyCode.Name:gsub("KeyCode%.", "");
                    statusLabel.TextColor3 = Color3.new(0.5, 1, 0.5);
                    spawn(function() --[[ Line: 0 ]] --[[ Name:  ]]
                        -- upvalues: statusLabel (ref)
                        wait(2);
                        statusLabel.Text = "Ready";
                        statusLabel.TextColor3 = Color3.new(0.7, 0.7, 0.7);
                    end);
                    keybindCaptureConnection:Disconnect();
                end;
                return;
            end;
        end);
    end);
    if deleteButton then
        deleteButton.MouseEnter:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
            -- upvalues: deleteButton (ref)
            deleteButton.BackgroundTransparency = 0.1;
        end);
        deleteButton.MouseLeave:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
            -- upvalues: deleteButton (ref)
            deleteButton.BackgroundTransparency = 0.3;
        end);
        deleteButton.MouseButton1Click:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
            -- upvalues: customEmotes (ref), rowEmote (ref), saveCustomToDisk (ref), statusLabel (ref)
            for customIndex, customEntry in pairs(customEmotes) do
                if customEntry.id == rowEmote.id and customEntry.name == rowEmote.name then
                    table.remove(customEmotes, customIndex);
                    break;
                end;
            end;
            saveCustomToDisk();
            loadGUI();
            statusLabel.Text = "Deleted: " .. rowEmote.name;
            statusLabel.TextColor3 = Color3.new(1, 1, 0.5);
            spawn(function() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: statusLabel (ref)
                wait(2);
                statusLabel.Text = "Ready";
                statusLabel.TextColor3 = Color3.new(0.7, 0.7, 0.7);
            end);
        end);
    end;
end;
loadGUI = function() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: listScrollFrame (ref), searchBox (ref), customAddPanel (ref), activeTab (ref), emoteCatalog (ref), favoriteById (ref), customEmotes (ref), createEmoteRow (ref), listLayout (ref)
    for _, childGuiObject in pairs(listScrollFrame:GetChildren()) do
        if childGuiObject:IsA("Frame") then
            childGuiObject:Destroy();
        end;
    end;
    local filteredEmotes = {};
    local searchLower = searchBox.Text:lower();
    customAddPanel.Visible = activeTab == "custom";
    if activeTab == "custom" then
        listScrollFrame.Size = UDim2.new(1, -16, 1, -200);
        listScrollFrame.Position = UDim2.new(0, 8, 0, 160);
    else
        listScrollFrame.Size = UDim2.new(1, -16, 1, -140);
        listScrollFrame.Position = UDim2.new(0, 8, 0, 105);
    end;
    if activeTab == "all" then
        for _, catalogEmote in pairs(emoteCatalog) do
            if searchLower == "" or catalogEmote.name:lower():find(searchLower) then
                table.insert(filteredEmotes, catalogEmote);
            end;
        end;
    elseif activeTab == "favorites" then
        for _, catalogEmote in pairs(emoteCatalog) do
            if favoriteById[catalogEmote.id] and (searchLower == "" or catalogEmote.name:lower():find(searchLower)) then
                table.insert(filteredEmotes, catalogEmote);
            end;
        end;
    elseif activeTab == "custom" then
        for _, customEmote in pairs(customEmotes) do
            if searchLower == "" or customEmote.name:lower():find(searchLower) then
                table.insert(filteredEmotes, customEmote);
            end;
        end;
    end;
    for _, visibleEmote in pairs(filteredEmotes) do
        createEmoteRow(visibleEmote, activeTab == "custom");
    end;
    spawn(function() --[[ Line: 0 ]] --[[ Name:  ]]
        -- upvalues: listScrollFrame (ref), listLayout (ref)
        wait(0.1);
        listScrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y);
    end);
end;
local function resetPlaybackSpeed() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: playbackSpeed (ref), speedSliderKnob (ref), speedValueLabel (ref), activeEmoteTrack (ref)
    playbackSpeed = 1;
    speedSliderKnob.Position = UDim2.new(0.5, -6, 0.5, -6);
    speedValueLabel.Text = "1.00x";
    if activeEmoteTrack then
        activeEmoteTrack:AdjustSpeed(playbackSpeed);
    end;
end;
customAddButton.MouseButton1Click:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: customNameBox (ref), customIdBox (ref), statusLabel (ref), customEmotes (ref), saveCustomToDisk (ref)
    local trimmedCustomName = customNameBox.Text:match("^%s*(.-)%s*$");
    local trimmedCustomIdText = customIdBox.Text:match("^%s*(.-)%s*$");
    if trimmedCustomName == "" or trimmedCustomIdText == "" then
        statusLabel.Text = "Please fill both fields";
        statusLabel.TextColor3 = Color3.new(1, 0.5, 0.5);
        spawn(function() --[[ Line: 0 ]] --[[ Name:  ]]
            -- upvalues: statusLabel (ref)
            wait(2);
            statusLabel.Text = "Ready";
            statusLabel.TextColor3 = Color3.new(0.7, 0.7, 0.7);
        end);
        return;
    else
        local customEmoteIdNumber = tonumber(trimmedCustomIdText);
        if not customEmoteIdNumber then
            statusLabel.Text = "Invalid animation ID";
            statusLabel.TextColor3 = Color3.new(1, 0.5, 0.5);
            spawn(function() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: statusLabel (ref)
                wait(2);
                statusLabel.Text = "Ready";
                statusLabel.TextColor3 = Color3.new(0.7, 0.7, 0.7);
            end);
            return;
        else
            for _, existingCustomEmote in pairs(customEmotes) do
                if existingCustomEmote.id == customEmoteIdNumber then
                    statusLabel.Text = "Animation ID already exists";
                    statusLabel.TextColor3 = Color3.new(1, 0.5, 0.5);
                    spawn(function() --[[ Line: 0 ]] --[[ Name:  ]]
                        -- upvalues: statusLabel (ref)
                        wait(2);
                        statusLabel.Text = "Ready";
                        statusLabel.TextColor3 = Color3.new(0.7, 0.7, 0.7);
                    end);
                    return;
                end;
            end;
            table.insert(customEmotes, {
                id = customEmoteIdNumber, 
                name = trimmedCustomName
            });
            saveCustomToDisk();
            customNameBox.Text = "";
            customIdBox.Text = "";
            loadGUI();
            statusLabel.Text = "Added: " .. trimmedCustomName;
            statusLabel.TextColor3 = Color3.new(0.5, 1, 0.5);
            spawn(function() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: statusLabel (ref)
                wait(2);
                statusLabel.Text = "Ready";
                statusLabel.TextColor3 = Color3.new(0.7, 0.7, 0.7);
            end);
            return;
        end;
    end;
end);
customAddButton.MouseEnter:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: customAddButton (ref)
    customAddButton.BackgroundTransparency = 0.1;
end);
customAddButton.MouseLeave:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: customAddButton (ref)
    customAddButton.BackgroundTransparency = 0.3;
end);
spawn(function() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: emoteCatalog (ref), statusLabel (ref), loadFavoritesFromDisk (ref)
    pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
        -- upvalues: emoteCatalog (ref), statusLabel (ref), loadFavoritesFromDisk (ref)
        local remoteCatalogSource = game:HttpGet("https://akadmin-bzk.pages.dev/Ugcemotesalternative.lua");
        local remoteCatalogLoader = loadstring(remoteCatalogSource);
        if remoteCatalogLoader then
            local remoteCatalogTable = remoteCatalogLoader();
            if type(remoteCatalogTable) == "table" then
                for remoteEmoteName, remoteEmoteValue in pairs(remoteCatalogTable) do
                    if type(remoteEmoteValue) == "number" and remoteEmoteValue > 1000000 then
                        table.insert(emoteCatalog, {
                            id = remoteEmoteValue, 
                            name = tostring(remoteEmoteName)
                        });
                    elseif type(remoteEmoteValue) == "table" and remoteEmoteValue.id then
                        table.insert(emoteCatalog, {
                            id = remoteEmoteValue.id, 
                            name = remoteEmoteValue.name or tostring(remoteEmoteName)
                        });
                    elseif type(remoteEmoteName) == "string" and type(remoteEmoteValue) == "number" and remoteEmoteValue > 1000000 then
                        table.insert(emoteCatalog, {
                            id = remoteEmoteValue, 
                            name = remoteEmoteName
                        });
                    end;
                end;
            end;
        end;
        if #emoteCatalog > 0 then
            statusLabel.Text = "Loaded " .. #emoteCatalog .. " emotes";
            statusLabel.TextColor3 = Color3.new(0.5, 1, 0.5);
            loadFavoritesFromDisk();
            loadGUI();
        else
            statusLabel.Text = "No emotes found";
            statusLabel.TextColor3 = Color3.new(1, 0.5, 0.5);
        end;
    end);
end);
closeButton.MouseButton1Click:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: screenGui (ref)
    screenGui:Destroy();
end);
minimizeButton.MouseButton1Click:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: isMinimizeTweening (ref), isMinimized (ref), contentWidgets (ref), TweenService (ref), mainFrame (ref), minimizeButton (ref), activeTab (ref), customAddPanel (ref)
    if isMinimizeTweening then
        return;
    else
        isMinimizeTweening = true;
        if not isMinimized then
            for _, widget in pairs(contentWidgets) do
                widget.Visible = false;
            end;
            local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
            local openTween = TweenService:Create(mainFrame, tweenInfo, {
                Size = UDim2.new(0, 280, 0, 30)
            });
            minimizeButton.Text = "+";
            isMinimized = true;
            openTween:Play();
            openTween.Completed:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: isMinimizeTweening (ref)
                isMinimizeTweening = false;
            end);
        else
            local restoreTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
            local restoreTween = TweenService:Create(mainFrame, restoreTweenInfo, {
                Size = UDim2.new(0, 280, 0, 350)
            });
            minimizeButton.Text = "\226\136\146";
            isMinimized = false;
            restoreTween:Play();
            restoreTween.Completed:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: contentWidgets (ref), activeTab (ref), customAddPanel (ref), isMinimizeTweening (ref)
                for _, widgetToShow in pairs(contentWidgets) do
                    widgetToShow.Visible = true;
                end;
                if activeTab ~= "custom" then
                    customAddPanel.Visible = false;
                end;
                isMinimizeTweening = false;
            end);
        end;
        return;
    end;
end);
local isSpeedSliderDragging = false;
local function updatePlaybackSpeedFromMouse(mouseInput) --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: speedSliderTrack (ref), playbackSpeed (ref), speedSliderKnob (ref), speedValueLabel (ref), activeEmoteTrack (ref)
    local normalizedSpeed = math.clamp((mouseInput.Position.X - speedSliderTrack.AbsolutePosition.X) / speedSliderTrack.AbsoluteSize.X, 0, 1);
    if normalizedSpeed <= 0.5 then
        playbackSpeed = 0.01 + normalizedSpeed * 2 * 0.99;
    else
        playbackSpeed = 1 + (normalizedSpeed - 0.5) * 2 * 99;
    end;
    speedSliderKnob.Position = UDim2.new(normalizedSpeed, -6, 0.5, -6);
    speedValueLabel.Text = string.format("%.2fx", playbackSpeed);
    if activeEmoteTrack then
        activeEmoteTrack:AdjustSpeed(playbackSpeed);
    end;
end;
spawn(function() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: speedSliderKnob (ref), speedValueLabel (ref)
    wait(0.1);
    speedSliderKnob.Position = UDim2.new(0.5, -6, 0.5, -6);
    speedValueLabel.Text = "1.00x";
end);
speedSliderTrack.InputBegan:Connect(function(sliderInput) --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: isSpeedSliderDragging (ref), updatePlaybackSpeedFromMouse (ref)
    if sliderInput.UserInputType == Enum.UserInputType.MouseButton1 or sliderInput.UserInputType == Enum.UserInputType.Touch then
        isSpeedSliderDragging = true;
        updatePlaybackSpeedFromMouse(sliderInput);
    end;
end);
UserInputService.InputChanged:Connect(function(sliderMoveInput) --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: isSpeedSliderDragging (ref), updatePlaybackSpeedFromMouse (ref)
    if isSpeedSliderDragging and (sliderMoveInput.UserInputType == Enum.UserInputType.MouseMovement or sliderMoveInput.UserInputType == Enum.UserInputType.Touch) then
        updatePlaybackSpeedFromMouse(sliderMoveInput);
    end;
end);
UserInputService.InputEnded:Connect(function(sliderEndInput) --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: isSpeedSliderDragging (ref)
    if sliderEndInput.UserInputType == Enum.UserInputType.MouseButton1 or sliderEndInput.UserInputType == Enum.UserInputType.Touch then
        isSpeedSliderDragging = false;
    end;
end);
speedResetButton.MouseButton1Click:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: resetPlaybackSpeed (ref)
    resetPlaybackSpeed();
end);
speedResetButton.MouseEnter:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: speedResetButton (ref)
    speedResetButton.BackgroundTransparency = 0.3;
end);
speedResetButton.MouseLeave:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: speedResetButton (ref)
    speedResetButton.BackgroundTransparency = 0.5;
end);
searchBox:GetPropertyChangedSignal("Text"):Connect(loadGUI);
tabAllButton.MouseButton1Click:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: activeTab (ref), tabAllButton (ref), tabFavoritesButton (ref), tabCustomButton (ref)
    activeTab = "all";
    tabAllButton.BackgroundTransparency = 0.5;
    tabFavoritesButton.BackgroundTransparency = 0.7;
    tabCustomButton.BackgroundTransparency = 0.7;
    loadGUI();
end);
tabFavoritesButton.MouseButton1Click:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: activeTab (ref), tabFavoritesButton (ref), tabAllButton (ref), tabCustomButton (ref)
    activeTab = "favorites";
    tabFavoritesButton.BackgroundTransparency = 0.5;
    tabAllButton.BackgroundTransparency = 0.7;
    tabCustomButton.BackgroundTransparency = 0.7;
    loadGUI();
end);
tabCustomButton.MouseButton1Click:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: activeTab (ref), tabCustomButton (ref), tabAllButton (ref), tabFavoritesButton (ref)
    activeTab = "custom";
    tabCustomButton.BackgroundTransparency = 0.5;
    tabAllButton.BackgroundTransparency = 0.7;
    tabFavoritesButton.BackgroundTransparency = 0.7;
    loadGUI();
end);
UserInputService.InputBegan:Connect(function(keyInput, keyProcessed) --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: keybindById (ref), emoteCatalog (ref), togglePlayEmote (ref), customEmotes (ref)
    if keyProcessed then
        return;
    else
        for boundEmoteId, boundKeyCode in pairs(keybindById) do
            if keyInput.KeyCode == boundKeyCode then
                for _, catalogEmote in pairs(emoteCatalog) do
                    if catalogEmote.id == boundEmoteId then
                        togglePlayEmote(catalogEmote.id, catalogEmote.name);
                        return;
                    end;
                end;
                for _, customEmoteEntry in pairs(customEmotes) do
                    if customEmoteEntry.id == boundEmoteId then
                        togglePlayEmote(customEmoteEntry.id, customEmoteEntry.name);
                        return;
                    end;
                end;
            end;
        end;
        return;
    end;
end);
local isWindowDragging = false;
local dragStartMousePos = nil;
local dragStartFramePos = nil;
local function beginWindowDrag(dragInput) --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: isWindowDragging (ref), dragStartMousePos (ref), dragStartFramePos (ref), mainFrame (ref)
    isWindowDragging = true;
    dragStartMousePos = dragInput.Position;
    dragStartFramePos = mainFrame.Position;
end;
local function updateWindowDrag(dragInput) --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: isWindowDragging (ref), dragStartMousePos (ref), mainFrame (ref), dragStartFramePos (ref)
    if isWindowDragging then
        local dragDelta = dragInput.Position - dragStartMousePos;
        mainFrame.Position = UDim2.new(dragStartFramePos.X.Scale, dragStartFramePos.X.Offset + dragDelta.X, dragStartFramePos.Y.Scale, dragStartFramePos.Y.Offset + dragDelta.Y);
    end;
end;
local function endWindowDrag() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: isWindowDragging (ref)
    isWindowDragging = false;
end;
titleBar.InputBegan:Connect(function(dragStartInput) --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: beginWindowDrag (ref)
    if dragStartInput.UserInputType == Enum.UserInputType.MouseButton1 or dragStartInput.UserInputType == Enum.UserInputType.Touch then
        beginWindowDrag(dragStartInput);
    end;
end);
UserInputService.InputChanged:Connect(function(dragMoveInput) --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: updateWindowDrag (ref)
    if dragMoveInput.UserInputType == Enum.UserInputType.MouseMovement or dragMoveInput.UserInputType == Enum.UserInputType.Touch then
        updateWindowDrag(dragMoveInput);
    end;
end);
UserInputService.InputEnded:Connect(function(dragEndInput) --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: endWindowDrag (ref)
    if dragEndInput.UserInputType == Enum.UserInputType.MouseButton1 or dragEndInput.UserInputType == Enum.UserInputType.Touch then
        endWindowDrag();
    end;
end);
print("Simplified UGC Emotes with Custom Tab loaded!");