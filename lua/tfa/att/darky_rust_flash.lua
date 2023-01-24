-- "lua\\tfa\\att\\darky_rust_flash.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Weapon Flashlight"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "You can see enemy in the dark",
	TFA.AttachmentColors["-"], "They can see you too",
}
ATTACHMENT.Icon = "vgui/entities/darky_rust_flash.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "FLASH"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["flashlight"] = {
			["active"] = true
		}
	},
	["WElements"] = {
		["flashlight"] = {
			["active"] = true
		},
		["flash_sprite"] = {
			["active"] = true
		},
	},
	["FlashlightAttachment"] = function(wep,stat) return 1 end,
	["FlashlightAttachmentWorld"] = function(wep,stat) return 1 end
}

function ATTACHMENT:Attach(wep)
	local owner = wep:GetOwner()

	if SERVER and IsValid(owner) and owner:IsPlayer() then
		owner:Flashlight(false)
		wep:ToggleFlashlight(true)
	end
end

function ATTACHMENT:Detach(wep)
	if wep:GetFlashlightEnabled() then
		-- owner:Flashlight(false)
		wep:ToggleFlashlight(false)
	end
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
