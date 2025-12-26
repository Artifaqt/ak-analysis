-- Luraph Dynamic Reversing Test
-- Testing anti-tamper bypass technique

-- STEP 1: Override error function (anti-tamper bypass)
local err = function() error'a' end

-- STEP 2: Hook loadstring to capture deobfuscated code
local original_loadstring = loadstring
local captured_code = {}

_G.loadstring = function(code, ...)
    print("[HOOK] loadstring called!")
    table.insert(captured_code, code)

    -- Write to file
    local file = io.open("C:/Users/Artifaqt/Downloads/ak/tools/captured_luraph.lua", "w")
    if file then
        file:write("-- Captured from Luraph script\n")
        file:write(code)
        file:close()
        print("[SAVED] Code written to captured_luraph.lua")
    end

    return original_loadstring(code, ...)
end

-- STEP 3: Hook load function as well
local original_load = load
_G.load = function(code, ...)
    print("[HOOK] load called!")
    if type(code) == "string" then
        table.insert(captured_code, code)

        local file = io.open("C:/Users/Artifaqt/Downloads/ak/tools/captured_luraph_load.lua", "w")
        if file then
            file:write("-- Captured from load function\n")
            file:write(code)
            file:close()
            print("[SAVED] Code written to captured_luraph_load.lua")
        end
    end

    return original_load(code, ...)
end

-- STEP 4: Load and execute a Luraph script
print("[INFO] Loading Luraph script...")
print("[INFO] Anti-tamper bypass active")
print("[INFO] Hooks installed")
print("")

-- Load the script (you'll need to execute this in a Roblox executor with the script)
-- Example:
-- dofile("C:/Users/Artifaqt/Downloads/ak/downloaded_commands/vm_obfuscated/flip.lua")

print("[INFO] Execute the Luraph script now")
print("[INFO] Any deobfuscated code will be captured")
