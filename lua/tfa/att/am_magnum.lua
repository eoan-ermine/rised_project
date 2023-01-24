-- "lua\\tfa\\att\\am_magnum.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Magnum Ammunition"
ATTACHMENT.ShortName = "MAG" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.Attachments.Colors["+"], "10% more damage", TFA.Attachments.Colors["-"], "15% more recoil", TFA.Attachments.Colors["-"], "10% more spread"  }
ATTACHMENT.Icon = "entities/tfa_ammo_magnum.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.TFADataVersion = TFA.LatestDataVersion

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat * 1.1 end,
		["Spread"] = function( wep, stat ) return stat * 1.1 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 1.1 end,
		["KickUp"] = function( wep, stat ) return stat * 1.15 end,
		["KickDown"] = function( wep, stat ) return stat * 1.15 end
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
