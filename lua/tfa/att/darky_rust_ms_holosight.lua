-- "lua\\tfa\\att\\darky_rust_ms_holosight.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Simple Handmade Sight"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
	TFA.AttachmentColors["="], "-5% zoom",
}
ATTACHMENT.Icon = "vgui/entities/darky_rust_ms_holosight.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "DIY"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["ms_holosight"] = {
			["active"] = true,
		},
		["ms_holosight_xhair"] = {
			["active"] = true
		}
	},
	["WElements"] = {
		["ms_holosight"] = {
			["active"] = true
		}
	},
	["Bodygroups_V"] = {
		[1] = 1,
	},	
	["IronSightsPos"] = function( wep, val ) return wep.IronSightsPos_msHolosight end,
	["IronSightsAng"] = function( wep, val ) return wep.IronSightsAng_msHolosight end,

	["Secondary"] = {
		["IronFOV"] = function( wep, val ) return wep.ViewModelFOV+10 end
	},
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
