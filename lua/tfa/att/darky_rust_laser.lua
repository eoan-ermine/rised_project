-- "lua\\tfa\\att\\darky_rust_laser.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Weapon Lasersight"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "44% more accuracy",
}
ATTACHMENT.Icon = "vgui/entities/darky_rust_laser.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "LASER"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["lasersight"] = {
			["active"] = true
		},
		["laser_beam"] = {
			["active"] = true
		}
	},
	["WElements"] = {
		["lasersight"] = {
			["active"] = true
		},
		["laser_dot"] = {
			["active"] = true
		},
	},
	["Primary"] = {
		["Spread"] = function(wep,stat) return stat * 0.66 end,
		["IronAccuracy"] = function(wep,stat) return stat * 0.66 end,
	},
	["LaserSightAttachment"] = function(wep,stat) return 1 end,
	["LaserSightAttachmentWorld"] = function(wep,stat) return 3 end,
}

function ATTACHMENT:Attach(wep)
	local owner = wep:GetOwner()

	if SERVER and IsValid(owner) and owner:IsPlayer() then
		owner:Flashlight(false)
	end
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
