-- "lua\\tfa\\modules\\tfa_soundscripts.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
sound.Add({
	name = "Weapon_Bow.1",
	channel = CHAN_STATIC,
	volume = 1.0,
	sound = {"weapons/tfbow/fire1.wav", "weapons/tfbow/fire2.wav", "weapons/tfbow/fire3.wav"}
})

sound.Add({
	name = "Weapon_Bow.boltpull",
	channel = CHAN_USER_BASE + 11,
	volume = 1.0,
	sound = {"weapons/tfbow/pull1.wav", "weapons/tfbow/pull2.wav", "weapons/tfbow/pull3.wav"}
})

sound.Add({
	name = "TFA.NearlyEmpty",
	channel = CHAN_USER_BASE + 15,
	volume = 1,
	pitch = 100,
	level = 65,
	sound = "weapons/tfa/lowammo.wav"
})

sound.Add({
	name = "TFA.Bash",
	channel = CHAN_USER_BASE + 14,
	volume = 1.0,
	sound = {
		")weapons/tfa/melee1.wav",
		")weapons/tfa/melee2.wav",
		")weapons/tfa/melee3.wav",
		")weapons/tfa/melee4.wav",
		")weapons/tfa/melee5.wav",
		")weapons/tfa/melee6.wav"
	},
	pitch = {97, 103}
})

sound.Add({
	name = "TFA.BashWall",
	channel = CHAN_USER_BASE + 14,
	volume = 1.0,
	sound = {
		")weapons/tfa/melee_hit_world1.wav",
		")weapons/tfa/melee_hit_world2.wav",
		")weapons/tfa/melee_hit_world3.wav"
	},
	pitch = {97, 103}
})

sound.Add({
	name = "TFA.BashFlesh",
	channel = CHAN_USER_BASE + 14,
	volume = 1.0,
	sound = {
		")weapons/tfa/melee_hit_body1.wav",
		")weapons/tfa/melee_hit_body2.wav",
		")weapons/tfa/melee_hit_body3.wav",
		")weapons/tfa/melee_hit_body4.wav",
		")weapons/tfa/melee_hit_body5.wav",
		")weapons/tfa/melee_hit_body6.wav"
	},
	pitch = {97, 103}
})

sound.Add({
	name = "TFA.IronIn",
	channel = CHAN_USER_BASE + 13,
	volume = 1.0,
	sound = {"weapons/tfa/ironin.wav"},
	pitch = {97, 103}
})

sound.Add({
	name = "TFA.IronOut",
	channel = CHAN_USER_BASE + 13,
	volume = 1.0,
	sound = {"weapons/tfa/ironout.wav"},
	pitch = {97, 103}
})

sound.Add({
	name = "Weapon_Pistol.Empty2",
	channel = CHAN_USER_BASE + 11,
	volume = 1.0,
	level = 80,
	sound = {"weapons/pistol/pistol_empty.wav"},
	pitch = {97, 103}
})

sound.Add({
	name = "Weapon_AR2.Empty2",
	channel = CHAN_USER_BASE + 11,
	volume = 1.0,
	level = 80,
	sound = {"weapons/ar2/ar2_empty.wav"},
	pitch = {97, 103}
})

sound.Add({
	name = "TFA.LowAmmo",
	channel = CHAN_USER_BASE + 15,
	volume = 1.0,
	level = 75,
	pitch = 100,
	sound = ")weapons/tfa/lowammo_indicator_automatic.wav"
})
sound.Add({
	name = "TFA.LowAmmo_Dry",
	channel = CHAN_USER_BASE + 15,
	volume = 1.0,
	level = 75,
	pitch = 100,
	sound = ")weapons/tfa/lowammo_dry_automatic.wav"
})

local ammos = {
	["Handgun"] = "handgun",
	["Shotgun"] = "shotgun",
	["AutoShotgun"] = "shotgun_auto",
	["MachineGun"] = "mg",
	["AssaultRifle"] = "ar",
	["DMR"] = "dmr",
	["Revolver"] = "revolver",
	["Sniper"] = "sr",
	["SMG"] = "smg",
	["SciFi"] = "scifi",
	["GL"] = "gl",
}
for k,v in pairs(ammos) do
	sound.Add({
		name = "TFA.LowAmmo." .. k, -- "TFA.LowAmmo.Handgun"
		channel = CHAN_USER_BASE + 15,
		volume = 1.0,
		level = 75,
		pitch = 100,
		sound = ")weapons/tfa/lowammo_indicator_" .. v .. ".wav"
	})
	sound.Add({
		name = "TFA.LowAmmo." .. k .. "_Dry", -- "TFA.LowAmmo.Handgun_Dry"
		channel = CHAN_USER_BASE + 15,
		volume = 1.0,
		level = 75,
		pitch = 100,
		sound = ")weapons/tfa/lowammo_dry_" .. v .. ".wav"
	})
end