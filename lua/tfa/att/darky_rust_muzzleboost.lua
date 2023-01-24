-- "lua\\tfa\\att\\darky_rust_muzzleboost.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Muzzle Boost"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "10% more fire rate",
	TFA.AttachmentColors["-"], "10% less damage",
	TFA.AttachmentColors["-"], "10% less bullet velocity",
}
ATTACHMENT.Icon = "vgui/entities/darky_rust_mboost.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "MBST"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["mboost"] = {
			["active"] = true
		}
	},
	["WElements"] = {
		["mboost"] = {
			["active"] = true
		}
	},
	["Primary"] = {
		["Damage"] = function(wep,stat) return stat * 0.9 end,
		["RPM"] = function(wep,stat) return stat * 1.1 end,
	},
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
