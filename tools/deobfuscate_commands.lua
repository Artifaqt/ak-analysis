--[[
    AK Admin Command Deobfuscator

    Runs each VM-obfuscated command script and captures the deobfuscated code

    USAGE:
    1. Place this in your executor workspace
    2. Make sure the downloaded_commands folder is in the same directory
    3. Run: loadfile("deobfuscate_commands.lua")()
    4. Check deobfuscated_commands/ folder for results

    CONFIGURATION:
    - DELAY_BETWEEN_SCRIPTS: Adjust if game crashes (default: 1.0s)
    - Increase delay for slower systems, decrease for faster processing
]]--

-- Console logging setup
local console_log = {}
local original_print = print

-- Hook print to capture all console output
local function log_print(...)
    local args = {...}
    local message = ""
    for i, v in ipairs(args) do
        if i > 1 then message = message .. "\t" end
        message = message .. tostring(v)
    end

    -- Add to log
    table.insert(console_log, message)

    -- Still print to console
    original_print(...)
end

-- Replace global print
_G.print = log_print

print("=" .. string.rep("=", 70))
print("AK ADMIN COMMAND DEOBFUSCATOR")
print("=" .. string.rep("=", 70))
print()

-- Create output folder
local OUTPUT_FOLDER = "deobfuscated_commands"
if not isfolder(OUTPUT_FOLDER) then
    makefolder(OUTPUT_FOLDER)
    print("[+] Created output folder: " .. OUTPUT_FOLDER)
end

-- Configuration
local DELAY_BETWEEN_SCRIPTS = 1.0  -- Delay in seconds (increase if game crashes)
local COMMANDS_PATH = "downloaded_commands/vm_obfuscated"

-- Scripts to skip (add problematic scripts here)
local SKIP_SCRIPTS = {
    -- VM obfuscated with anti-tamper (crash game)
    ["antiafk.lua"] = true,
    ["antivcban.lua"] = true,
    ["call.lua"] = true,
    ["limborbit.lua"] = true,
    ["speed.lua"] = true,
    ["chateditor.lua"] = true,
    ["kidnap.lua"] = true,
    ["spotify.lua"] = true,
    ["stalk.lua"] = true,
    ["flip.lua"] = true,
    ["coloredbaseplate.lua"] = true,
    ["infbaseplate.lua"] = true,
    ["gokutp.lua"] = true,
    ["shaders.lua"] = true,
    ["animcopy.lua"] = true,
    ["ftp.lua"] = true,
    ["trip.lua"] = true,
    ["swordreach.lua"] = true,
    ["reverse.lua"] = true,

    -- Special cases (need manual handling)
    ["animhub.lua"] = true,  -- Just needs beautification
    ["jerk.lua"] = true,     -- Has VM-obfuscated loadstring inside
    ["sfly.lua"] = true,     -- Not VM obfuscated
}

-- Get list of VM-obfuscated scripts
local vm_scripts = {
    "ugcemotes.lua",
    "caranims.lua",
    "antiafk.lua",
    "antivcban.lua",
    "limborbit.lua",
    "speed.lua",
    "chateditor.lua",
    "kidnap.lua",
    "call.lua",
    "spotify.lua",
    "stalk.lua",
    "flip.lua",
    "coloredbaseplate.lua",
    "infbaseplate.lua",
    "gokutp.lua",
    "shaders.lua",
    "animcopy.lua",
    "ftp.lua",
    "reanim.lua",
    "trip.lua",
    "animhub.lua",
    "swordreach.lua",
    "reverse.lua",
    "jerk.lua",
    "sfly.lua"
}

local stats = {
    total = #vm_scripts,
    success = 0,
    failed = 0,
    skipped = 0
}

print(string.format("[*] Found %d VM-obfuscated scripts to deobfuscate\n", stats.total))

-- Count how many will be skipped
local skip_count = 0
for _, script in ipairs(vm_scripts) do
    if SKIP_SCRIPTS[script] then
        skip_count = skip_count + 1
    end
end

if skip_count > 0 then
    print(string.format("[!] Skipping %d problematic script(s)", skip_count))
    print()
end

-- Hook loadstring to capture deobfuscated code
local original_loadstring = loadstring
local captured_code = nil

local function deobfuscate_script(script_name)
    print(string.format("[%d/%d] Processing %s...",
        stats.success + stats.failed + 1, stats.total, script_name))

    -- Reset capture
    captured_code = nil

    -- Read the obfuscated script
    local script_path = COMMANDS_PATH .. "/" .. script_name

    if not isfile(script_path) then
        print(string.format("    [ERROR] File not found: %s", script_path))
        stats.failed = stats.failed + 1
        return false
    end

    local obfuscated_code = readfile(script_path)

    -- Hook loadstring to capture the deobfuscated output
    _G.loadstring = function(code, ...)
        -- Capture the first significant loadstring call
        if not captured_code and #code > 500 then
            captured_code = code
            print(string.format("    [CAPTURED] %d bytes of deobfuscated code", #code))
        end

        -- Don't actually execute, just return a dummy function
        return function() end
    end

    -- Try to execute the obfuscated script
    local success, err = pcall(function()
        local script_func = original_loadstring(obfuscated_code)
        if script_func then
            script_func()
        end
    end)

    -- Restore original loadstring
    _G.loadstring = original_loadstring

    -- Save captured code if we got it
    if captured_code and #captured_code > 500 then
        local output_path = OUTPUT_FOLDER .. "/" .. script_name
        writefile(output_path, captured_code)

        print(string.format("    [SUCCESS] Saved to: %s", output_path))
        print(string.format("    [SIZE] %d bytes -> %d bytes (%.1f%% readable)",
            #obfuscated_code, #captured_code,
            (#captured_code / #obfuscated_code) * 100))

        stats.success = stats.success + 1
        return true
    else
        print(string.format("    [FAILED] Could not capture deobfuscated code"))
        if err then
            print(string.format("    [ERROR] %s", tostring(err)))
        end
        stats.failed = stats.failed + 1
        return false
    end
end

-- Process all scripts
print("Starting deobfuscation...\n")
print(string.format("[*] Processing with %ds delay between scripts to prevent crashes", DELAY_BETWEEN_SCRIPTS))
print(string.format("[*] Estimated time: ~%d seconds\n", (stats.total - skip_count) * DELAY_BETWEEN_SCRIPTS))

local processed = 0
for i, script_name in ipairs(vm_scripts) do
    -- Check if script should be skipped
    if SKIP_SCRIPTS[script_name] then
        print(string.format("[%d/%d] SKIPPING %s (marked as problematic)",
            processed + 1, stats.total, script_name))
        print(string.format("    [SKIP] This script causes crashes"))
        stats.skipped = stats.skipped + 1
    else
        processed = processed + 1
        deobfuscate_script(script_name)

        -- Wait between scripts to prevent crashes
        if i < #vm_scripts then
            print(string.format("    [WAIT] Waiting %ds before next script...", DELAY_BETWEEN_SCRIPTS))
            task.wait(DELAY_BETWEEN_SCRIPTS)
        end
    end

    print() -- Blank line between scripts
end

-- Summary
print("=" .. string.rep("=", 70))
print("DEOBFUSCATION COMPLETE")
print("=" .. string.rep("=", 70))
print()
print(string.format("Total Scripts:  %d", stats.total))
print(string.format("  [OK] Success: %d", stats.success))
print(string.format("  [X]  Failed:  %d", stats.failed))
print(string.format("  [!]  Skipped: %d", stats.skipped))
print()
print(string.format("[*] Deobfuscated scripts saved to: %s/", OUTPUT_FOLDER))
print()

-- Create summary report
local report_content = string.format([[
AK ADMIN COMMAND DEOBFUSCATION REPORT
======================================================================

Date: %s

STATISTICS:
  Total Scripts:  %d
  Success:        %d
  Failed:         %d
  Skipped:        %d
  Success Rate:   %.1f%%

======================================================================

Deobfuscated scripts are saved in: %s/

You can now analyze these scripts to understand what each command does.

Note: Some scripts may have failed deobfuscation if they use advanced
anti-tampering techniques or don't follow standard VM patterns.

Skipped scripts are known to cause crashes and were not processed.

======================================================================
]],
    os.date("%Y-%m-%d %H:%M:%S"),
    stats.total,
    stats.success,
    stats.failed,
    stats.skipped,
    ((stats.success / (stats.total - stats.skipped)) * 100),
    OUTPUT_FOLDER
)

writefile(OUTPUT_FOLDER .. "/DEOBFUSCATION_REPORT.txt", report_content)
print("[*] Report saved: " .. OUTPUT_FOLDER .. "/DEOBFUSCATION_REPORT.txt")

-- Save console log for debugging
local console_log_content = table.concat(console_log, "\n")
writefile(OUTPUT_FOLDER .. "/CONSOLE_LOG.txt", console_log_content)
print("[*] Console log saved: " .. OUTPUT_FOLDER .. "/CONSOLE_LOG.txt")

-- Restore original print
_G.print = original_print

print()
print("=" .. string.rep("=", 70))
print("[DONE] All scripts processed!")
print("=" .. string.rep("=", 70))
print()
print("[DEBUG] Full console log saved to: " .. OUTPUT_FOLDER .. "/CONSOLE_LOG.txt")
