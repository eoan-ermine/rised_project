-- "addons\\zrewards\\lua\\zrewards\\rewards\\types\\zrew_reward_basewars.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) REWARD TYPE - BaseWars
    Developed by Zephruz
]]

--[[REWARD: MONEY]]
local REWARD_BWMONEY = zrewards.rewards:Register("BaseWars.Money", {})
REWARD_BWMONEY:SetName("BaseWars Money")
REWARD_BWMONEY:SetDescription("Money reward type for BaseWars.")

function REWARD_BWMONEY:onRewardPlayer(ply, val)
    if (!BaseWars or !IsValid(ply) or !val) then return end
    
    ply:GiveMoney(val)

    return true
end

--[[REWARD: LEVEL]]
local REWARD_BWLEVEL = zrewards.rewards:Register("BaseWars.Level", {})
REWARD_BWLEVEL:SetName("BaseWars Level")
REWARD_BWLEVEL:SetDescription("Level reward type for BaseWars.")

function REWARD_BWLEVEL:onRewardPlayer(ply, val)
    if (!BaseWars or !IsValid(ply) or !val) then return end
    
    ply:AddLevel(val)

    return true
end