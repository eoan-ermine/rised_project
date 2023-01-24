-- "addons\\zrewards\\lua\\zrewards\\rewards\\types\\zrew_reward_nutscript.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) REWARD TYPE - Nutscript
    Developed by Zephruz
]]

--[[REWARD: MONEY]]
local REWARD_NUTSCRIPTMONEY = zrewards.rewards:Register("Nutscript.Money", {})
REWARD_NUTSCRIPTMONEY:SetName("Nutscript Cash")
REWARD_NUTSCRIPTMONEY:SetDescription("Money reward type for Nutscript.")

function REWARD_NUTSCRIPTMONEY:onRewardPlayer(ply, val)
    if (!nut or !IsValid(ply) or !val) then return end

    local char = ply:getChar()

    if !(char) then return end

    char:setMoney(val)

    return true
end