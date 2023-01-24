-- "lua\\tfa\\att\\ins2_ub_laser_railed_ots33.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name        = "SureFire X400 Laser + Flashlight"
ATTACHMENT.ShortName   = "X400"

ATTACHMENT.Icon        = "entities/eft_x400.png" 

ATTACHMENT.Description = { 
    TFA.AttachmentColors["+"], "Laser + Flashlight Modules",
    TFA.AttachmentColors["+"], "Enhanced laser point viewing distance",
    TFA.AttachmentColors["+"], "25% Lower base spread",
    TFA.AttachmentColors["-"], "5% Higher max spread",
    TFA.AttachmentColors["-"], "5% Lower zoom time",  
}

ATTACHMENT.WeaponTable = {

	["VElements"] = {
		["laser_railed"] = {
			["active"] = true
		},
		["laser_modkit"] = {
			["active"] = true
		},
		["laser_beam"] = {
			["active"] = true
		}
	},
	["WElements"] = {
		["laser"] = {
			["active"] = true
		},
		["laser_beam"] = {
			["active"] = true
		}
	},
	
	["Primary"] = {
		["Spread"] = function(wep,stat) return math.max( stat * 0.75, stat - 0.01 ) end,
		["SpreadMultiplierMax"] = function(wep,stat) return stat * ( 1 / 0.8 ) * 1.05 end,
	},

	["IronSightTime"] = function( wep, val ) return val * 1.05 end,

	["LaserSightAttachment"]      = function(wep,stat) return wep.LaserSightModAttachment end,
	["LaserSightAttachmentWorld"] = function(wep,stat) return wep.LaserSightModAttachmentWorld or wep.LaserSightModAttachment end,

	["LaserDistance"]        = 12 * 250,
	["LaserDistanceVisual"]  = 12 * 6.5,
	["laserFOV"]             = 0.8,
	
	["FlashlightAttachment"] = 1,
	["FlashlightDistance"]   = 10 * 70,
	["FlashlightBrightness"] = 7.5,
	["FlashlightFOV"]        = 50,
	
	FlashlightSoundToggleOn = Sound("TFA_INS2.FlashlightOn"),
	FlashlightSoundToggleOff = Sound("TFA_INS2.FlashlightOff"),
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