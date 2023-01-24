-- "lua\\tfa\\att\\darky_rust_silencer.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Silencer"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "Less firing noise",
	TFA.AttachmentColors["+"], "20% less recoil",
	TFA.AttachmentColors["+"], "45% less spread",
	TFA.AttachmentColors["-"], "5% less damage",
	TFA.AttachmentColors["-"], "25% less bullet velocity",
}
ATTACHMENT.Icon = "vgui/entities/darky_rust_silencer.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "SIL"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["silencer"] = {
			["active"] = true
		}
	},
	["WElements"] = {
		["silencer"] = {
			["active"] = true
		}
	},
	["Primary"] = {
		["Damage"] = function(wep,stat) return stat * 0.95 end,
		["Spread"] = function(wep,stat) return stat * 0.55 end,
		["IronAccuracy"] = function(wep,stat) return stat * 0.8 end,
		["Recoil"] = function(wep,stat) return stat * 0.8 end,
		["Sound"] = function(wep,stat) return wep.Primary.SilencedSound or stat end
	},
	["MuzzleFlashEffect"] = "",
	["Silenced"] = true,
}

function ATTACHMENT:Attach(wep)
	wep.Silenced = true
	wep:SetSilenced(wep.Silenced)
end

function ATTACHMENT:Detach(wep)
	wep.Silenced = false
	wep:SetSilenced(wep.Silenced)
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
