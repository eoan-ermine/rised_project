-- "addons\\zrewards\\lua\\zrewards\\rewards\\types\\zrew_reward_general.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) REWARD TYPE - GENERAL
    Developed by Zephruz
]]

--[[REWARD: WEAPON]]
local REWARD_WEAPON = zrewards.rewards:Register("General.Weapon", {})
REWARD_WEAPON:SetName("Weapon Reward")
REWARD_WEAPON:SetDescription("Weapon reward.")

function REWARD_WEAPON:onRewardPlayer(ply, val)
    if (!IsValid(ply) or !val) then return end

    ply:Give(val)
    
    return true
end