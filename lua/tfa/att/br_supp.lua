-- "lua\\tfa\\att\\br_supp.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Suppressor"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.Attachments.Colors["+"], "Less firing noise", TFA.Attachments.Colors["-"], "10% less spread", TFA.Attachments.Colors["-"], "5% less damage", TFA.Attachments.Colors["-"], "10% less vertical recoil" }
ATTACHMENT.Icon = "entities/tfa_br_supp.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "SUPP"
ATTACHMENT.TFADataVersion = TFA.LatestDataVersion

ATTACHMENT.WeaponTable = {
	["ViewModelElements"] = {
		["suppressor"] = {
			["active"] = true
		}
	},
	["WorldModelElements"] = {
		["suppressor"] = {
			["active"] = true
		}
	},
	["Primary"] = {
		["Damage"] = function(wep,stat) return stat * 0.95 end,
		["KickUp"] = function(wep,stat) return stat * 0.9 end,
		["KickDown"] = function(wep,stat) return stat * 0.9 end,
		["Spread"] = function(wep,stat) return stat * 0.9 end,
		["IronAccuracy"] = function(wep,stat) return stat * 0.9 end,
		["Sound"] = function(wep,stat) return wep.Primary.SilencedSound or stat end
	},
	["MuzzleFlashEffect"] = "tfa_muzzleflash_silenced",
	["MuzzleAttachmentMod"] = function(wep,stat) return wep.MuzzleAttachmentSilenced or stat end
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
