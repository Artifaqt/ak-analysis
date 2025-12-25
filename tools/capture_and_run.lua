--[[
    ALL-IN-ONE PAYLOAD CAPTURE SCRIPT

    This script will:
    1. Set up HTTP monitoring hooks
    2. Set up loadstring hooks
    3. Load ak.lua automatically
    4. Capture everything to files

    Just run this script, then enter your key when prompted!
]]--

print(string.rep("=", 80))
print("PAYLOAD CAPTURE SYSTEM - ALL-IN-ONE")
print(string.rep("=", 80))
print()

local captured_requests = {}
local captured_loadstrings = {}
local hasFileSystem = writefile ~= nil

if not hasFileSystem then
    error("This executor doesn't support writefile! Cannot capture payloads.")
end

print("[*] Setting up capture hooks...")

-- ============================================================================
-- HOOK 1: HTTP REQUESTS (GetAsync, PostAsync, RequestAsync)
-- ============================================================================

local http_hooked = false
pcall(function()
    local HttpService = game:GetService("HttpService")

    -- Hook GetAsync
    if HttpService.GetAsync then
        local original_GetAsync = HttpService.GetAsync
        HttpService.GetAsync = function(self, url, ...)
            print()
            print(string.rep("-", 80))
            print("[HTTP GET DETECTED]")
            print("URL:", url)
            print(string.rep("-", 80))

            local response = original_GetAsync(self, url, ...)

            print("Response Size:", #response, "bytes")
            print("Preview:", response:sub(1, 150))

            table.insert(captured_requests, {
                type = "GET",
                url = url,
                response = response,
                timestamp = tick()
            })

            -- Save immediately
            local filename = "http_payload_" .. #captured_requests .. ".lua"
            writefile(filename, response)
            print()
            print("[SAVED] HTTP Response saved to:", filename)
            print(string.rep("-", 80))

            return response
        end
        http_hooked = true
        print("[✓] HTTP GetAsync hooked")
    end

    -- Hook PostAsync
    if HttpService.PostAsync then
        local original_PostAsync = HttpService.PostAsync
        HttpService.PostAsync = function(self, url, data, ...)
            print()
            print(string.rep("-", 80))
            print("[HTTP POST DETECTED]")
            print("URL:", url)
            print("Data:", tostring(data):sub(1, 100))
            print(string.rep("-", 80))

            local response = original_PostAsync(self, url, data, ...)

            print("Response Size:", #response, "bytes")
            print("Preview:", response:sub(1, 150))

            table.insert(captured_requests, {
                type = "POST",
                url = url,
                data = data,
                response = response,
                timestamp = tick()
            })

            -- Save immediately
            local filename = "http_payload_" .. #captured_requests .. ".lua"
            writefile(filename, response)
            print()
            print("[SAVED] HTTP Response saved to:", filename)
            print(string.rep("-", 80))

            return response
        end
        http_hooked = true
        print("[✓] HTTP PostAsync hooked")
    end

    -- Hook RequestAsync (modern method)
    if HttpService.RequestAsync then
        local original_RequestAsync = HttpService.RequestAsync
        HttpService.RequestAsync = function(self, options, ...)
            print()
            print(string.rep("-", 80))
            print("[HTTP REQUEST DETECTED]")
            print("URL:", options.Url or "unknown")
            print("Method:", options.Method or "GET")
            print(string.rep("-", 80))

            local response = original_RequestAsync(self, options, ...)

            print("Status Code:", response.StatusCode)
            print("Response Size:", #response.Body, "bytes")
            print("Preview:", response.Body:sub(1, 150))

            table.insert(captured_requests, {
                type = "RequestAsync",
                url = options.Url,
                method = options.Method,
                response = response.Body,
                status = response.StatusCode,
                timestamp = tick()
            })

            -- Save immediately
            local filename = "http_payload_" .. #captured_requests .. ".lua"
            writefile(filename, response.Body)
            print()
            print("[SAVED] HTTP Response saved to:", filename)
            print(string.rep("-", 80))

            return response
        end
        http_hooked = true
        print("[✓] HTTP RequestAsync hooked")
    end
end)

if http_hooked then
    print("[✓] HTTP monitoring active")
else
    print("[!] WARNING: Could not hook HTTP functions")
end

-- ============================================================================
-- HOOK 2: LOADSTRING (THIS IS THE MOST IMPORTANT!)
-- ============================================================================

local loadstring_hooked = false
pcall(function()
    local original_loadstring = loadstring
    _G.loadstring = function(code, ...)
        print()
        print(string.rep("=", 80))
        print("!!! LOADSTRING CALLED - PAYLOAD DETECTED !!!")
        print(string.rep("=", 80))
        print("Code Size:", #code, "bytes")
        print("Code Preview:")
        print(code:sub(1, 500))
        print(string.rep("=", 80))

        table.insert(captured_loadstrings, code)

        -- Save the actual executed code
        local filename = "actual_payload_" .. #captured_loadstrings .. ".lua"
        writefile(filename, code)

        print()
        print("[✓✓✓ SUCCESS ✓✓✓]")
        print("ACTUAL PAYLOAD SAVED TO:", filename)
        print("[✓✓✓ THIS IS THE REAL SCRIPT ✓✓✓]")
        print(string.rep("=", 80))
        print()

        return original_loadstring(code, ...)
    end

    -- Also hook the global loadstring
    loadstring = _G.loadstring
    loadstring_hooked = true
    print("[✓] loadstring hook active")
end)

if not loadstring_hooked then
    print("[!] WARNING: Could not hook loadstring")
end

print()
print(string.rep("=", 80))
print("ALL HOOKS ACTIVE - READY TO CAPTURE")
print(string.rep("=", 80))
print()

-- ============================================================================
-- AUTOMATICALLY LOAD AK.LUA
-- ============================================================================

print("[*] Looking for ak.lua in workspace...")

local ak_files = {"ak.lua", "ak_deobfuscated.lua"}
local ak_content = nil
local ak_filename = nil

for _, filename in ipairs(ak_files) do
    if isfile and isfile(filename) then
        print("[✓] Found:", filename)
        ak_filename = filename
        ak_content = readfile(filename)
        break
    end
end

if not ak_content then
    print()
    print("[!] ERROR: Could not find ak.lua or ak_deobfuscated.lua in workspace!")
    print()
    print("Please make sure one of these files is in your executor's workspace folder:")
    print("  - ak.lua (the original loader)")
    print("  - ak_deobfuscated.lua")
    print()
    print("Then run this script again.")
    print()
    return
end

print("[*] Loading", ak_filename, "...")
print()

-- Small delay to ensure hooks are fully set up
wait(0.5)

-- Execute ak.lua
local success, err = pcall(function()
    local ak_func = loadstring(ak_content)
    if ak_func then
        ak_func()
    else
        error("Failed to compile " .. ak_filename)
    end
end)

if not success then
    print()
    print("[!] ERROR loading", ak_filename .. ":")
    print(err)
    print()
else
    print()
    print(string.rep("=", 80))
    print("ak.lua LOADED SUCCESSFULLY")
    print(string.rep("=", 80))
    print()
    print("Now enter your key when prompted:")
    print()
    print("  KEY_GQNUAKWHSXFKDMWGPBMVEGRTHWB")
    print()
    print("All HTTP requests and payload executions will be captured!")
    print()
    print("Look for these files in your workspace:")
    print("  - actual_payload_1.lua  ← THE REAL SCRIPT WITH 75 COMMANDS")
    print("  - http_payload_1.lua    ← HTTP response (might also have it)")
    print()
    print(string.rep("=", 80))
end