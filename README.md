# AK Admin Script - Complete Analysis & Deobfuscation

Full analysis and deobfuscation of the "AK Admin 75 Command Script" for Roblox.

## 📁 Folder Structure

```
ak/
├── README.md                    # This file
├── ak.lua                       # Original loader script
├── ak_deobfuscated.lua         # VM-obfuscated loader (Layer 0)
│
├── analysis/                    # All analysis documents
│   ├── COMPLETE_ANALYSIS.md    # 📊 MAIN ANALYSIS - Read this first!
│   ├── COMMAND_ANALYSIS.md     # Analysis of 40 remote control commands
│   ├── REANIMATION_BEHAVIOR_ANALYSIS.md  # Behavioral analysis
│   ├── SECURITY_ANALYSIS_REPORT.md       # Initial security assessment
│   ├── DEOBFUSCATION_RESULTS.md          # Layer 1 deobfuscation results
│   ├── DEOBFUSCATION_GUIDE.md            # Technical deobfuscation guide
│   ├── READY_TO_CAPTURE.md               # Payload capture guide
│   ├── CAPTURE_ACTUAL_PAYLOAD.md         # HTTP capture instructions
│   └── QUICK_START_DEOBFUSCATION.md      # Quick start guide
│
├── payloads/                    # All 24 captured payload scripts
│   ├── actual_payload_1.lua    # VM-obfuscated component
│   ├── actual_payload_2.lua    # VM-obfuscated component
│   ├── ...
│   ├── actual_payload_8.lua    # ⚠️ Main 40-command remote control script
│   ├── actual_payload_11.lua   # Group join prompt
│   ├── actual_payload_15.lua   # Position save/rejoin utility
│   ├── actual_payload_17.lua   # 📋 76+ command registry
│   ├── actual_payload_20.lua   # User tags/ranks (166K)
│   ├── actual_payload_21.lua   # GUI organizer
│   ├── actual_payload_23.lua   # Headsit/bodysit feature
│   ├── actual_payload_24.lua   # Auto-rejoin script
│   └── ...
│
├── extracted/                   # Key extracted/readable scripts
│   └── main_command_script.lua # 40 remote control commands (921 lines)
│
├── tools/                       # Deobfuscation and analysis tools
│   ├── capture_http_payload.lua           # HTTP request monitor
│   ├── run_deobfuscation.lua             # All-in-one deobfuscator
│   ├── deobfuscate_dynamic.lua           # Dynamic analysis framework
│   ├── run_layer2_deobfuscation.lua      # Layer 2 deobfuscator
│   ├── analyze_reanimation_patterns.py   # Pattern analyzer
│   ├── vm_bytecode_analyzer.py           # VM bytecode analyzer
│   ├── advanced_analysis.py              # Advanced static analysis
│   └── deobfuscate.py                    # Basic deobfuscator
│
└── LOGS/                        # Analysis logs and results
    ├── api_calls.txt           # 15 API calls captured
    ├── vm_analysis_report.txt  # VM structure analysis
    ├── reanimation_analysis.txt # Pattern analysis results
    ├── HOW_TO_USE.txt          # User guide
    ├── LAYER2_GUIDE.txt        # Layer 2 instructions
    └── QUICK_SETUP.txt         # Quick setup guide
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

4. **External Dependencies**
   - 76+ commands download scripts from `akadmin-bzk.pages.dev`
   - No verification of script safety

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

### For Command Details:
See: **[analysis/COMMAND_ANALYSIS.md](analysis/COMMAND_ANALYSIS.md)**

### For Technical Deep Dive:
See: **[analysis/REANIMATION_BEHAVIOR_ANALYSIS.md](analysis/REANIMATION_BEHAVIOR_ANALYSIS.md)**

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
| **payloads/actual_payload_11.lua** | Group join prompt (group 36018037) |
| **payloads/actual_payload_15.lua** | Position save/rejoin |
| **payloads/actual_payload_20.lua** | User tags/ranks configuration (166K) |
| **payloads/actual_payload_21.lua** | GUI organizer |
| **payloads/actual_payload_23.lua** | Headsit/bodysit feature |
| **payloads/actual_payload_24.lua** | Auto-rejoin (queue_on_teleport) |

---

## ⚙️ Tools Included

### Capture Tools:
- **tools/capture_http_payload.lua** - Captures HTTP requests made by scripts
- Used to intercept the actual payload downloads

### Deobfuscation Tools:
- **tools/run_deobfuscation.lua** - All-in-one dynamic deobfuscator
- **tools/deobfuscate_dynamic.lua** - Standalone framework
- **tools/run_layer2_deobfuscation.lua** - Layer 2 deobfuscator

### Analysis Tools:
- **tools/analyze_reanimation_patterns.py** - Static pattern analysis
- **tools/vm_bytecode_analyzer.py** - VM bytecode structure analyzer
- **tools/advanced_analysis.py** - Advanced static analysis

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
| External Scripts | 🟡 MEDIUM | 76+ unverified downloads |
| Deception | 🔴 HIGH | Misleading marketing |

**Overall Verdict:** 🔴 **UNSAFE - DO NOT USE**

---

## 📊 Analysis Statistics

- **Total Payloads Captured:** 24
- **Total Commands Found:** 116+
- **Whitelisted Users:** 5
- **Discord Webhook:** 1 (active surveillance)
- **External Download Sources:** 2 domains
- **VM-Obfuscated Files:** ~15
- **Readable Scripts:** ~9
- **Total Analysis Documents:** 9
- **Total Tools Created:** 7

---

## 🎓 What We Learned

### Technical Insights:

1. **VM Virtualization**
   - Uses Luraph-style bytecode obfuscation
   - Self-virtualizing VM (regenerates itself)
   - Traditional deobfuscation impossible

2. **Multi-Layer Architecture**
   - Loader (ak.lua) → Key System → Multiple Payloads
   - 24+ separate scripts loaded dynamically
   - Some VM-obfuscated, some readable

3. **Command System Design**
   - Two separate systems (`.` and `!` prefixes)
   - Remote execution via chat monitoring
   - Download-on-demand for `!commands`

4. **Surveillance Implementation**
   - Discord webhooks for logging
   - Complete activity tracking
   - No way to opt-out

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
Total Files: 60+

├── Analysis Documents: 9 (in analysis/)
├── Payload Scripts: 24 (in payloads/)
├── Extracted Scripts: 1 (in extracted/)
├── Tools: 7 (in tools/)
├── Logs: 6 (in LOGS/)
├── Original Files: 2 (ak.lua, ak_deobfuscated.lua)
└── Documentation: 1 (README.md)
```

---

## 🔗 External Resources

### Script Hosting Domains:
- `https://akadmin-bzk.pages.dev/` - Main command script host
- `https://absent.wtf/AKADMIN.lua` - Auto-rejoin script
- `https://ichfickdeinemutta.pages.dev/` - Owner command bar

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
- ❌ NOT for creating similar malicious scripts
- ❌ NOT for exploiting other users

**Use this knowledge responsibly.**

---

## 📞 Questions?

Read the analysis documents in order:

1. **[COMPLETE_ANALYSIS.md](analysis/COMPLETE_ANALYSIS.md)** - Start here
2. **[COMMAND_ANALYSIS.md](analysis/COMMAND_ANALYSIS.md)** - Command details
3. **[REANIMATION_BEHAVIOR_ANALYSIS.md](analysis/REANIMATION_BEHAVIOR_ANALYSIS.md)** - Technical deep dive

---

**Analysis Date:** December 24, 2024
**Status:** ✅ Complete
**Security Verdict:** 🔴 UNSAFE - DO NOT USE

---

**Stay safe, and never run unknown scripts!** 🛡️
