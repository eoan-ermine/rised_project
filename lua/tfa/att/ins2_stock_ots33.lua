-- "lua\\tfa\\att\\ins2_stock_ots33.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name        = "Metal Stock"
ATTACHMENT.ShortName   = "Stock"
ATTACHMENT.Icon        = "entities/ins2_stock_ots33.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.Description = { 
TFA.AttachmentColors["+"], "-20% Recoil", 
TFA.AttachmentColors["+"], "-20% Iron Spread",
TFA.AttachmentColors["+"], "-20% Max spread", 
TFA.AttachmentColors["-"], "+10% Zoom time",
TFA.AttachmentColors["-"], "+5% More wheigt",
}

ATTACHMENT.WeaponTable = {

	["Bodygroups_V"] = {
		[1] = 1
	},
	
	["Bodygroups_W"] = {
		[1] = 1
	},
	
--   ["ViewModelBoneMods"] = {
--	    ["L Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 2, -10) },
--	    ["L Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 5, -10) },    
--	},
	
	["Primary"] = {
		["KickUp"] = function(wep,stat) return stat * 0.8 end,
		["KickDown"] = function(wep,stat) return stat * 0.8 end,
		["IronAccuracy"] = function(wep,stat) return stat * 0.8 end,
		["Spread"] = function(wep,stat) return math.max( stat * 0.8, stat - 0.01 ) end,
		["SpreadMultiplierMax"] = function(wep,stat) return stat * 0.8 end,
	},
	
	["MoveSpeed"] = function(wep,stat) return stat * 0.95 end,
	["IronSightsMoveSpeed"] = function(wep,stat) return stat * 0.95 end,
	["IronSightTime"] = function( wep, val ) return val * 1.1 end,
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
