# MoonSec V3 Deobfuscation - Complete Success!

## 🎉 Major Breakthrough

Successfully deobfuscated **4 MoonSec V3 protected scripts** using the MoonsecDeobfuscator + Oracle pipeline!

**New Success Rate: 40/58 scripts readable (69%)** - Up from 36/58 (62%)

---

## 📊 Summary

### Before MoonSec Deobfuscation:
- **Readable:** 36/58 scripts (62%)
- **VM-Protected:** 22/58 scripts (38%)
  - Luraph: ~20 scripts
  - MoonSec V3: 4 scripts (2 local + 2 remote)

### After MoonSec Deobfuscation:
- **Readable:** 40/58 scripts (69%) ✅ **+4 scripts!**
- **VM-Protected:** 18/58 scripts (31%)
  - Luraph: ~18 scripts (still protected)
  - MoonSec V3: 0 scripts ✅ **100% success!**

---

## ✅ Successfully Deobfuscated Scripts (4)

### 1. caranims.lua ✅ FULLY DEOBFUSCATED
- **Original:** MoonSec V3 protected (82KB obfuscated)
- **Deobfuscated:** 31KB, 770 lines of readable Lua
- **Description:** Car animations with GUI controls
- **Features:**
  - Animation playback system
  - GUI with buttons for different car animations
  - Camera rotation controls
  - Speed-based animation multipliers
  - Viewport preview system
- **Quality:** High - Oracle decompiler produced excellent variable names
- **Location:** [downloaded_commands/readable/caranims.lua](../downloaded_commands/readable/caranims.lua)

### 2. ugcemotes.lua ✅ FULLY DEOBFUSCATED
- **Original:** MoonSec V3 protected (75KB obfuscated)
- **Deobfuscated:** 37KB, 910 lines of readable Lua
- **Description:** UGC emotes system
- **Features:**
  - Large collection of UGC emote IDs
  - Emote playback controls
  - GUI for emote selection
  - Animation management
- **Quality:** High - Well-structured decompiled code
- **Location:** [downloaded_commands/readable/ugcemotes.lua](../downloaded_commands/readable/ugcemotes.lua)

### 3. jerk_r6.lua ✅ FULLY DEOBFUSCATED
- **Original:** MoonSec V3 protected (29KB obfuscated, remote URL)
- **Deobfuscated:** 2.5KB, 73 lines of readable Lua
- **Description:** Jerk animation for R6 rigs
- **Features:**
  - Tool creation system
  - Animation looping with specific time positions
  - RenderStepped connection for smooth playback
  - Support for multiple animation tracks
- **Quality:** Excellent - Clean, well-commented code
- **Location:** [downloaded_commands/readable/jerk_r6.lua](../downloaded_commands/readable/jerk_r6.lua)
- **Remote URL:** https://pastefy.app/wa3v2Vgm/raw

### 4. jerk_r15.lua ✅ FULLY DEOBFUSCATED
- **Original:** MoonSec V3 protected (23KB obfuscated, remote URL)
- **Deobfuscated:** 1.7KB, 47 lines of readable Lua
- **Description:** Jerk animation for R15 rigs
- **Features:**
  - Similar to R6 version but adapted for R15 rig
  - Tool-based activation
  - Animation time control
  - Clean stop/start functionality
- **Quality:** Excellent - Compact and readable
- **Location:** [downloaded_commands/readable/jerk_r15.lua](../downloaded_commands/readable/jerk_r15.lua)
- **Remote URL:** https://pastefy.app/YZoglOyJ/raw

---

## 🔧 Tools & Process

### Step 1: MoonSec V3 to Lua 5.1 Bytecode
**Tool:** MoonsecDeobfuscator (C#/.NET)
- **Repository:** https://github.com/tupsutumppu/MoonsecDeobfuscator
- **Input:** MoonSec V3 protected Lua scripts
- **Output:** Lua 5.1 bytecode (.luac files)
- **Success Rate:** 4/4 (100%)

**Command:**
```bash
MoonsecDeobfuscator.exe -dev -i <input.lua> -o <output.luac>
```

**Results:**
- caranims.luac: 24KB
- ugcemotes.luac: 24KB
- jerk_r6.luac: 2.2KB
- jerk_r15.luac: 1.5KB

### Step 2: Lua 5.1 Bytecode to Readable Lua
**Tool:** Oracle Decompiler (API-based)
- **Service:** https://oracle.mshq.dev (renamer.mshq.dev)
- **Method:** Node.js CLI script with API key
- **Input:** Lua 5.1 bytecode files
- **Output:** Decompiled Lua with AI-powered variable renaming
- **Success Rate:** 4/4 (100%)

**Features:**
- Excellent variable naming (e.g., `l_Players_0`, `l_UserInputService_0`)
- Preserves code structure
- Adds upvalue comments
- Includes line number annotations
- Constants with descriptive names

**Command:**
```bash
node oracle_decompile.js <input.luac> <output.lua>
```

---

## 📈 Impact on Overall Statistics

### Updated Success Rates:
```
Total Scripts:  58

Readable Scripts:  40 (69%)  ← UP from 36 (62%)
  ├─ Already Readable: 33 (57%)
  ├─ Manually Processed: 3 (5%)
  └─ MoonSec Deobfuscated: 4 (7%)  ← NEW!

VM-Protected:  18 (31%)  ← DOWN from 22 (38%)
  └─ Luraph VM: ~18 scripts (still protected)

MoonSec V3 Deobfuscation:  100% (4/4)  ← BREAKTHROUGH!
```

### Breakdown by Category:
- **Dynamic Deobfuscation (Luraph):** 0/18 (0%) - Still fails
- **MoonSec V3 Deobfuscation:** 4/4 (100%) - Complete success!
- **Already Readable:** 33/58 (57%)
- **Manual Processing:** 3/58 (5%)
- **Overall Success:** 40/58 (69%)

---

## 🎯 Key Findings

### What Worked:
1. ✅ **MoonSec V3 is Deobfuscatable**
   - Unlike Luraph VM, MoonSec V3 can be broken
   - Two-step process: VM bytecode extraction → decompilation
   - 100% success rate on all 4 MoonSec scripts

2. ✅ **Oracle Decompiler is Excellent**
   - Produces high-quality readable code
   - AI-powered variable renaming
   - Maintains code structure and logic
   - Includes helpful comments (upvalues, line numbers)

3. ✅ **Remote Script Identification**
   - Found MoonSec scripts hidden in remote URLs
   - Successfully downloaded and processed them
   - Documented the full jerk.lua functionality

### What Still Doesn't Work:
1. ❌ **Luraph VM Protection**
   - ~18 scripts still use Luraph VM obfuscation
   - No standard deobfuscation works
   - Would require VM reverse engineering or memory dumping
   - Estimated effort: weeks to months

2. ⚠️ **Environment Dependency**
   - All scripts (including deobfuscated) require AK Admin infrastructure
   - Won't run standalone even with source code
   - This is architectural design, not just protection

---

## 📁 File Locations

### Decompiled Scripts (Ready to Analyze):
```
ak/downloaded_commands/readable/
├── caranims.lua          (31KB, 770 lines) ← NEW!
├── ugcemotes.lua         (37KB, 910 lines) ← NEW!
├── jerk_r6.lua           (2.5KB, 73 lines) ← NEW!
└── jerk_r15.lua          (1.7KB, 47 lines) ← NEW!
```

### Intermediate Files (Bytecode):
```
ak/downloaded_commands/moonsec_deobfuscated/
├── caranims.luac         (24KB)
├── ugcemotes.luac        (24KB)
├── jerk_r6.luac          (2.2KB)
└── jerk_r15.luac         (1.5KB)
```

### Original MoonSec Files (Preserved):
```
ak/downloaded_commands/vm_obfuscated/
├── caranims.lua.moonsec_original   (82KB)
├── ugcemotes.lua.moonsec_original  (75KB)
├── jerk_r6.lua                      (29KB, downloaded)
└── jerk_r15.lua                     (23KB, downloaded)
```

### Tools Created:
```
ak/tools/
├── MoonsecDeobfuscator/           (Cloned repository)
│   └── bin/Release/net9.0/MoonsecDeobfuscator.exe
└── oracle_decompile.js            (Node.js CLI script with API key)
```

---

## 🏆 Achievement Summary

### What We Accomplished:
1. ✅ **Identified all 4 MoonSec V3 scripts** (2 local + 2 remote)
2. ✅ **Successfully deobfuscated all 4** using MoonsecDeobfuscator
3. ✅ **Decompiled all 4 to readable Lua** using Oracle API
4. ✅ **Increased readable script count** from 36 to 40 (+11% improvement)
5. ✅ **Documented the entire process** for future reference
6. ✅ **Created automated tools** (oracle_decompile.js)

### Statistics:
- **Time Investment:** ~2 hours
- **Success Rate:** 100% (4/4 MoonSec scripts)
- **Lines of Code Recovered:** 1,800 lines
- **Scripts Now Readable:** 40/58 (69%)
- **MoonSec Scripts Remaining:** 0/4 (0%)

---

## 🔮 Next Steps (Optional)

### For the Remaining 18 Luraph Scripts:

**Option 1: Accept Current State** ⭐ RECOMMENDED
- We now have **69% of scripts readable** (40/58)
- Only 31% remain protected (18/58)
- Diminishing returns on further deobfuscation efforts

**Option 2: Luraph VM Memory Dumping** (Advanced)
- Requires runtime memory access
- Hook into Roblox memory during execution
- Extract bytecode from VM at runtime
- Effort: Very High, Success: Medium (60-80%)

**Option 3: Luraph VM Reverse Engineering** (Expert)
- Reverse engineer the Luraph VM implementation
- Create custom Luraph decompiler
- Effort: Extremely High (weeks/months), Success: High (80-90%)

**Option 4: Behavioral Analysis** (Practical)
- Run commands in-game and document behavior
- Observe GUI, effects, animations
- Map functionality without source code
- Effort: Low-Medium, Success: 100% for behavior documentation

---

## 📝 Updated Jerk.lua Documentation

Previously, jerk.lua was marked as "⚠️ PARTIALLY PROCESSED" because the remote scripts were MoonSec protected.

**Now:** ✅ **FULLY PROCESSED**

- Main loader: Documented
- R6 remote script: ✅ Deobfuscated (jerk_r6.lua)
- R15 remote script: ✅ Deobfuscated (jerk_r15.lua)
- **Status changed from** ⚠️ to ✅

---

## 💡 Lessons Learned

### Technical Insights:
1. **Not All VM Protection is Equal**
   - MoonSec V3: Deobfuscatable (bytecode can be extracted)
   - Luraph VM: Much harder (custom VM interpreter)

2. **Two-Stage Deobfuscation Works**
   - Stage 1: VM bytecode extraction
   - Stage 2: Bytecode decompilation
   - Both stages must succeed

3. **Oracle Decompiler is Worth the Investment**
   - Produces excellent readable code
   - AI renaming is very effective
   - Much better than generic decompilers (unluac, luadec)

4. **Remote Script Investigation Pays Off**
   - Found hidden MoonSec scripts in remote URLs
   - Increased success rate significantly

### Process Improvements:
1. Always identify obfuscation type before attempting deobfuscation
2. Check for remote scripts that might use different protection
3. Use specialized tools for each protection type
4. Oracle > generic decompilers for quality output

---

## 🎉 Final Verdict

**MoonSec V3 Deobfuscation: COMPLETE SUCCESS!**

- ✅ 4/4 scripts deobfuscated (100%)
- ✅ All produce high-quality readable code
- ✅ Increased overall success from 62% to 69%
- ✅ Documented complete process for future use
- ✅ Created reusable tools (oracle_decompile.js)

**This represents a major breakthrough in the AK Admin analysis project!**

---

**Date:** December 26, 2025
**Success Rate:** 100% (4/4 MoonSec V3 scripts)
**Overall Project Success:** 69% (40/58 scripts readable)
**Status:** ✅ COMPLETE SUCCESS
