-- "lua\\tfa\\att\\darky_rust_gl_smoke.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "40mm Smoke Grenade"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
	TFA.AttachmentColors["-"], "0 DMG",
}
ATTACHMENT.Icon = "entities/ammo.grenadelauncher.smoke.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "SMOKE"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = 0,
		["Projectile"] = "rust_glsmoke",
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
