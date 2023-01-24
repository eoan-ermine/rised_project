-- "lua\\tfa\\external\\tfa_xm25_sounds.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local path = "weapons/tfa_xm25/"
local pref = "Weapon_TFA_XM25"
local hudcolor = Color(255, 255, 255, 255)

TFA.AddWeaponSound(pref .. ".Magrelease", path .. "mini14_magrelease.wav")
TFA.AddWeaponSound(pref .. ".Magout", path .. "mini14_magout.wav")
TFA.AddWeaponSound(pref .. ".Magin", path .. "mini14_magin.wav")
TFA.AddWeaponSound(pref .. ".Empty", path .. "mini14_empty.wav")
TFA.AddWeaponSound(pref .. ".Rattle", path .. "ak47_rattle.wav")

if killicon and killicon.Add then
	killicon.Add("tfa_ins2_xm25", "vgui/hud/tfa_ins2_xm25", hudcolor)
end