-- "addons\\zrewards\\lua\\zrewards\\rewards\\sh_rewards.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) Rewards
    Developed by Zephruz
]]

zrewards.rewards = (zrewards.rewards or {})
zrewards.rewards.types = (zrewards.rewards.types or {})

--[[
    zrewards.rewards:Register(name [string], data [table (OPTIONAL)])
]]
function zrewards.rewards:Register(name, data)
    local rType = {}

    zlib.object:SetMetatable("zrewards.RewardType", rType)

    rType:SetUniqueName(name)

    if (data) then
        for k,v in pairs(data) do
            rType:setData(k,v)
        end
    end

    -- Configs
    local rewCfg = zrewards.config.rewards
    rewCfg = (rewCfg && rewCfg[name])

    if (rewCfg) then
        for k,v in pairs(rewCfg) do
            rType:setData(k,v)
        end
    end

    self.types[name] = rType

    return self.types[name]
end

--[[
    zrewards.rewards:GetType(name [string])
]]
function zrewards.rewards:GetType(name)
    return self.types[name]
end

--[[
    zrewards.rewards:GetAllTypes()
]]
function zrewards.rewards:GetAllTypes()
    return self.types
end

--[[
    Reward Metastructure
]]
local rewMeta = zlib.object:Create("zrewards.RewardType")

rewMeta:setData("UniqueName", nil, {})
rewMeta:setData("Name", "REWARD.NAME", {})
rewMeta:setData("Description", "REWARD.DESCRIPTION", {})
rewMeta:setData("Icon", "icon16/ruby.png", {})
rewMeta:setData("RewardFor", {}, {
    onGet = function(s,val,rewFor)
        if !(rewFor) then return val end

        return (val[rewFor] || false)
    end,
})

--[[
    Networking
]]

--[[USER REQUESTS]]
local userReqs = {}
userReqs["getRewards"] = function(ply, val, cb)
    zrewards.rewards:GetPlayerRewards(ply:SteamID(),
    function(rews)
        cb(rews)
    end)
end

zlib.network:RegisterAction("zrewards.rewards.userRequest", {
    onReceive = function(ply, val, cb)
        if !(istable(val)) then return end

        local reqName, data = val.reqName, (val.data or {})
        local req = userReqs[reqName]
        
        if (req) then
            req(ply, val, cb)
        end
    end,
})

--[[ADMIN REQUESTS]]
local adminReqs = {}

adminReqs["getUserTotalRewards"] = function(ply, val, cb)
    local dType = zlib.data:GetConnection("zrewards.Main")

    if !(dType) then cb(0) return end

    local stid = val.steamid

    if !(stid) then return end

    dType:Query("SELECT COUNT(*) FROM `zrewards_rewards` WHERE `steamid`=" .. dType:EscapeString(stid),
    function(data)
        data = (data && data[1])

        cb(data && data["COUNT(*)"] || 0)
    end)
end

adminReqs["getTotalRewards"] = function(ply, val, cb)
    local dType = zlib.data:GetConnection("zrewards.Main")

    if !(dType) then cb(0) return end

    dType:Query("SELECT COUNT(*) FROM `zrewards_rewards`",
    function(data)
        data = (data && data[1])

        cb(data && data["COUNT(*)"] || 0)
    end)
end

zlib.network:RegisterAction("zrewards.rewards.adminRequest", {
    adminOnly = zrewards.config.adminGroups,
    onReceive = function(ply, val, cb)
        if !(istable(val)) then return end

        local reqName, data = val.reqName, (val.data or {})
        local req = adminReqs[reqName]
        
        if (req) then
            req(ply, val, cb)
        end
    end,
})

--[[
    Includes
]]
if (SERVER) then include("sv_rewards.lua") end

-- Reward Types
local files, dirs = file.Find("zrewards/rewards/types/zrew_reward_*", "LUA")

for k,v in pairs(files) do
    zlib.util:IncludeByPath(v, "types/")
end
