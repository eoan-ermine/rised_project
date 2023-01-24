-- "lua\\tfa\\att\\si_aimpoint.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Aimpoint"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.Attachments.Colors["="], "10% higher zoom", TFA.Attachments.Colors["-"], "10% higher zoom time" }
ATTACHMENT.Icon = "entities/tfa_si_aimpoint.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "AIM"
ATTACHMENT.TFADataVersion = TFA.LatestDataVersion

ATTACHMENT.WeaponTable = {
	["ViewModelElements"] = {
		["aimpoint"] = {
			["active"] = true
		},
		["aimpoint_spr"] = {
			["active"] = true
		}
	},
	["WorldModelElements"] = {
		["aimpoint"] = {
			["active"] = true
		},
		["aimpoint_spr"] = {
			["active"] = true
		}
	},
	["IronSightsPosition"] = function( wep, val ) return wep.IronSightsPos_AimPoint or val, true end,
	["IronSightsAngle"] = function( wep, val ) return wep.IronSightsAng_AimPoint or val, true end,
	["Secondary"] = {
		["OwnerFOV"] = function( wep, val ) return val * 0.9 end
	},
	["IronSightTime"] = function( wep, val ) return val * 1.10 end
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
