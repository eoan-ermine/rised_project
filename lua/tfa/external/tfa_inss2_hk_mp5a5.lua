-- "lua\\tfa\\external\\tfa_inss2_hk_mp5a5.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local path = "/weapons/inss_mp5a5/"
local pref = "TFA_INS2.INSS_MP5A5"

TFA.AddFireSound(pref .. ".Fire", {path .. "inss_mp5k_fp.wav"}, true, ")")
TFA.AddFireSound(pref .. ".Fire_Suppressed", {path .. "inss_mp5k_suppressed_fp.wav"})

TFA.AddWeaponSound(pref .. ".Boltback", path .. "boltback.wav")
TFA.AddWeaponSound(pref .. ".Boltlock", path .. "boltlock.wav")
TFA.AddWeaponSound(pref .. ".Boltrelease", path .. "boltrelease.wav")
TFA.AddWeaponSound(pref .. ".Magrelease", path .. "magrelease.wav")
TFA.AddWeaponSound(pref .. ".Magout", path .. "Kry_MP5_magout.wav")
TFA.AddWeaponSound(pref .. ".Magin", path .. "Kry_MP5_magin.wav")

TFA.AddWeaponSound(pref .. ".ROF", path .. "inss_mp5k_fireselect.wav")
TFA.AddWeaponSound(pref .. ".Empty", path .. "inss_mp5k_empty.wav")