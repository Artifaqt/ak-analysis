-- Luraph Bypass - FULLY GUARDED
-- All hooks have recursion guards
-- This tests if recursion is from hooks calling themselves

print("[BYPASS] Loading fully-guarded Luraph anti-tamper bypass...")

local fakelinenumber = 8984
local newcclosure = newcclosure or function(a) return a end

local old_pcall = pcall
local old_type = type
local old_unpack = unpack or table.unpack
local old_setfenv = setfenv

-- Global recursion tracking
local pcall_recursion = false
local setfenv_recursion = false
local traceback_recursion = false

local function replaceLineNumber(str)
    return (str:gsub(":(%d+)([:\r\n])", ":" .. fakelinenumber .. "%2"))
end

-- Hook pcall with recursion guard
local hooked_pcall = newcclosure(function(...)
    -- Recursion guard - if already in pcall hook, just pass through
    if pcall_recursion then
        return old_pcall(...)
    end

    pcall_recursion = true

    local results = {old_pcall(...)}
    local first = results[1]
    if old_type(first) == "boolean" and first == false then
        local second = results[2]
        if old_type(second) == "string" then
            if second:find("'setfenv' cannot change environment of given object") then
                results[2] = "'setfenv' cannot change environment of given object"
            else
                results[2] = (replaceLineNumber(second))
            end
        end
    end

    pcall_recursion = false
    return old_unpack(results)
end)

pcall = hooked_pcall

-- Hook setfenv with recursion guard
local hooked_setfenv = newcclosure(function(...)
    -- Recursion guard
    if setfenv_recursion then
        return old_setfenv(...)
    end

    setfenv_recursion = true

    local func = (...)
    if func == hooked_pcall or func == hooked_setfenv then
        setfenv_recursion = false
        error("'setfenv' cannot change environment of given object")
    end

    local result = old_setfenv(...)
    setfenv_recursion = false
    return result
end)

setfenv = hooked_setfenv

-- Hook debug.traceback with recursion guard
local old_debugtraceback = debug.traceback
local mytraceback = function(...)
    -- Recursion guard
    if traceback_recursion then
        return old_debugtraceback(...)
    end

    traceback_recursion = true
    local result = replaceLineNumber(old_debugtraceback(...))
    traceback_recursion = false
    return result
end

-- Update debug table
local old_debug = debug
debug = setmetatable({traceback = mytraceback}, {__index = old_debug})
table.freeze(debug)

print("[OK] Fully-guarded bypass installed")
print("[OK] pcall, setfenv, debug.traceback hooked (all with recursion guards)")
print("[INFO] NO debug.info hook (avoids that recursion)")

-- Capture hooks with recursion guards
local capture_count = 0
local output_dir = "C:/Users/Artifaqt/Downloads/ak/downloaded_commands/moonsec_deobfuscated/"

local original_loadstring = loadstring
local original_load = load
local loadstring_recursion = false
local load_recursion = false

if loadstring then
    _G.loadstring = function(code, ...)
        if loadstring_recursion then
            return original_loadstring(code, ...)
        end

        loadstring_recursion = true

        if type(code) == "string" then
            capture_count = capture_count + 1
            print(string.format("[CAPTURE #%d] loadstring called with %d bytes", capture_count, #code))

            local filename = output_dir .. string.format("luraph_captured_%d.lua", capture_count)
            local file = io.open(filename, "w")
            if file then
                file:write("-- Captured from Luraph script via loadstring\n")
                file:write("-- Capture #" .. capture_count .. "\n\n")
                file:write(code)
                file:close()
                print("[SAVED] " .. filename)

                local preview = code:sub(1, 200)
                if #code > 200 then preview = preview .. "..." end
                print("[PREVIEW] " .. preview)
            end
        end

        local result = original_loadstring(code, ...)
        loadstring_recursion = false
        return result
    end
    print("[OK] loadstring hook installed (with recursion guard)")
end

if load then
    _G.load = function(code, ...)
        if load_recursion then
            return original_load(code, ...)
        end

        load_recursion = true

        if type(code) == "string" then
            capture_count = capture_count + 1
            print(string.format("[CAPTURE #%d] load called with %d bytes", capture_count, #code))

            local filename = output_dir .. string.format("luraph_captured_%d.lua", capture_count)
            local file = io.open(filename, "w")
            if file then
                file:write("-- Captured from Luraph script via load\n")
                file:write("-- Capture #" .. capture_count .. "\n\n")
                file:write(code)
                file:close()
                print("[SAVED] " .. filename)

                local preview = code:sub(1, 200)
                if #code > 200 then preview = preview .. "..." end
                print("[PREVIEW] " .. preview)
            end
        end

        local result = original_load(code, ...)
        load_recursion = false
        return result
    end
    print("[OK] load hook installed (with recursion guard)")
end

print("=== Fully-Guarded Bypass Ready ===")
print("[INFO] All hooks have recursion guards")
print("[INFO] Now execute the Luraph script")
