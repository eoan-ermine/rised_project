-- "lua\\tfa\\external\\tfa_ins2_fn_fal.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local path = "/weapons/fal/"
local pref = "TFA_INS2.FAL"

TFA.AddFireSound(pref .. ".Fire", path .. "fnfal_fire.wav", true, ")")
TFA.AddFireSound(pref .. ".Fire_Suppressed", path .. "fnfal_suppressed.wav", false, ")")

TFA.AddWeaponSound(pref .. ".Draw", path .. "fnfal_draw.wav")
TFA.AddWeaponSound(pref .. ".Boltback", path .. "fnfal_boltback.wav")
TFA.AddWeaponSound(pref .. ".Boltrelease", path .. "fnfal_boltrelease.wav")
TFA.AddWeaponSound(pref .. ".Empty", path .. "fnfal_empty.wav")
TFA.AddWeaponSound(pref .. ".Magout", path .. "fnfal_magout.wav")
TFA.AddWeaponSound(pref .. ".Magin", path .. "fnfal_magin.wav")
TFA.AddWeaponSound(pref .. ".ROF", path .. "fnfal_rof.wav")
