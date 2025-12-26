local Players = game:GetService("Players");
local StarterGui = game:GetService("StarterGui");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local CoreGui = game:GetService("CoreGui");
local UI_CONFIG = {
    BUTTON_TEXT_SIZE = 12, 
    CORNER_RADIUS = UDim.new(0, 6), 
    MAIN_CORNER_RADIUS = UDim.new(0, 10), 
    ROTATION_SPEED = math.rad(30), 
    CAMERA_RADIUS = 6, 
    CAMERA_HEIGHT = 3, 
    SPEED_THRESHOLD = 0.1, 
    SPEED_DIVISOR = 16
};
local UI_COLORS = {
    BACKGROUND = Color3.fromRGB(0, 0, 0), 
    TEXT = Color3.new(1, 1, 1), 
    CONFIRM_YES = Color3.fromRGB(200, 60, 60), 
    CONFIRM_NO = Color3.fromRGB(80, 80, 80)
};
local UI_ALPHA = {
    MAIN_FRAME = 0.6, 
    TITLE_BAR = 0.5, 
    BUTTON = 0.7, 
    VIEWPORT = 0.8, 
    POPUP = 0.5, 
    POPUP_BUTTON = 0.6
};
local CAR_ANIMS = {
    {
        id = "76503595759461", 
        mult = 1
    }, 
    {
        id = "115245341767944", 
        mult = 2
    }, 
    {
        id = "127805235430271", 
        mult = 4
    }, 
    {
        id = "138003068153218", 
        mult = 1
    }, 
    {
        id = "116772752010894", 
        mult = 1
    }, 
    {
        id = "116625361313832", 
        mult = 1
    }, 
    {
        id = "81388785824317", 
        mult = 1
    }, 
    {
        id = "108747312576405", 
        mult = 2
    }, 
    {
        id = "113181071290859", 
        mult = 1
    }, 
    {
        id = "134681712937413", 
        mult = 1
    }, 
    {
        id = "115260380433565", 
        mult = 2
    }, 
    {
        id = "72382226286301", 
        mult = 1
    }
};
local state = {
    currentIndex = 1, 
    activeTrack = nil, 
    activeConn = nil, 
    carstop = false, 
    minimized = false, 
    confirmationgui = false, 
    rotationAngle = 0
};
local ui = {};
local function getViewportScaleHelpers() --[[ Line: 0 ]] --[[ Name:  ]]
    local l_ViewportSize_0 = workspace.CurrentCamera.ViewportSize;
    return {
        uScale = function(xScaleFactor, yScaleFactor) --[[ Line: 0 ]] --[[ Name:  ]]
            -- upvalues: l_ViewportSize_0 (ref)
            return UDim2.new(0, l_ViewportSize_0.X * xScaleFactor, 0, l_ViewportSize_0.Y * (yScaleFactor or xScaleFactor));
        end, 
        uPos = function(xPosFactor, yPosFactor) --[[ Line: 0 ]] --[[ Name:  ]]
            -- upvalues: l_ViewportSize_0 (ref)
            return UDim2.new(0, l_ViewportSize_0.X * xPosFactor, 0, l_ViewportSize_0.Y * yPosFactor);
        end, 
        uSize = function(xSizeFactor, ySizeFactor) --[[ Line: 0 ]] --[[ Name:  ]]
            -- upvalues: l_ViewportSize_0 (ref)
            return UDim2.new(0, l_ViewportSize_0.X * xSizeFactor, 0, l_ViewportSize_0.Y * (ySizeFactor or xSizeFactor));
        end
    };
end;
local function isLocalPlayerR15() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: Players (ref)
    local l_LocalPlayer_0 = Players.LocalPlayer;
    if not l_LocalPlayer_0 then
        return false;
    else
        local l_Character_0 = l_LocalPlayer_0.Character;
        if not l_Character_0 then
            return false;
        else
            local l_Humanoid_0 = l_Character_0:FindFirstChild("Humanoid");
            if not l_Humanoid_0 then
                return false;
            else
                return l_Humanoid_0.RigType == Enum.HumanoidRigType.R15;
            end;
        end;
    end;
end;
local function resetExistingUIAndSingleton() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: CoreGui (ref)
    local l_SillyCarUI_0 = CoreGui:FindFirstChild("SillyCarUI");
    if l_SillyCarUI_0 then
        l_SillyCarUI_0:Destroy();
        wait(0.1);
    end;
    if getgenv and getgenv().CarExecuted then
        getgenv().CarExecuted = false;
        wait(0.1);
    end;
    if getgenv then
        getgenv().CarExecuted = true;
    end;
    return true;
end;
local function makeCorner(cornerRadius) --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: UI_CONFIG (ref)
    local l_UICorner_0 = Instance.new("UICorner");
    l_UICorner_0.CornerRadius = cornerRadius or UI_CONFIG.CORNER_RADIUS;
    return l_UICorner_0;
end;
local function createButton(parentGui, buttonSize, buttonPosition, buttonText, buttonTextSize) --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: UI_COLORS (ref), UI_ALPHA (ref), UI_CONFIG (ref), makeCorner (ref)
    local l_TextButton_0 = Instance.new("TextButton");
    l_TextButton_0.Parent = parentGui;
    l_TextButton_0.Size = buttonSize;
    l_TextButton_0.Position = buttonPosition;
    l_TextButton_0.BackgroundColor3 = UI_COLORS.BACKGROUND;
    l_TextButton_0.BackgroundTransparency = UI_ALPHA.BUTTON;
    l_TextButton_0.BorderSizePixel = 0;
    l_TextButton_0.TextColor3 = UI_COLORS.TEXT;
    l_TextButton_0.Text = buttonText;
    l_TextButton_0.Font = Enum.Font.Gotham;
    l_TextButton_0.TextSize = buttonTextSize or UI_CONFIG.BUTTON_TEXT_SIZE;
    l_TextButton_0.TextScaled = false;
    makeCorner():Clone().Parent = l_TextButton_0;
    return l_TextButton_0;
end;
local function createFrame(parentInstance, frameSize, framePosition, backgroundAlpha) --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: UI_COLORS (ref)
    local l_Frame_0 = Instance.new("Frame");
    l_Frame_0.Parent = parentInstance;
    l_Frame_0.Size = frameSize;
    l_Frame_0.Position = framePosition;
    l_Frame_0.BackgroundColor3 = UI_COLORS.BACKGROUND;
    l_Frame_0.BackgroundTransparency = backgroundAlpha or 1;
    l_Frame_0.BorderSizePixel = 0;
    return l_Frame_0;
end;
local function createLabel(labelParent, labelSize, labelPosition, labelText, labelTextSize) --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: UI_COLORS (ref), UI_CONFIG (ref)
    local l_TextLabel_0 = Instance.new("TextLabel");
    l_TextLabel_0.Parent = labelParent;
    l_TextLabel_0.Size = labelSize;
    l_TextLabel_0.Position = labelPosition;
    l_TextLabel_0.BackgroundTransparency = 1;
    l_TextLabel_0.Text = labelText;
    l_TextLabel_0.Font = Enum.Font.Gotham;
    l_TextLabel_0.TextColor3 = UI_COLORS.TEXT;
    l_TextLabel_0.TextSize = labelTextSize or UI_CONFIG.BUTTON_TEXT_SIZE;
    l_TextLabel_0.TextScaled = false;
    return l_TextLabel_0;
end;
local function attachHoverTransparency(hoverTarget) --[[ Line: 0 ]] --[[ Name:  ]]
    local l_BackgroundTransparency_0 = hoverTarget.BackgroundTransparency;
    hoverTarget.MouseEnter:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
        -- upvalues: hoverTarget (ref), l_BackgroundTransparency_0 (ref)
        hoverTarget.BackgroundTransparency = math.max(0, l_BackgroundTransparency_0 - 0.1);
    end);
    hoverTarget.MouseLeave:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
        -- upvalues: hoverTarget (ref), l_BackgroundTransparency_0 (ref)
        hoverTarget.BackgroundTransparency = l_BackgroundTransparency_0;
    end);
end;
local function buildRootUI() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: getViewportScaleHelpers (ref), ui (ref), CoreGui (ref), createFrame (ref), UI_ALPHA (ref), makeCorner (ref), UI_CONFIG (ref)
    local viewportScaleHelpers = getViewportScaleHelpers();
    ui.screenGui = Instance.new("ScreenGui");
    ui.screenGui.Parent = CoreGui;
    ui.screenGui.ResetOnSpawn = false;
    ui.screenGui.Name = "SillyCarUI";
    ui.mainFrame = createFrame(ui.screenGui, viewportScaleHelpers.uSize(0.2, 0.35), UDim2.new(0.5, -120, 0.5, -105), UI_ALPHA.MAIN_FRAME);
    ui.mainFrame.Active = true;
    ui.mainFrame.Draggable = true;
    makeCorner(UI_CONFIG.MAIN_CORNER_RADIUS).Parent = ui.mainFrame;
    return viewportScaleHelpers;
end;
local function buildTitleBar() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: ui (ref), createFrame (ref), UI_ALPHA (ref), makeCorner (ref), UI_CONFIG (ref), createLabel (ref), createButton (ref)
    ui.titleBar = createFrame(ui.mainFrame, UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 0), UI_ALPHA.TITLE_BAR);
    makeCorner(UI_CONFIG.MAIN_CORNER_RADIUS).Parent = ui.titleBar;
    ui.titleText = createLabel(ui.titleBar, UDim2.new(1, -60, 1, 0), UDim2.new(0, 30, 0, 0), "CAR anims", UI_CONFIG.BUTTON_TEXT_SIZE);
    ui.titleText.TextXAlignment = Enum.TextXAlignment.Center;
    ui.minBtn = createButton(ui.titleBar, UDim2.new(0, 20, 0, 20), UDim2.new(1, -45, 0, 5), "\226\128\148", UI_CONFIG.BUTTON_TEXT_SIZE);
    ui.closeBtn = createButton(ui.titleBar, UDim2.new(0, 20, 0, 20), UDim2.new(1, -22, 0, 5), "\226\156\149", UI_CONFIG.BUTTON_TEXT_SIZE);
end;
local function buildAnimHeader() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: ui (ref), createFrame (ref), UI_ALPHA (ref), makeCorner (ref), createLabel (ref), state (ref), CAR_ANIMS (ref), UI_CONFIG (ref)
    ui.contentFrame = createFrame(ui.mainFrame, UDim2.new(1, -20, 1, -45), UDim2.new(0, 10, 0, 35), 1);
    ui.animNameFrame = createFrame(ui.contentFrame, UDim2.new(1, 0, 0, 25), UDim2.new(0, 0, 0, 0), UI_ALPHA.BUTTON);
    makeCorner().Parent = ui.animNameFrame;
    ui.animNameText = createLabel(ui.animNameFrame, UDim2.new(1, -10, 1, 0), UDim2.new(0, 5, 0, 0), "Animation " .. state.currentIndex .. "/" .. #CAR_ANIMS, UI_CONFIG.BUTTON_TEXT_SIZE);
    ui.animNameText.TextXAlignment = Enum.TextXAlignment.Center;
end;
local function buildViewport() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: ui (ref), createFrame (ref), UI_ALPHA (ref), makeCorner (ref), UI_COLORS (ref)
    ui.viewportContainer = createFrame(ui.contentFrame, UDim2.new(1, 0, 1, -105), UDim2.new(0, 0, 0, 30), UI_ALPHA.BUTTON);
    makeCorner(UDim.new(0, 8)).Parent = ui.viewportContainer;
    ui.viewport = Instance.new("ViewportFrame");
    ui.viewport.Parent = ui.viewportContainer;
    ui.viewport.Size = UDim2.new(1, -6, 1, -6);
    ui.viewport.Position = UDim2.new(0, 3, 0, 3);
    ui.viewport.BackgroundColor3 = UI_COLORS.BACKGROUND;
    ui.viewport.BackgroundTransparency = UI_ALPHA.VIEWPORT;
    ui.viewport.BorderSizePixel = 0;
    makeCorner().Parent = ui.viewport;
    ui.camera = Instance.new("Camera");
    ui.camera.CameraType = Enum.CameraType.Scriptable;
    ui.viewport.CurrentCamera = ui.camera;
end;
local function buildNavControls() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: ui (ref), createFrame (ref), createButton (ref), UI_CONFIG (ref)
    ui.navContainer = createFrame(ui.contentFrame, UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 1, -75), 1);
    ui.prevBtn = createButton(ui.navContainer, UDim2.new(0.48, 0, 1, 0), UDim2.new(0, 0, 0, 0), "\226\151\128 Previous", UI_CONFIG.BUTTON_TEXT_SIZE);
    ui.nextBtn = createButton(ui.navContainer, UDim2.new(0.48, 0, 1, 0), UDim2.new(0.52, 0, 0, 0), "Next \226\150\182", UI_CONFIG.BUTTON_TEXT_SIZE);
end;
local function buildPlayStopControls() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: ui (ref), createFrame (ref), createButton (ref), UI_CONFIG (ref)
    ui.controlContainer = createFrame(ui.contentFrame, UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 1, -40), 1);
    ui.playBtn = createButton(ui.controlContainer, UDim2.new(0.48, 0, 1, 0), UDim2.new(0, 0, 0, 0), "Play Car", UI_CONFIG.BUTTON_TEXT_SIZE);
    ui.playBtn.Font = Enum.Font.GothamBold;
    ui.stopBtn = createButton(ui.controlContainer, UDim2.new(0.48, 0, 1, 0), UDim2.new(0.52, 0, 0, 0), "Stop Car", UI_CONFIG.BUTTON_TEXT_SIZE);
    ui.stopBtn.Font = Enum.Font.GothamBold;
end;
local function applyButtonHoverEffects() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: ui (ref), attachHoverTransparency (ref)
    local buttonsToHover = {
        ui.prevBtn, 
        ui.nextBtn, 
        ui.playBtn, 
        ui.stopBtn, 
        ui.minBtn, 
        ui.closeBtn
    };
    for _, buttonToStyle in ipairs(buttonsToHover) do
        attachHoverTransparency(buttonToStyle);
    end;
end;
local function ensureModelPrimaryPart(dummyModel) --[[ Line: 0 ]] --[[ Name:  ]]
    if not dummyModel or not dummyModel.Parent then
        return false;
    elseif dummyModel.PrimaryPart then
        return true;
    else
        local dummyPrimaryPartCandidate = dummyModel:FindFirstChild("HumanoidRootPart") or dummyModel:FindFirstChildWhichIsA("BasePart");
        if dummyPrimaryPartCandidate then
            dummyModel.PrimaryPart = dummyPrimaryPartCandidate;
            return true;
        else
            return false;
        end;
    end;
end;
local function createAndSetupDummyModels() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: Players (ref), ui (ref), ensureModelPrimaryPart (ref)
    local l_status_0, l_result_0 = pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
        -- upvalues: Players (ref)
        return Players:CreateHumanoidModelFromUserId(9160453052);
    end);
    if not l_status_0 or not l_result_0 then
        warn("Failed to create dummy model: " .. tostring(l_result_0));
        local l_status_1, l_result_1 = pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
            -- upvalues: Players (ref)
            return Players:CreateHumanoidModelFromUserId(1);
        end);
        l_result_0 = l_result_1;
        if not l_status_1 or not l_result_0 then
            return false;
        end;
    end;
    ui.realDummy = l_result_0;
    ui.realDummy.Parent = workspace;
    local attempts = 0;
    local maxAttempts = 100;
    while attempts < maxAttempts and not ensureModelPrimaryPart(ui.realDummy) do
        task.wait(0.05);
        attempts = attempts + 1;
    end;
    if not ui.realDummy.PrimaryPart then
        warn("Failed to set PrimaryPart for dummy");
        return false;
    else
        pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
            -- upvalues: ui (ref)
            ui.realDummy:SetPrimaryPartCFrame(CFrame.new(0, 10000, 0));
        end);
        ui.vpDummy = ui.realDummy:Clone();
        ensureModelPrimaryPart(ui.vpDummy);
        ui.vpDummy.Parent = ui.viewport;
        if ui.vpDummy.PrimaryPart and ui.realDummy.PrimaryPart then
            ui.vpDummy:SetPrimaryPartCFrame(ui.realDummy.PrimaryPart.CFrame);
        end;
        for _, realDummyPart in pairs(ui.realDummy:GetDescendants()) do
            if realDummyPart:IsA("BasePart") then
                realDummyPart.Transparency = 1;
                realDummyPart.CanCollide = false;
            end;
        end;
        local l_HumanoidRootPart_0 = ui.vpDummy:FindFirstChild("HumanoidRootPart");
        if l_HumanoidRootPart_0 then
            l_HumanoidRootPart_0.Transparency = 1;
        end;
        for _, viewportDummyPart in pairs(ui.vpDummy:GetDescendants()) do
            if viewportDummyPart:IsA("BasePart") then
                viewportDummyPart.CanCollide = false;
            end;
        end;
        return true;
    end;
end;
local function startViewportSyncLoop() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: RunService (ref), state (ref), ui (ref), UI_CONFIG (ref)
    local renderConn = nil;
    renderConn = RunService.RenderStepped:Connect(function(dt) --[[ Line: 0 ]] --[[ Name:  ]]
        -- upvalues: state (ref), renderConn (ref), ui (ref), UI_CONFIG (ref)
        if state.carstop then
            renderConn:Disconnect();
            return;
        elseif not ui.realDummy or not ui.realDummy.Parent or not ui.vpDummy or not ui.vpDummy.Parent then
            return;
        else
            pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: ui (ref)
                for _, realDummyPart in pairs(ui.realDummy:GetDescendants()) do
                    if realDummyPart:IsA("BasePart") then
                        local l_FirstChild_0 = ui.vpDummy:FindFirstChild(realDummyPart.Name, true);
                        if l_FirstChild_0 and l_FirstChild_0:IsA("BasePart") then
                            l_FirstChild_0.CFrame = realDummyPart.CFrame;
                        end;
                    end;
                end;
            end);
            state.rotationAngle = state.rotationAngle + UI_CONFIG.ROTATION_SPEED * dt;
            local cameraOffsetX = math.sin(state.rotationAngle) * UI_CONFIG.CAMERA_RADIUS;
            local cameraOffsetZ = math.cos(state.rotationAngle) * UI_CONFIG.CAMERA_RADIUS;
            local cameraFocusPos = ui.vpDummy.PrimaryPart and ui.vpDummy.PrimaryPart.Position or Vector3.new(0, 1, 0);
            pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: ui (ref), cameraFocusPos (ref), cameraOffsetX (ref), UI_CONFIG (ref), cameraOffsetZ (ref)
                ui.camera.CFrame = CFrame.new(cameraFocusPos + Vector3.new(cameraOffsetX, UI_CONFIG.CAMERA_HEIGHT, cameraOffsetZ), cameraFocusPos);
            end);
            return;
        end;
    end);
end;
local function setupDummyAnimator() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: ui (ref)
    if not ui.realDummy then
        return false;
    else
        ui.humanoid = ui.realDummy:FindFirstChildWhichIsA("Humanoid");
        if ui.humanoid then
            ui.animator = ui.humanoid:FindFirstChildOfClass("Animator");
            if not ui.animator then
                ui.animator = Instance.new("Animator");
                ui.animator.Parent = ui.humanoid;
            end;
        end;
        ui.previewAnimTrack = nil;
        return ui.humanoid and ui.animator;
    end;
end;
local function previewSelectedAnimation(animIndex) --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: ui (ref), CAR_ANIMS (ref), state (ref)
    if not ui.animator then
        return;
    else
        if ui.previewAnimTrack then
            pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: ui (ref)
                ui.previewAnimTrack:Stop();
                ui.previewAnimTrack:Destroy();
            end);
            ui.previewAnimTrack = nil;
        end;
        local l_status_2, l_result_2 = pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
            -- upvalues: CAR_ANIMS (ref), animIndex (ref), ui (ref)
            local l_Animation_0 = Instance.new("Animation");
            l_Animation_0.AnimationId = "rbxassetid://" .. CAR_ANIMS[animIndex].id;
            local viewportAnimTrack = ui.animator:LoadAnimation(l_Animation_0);
            viewportAnimTrack.Priority = Enum.AnimationPriority.Action;
            viewportAnimTrack.Looped = true;
            viewportAnimTrack:Play();
            viewportAnimTrack:AdjustWeight(1);
            viewportAnimTrack:AdjustSpeed(1);
            return viewportAnimTrack;
        end);
        if l_status_2 and l_result_2 then
            ui.previewAnimTrack = l_result_2;
        end;
        if ui.animNameText then
            ui.animNameText.Text = "Animation " .. state.currentIndex .. "/" .. #CAR_ANIMS;
        end;
        return;
    end;
end;
local function stopActiveCarAnimation() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: state (ref)
    if state.activeTrack then
        pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
            -- upvalues: state (ref)
            state.activeTrack:Stop();
            state.activeTrack:Destroy();
        end);
        state.activeTrack = nil;
    end;
    if state.activeConn then
        pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
            -- upvalues: state (ref)
            state.activeConn:Disconnect();
        end);
        state.activeConn = nil;
    end;
end;
local function playCarAnimationOnCharacter(characterModel) --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: stopActiveCarAnimation (ref), CAR_ANIMS (ref), state (ref), RunService (ref), UI_CONFIG (ref)
    if not characterModel or not characterModel.Parent then
        return;
    else
        stopActiveCarAnimation();
        local l_Humanoid_1 = characterModel:FindFirstChild("Humanoid");
        local l_HumanoidRootPart_1 = characterModel:FindFirstChild("HumanoidRootPart");
        if not l_Humanoid_1 or not l_HumanoidRootPart_1 then
            warn("Character missing required parts");
            return;
        else
            local l_status_3, l_result_3 = pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
                -- upvalues: CAR_ANIMS (ref), state (ref), l_Humanoid_1 (ref)
                local l_Animation_1 = Instance.new("Animation");
                l_Animation_1.AnimationId = "rbxassetid://" .. CAR_ANIMS[state.currentIndex].id;
                local playerAnimTrack = l_Humanoid_1:LoadAnimation(l_Animation_1);
                playerAnimTrack.Priority = Enum.AnimationPriority.Action;
                playerAnimTrack:Play();
                playerAnimTrack.Looped = true;
                playerAnimTrack:AdjustWeight(1);
                return playerAnimTrack;
            end);
            if not l_status_3 or not l_result_3 then
                warn("Failed to load animation");
                return;
            else
                state.activeTrack = l_result_3;
                pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
                    -- upvalues: characterModel (ref), l_Humanoid_1 (ref)
                    workspace.CurrentCamera.CameraSubject = characterModel:FindFirstChild("Head") or l_Humanoid_1;
                end);
                local l_Position_0 = l_HumanoidRootPart_1.Position;
                local lastPosTime = os.clock();
                state.activeConn = RunService.Heartbeat:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
                    -- upvalues: state (ref), l_HumanoidRootPart_1 (ref), l_result_3 (ref), lastPosTime (ref), l_Position_0 (ref), UI_CONFIG (ref), CAR_ANIMS (ref)
                    if state.carstop or not l_HumanoidRootPart_1.Parent or not l_result_3.IsPlaying then
                        return;
                    else
                        local l_Position_1 = l_HumanoidRootPart_1.Position;
                        local nowTime = os.clock();
                        local elapsed = nowTime - lastPosTime;
                        if elapsed > 0 then
                            local velocity = (l_Position_1 - l_Position_0) / elapsed;
                            local l_Magnitude_0 = velocity.Magnitude;
                            if UI_CONFIG.SPEED_THRESHOLD < l_Magnitude_0 then
                                local forwardDot = l_HumanoidRootPart_1.CFrame.LookVector:Dot(velocity.Unit);
                                local calculatedSpeed = l_Magnitude_0 / UI_CONFIG.SPEED_DIVISOR * CAR_ANIMS[state.currentIndex].mult * (forwardDot >= 0 and 1 or -1);
                                do
                                    local l_v109_0 = calculatedSpeed;
                                    pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
                                        -- upvalues: l_result_3 (ref), l_v109_0 (ref)
                                        l_result_3:AdjustSpeed(l_v109_0);
                                    end);
                                end;
                            else
                                pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
                                    -- upvalues: l_result_3 (ref)
                                    l_result_3:AdjustSpeed(0);
                                end);
                            end;
                        end;
                        l_Position_0 = l_Position_1;
                        lastPosTime = nowTime;
                        return;
                    end;
                end);
                return;
            end;
        end;
    end;
end;
local function showStopConfirmationDialog(onDecision) --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: state (ref), ui (ref), createFrame (ref), UI_ALPHA (ref), makeCorner (ref), UI_CONFIG (ref), createLabel (ref), createButton (ref), UI_COLORS (ref), attachHoverTransparency (ref)
    if state.confirmationgui or not ui.screenGui then
        return;
    else
        state.confirmationgui = true;
        local confirmDialogFrame = createFrame(ui.screenGui, UDim2.new(0, 250, 0, 120), UDim2.new(0.5, -125, 0.5, -60), UI_ALPHA.POPUP);
        confirmDialogFrame.Name = "ConfirmationDialog";
        makeCorner(UI_CONFIG.MAIN_CORNER_RADIUS).Parent = confirmDialogFrame;
        createLabel(confirmDialogFrame, UDim2.new(1, -20, 0, 50), UDim2.new(0, 10, 0, 10), "Are you sure you want to close?\n(This will stop the current animation)", 14).TextWrapped = true;
        local confirmButtonsFrame = createFrame(confirmDialogFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 10, 1, -45), 1);
        local confirmYesButton = createButton(confirmButtonsFrame, UDim2.new(0.4, 0, 1, 0), UDim2.new(0, 0, 0, 0), "Yes", UI_CONFIG.BUTTON_TEXT_SIZE);
        confirmYesButton.BackgroundColor3 = UI_COLORS.CONFIRM_YES;
        confirmYesButton.BackgroundTransparency = UI_ALPHA.POPUP_BUTTON;
        confirmYesButton.Font = Enum.Font.GothamBold;
        local confirmNoButton = createButton(confirmButtonsFrame, UDim2.new(0.4, 0, 1, 0), UDim2.new(0.6, 0, 0, 0), "No", UI_CONFIG.BUTTON_TEXT_SIZE);
        confirmNoButton.BackgroundColor3 = UI_COLORS.CONFIRM_NO;
        confirmNoButton.BackgroundTransparency = UI_ALPHA.POPUP_BUTTON;
        confirmNoButton.Font = Enum.Font.GothamBold;
        attachHoverTransparency(confirmYesButton);
        attachHoverTransparency(confirmNoButton);
        confirmYesButton.MouseButton1Click:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
            -- upvalues: confirmDialogFrame (ref), onDecision (ref), state (ref)
            confirmDialogFrame:Destroy();
            onDecision(true);
            state.confirmationgui = false;
        end);
        confirmNoButton.MouseButton1Click:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
            -- upvalues: confirmDialogFrame (ref), onDecision (ref), state (ref)
            confirmDialogFrame:Destroy();
            onDecision(false);
            state.confirmationgui = false;
        end);
        return;
    end;
end;
local function setupKeyboardShortcuts() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: UserInputService (ref), ui (ref), state (ref), CAR_ANIMS (ref), previewSelectedAnimation (ref), Players (ref), playCarAnimationOnCharacter (ref)
    UserInputService.InputBegan:Connect(function(input, gameProcessed) --[[ Line: 0 ]] --[[ Name:  ]]
        -- upvalues: ui (ref), state (ref), CAR_ANIMS (ref), previewSelectedAnimation (ref), Players (ref), playCarAnimationOnCharacter (ref)
        if gameProcessed or not ui.screenGui or state.carstop then
            return;
        else
            if input.KeyCode == Enum.KeyCode.K then
                ui.screenGui.Enabled = not ui.screenGui.Enabled;
            elseif input.KeyCode == Enum.KeyCode.Left then
                state.currentIndex = (state.currentIndex - 2) % #CAR_ANIMS + 1;
                previewSelectedAnimation(state.currentIndex);
            elseif input.KeyCode == Enum.KeyCode.Right then
                state.currentIndex = state.currentIndex % #CAR_ANIMS + 1;
                previewSelectedAnimation(state.currentIndex);
            elseif (input.KeyCode == Enum.KeyCode.Return or input.KeyCode == Enum.KeyCode.KeypadEnter) and Players.LocalPlayer.Character then
                playCarAnimationOnCharacter(Players.LocalPlayer.Character);
            end;
            return;
        end;
    end);
end;
local function wireUIButtonCallbacks() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: ui (ref), state (ref), CAR_ANIMS (ref), previewSelectedAnimation (ref), Players (ref), playCarAnimationOnCharacter (ref), stopActiveCarAnimation (ref), getViewportScaleHelpers (ref), showStopConfirmationDialog (ref)
    ui.prevBtn.MouseButton1Click:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
        -- upvalues: state (ref), CAR_ANIMS (ref), previewSelectedAnimation (ref)
        state.currentIndex = (state.currentIndex - 2) % #CAR_ANIMS + 1;
        previewSelectedAnimation(state.currentIndex);
    end);
    ui.nextBtn.MouseButton1Click:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
        -- upvalues: state (ref), CAR_ANIMS (ref), previewSelectedAnimation (ref)
        state.currentIndex = state.currentIndex % #CAR_ANIMS + 1;
        previewSelectedAnimation(state.currentIndex);
    end);
    ui.playBtn.MouseButton1Click:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
        -- upvalues: Players (ref), playCarAnimationOnCharacter (ref)
        if Players.LocalPlayer.Character then
            playCarAnimationOnCharacter(Players.LocalPlayer.Character);
        end;
    end);
    ui.stopBtn.MouseButton1Click:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
        -- upvalues: stopActiveCarAnimation (ref)
        stopActiveCarAnimation();
    end);
    ui.minBtn.MouseButton1Click:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
        -- upvalues: state (ref), ui (ref), getViewportScaleHelpers (ref)
        state.minimized = not state.minimized;
        if state.minimized then
            ui.mainFrame.Size = UDim2.new(0, ui.mainFrame.AbsoluteSize.X, 0, 30);
            ui.contentFrame.Visible = false;
        else
            local vpHelpers = getViewportScaleHelpers();
            ui.mainFrame.Size = vpHelpers.uSize(0.2, 0.35);
            ui.contentFrame.Visible = true;
        end;
    end);
    ui.closeBtn.MouseButton1Click:Connect(function() --[[ Line: 0 ]] --[[ Name:  ]]
        -- upvalues: showStopConfirmationDialog (ref), state (ref), stopActiveCarAnimation (ref), ui (ref)
        showStopConfirmationDialog(function(didConfirm) --[[ Line: 0 ]] --[[ Name:  ]]
            -- upvalues: state (ref), stopActiveCarAnimation (ref), ui (ref)
            if didConfirm then
                state.carstop = true;
                stopActiveCarAnimation();
                if ui.realDummy then
                    ui.realDummy:Destroy();
                end;
                if ui.screenGui then
                    ui.screenGui:Destroy();
                end;
                if getgenv then
                    getgenv().CarExecuted = false;
                end;
            end;
        end);
    end);
end;
local function setupRespawnAutoReplay() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: Players (ref), state (ref), playCarAnimationOnCharacter (ref)
    local l_LocalPlayer_1 = Players.LocalPlayer;
    if not l_LocalPlayer_1 then
        return;
    else
        l_LocalPlayer_1.CharacterAdded:Connect(function(newCharacter) --[[ Line: 0 ]] --[[ Name:  ]]
            -- upvalues: state (ref), playCarAnimationOnCharacter (ref)
            if state.carstop then
                return;
            else
                local respawnHumanoid = newCharacter:WaitForChild("Humanoid", 10);
                local respawnRootPart = newCharacter:WaitForChild("HumanoidRootPart", 10);
                if not respawnHumanoid or not respawnRootPart then
                    return;
                else
                    task.wait(2);
                    if newCharacter.Parent and not state.carstop then
                        playCarAnimationOnCharacter(newCharacter);
                    end;
                    return;
                end;
            end;
        end);
        return;
    end;
end;
local l_status_4, l_result_4 = pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
    -- upvalues: StarterGui (ref), isLocalPlayerR15 (ref), resetExistingUIAndSingleton (ref), buildRootUI (ref), buildTitleBar (ref), buildAnimHeader (ref), buildViewport (ref), buildNavControls (ref), buildPlayStopControls (ref), applyButtonHoverEffects (ref), createAndSetupDummyModels (ref), ui (ref), startViewportSyncLoop (ref), setupDummyAnimator (ref), previewSelectedAnimation (ref), state (ref), setupKeyboardShortcuts (ref), wireUIButtonCallbacks (ref), setupRespawnAutoReplay (ref)
    pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
        -- upvalues: StarterGui (ref)
        StarterGui:SetCore("SendNotification", {
            Title = "Car Animations", 
            Text = "Loading script...", 
            Duration = 3
        });
    end);
    if not isLocalPlayerR15() then
        pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
            -- upvalues: StarterGui (ref)
            StarterGui:SetCore("SendNotification", {
                Title = "Car Animations", 
                Text = "This script only works with R15 characters!", 
                Duration = 5
            });
        end);
        return;
    elseif not resetExistingUIAndSingleton() then
        pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
            -- upvalues: StarterGui (ref)
            StarterGui:SetCore("SendNotification", {
                Title = "Car Animations", 
                Text = "Script is already running!", 
                Duration = 3
            });
        end);
        return;
    elseif not pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
        -- upvalues: buildRootUI (ref), buildTitleBar (ref), buildAnimHeader (ref), buildViewport (ref), buildNavControls (ref), buildPlayStopControls (ref), applyButtonHoverEffects (ref)
        buildRootUI();
        buildTitleBar();
        buildAnimHeader();
        buildViewport();
        buildNavControls();
        buildPlayStopControls();
        applyButtonHoverEffects();
    end) then
        warn("Failed to create interface");
        if getgenv then
            getgenv().CarExecuted = false;
        end;
        return;
    else
        task.spawn(function() --[[ Line: 0 ]] --[[ Name:  ]]
            -- upvalues: createAndSetupDummyModels (ref), ui (ref), StarterGui (ref), startViewportSyncLoop (ref), setupDummyAnimator (ref), previewSelectedAnimation (ref), state (ref), setupKeyboardShortcuts (ref), wireUIButtonCallbacks (ref), setupRespawnAutoReplay (ref)
            local setupOk = false;
            local setupAttempts = 0;
            local maxSetupAttempts = 3;
            while not setupOk and setupAttempts < maxSetupAttempts do
                setupAttempts = setupAttempts + 1;
                setupOk = createAndSetupDummyModels();
                if not setupOk then
                    task.wait(1);
                end;
            end;
            if not setupOk then
                warn("Failed to create dummy models after " .. maxSetupAttempts .. " attempts");
                if ui.screenGui then
                    ui.screenGui:Destroy();
                end;
                if getgenv then
                    getgenv().CarExecuted = false;
                end;
                pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
                    -- upvalues: StarterGui (ref)
                    StarterGui:SetCore("SendNotification", {
                        Title = "Car Animations", 
                        Text = "Failed to load dummy model. Try again.", 
                        Duration = 5
                    });
                end);
                return;
            else
                startViewportSyncLoop();
                if not setupDummyAnimator() then
                    warn("Failed to initialize animation system");
                    return;
                else
                    previewSelectedAnimation(state.currentIndex);
                    setupKeyboardShortcuts();
                    wireUIButtonCallbacks();
                    setupRespawnAutoReplay();
                    pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
                        -- upvalues: StarterGui (ref)
                        StarterGui:SetCore("SendNotification", {
                            Title = "Car Animations", 
                            Text = "Script loaded! Press K to toggle UI", 
                            Duration = 5
                        });
                    end);
                    return;
                end;
            end;
        end);
        return;
    end;
end);
if not l_status_4 then
    warn("Script execution failed: " .. tostring(l_result_4));
    pcall(function() --[[ Line: 0 ]] --[[ Name:  ]]
        -- upvalues: StarterGui (ref), l_result_4 (ref)
        StarterGui:SetCore("SendNotification", {
            Title = "Car Animations", 
            Text = "Script failed to load: " .. tostring(l_result_4), 
            Duration = 8
        });
    end);
end;