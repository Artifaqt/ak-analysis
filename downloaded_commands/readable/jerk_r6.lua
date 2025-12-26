local Players = game:GetService("Players");
local _ = game:GetService("UserInputService");
local _ = game:GetService("ReplicatedStorage");
local localPlayer = Players.LocalPlayer;
local function createJerkOffTool() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: localPlayer (ref)
    local tool = Instance.new("Tool");
    tool.Name = "Jerk Off";
    tool.RequiresHandle = false;
    tool.Parent = localPlayer.Backpack;
    return tool;
end;
local isLooping = false;
local renderStepConnections = {};
local function startLoopedAnimationSegment(animId, loopStartTime, loopEndTime, slotKey) --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: localPlayer (ref), renderStepConnections (ref), isLooping (ref)
    local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid");
    if not humanoid then
        warn("Humanoid not found!");
        return;
    else
        local animation = Instance.new("Animation");
        animation.AnimationId = "rbxassetid://" .. animId;
        local track = humanoid:LoadAnimation(animation);
        renderStepConnections[slotKey] = game:GetService("RunService").RenderStepped:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
            -- upvalues: isLooping (ref), track (ref), loopEndTime (ref), loopStartTime (ref)
            if isLooping then
                if track.TimePosition >= loopEndTime or track.IsPlaying == false then
                    track:Play();
                    track.TimePosition = loopStartTime;
                end;
            else
                track:Stop();
            end;
        end);
        track:Play();
        track.TimePosition = loopStartTime;
        return;
    end;
end;
local function startJerkSequence() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: startLoopedAnimationSegment (ref), isLooping (ref)
    startLoopedAnimationSegment("72042024", 0.5, 0.9, 1);
    startLoopedAnimationSegment("168268306", 1, 1.001, 2);
    isLooping = true;
end;
local function stopJerkSequence() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: isLooping (ref), renderStepConnections (ref)
    isLooping = false;
    for _, conn in pairs(renderStepConnections) do
        conn:Disconnect();
    end;
    renderStepConnections = {};
end;
local function onToolEquipped() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: startJerkSequence (ref)
    startJerkSequence();
end;
local function onToolUnequipped() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: stopJerkSequence (ref)
    stopJerkSequence();
end;
localPlayer.CharacterAdded:Connect(function(_) --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: localPlayer (ref), createJerkOffTool (ref), onToolEquipped (ref), onToolUnequipped (ref)
    if localPlayer.Backpack:FindFirstChild("Jerk Off") then
        localPlayer.Backpack["Jerk Off"]:Destroy();
    end;
    local tool = createJerkOffTool();
    tool.Equipped:Connect(onToolEquipped);
    tool.Unequipped:Connect(onToolUnequipped);
end);
local tool2 = createJerkOffTool();
tool2.Equipped:Connect(onToolEquipped);
tool2.Unequipped:Connect(onToolUnequipped);