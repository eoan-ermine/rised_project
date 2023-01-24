-- "lua\\tfa\\att\\si_acog.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Base = "si_rt_base"
ATTACHMENT.Name = "ACOG"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.Attachments.Colors["="], "4x zoom", TFA.Attachments.Colors["-"], "20% higher zoom time",  TFA.Attachments.Colors["-"], "10% slower aimed walking" }
ATTACHMENT.Icon = "entities/tfa_si_acog.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "ACOG"
ATTACHMENT.TFADataVersion = TFA.LatestDataVersion

local fov = 90 / 4 / 2 -- Default FOV / Scope Zoom / screenscale

ATTACHMENT.WeaponTable = {
	["ViewModelElements"] = {
		["acog"] = {
			["active"] = true
		},
		["rtcircle_acog"] = {
			["active"] = true
		}
	},
	["WorldModelElements"] = {
		["acog"] = {
			["active"] = true
		}
	},
	["IronSightsPosition"] = function( wep, val ) return wep.IronSightsPos_ACOG or val, true end,
	["IronSightsAngle"] = function( wep, val ) return wep.IronSightsAng_ACOG or val, true end,
	["IronSightsSensitivity"] = function(wep,val) return TFA.CalculateSensitivtyScale( fov, wep:GetStatL("Secondary.OwnerFOV"), wep.ACOGScreenScale ) end ,
	["Secondary"] = {
		["OwnerFOV"] = function( wep, val ) return val * 0.7 end
	},
	["IronSightTime"] = function( wep, val ) return val * 1.20 end,
	["IronSightMoveSpeed"] = function(stat) return stat * 0.9 end,
	["RTOpaque"] = true,
	["RTMaterialOverride"] = -1,

	["RTScopeFOV"] = 90 / 4 / 2, -- Default FOV / Scope Zoom / screenscale

	["RTReticleMaterial"] = Material("scope/gdcw_acog"),
	["RTReticleScale"] = 1,
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
