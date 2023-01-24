-- "addons\\zrewards\\lua\\zrewards\\sh_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) Init
    Developed by Zephruz
]]

-- Config(s)
AddCSLuaFile("sh_config.lua")
include("sh_config.lua")

if (SERVER) then 
    include("sv_config.lua") 
end

-- Language
AddCSLuaFile("sh_language.lua")
include("sh_language.lua")

-- Init(s)
AddCSLuaFile("cl_init.lua")
if (CLIENT) then include("cl_init.lua") end

-- Rewards
AddCSLuaFile("rewards/sh_rewards.lua")
include("rewards/sh_rewards.lua")

-- Referrals
AddCSLuaFile("referrals/sh_referrals.lua")
include("referrals/sh_referrals.lua")

-- Methods
AddCSLuaFile("methods/sh_methods.lua")
include("methods/sh_methods.lua")

-- VGUI
AddCSLuaFile("vgui/sh_vgui.lua")
include("vgui/sh_vgui.lua")

--[[
    ZRewards Load
]]
function zrewards:Load()
    if (SERVER) then
        local cfg = zrewards.config
        local mysqlInfo = (cfg && cfg.mysqlInfo)

        local dtype = zlib.data:CreateConnection("zrewards.Main", mysqlInfo.dbModule, { mysqlInfo = mysqlInfo })
        dtype:Connect(function()
            hook.Run("zrewards.data.Initialized", zrewards, dtype)
        end,
        function(err) 
            zrewards:ConsoleMessage("Failed to connect to DB: ", err)
        end)
    end

    self.vgui:Load()
end

zrewards:Load()

--[[
    Commands
]]

--[[
    setreferrer
]]
concommand.Add("setreferrer",
function(ply, cmd, args)
    local refID = args[1]

    if (SERVER || !IsValid(ply) || !refID) then return end

    -- Set referrer
    zlib.network:CallAction("zrewards.referral.userRequest", {reqName = "setReferrer", referrerid = refID}, 
    function(val)
        local set, msg = val.set, val.msg

        if (set) then
            zlib.notifs:Create(zrewards.lang:GetTranslation(msg || "yourReferrerSet"))
        else
            zlib.notifs:Create(zrewards.lang:GetTranslation(msg || "unknown error"))
        end
    end)
end, nil, "Command should be used as setreferrer 'referral_id_here'")

--[[
    zrew_reload

    - Completely reloads the addon (core, modules, libraries, etc)
        * If you're an admin, this reloads both locally (yourself) and the server
    - Useful for quickly fixing odd bugs/errors
]]
concommand.Add("zrew_reload", 
function(ply, cmd, args)
    if (SERVER && IsValid(ply) && !table.HasValue(zrewards.config.adminGroups, ply:GetUserGroup())) then return end

    zrewards:Init()
end)