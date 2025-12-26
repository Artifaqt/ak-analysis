-- Luraph Bypass - CAPTURE ONLY (No Anti-Tamper)
-- Only hooks loadstring/load to capture code
-- NO pcall, setfenv, or debug hooks
-- Tests if recursion is from capture hooks or anti-tamper hooks

print("[BYPASS] Loading capture-only bypass (no anti-tamper protection)...")

local capture_count = 0
local output_dir = "C:/Users/Artifaqt/Downloads/ak/downloaded_commands/moonsec_deobfuscated/"

local original_loadstring = loadstring
local original_load = load

-- Simple loadstring hook with recursion guard
local loadstring_recursion = false
if loadstring then
    _G.loadstring = function(code, ...)
        -- Recursion guard
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
    print("[OK] loadstring hook installed")
end

-- Simple load hook with recursion guard
local load_recursion = false
if load then
    _G.load = function(code, ...)
        -- Recursion guard
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
    print("[OK] load hook installed")
end

print("=== Capture-Only Bypass Ready ===")
print("[WARNING] No anti-tamper protection - script may crash if protected")
print("[INFO] This is a test to isolate recursion issues")
print("[INFO] Now execute the Luraph script")
