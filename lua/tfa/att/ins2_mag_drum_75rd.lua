-- "lua\\tfa\\att\\ins2_mag_drum_75rd.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Drum Magazine"
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "Increases magazine capacity to 75 rounds."
}
ATTACHMENT.Icon = "entities/ins2_att_mag_drum_75rd.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "DRUM"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["mag"] = {
			["active"] = false,
		},
		["mag_drum"] = {
			["active"] = true,
		}
	},
	["WElements"] = {
		["mag"] = {
			["active"] = false,
		},
		["mag_drum"] = {
			["active"] = true,
		}
	},
	["Animations"] = {
		["reload"] = function(wep, _val)
			local val = table.Copy(_val)
			if val.type == TFA.Enum.ANIMATION_SEQ then
				val.value = val.value .. "_drum"
			else
				val.type = TFA.Enum.ANIMATION_SEQ --Sequence or act
				val.value = "base_reload_drum"
			end
			return (wep:CheckVMSequence(val.value) and val or _val), true, true
		end,
		["reload_empty"] = function(wep, _val)
			local val = table.Copy(_val)
			if val.type == TFA.Enum.ANIMATION_SEQ then
				val.value = val.value .. "_drum"
			else
				val.type = TFA.Enum.ANIMATION_SEQ --Sequence or act
				val.value = "base_reload_empty_drum"
			end
			return (wep:CheckVMSequence(val.value) and val or _val), true, true
		end,
	},
	["Primary"] = {
		["ClipSize"] = function(wep, val)
			return wep.Primary.ClipSize_Drum or 75
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
