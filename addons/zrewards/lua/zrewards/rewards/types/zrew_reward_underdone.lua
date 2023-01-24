-- "addons\\zrewards\\lua\\zrewards\\rewards\\types\\zrew_reward_underdone.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) REWARD TYPE - Underdone
    Developed by Zephruz
]]

--[[REWARD: ITEM]]
local REWARD_ITEM = zrewards.rewards:Register("Underdone.Item", {})
REWARD_ITEM:SetName("Underdone Item")
REWARD_ITEM:SetDescription("Underdone item reward.")

function REWARD_ITEM:onRewardPlayer(ply, val)
    if (!IsValid(ply) or !val) then return end

    local item, amt = val, 1

    if (istable(val)) then
        item = val.item
        amt = (val.amount || 1)

        if !(item) then return end
    end

    RunConsoleCommand("ud_admingiveitem", item, amt, ply:Nick())

    return true
end

--[[REWARD: MONEY]]
local REWARD_MONEY = zrewards.rewards:Register("Underdone.Money", {})
REWARD_MONEY:SetName("Underdone Money")
REWARD_MONEY:SetDescription("Underdone money reward.")

function REWARD_MONEY:onRewardPlayer(ply, val)
    if (!IsValid(ply) or !val) then return end

    RunConsoleCommand("ud_admingiveitem", "money", val, ply:Nick())

    return true
end

--[[REWARD: XP]]
local REWARD_XP = zrewards.rewards:Register("Underdone.XP", {})
REWARD_XP:SetName("Underdone XP")
REWARD_XP:SetDescription("Underdone XP reward.")

function REWARD_XP:onRewardPlayer(ply, val)
    if (!IsValid(ply) or !val) then return end

    RunConsoleCommand("ud_admingivexp", val, ply:Nick())

    return true
end