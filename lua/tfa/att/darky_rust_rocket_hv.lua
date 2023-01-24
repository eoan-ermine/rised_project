-- "lua\\tfa\\att\\darky_rust_rocket_hv.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "High Velocity Rocket"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "50% more velocity",
	TFA.AttachmentColors["-"], "38% less damage",
	TFA.AttachmentColors["-"], "30% less explosion radius",
}
ATTACHMENT.Icon = "entities/ammo.rocket.hv.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "HV"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function(wep,stat) return 255 end,
		["ProjectileModel"] = function(wep,stat) return "models/weapons/darky_m/rust/rocket_hv.mdl" end,
		["ProjectileVelocity"] = function(wep,stat) return stat * 1.5 end,
		["Radius"] = function(wep,stat) return stat * 0.7 end,
	},
	["Bodygroups_V"] = {
		[1] = 1,
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
