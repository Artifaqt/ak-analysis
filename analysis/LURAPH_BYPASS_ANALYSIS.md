# Luraph Bypass Analysis - TechHog8984 Method

## Success: Anti-Tamper Defeated!

**Status:** ✅ The bypass successfully prevented Luraph's anti-tamper from crashing the script!

**Evidence:**
- Script executed without immediate crash
- No anti-tamper detection errors
- Script ran until hitting a stack overflow at line 86

---

## Stack Overflow Issue

### Error Details:
```
Stack overflow
Script '', Line 86
(repeated 100,010+ times, truncated at 16,384 characters)
```

### Root Cause Analysis:

The stack overflow is caused by **recursive hook calls** in the bypass. Specifically:

1. **debug.info hook recursion:**
   ```lua
   local myinfo = function(...)
       if type(func) == "number" then
           results = {old_debuginfo(func + 1, options)}  -- This can recurse
       end
   end
   ```

2. **Infinite loop scenario:**
   - Luraph calls `debug.info(2, "sl")`
   - Bypass intercepts, adds 1 to level: `debug.info(3, "sl")`
   - Next hook intercepts, adds 1 again: `debug.info(4, "sl")`
   - Continues infinitely until stack overflow

### Why It Happened:

The bypass adjusts stack levels (`func + 1`) to hide the hook itself, but if Luraph repeatedly calls `debug.info` in a loop, each call increments the level, creating exponential recursion.

---

## The Bypass Method (TechHog8984)

### How It Works:

**Core Principle:** Replace all line numbers in error stack traces with a consistent fake number (8984) so Luraph can't detect tampering.

**Hook Strategy:**

1. **pcall hook** - Intercepts error messages, replaces line numbers
2. **setfenv hook** - Prevents environment changes on hooked functions
3. **debug.info hook** - Returns fake line numbers for stack inspection
4. **debug.traceback hook** - Replaces line numbers in traceback strings

### Key Code:
```lua
local fakelinenumber = 8984

-- Replace :123: or :123\n with :8984: or :8984\n
local function replaceLineNumber(str)
    return (str:gsub(":(%d+)([:\r\n])", ":" .. fakelinenumber .. "%2"))
end
```

### Advanced Features:

- **hook_map table** - Tracks all hooked functions
- **newcclosure** - Makes hooks appear as C closures (harder to detect)
- **Table freeze** - Prevents Luraph from modifying the debug table
- **setfenv protection** - Errors if Luraph tries to change hook environments

---

## Fixes for Stack Overflow

### Option 1: Add Recursion Limit

```lua
local recursion_depth = 0
local MAX_RECURSION = 100

local myinfo = function(...)
    recursion_depth = recursion_depth + 1

    if recursion_depth > MAX_RECURSION then
        recursion_depth = recursion_depth - 1
        return "[C]", -1, "info", 0, true, myinfo
    end

    local results
    local func, options = ...
    if type(func) == "number" then
        results = {old_debuginfo(func + 1, options)}
    elseif func and hook_map[func] then
        local hook = hook_map[func]
        results = {
            "[C]",
            -1,
            hook[1],
            0,
            true,
            hook[2]
        }
    else
        results = {old_debuginfo(func, options)}
    end

    if results[1] ~= "[C]" then
        results[2] = fakelinenumber
    end

    recursion_depth = recursion_depth - 1
    return old_unpack(results)
end
```

### Option 2: Don't Increment Stack Level

```lua
local myinfo = function(...)
    local results
    local func, options = ...
    if type(func) == "number" then
        -- Don't add 1, just pass through
        results = {old_debuginfo(func, options)}
    elseif func and hook_map[func] then
        local hook = hook_map[func]
        results = {
            "[C]",
            -1,
            hook[1],
            0,
            true,
            hook[2]
        }
    else
        results = {old_debuginfo(func, options)}
    end

    if results[1] ~= "[C]" then
        results[2] = fakelinenumber
    end

    return old_unpack(results)
end
```

### Option 3: Cache Results

```lua
local info_cache = {}

local myinfo = function(...)
    local func, options = ...
    local cache_key = tostring(func) .. options

    if info_cache[cache_key] then
        return old_unpack(info_cache[cache_key])
    end

    local results
    if type(func) == "number" then
        results = {old_debuginfo(func, options)}
    elseif func and hook_map[func] then
        local hook = hook_map[func]
        results = {
            "[C]",
            -1,
            hook[1],
            0,
            true,
            hook[2]
        }
    else
        results = {old_debuginfo(func, options)}
    end

    if results[1] ~= "[C]" then
        results[2] = fakelinenumber
    end

    info_cache[cache_key] = results
    return old_unpack(results)
end
```

---

## Alternative: Simplified Bypass (Gist Version)

From the original [TechHog8984 gist](https://gist.github.com/TechHog8984/2e41a77e1d62b5b9d91a5e84274cdf45):

```lua
local old_pcall = pcall
pcall = newcclosure(function(...)
    local results = {old_pcall(...)}
    local first = results[1]
    if type(first) == "boolean" and first == false then
        local second = results[2]
        if type(second) == "string" then
            -- Replace :123: with :1:
            results[2] = (second:gsub(":(%d+)([:rn])", ":1%2"))
        end
    end
    return unpack(results)
end)
```

**This minimal version might work better** - it only hooks pcall without debug.info recursion.

---

## Testing Next Steps

### Test 1: Simplified Bypass Only
```lua
-- Only hook pcall, no debug hooks
local old_pcall = pcall
local old_unpack = unpack

pcall = function(...)
    local results = {old_pcall(...)}
    if not results[1] and type(results[2]) == "string" then
        results[2] = results[2]:gsub(":(%d+)([:\r\n])", ":8984%2")
    end
    return old_unpack(results)
end

-- Now load flip.lua
```

### Test 2: Option 2 (Don't Increment)
Use the full bypass but remove `func + 1` (Option 2 above)

### Test 3: Recursion Limit
Use Option 1 with MAX_RECURSION = 50

---

## Other Useful Tools Found

### From TechHog8984's Resources:

1. **moonsecdumper.lua** - MoonSec V3 dumper in pure Lua
   - Alternative to the C# MoonsecDeobfuscator we used
   - Might be more flexible for batch processing

2. **skeppy.luau** - IronBrew bytecode deserializer
   - Useful if we encounter IronBrew-protected scripts
   - Written in Luau

3. **inu** (Rust tool) - Lua bytecode parser
   - WIP tool for bytecode analysis
   - Supports Lua 5.1
   - Currently incomplete (testing infrastructure missing)
   - 43 commits, early stage
   - Not ready for production use yet

4. **luau-format** - Fast Luau code formatter in C++
   - Can simplify wide range of expressions
   - Useful for beautifying deobfuscated code

---

## Recommended Approach

### Immediate Fix:

1. **Try the simplified bypass first** (gist version with only pcall hook)
2. **If that fails, use Option 2** (full bypass without stack increment)
3. **If still failing, add recursion limit** (Option 1)

### Why This Matters:

- ✅ Anti-tamper is already defeated
- ⚠️ Just need to fix the stack overflow
- 🎯 Once fixed, we can capture deobfuscated code via loadstring hooks

### Success Criteria:

1. Script runs without stack overflow
2. No anti-tamper errors
3. Any loadstring/load calls are captured
4. If no calls are captured, at least the script executes fully

---

## File to Test First:

**flip.lua (79KB)** - Already tested, just need to fix the overflow

**Why continue with flip.lua:**
- We know anti-tamper bypass works
- Stack overflow is at line 86 (specific location)
- Once we fix the recursion issue, this should work

---

## Sources

- [Luraph v14.2 Anti Format Bypass (TechHog8984)](https://gist.github.com/TechHog8984/2e41a77e1d62b5b9d91a5e84274cdf45)
- [TechHog8984 GitHub Profile](https://github.com/TechHog8984)
- [inu - Rust Lua bytecode tool](https://github.com/TechHog8984/inu)
- [lua-tools/lua-bytecode - Rust bytecode parser](https://github.com/lua-tools/lua-bytecode)
- [luac-parser-rs - Comprehensive bytecode parser](https://github.com/metaworm/luac-parser-rs)

---

**Date:** December 26, 2025
**Status:** ✅ Anti-tamper bypassed, ⚠️ Stack overflow needs fixing
**Next Action:** Test simplified bypass version
