-- "lua\\tfa\\att\\darky_rust_muzzlebrake.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Muzzle Brake"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "50% less recoil",
	TFA.AttachmentColors["-"], "20% less damage",
	TFA.AttachmentColors["-"], "20% less bullet velocity",
}
ATTACHMENT.Icon = "vgui/entities/darky_rust_mbrake.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "MBRK"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["mbrake"] = {
			["active"] = true
		}
	},
	["WElements"] = {
		["mbrake"] = {
			["active"] = true
		}
	},
	["Primary"] = {
		["Damage"] = function(wep,stat) return stat * 0.8 end,
		["Recoil"] = function(wep,stat) return stat * 0.5 end,
	},
}


if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
