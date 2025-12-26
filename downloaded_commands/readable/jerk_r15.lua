local JERK_ANIM_ASSET = "rbxassetid://698251653";
local localPlayer = game.Players.LocalPlayer;
local function createJerkOffToolR15() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: localPlayer (ref), JERK_ANIM_ASSET (ref)
    local tool = Instance.new("Tool");
    tool.Name = "Jerk Off R15";
    tool.RequiresHandle = false;
    tool.Parent = localPlayer.Backpack;
    local jerkAnimTrack = nil;
    tool.Equipped:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
        -- upvalues: localPlayer (ref), JERK_ANIM_ASSET (ref), jerkAnimTrack (ref)
        local humanoid = (localPlayer.Character or localPlayer.CharacterAdded:Wait()):FindFirstChildOfClass("Humanoid");
        if not humanoid then
            return;
        else
            local animation = Instance.new("Animation");
            animation.AnimationId = JERK_ANIM_ASSET;
            jerkAnimTrack = humanoid:LoadAnimation(animation);
            jerkAnimTrack.Looped = false;
            jerkAnimTrack:Play();
            jerkAnimTrack.TimePosition = 0.58;
            jerkAnimTrack:AdjustSpeed(0.4);
            task.spawn(function() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: jerkAnimTrack (ref)
                while jerkAnimTrack and jerkAnimTrack.IsPlaying do
                    if jerkAnimTrack.TimePosition >= 0.63 then
                        jerkAnimTrack.TimePosition = 0.58;
                    end;
                    task.wait();
                end;
            end);
            return;
        end;
    end);
    tool.Unequipped:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
        -- upvalues: jerkAnimTrack (ref)
        if jerkAnimTrack then
            jerkAnimTrack:Stop();
            jerkAnimTrack = nil;
        end;
    end);
end;
createJerkOffToolR15();
localPlayer.CharacterAdded:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: createJerkOffToolR15 (ref)
    task.wait(0.5);
    createJerkOffToolR15();
end);