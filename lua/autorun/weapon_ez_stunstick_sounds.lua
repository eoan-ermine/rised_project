-- "lua\\autorun\\weapon_ez_stunstick_sounds.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
sound.Add(
{
name = "Weapon_ez_StunStick.Swing",
channel = CHAN_STATIC,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = { "weapons/ez/stunstick/stunstick_swing1.wav", "weapons/ez/stunstick/stunstick_swing2.wav" }
} )
sound.Add(
{
name = "Weapon_ez_StunStick.Melee_Miss",
channel = CHAN_STATIC,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = { "weapons/stunstick/stunstick_fleshhit1.wav", "weapons/stunstick/stunstick_fleshhit2.wav" }
} )
sound.Add(
{
name = "Weapon_ez_StunStick.Melee_Hit",
channel = CHAN_STATIC,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = { "weapons/stunstick/stunstick_fleshhit1.wav", "weapons/stunstick/stunstick_fleshhit2.wav" }
} )
sound.Add(
{
name = "Weapon_ez_StunStick.Melee_HitWorld",
channel = CHAN_STATIC,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = { "weapons/stunstick/stunstick_impact1.wav", "weapons/stunstick/stunstick_impact2.wav" }
} )
sound.Add(
{
name = "Weapon_ez_StunStick.Charge",
channel = CHAN_STATIC,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/ez/stunstick/stunstick_chargeup.wav"
} )
sound.Add(
{
name = "Weapon_ez_StunStick.Charged_Hit",
channel = CHAN_STATIC,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/ez/stunstick/stunstick_chargedhit1.wav"
} )