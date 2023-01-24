-- "lua\\tfa\\att\\ins2_si_eotech.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "EOTech 552"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["="], "5% higher zoom", TFA.AttachmentColors["-"], "5% higher zoom time" }
ATTACHMENT.Icon = "entities/ins2_si_eotech.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "EOTECH"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["rail_sights"] = {
			["active"] = true
		},
		["sight_eotech"] = {
			["active"] = true,
			["ins2_sightanim_idle"] = "idle",
			["ins2_sightanim_iron"] = "zoom",
		},
		["sights_folded"] = {
			["active"] = false
		},
		["sight_eotech_lens"] = {
			["active"] = true
		}
	},
	["WElements"] = {
		["rail_sights"] = {
			["active"] = true
		},
		["sight_eotech"] = {
			["active"] = true
		},
		["sights_folded"] = {
			["active"] = false
		},
		["sight_eotech_lens"] = {
			["active"] = true
		}
	},
	["IronSightsPos"] = function( wep, val ) return wep.IronSightsPos_EOTech or val end,
	["IronSightsAng"] = function( wep, val ) return wep.IronSightsAng_EOTech or val end,
	["Secondary"] = {
		["IronFOV"] = function( wep, val ) return wep.Secondary.IronFOV_EOTech or val * 0.95 end
	},
	["IronSightTime"] = function( wep, val ) return val * 1.05 end,
	["INS2_SightVElement"] = "sight_eotech",
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
