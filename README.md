# AK Admin Script - Complete Analysis & Deobfuscation

Full analysis and deobfuscation of the "AK Admin 75 Command Script" for Roblox.

## 📊 Project Status

### Downloaded Command Scripts:
- **Total Scripts:** 58 command scripts
- **Readable Scripts:** 40 scripts (69%) ✅
- **VM-Protected (Luraph):** 18 scripts (31%) ❌
- **MoonSec Deobfuscated:** 4 scripts (7%) ✅ 100% success!
- **Manually Processed:** 3 scripts (animhub, sfly, jerk - beautification/merging)
- **Already Readable:** 33 scripts (downloaded without VM protection)
- **Luraph Deobfuscation:** 0/18 (Luraph VM too strong for hook-based bypass)

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
│   ├── readable/                      # 40 readable scripts ✅ (69%)
│   │   ├── animhub.lua               # ✅ 269KB, beautified + renamed + syntax fixed
│   │   ├── sfly.lua                  # ✅ 32KB, merged mobile + desktop versions
│   │   ├── jerk.lua                  # ✅ Fully deobfuscated (including R6/R15 remotes)
│   │   ├── caranims.lua              # ✅ MoonSec V3 → Oracle (31KB, 770 lines)
│   │   ├── ugcemotes.lua             # ✅ MoonSec V3 → Oracle (37KB, 910 lines)
│   │   ├── jerk_r6.lua               # ✅ MoonSec V3 → Oracle (2.5KB, 73 lines)
│   │   ├── jerk_r15.lua              # ✅ MoonSec V3 → Oracle (1.7KB, 47 lines)
│   │   ├── iy.lua                    # ✅ 486KB, Infinite Yield admin
│   │   ├── emotes.lua, fling.lua, hug.lua, invis.lua
│   │   ├── antiall.lua, antibang.lua, antifling.lua, antiheadsit.lua
│   │   ├── antikidnap.lua, antislide.lua, antivoid.lua
│   │   ├── chatlogs.lua, domainexpansion.lua, facebang.lua
│   │   ├── friendcheck.lua, pianoplayer.lua, shiftlock.lua
│   │   ├── touchfling.lua, uafling.lua, walkonair.lua
│   │   └── ... and 15 more readable scripts
│   └── vm_obfuscated/                # 18 Luraph-protected scripts ❌ (31%)
│       ├── reanim.lua
│       ├── antiafk.lua, antivcban.lua, call.lua
│       ├── chateditor.lua, kidnap.lua, stalk.lua
│       ├── speed.lua, flip.lua, trip.lua
│       └── ... and 14 more Luraph-protected scripts
│
│   ├── moonsec_deobfuscated/         # MoonSec V3 bytecode (intermediate)
│   │   ├── caranims.luac, ugcemotes.luac
│   │   └── jerk_r6.luac, jerk_r15.luac
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
│   ├── beautify_all_readable.py      # Batch beautifier for all readable scripts
│   ├── rename_variables.py           # Variable renaming tool
│   ├── comprehensive_rename.py       # Advanced variable renaming (148 vars renamed)
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

4. **VM Protection**
   - 18/58 command scripts use Luraph VM (31%) - couldn't be deobfuscated
   - 4/58 used MoonSec V3 (7%) - 100% success with Oracle decompiler
   - 40/58 scripts total are now readable (69%)
   - No standard loadstring() calls in Luraph VM scripts - custom VM interpreter

5. **Luraph Anti-Tamper Protection**
   - 18/58 scripts protected with Luraph VM
   - Anti-tamper detects and blocks all bypass attempts
   - Hook-based deobfuscation fundamentally doesn't work
   - 7 different bypass variants all failed

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
- Complete deobfuscation results (40/58 readable - 69% success)
- MoonSec V3 breakthrough (4/4 scripts - 100% success)
- Why Luraph VM couldn't be bypassed (0/18 scripts)
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

## ✅ Readable Scripts Summary (40 total)

### Manually Processed Scripts (7)
These required special processing (beautification, merging, variable renaming, MoonSec deobfuscation):

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

### 3. jerk.lua ✅ FULLY PROCESSED
- **Status:** Main loader + both R6/R15 remote scripts deobfuscated
- **Processing:** Used MoonsecDeobfuscator + Oracle API to deobfuscate MoonSec V3 protection
  - R6: jerk_r6.lua (2.5KB, 73 lines) - Animation jerk for R6 avatars
  - R15: jerk_r15.lua (1.7KB, 47 lines) - Animation jerk for R15 avatars
- **Description:** Animation jerk loader for R6/R15 rigs
- **Location:** [downloaded_commands/readable/jerk.lua](downloaded_commands/readable/jerk.lua)

### 4. caranims.lua ✅ MOONSEC V3 DEOBFUSCATED
- **Size:** 31KB, 770 lines
- **Processing:** MoonsecDeobfuscator → Oracle API decompilation
- **Description:** Car animations with GUI controls
- **Location:** [downloaded_commands/readable/caranims.lua](downloaded_commands/readable/caranims.lua)

### 5. ugcemotes.lua ✅ MOONSEC V3 DEOBFUSCATED
- **Size:** 37KB, 910 lines
- **Processing:** MoonsecDeobfuscator → Oracle API decompilation
- **Description:** UGC emotes system with comprehensive animation support
- **Location:** [downloaded_commands/readable/ugcemotes.lua](downloaded_commands/readable/ugcemotes.lua)

### 6. jerk_r6.lua ✅ MOONSEC V3 DEOBFUSCATED
- **Size:** 2.5KB, 73 lines
- **Processing:** MoonsecDeobfuscator → Oracle API decompilation
- **Description:** Animation jerk tool for R6 avatars
- **Location:** [downloaded_commands/readable/jerk_r6.lua](downloaded_commands/readable/jerk_r6.lua)

### 7. jerk_r15.lua ✅ MOONSEC V3 DEOBFUSCATED
- **Size:** 1.7KB, 47 lines
- **Processing:** MoonsecDeobfuscator → Oracle API decompilation
- **Description:** Animation jerk tool for R15 avatars
- **Location:** [downloaded_commands/readable/jerk_r15.lua](downloaded_commands/readable/jerk_r15.lua)

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

## ❌ Luraph VM-Protected Scripts (18)

These scripts remain in [downloaded_commands/vm_obfuscated/](downloaded_commands/vm_obfuscated/) and cannot be deobfuscated:

**Why Luraph deobfuscation failed:**
1. **Luraph Anti-Tamper Detection** - Detects and blocks all hook attempts on debug.info, pcall, setfenv
2. **Deep internal recursion** - Luraph VM has 181+ call depth as architectural feature
3. **Custom VM bytecode** - No standard Lua loadstring() calls to hook
4. **Hook-based approaches fundamentally don't work**

**All 7 bypass variants tested on flip.lua:**
- Simplified: Anti-tamper crash (detected hooks immediately)
- No increment: Stack overflow at 166
- Recursion limit (50): Stack overflow at 181
- High limit (500): Stack overflow at 182
- No debuginfo: Stack overflow at 127
- Capture only: Froze Roblox
- Guarded: Stack overflow at 181

**Complete List (18 scripts):**
1. animcopy.lua - Animation copier
2. antiafk.lua - Anti-AFK
3. antivcban.lua - Anti voice chat ban
4. call.lua - Phone call UI
5. chateditor.lua - Chat editor
6. coloredbaseplate.lua - Colored baseplate
7. flip.lua - Flip character
8. ftp.lua - Fast teleport
9. gokutp.lua - Goku-style teleport
10. infbaseplate.lua - Infinite baseplate
11. kidnap.lua - Kidnap feature
12. limborbit.lua - Limbo orbit
13. reanim.lua - Reanimation/size changer
14. reverse.lua - Reverse controls
15. shaders.lua - Graphics shaders
16. speed.lua - Speed hack
17. spotify.lua - Spotify UI
18. stalk.lua - Player stalker

**Note:** caranims.lua and ugcemotes.lua were successfully deobfuscated using MoonSec V3 tools and moved to readable/

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
5. 31% of commands are still Luraph VM-protected black boxes (18/58)
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
| Luraph VM Obfuscation | 🟡 MEDIUM | 31% of commands are black boxes (18/58) |
| Unverified Code | 🟡 MEDIUM | Even readable scripts could be harmful |

**Overall Verdict:** 🔴 **UNSAFE - DO NOT USE**

---

## 🔬 Protection Analysis

The AK admin commands use sophisticated multi-layer protection:

### Layer 1: Initial Obfuscation
- Minification (animhub.lua case)
- String encryption
- Control flow obfuscation

### Layer 2: VM Obfuscation
- **Luraph VM:** 18/58 scripts - Custom bytecode, couldn't be bypassed ❌
- **MoonSec V3:** 4/58 scripts - Successfully deobfuscated with Oracle API ✅
- VM interpreter at runtime
- No standard Lua loadstring() calls

### Layer 3: Anti-Tamper Detection (Luraph)
- **Extremely effective** - Defeated all 7 bypass variants
- Detects hooked functions (debug.info, pcall, setfenv)
- Triggers immediate crash or causes stack overflow
- Makes hook-based deobfuscation impossible
- **This is why Luraph scripts remain protected** 🔴

### Layer 4: Deep VM Recursion
- Luraph VM uses 181+ call depth internally
- Can't be prevented by external recursion limits
- Even 500 recursion limit still overflows
- Architectural feature, not just anti-tamper

### Layer 5: Alternative Obfuscation (MoonSec V3)
- Used by 4 scripts (caranims, ugcemotes, jerk_r6, jerk_r15)
- Different obfuscator than Luraph
- Successfully deobfuscated using MoonsecDeobfuscator + Oracle API ✅

---

## 📊 Analysis Statistics

- **Total Payloads Captured:** 24
- **Total Commands Found:** 116+
- **Command Scripts Downloaded:** 58
- **Readable Scripts:** 40 (69%)
- **Luraph VM-Protected:** 18 (31%)
- **MoonSec V3 Scripts:** 4 (100% deobfuscated)
- **Manually Processed:** 7 (animhub, sfly, jerk + 4 MoonSec scripts)
- **Whitelisted Users:** 5
- **Discord Webhook:** 1 (active surveillance)
- **External Download Sources:** 2 domains
- **Total Analysis Documents:** 9 (including MoonSec and Luraph docs)
- **Total Tools Created:** 10+ (beautifiers, renamers, MoonSec tools, Luraph bypasses)

---

## 🎓 What We Learned

### Technical Insights:

1. **VM Virtualization (Mixed Success)**
   - **Luraph VM:** 18/58 scripts (31%) - couldn't be bypassed despite 7 different approaches
   - **MoonSec V3:** 4/58 scripts (7%) - 100% success using MoonsecDeobfuscator + Oracle API
   - Custom execution engines that don't call loadstring()
   - Luraph VM has deep internal recursion (181+ call depth) preventing hook-based bypass
   - Good news: 69% of scripts (40/58) are now readable!

2. **Luraph Anti-Tamper is Extremely Strong** 🔴 CRITICAL DISCOVERY
   - All 7 bypass variants defeated by anti-tamper detection
   - Detects any hooks on debug.info, pcall, setfenv
   - Triggers crashes or stack overflow when tampered with
   - Hook-based approaches fundamentally don't work

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
   - 40/58 scripts (69%) now readable
   - 33 scripts downloaded without VM protection
   - 7 scripts required manual processing (beautification/merging/deobfuscation)
   - Manual processing successfully beautified minified code (animhub.lua)
   - Fetched and merged remote scripts (sfly.lua)
   - Variable renaming improves readability (148 variables renamed)
   - MoonSec V3 breakthrough: 4/4 scripts successfully deobfuscated

2. **Luraph VM Deobfuscation Failed Completely**
   - Tested 7 different bypass variants on flip.lua
   - Luraph anti-tamper detected and blocked all attempts
   - Simplified bypass: Immediate crash from anti-tamper
   - Other 6 variants: Stack overflow at 127-182 call depth
   - Hook-based approaches fundamentally don't work (0/18 success)
   - Luraph VM has deep internal recursion (181+ call depth)
   - No intermediate deobfuscated code to capture

3. **MoonSec V3 vs Luraph: Different Outcomes**
   - MoonSec V3: 100% success with right tools (MoonsecDeobfuscator + Oracle)
   - Luraph: 0% success despite 7 different bypass attempts
   - Luraph's anti-tamper is significantly stronger than MoonSec V3

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
Total Files: 120+

├── Analysis Documents: 9 (in analysis/)
├── Payload Scripts: 24 (in payloads/)
├── Downloaded Commands: 58 (40 readable, 18 Luraph VM-protected)
├── MoonSec Deobfuscated: 4 (intermediate bytecode in moonsec_deobfuscated/)
├── Extracted Scripts: 2 (in extracted/)
├── Tools: 10+ (in tools/)
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

**Analysis Date:** December 25-26, 2025
**Status:** ✅ Complete (40/58 scripts readable, 18/58 Luraph VM-protected)
**Security Verdict:** 🔴 UNSAFE - DO NOT USE

**Final Verdict:** 69% of scripts are readable (40/58), 31% remain Luraph VM-protected (18/58). Major breakthrough with MoonSec V3 deobfuscation (4/4 scripts - 100% success). Luraph VM proved unbreakable with hook-based approaches (0/18 success after testing 7 bypass variants).

---

**Stay safe, and never run unknown scripts!** 🛡️
