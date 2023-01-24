-- "lua\\tfa\\att\\ins2_br_heavy.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Heavy Barrel"
ATTACHMENT.Description = {
	TFA.AttachmentColors["="], "Weight in the front of the weapon to reduce muzzle climb and increase accuracy",
	TFA.AttachmentColors["+"], "Reduces vertical recoil by 10%",
	TFA.AttachmentColors["-"], "Increases weight of the weapon",
}
ATTACHMENT.Icon = "entities/ins2_att_br_heavy.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "HBR"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["KickUp"] = function( wep, stat ) return stat * 0.9 end,
		["KickDown"] = function( wep, stat ) return stat * 0.9 end,
	},
	["MoveSpeed"] = function( wep, stat ) return stat * 0.95 end,
	["IronSightsMoveSpeed"] = function( wep, stat ) return stat * 0.95 end,
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
