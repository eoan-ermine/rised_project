-- "addons\\zrewards\\lua\\zrewards\\rewards\\types\\zrew_reward_williamscardealer.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) REWARD TYPE - Williams Car Dealer
    Developed by Zephruz
]]

--[[REWARD: CAR]]
local REWARD_WCDCAR = zrewards.rewards:Register("willsDealer.Car", {})
REWARD_WCDCAR:SetName("Car")
REWARD_WCDCAR:SetDescription("Car reward type for Williams Car Dealer.")

function REWARD_WCDCAR:onRewardPlayer(ply, val)
    if (!WCD or !IsValid(ply) or !val) then return end
    
    WCD:GiveVehicleToSteamID(ply:SteamID(), val)

    return true
end