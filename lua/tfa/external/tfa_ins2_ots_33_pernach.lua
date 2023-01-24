-- "lua\\tfa\\external\\tfa_ins2_ots_33_pernach.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local path = "/weapons/ots33/"
local pref = "TFA_INS2.OTS33"

TFA.AddFireSound(pref .. ".Fire", path .. "fire1.wav", true, ")")
TFA.AddFireSound(pref .. ".Fire_Suppressed", path .. "fire_suppressed.wav", false, ")")

TFA.AddWeaponSound(pref .. ".Safety", path .. "fireselect.wav")
TFA.AddWeaponSound(pref .. ".Boltback", path .. "slideback.wav")
TFA.AddWeaponSound(pref .. ".Boltrelease", path .. "sliderelease.wav")
TFA.AddWeaponSound(pref .. ".Empty", path .. "empty.wav")
TFA.AddWeaponSound(pref .. ".Magrelease", path .. "magrelease.wav")
TFA.AddWeaponSound(pref .. ".Magout", path .. "magout.wav")
TFA.AddWeaponSound(pref .. ".Magin", path .. "magin_2.wav")
TFA.AddWeaponSound(pref .. ".MagHit", path .. "sterling_maghit.wav")
TFA.AddWeaponSound(pref .. ".Boltslap", path .. "slidelock.wav")
TFA.AddWeaponSound(pref .. ".StockOpen", path .. "stockopen_01.wav")