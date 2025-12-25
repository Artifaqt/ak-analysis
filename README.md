# AK Admin Script - Complete Analysis & Deobfuscation

Full analysis and deobfuscation of the "AK Admin 75 Command Script" for Roblox.

## 📊 Project Status

### Downloaded Command Scripts:
- **Total Scripts:** 58 command scripts
- **Readable Scripts:** 36 scripts (62%) ✅
- **VM-Protected:** 22 scripts (38%) ❌
- **Manually Processed:** 3 scripts (animhub, sfly, jerk - required beautification/merging)
- **Already Readable:** 33 scripts (downloaded without VM protection)
- **Dynamic Deobfuscation Success:** 0% (Luraph VM too strong for protected scripts)

### Key Discovery:
**Scripts crash when run standalone but work through AK Admin** due to environment dependency - they require AK Admin infrastructure to execute.

---

## 📁 Folder Structure

```
ak/
├── README.md                          # This file
├── ak.lua                             # Original loader script
├── ak_deobfuscated.lua               # VM-obfuscated loader (Layer 0)
│
├── analysis/                          # All analysis documents ✅
│   ├── DEOBFUSCATION_STATUS.md       # 📊 Current deobfuscation status
│   ├── CRASH_ANALYSIS.md             # Why scripts crash (environment dependency)
│   ├── COMMAND_TO_FILE_MAPPING.md    # Maps !commands to downloaded files
│   ├── COMPLETE_ANALYSIS.md          # Full system analysis
│   ├── COMMAND_ANALYSIS.md           # Analysis of 40 remote control commands
│   ├── CAPTURE_ACTUAL_PAYLOAD.md     # HTTP capture instructions
│   └── READY_TO_CAPTURE.md           # Payload capture guide
│
├── downloaded_commands/               # Downloaded !command scripts (58 total)
│   ├── readable/                      # 36 readable scripts ✅ (62%)
│   │   ├── animhub.lua               # ✅ 269KB, beautified + renamed + syntax fixed
│   │   ├── sfly.lua                  # ✅ 32KB, merged mobile + desktop versions
│   │   ├── jerk.lua                  # ⚠️ Loader documented (remotes MoonSec V3 protected)
│   │   ├── iy.lua                    # ✅ 486KB, Infinite Yield admin
│   │   ├── emotes.lua, fling.lua, hug.lua, invis.lua
│   │   ├── antiall.lua, antibang.lua, antifling.lua, antiheadsit.lua
│   │   ├── antikidnap.lua, antislide.lua, antivoid.lua
│   │   ├── chatlogs.lua, domainexpansion.lua, facebang.lua
│   │   ├── friendcheck.lua, pianoplayer.lua, shiftlock.lua
│   │   ├── touchfling.lua, uafling.lua, walkonair.lua
│   │   └── ... and 15 more readable scripts
│   └── vm_obfuscated/                # 22 VM-protected scripts ❌ (38%)
│       ├── ugcemotes.lua, caranims.lua, reanim.lua
│       ├── antiafk.lua, antivcban.lua, call.lua
│       ├── chateditor.lua, kidnap.lua, stalk.lua
│       ├── speed.lua, flip.lua, trip.lua
│       └── ... and 10 more VM-protected scripts
│
├── extracted/                         # Key extracted/readable scripts
│   ├── main_command_script.lua       # 40 remote control commands (921 lines)
│   └── PAYLOAD_BREAKDOWN.md          # Analysis of 24 payload files
│
├── payloads/                          # All 24 captured payload scripts
│   ├── actual_payload_1.lua through actual_payload_24.lua
│   ├── actual_payload_8.lua          # ⚠️ Main 40-command remote control script
│   ├── actual_payload_11.lua         # Group join prompt
│   ├── actual_payload_15.lua         # Position save/rejoin utility
│   ├── actual_payload_17.lua         # 📋 76+ command registry
│   ├── actual_payload_20.lua         # User tags/ranks (166K)
│   ├── actual_payload_21.lua         # GUI organizer
│   ├── actual_payload_23.lua         # Headsit/bodysit feature
│   └── actual_payload_24.lua         # Auto-rejoin script
│
├── tools/                             # Processing tools created ✅
│   ├── beautify_lua.py               # Basic Lua beautifier
│   ├── beautify_lua_advanced.py      # Advanced beautifier (better spacing)
│   ├── rename_variables.py           # Variable renaming tool
│   ├── capture_http_payload.lua      # HTTP request monitor
│   ├── run_deobfuscation.lua         # All-in-one deobfuscator
│   ├── analyze_reanimation_patterns.py   # Pattern analyzer
│   └── vm_bytecode_analyzer.py       # VM bytecode analyzer
│
└── LOGS/                              # Analysis logs and results
    ├── api_calls.txt
    ├── vm_analysis_report.txt
    └── deobfuscation_console.log
```

---

## 🚨 Quick Summary

### What This Script Actually Is:

❌ **NOT** an admin script that gives YOU control
✅ **ACTUALLY** a remote control system where 5 whitelisted users control YOU

### Key Findings:

1. **116+ Total Commands** (not just 75)
   - 40 `.commands` - Remote control by whitelisted users (DANGEROUS)
   - 76+ `!commands` - Your commands (download external scripts)

2. **Remote Control System**
   - 5 whitelisted user IDs can control ANY user running the script
   - Commands include: kill, loopkill, crash, kick, freeze, fling

3. **Complete Surveillance**
   - All activity logged to Discord webhook
   - Tracks username, commands, timestamps

4. **VM Protection (Luraph)**
   - 22/58 command scripts use custom bytecode obfuscation (38%)
   - 36/58 scripts were already readable (62%)
   - Dynamic deobfuscation failed for all VM-protected scripts
   - No standard loadstring() calls in VM scripts - custom VM interpreter

5. **Environment Dependency** 🔴 CRITICAL DISCOVERY
   - Scripts crash when run standalone
   - Work perfectly when executed through AK Admin
   - Require AK-specific globals and infrastructure
   - Validate environment before execution

### Security Verdict: 🔴 **DO NOT USE**

---

## 📖 Where to Start

### For Quick Understanding:
Read: **[analysis/COMPLETE_ANALYSIS.md](analysis/COMPLETE_ANALYSIS.md)**

This contains:
- Complete breakdown of both command systems
- All 116+ commands documented
- Security analysis
- How the deception works

### For Deobfuscation Status:
Read: **[analysis/DEOBFUSCATION_STATUS.md](analysis/DEOBFUSCATION_STATUS.md)**

This contains:
- Complete deobfuscation results (3/25 success)
- Why dynamic deobfuscation failed
- Processing details for readable scripts
- Protection analysis (5 layers)

### For Crash Analysis:
Read: **[analysis/CRASH_ANALYSIS.md](analysis/CRASH_ANALYSIS.md)**

This contains:
- Why scripts crash standalone
- Environment dependency explanation
- How AK Admin infrastructure works

### For Command Details:
See: **[analysis/COMMAND_ANALYSIS.md](analysis/COMMAND_ANALYSIS.md)**

---

## ✅ Readable Scripts Summary (36 total)

### Manually Processed Scripts (3)
These required special processing (beautification, merging, variable renaming):

### 1. animhub.lua ✅ FULLY PROCESSED
- **Original:** 144KB minified on 1 line
- **After Processing:** 269KB formatted across 2,605 lines
- **Processing Applied:**
  - Advanced beautification with proper spacing
  - 30+ variables renamed to meaningful names (a→localPlayer, b→animateScript, etc.)
  - All syntax errors fixed (broken quotes, operators, URLs)
- **Description:** Animation hub with 400+ emotes, 30+ animation packs, custom animations, GUI controls
- **Source:** External GitHub (not VM-protected, just minified)
- **Location:** [downloaded_commands/readable/animhub.lua](downloaded_commands/readable/animhub.lua)

### 2. sfly.lua ✅ FULLY PROCESSED
- **Size:** 32KB combined, 1,024 lines
- **Processing Applied:**
  - Fetched both remote scripts (mobile + desktop versions)
  - Merged supermanfly.lua and supermanflyjj.lua into one file
  - Added comment separators between versions
- **Description:** Superman fly script with GUI, supports both touch (mobile) and keyboard (desktop) controls
- **Source:** Remote scripts from akadmin-bzk.pages.dev (not VM-protected)
- **Location:** [downloaded_commands/readable/sfly.lua](downloaded_commands/readable/sfly.lua)

### 3. jerk.lua ⚠️ PARTIALLY PROCESSED
- **Status:** Main loader documented, remote scripts remain obfuscated
- **Issue:** Both R6 and R15 remote URLs use **MoonSec V3 protection** (different obfuscator)
  - R6: https://pastefy.app/wa3v2Vgm/raw (MoonSec V3 protected)
  - R15: https://pastefy.app/YZoglOyJ/raw (MoonSec V3 protected)
- **Description:** Animation jerk loader for R6/R15 rigs
- **Location:** [downloaded_commands/readable/jerk.lua](downloaded_commands/readable/jerk.lua)

### Already Readable Scripts (33)
These were downloaded without VM protection and require no processing:

**Anti-Protection Scripts (7):**
- antiall.lua (7.8KB) - All anti-protections combined
- antibang.lua (5.9KB) - Anti-bang protection
- antifling.lua (1.4KB) - Anti-fling protection
- antiheadsit.lua (5.8KB) - Anti-headsit protection
- antikidnap.lua (13KB) - Anti-kidnap protection
- antislide.lua (2.7KB) - Anti-slide/glide
- antivoid.lua (1.1KB) - Anti-void protection

**Interaction Scripts (4):**
- facebang.lua (28KB) - Player interaction animation
- fling.lua (21KB) - Fling players
- hug.lua (13KB) - Hug animation
- touchfling.lua (17KB) - Touch-based fling

**Utility Scripts (11):**
- ad.lua (3.9KB) - Advertisement system
- akbypasser.lua (12KB) - Chat bypasser
- animlogger.lua (12KB) - Animation logger
- chatlogs.lua (9.6KB) - Chat logging
- friendcheck.lua (31KB) - Friend checker
- fpsboost.lua (1.3KB) - FPS booster
- naturaldisastergodmode.lua (1.6KB) - Natural Disaster godmode
- pianoplayer.lua (18KB) - Piano player
- shiftlock.lua (3.7KB) - Shiftlock enabler
- shmost.lua (21KB) - Unknown utility
- walkonair.lua (7.4KB) - Walk on air

**Movement Scripts (3):**
- fastre.lua (6.6KB) - Fast reset
- uafling.lua (13KB) - Universal fling
- voidre.lua (3.5KB) - Void reset

**Visual/World Scripts (3):**
- domainexpansion.lua (14KB) - Domain expansion effect
- emotes.lua (21KB) - Emote hub
- skymaster.lua (4.4KB) - Sky effects

**Character Scripts (3):**
- invis.lua (16KB) - Invisibility
- r6.lua (3.6KB) - Force R6 avatar
- r15.lua (3.6KB) - Force R15 avatar

**Other Scripts (2):**
- iy.lua (486KB) - Infinite Yield admin script
- re.lua (427 bytes) - Reset character

**Location:** All 36 scripts in [downloaded_commands/readable/](downloaded_commands/readable/)

---

## ❌ VM-Protected Scripts (22)

These scripts remain in [downloaded_commands/vm_obfuscated/](downloaded_commands/vm_obfuscated/) and cannot be deobfuscated:

**Why deobfuscation failed:**
1. **Luraph VM Protection** - Custom bytecode interpreter, not standard Lua
2. **No loadstring() calls** - Hook-based deobfuscation impossible
3. **Anti-tamper detection** - Detects debugging attempts
4. **Environment validation** - Crashes when AK infrastructure is missing

**Complete List (22 scripts):**
1. animcopy.lua - Animation copier
2. antiafk.lua - Anti-AFK
3. antivcban.lua - Anti voice chat ban
4. call.lua - Phone call UI
5. caranims.lua - Car animations
6. chateditor.lua - Chat editor
7. coloredbaseplate.lua - Colored baseplate
8. flip.lua - Flip character
9. ftp.lua - Fast teleport
10. gokutp.lua - Goku-style teleport
11. infbaseplate.lua - Infinite baseplate
12. kidnap.lua - Kidnap feature
13. limborbit.lua - Limbo orbit
14. reanim.lua - Reanimation/size changer
15. reverse.lua - Reverse controls
16. shaders.lua - Graphics shaders
17. speed.lua - Speed hack
18. spotify.lua - Spotify UI
19. stalk.lua - Player stalker
20. swordreach.lua - Sword reach
21. trip.lua - Trip animation
22. ugcemotes.lua - UGC emotes

---

## 🔍 Important Payload Files

### Critical Files to Review:

| File | Description | Risk |
|------|-------------|------|
| **payloads/actual_payload_8.lua** | Main remote control script (40 commands) | 🔴 CRITICAL |
| **payloads/actual_payload_17.lua** | Registry of 76+ `!commands` | 🟡 MEDIUM |
| **extracted/main_command_script.lua** | Same as payload_8 (readable copy) | 🔴 CRITICAL |

### Utility Files:

| File | Description |
|------|-------------|
| **payloads/actual_payload_10.lua** | Command loader bootstrap (loads originalLoadcmds.lua) |
| **payloads/actual_payload_11.lua** | Group join prompt (group 36018037) |
| **payloads/actual_payload_15.lua** | Position save/rejoin |
| **payloads/actual_payload_20.lua** | User tags/ranks configuration (166K) |
| **payloads/actual_payload_21.lua** | GUI organizer |
| **payloads/actual_payload_23.lua** | Headsit/bodysit feature |
| **payloads/actual_payload_24.lua** | Auto-rejoin (queue_on_teleport) |

### Analysis:

| File | Description |
|------|-------------|
| **extracted/PAYLOAD_BREAKDOWN.md** | Complete analysis of all 24 payload files |
| **analysis/DEOBFUSCATION_STATUS.md** | Current status of deobfuscation efforts |
| **analysis/CRASH_ANALYSIS.md** | Why scripts crash and environment dependency |
| **analysis/COMMAND_TO_FILE_MAPPING.md** | Maps all !commands to files |

---

## ⚙️ Tools Created

### Lua Processing Tools (Python):
- **tools/beautify_lua.py** - Basic Lua beautifier
  - Adds indentation and separates statements
  - Result: Too many newlines (1.8MB for animhub)

- **tools/beautify_lua_advanced.py** ⭐ - Improved beautifier
  - Better spacing logic and operator formatting
  - Line breaks before keywords
  - Result: Optimal formatting (269KB for animhub)

- **tools/rename_variables.py** - Variable renaming tool
  - Analyzes code usage patterns
  - Creates systematic renaming map
  - Applies replacements with word boundaries
  - Result: 30+ variables renamed in animhub.lua

### Capture & Deobfuscation Tools (Lua):
- **tools/capture_http_payload.lua** - Captures HTTP requests made by scripts
- **tools/run_deobfuscation.lua** - All-in-one dynamic deobfuscator (failed for VM scripts)

### Analysis Tools (Python):
- **tools/analyze_reanimation_patterns.py** - Static pattern analysis
- **tools/vm_bytecode_analyzer.py** - VM bytecode structure analyzer

---

## 🎯 The Deception Explained

### What They Advertise:
> "AK Admin - 75 command admin script with animations visible to all"

### What You Get:
1. **Not 75 commands** - Actually 116+ commands
2. **You're not the admin** - 5 strangers admin YOU via remote control
3. **"Visible to all"** - Because they remote control your actual character

### The Remote Control System:

**Whitelisted User IDs:**
```
34963408
7706532914
8319842463
1810203567
2823434956
```

These users can type in chat:
```
.kill YourUsername
.loopkill YourUsername
.crash YourUsername
.chat YourUsername say something embarrassing
```

And it executes on YOUR client with NO way to stop it except closing the game.

### The Surveillance:

**Discord Webhook:**
```
https://discord.com/api/webhooks/1416824385267957800/1qCdZ7WoxBAOWtYMgpzFnAiwj0w5hOkMeRsEUE_VDjLUwBgQOllGOzZ2db63Ai10Z1lg
```

Every command execution is logged with:
- Your username
- Command name
- Timestamp
- Success/failure

---

## 🛡️ Recommendations

### DO NOT USE the Full Script

**Reasons:**
1. Remote control by strangers
2. Complete surveillance
3. Could get your account banned
4. No way to disable it
5. 38% of commands are still VM-protected black boxes
6. Even "readable" scripts are unverified and potentially harmful

### Safer Alternatives:

If you want specific features, run individual `!command` scripts directly:

```lua
-- Example: Just get emotes without the remote control/surveillance
loadstring(game:HttpGet("https://akadmin-bzk.pages.dev/Emotes.lua"))()
```

This gives you the feature WITHOUT:
- Remote control system
- Discord surveillance
- Auto-persistence
- Group join prompts

**WARNING:** Individual scripts are still unverified and could be harmful.

---

## 📋 Command System Breakdown

### System 1: `.commands` (Remote Control)

**40 commands** that whitelisted users execute on YOU:

**Categories:**
- Destructive: `kill`, `loopkill`, `crash`, `kick`
- Control: `freeze`, `stun`, `chat`, `say`
- Movement: `bring`, `goto`, `orbit`, `walkto`
- Animation: `fling`, `jumpscare`, `trip`, `dance`, `spin`
- Character: `reset`, `jump`, `sit`, `speed`, `invert`
- Meta: `usecmd`, `cmds`, `whitelist`, `unwhitelist`

Full list in: **[analysis/COMMAND_ANALYSIS.md](analysis/COMMAND_ANALYSIS.md)**

### System 2: `!commands` (Your Commands)

**76+ commands** that download scripts from `akadmin-bzk.pages.dev`:

**Categories:**
- Animations: `!ugcemotes`, `!caranims`, `!emotes`, `!animhub`
- Movement: `!speed`, `!sfly`, `!ftp`, `!walkonair`
- Reanimation: `!reanim`, `!r6`, `!r15`, `!invis`
- Interaction: `!headsit`, `!kidnap`, `!hug`, `!fling`
- Utility: `!antiafk`, `!fpsboost`, `!chatlogs`, `!stalk`
- Protection: `!antibang`, `!antiheadsit`, `!antifling`
- And 50+ more...

Full list in: **[analysis/COMPLETE_ANALYSIS.md](analysis/COMPLETE_ANALYSIS.md)**

---

## 🔐 Security Summary

| Threat | Level | Details |
|--------|-------|---------|
| Remote Control | 🔴 CRITICAL | Others fully control your character |
| Surveillance | 🔴 CRITICAL | All activity logged to Discord |
| Malicious Abuse | 🔴 HIGH | Easy to grief/harass users |
| Account Safety | 🟡 MEDIUM | Could trigger bans |
| External Scripts | 🟡 MEDIUM | 58 unverified downloads |
| Deception | 🔴 HIGH | Misleading marketing |
| VM Obfuscation | 🟡 MEDIUM | 38% of commands are black boxes (22/58) |
| Unverified Code | 🟡 MEDIUM | Even readable scripts could be harmful |

**Overall Verdict:** 🔴 **UNSAFE - DO NOT USE**

---

## 🔬 Protection Analysis

The AK admin commands use sophisticated multi-layer protection:

### Layer 1: Initial Obfuscation
- Minification (animhub.lua case)
- String encryption
- Control flow obfuscation

### Layer 2: VM Obfuscation (Luraph)
- Custom bytecode compilation
- VM interpreter at runtime
- No standard Lua loadstring() calls
- **22/25 scripts use this** ❌

### Layer 3: Environment Validation
- Scripts validate AK Admin environment
- Check for specific globals set by main loader
- Require infrastructure from 24 payload files
- Crash when validation fails (`while true do end`)
- **This is why they work in AK but crash standalone** 🔴

### Layer 4: Anti-Tamper Detection
- Detect hooked functions
- Check for debuggers
- Verify VM bytecode integrity
- Detect exploit-specific globals

### Layer 5: Alternative Obfuscation (MoonSec V3)
- Used by jerk.lua remote scripts
- Different obfuscator than Luraph
- Also can't be easily deobfuscated

---

## 📊 Analysis Statistics

- **Total Payloads Captured:** 24
- **Total Commands Found:** 116+
- **Command Scripts Downloaded:** 58
- **Readable Scripts:** 36 (62%)
- **VM-Protected:** 22 (38%)
- **Manually Processed:** 3 (animhub, sfly, jerk)
- **Whitelisted Users:** 5
- **Discord Webhook:** 1 (active surveillance)
- **External Download Sources:** 2 domains
- **Total Analysis Documents:** 7
- **Total Tools Created:** 7

---

## 🎓 What We Learned

### Technical Insights:

1. **VM Virtualization (38% of scripts)**
   - 22/58 scripts use Luraph-style bytecode obfuscation
   - Custom execution engine that doesn't call loadstring()
   - Traditional deobfuscation impossible (0/22 success for VM scripts)
   - Can only be analyzed through runtime memory dumping or VM reverse engineering
   - Good news: 62% of scripts (36/58) were already readable!

2. **Environment Dependency** 🔴 CRITICAL DISCOVERY
   - Scripts require AK Admin infrastructure to run
   - Validate environment before execution
   - Crash when run standalone (even if deobfuscated)
   - This is architectural design, not just anti-tamper

3. **Multi-Layer Architecture**
   - Loader (ak.lua) → Key System → 24 Payloads
   - Command loader → Command registry → Individual command scripts
   - Some scripts load additional external scripts

4. **Command System Design**
   - Two separate systems (`.` and `!` prefixes)
   - Remote execution via chat monitoring
   - Download-on-demand for `!commands`

5. **Surveillance Implementation**
   - Discord webhooks for logging
   - Complete activity tracking
   - No way to opt-out

### Processing Lessons:

1. **Most Scripts Were Already Readable**
   - 36/58 scripts (62%) downloaded without VM protection
   - Only 3 scripts required manual processing (beautification/merging)
   - 33 scripts were immediately usable for analysis
   - Manual processing successfully beautified minified code (animhub.lua)
   - Fetched and merged remote scripts (sfly.lua)
   - Variable renaming improves readability

2. **Dynamic Deobfuscation Failed Completely**
   - Loadstring hooks don't work (0/25 success)
   - VM uses custom interpreter
   - No intermediate deobfuscated code to capture

3. **Environment Dependency Blocks Standalone Execution**
   - Even if we deobfuscate source code, scripts won't run
   - Require AK-specific globals and infrastructure
   - Would need to recreate entire AK environment

### Security Lessons:

1. **Never trust script marketing**
   - "75 commands" != "75 commands YOU control"
   - "Admin script" != "You get admin"

2. **Read before you run**
   - Deobfuscation reveals true intent
   - Static analysis insufficient for VM obfuscation
   - Dynamic analysis + monitoring essential

3. **Remote control is dangerous**
   - Whitelisted users = backdoor access
   - Chat-based commands = covert control
   - No user consent required

---

## 📁 File Count Summary

```
Total Files: 113+

├── Analysis Documents: 7 (in analysis/)
├── Payload Scripts: 24 (in payloads/)
├── Downloaded Commands: 58 (36 readable, 22 VM-protected)
├── Extracted Scripts: 2 (in extracted/)
├── Tools: 7 (in tools/)
├── Logs: 3+ (in LOGS/)
├── Original Files: 2 (ak.lua, ak_deobfuscated.lua)
└── Documentation: 1 (README.md)
```

---

## 🔗 External Resources

### Script Hosting Domains:
- `https://akadmin-bzk.pages.dev/` - Main command script host (76+ scripts)
- `https://absent.wtf/AKADMIN.lua` - Auto-rejoin script
- `https://pastefy.app/` - MoonSec V3 protected scripts (jerk.lua remotes)
- `https://raw.githubusercontent.com/` - External scripts (animhub, fpsboost, iy)

### Discord Webhook:
- `https://discord.com/api/webhooks/1416824385267957800/...`

### Roblox Group:
- Group ID: `36018037`

---

## ⚠️ Disclaimer

This analysis is for **educational and security research purposes only**.

- ✅ Understanding how malicious scripts work
- ✅ Learning about obfuscation techniques
- ✅ Identifying security threats
- ✅ Developing deobfuscation tools
- ❌ NOT for creating similar malicious scripts
- ❌ NOT for exploiting other users
- ❌ NOT for bypassing game security

**Use this knowledge responsibly.**

---

## 📞 Questions?

Read the analysis documents in order:

1. **[DEOBFUSCATION_STATUS.md](analysis/DEOBFUSCATION_STATUS.md)** - Current deobfuscation results
2. **[COMPLETE_ANALYSIS.md](analysis/COMPLETE_ANALYSIS.md)** - Full system analysis
3. **[CRASH_ANALYSIS.md](analysis/CRASH_ANALYSIS.md)** - Environment dependency explanation
4. **[COMMAND_ANALYSIS.md](analysis/COMMAND_ANALYSIS.md)** - Command details
5. **[COMMAND_TO_FILE_MAPPING.md](analysis/COMMAND_TO_FILE_MAPPING.md)** - Command to file mapping
6. **[PAYLOAD_BREAKDOWN.md](extracted/PAYLOAD_BREAKDOWN.md)** - All 24 payloads analyzed

---

**Analysis Date:** December 25, 2025
**Status:** ✅ Complete (36/58 scripts readable, 22/58 VM-protected)
**Security Verdict:** 🔴 UNSAFE - DO NOT USE

**Final Verdict:** 62% of scripts are readable (36/58), 38% remain VM-protected (22/58). Most scripts were already readable when downloaded - only 3 required manual processing.

---

**Stay safe, and never run unknown scripts!** 🛡️
