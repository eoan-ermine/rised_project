-- "lua\\tfa\\att\\ins2_ub_flashlight.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Flashlight"
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "Assists target discovery in darker settings"
}
ATTACHMENT.Icon = "entities/ins2_att_ub_flashlight.png"
ATTACHMENT.ShortName = "FLASH"

ATTACHMENT.WeaponTable = {
	VElements = {
		flashlight = {
			active = true
		}
	},
	WElements = {
		flashlight = {
			active = true
		}
	},
	FlashlightAttachmentName = "Laser",
	Flashlight_VElement = "flashlight",
	FlashlightAttachmentWorld = 1,

	FlashlightSoundToggleOn = Sound("TFA_INS2.FlashlightOn"),
	FlashlightSoundToggleOff = Sound("TFA_INS2.FlashlightOff")
}

function ATTACHMENT:Attach(wep)
	local owner = wep:GetOwner()

	if SERVER and IsValid(owner) and owner:IsPlayer() and owner:FlashlightIsOn() then
		owner:Flashlight(false)
	end
end

function ATTACHMENT:Detach(wep)
	if wep:GetFlashlightEnabled() then
		wep:ToggleFlashlight(false)
	end
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
