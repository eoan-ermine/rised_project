-- "lua\\weapons\\rust_m39emr\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SWEP.Base = "tfa_rust_recoilbase"

SWEP.PrintName = "M39 Rifle"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Category = "TFA Rust Weapons"
SWEP.HoldType = "ar2"
SWEP.ViewModelFOV = 65
SWEP.Secondary.IronFOV = 65

SWEP.Type = "Rifle"

SWEP.Slot = 2
SWEP.SlotPos = 74

SWEP.ViewModel = "models/weapons/darky_m/rust/c_m39emr.mdl"
SWEP.WorldModel = "models/weapons/darky_m/rust/w_m39.mdl"

SWEP.IronSightsPos = Vector(-3.94, -3.47, 1.98)
SWEP.IronSightsAng = Vector(1.218, 1.12, 0)

SWEP.IronSightsPos_msHolosight = Vector(-4.032+0.135, -3.47, 0.7)
SWEP.IronSightsAng_msHolosight = Vector(0.4, 1.25, 0)

SWEP.IronSightsPos_Holo = Vector(-3.99+0.133, -3.17, 1.225)
SWEP.IronSightsAng_Holo = Vector(0.4, 1.25, 0)

SWEP.IronSightsPos_4xscope = Vector(-4.2+0.133, -3.47, 1.38)
SWEP.IronSightsAng_4xscope = Vector(0, 0.08, 0)

SWEP.IronSightsPos_8xscope = Vector(-4.2+0.133, -3.47, 1.0775)
SWEP.IronSightsAng_8xscope = Vector(0, 0.285, 0)



SWEP.Primary.Sound = "darky_rust.m39-attack"
SWEP.Primary.SilencedSound= "darky_rust.m39-attack-silenced" 

SWEP.Primary.Spread = .000873*10
SWEP.Primary.IronAccuracy = .000873

SWEP.Primary.Damage = 50
SWEP.Primary.ClipSize = 20
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.DefaultClip = 20
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 250

SWEP.Primary.Range = 4096
SWEP.Primary.RangeFalloff = 0.8


SWEP.Attachments = {
	[1] = {atts = {"darky_rust_silencer", "darky_rust_muzzlebrake", "darky_rust_muzzleboost"}},
	[2] = {atts = {"darky_rust_ms_holosight", "darky_rust_holo", "darky_rust_4x", "darky_rust_8x"}},
	[3] = {atts = {"darky_rust_laser", "darky_rust_flash"}},
	[4] = {atts = {"darky_rust_556hv","darky_rust_556inc","darky_rust_556exp"}},
}

local rust_holo_material = Material( "models/darky_m/rust_weapons/mods/holosight.reticle.standard.png" )
local rust_ms_material = Material( "models/darky_m/rust_weapons/mods/xhair_highvis.png" )

SWEP.VElements = {
	["ms_holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_ms_holosight.mdl", bone = "main", rel = "", pos = Vector(0.02, -3.6, 4.6), angle = Angle(180, -90, -90), size = Vector(1.15, 0.8, 1.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["ms_holosight_xhair"] = { type = "Quad", bone = "main", rel = "ms_holosight", pos = Vector(0.519, 0, 0), angle = Angle(-90, 0, 90), size = 0.01, active = false, draw_func = function()   surface.SetDrawColor(255,255,255,255) surface.SetMaterial( rust_ms_material ) surface.DrawTexturedRect(-70, -70, 140, 140) end },

	["holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_holo.mdl", bone = "main", rel = "", pos = Vector(-0.07, -3.12, 4.62), angle = Angle(180, -90, 0), size = Vector(0.9, 0.9, 0.65), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["holosight_lens"] = { type = "Quad", bone = "main", rel = "holosight", pos = Vector(0.47, -0.123, 0.3), angle = Angle(0, -90, 0), size = 0.01, active = false, draw_func = function()     surface.SetDrawColor(255,0,0,255) surface.SetMaterial( rust_holo_material ) surface.DrawTexturedRect(-40, -40, 80, 80) end },
	["8xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_8xScope.mdl", bone = "main", rel = "", pos = Vector(-0.05, -2.2, 6.2), angle = Angle(180, 0, -90), size = Vector(1, 0.75, 1), color = Color(255, 255, 255, 255), surpresslightning = false, materials = {"","","!tfa_rtmaterial"}, skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["4xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_reddot.mdl", bone = "main", rel = "", pos = Vector(0.24, -4.0, 5), angle = Angle(0, 0, -90), size = Vector(1, 0.75, 1), color = Color(255, 255, 255, 255), surpresslightning = false, materials = {"","","!tfa_rtmaterial"}, skin = 0, bonemerge = false, active = false, bodygroup = {} },
	

	["silencer"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_silencer.mdl", bone = "main", rel = "", pos = Vector(0, -0.9, 42.2), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mbrake"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_muzzlebrake.mdl", bone = "main", rel = "", pos = Vector(0, -0.8, 39.2), angle = Angle(0, 90, -90), size = Vector(2.5, 2.5, 2.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mboost"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_muzzleboost.mdl", bone = "main", rel = "", pos = Vector(0, -0.8, 39.2), angle = Angle(0, 90, -90), size = Vector(2.5, 2.5, 2.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	
	["lasersight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_laser.mdl", bone = "main", rel = "", pos = Vector(1.7, -0.2, 23), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["flashlight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_flash.mdl", bone = "main", rel = "", pos = Vector(2.25, -0.45, 22), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["laser_beam"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "main", rel = "lasersight", pos = Vector(0.5,0,0), angle = Angle(-90, 0, 0), size = Vector(2, 0.5, 0.5), color = Color(255, 255, 255, 32), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = false, active = false },
}

SWEP.WElements = {
	["w_offset"] = { type = "Quad", bone = "main", rel = "", pos = Vector(4, 0.7, -3.9), angle = Angle(0, -90, -100), size = 1, active = true, draw_func = nil },

	["ms_holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_ms_holosight.mdl", bone = "main", rel = "w_offset", pos = Vector(0.02, -3.6, 4.6), angle = Angle(180, -90, -90), size = Vector(1.15, 0.8, 1.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },

	["holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_holo.mdl", bone = "main", rel = "w_offset", pos = Vector(-0.07, -3.12, 4.62), angle = Angle(180, -90, 0), size = Vector(0.9, 0.9, 0.65), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["8xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_8xScope.mdl", bone = "main", rel = "w_offset", pos = Vector(-0.05, -2.2, 6.2), angle = Angle(180, 0, -90), size = Vector(1, 0.75, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["4xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_reddot.mdl", bone = "main", rel = "w_offset", pos = Vector(0.24, -4.0, 5), angle = Angle(0, 0, -90), size = Vector(1, 0.75, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	

	["silencer"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_silencer.mdl", bone = "main", rel = "w_offset", pos = Vector(0, -0.9, 42.2), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mbrake"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_muzzlebrake.mdl", bone = "main", rel = "w_offset", pos = Vector(0, -0.8, 39.2), angle = Angle(0, 90, -90), size = Vector(2.5, 2.5, 2.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mboost"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_muzzleboost.mdl", bone = "main", rel = "w_offset", pos = Vector(0, -0.8, 39.2), angle = Angle(0, 90, -90), size = Vector(2.5, 2.5, 2.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	
	["lasersight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_laser.mdl", bone = "main", rel = "w_offset", pos = Vector(1.7, -0.2, 23), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["flashlight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_flash.mdl", bone = "main", rel = "w_offset", pos = Vector(2.25, -0.45, 22), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["laser_dot"] = { type = "Sprite", sprite = "effects/tfalaserdot", bone = "main", rel = "lasersight", pos = Vector(0.4, 0, -2), size = { x = 4, y = 4 }, color = Color(255, 0, 0, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false, active = false},
	["flash_sprite"] = { type = "Sprite", sprite = "effects/blueflare1", bone = "main", rel = "flashlight", pos = Vector(0.3, 0, -4), size = { x = 15, y = 15 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false, active = false}
}

SWEP.MuzzleFlashEffect = "tfa_muzzleflash_shotgun"

SWEP.LuaShellEject = true
SWEP.LuaShellEjectDelay = 0
SWEP.LuaShellEffect = "RifleShellEject"

SWEP.IronAnimation = {
	["shoot"] = {
		["type"] = TFA.Enum.ANIMATION_ACT,
		["value"] = ACT_VM_PRIMARYATTACK_1,
	}
}

SWEP.EventTable = {}

SWEP.RecoilIS = 0.6
SWEP.Primary.Recoil = 1.2

SWEP.RecoilTable = {
	Angle(-2.5, 0, 0),
	Angle(-8, 0.25, 0),
	Angle(-8, 0, 0),
	Angle(-8, -0.25, 0),
	Angle(-8, -0.25, 0),
	Angle(-8, 0, 0),
}