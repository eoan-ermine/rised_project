-- "lua\\tfa\\external\\ins2_sounds.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
TFA.INS2 = TFA.INS2 or {}

-- Universal
TFA.AddWeaponSound("TFA_INS2.PistolDraw", {"weapons/ins2/uni/uni_pistol_draw_01.wav", "weapons/ins2/uni/uni_pistol_draw_02.wav", "weapons/ins2/uni/uni_pistol_draw_03.wav" } ) --, "weapons/ins2/uni/bash1.wav"})
TFA.AddWeaponSound("TFA_INS2.PistolHolster", "weapons/ins2/uni/uni_pistol_holster.wav")
TFA.AddWeaponSound("TFA_INS2.Draw", {"weapons/ins2/uni/uni_weapon_draw_01.wav", "weapons/ins2/uni/uni_weapon_draw_02.wav", "weapons/ins2/uni/uni_weapon_draw_03.wav" } ) --, "weapons/ins2/uni/bash1.wav"})
TFA.AddWeaponSound("TFA_INS2.Holster", "weapons/ins2/uni/uni_weapon_holster.wav")

TFA.AddWeaponSound("TFA_INS2.IronIn", {"weapons/ins2/uni/uni_ads_in_01.wav", "weapons/ins2/uni/uni_ads_in_02.wav", "weapons/ins2/uni/uni_ads_in_03.wav", "weapons/ins2/uni/uni_ads_in_04.wav", "weapons/ins2/uni/uni_ads_in_05.wav", "weapons/ins2/uni/uni_ads_in_06.wav" } )
TFA.AddWeaponSound("TFA_INS2.IronOut", "weapons/ins2/uni/uni_ads_out_01.wav")
TFA.AddWeaponSound("TFA_INS2.LeanIn", {"weapons/ins2/uni/uni_lean_in_01.wav", "weapons/ins2/uni/uni_lean_in_02.wav", "weapons/ins2/uni/uni_lean_in_03.wav", "weapons/ins2/uni/uni_lean_in_04.wav" } )

TFA.AddWeaponSound("TFA_INS2.GLBeginReload", {"weapons/ins2/uni/uni_gl_beginreload_01.wav", "weapons/ins2/uni/uni_gl_beginreload_02.wav", "weapons/ins2/uni/uni_gl_beginreload_03.wav" } )

-- GP30
TFA.AddFireSound("TFA_INS2_GP30.1", "weapons/ins2/gp30/gp30_fp.wav", true, ")" )
TFA.AddWeaponSound("TFA_INS2_GP30.Deselect", "weapons/ins2/gp30/handling/gp30_deselect.wav" )
TFA.AddWeaponSound("TFA_INS2_GP30.Select", "weapons/ins2/gp30/handling/gp30_select.wav" )
TFA.AddWeaponSound("TFA_INS2_GP30.GrenadeIn", { "weapons/ins2/gp30/handling/gp30_insertgrenade_01.wav", "weapons/ins2/gp30/handling/gp30_insertgrenade_02.wav" } )
TFA.AddWeaponSound("TFA_INS2_GP30.GrenadeInClick", "weapons/ins2/gp30/handling/gp30_insertgrenade_click.wav" )
TFA.AddWeaponSound("TFA_INS2_GP30.Empty", "weapons/ins2/gp30/handling/gp30_empty.wav" )

-- M203

TFA.AddFireSound("TFA_INS2_M203.1", "weapons/ins2/m203/m203_fp.wav", true, ")")
TFA.AddWeaponSound("TFA_INS2_M203.Deselect", "weapons/ins2/m203/handling/m203_deselect.wav")
TFA.AddWeaponSound("TFA_INS2_M203.Select", "weapons/ins2/m203/handling/m203_select.wav")
TFA.AddWeaponSound("TFA_INS2_M203.Empty", "weapons/ins2/m203/handling/m203_empty.wav")
TFA.AddWeaponSound("TFA_INS2_M203.GrenadeIn", {"weapons/ins2/m203/handling/m203_insertgrenade_01.wav", "weapons/ins2/m203/handling/m203_insertgrenade_02.wav"})
TFA.AddWeaponSound("TFA_INS2_M203.CloseBarrel", "weapons/ins2/m203/handling/m203_closebarrel.wav")
TFA.AddWeaponSound("TFA_INS2_M203.OpenBarrel", "weapons/ins2/m203/handling/m203_openbarrel.wav")

-- Flashlight
TFA.AddSound("TFA_INS2.FlashlightOn", CHAN_ITEM, 0.2, 75, 100, "weapons/ins2/player/flashlight_on.wav")
TFA.AddSound("TFA_INS2.FlashlightOff", CHAN_ITEM, 0.2, 75, 100, "weapons/ins2/player/flashlight_off.wav")