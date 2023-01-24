-- "lua\\tfa\\att\\darky_rust_556exp.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Explosive 5.56 Rifle Ammo"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "This ammo explodes on contact dealing a small amount of fragmentation damage to nearby objects.",
	TFA.AttachmentColors["-"], "40% less velocity",
}

ATTACHMENT.Icon = "entities/ammo.rifle.explosive.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "EXP"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Range"] = function(wep,stat) return stat*0.6 end,
		["RangeFalloff"] = function(wep,stat) return stat*0.6 end,
	},
}


function ATTACHMENT:Attach(wep)
	wep:Unload()

	wep.CustomBulletCallback = function(ply, trace, dmginfo)
		if CLIENT or game.SinglePlayer then 
			ParticleEffect("rust_explode", trace.HitPos+trace.HitNormal*10, Angle(0, 0, 0)) 
			return 
		end

		util.BlastDamageInfo(dmginfo, trace.HitPos, 80)

		if math.random(1,15)>13 and not trace.HitSky then
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
