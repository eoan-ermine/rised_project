-- "addons\\zrewards\\lua\\zrewards\\rewards\\types\\zrew_reward_shpointshop.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) REWARD TYPE - SH Pointshop
    Developed by Zephruz
]]

--[[REWARD: STANDARD POINTS]]
local REWARD_SHPSSTDPOINTS = zrewards.rewards:Register("SHPointshop.StandardPoints", {})
REWARD_SHPSSTDPOINTS:SetName("SH Pointshop Standard Points")
REWARD_SHPSSTDPOINTS:SetDescription("Standard Point reward type for SH Pointshop.")

function REWARD_SHPSSTDPOINTS:onRewardPlayer(ply, val)
    if (!SH_POINTSHOP or !IsValid(ply) or !val) then return end

    ply:SH_AddStandardPoints(val)

    return true
end

--[[REWARD: PREMIUM POINTS]]
local REWARD_SHPREMPOINTS = zrewards.rewards:Register("SHPointshop.PremiumPoints", {})
REWARD_SHPREMPOINTS:SetName("SH Pointshop Premium Points")
REWARD_SHPREMPOINTS:SetDescription("Premium Point reward type for SH Pointshop.")

function REWARD_SHPREMPOINTS:onRewardPlayer(ply, val)
    if (!SH_POINTSHOP or !IsValid(ply) or !val) then return end

    ply:SH_AddPremiumPoints(val)

    return true
end