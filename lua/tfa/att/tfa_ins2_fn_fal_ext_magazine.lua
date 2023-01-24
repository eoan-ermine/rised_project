-- "lua\\tfa\\att\\tfa_ins2_fn_fal_ext_magazine.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name        = "Extended Magazine"
ATTACHMENT.ShortName   = "MAG+"

ATTACHMENT.Icon        = "entities/ins2_att_mag_ext_rifle_30rd.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "Increases magazine capacity to 30 rounds."
}

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["mag"] = {
			["active"] = false,
		},
		["mag_ext"] = {
			["active"] = true,
		}
	},
	["WElements"] = {
		["mag"] = {
			["active"] = false,
		},
		["mag_ext"] = {
			["active"] = true,
		}
	},
	["Primary"] = {
		["ClipSize"] = function(wep, val)
			return wep.Primary.ClipSize_ExtRifle or 30
		end,
	},
}

function ATTACHMENT:Attach(wep)
	if not wep.IsFirstDeploy then
		wep:Unload()
	end
end

function ATTACHMENT:Detach(wep)
	wep:Unload()
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
