-- "lua\\tfa\\att\\ins2_si_mosin.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "7X Scope"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {TFA.AttachmentColors["="], "7x zoom", TFA.AttachmentColors["-"], "30% higher zoom time", TFA.AttachmentColors["-"], "10% slower aimed walking"}
ATTACHMENT.Icon = "entities/ins2_si_mosin.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "MOSN"
ATTACHMENT.Base = "ins2_scope_base"
ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["scope_mosin"] = {
			["active"] = true,
			["ins2_sightanim_idle"] = "scope_idle",
			["ins2_sightanim_iron"] = "scope_zoom"
		}
	},
	["WElements"] = {
		["scope_mosin"] = {
			["active"] = true
		}
	},
	["Secondary"] = {
		["ScopeZoom"] = function(wep, val) return 7 end
	},
	["INS2_SightVElement"] = "scope_mosin",
	["INS2_SightSuffix"] = "Mosin"
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end