-- "lua\\tfa\\att\\darky_rust_gl_shotgun.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "40mm Shotgun Round"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "270 DMG",
	TFA.AttachmentColors["+"], "225 Velocity",
	TFA.AttachmentColors["="], "18 Pellets",
}
ATTACHMENT.Icon = "entities/ammo.grenadelauncher.buckshot.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "SG"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Projectile"] = false,
		["ProjectileModel"] = nil,
		["ProjectileVelocity"] = nil,
		["Damage"] = 270/18,
		["NumShots"] = 18,
		["Sound"] = "darky_rust.spas12-attack",
		["Spread"] = 0.12,
		["IronAccuracy"] = 0.12,
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
