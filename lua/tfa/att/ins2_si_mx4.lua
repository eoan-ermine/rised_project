-- "lua\\tfa\\att\\ins2_si_mx4.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "MX4 Scope"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["="], "8.7x zoom", TFA.AttachmentColors["-"], "40% higher zoom time",  TFA.AttachmentColors["-"], "10% slower aimed walking" }
ATTACHMENT.Icon = "entities/ins2_si_mx4.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "MX4"
ATTACHMENT.Base = "ins2_scope_base"
ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["scope_mx4"] = {
			["active"] = true,
			["ins2_sightanim_idle"] = "scope_idle",
			["ins2_sightanim_iron"] = "scope_zoom",
		}
	},
	["WElements"] = {
		["scope_mx4"] = {
			["active"] = true
		}
	},
	["Secondary"] = {
		["ScopeZoom"] = function(wep, val) return 8.7 end
	},
	["INS2_SightVElement"] = "scope_mx4",
	["INS2_SightSuffix"] = "MX4"
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end