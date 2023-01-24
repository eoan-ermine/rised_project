-- "lua\\tfa\\att\\darky_rust_rocket_inc.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Incendiary Rocket"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
	TFA.AttachmentColors["="], "Incendiary rockets spread flames over the area of impact",
	TFA.AttachmentColors["-"], "20% less damage",
	TFA.AttachmentColors["-"], "20% less velocity",
}
ATTACHMENT.Icon = "entities/ammo.rocket.fire.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "INC"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function(wep,stat) return 325 end,
		["ProjectileModel"] = function(wep,stat) return "models/weapons/darky_m/rust/rocket_inc.mdl" end,
		["ProjectileVelocity"] = function(wep,stat) return stat * 0.8 end,
		["Projectile"] = function(wep,stat) return "rust_rocket_inc" end,
		["Radius"] = function(wep,stat) return stat * 0.7 end,
	},
	["Bodygroups_V"] = {
		[1] = 2,
	},	
}


function ATTACHMENT:Attach(wep)
	wep:Unload()
end

function ATTACHMENT:Detach(wep)
	wep:Unload()
end



if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
