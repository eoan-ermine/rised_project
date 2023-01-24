-- "lua\\tfa\\external\\hl2_crowbar.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--Crowbar Sounds

sound.Add( {
    name = "HL2.CROWBAR.HIT",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 100,
    pitch = { 90, 110 },
    sound =  { "weapons/crowbar/crowbar_swing1.wav","weapons/crowbar/crowbar_swing2.wav","weapons/crowbar/crowbar_swing3.wav" }
} )
sound.Add( {
    name = "HL2.CROWBAR.DRAW",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 100,
    pitch = { 90, 110 },
    sound =  { "weapons/crowbar/crowbar_deploy.wav" }
} )