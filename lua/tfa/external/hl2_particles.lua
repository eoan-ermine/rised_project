-- "lua\\tfa\\external\\hl2_particles.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
MMODParticleFiles = {}
table.insert(MMODParticleFiles, #MMODParticleFiles, "hl2mmod_explosions")
table.insert(MMODParticleFiles, #MMODParticleFiles, "hl2mmod_muzzleflashes")
table.insert(MMODParticleFiles, #MMODParticleFiles, "hl2mmod_weaponeffects")

MMODParticleEffects = {}
table.insert(MMODParticleEffects, #MMODParticleEffects, "weapon_rpg_smoketrail_fire")
table.insert(MMODParticleEffects, #MMODParticleEffects, "weapon_rpg_smoketrail_firebase")
table.insert(MMODParticleEffects, #MMODParticleEffects, "weapon_rpg_smoketrail_firemid")
--MUZZLEFLASHES
table.insert(MMODParticleEffects, #MMODParticleEffects, "hl2mmod_muzzleflash_357")
table.insert(MMODParticleEffects, #MMODParticleEffects, "hl2mmod_muzzleflash_357_alt")
table.insert(MMODParticleEffects, #MMODParticleEffects, "hl2mmod_muzzleflash_ar2")
table.insert(MMODParticleEffects, #MMODParticleEffects, "hl2mmod_muzzleflash_ar2_alt")
table.insert(MMODParticleEffects, #MMODParticleEffects, "hl2mmod_muzzleflash_ar2_alt_charge") --Altattack charge, attached to Secondary (att 3)
table.insert(MMODParticleEffects, #MMODParticleEffects, "hl2mmod_muzzleflash_ar2_punch") --No idea, probably altattack muzzleflash, attached to punch (att 4)
table.insert(MMODParticleEffects, #MMODParticleEffects, "hl2mmod_muzzleflash_pistol")
table.insert(MMODParticleEffects, #MMODParticleEffects, "hl2mmod_muzzleflash_pistol_alt")
table.insert(MMODParticleEffects, #MMODParticleEffects, "hl2mmod_muzzleflash_rpg")
table.insert(MMODParticleEffects, #MMODParticleEffects, "hl2mmod_muzzleflash_shotgun")
table.insert(MMODParticleEffects, #MMODParticleEffects, "hl2mmod_muzzleflash_shotgun_alt")
table.insert(MMODParticleEffects, #MMODParticleEffects, "hl2mmod_muzzleflash_smg1")
table.insert(MMODParticleEffects, #MMODParticleEffects, "hl2mmod_muzzleflash_rpg")
--WEAPON FX
table.insert(MMODParticleEffects, #MMODParticleEffects, "hl2mmod_weapon_rpg_smoketrail")
table.insert(MMODParticleEffects, #MMODParticleEffects, "hl2mmod_weapon_rpg_ignite")
--EXPLOSIONS
table.insert(MMODParticleEffects, #MMODParticleEffects, "hl2mmod_explosion_rpg")
table.insert(MMODParticleEffects, #MMODParticleEffects, "hl2mmod_explosion_grenade_noaftersmoke")

for k, v in pairs(MMODParticleFiles) do
	game.AddParticles("particles/" .. v .. ".pcf")
end

for k, v in pairs(MMODParticleEffects) do
	PrecacheParticleSystem(v)
end