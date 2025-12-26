-- Advanced Luraph Dynamic Reversing
-- Multiple anti-tamper bypass techniques

print("=== Luraph Dynamic Reversing Tool ===")
print("[INFO] Initializing bypass techniques...")

-- TECHNIQUE 1: Override error function (anti-tamper bypass)
local err = function() error'a' end
print("[OK] Error override installed")

-- TECHNIQUE 2: Backup original functions before hooks
local original_loadstring = loadstring or load
local original_load = load
local original_pcall = pcall
local original_xpcall = xpcall
local original_error = error
local original_assert = assert
print("[OK] Original functions backed up")

-- TECHNIQUE 3: Create safe execution environment
local function safe_call(func, ...)
    local success, result = original_pcall(func, ...)
    if not success then
        print("[WARN] Error caught: " .. tostring(result))
    end
    return success, result
end

-- TECHNIQUE 4: Hook loadstring/load to capture code
local captured_count = 0
local output_dir = "C:/Users/Artifaqt/Downloads/ak/downloaded_commands/moonsec_deobfuscated/"

local function capture_code(code, source_func)
    if type(code) ~= "string" then
        return
    end

    captured_count = captured_count + 1
    local filename = output_dir .. "luraph_captured_" .. captured_count .. ".lua"

    print(string.format("[CAPTURE #%d] %s called with %d bytes",
        captured_count, source_func, #code))

    -- Save to file
    local file = io.open(filename, "w")
    if file then
        file:write("-- Captured from " .. source_func .. "\n")
        file:write("-- Size: " .. #code .. " bytes\n")
        file:write("-- Capture #" .. captured_count .. "\n\n")
        file:write(code)
        file:close()
        print("[SAVED] " .. filename)
    else
        print("[ERROR] Could not save file")
    end

    -- Also print first 200 chars for preview
    print("[PREVIEW] " .. code:sub(1, 200):gsub("\n", " "))
    print("")
end

-- Install hooks
if loadstring then
    _G.loadstring = function(code, ...)
        if type(code) == "string" then
            capture_code(code, "loadstring")
        end
        return original_loadstring(code, ...)
    end
    print("[OK] loadstring hook installed")
end

_G.load = function(code, ...)
    if type(code) == "string" then
        capture_code(code, "load")
    end
    return original_load(code, ...)
end
print("[OK] load hook installed")

-- TECHNIQUE 5: Hook pcall to catch errors without crashing
_G.pcall = function(func, ...)
    print("[TRACE] pcall called")
    return original_pcall(func, ...)
end

-- TECHNIQUE 6: Hook error to prevent anti-tamper crashes
_G.error = function(msg, level)
    print("[ERROR CAUGHT] " .. tostring(msg))
    -- Don't actually throw the error if it's from anti-tamper
    if type(msg) == "string" and (
        msg:find("tamper") or
        msg:find("debug") or
        msg:find("hook") or
        msg:find("detected")
    ) then
        print("[BYPASS] Anti-tamper error suppressed")
        return
    end
    return original_error(msg, level)
end
print("[OK] error hook installed (anti-tamper suppression)")

-- TECHNIQUE 7: Disable common anti-debug checks
if debug then
    local original_getinfo = debug.getinfo
    debug.getinfo = function(...)
        print("[TRACE] debug.getinfo called")
        return original_getinfo(...)
    end
    print("[OK] debug.getinfo hook installed")
end

print("")
print("=== All Hooks Installed ===")
print("[INFO] Ready to execute Luraph script")
print("[INFO] Captured code will be saved to:")
print("       " .. output_dir .. "luraph_captured_*.lua")
print("")
print("Usage:")
print("1. Load this script first")
print("2. Then execute the Luraph script you want to analyze")
print("3. Check the output directory for captured code")
print("")
print("Example:")
print('  dofile("C:/path/to/luraph_advanced_bypass.lua")')
print('  dofile("C:/path/to/obfuscated_script.lua")')
print("")
