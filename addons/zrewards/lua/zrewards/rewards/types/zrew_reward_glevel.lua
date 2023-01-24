-- "addons\\zrewards\\lua\\zrewards\\rewards\\types\\zrew_reward_glevel.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) REWARD TYPE - gLevel
    Developed by Zephruz
]]

--[[REWARD: EXP]]
local REWARD_GLEVELEXP = zrewards.rewards:Register("gLevel.EXP", {})
REWARD_GLEVELEXP:SetName("gLevel EXP")
REWARD_GLEVELEXP:SetDescription("EXP reward type for gLevel.")

function REWARD_GLEVELEXP:onRewardPlayer(ply, val)
    if (!gLevel or !IsValid(ply) or !val) then return end

    gLevel.giveExp(ply, val)

    return true
end

--[[REWARD: LEVEL]]
local REWARD_GLEVELLVL = zrewards.rewards:Register("gLevel.Level", {})
REWARD_GLEVELLVL:SetName("gLevel Level")
REWARD_GLEVELLVL:SetDescription("Level reward type for gLevel.")

function REWARD_GLEVELLVL:onRewardPlayer(ply, val)
    if (!gLevel or !IsValid(ply) or !val) then return end

    gLevel.giveLevel(ply, val)

    return true
end

--[[REWARD: RANK]]
local REWARD_GLEVELRANK = zrewards.rewards:Register("gLevel.Rank", {})
REWARD_GLEVELRANK:SetName("gLevel Rank")
REWARD_GLEVELRANK:SetDescription("Rank reward type for gLevel.")

function REWARD_GLEVELRANK:onRewardPlayer(ply, val)
    if (!gLevel or !IsValid(ply) or !val) then return end

    gLevel.giveRank(ply, val)

    return true
end

--[[REWARD: POINTS]]
local REWARD_GLEVELPOINTS = zrewards.rewards:Register("gLevel.Points", {})
REWARD_GLEVELPOINTS:SetName("gLevel Points")
REWARD_GLEVELPOINTS:SetDescription("Point reward type for gLevel.")

function REWARD_GLEVELPOINTS:onRewardPlayer(ply, val)
    if (!gLevel or !IsValid(ply) or !val) then return end

    gLevel.givePoints(ply, val)

    return true
end

--[[REWARD: KEYS]]
local REWARD_GLEVELKEYS = zrewards.rewards:Register("gLevel.Keys", {})
REWARD_GLEVELKEYS:SetName("gLevel Keys")
REWARD_GLEVELKEYS:SetDescription("Key reward type for gLevel.")

function REWARD_GLEVELKEYS:onRewardPlayer(ply, val)
    if (!gLevel or !IsValid(ply) or !val) then return end

    gLevel.giveKeys(ply, val)

    return true
end