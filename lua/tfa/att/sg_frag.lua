-- "lua\\tfa\\att\\sg_frag.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Frag Ammunition"
ATTACHMENT.ShortName = "Frag" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.Attachments.Colors["+"], "Explosive Damage", "2x damage", TFA.Attachments.Colors["-"], "0.5x pellets" }
ATTACHMENT.Icon = "entities/tfa_ammo_fragshell.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.TFADataVersion = TFA.LatestDataVersion

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["DamageType"] = function(wep,stat) return bit.bor( stat or 0, DMG_BLAST ) end,
		["Damage"] = function(wep,stat) return stat * 2 end,
		["NumShots"] = function(wep,stat) return stat / 2 end
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
