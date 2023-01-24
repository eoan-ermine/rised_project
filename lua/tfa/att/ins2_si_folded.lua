-- "lua\\tfa\\att\\ins2_si_folded.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Folded Sights"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "Easier to aim", TFA.AttachmentColors["-"], "5% higher zoom time" }
ATTACHMENT.Icon = "entities/ins2_att_fsi.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "FSI"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["rail_sights"] = {
			["active"] = true
		},
		["sights_folded"] = {
			["active"] = true
		}
	},
	["WElements"] = {
		["rail_sights"] = {
			["active"] = true
		},
		["sights_folded"] = {
			["active"] = true
		}
	},
	["IronSightsPos"] = function( wep, val ) return wep.IronSightsPos_Folded or val end,
	["IronSightsAng"] = function( wep, val ) return wep.IronSightsAng_Folded or val end,
	["IronSightTime"] = function( wep, val ) return val * 1.05 end
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
