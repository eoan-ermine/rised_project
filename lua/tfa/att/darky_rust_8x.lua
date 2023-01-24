-- "lua\\tfa\\att\\darky_rust_8x.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Base = "si_rt_base"
ATTACHMENT.Name = "8x Zoom Scope"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "15% more accuracy",
	TFA.AttachmentColors["+"], "20% less recoil",
	TFA.AttachmentColors["+"], "8.0x zoom",
}
ATTACHMENT.Icon = "vgui/entities/darky_rust_16x.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "8X"

local fov = 90 / 4 / 2 -- Default FOV / Scope Zoom / screenscale

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["8xscope"] = {
			["active"] = true,
		},
	},
	["WElements"] = {
		["8xscope"] = {
			["active"] = true
		}
	},
	["Primary"] = {
		["IronAccuracy"] = function(wep,stat) return stat * 0.85 end,
		-- ["RecoilLUT"] = {
		-- 	["loop"] = {
		-- 		["points"] = function(wep,stat) print(stat) return stat * 0.1 end,
		-- 	}
		-- }
	},

	["Bodygroups_V"] = {
		[1] = 1,
	},	
	["IronSightsPos"] = function( wep, val ) return wep.IronSightsPos_8xscope or val, true end,
	["IronSightsAng"] = function( wep, val ) return wep.IronSightsAng_8xscope or val, true end,
	["IronSightsSensitivity"] = function(wep,val) return 0.25 end,
	["Secondary"] = {
		["IronFOV"] = function( wep, val ) return val * 0.7 end
	},
	["IronSightTime"] = function( wep, val ) return val * 1.20 end,
	["IronSightMoveSpeed"] = function(stat) return stat * 0.8 end,
	["RTOpaque"] = true,
	["RTMaterialOverride"] = -1,

	["RTScopeFOV"] = 90 / 8 / 2, -- Default FOV / Scope Zoom / screenscale

	["RTReticleMaterial"] = Material("models/darky_m/rust_weapons/mods/8x_crosshair"),
	["RTReticleScale"] = 1,
}


if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
