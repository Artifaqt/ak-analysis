# Luraph Dynamic Reversing Guide

## Overview

Since static Luraph deobfuscators only work on old versions (2020), we're attempting **dynamic reversing** - running the script in a controlled environment while capturing the deobfuscated code at runtime.

## Anti-Tamper Bypass Technique

### The Bypass
```lua
local err = function() error'a' end
```

**What it does:**
- Overrides error handling before Luraph's anti-tamper checks
- Prevents detection of debugging/hooking attempts
- Allows `loadstring`/`load` hooks to capture deobfuscated code

### Additional Bypasses Implemented

Our advanced bypass includes:
1. **Error override** - Suppress anti-tamper error throws
2. **Function hooks** - Capture `loadstring`, `load`, `pcall` calls
3. **Error filtering** - Detect and suppress anti-tamper errors
4. **Debug protection** - Hook `debug.getinfo` to hide debugging
5. **Safe execution** - Wrap calls in `pcall` to catch crashes

## Tools Created

### Original Tools (Basic)

#### 1. [luraph_dynamic_test.lua](../tools/luraph_dynamic_test.lua)
**Basic bypass with loadstring hooks**
- Simple anti-tamper bypass
- Hooks `loadstring` and `load`
- Saves captured code to files

#### 2. [luraph_advanced_bypass.lua](../tools/luraph_advanced_bypass.lua)
**Advanced bypass with multiple techniques**
- Multiple anti-tamper bypasses
- Error suppression (detects anti-tamper keywords)
- Debug protection
- Automatic file saving with numbered captures
- Preview of captured code
- Detailed logging

### TechHog8984 Method (Improved) ⭐ RECOMMENDED

**Source:** [TechHog8984's Luraph v14.2 Anti Format Bypass](https://gist.github.com/TechHog8984/2e41a77e1d62b5b9d91a5e84274cdf45)

#### 3. [luraph_bypass_simplified.lua](../tools/luraph_bypass_simplified.lua) ⭐ START HERE
**Minimal bypass - pcall hook only**
- Based on TechHog8984's gist method
- Only hooks pcall (no debug.info)
- Avoids stack overflow recursion
- Includes loadstring/load capture hooks
- **Status:** ✅ Best chance of success without crashes

#### 4. [luraph_bypass_no_increment.lua](../tools/luraph_bypass_no_increment.lua)
**Full bypass without stack increment**
- Hooks pcall, setfenv, debug.info, debug.traceback
- Removes `func + 1` to prevent recursion
- More protection than simplified version
- **Status:** If simplified version fails anti-tamper

#### 5. [luraph_bypass_recursion_limit.lua](../tools/luraph_bypass_recursion_limit.lua)
**Full bypass with recursion safety**
- Complete hook suite
- Recursion depth tracking (max 50 calls)
- Returns safe default if limit hit
- **Status:** If you need full protection with safety net

### Test Results

**flip.lua tested with TechHog8984's full bypass:**
- ✅ Anti-tamper bypass successful (no crash)
- ❌ Stack overflow at line 86 (recursion issue)
- **Fix:** Use the improved versions above (3, 4, or 5)

## How to Use

### Requirements
- Roblox script executor (Synapse, Script-Ware, etc.)
- One of the 18 Luraph-protected AK Admin scripts
- The bypass script

### Method 1: Roblox Executor (Recommended)

**⚠️ UPDATED:** Use the new TechHog8984 bypasses for better results!

1. **Load the bypass first (try in order):**
   ```lua
   -- Option A: Simplified (recommended to start)
   loadfile("C:/Users/Artifaqt/Downloads/ak/tools/luraph_bypass_simplified.lua")()

   -- Option B: No increment (if A fails anti-tamper)
   loadfile("C:/Users/Artifaqt/Downloads/ak/tools/luraph_bypass_no_increment.lua")()

   -- Option C: Recursion limit (if B causes stack overflow)
   loadfile("C:/Users/Artifaqt/Downloads/ak/tools/luraph_bypass_recursion_limit.lua")()
   ```

2. **Then execute the Luraph script:**
   ```lua
   loadfile("C:/Users/Artifaqt/Downloads/ak/downloaded_commands/vm_obfuscated/flip.lua")()
   ```

3. **Check the output directory:**
   ```
   C:/Users/Artifaqt/Downloads/ak/downloaded_commands/moonsec_deobfuscated/
   ```

4. **Look for files:**
   - `luraph_captured_1.lua`
   - `luraph_captured_2.lua`
   - etc.

### Method 2: Modified Script

1. **Create a combined test file:**
   ```lua
   -- Load bypass
   dofile("C:/path/to/luraph_advanced_bypass.lua")

   -- Load Luraph script
   dofile("C:/path/to/flip.lua")
   ```

2. **Execute in Roblox**

3. **Check output files**

### Method 3: Direct Integration

**Prepend the bypass to the script:**

```lua
-- Anti-tamper bypass
local err = function() error'a' end

-- Your hooks here
local original_loadstring = loadstring
_G.loadstring = function(code, ...)
    print("[CAPTURED]", #code, "bytes")
    -- Save code...
    return original_loadstring(code, ...)
end

-- Original Luraph script below
return(function(Ci,zd,xN,bC,Hj,sJ,dD,TY,qj,Cq...)
    -- Luraph VM code...
end)(...)
```

## Expected Results

### If Successful
```
[INFO] Initializing bypass techniques...
[OK] Error override installed
[OK] Original functions backed up
[OK] loadstring hook installed
[OK] load hook installed
[OK] error hook installed (anti-tamper suppression)
=== All Hooks Installed ===

[CAPTURE #1] loadstring called with 15234 bytes
[SAVED] luraph_captured_1.lua
[PREVIEW] local l_Players_0 = game:GetService("Players")...

[CAPTURE #2] load called with 8765 bytes
[SAVED] luraph_captured_2.lua
```

### If Failed
```
[ERROR CAUGHT] Tamper detected
[BYPASS] Anti-tamper error suppressed
```
or
```
[ERROR] Script crashed despite bypass
```

## Testing Strategy

### Start with smallest scripts first:
1. **flip.lua** (79KB) - Flip character
2. **ftp.lua** (67KB) - Fast teleport
3. **trip.lua** (68KB) - Trip animation
4. **shaders.lua** (70KB) - Graphics shaders
5. **gokutp.lua** (71KB) - Goku teleport

### Work up to larger scripts:
- **reanim.lua** (174KB)
- **spotify.lua** (127KB)
- **kidnap.lua** (90KB)

## Success Criteria

**Successful if ANY of these happen:**
1. ✅ Captured code in output files
2. ✅ Script executes without crashing
3. ✅ Partial code fragments captured
4. ✅ String tables extracted
5. ✅ Bytecode dumped

**Failed if:**
1. ❌ Script crashes immediately
2. ❌ Anti-tamper triggers despite bypass
3. ❌ No `loadstring`/`load` calls captured
4. ❌ Environment validation prevents execution

## Alternative Approaches

### If hooks don't work:

1. **Memory Dumping**
   - Use Roblox memory tools
   - Dump during execution
   - Extract bytecode from memory

2. **Bytecode Extraction**
   - Hook at lower level (C/C++ hooks)
   - Intercept Luau VM calls
   - Dump bytecode before execution

3. **Behavioral Analysis**
   - Run script in-game
   - Document functionality
   - Reverse engineer from behavior

## Limitations

### Known Issues:
1. **Environment Dependency** - Scripts require AK Admin infrastructure
2. **Modern Luraph** - May use anti-hook techniques we can't bypass
3. **No loadstring calls** - Luraph VM might not call `loadstring` at all
4. **Bytecode only** - Might only get bytecode, not source

### Why This Might Not Work:

**Luraph VM Architecture:**
- Doesn't use standard `loadstring`
- Executes bytecode directly
- Custom VM interpreter
- No intermediate Lua code

**Better chance if:**
- Script uses string decryption (might call `load`)
- Script loads additional modules (might call `loadstring`)
- Script has string tables (can extract those)

## Next Steps After Capture

### If you capture code:

1. **Verify it's valid Lua:**
   ```bash
   luac -p captured.lua
   ```

2. **Check if it's bytecode:**
   ```bash
   file captured.lua
   ```

3. **If it's bytecode, decompile:**
   ```bash
   # Using unluac
   java -jar unluac.jar captured.luac > decompiled.lua

   # Or Oracle
   node oracle_decompile.js captured.luac output.lua
   ```

4. **Apply variable renaming:**
   ```bash
   python comprehensive_rename.py
   ```

5. **Move to readable folder:**
   ```bash
   mv decompiled.lua ../downloaded_commands/readable/
   ```

## Success Metrics

### Target:
- **Ideal:** 18/18 Luraph scripts deobfuscated (100%)
- **Good:** 5-10 scripts captured (28-56%)
- **Acceptable:** 1-4 scripts captured (6-22%)
- **Learning:** 0 scripts but understanding why it failed

### Current Status:
- **Readable:** 40/58 (69%)
- **Luraph Protected:** 18/58 (31%)
- **Target with dynamic reversing:** 58/58 (100%)

## Documentation

### Capture Logs
All captures will be saved with:
- Capture number
- Source function (`loadstring` or `load`)
- Code size
- Preview (first 200 chars)

### File Naming
```
luraph_captured_1.lua  - First capture
luraph_captured_2.lua  - Second capture
luraph_captured_3.lua  - Third capture
...
```

## Safety Notes

⚠️ **Important:**
1. Only run in isolated Roblox testing environment
2. Don't use on main account (risk of ban)
3. Scripts may still execute malicious code
4. This is for security research only
5. The scripts are malware - handle carefully

## Expected Timeline

- **Setup:** 5 minutes
- **Per script test:** 2-5 minutes
- **Analysis if successful:** 10-20 minutes per script
- **Total for 18 scripts:** 2-4 hours

## Conclusion

This dynamic reversing approach is our **last viable option** for the 18 Luraph scripts. If this doesn't work, we'll need to:
- Accept the 69% success rate (40/58 readable)
- Use behavioral analysis for remaining scripts
- Wait for better Luraph deobfuscation tools

But it's worth trying! Even partial success (capturing string tables or fragments) gives us more insight than we have now.

---

**Status:** ⚠️ EXPERIMENTAL - Anti-tamper bypass confirmed working!
**Risk Level:** Medium (requires Roblox executor)
**Expected Success:** 30-60% chance of capturing code (improved with TechHog8984 method)
**Alternative:** Accept 69% success rate (still excellent!)
**Latest Update:** Dec 26, 2025 - Added improved bypasses to fix stack overflow issue
