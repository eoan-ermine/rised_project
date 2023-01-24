-- "lua\\tfa\\att\\darky_rust_9inc.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Incendiary Pistol Bullet"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
	TFA.AttachmentColors["="], "Slower moving ammunition that deals fire damage. There's a small chance it will start a fire.",
	TFA.AttachmentColors["+"], "12% more damage",
	TFA.AttachmentColors["-"], "25% less velocity",
}

ATTACHMENT.Icon = "entities/ammo.pistol.fire.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "INC"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function(wep,stat) return stat*1.12 end,
		["Range"] = function(wep,stat) return stat*0.75 end,
		["RangeFalloff"] = function(wep,stat) return stat*0.75 end,
	},
}


function ATTACHMENT:Attach(wep)
	wep:Unload()

	wep.CustomBulletCallback = function(ply, trace, dmginfo)
		if CLIENT then return end
		if math.random(1,10)>8 and not trace.HitSky then
			timer.Simple(0, function()
				local i = ents.Create("rust_fire_ent")
				if i:IsValid() then
					i:SetPos(trace.HitPos)
					i:Spawn()
					i:GetPhysicsObject():SetVelocity(Vector(trace.HitNormal)*102)
					ParticleEffectAttach("rust_fire_ent", PATTACH_ABSORIGIN_FOLLOW, i, 0)
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
