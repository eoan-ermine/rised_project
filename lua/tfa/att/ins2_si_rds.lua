-- "lua\\tfa\\att\\ins2_si_rds.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Aimpoint CompM2"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["="], "10% higher zoom", TFA.AttachmentColors["-"], "7.5% higher zoom time" }
ATTACHMENT.Icon = "entities/ins2_si_rds.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "RDS"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["rail_sights"] = {
			["active"] = true
		},
		["sight_rds"] = {
			["active"] = true,
			["ins2_sightanim_idle"] = "4x_idle",
			["ins2_sightanim_iron"] = "4x_zoom",
		},
		["sights_folded"] = {
			["active"] = false
		},
		["sight_rds_lens"] = {
			["active"] = true
		}
	},
	["WElements"] = {
		["rail_sights"] = {
			["active"] = true
		},
		["sight_rds"] = {
			["active"] = true
		},
		["sights_folded"] = {
			["active"] = false
		},
		["sight_rds_lens"] = {
			["active"] = true
		}
	},
	["IronSightsPos"] = function( wep, val ) return wep.IronSightsPos_RDS or val end,
	["IronSightsAng"] = function( wep, val ) return wep.IronSightsAng_RDS or val end,
	["Secondary"] = {
		["IronFOV"] = function( wep, val ) return wep.Secondary.IronFOV_RDS or val * 0.9 end
	},
	["IronSightTime"] = function( wep, val ) return val * 1.075 end,
	["INS2_SightVElement"] = "sight_rds",
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
