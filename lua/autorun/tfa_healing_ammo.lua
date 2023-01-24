-- "lua\\autorun\\tfa_healing_ammo.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if CLIENT then
language.Add("fas2_bandage_ammo", "Bandages") 
end


game.AddAmmoType( {
name = "fas2_bandage",
dmgtype = DMG_BULLET,
tracer = TRACER_LINE,
plydmg = 0,
npcdmg = 0,
force = 2000,
minsplash = 10,
maxsplash = 5
} )

if CLIENT then
language.Add("fas2_hemostat_ammo", "Hemostats") 
end


game.AddAmmoType( {
name = "fas2_hemostat",
dmgtype = DMG_BULLET,
tracer = TRACER_LINE,
plydmg = 0,
npcdmg = 0,
force = 2000,
minsplash = 10,
maxsplash = 5
} )