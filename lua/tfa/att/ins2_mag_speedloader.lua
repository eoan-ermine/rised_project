-- "lua\\tfa\\att\\ins2_mag_speedloader.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Speed Loader"
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "Bundles rounds into fixed magazines to speed up reloading"
}
ATTACHMENT.Icon = "entities/ins2_att_mag_speedloader.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "LOAD+"

local function checkSeqExists(wep, name)
	if not IsValid(wep) then return false end
	local owner = wep:GetOwner() or NULL
	if not wep:IsValid() then return false end
	local vm = owner:GetViewModel() or NULL
	if not vm:IsValid() then return false end
	local id = vm:LookupSequence(name)
	if id >= 0 then return true end
	return false
end

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["speedloader"] = {
			["active"] = true,
		}
	},
	["Shotgun"] = false,
	["Animations"] = {
		["reload"] = function(wep, _val)
			local val = table.Copy(_val)
			if val.type == TFA.Enum.ANIMATION_SEQ then
				val.value = val.value .. "_speed"
			else
				val.type = TFA.Enum.ANIMATION_SEQ --Sequence or act
				val.value = "base_reload_speed"
			end
			return (checkSeqExists(wep, val.value) and val or _val), true, true
		end,
		["reload_shotgun_start"] = {
			type = 0, value = 0,
		},
		["reload_shotgun_finish"] = {
			type = 0, value = 0,
		},
	},
}

function ATTACHMENT:Attach(wep)
	wep.Shotgun = false
end

function ATTACHMENT:Detach(wep)
	wep.Shotgun = true
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
