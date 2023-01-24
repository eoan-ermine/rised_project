-- "lua\\tfa\\att\\darky_rust_12gauge.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "12 Gauge Buckshot"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "Extremely lethal in close quarters, capable of one-shotting fully geared players at point-blank.",
	TFA.AttachmentColors["+"], "210 DMG",
	TFA.AttachmentColors["+"], "225 Velocity",
	TFA.AttachmentColors["-"], "14 Pellets",
}
ATTACHMENT.Icon = "entities/ammo.shotgun.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "12G"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function(wep,stat) return 210/14 end,
		["NumShots"] = function(wep,stat) return 14 end,
	},
	["LuaShellModel"] = "models/weapons/darky_m/rust/shotgun_shell_red.mdl",

	["MaterialTable_V"] = function(wep,stat) return {[wep.ShellMaterial] = "models/darky_m/rust_weapons/sawnoffshotgun/Shotgunshell"} end,

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
