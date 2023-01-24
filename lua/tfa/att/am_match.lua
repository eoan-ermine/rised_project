-- "lua\\tfa\\att\\am_match.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Match Ammunition"
ATTACHMENT.ShortName = "Match" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.Attachments.Colors["+"], "20% lower spread kick", "10% lower recoil", TFA.Attachments.Colors["-"], "20% lower spread recovery"  }
ATTACHMENT.Icon = "entities/tfa_ammo_match.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.TFADataVersion = TFA.LatestDataVersion

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["SpreadIncrement"] = function( wep, stat ) return stat * 0.9 end,
		["SpreadRecovery"] = function( wep, stat ) return stat * 0.8 end,
		["KickUp"] = function( wep, stat ) return stat * 0.9 end,
		["KickDown"] = function( wep, stat ) return stat * 0.9 end
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
