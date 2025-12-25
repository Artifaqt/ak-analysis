--[[
    HTTP REQUEST MONITOR

    This captures HTTP requests made by the script to download the actual payload.
    Run this BEFORE running ak.lua, then enter your key.
]]--

print("="..string.rep("=", 78))
print("HTTP REQUEST MONITOR")
print("="..string.rep("=", 78))

local captured_requests = {}
local captured_responses = {}
local hasFileSystem = writefile ~= nil

-- Hook HttpService if it exists
pcall(function()
    local HttpService = game:GetService("HttpService")

    -- Hook GetAsync
    if HttpService.GetAsync then
        local original_GetAsync = HttpService.GetAsync
        HttpService.GetAsync = function(self, url, ...)
            print("\n[HTTP GET] URL:", url)

            local response = original_GetAsync(self, url, ...)

            print("[HTTP GET] Response length:", #response, "characters")
            print("[HTTP GET] Response preview:", response:sub(1, 200))

            table.insert(captured_requests, {
                type = "GET",
                url = url,
                response = response,
                timestamp = tick()
            })

            -- Save immediately
            if hasFileSystem then
                local filename = "http_payload_" .. #captured_requests .. ".lua"
                writefile(filename, response)
                print("[SAVED] Payload saved to:", filename)
            end

            return response
        end
        print("[✓] GetAsync hooked")
    end

    -- Hook PostAsync
    if HttpService.PostAsync then
        local original_PostAsync = HttpService.PostAsync
        HttpService.PostAsync = function(self, url, data, ...)
            print("\n[HTTP POST] URL:", url)
            print("[HTTP POST] Data:", data)

            local response = original_PostAsync(self, url, data, ...)

            print("[HTTP POST] Response:", response:sub(1, 200))

            table.insert(captured_requests, {
                type = "POST",
                url = url,
                data = data,
                response = response,
                timestamp = tick()
            })

            -- Save immediately
            if hasFileSystem then
                local filename = "http_payload_" .. #captured_requests .. ".lua"
                writefile(filename, response)
                print("[SAVED] Response saved to:", filename)
            end

            return response
        end
        print("[✓] PostAsync hooked")
    end

    -- Hook RequestAsync (more modern method)
    if HttpService.RequestAsync then
        local original_RequestAsync = HttpService.RequestAsync
        HttpService.RequestAsync = function(self, options, ...)
            print("\n[HTTP REQUEST]")
            print("  URL:", options.Url)
            print("  Method:", options.Method)
            if options.Body then
                print("  Body:", options.Body:sub(1, 100))
            end

            local response = original_RequestAsync(self, options, ...)

            print("[HTTP RESPONSE]")
            print("  Status:", response.StatusCode)
            print("  Body length:", #response.Body, "characters")
            print("  Body preview:", response.Body:sub(1, 200))

            table.insert(captured_requests, {
                type = "RequestAsync",
                url = options.Url,
                method = options.Method,
                request_body = options.Body,
                response = response.Body,
                status = response.StatusCode,
                timestamp = tick()
            })

            -- Save immediately
            if hasFileSystem then
                local filename = "http_payload_" .. #captured_requests .. ".lua"
                writefile(filename, response.Body)
                print("[SAVED] Payload saved to:", filename)
            end

            return response
        end
        print("[✓] RequestAsync hooked")
    end
end)

-- Hook loadstring to capture what gets executed after key validation
pcall(function()
    local original_loadstring = loadstring
    loadstring = function(code, ...)
        print("\n" .. string.rep("=", 78))
        print("LOADSTRING CALLED - CAPTURING PAYLOAD!")
        print(string.rep("=", 78))
        print("Code length:", #code, "characters")
        print("Code preview:", code:sub(1, 500))

        table.insert(captured_responses, code)

        -- Save the actual payload
        if hasFileSystem then
            local filename = "actual_payload_" .. #captured_responses .. ".lua"
            writefile(filename, code)
            print("\n[✓✓✓] ACTUAL PAYLOAD SAVED TO:", filename, "✓✓✓\n")
        end

        return original_loadstring(code, ...)
    end
    print("[✓] loadstring hooked")
end)

print("\n" .. string.rep("=", 78))
print("HOOKS ACTIVE")
print("="..string.rep("=", 78))
print("\nNow run ak.lua and enter your key...")
print("All HTTP requests and payloads will be captured!")
print("\n")
