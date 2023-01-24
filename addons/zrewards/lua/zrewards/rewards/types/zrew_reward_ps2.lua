-- "addons\\zrewards\\lua\\zrewards\\rewards\\types\\zrew_reward_ps2.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) REWARD TYPE - PS2
    Developed by Zephruz
]]

--[[REWARD: POINTS]]
local REWARD_PS2POINTS = zrewards.rewards:Register("PS2.Points", {})
REWARD_PS2POINTS:SetName("PS2 Points")
REWARD_PS2POINTS:SetDescription("Point reward type for PointShop 2.")

function REWARD_PS2POINTS:onRewardPlayer(ply, val)
    if (!Pointshop2 or !IsValid(ply) or !val) then return end
	
	timer.Simple(3,
    function()
		if !(IsValid(ply)) then return end
		
		ply:PS2_AddStandardPoints(val)
	end)
    
    return true
end

--[[REWARD: PREMIUM POINTS]]
local REWARD_PS2PREMIUMPOINTS = zrewards.rewards:Register("PS2.PremiumPoints", {})
REWARD_PS2PREMIUMPOINTS:SetName("PS2 Premium Points")
REWARD_PS2PREMIUMPOINTS:SetDescription("Premium point reward type for PointShop 2.")

function REWARD_PS2PREMIUMPOINTS:onRewardPlayer(ply, val)
    if (!Pointshop2 or !IsValid(ply) or !val) then return end

	timer.Simple(3,
    function()
		if !(IsValid(ply)) then return end
		
		ply:PS2_AddPremiumPoints(val)
	end)
    
	
    return true
end