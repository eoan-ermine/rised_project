-- "lua\\autorun\\darky_rust_explosives.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
game.AddParticles("particles/rust.pcf")
PrecacheParticleSystem("rust_fire")
PrecacheParticleSystem("rust_inc")
PrecacheParticleSystem("rust_fire_ent")
PrecacheParticleSystem("rust_fire_vm")
PrecacheParticleSystem("rust_explode")
PrecacheParticleSystem("rust_big_explosion")

CreateConVar( "tfa_rust_slowdown_onfire", 1, FCVAR_ARCHIVE, "slowdown players on fire", 0, 1 )
CreateConVar( "tfa_rust_rocket_trails", 1, FCVAR_ARCHIVE, "trailz", 0, 1 )

hook.Add("ShouldCollide", "DarkyTFA_Firecollide", function(ent1, ent2)
    if ent1:GetClass()=="rust_fire_ent" then
        if ent2:GetClass()=="rust_fire_ent" or ent2:IsPlayer() then 
            return false 
        end
    end
end)

if SERVER then
    hook.Add("Think","DarkyTFA_FireSpeed",function()
        for _, ply in ipairs(player.GetAll()) do
            if ply.RustSlowDown then
               if ply.RustSlowDown <= CurTime() then
                    ply:SetWalkSpeed(ply.RustWalkSpeed)
                    ply:SetRunSpeed(ply.RustRunSpeed)
                    ply.RustSlowDown = nil
                end
            end
        end
    end)
end

if game and game.AddAmmoType then
	game.AddAmmoType({ name = "rust_satchel" })
	game.AddAmmoType({ name = "rust_c4" })

	game.AddAmmoType({ name = "rust_f1" })
	game.AddAmmoType({ name = "rust_beancan" })
end

if language and language.Add then
	language.Add("rust_satchel_ammo", "Satchel Charge")
	language.Add("rust_c4_ammo", "Timed Explosive Charge")

	language.Add("rust_f1_ammo", "F1 Grenade")
	language.Add("rust_beancan_ammo", "Beancan Grenade")
end

-- if TFA and TFA.AddFireSound then
--     TFA.AddFireSound("TFA_RUST_SATCHEL", {"^weapons/rust_distant/satchel-charge-explosion-001.mp3", "^weapons/rust_distant/satchel-charge-explosion-002.mp3", "^weapons/rust_distant/satchel-charge-explosion-003.mp3","^weapons/rust_distant/satchel-charge-explosion-004.mp3"})
--     TFA.AddFireSound("TFA_RUST_C4", {"^weapons/rust_distant/c4-explosion-1.mp3", "^weapons/rust_distant/c4-explosion-2.mp3", "^weapons/rust_distant/c4-explosion-3.mp3","^weapons/rust_distant/c4-explosion-4.mp3"})
--     TFA.AddFireSound("TFA_RUST_RPG", {"^weapons/rust_distant/rocket_explosion-001.mp3", "^weapons/rust_distant/rocket_explosion-002.mp3", "^weapons/rust_distant/rocket_explosion-003.mp3","^weapons/rust_distant/rocket_explosion-004.mp3"})
-- end

if not DARKY_RUST then DARKY_RUST = {} end

DARKY_RUST.explosives = true

if not DARKY_RUST.firearms then 
    local gunshots = file.Find( "sound/weapons/rust_distant/*", "GAME" )
    local mp3s = file.Find( "sound/weapons/rust_mp3/*.mp3", "GAME" )
    local wavs = file.Find( "sound/weapons/rust/*.wav", "GAME" )

    for i=1, #mp3s do
        local snd = string.sub(mp3s[i],1,-5)
        sound.Add(
            {
                name = "darky_rust."..snd,
                channel = CHAN_STATIC,
                volume = 1.0,
                soundlevel = 180,
                sound = "weapons/rust_mp3/"..snd..".mp3"
            }
        )	
    end

    for i=1, #wavs do
        local snd = string.sub(wavs[i],1,-5)
        sound.Add(
            {
                name = "darky_rust."..snd,
                channel = CHAN_STATIC,
                volume = 1.0,
                soundlevel = 180,
                sound = "weapons/rust/"..snd..".wav"
            }
        )	
    end

    for i=1, #gunshots do
        local snd = string.sub(gunshots[i],1,-5)
        sound.Add(
            {
                name = "darky_rust."..snd,
                channel = CHAN_STATIC,
                volume = 1.0,
                soundlevel = 180,
                sound = "^weapons/rust_distant/"..snd..".mp3"
            }
        )	
    end
end

