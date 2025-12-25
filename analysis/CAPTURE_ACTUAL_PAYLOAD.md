# Capturing the Actual 75-Command Payload

## 🎯 Situation

- You have a valid key: `KEY_GQNUAKWHSXFKDMWGPBMVEGRTHWB`
- The script `ak.lua` is just a LOADER with key authentication
- After entering the key, it downloads/loads the ACTUAL script (75 commands)
- **The animations are visible to ALL players** - meaning server-side replication

## 📊 What We Need to Capture

When you enter the valid key, the loader will:
1. Validate the key (possibly via HTTP to a server)
2. Download the actual payload
3. Execute it via `loadstring()`

We need to intercept step #2 and #3 to get the actual commands!

## 🚀 Method 1: Capture HTTP Payload (RECOMMENDED)

### Step 1: Copy the HTTP monitor to workspace

Copy `capture_http_payload.lua` to your executor's workspace folder.

### Step 2: Run the monitor FIRST

```lua
loadfile("capture_http_payload.lua")()
```

### Step 3: Run ak.lua

```lua
loadfile("ak.lua")()
```

### Step 4: Enter your key

When prompted, enter: `KEY_GQNUAKWHSXFKDMWGPBMVEGRTHWB`

### Step 5: Check the captured files

Look in your workspace for:
- `http_payload_1.lua` - The downloaded script
- `actual_payload_1.lua` - What gets executed
- **One of these will have the 75 commands!**

---

## 🔍 Method 2: Enhanced Monitoring with Command Detection

If Method 1 doesn't capture everything, use this enhanced version:

### Commands to Look For

Since it has 75 commands and animations visible to all, it likely uses:
- Chat commands (`.command` or `/command`)
- Remote events (FireServer)
- Animation replication
- Network ownership manipulation

The enhanced monitor will specifically look for these patterns.

---

## 📝 What the Actual Script Likely Contains

Based on "75 commands" and "visible to all":

### Expected Structure

```lua
-- Command system
local commands = {
    ["command1"] = function()
        -- Does something
    end,
    ["command2"] = function()
        -- Does something else
    end,
    -- ... 73 more
}

-- Chat hook or input handler
game:GetService("Players").LocalPlayer.Chatted:Connect(function(msg)
    local cmd = msg:lower()
    if commands[cmd] then
        commands[cmd]()
    end
end)

-- Animation/replication system
-- (This is what makes it visible to all)
```

### Likely Techniques for Server Visibility

1. **Network Ownership Exploit**
   - Takes ownership of character parts
   - Manipulates them in ways that replicate to server

2. **Animation Replication**
   - Uses Animation tracks that sync to server
   - Server sees and replicates to all clients

3. **Remote Event Exploitation**
   - Fires remoteevents with specific payloads
   - Server processes and replicates

---

## 🔓 Method 3: Direct Payload Extraction (If HTTP Fails)

If the script embeds the payload instead of downloading it:

### Search for Embedded Payload

The payload might be:
1. **Base64 encoded** in the loader
2. **Encrypted** with the key
3. **Split across multiple variables**

Look for:
```lua
-- Patterns like:
local payload = "..." -- Very long string
local decoded = base64_decode(payload)
loadstring(decoded)()
```

---

## ⚡ Quick Start (Do This Now)

### STEP 1: Copy to workspace
Copy these files to your executor workspace:
- `capture_http_payload.lua`
- `ak.lua`

### STEP 2: Execute this in your executor:

```lua
-- Load HTTP monitor first
loadfile("capture_http_payload.lua")()

-- Wait a second
wait(1)

-- Load ak.lua
loadfile("ak.lua")()

-- Enter key when prompted:
-- KEY_GQNUAKWHSXFKDMWGPBMVEGRTHWB
```

### STEP 3: Check workspace for:
- `actual_payload_1.lua` ← **THIS IS THE 75 COMMANDS!**
- `http_payload_1.lua` ← Might also have it

---

## 🎓 Understanding the Commands

Once you have the actual payload, look for:

### Command Registration

```lua
-- Patterns like:
commands["fly"] = function() ... end
commands["speed"] = function() ... end
commands["noclip"] = function() ... end
```

### Replication Methods

```lua
-- How it makes animations visible:
-- Could be:
local anim = humanoid:LoadAnimation(animTrack)
anim:Play()
-- OR
character.HumanoidRootPart.CFrame = ...
-- OR
part:SetNetworkOwner(player)
```

### Server Communication

```lua
-- Look for:
game.ReplicatedStorage.RemoteEvent:FireServer(...)
-- or
HttpService:PostAsync(...)
```

---

## 🔐 Security Note

**Why this is important:**

If the script can make animations/actions visible to **ALL players**, it means:
1. It's exploiting server replication
2. Other players can SEE what you're doing
3. It might be detectable by game anti-cheats
4. Could be flagged as exploiting

**Make sure** you understand what each command does before using it!

---

## 📊 After You Get the Payload

Once you capture `actual_payload_1.lua`:

1. **Copy it back** to `c:\Users\Artifaqt\Downloads\ak\`
2. **Run the pattern analyzer** on it:
   ```bash
   python analyze_reanimation_patterns.py actual_payload_1.lua
   ```
3. **Search for command definitions**:
   ```bash
   grep -i "function\|command" actual_payload_1.lua
   ```
4. **List all commands** to understand what it can do

---

## 🎯 Expected Result

You should get a file with code like:

```lua
-- Example of what you might find:
local Commands = {
    [".fly"] = function()
        -- Flying code
    end,
    [".speed"] = function(args)
        -- Speed modification
    end,
    [".noclip"] = function()
        -- Noclip code
    end,
    -- ... 72 more commands
}
```

**This will show you EXACTLY what the 75 commands are and how they work!**

---

Run the HTTP monitor now and enter your key - you'll get the real script! 🚀
