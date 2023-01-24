-- "lua\\tfa\\external\\hl2_rpg.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
-- MMOD RPG Sounds

sound.Add( {
    name = "Project_MMOD_RPG.Fire",
    channel = CHAN_WEAPON,
    volume = 0.9,
    level = SNDLVL_GUNFIRE,
    pitch = { 95, 100 },
    sound =  { "weapons/projectmmod_rpg/rocketfire1.wav", }
} )
sound.Add( {
    name = "Project_MMOD_RPG.Draw",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = SNDLVL_NORM,
    pitch = { 100, 100 },
    sound =  { "weapons/projectmmod_rpg/rpg_deploy.wav", }
} )
sound.Add( {
    name = "Project_MMOD_RPG.Button",
    channel = CHAN_AUTO,
    volume = 1.0,
    level = SNDLVL_NONE,
    pitch = { 90, 110 },
    sound =  { "weapons/projectmmod_rpg/rpg_button.wav", }
} )
sound.Add( {
    name = "Project_MMOD_RPG.Reload",
    channel = CHAN_ITEM,
    volume = 0.9,
    level = SNDLVL_NORM,
    pitch = { 90, 110 },
    sound =  { "weapons/projectmmod_rpg/rpg_reload1.wav", }
} )
sound.Add( {
    name = "Project_MMOD_RPG.Loop",
    channel = CHAN_WEAPON,
    volume = 0.9,
    level = SNDLVL_GUNFIRE,
    pitch = { 95, 100 },
    sound =  { "weapons/projectmmod_rpg/rocket1.wav", }
} )