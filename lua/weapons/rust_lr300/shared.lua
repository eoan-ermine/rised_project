-- "lua\\weapons\\rust_lr300\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SWEP.Base = "tfa_rust_recoilbase"

SWEP.PrintName = "LR-300 Assault Rifle"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.HoldType = "ar2"
SWEP.ViewModelFOV = 65
SWEP.Secondary.IronFOV = 55
SWEP.Category = "TFA Rust Weapons"
SWEP.Type = "Rifle"

SWEP.Slot = 2
SWEP.SlotPos = 74

SWEP.ViewModel = "models/weapons/darky_m/rust/c_lr300.mdl"
SWEP.WorldModel = "models/weapons/darky_m/rust/w_lr300.mdl"


SWEP.IronSightsPos = Vector(-4.407, 0, 1.05)
SWEP.IronSightsAng = Vector(0.37, 0.05, 0)

SWEP.IronSightsPos_msHolosight = Vector(-4.415, 0, 1.12)
SWEP.IronSightsAng_msHolosight = Vector(0, 0, 0)

SWEP.IronSightsPos_Holo = Vector(-4.372, 0, 1.572)
SWEP.IronSightsAng_Holo = Vector(0, 0, 0)

SWEP.IronSightsPos_8xscope = Vector(-4.4035, 0, 1.49)
SWEP.IronSightsAng_8xscope = Vector(0, 0, 0)

SWEP.IronSightsPos_4xscope = Vector(-4.392, -7.0, 1.622)
SWEP.IronSightsAng_4xscope = Vector(0, 0, 0)


SWEP.Primary.Sound = "darky_rust.lr300-attack"
SWEP.Primary.SilencedSound= "darky_rust.lr300-attack-silenced" 

SWEP.Primary.Spread = .001746*10
SWEP.Primary.IronAccuracy = .001746

SWEP.Primary.Damage = 40
SWEP.Primary.ClipSize = 30
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 500

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
	["ms_holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_ms_holosight.mdl", bone = "main", rel = "", pos = Vector(0.03, -4.4, 0.2), angle = Angle(180, -90, -90), size = Vector(1.15, 1.15, 1.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["ms_holosight_xhair"] = { type = "Quad", bone = "main", rel = "ms_holosight", pos = Vector(0.519, 0, 0), angle = Angle(-90, 0, 90), size = 0.01, active = false, draw_func = function()   surface.SetDrawColor(255,255,255,255) surface.SetMaterial( rust_ms_material ) surface.DrawTexturedRect(-70, -70, 140, 140) end },

	["holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_holo.mdl", bone = "main", rel = "", pos = Vector(-0.05, -4.0, 0.2), angle = Angle(180, -90, 0), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["holosight_lens"] = { type = "Quad", bone = "main", rel = "holosight", pos = Vector(0.47, -0.123, 0.3), angle = Angle(0, -90, 0), size = 0.01, active = false, draw_func = function()     surface.SetDrawColor(255,0,0,255) surface.SetMaterial( rust_holo_material ) surface.DrawTexturedRect(-40, -40, 80, 80) end },
	["8xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_8xScope.mdl", bone = "main", rel = "", pos = Vector(0.04, -3.0, 2.3), angle = Angle(180, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, materials = {"","","!tfa_rtmaterial"}, skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["4xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_reddot.mdl", bone = "main", rel = "", pos = Vector(0.3, -4.95, 0), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, materials = {"","","!tfa_rtmaterial"}, skin = 0, bonemerge = false, active = false, bodygroup = {} },
	

	["silencer"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_silencer.mdl", bone = "main", rel = "", pos = Vector(0, -1.55, 26.2), angle = Angle(0, 0, 180), size = Vector(1.1, 1.1, 1.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mbrake"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_muzzlebrake.mdl", bone = "main", rel = "", pos = Vector(0, -1.55, 22.2), angle = Angle(0, 90, -90), size = Vector(2.5, 2.5, 2.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mboost"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_muzzleboost.mdl", bone = "main", rel = "", pos = Vector(0, -1.55, 22.2), angle = Angle(0, 90, -90), size = Vector(2.5, 2.5, 2.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	
	["lasersight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_laser.mdl", bone = "main", rel = "", pos = Vector(0, 0.268, 14), angle = Angle(0, -90, 180), size = Vector(1.1, 1.1, 1.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["flashlight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_flash.mdl", bone = "main", rel = "", pos = Vector(0, 0.9, 15), angle = Angle(0, -90, 180), size = Vector(1.1, 1.1, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },

	["laser_beam"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "main", rel = "lasersight", pos = Vector(0.5,0,0), angle = Angle(-90, 0, 0), size = Vector(2, 0.5, 0.5), color = Color(255, 255, 255, 32), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = false, active = false },
}

SWEP.WElements = {
	["w_offset"] = { type = "Quad", bone = "main", rel = "", pos = Vector(5.5, 0.7, -3), angle = Angle(0, -90, -100), size = 1, active = true, draw_func = nil },

	["ms_holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_ms_holosight.mdl", bone = "main", rel = "w_offset", pos = Vector(0.03, -4.4, 0.2), angle = Angle(180, -90, -90), size = Vector(1.15, 1.15, 1.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_holo.mdl", bone = "main", rel = "w_offset", pos = Vector(-0.05, -4.0, 0.2), angle = Angle(180, -90, 0), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["8xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_8xScope.mdl", bone = "main", rel = "w_offset", pos = Vector(0.04, -3.0, 2.3), angle = Angle(180, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, materials = {"","","!tfa_rtmaterial"}, skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["4xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_reddot.mdl", bone = "main", rel = "w_offset", pos = Vector(0.3, -4.95, 0), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, materials = {"","","!tfa_rtmaterial"}, skin = 0, bonemerge = false, active = false, bodygroup = {} },
	

	["silencer"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_silencer.mdl", bone = "main", rel = "w_offset", pos = Vector(0, -1.55, 26.2), angle = Angle(0, 0, 180), size = Vector(1.1, 1.1, 1.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mbrake"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_muzzlebrake.mdl", bone = "main", rel = "w_offset", pos = Vector(0, -1.55, 22.2), angle = Angle(0, 90, -90), size = Vector(2.5, 2.5, 2.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mboost"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_muzzleboost.mdl", bone = "main", rel = "w_offset", pos = Vector(0, -1.55, 22.2), angle = Angle(0, 90, -90), size = Vector(2.5, 2.5, 2.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	
	["lasersight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_laser.mdl", bone = "main", rel = "w_offset", pos = Vector(0, 0.268, 14), angle = Angle(0, -90, 180), size = Vector(1.1, 1.1, 1.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["flashlight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_flash.mdl", bone = "main", rel = "w_offset", pos = Vector(0, 0.9, 15), angle = Angle(0, -90, 180), size = Vector(1.1, 1.1, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
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

SWEP.EventTable = {
}


SWEP.Primary.Recoil = 0.95
SWEP.RecoilTable = {
	Angle(-2.5531914893617, 3, 0),
	Angle(-3.4042553191489, -1.25, 0),
	Angle(-2.9787234042553, -1, 0),
	Angle(-2.3404255319149, -1.75, 0),
	Angle(-2.7659574468085, -1.25, 0),
	Angle(-2.5531914893617, -1.5, 0),
	Angle(-2.1276595744681, -2.75, 0),
	Angle(-2.7659574468085, -1.25, 0),
	Angle(-2.3404255319149, 2.25, 0),
	Angle(-1.2765957446809, 3.5, 0),
	Angle(-1.063829787234, 3.25, 0),
	Angle(-0.85106382978723, 3.25, 0),
	Angle(-1.063829787234, 3, 0),
	Angle(-1.2765957446809, 2.75, 0),
	Angle(-2.1276595744681, -1.25, 0),
	Angle(-1.2765957446809, -2.75, 0),
	Angle(-0.63829787234043, -3, 0),
	Angle(-0.42553191489362, -2.75, 0),
	Angle(-0.42553191489362, -3, 0),
	Angle(-0.63829787234043, -2.75, 0),
	Angle(-0.63829787234043, -3, 0),
	Angle(-0.42553191489362, -3, 0),
	Angle(-0.42553191489362, -3.25, 0),
	Angle(-1.2765957446809, -2.5, 0),
	Angle(-2.5531914893617, 1, 0),
	Angle(-0.85106382978723, 2.75, 0),
	Angle(-0.63829787234043, 3.5, 0),
	Angle(-0.42553191489362, 3.75, 0),
	Angle(-0.21276595744681, 3.75, 0),
	Angle(-0.21276595744681, 3.5, 0),	
	Angle(0, -0.25, 0),
}