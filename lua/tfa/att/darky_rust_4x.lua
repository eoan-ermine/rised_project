-- "lua\\tfa\\att\\darky_rust_4x.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Base = "si_rt_base"
ATTACHMENT.Name = "4x Zoom Scope"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "15% more accuracy",
	TFA.AttachmentColors["+"], "20% less recoil",
	TFA.AttachmentColors["+"], "4.0x zoom",
}
ATTACHMENT.Icon = "vgui/entities/darky_rust_8x.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "4X"

local fov = 90 / 4 / 2 -- Default FOV / Scope Zoom / screenscale

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["4xscope"] = {
			["active"] = true,
		},
	},
	["WElements"] = {
		["4xscope"] = {
			["active"] = true
		}
	},
	["Primary"] = {
		["IronAccuracy"] = function(wep,stat) return stat * 0.85 end,
	},
	["Bodygroups_V"] = {
		[1] = 1,
	},	
	["IronSightsPos"] = function( wep, val ) return wep.IronSightsPos_4xscope or val, true end,
	["IronSightsAng"] = function( wep, val ) return wep.IronSightsAng_4xscope or val, true end,
	["IronSightsSensitivity"] = function(wep,val) return 0.5 end,
	["Secondary"] = {
		["IronFOV"] = function( wep, val ) return val * 0.7 end
	},
	["IronSightTime"] = function( wep, val ) return val * 1.20 end,
	["IronSightMoveSpeed"] = function(stat) return stat * 0.8 end,
	["RTOpaque"] = true,
	["RTMaterialOverride"] = -1,

	["RTScopeFOV"] = 90 / 4 / 2,

	["RTReticleMaterial"] = Material("models/darky_m/rust_weapons/mods/4x_crosshair"),
	["RTReticleScale"] = 1,
}


if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
