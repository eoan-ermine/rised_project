-- "lua\\tfa\\external\\tfa_ins2_izh43sw.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local path = "weapons/tfa_ins2/doublebarrel/"

TFA.AddFireSound("TFA_INS2_DOUBLEBARREL.1", path .. "doublebarrel_fire.wav", true, ")")
TFA.AddFireSound("TFA_INS2_DOUBLEBARREL.2", path .. "doublebarrel_suppressed.wav")

TFA.AddWeaponSound("Weapon_DOUBLEBARREL.Empty", path .. "doublebarrel_empty.wav")

TFA.AddWeaponSound("Weapon_DOUBLEBARREL.Magout", path .. "doublebarrel_magout.wav")
TFA.AddWeaponSound("Weapon_Doublebarrel.Shellinsert", { path .. "shellinsert1.wav", path .. "shellinsert2.wav" } )
TFA.AddWeaponSound("Weapon_Doublebarrel.Ejectshell", path .. "shelleject1.wav")
TFA.AddWeaponSound("doublebarrel.Draw", path .. "doublebarrel_draw.wav")
TFA.AddWeaponSound("Weapon_Doublebarrel.Ejectshells", path .. "shellseject.wav")
TFA.AddWeaponSound("Weapon_Doublebarrel.Openbarrel", path .. "breakopen.wav")
TFA.AddWeaponSound("Weapon_Doublebarrel.Closebarrel", path .. "breakclose.wav")
TFA.AddWeaponSound("doublebarrel.Holster", path .. "doublebarrel_draw.wav")