-- "lua\\tfa\\att\\darky_rust_12incendiary.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "12 Gauge Incendiary Shell"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "Once fired, unlike any other shell, it will spew out flaming shotgun projectiles.",
	TFA.AttachmentColors["-"], "150 DMG",
	TFA.AttachmentColors["="], "100 Velocity",
	TFA.AttachmentColors["-"], "10 Pellets",
}

ATTACHMENT.Icon = "entities/ammo.shotgun.fire.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "INC"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function(wep,stat) return 150/10 end,
		["NumShots"] = function(wep,stat) return 10 end,
	},
	["LuaShellModel"] = "models/weapons/darky_m/rust/shotgun_shell_blue.mdl",

	["MaterialTable_V"] = function(wep,stat) return {[wep.ShellMaterial] = "models/darky_m/rust_weapons/sawnoffshotgun/Shotgunshell_blue"} end,
}


function ATTACHMENT:Attach(wep)
	wep:Unload()

	wep.CustomBulletCallback = function(ply, trace, dmginfo)
		if CLIENT then return end
		if math.random(1,10)>6 and not trace.HitSky then
			timer.Simple(0, function()
				local i = ents.Create("rust_fire_ent")
				if i:IsValid() then
					i:SetPos(trace.HitPos)
					i:Spawn()
					i:GetPhysicsObject():SetVelocity(Vector(trace.HitNormal)*102)
					ParticleEffectAttach("rust_inc", PATTACH_ABSORIGIN_FOLLOW, i, 0)
				end
			end)
		end
	end
end

function ATTACHMENT:Detach(wep)
	wep:Unload()
	wep.CustomBulletCallback = function(ply, trace, dmginfo) end
end



if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
