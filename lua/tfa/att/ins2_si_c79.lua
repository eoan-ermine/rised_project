-- "lua\\tfa\\att\\ins2_si_c79.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "C79 Elcan"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["="], "3.4x zoom", TFA.AttachmentColors["-"], "20% higher zoom time",  TFA.AttachmentColors["-"], "5% slower aimed walking" }
ATTACHMENT.Icon = "entities/ins2_si_c79.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "C79"
ATTACHMENT.Base = "ins2_scope_base"
ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["scope_c79"] = {
			["active"] = true,
			["ins2_sightanim_idle"] = "elcan_idle",
			["ins2_sightanim_iron"] = "elcan_zoom",
		}
	},
	["WElements"] = {
		["scope_c79"] = {
			["active"] = true
		}
	},
	["Secondary"] = {
		["ScopeZoom"] = function( wep, val ) return 3.4 end
	},
	["INS2_SightVElement"] = "scope_c79",
	["INS2_SightSuffix"] = "C79"
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end