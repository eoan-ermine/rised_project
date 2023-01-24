-- "addons\\zrewards\\lua\\zrewards\\referrals\\sh_referrals.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) Referrals
    Developed by Zephruz
]]

zrewards.referral = (zrewards.referral or {})

--[[
    Networking
]]

--[[USER REQUESTS]]
local userReqs = {}
userReqs["getReferrals"] = function(ply, val, cb)
    zrewards.referral:GetReferrals(ply,
    function(refs)
        cb(refs)
    end)
end

userReqs["setReferrer"] = function(ply, val, cb)
    local referrerid = val.referrerid
    
    if !(referrerid) then return end

    zrewards.referral:SetReferrer(ply, referrerid,
    function(set, msg)
        cb({set = set, msg = msg})
    end)
end

userReqs["getReferrer"] = function(ply, val, cb)
    zrewards.referral:GetReferrer(ply,
    function(stid, data)
        cb({stid = stid, data = data})
    end)
end

userReqs["getReferralHiscores"] = function(ply, val, cb)
    zrewards.referral:GetHiscores(zrewards.config.hiscoresPlayerLimit,
    function(data)
        cb(data)
    end)
end

zlib.network:RegisterAction("zrewards.referral.userRequest", {
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

adminReqs["getUserTotalReferrals"] = function(ply, val, cb)
    local dType = zlib.data:GetConnection("zrewards.Main")

    if !(dType) then cb(0) return end

    local stid = val.steamid

    if !(stid) then return end

    dType:Query("SELECT COUNT(*) FROM `zrewards_referrals` WHERE `referrer_steamid`=" .. dType:EscapeString(stid),
    function(data)
        data = (data && data[1])
        
        local count = (data && data["COUNT(*)"])

        cb(count or 0)
    end)
end

adminReqs["getTotalReferrals"] = function(ply, val, cb)
    local dType = zlib.data:GetConnection("zrewards.Main")

    if !(dType) then cb(0) return end

    dType:Query("SELECT COUNT(*) FROM `zrewards_referrals`",
    function(data)
        data = (data && data[1])
        
        local count = (data && data["COUNT(*)"])

        cb(count or 0)
    end)
end

adminReqs["getTotalUsers"] = function(ply, val, cb)
    local dType = zlib.data:GetConnection("zrewards.Main")

    if !(dType) then cb(0) return end

    dType:Query("SELECT COUNT(*) FROM `zrewards_users`",
    function(data)
        data = (data && data[1])
        
        local count = (data && data["COUNT(*)"])

        cb(count or 0)
    end)
end

adminReqs["clearUserReferrals"] = function(ply, val, cb)
    local dType = zlib.data:GetConnection("zrewards.Main")

    if !(dType) then cb(0) return end

    local stid = val.steamid

    if !(stid) then return end
    
    dType:Query("DELETE FROM `zrewards_referrals` WHERE `referrer_steamid`=" .. dType:EscapeString(stid),
    function()
        cb(true)
    end)
end

zlib.network:RegisterAction("zrewards.referral.adminRequest", {
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
    Player Meta
]]
local plyMeta = FindMetaTable("Player")

function plyMeta:SetReferralID(id)
    if !(id) then return end
    
    self:SetNW2String("zrew.ReferralID", id)
end

function plyMeta:GetReferralID()
    return self:GetNW2String("zrew.ReferralID", "NIL")
end

function plyMeta:SetReferrerID(id)
    if !(id) then return end

    self:SetNW2String("zrew.ReferrerID", id)
end

function plyMeta:GetReferrerID()
    return self:GetNW2String("zrew.ReferrerID", "NIL")
end

--[[
    Includes
]]
AddCSLuaFile("cl_referrals.lua")
include((SERVER && "sv" || "cl") .. "_referrals.lua")