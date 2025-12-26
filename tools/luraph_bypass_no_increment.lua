-- Luraph Anti-Tamper Bypass - NO STACK INCREMENT VERSION
-- Based on TechHog8984's full bypass but removes func+1 to avoid recursion
-- This should prevent stack overflow while maintaining full protection

print("[BYPASS] Loading no-increment Luraph anti-tamper bypass...")

local env = getfenv()
local hook_map = setmetatable({}, {__newindex = function(self, og, value)
    local name = value[1]
    local hook = value[2]
    rawset(self, hook, value)
    env[name] = hook
end})

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
hook_map[pcall] = {"pcall", newcclosure(function(...)
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
end)}

-- Hook setfenv
hook_map[setfenv] = {"setfenv", newcclosure(function(...)
    local func = (...)
    if hook_map[func] then
        error("'setfenv' cannot change environment of given object")
    end
    return old_setfenv(...)
end)}

-- Hook debug.info - NO STACK INCREMENT
local old_debuginfo = debug.info
local myinfo = function(...)
    local results
    local func, options = ...
    if type(func) == "number" then
        -- CHANGED: Don't add 1, just pass through
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
local old_env_value = env.info
hook_map[old_debuginfo] = {"info", myinfo}
env.info = old_env_value

-- Hook debug.traceback
local old_debugtraceback = debug.traceback
local mytraceback = function(...)
    return replaceLineNumber(old_debugtraceback(...))
end
local old_env_value = env.traceback
hook_map[old_debugtraceback] = {"traceback", mytraceback}
env.traceback = old_env_value

-- Update debug table
local old_debug = debug
debug = setmetatable({info = myinfo, traceback = mytraceback}, {__index = old_debug})
table.freeze(debug)

print("[OK] No-increment bypass installed")
print("[OK] pcall, setfenv, debug.info, debug.traceback all hooked")
print("[INFO] Stack increment removed - should prevent overflow")

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

print("=== No-Increment Bypass Ready ===")
print("[INFO] Now execute the Luraph script")
