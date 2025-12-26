-- Luraph Anti-Tamper Bypass - NO DEBUG.INFO HOOKS
-- Hooks pcall, setfenv, traceback but NOT debug.info to avoid recursion entirely

print("[BYPASS] Loading no-debuginfo Luraph anti-tamper bypass...")

local fakelinenumber = 8984
local newcclosure = newcclosure or function(a) return a end

local old_pcall = pcall
local old_type = type
local old_unpack = unpack or table.unpack
local old_setfenv = setfenv

local function replaceLineNumber(str)
    return (str:gsub(":(%d+)([:\r\n])", ":" .. fakelinenumber .. "%2"))
end

-- Hook pcall
local hooked_pcall = newcclosure(function(...)
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
    return old_unpack(results)
end)

pcall = hooked_pcall

-- Hook setfenv with simpler check
local hooked_setfenv = newcclosure(function(...)
    local func = (...)
    -- Don't allow setfenv on our hooked functions
    if func == hooked_pcall or func == hooked_setfenv then
        error("'setfenv' cannot change environment of given object")
    end
    return old_setfenv(...)
end)

setfenv = hooked_setfenv

-- Hook debug.traceback (but NOT debug.info to avoid recursion)
local old_debugtraceback = debug.traceback
local mytraceback = function(...)
    return replaceLineNumber(old_debugtraceback(...))
end

-- Update debug table (only traceback, no info hook)
local old_debug = debug
debug = setmetatable({traceback = mytraceback}, {__index = old_debug})
table.freeze(debug)

print("[OK] No-debuginfo bypass installed")
print("[OK] pcall, setfenv, debug.traceback hooked (debug.info NOT hooked)")
print("[INFO] This should avoid debug.info recursion entirely")

-- Optional: Add loadstring/load hooks
local capture_count = 0
local output_dir = "C:/Users/Artifaqt/Downloads/ak/downloaded_commands/moonsec_deobfuscated/"

local original_loadstring = loadstring
local original_load = load

if loadstring then
    _G.loadstring = function(code, ...)
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

        return original_loadstring(code, ...)
    end
    print("[OK] loadstring hook installed")
end

if load then
    _G.load = function(code, ...)
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

        return original_load(code, ...)
    end
    print("[OK] load hook installed")
end

print("=== No-DebugInfo Bypass Ready ===")
print("[INFO] Now execute the Luraph script")
