-- "lua\\weapons\\rust_m92\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SWEP.Base = "tfa_rust_recoilbase"

SWEP.PrintName = "M92 Pistol"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Category = "TFA Rust Weapons"
SWEP.HoldType = "revolver"
SWEP.ViewModelFOV = 60
SWEP.Secondary.IronFOV = SWEP.ViewModelFOV

SWEP.Type = "Pistol"

SWEP.Slot = 1
SWEP.SlotPos = 74

SWEP.ViewModel = "models/weapons/darky_m/rust/c_m92.mdl"
SWEP.WorldModel = "models/weapons/darky_m/rust/w_m92.mdl"


SWEP.IronSightsPos = Vector(-3.711, 0, 1.799)
SWEP.IronSightsAng = Vector(0.209, 0, 0)

SWEP.IronSightsPos_msHolosight = Vector(-3.705, 0, 0.69)
SWEP.IronSightsAng_msHolosight = Vector(0.209, 0, 0)

SWEP.IronSightsPos_Holo = Vector(-3.695, -2.5, 0.945)
SWEP.IronSightsAng_Holo = Vector(0.209, 0, 0)

SWEP.IronSightsPos_4xscope = Vector(-3.7, -3, 1.15)
SWEP.IronSightsAng_4xscope = Vector(0.209, 0, 0)

SWEP.IronSightsPos_8xscope = Vector(-3.695, -3, 0.89)
SWEP.IronSightsAng_8xscope = Vector(0.209, 0, 0)


SWEP.Primary.Sound = "darky_rust.m92-attack"
SWEP.Primary.SilencedSound= "darky_rust.m92-attack-silenced" 

SWEP.Primary.Spread = .00873*6
SWEP.Primary.IronAccuracy = .00873

SWEP.Primary.Damage = 45
SWEP.Primary.ClipSize = 15
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.DefaultClip = 15
SWEP.Primary.Automatic = false 
SWEP.Primary.RPM = 400

SWEP.Primary.Range = 2048
SWEP.Primary.RangeFalloff = 0.8


SWEP.Attachments = {
	[1] = {atts = {"darky_rust_silencer", "darky_rust_muzzlebrake", "darky_rust_muzzleboost"}},
	[2] = {atts = {"darky_rust_ms_holosight", "darky_rust_holo", "darky_rust_4x", "darky_rust_8x"}},
	[3] = {atts = {"darky_rust_laser", "darky_rust_flash"}},
	[4] = {atts = {"darky_rust_9hv","darky_rust_9inc"}},
}

local rust_holo_material = Material( "models/darky_m/rust_weapons/mods/holosight.reticle.standard.png" )
local rust_ms_material = Material( "models/darky_m/rust_weapons/mods/xhair_highvis.png" )

SWEP.VElements = {
	["ms_holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_ms_holosight.mdl", bone = "slide", rel = "", pos = Vector(-0.02, -1.4, -0.65+2.9), angle = Angle(180, -90, -90), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["ms_holosight_xhair"] = { type = "Quad", bone = "main", rel = "ms_holosight", pos = Vector(0.519, 0, 0), angle = Angle(-90, 0, 90), size = 0.01, active = false, draw_func = function()   surface.SetDrawColor(255,255,255,255) surface.SetMaterial( rust_ms_material ) surface.DrawTexturedRect(-70, -70, 140, 140) end },

	["holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_holo.mdl", bone = "slide", rel = "", pos = Vector(-0.09, -1.2, -0.5+2.9), angle = Angle(180, -90, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["holosight_lens"] = { type = "Quad", bone = "slide", rel = "holosight", pos = Vector(0.47, -0.083, 0.3), angle = Angle(0, -90, 0), size = 0.01, active = false, draw_func = function()     surface.SetDrawColor(255,0,0,255) surface.SetMaterial( rust_holo_material ) surface.DrawTexturedRect(-40, -40, 80, 80) end },
	["8xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_8xScope.mdl", bone = "slide", rel = "", pos = Vector(-0.01, -0.5, 3), angle = Angle(180, 0, -90), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, materials = {"","","!tfa_rtmaterial"}, skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["4xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_reddot.mdl", bone = "slide", rel = "", pos = Vector(0.18, -1.9, -1+2.9), angle = Angle(0, 0, -90), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, materials = {"","","!tfa_rtmaterial"}, skin = 0, bonemerge = false, active = false, bodygroup = {} },
	
	["silencer"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_silencer.mdl", bone = "main", rel = "", pos = Vector(0, -1.7, 13.5), angle = Angle(0, 0, 180), size = Vector(0.7, 0.7, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mbrake"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_muzzlebrake.mdl", bone = "main", rel = "", pos = Vector(0, -1.7, 10.5), angle = Angle(0, 90, -90), size = Vector(1.55, 2.0, 1.7), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mboost"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_muzzleboost.mdl", bone = "main", rel = "", pos = Vector(0, -1.7, 10.7), angle = Angle(0, 90, -90), size = Vector(1.7, 2.1, 1.7), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	
	["lasersight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_laser.mdl", bone = "main", rel = "", pos = Vector(0, 0.1, 6.0), angle = Angle(0, -90, 180), size = Vector(0.9, 0.7, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["flashlight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_pistol_flash.mdl", bone = "main", rel = "", pos = Vector(0, 0.1, 5.9), angle = Angle(0, 90, 180), size = Vector(0.9, 0.9, 1.0), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["laser_beam"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "main", rel = "lasersight", pos = Vector(0.5,0,0), angle = Angle(-90, 0, 0), size = Vector(2, 0.5, 0.5), color = Color(255, 255, 255, 32), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = false, active = false },
}

SWEP.WElements = {
	["w_offset"] = { type = "Quad", bone = "main", rel = "", pos = Vector(4, 0.7, -1.6), angle = Angle(0, -90, -100), size = 1, active = true, draw_func = nil },
	["w_offset2"] = { type = "Quad", bone = "main", rel = "", pos = Vector(4, 0.7, -3.2), angle = Angle(0, -90, -100), size = 1, active = true, draw_func = nil },
	["ms_holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_ms_holosight.mdl", bone = "slide", rel = "w_offset2", pos = Vector(-0.02, -1.4, -0.65+2.9), angle = Angle(180, -90, -90), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },

	["holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_holo.mdl", bone = "slide", rel = "w_offset2", pos = Vector(-0.09, -1.2, -0.5+2.9), angle = Angle(180, -90, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["8xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_8xScope.mdl", bone = "slide", rel = "w_offset2", pos = Vector(-0.01, -0.5, 3), angle = Angle(180, 0, -90), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["4xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_reddot.mdl", bone = "slide", rel = "w_offset2", pos = Vector(0.18, -1.9, -1+2.9), angle = Angle(0, 0, -90), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	
	["silencer"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_silencer.mdl", bone = "main", rel = "w_offset", pos = Vector(0, -1.7, 13.5), angle = Angle(0, 0, 180), size = Vector(0.7, 0.7, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mbrake"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_muzzlebrake.mdl", bone = "main", rel = "w_offset", pos = Vector(0, -1.7, 10.5), angle = Angle(0, 90, -90), size = Vector(1.55, 2.0, 1.7), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mboost"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_muzzleboost.mdl", bone = "main", rel = "w_offset", pos = Vector(0, -1.7, 10.7), angle = Angle(0, 90, -90), size = Vector(1.7, 2.1, 1.7), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	
	["lasersight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_laser.mdl", bone = "main", rel = "w_offset", pos = Vector(0, 0.1, 6.0), angle = Angle(0, -90, 180), size = Vector(0.9, 0.7, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["flashlight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_pistol_flash.mdl", bone = "main", rel = "w_offset", pos = Vector(0, 0.1, 5.9), angle = Angle(0, 90, 180), size = Vector(0.9, 0.9, 1.0), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["laser_dot"] = { type = "Sprite", sprite = "effects/tfalaserdot", bone = "main", rel = "lasersight", pos = Vector(0.4, 0, -2), size = { x = 4, y = 4 }, color = Color(255, 0, 0, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false, active = false},
	["flash_sprite"] = { type = "Sprite", sprite = "effects/blueflare1", bone = "main", rel = "flashlight", pos = Vector(0.3, 0, -4), size = { x = 15, y = 15 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false, active = false}
}

SWEP.MuzzleFlashEffect = "tfa_muzzleflash_pistol"

SWEP.LuaShellModel = "models/tfa/pistolshell.mdl"
SWEP.LuaShellEject = true
SWEP.LuaShellEjectDelay = 0
SWEP.LuaShellEffect = "PistolShellEject"

SWEP.IronAnimation = {
	["shoot"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,
		["value"] = "fire_ads",
		["value_last"] = "fire_last_ads",
	}
}

SWEP.EventTable = {}

SWEP.RecoilIS = 0.7 -- 
SWEP.RecoilLerp = 0.05
SWEP.RecoilShootReturnTime = 0.1

SWEP.RecoilTable = {
	Angle(-2.5*4, 0.4, 0),
}