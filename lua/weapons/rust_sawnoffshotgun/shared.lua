-- "lua\\weapons\\rust_sawnoffshotgun\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SWEP.Base = "tfa_rust_recoilbase"

SWEP.PrintName = "Pump Shotgun"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Category = "TFA Rust Weapons"
SWEP.HoldType = "shotgun"
SWEP.ViewModelFOV = 60
SWEP.Secondary.IronFOV = 60

SWEP.Type = "Shotgun"

SWEP.Slot = 3
SWEP.SlotPos = 74

SWEP.ViewModel = "models/weapons/darky_m/rust/c_sawnoffshotgun.mdl"
SWEP.WorldModel = "models/weapons/darky_m/rust/w_sawnoffshotgun.mdl"


SWEP.IronSightsPos = Vector(-3.84, -10.051, 3.598)
SWEP.IronSightsAng = Vector(-0.63, 0.059, 0)

SWEP.IronSightsPos_msHolosight = Vector(-3.895, -4.2, 1.82)
SWEP.IronSightsAng_msHolosight = Vector(0, 0, 0)

SWEP.IronSightsPos_Holo = Vector(-3.855, -4.2, 2.375)
SWEP.IronSightsAng_Holo = Vector(0, 0, 0)

SWEP.IronSightsPos_8xscope = Vector(-3.85, -4.2, 2.294)
SWEP.IronSightsAng_8xscope = Vector(0, 0, 0)

SWEP.IronSightsPos_4xscope = Vector(-3.85, -4.2, 2.576)
SWEP.IronSightsAng_4xscope = Vector(0, 0, 0)


SWEP.Primary.Sound = "darky_rust.sawnoff-shotgun-attack"
SWEP.Primary.SilencedSound= "darky_rust.sawnoff-shotgun-attack-silenced" 

SWEP.Primary.Spread = .15
SWEP.Primary.IronAccuracy = .15

SWEP.Primary.Damage = 100/20
SWEP.Primary.NumShots = 20
SWEP.Primary.ClipSize = 6
SWEP.Primary.Ammo = "Buckshot"
SWEP.Primary.DefaultClip = 6
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 150

SWEP.Primary.Range = 4096
SWEP.Primary.RangeFalloff = 0.8

SWEP.Attachments = {
	[1] = {atts = {"darky_rust_silencer", "darky_rust_muzzlebrake", "darky_rust_muzzleboost"}},
	[2] = {atts = {"darky_rust_ms_holosight", "darky_rust_holo", "darky_rust_4x", "darky_rust_8x"}},
	[3] = {atts = {"darky_rust_12gauge","darky_rust_12slug","darky_rust_12incendiary"}},
}

local rust_holo_material = Material( "models/darky_m/rust_weapons/mods/holosight.reticle.standard.png" )
local rust_ms_material = Material( "models/darky_m/rust_weapons/mods/xhair_highvis.png" )

SWEP.VElements = {
	["ms_holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_ms_holosight.mdl", bone = "main", rel = "", pos = Vector(-0.04, -3.5, 4.0), angle = Angle(180, -90, -90), size = Vector(1.15, 1.15, 1.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["ms_holosight_xhair"] = { type = "Quad", bone = "main", rel = "ms_holosight", pos = Vector(0.519, 0, 0), angle = Angle(-90, 0, 90), size = 0.01, active = false, draw_func = function()   surface.SetDrawColor(255,255,255,255) surface.SetMaterial( rust_ms_material ) surface.DrawTexturedRect(-70, -70, 140, 140) end },

	["holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_holo.mdl", bone = "main", rel = "", pos = Vector(-0.125, -3.0, 4.0), angle = Angle(180, -90, 0), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["holosight_lens"] = { type = "Quad", bone = "main", rel = "holosight", pos = Vector(0.47, -0.123, 0.3), angle = Angle(0, -90, 0), size = 0.01, active = false, draw_func = function()     surface.SetDrawColor(255,0,0,255) surface.SetMaterial( rust_holo_material ) surface.DrawTexturedRect(-40, -40, 80, 80) end },
	["8xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_8xScope.mdl", bone = "main", rel = "", pos = Vector(0, -2.0, 6.7), angle = Angle(180, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, materials = {"","","!tfa_rtmaterial"}, skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["4xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_reddot.mdl", bone = "main", rel = "", pos = Vector(0.25, -3.8, 4.0), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, materials = {"","","!tfa_rtmaterial"}, skin = 0, bonemerge = false, active = false, bodygroup = {} },
	

	["silencer"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_silencer.mdl", bone = "main", rel = "", pos = Vector(-0.05, -1.45, 24.5), angle = Angle(0, 0, 180), size = Vector(0.85, 0.85, 0.85), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mbrake"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_muzzlebrake.mdl", bone = "main", rel = "", pos = Vector(0, -1.45, 21.7), angle = Angle(0, 90, -90), size = Vector(2.0, 2.0, 2.0), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mboost"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_muzzleboost.mdl", bone = "main", rel = "", pos = Vector(0, -1.45, 21.7), angle = Angle(0, 90, -90), size = Vector(2.0, 2.0, 2.0), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
}

SWEP.WElements = {
	["w_offset"] = { type = "Quad", bone = "main", rel = "", pos = Vector(9, 0.7, -4.7), angle = Angle(0, -90, -100), size = 1, active = true, draw_func = nil },

	["ms_holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_ms_holosight.mdl", bone = "main", rel = "w_offset", pos = Vector(-0.04, -3.5, 4.0), angle = Angle(180, -90, -90), size = Vector(1.15, 1.15, 1.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_holo.mdl", bone = "main", rel = "w_offset", pos = Vector(-0.125, -3.0, 4.0), angle = Angle(180, -90, 0), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["8xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_8xScope.mdl", bone = "main", rel = "w_offset", pos = Vector(0, -2.0, 6.7), angle = Angle(180, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["4xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_reddot.mdl", bone = "main", rel = "w_offset", pos = Vector(0.25, -3.8, 4.0), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	

	["silencer"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_silencer.mdl", bone = "main", rel = "w_offset", pos = Vector(-0.05, -1.45, 24.5), angle = Angle(0, 0, 180), size = Vector(0.85, 0.85, 0.85), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mbrake"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_muzzlebrake.mdl", bone = "main", rel = "w_offset", pos = Vector(0, -1.45, 21.7), angle = Angle(0, 90, -90), size = Vector(2.0, 2.0, 2.0), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mboost"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_muzzleboost.mdl", bone = "main", rel = "w_offset", pos = Vector(0, -1.45, 21.7), angle = Angle(0, 90, -90), size = Vector(2.0, 2.0, 2.0), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
}

SWEP.MuzzleFlashEffect = "tfa_muzzleflash_shotgun"

SWEP.LuaShellEject = false
SWEP.LuaShellEjectDelay = 0
SWEP.LuaShellEffect = "RifleShellEject"
SWEP.LuaShellScale = 2
SWEP.LuaShellModel = "models/weapons/darky_m/rust/shotgun_shell_handmade.mdl"

SWEP.IronAnimation = {
	["shoot"] = {
		["type"] = TFA.Enum.ANIMATION_ACT,
		["value"] = ACT_VM_PRIMARYATTACK_1,
	}
}

SWEP.Shotgun = true
SWEP.ShotgunStartAnimShell = true
SWEP.BoltAction = true
SWEP.PumpAction = {
	["type"] = TFA.Enum.ANIMATION_ACT,
	["value"] = ACT_SHOTGUN_PUMP,
}

SWEP.EventTable = {
	[ACT_SHOTGUN_PUMP] = {
		{ ["time"] = 0.25, ["type"] = "lua", ["value"] = function(wep, vm)
			wep:EventShell()
		end, ["client"] = true, ["server"] = true }
	},	

	[ACT_SHOTGUN_RELOAD_START] = {
		{ ["time"] = 0.1, ["type"] = "lua", ["value"] = function(wep, vm)
			wep:EventShell()
		end, ["client"] = true, ["server"] = true }
	},
}
SWEP.ShellMaterial = 2

SWEP.MaterialTable_V = {
	[SWEP.ShellMaterial] = "models/darky_m/rust_weapons/sawnoffshotgun/Shotgunshell_handmade",
}
SWEP.Primary.Recoil = 0.5
-- SWEP.RecoilIS = 0.3 -- 
SWEP.RecoilLerp = 0.07
SWEP.RecoilShootReturnTime = 0.05

SWEP.RecoilTable = {
	Angle(-170, -50, 0),
}