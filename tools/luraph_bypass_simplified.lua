-- Luraph Anti-Tamper Bypass - SIMPLIFIED VERSION
-- Based on TechHog8984's minimal approach
-- Only hooks pcall, avoids debug.info recursion issues
-- URL: https://gist.github.com/TechHog8984/2e41a77e1d62b5b9d91a5e84274cdf45

print("[BYPASS] Loading simplified Luraph anti-tamper bypass...")

local old_pcall = pcall
local old_unpack = unpack or table.unpack
local newcclosure = newcclosure or function(f) return f end

-- Hook pcall to replace line numbers in error messages
pcall = newcclosure(function(...)
    local results = {old_pcall(...)}
    local first = results[1]

    -- If pcall failed (first result is false)
    if type(first) == "boolean" and first == false then
        local second = results[2]

        -- If error message is a string
        if type(second) == "string" then
            -- Replace all line numbers with 8984
            -- Pattern: :123: or :123\n becomes :8984: or :8984\n
            results[2] = second:gsub(":(%d+)([:\r\n])", ":8984%2")

            -- Also handle special setfenv error
            if second:find("'setfenv' cannot change environment of given object") then
                results[2] = "'setfenv' cannot change environment of given object"
            end
        end
    end

    return old_unpack(results)
end)

print("[OK] Simplified bypass installed (pcall hook only)")
print("[INFO] No debug.info hooks - should avoid stack overflow")

-- Optional: Add loadstring/load hooks to capture deobfuscated code
local capture_count = 0
local output_dir = "C:/Users/Artifaqt/Downloads/ak/downloaded_commands/moonsec_deobfuscated/"

local original_loadstring = loadstring
local original_load = load

if loadstring then
    _G.loadstring = function(code, ...)
        capture_count = capture_count + 1
        print(string.format("[CAPTURE #%d] loadstring called with %d bytes", capture_count, #code))

        -- Save to file
        local filename = output_dir .. string.format("luraph_captured_%d.lua", capture_count)
        local file = io.open(filename, "w")
        if file then
            file:write("-- Captured from Luraph script via loadstring\n")
            file:write("-- Capture #" .. capture_count .. "\n\n")
            file:write(code)
            file:close()
            print("[SAVED] " .. filename)

            -- Preview
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

            -- Save to file
            local filename = output_dir .. string.format("luraph_captured_%d.lua", capture_count)
            local file = io.open(filename, "w")
            if file then
                file:write("-- Captured from Luraph script via load\n")
                file:write("-- Capture #" .. capture_count .. "\n\n")
                file:write(code)
                file:close()
                print("[SAVED] " .. filename)

                -- Preview
                local preview = code:sub(1, 200)
                if #code > 200 then preview = preview .. "..." end
                print("[PREVIEW] " .. preview)
            end
        end

        return original_load(code, ...)
    end
    print("[OK] load hook installed")
end

print("=== Simplified Bypass Ready ===")
print("[INFO] Now execute the Luraph script")
