-- "lua\\tfa\\att\\ins2_si_2xrds.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Aimpoint CompM2 2X"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["="], "2x zoom", TFA.AttachmentColors["-"], "10% higher zoom time",  TFA.AttachmentColors["-"], "5% slower aimed walking" }
ATTACHMENT.Icon = "entities/ins2_si_2xrds.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "2XRDS"
ATTACHMENT.Base = "ins2_scope_base"
ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["scope_2xrds"] = {
			["active"] = true,
			["ins2_sightanim_idle"] = "4x_idle",
			["ins2_sightanim_iron"] = "4x_zoom",
		}
	},
	["WElements"] = {
		["scope_2xrds"] = {
			["active"] = true
		}
	},
	["Secondary"] = {
		["ScopeZoom"] = function( wep, val ) return 2 end
	},
	["INS2_SightVElement"] = "scope_2xrds",
	["INS2_SightSuffix"] = "2XRDS"
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end