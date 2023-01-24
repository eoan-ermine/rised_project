-- "addons\\zrewards\\lua\\zrewards\\rewards\\types\\zrew_reward_ilevel.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) REWARD TYPE - iLevel Rewards
    Developed by Zephruz
]]

--[[REWARD: XP]]
local REWARD_ILVLXP = zrewards.rewards:Register("iLevel.XP", {})
REWARD_ILVLXP:SetName("iLevel XP")
REWARD_ILVLXP:SetDescription("XP reward for iLevel.")

function REWARD_ILVLXP:onRewardPlayer(ply, val)
    if (!xpSystem or !IsValid(ply) or !val) then return end

    ply:AddXP("Reward", val)

    return true
end

--[[REWARD: Perk Points]]
local REWARD_ILVLPP = zrewards.rewards:Register("iLevel.PerkPoints", {})
REWARD_ILVLPP:SetName("iLevel Perk Points")
REWARD_ILVLPP:SetDescription("Perk Point reward for iLevel.")

function REWARD_ILVLPP:onRewardPlayer(ply, val)
    if (!xpSystem or !IsValid(ply) or !val) then return end

    ply:AddPP(amount)

    return true
end