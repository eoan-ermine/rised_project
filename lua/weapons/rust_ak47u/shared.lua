-- "lua\\weapons\\rust_ak47u\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SWEP.Base = "tfa_rust_recoilbase"

SWEP.PrintName = "Assault Rifle"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.HoldType = "ar2"
SWEP.ViewModelFOV = 71
SWEP.Secondary.IronFOV = 71

SWEP.Type = "Rifle"

SWEP.Slot = 2
SWEP.SlotPos = 74
SWEP.Category = "TFA Rust Weapons"
SWEP.ViewModel = "models/weapons/darky_m/rust/c_ak47u.mdl"
SWEP.WorldModel = "models/weapons/darky_m/rust/w_ak47u.mdl"


SWEP.IronSightsPos = Vector(-6.115, -6.896, 3.703)
SWEP.IronSightsAng = Vector(-0.3, 0.012, 0)

SWEP.IronSightsPos_msHolosight = Vector(-6.1, -4.6, 2.44)
SWEP.IronSightsAng_msHolosight = Vector(0, 0, 0)

SWEP.IronSightsPos_Holo = Vector(-6.073, -2.6, 2.785)
SWEP.IronSightsAng_Holo = Vector(0, 0, 0)

SWEP.IronSightsPos_8xscope = Vector(-6.106, -2.6, 2.85)
SWEP.IronSightsAng_8xscope = Vector(0, 0, 0)

SWEP.IronSightsPos_4xscope = Vector(-6.145, -2.6, 3.155)
SWEP.IronSightsAng_4xscope = Vector(0, 0, 0)


SWEP.Primary.Sound = "darky_rust.ak74u-attack"
SWEP.Primary.SilencedSound= "darky_rust.ak74u-attack-silenced" 

SWEP.Primary.Spread = .001746*10
SWEP.Primary.IronAccuracy = .001746

SWEP.Primary.Damage = 50
SWEP.Primary.ClipSize = 30
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 450

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
	["ms_holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_ms_holosight.mdl", bone = "main", rel = "", pos = Vector(-0.05, -2.8, 0.2), angle = Angle(180, -90, -90), size = Vector(1.15, 1.15, 1.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["ms_holosight_xhair"] = { type = "Quad", bone = "main", rel = "ms_holosight", pos = Vector(0.519, 0, 0), angle = Angle(-90, 0, 90), size = 0.01, active = false, draw_func = function()   surface.SetDrawColor(255,255,255,255) surface.SetMaterial( rust_ms_material ) surface.DrawTexturedRect(-70, -70, 140, 140) end },

	["holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_holo.mdl", bone = "main", rel = "", pos = Vector(-0.15, -2.5, -0.2), angle = Angle(180, -90, 0), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["holosight_lens"] = { type = "Quad", bone = "main", rel = "holosight", pos = Vector(0.47, -0.123, 0.3), angle = Angle(0, -90, 0), size = 0.01, active = false, draw_func = function()     surface.SetDrawColor(255,0,0,255) surface.SetMaterial( rust_holo_material ) surface.DrawTexturedRect(-40, -40, 80, 80) end },
	["8xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_8xScope.mdl", bone = "main", rel = "", pos = Vector(-0.06, -1.354, 3.079), angle = Angle(180, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, materials = {"","","!tfa_rtmaterial"}, skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["4xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_reddot.mdl", bone = "main", rel = "", pos = Vector(0.148, -3.13, 0.281), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, materials = {"","","!tfa_rtmaterial"}, skin = 0, bonemerge = false, active = false, bodygroup = {} },
	

	["silencer"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_silencer.mdl", bone = "main", rel = "", pos = Vector(0, 0.5, 29), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mbrake"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_muzzlebrake.mdl", bone = "main", rel = "", pos = Vector(0, 0.6, 26), angle = Angle(0, 90, -90), size = Vector(2.5, 2.5, 2.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mboost"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_muzzleboost.mdl", bone = "main", rel = "", pos = Vector(0, 0.6, 26), angle = Angle(0, 90, -90), size = Vector(2.5, 2.5, 2.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	
	["lasersight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_laser.mdl", bone = "main", rel = "", pos = Vector(0, 1.568, 15.238), angle = Angle(0, -90, 180), size = Vector(1.1, 1.1, 1.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["flashlight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_flash.mdl", bone = "main", rel = "", pos = Vector(-0.08, 2.03, 15.1), angle = Angle(0, -90, 180), size = Vector(1.1, 1.1, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },

	["laser_beam"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "main", rel = "lasersight", pos = Vector(0.5,0,0), angle = Angle(-90, 0, 0), size = Vector(2, 0.5, 0.5), color = Color(255, 255, 255, 32), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = false, active = false },
}

SWEP.WElements = {
	["w_offset"] = { type = "Quad", bone = "main", rel = "", pos = Vector(5.5, 0.7, -4), angle = Angle(0, -90, -100), size = 1, active = true, draw_func = nil },

	["ms_holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_ms_holosight.mdl", bone = "main", rel = "w_offset", pos = Vector(-0.05, -2.8, 0.2), angle = Angle(180, -90, -90), size = Vector(1.15, 1.15, 1.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },

	["holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_holo.mdl", bone = "main", rel = "w_offset", pos = Vector(-0.15, -2.5, -0.2), angle = Angle(180, -90, 0), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["8xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_8xScope.mdl", bone = "main", rel = "w_offset", pos = Vector(-0.06, -1.354, 3.079), angle = Angle(180, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["4xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_reddot.mdl", bone = "main", rel = "w_offset", pos = Vector(0.148, -3.13, 0.281), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	

	["silencer"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_silencer.mdl", bone = "main", rel = "w_offset", pos = Vector(0, 0.5, 29), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mbrake"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_muzzlebrake.mdl", bone = "main", rel = "w_offset", pos = Vector(0, 0.6, 26), angle = Angle(0, 90, -90), size = Vector(2.5, 2.5, 2.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mboost"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_muzzleboost.mdl", bone = "main", rel = "w_offset", pos = Vector(0, 0.6, 26), angle = Angle(0, 90, -90), size = Vector(2.5, 2.5, 2.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	
	["lasersight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_laser.mdl", bone = "main", rel = "w_offset", pos = Vector(0, 1.568, 15.238), angle = Angle(0, -90, 180), size = Vector(1.1, 1.1, 1.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["flashlight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_flash.mdl", bone = "main", rel = "w_offset", pos = Vector(-0.08, 2.03, 15.1), angle = Angle(0, -90, 180), size = Vector(1.1, 1.1, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },

	["laser_dot"] = { type = "Sprite", sprite = "effects/tfalaserdot", bone = "main", rel = "lasersight", pos = Vector(0.4, 0, -2), size = { x = 4, y = 4 }, color = Color(255, 0, 0, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false, active = false},
	["flash_sprite"] = { type = "Sprite", sprite = "effects/blueflare1", bone = "main", rel = "flashlight", pos = Vector(0.3, 0, -4), size = { x = 15, y = 15 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false, active = false}
}

SWEP.MuzzleFlashEffect = "tfa_muzzleflash_rifle"

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

SWEP.RecoilTable = {
	Angle(-2.5531914893617, 3, 0),
	Angle(-4.2553191489362, -3.5, 0),
	Angle(-4.2553191489362, 0.5, 0),
	Angle(-3.8297872340426, -4, 0),
	Angle(-3.4042553191489, -3, 0),
	Angle(-4.0425531914894, -0.75, 0),
	Angle(-3.4042553191489, 1.75, 0),
	Angle(-2.7659574468085, 3.75, 0),
	Angle(-1.4893617021277, 5.75, 0),
	Angle(-1.2765957446809, 6, 0),
	Angle(-1.9148936170213, 5, 0),
	Angle(-3.4042553191489, 3.75, 0),
	Angle(-3.6170212765957, 1.75, 0),
	Angle(-4.2553191489362, 0.75, 0),
	Angle(-4.0425531914894, -1.75, 0),
	Angle(-3.1914893617021, -3, 0),
	Angle(-2.7659574468085, -4, 0),
	Angle(-2.3404255319149, -5.25, 0),
	Angle(-2.7659574468085, -5.75, 0),
	Angle(-1.9148936170213, -6.25, 0),
	Angle(-1.7021276595745, -5.5, 0),
	Angle(-1.4893617021277, -5, 0),
	Angle(-1.7021276595745, -4.5, 0),
	Angle(-3.8297872340426, -2.5, 0),
	Angle(-3.6170212765957, 4, 0),
	Angle(-2.1276595744681, 3.75, 0),
	Angle(-2.5531914893617, 4.5, 0),
	Angle(-2.1276595744681, 4.25, 0),
	Angle(-1.7021276595745, 4, 0),
	Angle(-1.7021276595745, 3.75, 0),
}
