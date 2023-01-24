-- "lua\\tfa\\att\\am_gib.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "G.I.B Ammunition"
ATTACHMENT.ShortName = "GIB" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.Attachments.Colors["+"], "Always gibs enemies", TFA.Attachments.Colors["+"], "10% more damage", TFA.Attachments.Colors["-"], "20% more recoil", TFA.Attachments.Colors["-"], "10% more spread"  }
ATTACHMENT.Icon = "entities/tfa_ammo_gib.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.TFADataVersion = TFA.LatestDataVersion

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["DamageType"] = function(wep,stat) return bit.bor( stat or DMG_BULLET, DMG_ALWAYSGIB ) end,
		["Damage"] = function( wep, stat ) return stat * 1.1 end,
		["Spread"] = function( wep, stat ) return stat * 1.1 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 1.1 end,
		["KickUp"] = function( wep, stat ) return stat * 1.2 end,
		["KickDown"] = function( wep, stat ) return stat * 1.2 end
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
