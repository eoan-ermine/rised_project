-- "lua\\tfa\\att\\darky_rust_12slug.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "12 Gauge Slug"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "Type of shotgun ammunition that fires a single, high-damage projectile.",
	TFA.AttachmentColors["-"], "80 DMG",
	TFA.AttachmentColors["+"], "225 Velocity",
	TFA.AttachmentColors["-"], "1 Pellet",
}
ATTACHMENT.Icon = "entities/ammo.shotgun.slug.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "SLUG"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function(wep,stat) return 80 end,
		["NumShots"] = function(wep,stat) return 1 end,
		["Spread"] = function(wep,stat) return stat/2 end,
		["IronAccuracy"] = function(wep,stat) return stat/11 end,
	},
	["LuaShellModel"] = "models/weapons/darky_m/rust/shotgun_shell_green.mdl",

	["MaterialTable_V"] = function(wep,stat) return {[wep.ShellMaterial] = "models/darky_m/rust_weapons/sawnoffshotgun/Shotgunshell_green"} end,
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
