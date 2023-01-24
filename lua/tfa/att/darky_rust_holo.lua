-- "lua\\tfa\\att\\darky_rust_holo.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Holosight"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "70% more accuracy",
	TFA.AttachmentColors["+"], "2.0x zoom",
}
ATTACHMENT.Icon = "vgui/entities/darky_rust_holo.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "HOLO"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["holosight"] = {
			["active"] = true,
		},
		["holosight_lens"] = {
			["active"] = true
		}
	},
	["WElements"] = {
		["holosight"] = {
			["active"] = true
		}
	},
	["Primary"] = {
		["IronAccuracy"] = function(wep,stat) return stat * 0.7 end,
	},
	["Bodygroups_V"] = {
		[1] = 1,
	},	
	["IronSightsPos"] = function( wep, val ) return wep.IronSightsPos_Holo or val end,
	["IronSightsAng"] = function( wep, val ) return wep.IronSightsAng_Holo or val end,
	["Secondary"] = {
		["IronFOV"] = function( wep, val ) return val * 0.9 end
	},
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
