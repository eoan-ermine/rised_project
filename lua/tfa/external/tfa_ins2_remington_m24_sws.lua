-- "lua\\tfa\\external\\tfa_ins2_remington_m24_sws.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local path = "weapons/m24sws/"
local pref = "TFA_INS2.M24SWS"

TFA.AddFireSound(pref .. ".Fire", path .. "m24_shoot_default.wav", true, ")")
TFA.AddFireSound( pref .. ".Fire_Suppressed", { path .. "m24_shoot_suppressed.wav" })

TFA.AddWeaponSound( pref .. ".Boltback", path .. "m24_bolt_back.wav" )
TFA.AddWeaponSound( pref .. ".Boltrelease", path .. "m24_boltrelease.wav" )
TFA.AddWeaponSound( pref .. ".Boltforward", path .. "m24_bolt_forward.wav" )
TFA.AddWeaponSound( pref .. ".Boltlatch", path .. "m24_bolt_up.wav" )
TFA.AddWeaponSound( pref .. ".Roundin", { path .. "m24_bulletin_1.wav", path .. "m24_bulletin_2.wav", path .. "m24_bulletin_3.wav", path .. "m24_bulletin_4.wav" } )
TFA.AddWeaponSound( pref .. ".Empty", path .. "m24_empty.wav")
TFA.AddWeaponSound( pref .. ".Draw", path .. "m24_deploy.wav")
