-- "addons\\zrewards\\lua\\zrewards\\rewards\\types\\zrew_reward_ps1.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) REWARD TYPE - PS1
    Developed by Zephruz
]]

--[[REWARD: POINTS]]
local REWARD_PS1POINTS = zrewards.rewards:Register("PS1.Points", {})
REWARD_PS1POINTS:SetName("PS1 Points")
REWARD_PS1POINTS:SetDescription("Point reward type for PointShop 1.")

function REWARD_PS1POINTS:onRewardPlayer(ply, val)
    if (!PS or !IsValid(ply) or !val) then return end

    ply:PS_GivePoints(val)

    return true
end