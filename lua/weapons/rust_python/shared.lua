-- "lua\\weapons\\rust_python\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SWEP.Base = "tfa_rust_recoilbase"

SWEP.PrintName = "Python Revolver"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Category = "TFA Rust Weapons"
SWEP.HoldType = "revolver"
SWEP.ViewModelFOV = 60
SWEP.Secondary.IronFOV = 60

SWEP.Type = "Pistol"

SWEP.Slot = 1
SWEP.SlotPos = 74

SWEP.ViewModel = "models/weapons/darky_m/rust/c_python.mdl"
SWEP.WorldModel = "models/weapons/darky_m/rust/w_python.mdl"


SWEP.IronSightsPos = Vector(-4.385, -5.453, 2.475)
SWEP.IronSightsAng = Vector(0.1, 0.07, 0)

SWEP.IronSightsPos_msHolosight = Vector(-4.405, -5.453, 1.042)
SWEP.IronSightsAng_msHolosight = Vector(0.1, 0.07, 0)

SWEP.IronSightsPos_Holo = Vector(-4.341, -5.5, 1.492)
SWEP.IronSightsAng_Holo = Vector(0.1, 0.07, 0)

SWEP.IronSightsPos_4xscope = Vector(-4.395, -5.5, 1.664)
SWEP.IronSightsAng_4xscope = Vector(0, 0, 0)

SWEP.IronSightsPos_8xscope = Vector(-4.392, -5.5, 1.492)
SWEP.IronSightsAng_8xscope = Vector(0, 0, 0)


SWEP.Primary.Sound = "darky_rust.python-attack"
SWEP.Primary.Sound_DryFire = "darky_rust.python-dryfire"

SWEP.Primary.Spread = .004365*10
SWEP.Primary.IronAccuracy = .004365

SWEP.Primary.Damage = 55
SWEP.Primary.ClipSize = 6
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.DefaultClip = 6
SWEP.Primary.Automatic = false 
SWEP.Primary.RPM = 400

SWEP.Primary.Range = 2048
SWEP.Primary.RangeFalloff = 0.8


SWEP.Attachments = {
	[1] = {atts = {"darky_rust_ms_holosight", "darky_rust_holo", "darky_rust_4x", "darky_rust_8x"}},
	[2] = {atts = {"darky_rust_laser", "darky_rust_flash"}},
	[3] = {atts = {"darky_rust_9hv","darky_rust_9inc"}},
}

local rust_holo_material = Material( "models/darky_m/rust_weapons/mods/holosight.reticle.standard.png" )
local rust_ms_material = Material( "models/darky_m/rust_weapons/mods/xhair_highvis.png" )

SWEP.VElements = {
	["ms_holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_ms_holosight.mdl", bone = "main", rel = "", pos = Vector(-0.09, -1.9-1.0, -0.65+3.9), angle = Angle(180, -90, -90), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["ms_holosight_xhair"] = { type = "Quad", bone = "main", rel = "ms_holosight", pos = Vector(0.519, 0, 0), angle = Angle(-90, 0, 90), size = 0.01, active = false, draw_func = function()   surface.SetDrawColor(255,255,255,255) surface.SetMaterial( rust_ms_material ) surface.DrawTexturedRect(-70, -70, 140, 140) end },

	["holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_holo.mdl", bone = "main", rel = "", pos = Vector(-0.15, -1.5-1.0, -0.8+3.9), angle = Angle(180, -90, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["holosight_lens"] = { type = "Quad", bone = "main", rel = "holosight", pos = Vector(0.47, -0.123, 0.3), angle = Angle(0, -90, 0), size = 0.01, active = false, draw_func = function()     surface.SetDrawColor(255,0,0,255) surface.SetMaterial( rust_holo_material ) surface.DrawTexturedRect(-40, -40, 80, 80) end },
	["8xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_8xScope.mdl", bone = "main", rel = "", pos = Vector(-0.06, -0.4-1.2, 1.9+2), angle = Angle(180, 0, -90), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, materials = {"","","!tfa_rtmaterial"}, skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["4xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_reddot.mdl", bone = "main", rel = "", pos = Vector(0.16, -2.3-1.0, -1+3.9), angle = Angle(0, 0, -90), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, materials = {"","","!tfa_rtmaterial"}, skin = 0, bonemerge = false, active = false, bodygroup = {} },
	

	["lasersight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_laser.mdl", bone = "main", rel = "", pos = Vector(0, -0.2, 7.4), angle = Angle(0, -90, 180), size = Vector(0.9, 0.7, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["flashlight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_pistol_flash.mdl", bone = "main", rel = "", pos = Vector(0, 0.2, 7.4), angle = Angle(0, 90, 180), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["laser_beam"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "main", rel = "lasersight", pos = Vector(0.5,0,0), angle = Angle(-90, 0, 0), size = Vector(2, 0.5, 0.5), color = Color(255, 255, 255, 32), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = false, active = false },
}

SWEP.WElements = {
	["w_offset"] = { type = "Quad", bone = "main", rel = "", pos = Vector(4, 0.9, -2.6), angle = Angle(0, -90, -100), size = 1, active = true, draw_func = nil },
	["ms_holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_ms_holosight.mdl", bone = "main", rel = "w_offset", pos = Vector(-0.09, -1.9-1.0, -0.65+3.9), angle = Angle(180, -90, -90), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },

	["holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_holo.mdl", bone = "main", rel = "w_offset", pos = Vector(-0.15, -1.5-1.0, -0.8+3.9), angle = Angle(180, -90, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["8xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_8xScope.mdl", bone = "main", rel = "w_offset", pos = Vector(-0.06, -0.4-1.2, 1.9+2), angle = Angle(180, 0, -90), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["4xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_reddot.mdl", bone = "main", rel = "w_offset", pos = Vector(0.16, -2.3-1.0, -1+3.9), angle = Angle(0, 0, -90), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	

	["lasersight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_laser.mdl", bone = "main", rel = "w_offset", pos = Vector(0, -0.2, 7.4), angle = Angle(0, -90, 180), size = Vector(0.9, 0.7, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["flashlight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_pistol_flash.mdl", bone = "main", rel = "w_offset", pos = Vector(0, 0.2, 7.4), angle = Angle(0, 90, 180), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["laser_dot"] = { type = "Sprite", sprite = "effects/tfalaserdot", bone = "main", rel = "lasersight", pos = Vector(0.4, 0, -2), size = { x = 4, y = 4 }, color = Color(255, 0, 0, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false, active = false},
	["flash_sprite"] = { type = "Sprite", sprite = "effects/blueflare1", bone = "main", rel = "flashlight", pos = Vector(0.3, 0, -4), size = { x = 15, y = 15 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false, active = false}
}

SWEP.MuzzleFlashEffect = "tfa_muzzleflash_pistol"

SWEP.LuaShellModel = "models/tfa/pistolshell.mdl"
SWEP.LuaShellEject = false
SWEP.LuaShellEjectDelay = 0
SWEP.LuaShellEffect = "PistolShellEject"

SWEP.IronAnimation = {
	["shoot"] = {
		["type"] = TFA.Enum.ANIMATION_ACT,
		["value"] = ACT_VM_PRIMARYATTACK_1,
	}
}

SWEP.EventTable = {}

SWEP.RecoilIS = 0.3 -- 
SWEP.RecoilLerp = 0.04
SWEP.RecoilShootReturnTime = 0.05

SWEP.RecoilTable = {
	Angle(-2.5*50, 0.4*2, 0),
}