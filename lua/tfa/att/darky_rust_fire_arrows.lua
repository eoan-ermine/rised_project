-- "lua\\tfa\\att\\darky_rust_fire_arrows.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Fire Arrow"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
	TFA.AttachmentColors["="], "A fuel soaked arrow, ignite it by aiming into a fire source.",
	TFA.AttachmentColors["+"], "Flaming",
	TFA.AttachmentColors["-"], "20% less damage",
	TFA.AttachmentColors["-"], "20% less velocity",
}
ATTACHMENT.Icon = "entities/arrow.fire.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "FIRE"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["fire_arrow"] = {
			["active"] = true
		}
	},
	["WElements"] = {
		["fire_arrow"] = {
			["active"] = true
		}
	},
	["Primary"] = {
		["Damage"] = function(wep,stat) return stat * 0.8 end,
		["ProjectileModel"] = function(wep,stat) return "models/weapons/darky_m/rust/fire_arrow.mdl" end,
		["ProjectileVelocity"] = function(wep,stat) return stat * 0.8 end,
		["Projectile"] = function(wep,stat) return "rust_fire_arrow" end,
	},
	["Bodygroups_V"] = {
		[2] = 3,
	},	
	
}


function ATTACHMENT:Attach(wep)
	wep:Unload()
	wep.Pull = false
	wep.Keydown = false
end

function ATTACHMENT:Detach(wep)
	wep:Unload()
	wep.Pull = false
	wep.Keydown = false
	wep.Owner:GetViewModel():StopParticles()
end



if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
