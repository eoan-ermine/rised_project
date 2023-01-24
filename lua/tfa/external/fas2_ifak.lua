-- "lua\\tfa\\external\\fas2_ifak.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local path = "weapons/tfa_fas2/ifak/"
local pref = "TFA_FAS2.IFAK"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddWeaponSound(pref .. ".Success", path .. "heal_success.wav")

TFA.AddWeaponSound(pref .. ".BandageRetrieve", path .. "bandage_open.wav")
TFA.AddWeaponSound(pref .. ".BandageOpen", path .. "bandage_retrieve.wav")
TFA.AddWeaponSound(pref .. ".HemostatRetrieve", path .. "hemostat_retrieve.wav")
TFA.AddWeaponSound(pref .. ".HemostatClose", path .. "hemostat_close.wav")