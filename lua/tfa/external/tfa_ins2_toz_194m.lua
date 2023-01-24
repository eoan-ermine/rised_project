-- "lua\\tfa\\external\\tfa_ins2_toz_194m.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local path = "/weapons/toz-194m/"
local pref = "TFA_INS2.Toz_194M"

TFA.AddFireSound(pref .. ".Fire", {path .. "toz_194m_fire_1.wav", path .. "toz_194m_fire_2.wav", path .. "toz_194m_fire_3.wav"}, true, ")")
TFA.AddFireSound(pref .. ".Fire_Suppressed", {path .. "toz_194m_suppressed.wav"})

TFA.AddWeaponSound(pref .. ".Draw", path .. "toz_194m_draw.wav")

TFA.AddWeaponSound(pref .. ".Boltback", path .. "toz_194m_pumpback.wav")
TFA.AddWeaponSound(pref .. ".Boltrelease", path .. "toz_194m_pumpforward.wav")
TFA.AddWeaponSound(pref .. ".Empty", path .. "toz_194m_empty.wav")
TFA.AddWeaponSound(pref .. ".ShellInsert", {path .. "toz_194m_shell_insert_1.wav", path .. "toz_194m_shell_insert_2.wav", path .. "toz_194m_shell_insert_3.wav"})
TFA.AddWeaponSound(pref .. ".ShellInsertSingle", {path .. "toz_194m_single_shell_insert_1.wav", path .. "toz_194m_single_shell_insert_2.wav", path .. "toz_194m_single_shell_insert_3.wav"})