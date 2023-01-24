-- "addons\\rised_weapons\\lua\\weapons\\swb_base\\sh_sounds.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

-----------------------------------------------------
--[[
You can use this function to create weapon sound scripts if you plan to make weapons with separate sounds
Example usage:
SWB_RegisterSound("ExampleSound", "path/to/example/sound.format", 100)

Supported formats: .wav, .mp3, .ogg
The 'level' argument indicates how far the sound will be audible.
The 'pstart' and 'pend' arguments dictate the random pitch that will be used when the sound is played.
]]--

function SWB_RegisterSound(n, s, l, pstart, pend)
	local tbl = {channel = CHAN_STATIC,
		volume = 1,
		level = l,
		name = n,
		sound = s,
		pitchstart = pstart,
		pitchend = pend}
	
	sound.Add(tbl)
end

SWB_RegisterSound("SWB_Empty", "weapons/shotgun/shotgun_empty.wav", 60, 95, 112)
SWB_RegisterSound("SWB_Knife_Hit", {"weapons/knife/knife_hit1.wav", "weapons/knife/knife_hit2.wav", "weapons/knife/knife_hit3.wav", "weapons/knife/knife_hit4.wav"}, 70, 92, 122)
SWB_RegisterSound("SWB_Knife_HitElse", "weapons/knife/knife_hitwall1.wav", 70, 92, 122)
SWB_RegisterSound("SWB_Knife_Swing", {"weapons/knife/knife_slash1.wav", "weapons/knife/knife_slash2.wav"}, 65, 92, 122)

SWB_RegisterSound("Magazine.Out", "sniper_military_slideback_1.wav", 65, 92, 122)
SWB_RegisterSound("Magazine.In", "sniper_military_slideforward_1.wav", 65, 92, 122)

SWB_RegisterSound("0", "awp_bolt.wav", 65, 92, 122)
SWB_RegisterSound("1", "ar2_reload_rotate.wav", 65, 92, 122)
SWB_RegisterSound("2", "ar2_reload_push.wav", 65, 92, 122)

SWB_RegisterSound("Weapon_Mosin.Boltback", "weapons/tfa_ins2/mosin/mosin_boltback.wav", 65, 92, 122)
SWB_RegisterSound("Weapon_Mosin.Boltrelease", "weapons/tfa_ins2/mosin/mosin_boltrelease.wav", 65, 92, 122)
SWB_RegisterSound("Weapon_Mosin.Boltforward", "weapons/tfa_ins2/mosin/mosin_boltforward.wav", 65, 92, 122)
SWB_RegisterSound("Weapon_Mosin.Boltlatch", "weapons/tfa_ins2/mosin/mosin_boltlatch.wav", 65, 92, 122)
SWB_RegisterSound("Weapon_Mosin.Roundin", {"weapons/tfa_ins2/mosin/mosin_bulletin_1.wav", "weapons/tfa_ins2/mosin/mosin_bulletin_2.wav", "weapons/tfa_ins2/mosin/mosin_bulletin_3.wav", "weapons/tfa_ins2/mosin/mosin_bulletin_4.wav",}, 65, 92, 122)
SWB_RegisterSound("Weapon_Mosin.Empty", "weapons/tfa_ins2/mosin/mosin_empty.wav", 65, 92, 122)
SWB_RegisterSound("mosin.Draw", "weapons/tfa_ins2/mosin/mosin_draw.wav", 65, 92, 122)
SWB_RegisterSound("mosin.Holster", "weapons/tfa_ins2/mosin/mosin_draw.wav", 65, 92, 122)


SWB_RegisterSound("Weapon_asval.Empty", "weapons/tfa_ins2/asval/asval_empty.wav", 65, 92, 122)
SWB_RegisterSound("Weapon_asval.Magout", "weapons/tfa_ins2/asval/asval_magout.wav", 65, 92, 122)
SWB_RegisterSound("Weapon_asval.Magin", "weapons/tfa_ins2/asval/asval_magin.wav", 65, 92, 122)
SWB_RegisterSound("Weapon_asval.Boltback", "weapons/tfa_ins2/asval/asval_boltback.wav", 65, 92, 122)
SWB_RegisterSound("Weapon_asval.Boltrelease", "weapons/tfa_ins2/asval/asval_boltrelease.wav", 65, 92, 122)
SWB_RegisterSound("Weapon_asval.ROF", "weapons/tfa_ins2/asval/asval_fireselect_1.wav", 65, 92, 122)
SWB_RegisterSound("Weapon_asval.Draw", "weapons/tfa_ins2/asval/asval_draw.wav", 65, 92, 122)
SWB_RegisterSound("Weapon_asval.Holster", "weapons/tfa_ins2/asval/asval_draw.wav", 65, 92, 122)


SWB_RegisterSound("Weapon_SVD.Empty", "weapons/tfa_ins2/svd/rpk_empty.wav", 65, 92, 122)
SWB_RegisterSound("Weapon_SVD.Magout", "weapons/tfa_ins2/svd/svd_magout.wav", 65, 92, 122)
SWB_RegisterSound("Weapon_SVD.Magin", "weapons/tfa_ins2/svd/svd_magin.wav", 65, 92, 122)
SWB_RegisterSound("Weapon_SVD.Boltback", "weapons/tfa_ins2/svd/svd_boltback.wav", 65, 92, 122)
SWB_RegisterSound("Weapon_SVD.Boltrelease", "weapons/tfa_ins2/svd/svd_boltrelease.wav", 65, 92, 122)
SWB_RegisterSound("Weapon_SVD.Magrelease", "weapons/tfa_ins2/svd/svd_magrelease.wav", 65, 92, 122)
SWB_RegisterSound("Weapon_SVD.ROF", "weapons/tfa_ins2/svd/svd_fireselect_1.wav", 65, 92, 122)
SWB_RegisterSound("svd.Draw", "weapons/tfa_ins2/svd/svd_draw.wav", 65, 92, 122)
SWB_RegisterSound("svd.Holster", "weapons/tfa_ins2/svd/svd_draw.wav", 65, 92, 122)


SWB_RegisterSound("svd.Holster", "weapons/tfa_ins2/svd/svd_draw.wav", 65, 92, 122)

SWB_RegisterSound("TFA_INS2.Toz_194M.Draw", "/weapons/toz-194m/toz_194m_draw.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.Toz_194M.Boltback", "/weapons/toz-194m/toz_194m_pumpback.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.Toz_194M.Boltrelease", "/weapons/toz-194m/toz_194m_pumpforward.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.Toz_194M.Empty", "/weapons/toz-194m/toz_194m_empty.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.Toz_194M.ShellInsert", {"/weapons/toz-194m/toz_194m_shell_insert_1.wav", "/weapons/toz-194m/toz_194m_shell_insert_2.wav", "/weapons/toz-194m/toz_194m_shell_insert_3.wav"}, 65, 92, 122)
SWB_RegisterSound("TFA_INS2.Toz_194M.ShellInsertSingle", {"/weapons/toz-194m/toz_194m_single_shell_insert_1.wav", "/weapons/toz-194m/toz_194m_single_shell_insert_2.wav", "/weapons/toz-194m/toz_194m_single_shell_insert_3.wav"}, 65, 92, 122)


SWB_RegisterSound("Weapon_DOUBLEBARREL.Empty", "weapons/tfa_ins2/doublebarrel/doublebarrel_empty.wav", 65, 92, 122)
SWB_RegisterSound("Weapon_DOUBLEBARREL.Magout", "weapons/tfa_ins2/doublebarrel/doublebarrel_magout.wav", 65, 92, 122)
SWB_RegisterSound("Weapon_DOUBLEBARREL.Shellinsert", {"weapons/tfa_ins2/doublebarrel/shellinsert1.wav", "weapons/tfa_ins2/doublebarrel/shellinsert2.wav"}, 65, 92, 122)
SWB_RegisterSound("Weapon_DOUBLEBARREL.Ejectshell", "weapons/tfa_ins2/doublebarrel/shelleject1.wav", 65, 92, 122)
SWB_RegisterSound("Weapon_DOUBLEBARREL.Ejectshells", "weapons/tfa_ins2/doublebarrel/shellseject.wav", 65, 92, 122)
SWB_RegisterSound("Weapon_DOUBLEBARREL.Openbarrel", "weapons/tfa_ins2/doublebarrel/breakopen.wav", 65, 92, 122)
SWB_RegisterSound("Weapon_DOUBLEBARREL.Closebarrel", "weapons/tfa_ins2/doublebarrel/breakclose.wav", 65, 92, 122)
SWB_RegisterSound("doublebarrel.Draw", "weapons/tfa_ins2/doublebarrel/doublebarrel_draw.wav", 65, 92, 122)
SWB_RegisterSound("doublebarrel.Holster", "weapons/tfa_ins2/doublebarrel/doublebarrel_draw.wav", 65, 92, 122)


SWB_RegisterSound("Weapon_GSH18_TFA.Empty", "weapons/tfa_ins2_gsh18/makarov_empty.wav", 65, 92, 122)
SWB_RegisterSound("Weapon_GSH18_TFA.Magrelease", "weapons/tfa_ins2_gsh18/makarov_magrelease.wav", 65, 92, 122)
SWB_RegisterSound("Weapon_GSH18_TFA.Magin", "weapons/tfa_ins2_gsh18/makarov_magin.wav", 65, 92, 122)
SWB_RegisterSound("Weapon_GSH18_TFA.Magout", "weapons/tfa_ins2_gsh18/makarov_magout.wav", 65, 92, 122)
SWB_RegisterSound("Weapon_GSH18_TFA.Boltback", "weapons/tfa_ins2_gsh18/makarov_boltback.wav", 65, 92, 122)
SWB_RegisterSound("Weapon_GSH18_TFA.Boltrelease", "weapons/tfa_ins2_gsh18/makarov_boltrelease.wav", 65, 92, 122)
SWB_RegisterSound("Weapon_GSH18_TFA.Magrelease", "weapons/tfa_ins2_gsh18/makarov_magrelease.wav", 65, 92, 122)
SWB_RegisterSound("Weapon_GSH18_TFA.MagHit", "weapons/tfa_ins2_gsh18/makarov_maghit.wav", 65, 92, 122)


SWB_RegisterSound("TFA_INS2_RPK74M.Draw", "weapons/rpk74m/rpk_weapon_draw_03.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2_RPK74M.Empty", "weapons/rpk74m/rpk_empty.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2_RPK74M.ROF", "weapons/rpk74m/rpk_fireselect_1.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2_RPK74M.MagRelease", "weapons/rpk74m/rpk_magrelease.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2_RPK74M.Magout", "weapons/rpk74m/rpk_magout.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2_RPK74M.FetchMag", "weapons/rpk74m/rpk_fetchmag.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2_RPK74M.Rattle", "weapons/rpk74m/rpk_rattle.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2_RPK74M.Magin", "weapons/rpk74m/rpk_magin.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2_RPK74M.Boltback", "weapons/rpk74m/rpk_boltback.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2_RPK74M.Boltrelease", "weapons/rpk74m/rpk_boltrelease.wav", 65, 92, 122)

SWB_RegisterSound("TFA_L4D2_CTM200.1", "weapons/tfa_l4d2/ct_m200/gunfire/awp1.wav", 65, 92, 122)
SWB_RegisterSound("TFA_L4D2_CTM200.Deploy", "weapons/tfa_l4d2/ct_m200/gunother/awp_deploy.wav", 65, 92, 122)
SWB_RegisterSound("TFA_L4D2_CTM200.Clipout", "weapons/tfa_l4d2/ct_m200/gunother/awp_clipin.wav", 65, 92, 122)
SWB_RegisterSound("TFA_L4D2_CTM200.Clipin", "weapons/tfa_l4d2/ct_m200/gunother/awp_clipout.wav", 65, 92, 122)
SWB_RegisterSound("TFA_L4D2_CTM200.Bolt", "weapons/tfa_l4d2/ct_m200/gunother/awp_bolt.wav", 65, 92, 122)
SWB_RegisterSound("TFA_L4D2_CTM200.BoltForward", "weapons/tfa_l4d2/ct_m200/gunother/awp_bolt_forward.wav", 65, 92, 122)

SWB_RegisterSound("TFA_INS2_AKZ.1", "weapons/tfa_ins2/akz/ak47_fp.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2_AKZ.Empty", "weapons/tfa_ins2/akz/ak47_empty.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2_AKZ.ROF", "weapons/tfa_ins2/akz/ak47_fireselect_1.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2_AKZ.MagRelease", "weapons/tfa_ins2/akz/ak47_magrelease.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2_AKZ.Magout", "weapons/tfa_ins2/akz/ak47_magout.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2_AKZ.Rattle", "weapons/tfa_ins2/akz/ak47_rattle.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2_AKZ.Magin", "weapons/tfa_ins2/akz/ak47_magin.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2_AKZ.Boltback", "weapons/tfa_ins2/akz/ak47_boltback.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2_AKZ.Boltrelease", "weapons/tfa_ins2/akz/ak47_boltrelease.wav", 65, 92, 122)

SWB_RegisterSound("TFA_INS2.CZ75_SP01.Fire", "weapons/cz75_sp01/cz75_fp.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.CZ75_SP01.Safety", "weapons/cz75_sp01/cz75_safety.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.CZ75_SP01.Boltback", "weapons/cz75_sp01/cz75_boltback.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.CZ75_SP01.Boltrelease", "weapons/cz75_sp01/cz75_boltrelease.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.CZ75_SP01.Empty", "weapons/cz75_sp01/cz75_empty.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.CZ75_SP01.Magrelease", "weapons/cz75_sp01/cz75_magrelease.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.CZ75_SP01.Magout", "weapons/cz75_sp01/cz75_magout.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.CZ75_SP01.Magin", "weapons/cz75_sp01/cz75_magin.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.CZ75_SP01.MagHit", "weapons/cz75_sp01/cz75_maghit.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.CZ75_SP01.Boltslap", "weapons/cz75_sp01/cz75_boltslap.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.CZ75_SP01.Cloth", "weapons/cz75_sp01/cloth.wav", 65, 92, 122)

SWB_RegisterSound("TFA_INS2_SPAS12.1", "weapons/tfa_ins2/spas12/fire.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2_SPAS12.Draw", "weapons/tfa_ins2/spas12/uni_weapon_draw_01.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2_SPAS12.Holster", "weapons/tfa_ins2/spas12/uni_weapon_holster.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2_SPAS12.Boltback", "weapons/tfa_ins2/spas12/PumpBack.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2_SPAS12.Boltrelease", "weapons/tfa_ins2/spas12/PumpForward.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2_SPAS12.ShellInsert", "weapons/tfa_ins2/spas12/insertshell-1.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2_SPAS12.ShellInsertSingle", "weapons/tfa_ins2/spas12/insertshell-1.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2_SPAS12.Empty", "weapons/tfa_ins2/spas12/m590_empty.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2_SPAS12.IronIn", "weapons/tfa_ins2/spas12/uni_ads_in_01.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2_SPAS12.IronOut", "weapons/tfa_ins2/spas12/uni_ads_out_01.wav", 65, 92, 122)

SWB_RegisterSound("TFA_INS2.USP_M.1", "/weapons/tfa_ins2/usp_match/usp_unsil-1.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.USP_M.Empty", "/weapons/tfa_ins2/usp_match/usp_match_empty.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.USP_M.Boltback", "/weapons/tfa_ins2/usp_match/usp_match_boltback.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.USP_M.Boltrelease", "/weapons/tfa_ins2/usp_match/usp_match_boltrelease.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.USP_M.Magrelease", "/weapons/tfa_ins2/usp_match/usp_match_magrelease.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.USP_M.Magout", "/weapons/tfa_ins2/usp_match/usp_match_magout.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.USP_M.Magin", "/weapons/tfa_ins2/usp_match/usp_match_magin.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.USP_M.MagHit", "/weapons/tfa_ins2/usp_match/usp_match_maghit.wav", 65, 92, 122)

SWB_RegisterSound("TFA_INS2.MP7.1", "weapons/tfa_ins2/mp7/fp.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.MP7.Empty", "weapons/tfa_ins2/mp7/empty.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.MP7.Boltback", "weapons/tfa_ins2/mp7/boltback.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.MP7.Boltrelease", "weapons/tfa_ins2/mp7/boltrelease.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.MP7.Magrelease", "weapons/tfa_ins2/mp7/magrelease.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.MP7.Magout", "weapons/tfa_ins2/mp7/magout.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.MP7.Magin", "weapons/tfa_ins2/mp7/magin.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.MP7.ROF", "weapons/tfa_ins2/mp7/fireselect.wav", 65, 92, 122)

SWB_RegisterSound("TFA_INS2.INSS_MP5A5.Fire", "weapons/inss_mp5a5/inss_mp5k_fp.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.INSS_MP5A5.Fire_Suppressed", "weapons/inss_mp5a5/inss_mp5k_suppressed_fp.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.INSS_MP5A5.Boltback", "weapons/inss_mp5a5/boltback.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.INSS_MP5A5.Boltlock", "weapons/inss_mp5a5/boltlock.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.INSS_MP5A5.Boltrelease", "weapons/inss_mp5a5/boltrelease.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.INSS_MP5A5.Magrelease", "weapons/inss_mp5a5/magrelease.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.INSS_MP5A5.Magout", "weapons/inss_mp5a5/Kry_MP5_magout.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.INSS_MP5A5.Magin", "weapons/inss_mp5a5/Kry_MP5_magin.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.INSS_MP5A5.ROF", "weapons/inss_mp5a5/inss_mp5k_fireselect.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.INSS_MP5A5.Empty", "weapons/inss_mp5a5/inss_mp5k_empty.wav", 65, 92, 122)

SWB_RegisterSound("TFA_INS2.DEAGLE.1", "weapons/tfa_ins2/deagle/de_single.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.DEAGLE.2", "weapons/tfa_ins2/deagle/de_single_silenced.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.DEAGLE.Boltback", "weapons/tfa_ins2/deagle/handling/deagle_boltback.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.DEAGLE.Boltrelease", "weapons/tfa_ins2/deagle/handling/deagle_boltrelease.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.DEAGLE.Boltslap", "weapons/tfa_ins2/deagle/handling/deagle_boltslap.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.DEAGLE.Boltbackslap", "weapons/tfa_ins2/deagle/handling/deagle_boltbackslap.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.DEAGLE.Empty", "weapons/tfa_ins2/deagle/handling/deagle_empty.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.DEAGLE.Magrelease", "weapons/tfa_ins2/deagle/handling/deagle_magrelease.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.DEAGLE.Magout", "weapons/tfa_ins2/deagle/handling/deagle_magout.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.DEAGLE.Magin", "weapons/tfa_ins2/deagle/handling/deagle_magin.wav", 65, 92, 122)
SWB_RegisterSound("TFA_INS2.DEAGLE.MagHit", "weapons/tfa_ins2/deagle/handling/deagle_maghit.wav", 65, 92, 122)



sound.Add(
{
    name = "Weapon_AK74.Single",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = SNDLVL_GUNFIRE,
    sound = "weapons/ak74/AK74_tp.wav"
})
sound.Add(
{
    name = "Weapon_AK74.MagRelease",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/ak74/handling/AK74_magrelease.wav"
})
sound.Add(
{
    name = "Weapon_AK74.Magin",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/ak74/handling/AK74_magin.wav"
})
sound.Add(
{
    name = "Weapon_AK74.Magout",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/ak74/handling/AK74_magout.wav"
})
sound.Add(
{
    name = "Weapon_AK74.MagoutRattle",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/ak74/handling/AK74_magout_rattle.wav"
})
sound.Add(
{
    name = "Weapon_AK74.Rattle",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/ak74/handling/AK74_rattle.wav"
})
sound.Add(
{
    name = "Weapon_AK74.Boltback",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/ak74/handling/AK74_boltback.wav"
})
sound.Add(
{
    name = "Weapon_AK74.Boltrelease",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/ak74/handling/AK74_boltrelease.wav"
})
sound.Add(
{
    name = "Weapon_AK74.ROF",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/ak74/handling/AK74_fireselect_1.wav"
})

sound.Add(
{
name = "Weapon_INS_Makarov.Single",
channel = CHAN_WEAPON,
volume = 1,
level = 75,
sound = "ins/weapons/makarov/makarov-01.wav"
} )
sound.Add(
{
name = "Weapon_INS_Makarov.Echo",
channel = CHAN_STATIC,
volume = 1,
level = 150,
sound = "ins/weapons/makarov/makarov-01_echo.wav"
} )
sound.Add(
{
name = "Weapon_INS_Makarov.Magin",
channel = CHAN_ITEM,
volume = 1,
level = 75,
sound = "ins/weapons/makarov/makarov-magin.wav"
} )
sound.Add(
{
name = "Weapon_INS_Makarov.Magout",
channel = CHAN_ITEM,
volume = 1,
level = 75,
sound = "ins/weapons/makarov/makarov-magout.wav"
} )
sound.Add(
{
name = "Weapon_INS_Makarov.SlideForward",
channel = CHAN_ITEM,
volume = 1,
level = 75,
sound = "ins/weapons/makarov/makarov-slideforward.wav"
} )
sound.Add(
{
name = "Weapon_INS_Makarov.SlideBack",
channel = CHAN_ITEM,
volume = 1,
level = 75,
sound = "ins/weapons/makarov/makarov-slideback.wav"
} )
sound.Add(
{
name = "Weapon_INS_Makarov.Safety",
channel = CHAN_ITEM,
volume = 1,
level = 75,
sound = "ins/weapons/makarov/makarov-slideback.wav"
} )
sound.Add(
{
name = "Weapon_INS_Makarov.Empty",
channel = CHAN_ITEM,
volume = 1,
level = 75,
sound = "ins/weapons/makarov/makarov-empty.wav"
} )

sound.Add(
{
name = "Weapon_Tokarev.Boltback",
channel = CHAN_ITEM,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_nam_tokarev_tt33/tokarev_slideback.wav"
} )
sound.Add(
{
name = "Weapon_Tokarev.Boltrelease",
channel = CHAN_ITEM,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_nam_tokarev_tt33/tokarev_sliderelease.wav"
} )
sound.Add(
{
name = "Weapon_Tokarev.MagHit",
channel = CHAN_ITEM,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_nam_tokarev_tt33/tokarev_cliphit.wav"
} )
sound.Add(
{
name = "Weapon_Tokarev.Empty",
channel = CHAN_ITEM,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_nam_tokarev_tt33/tokarev_empty.wav"
} )
sound.Add(
{
name = "Weapon_Tokarev.Magrelease",
channel = CHAN_ITEM,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_nam_tokarev_tt33/tokarev_magrelease.wav"
} )
sound.Add(
{
name = "Weapon_Tokarev.Magout",
channel = CHAN_ITEM,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_nam_tokarev_tt33/tokarev_clipout.wav"
} )
sound.Add(
{
name = "Weapon_Tokarev.Magin",
channel = CHAN_ITEM,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_nam_tokarev_tt33/tokarev_clipin.wav"
} )

sound.Add(
{
    name = "Weapon_SKS.Single",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = SNDLVL_GUNFIRE,
    sound = "weapons/SKS/SKS_TP.wav"
})
sound.Add(
{
    name = "Weapon_SKS.Magrelease",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/SKS/handling/SKS_magrelease.wav"
})
sound.Add(
{
    name = "Weapon_SKS.Magin",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/SKS/handling/SKS_magin.wav"
})
sound.Add(
{
    name = "Weapon_SKS.Magout",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/SKS/handling/SKS_magout.wav"
})
sound.Add(
{
    name = "Weapon_SKS.Boltback",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/SKS/handling/SKS_boltback.wav"
})
sound.Add(
{
    name = "Weapon_SKS.Boltrelease",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/SKS/handling/SKS_boltrelease.wav"
})

sound.Add(
{
    name = "Weapon_AK74.Single",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = SNDLVL_GUNFIRE,
    sound = "weapons/ak74/AK74_tp.wav"
})
sound.Add(
{
    name = "Weapon_AK74.MagRelease",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/ak74/handling/AK74_magrelease.wav"
})
sound.Add(
{
    name = "Weapon_AK74.Magin",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/ak74/handling/AK74_magin.wav"
})
sound.Add(
{
    name = "Weapon_AK74.Magout",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/ak74/handling/AK74_magout.wav"
})
sound.Add(
{
    name = "Weapon_AK74.MagoutRattle",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/ak74/handling/AK74_magout_rattle.wav"
})
sound.Add(
{
    name = "Weapon_AK74.Rattle",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/ak74/handling/AK74_rattle.wav"
})
sound.Add(
{
    name = "Weapon_AK74.Boltback",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/ak74/handling/AK74_boltback.wav"
})
sound.Add(
{
    name = "Weapon_AK74.Boltrelease",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/ak74/handling/AK74_boltrelease.wav"
})
sound.Add(
{
    name = "Weapon_AK74.ROF",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/ak74/handling/AK74_fireselect_1.wav"
})


sound.Add({
	name = 			"Weapon_AWP.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/sv98/clipin.wav"
})

sound.Add({
	name = 			"Weapon_AWP.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/sv98/clipout.wav"
})

sound.Add({
	name = 			"Weapon_AWP.Clipout2",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/sv98/clipout2.wav"
})

sound.Add({
	name = 			"Weapon_AWP.Boltback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/sv98/boltback.wav"
})

sound.Add({
	name = 			"Weapon_AWP.Boltforward",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/sv98/boltforward.wav"
})

local soundData = {
    name                = "Mag.in" ,
    channel     = CHAN_WEAPON,
    volume              = 0.5,
    soundlevel  = 80,
    pitchstart  = 100,
    pitchend    = 100,
    sound               = "sniper_military_clip_in_1.wav"
}
sound.Add(soundData)

local soundData = {
    name                = "Mag.out" ,
    channel     = CHAN_WEAPON,
    volume              = 0.5,
    soundlevel  = 80,
    pitchstart  = 100,
    pitchend    = 100,
    sound               = "sniper_military_clip_out_1.wav"
}
sound.Add(soundData)

local soundData = {
    name                = "Draw.out" ,
    channel     = CHAN_WEAPON,
    volume              = 0.5,
    soundlevel  = 80,
    pitchstart  = 100,
    pitchend    = 100,
    sound               = "sniper_military_deploy_1.wav"
}
sound.Add(soundData)

local soundData = {
    name                = "Mag.inn" ,
    channel     = CHAN_WEAPON,
    volume              = 0.5,
    soundlevel  = 80,
    pitchstart  = 100,
    pitchend    = 100,
    sound               = "sniper_military_push_button_1.wav"
}
sound.Add(soundData)


local soundData = {
    name                = "Mag.in" ,
    channel     = CHAN_WEAPON,
    volume              = 0.5,
    soundlevel  = 80,
    pitchstart  = 100,
    pitchend    = 100,
    sound               = "sniper_military_clip_in_1.wav"
}
sound.Add(soundData)

local soundData = {
    name                = "Mag.out" ,
    channel     = CHAN_WEAPON,
    volume              = 0.5,
    soundlevel  = 80,
    pitchstart  = 100,
    pitchend    = 100,
    sound               = "sniper_military_clip_out_1.wav"
}
sound.Add(soundData)

local soundData = {
    name                = "Draw.out" ,
    channel     = CHAN_WEAPON,
    volume              = 0.5,
    soundlevel  = 80,
    pitchstart  = 100,
    pitchend    = 100,
    sound               = "sniper_military_deploy_1.wav"
}
sound.Add(soundData)

local soundData = {
    name                = "Mag.inn" ,
    channel     = CHAN_WEAPON,
    volume              = 0.5,
    soundlevel  = 80,
    pitchstart  = 100,
    pitchend    = 100,
    sound               = "sniper_military_push_button_1.wav"
}
sound.Add(soundData)

local soundData = {
    name                = "Slide.inn" ,
    channel     = CHAN_WEAPON,
    volume              = 0.5,
    soundlevel  = 80,
    pitchstart  = 100,
    pitchend    = 100,
    sound               = "sniper_military_slideforward_1.wav"
}
sound.Add(soundData)

local soundData = {
    name                = "Slide.back" ,
    channel     = CHAN_WEAPON,
    volume              = 0.5,
    soundlevel  = 80,
    pitchstart  = 100,
    pitchend    = 100,
    sound               = "sniper_military_slideback_1.wav"
}
sound.Add(soundData)

sound.Add(
{
name = "Weapon_M60.Boltback",
channel = CHAN_ITEM,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_nam_m60/m60_boltback.wav"
} )
sound.Add(
{
name = "Weapon_M60.Boltrelease",
channel = CHAN_ITEM,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_nam_m60/m60_boltrelease.wav"
} )
sound.Add(
{
name = "Weapon_M60.Shoulder",
channel = CHAN_ITEM,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_nam_m60/m60_shoulder.wav"
} )
sound.Add(
{
name = "Weapon_M60.ArmMovement_01",
channel = CHAN_ITEM,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_nam_m60/m60_armmovement_01.wav"
} )
sound.Add(
{
name = "Weapon_M60.ArmMovement_02",
channel = CHAN_ITEM,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_nam_m60/m60_armmovement_02.wav"
} )
sound.Add(
{
name = "Weapon_M60.Empty",
channel = CHAN_ITEM,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_nam_m60/m60_empty.wav"
} )
sound.Add(
{
name = "Weapon_M60.CoverOpen",
channel = CHAN_ITEM,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_nam_m60/m60_coveropen.wav"
} )
sound.Add(
{
name = "Weapon_M60.MagoutFull",
channel = CHAN_ITEM,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_nam_m60/m60_magout_full.wav"
} )
sound.Add(
{
name = "Weapon_M60.FetchMag",
channel = CHAN_ITEM,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_nam_m60/m60_fetchmag.wav"
} )
sound.Add(
{
name = "Weapon_M60.Magin",
channel = CHAN_ITEM,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_nam_m60/m60_magin.wav"
} )
sound.Add(
{
name = "Weapon_M60.Magout",
channel = CHAN_ITEM,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_nam_m60/m60_magout.wav"
} )
sound.Add(
{
name = "Weapon_M60.Magout",
channel = CHAN_ITEM,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_nam_m60/m60_magout.wav"
} )
sound.Add(
{
name = "Weapon_M60.MagHit",
channel = CHAN_ITEM,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_nam_m60/m60_maghit.wav"
} )
sound.Add(
{
name = "Weapon_M60.BeltAlign",
channel = CHAN_ITEM,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_nam_m60/m60_beltalign.wav"
} )
sound.Add(
{
name = "Weapon_M60.BeltJingle",
channel = CHAN_ITEM,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_nam_m60/m60_beltalign.wav"
} )
sound.Add(
{
name = "Weapon_M60.CoverClose",
channel = CHAN_ITEM,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_nam_m60/m60_coverclose.wav"
} )