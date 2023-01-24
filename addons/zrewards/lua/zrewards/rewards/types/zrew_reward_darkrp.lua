-- "addons\\zrewards\\lua\\zrewards\\rewards\\types\\zrew_reward_darkrp.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) REWARD TYPE - DarkRP
    Developed by Zephruz
]]

--[[REWARD: CASH]]
local REWARD_DARKRPCASH = zrewards.rewards:Register("DarkRP.Cash", {})
REWARD_DARKRPCASH:SetName("Cash")
REWARD_DARKRPCASH:SetDescription("Cash reward type for DarkRP.")

function REWARD_DARKRPCASH:onRewardPlayer(ply, val)
    if (!DarkRP or !IsValid(ply) or !val) then return end

    -- Had to do this because it would error out if a player wasn't fully loaded
    local plyMoney = ply:getDarkRPVar("money")

    if !(plyMoney) then return end

    ply:addMoney(val)

    return true
end