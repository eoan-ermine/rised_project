-- "lua\\tfa\\external\\hl2_crossbow.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
-- CrossBow Bolt Sounds

sound.Add( {
    name = "Project_MMOD_CrossBow.DrawBack",
    channel = CHAN_AUTO,
    volume = 1,
    level = SNDLVL_NONE,
    pitch = { 90, 110 },
    sound =  { "weapons/projectmmod_crossbow/firebow.wav" }
} )

TFA.AddWeaponSound( "Project_MMOD_CrossBow.Draw", "weapons/projectmmod_crossbow/crossbow_deploy.wav" )
TFA.AddWeaponSound( "Project_MMOD_CrossBow.Reload", "weapons/projectmmod_crossbow/bolt_load1.wav" )
TFA.AddWeaponSound( "Project_MMOD_CrossBow.Reload", "weapons/projectmmod_crossbow/bolt_load2.wav" )
TFA.AddWeaponSound( "Project_MMOD_CrossBow.Lens", "weapons/projectmmod_crossbow/crossbow_lens.wav" )