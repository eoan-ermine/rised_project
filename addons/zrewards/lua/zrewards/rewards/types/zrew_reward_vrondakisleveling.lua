-- "addons\\zrewards\\lua\\zrewards\\rewards\\types\\zrew_reward_vrondakisleveling.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) REWARD TYPE - Vrondakis Level-System
    Developed by Zephruz
]]

--[[REWARD: LEVEL]]
local REWARD_VLEVEL = zrewards.rewards:Register("vrondakis.Level", {})
REWARD_VLEVEL:SetName("Level")
REWARD_VLEVEL:SetDescription("Level reward type for Vrondakis Level-System.")

function REWARD_VLEVEL:onRewardPlayer(ply, val)
    if (!IsValid(ply) or !ply:getDarkRPVar("level") or !val) then return end
    
    ply:addLevels(val)

    return true
end

--[[REWARD: XP]]
local REWARD_VXP = zrewards.rewards:Register("vrondakis.XP", {})
REWARD_VXP:SetName("XP")
REWARD_VXP:SetDescription("XP reward type for Vrondakis Level-System.")

function REWARD_VXP:onRewardPlayer(ply, val)
    if (!IsValid(ply) or !ply:getDarkRPVar("xp") or !val) then return end
    
    ply:addXP(val)

    return true
end