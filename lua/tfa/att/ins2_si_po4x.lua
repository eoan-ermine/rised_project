-- "lua\\tfa\\att\\ins2_si_po4x.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "PO 4x24P"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["="], "4x zoom", TFA.AttachmentColors["-"], "25% higher zoom time",  TFA.AttachmentColors["-"], "5% slower aimed walking" }
ATTACHMENT.Icon = "entities/ins2_si_po4x.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "PO4X"
ATTACHMENT.Base = "ins2_scope_base"
ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["scope_po4x"] = {
			["active"] = true,
			["ins2_sightanim_idle"] = "po_idle",
			["ins2_sightanim_iron"] = "po_zoom",
		}
	},
	["WElements"] = {
		["scope_po4x"] = {
			["active"] = true
		}
	},
	["Secondary"] = {
		["ScopeZoom"] = function( wep, val ) return 4 end
	},
	["INS2_SightVElement"] = "scope_po4x",
	["INS2_SightSuffix"] = "PO4X"
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end