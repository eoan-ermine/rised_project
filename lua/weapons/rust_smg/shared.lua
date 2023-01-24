-- "lua\\weapons\\rust_smg\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SWEP.Base = "tfa_rust_recoilbase"

SWEP.PrintName = "Custom SMG"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.HoldType = "ar2"
SWEP.ViewModelFOV = 55
SWEP.Secondary.IronFOV = 60
SWEP.Category = "TFA Rust Weapons"
SWEP.Type = "SMG"

SWEP.Slot = 2
SWEP.SlotPos = 74

SWEP.ViewModel = "models/weapons/darky_m/rust/c_customsmg.mdl"
SWEP.WorldModel = "models/weapons/darky_m/rust/w_smg.mdl"


SWEP.IronSightsPos = Vector(-6.95, 0, 3.68)
SWEP.IronSightsAng = Vector(-0.35, -0.59, 0.4)

SWEP.IronSightsPos_msHolosight = Vector(-6.937, 0, 2.31)
SWEP.IronSightsAng_msHolosight = Vector(-0.35, -0.59, 0.4)

SWEP.IronSightsPos_Holo = Vector(-6.905, 0, 2.768)
SWEP.IronSightsAng_Holo = Vector(-0.35, -0.59, 0.4)

SWEP.IronSightsPos_8xscope = Vector(-6.9475, 0, 2.781)
SWEP.IronSightsAng_8xscope = Vector(-0.35, -0.59, 0.4)

SWEP.IronSightsPos_4xscope = Vector(-6.955, 0, 2.963)
SWEP.IronSightsAng_4xscope = Vector(-0.35, -0.59, 0.4)


SWEP.Primary.Sound = "darky_rust.smg-attack"
SWEP.Primary.SilencedSound= "darky_rust.smg-attack-silenced" 

SWEP.Primary.Spread = .004365*10
SWEP.Primary.IronAccuracy = .004365

SWEP.Primary.Damage = 30
SWEP.Primary.ClipSize = 24
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.DefaultClip = 24
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 600

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
	["ms_holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_ms_holosight.mdl", bone = "attach", rel = "", pos = Vector(0.05, -1.9, -0.65), angle = Angle(180, -90, -90), size = Vector(1.15, 1.15, 1.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["ms_holosight_xhair"] = { type = "Quad", bone = "main", rel = "ms_holosight", pos = Vector(0.519, 0, 0), angle = Angle(-90, 0, 90), size = 0.01, active = false, draw_func = function()   surface.SetDrawColor(255,255,255,255) surface.SetMaterial( rust_ms_material ) surface.DrawTexturedRect(-70, -70, 140, 140) end },

	["holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_holo.mdl", bone = "attach", rel = "", pos = Vector(-0.04, -1.5, -0.8), angle = Angle(180, -90, 0), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["holosight_lens"] = { type = "Quad", bone = "attach", rel = "holosight", pos = Vector(0.47, -0.123, 0.3), angle = Angle(0, -90, 0), size = 0.01, active = false, draw_func = function()     surface.SetDrawColor(255,0,0,255) surface.SetMaterial( rust_holo_material ) surface.DrawTexturedRect(-40, -40, 80, 80) end },
	["8xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_8xScope.mdl", bone = "attach", rel = "", pos = Vector(0.04, -0.4, 1.9), angle = Angle(180, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, materials = {"","","!tfa_rtmaterial"}, skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["4xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_reddot.mdl", bone = "attach", rel = "", pos = Vector(0.28, -2.3, -1), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, materials = {"","","!tfa_rtmaterial"}, skin = 0, bonemerge = false, active = false, bodygroup = {} },
	

	["silencer"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_silencer.mdl", bone = "attach", rel = "", pos = Vector(0, 0.3, 16.5), angle = Angle(0, 0, 180), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mbrake"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_muzzlebrake.mdl", bone = "attach", rel = "", pos = Vector(0, 0.4, 12.1), angle = Angle(0, 90, -90), size = Vector(1.65, 2.1, 1.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mboost"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_muzzleboost.mdl", bone = "attach", rel = "", pos = Vector(0, 0.4, 12.3), angle = Angle(0, 90, -90), size = Vector(1.8, 2.2, 1.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	
	["lasersight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_laser.mdl", bone = "attach", rel = "", pos = Vector(0, 1.1, 7.18), angle = Angle(0, -90, 180), size = Vector(1.0, 1.0, 1.0), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["flashlight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_flash.mdl", bone = "attach", rel = "", pos = Vector(-0.1, 1.9, 8.1), angle = Angle(0, -90, 180), size = Vector(1.0, 1.0, 1.0), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["laser_beam"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "main", rel = "lasersight", pos = Vector(0.5,0,0), angle = Angle(-90, 0, 0), size = Vector(2, 0.5, 0.5), color = Color(255, 255, 255, 32), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = false, active = false },
}

SWEP.WElements = {
	["w_offset"] = { type = "Quad", bone = "main", rel = "", pos = Vector(4, 0.7, -4.5), angle = Angle(0, -90, -100), size = 1, active = true, draw_func = nil },

	["ms_holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_ms_holosight.mdl", bone = "attach", rel = "w_offset", pos = Vector(0.05, -1.9, -0.65), angle = Angle(180, -90, -90), size = Vector(1.15, 1.15, 1.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_holo.mdl", bone = "attach", rel = "w_offset", pos = Vector(-0.04, -1.5, -0.8), angle = Angle(180, -90, 0), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["8xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_8xScope.mdl", bone = "attach", rel = "w_offset", pos = Vector(0.04, -0.4, 1.9), angle = Angle(180, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["4xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_reddot.mdl", bone = "attach", rel = "w_offset", pos = Vector(0.28, -2.3, -1), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	

	["silencer"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_silencer.mdl", bone = "attach", rel = "w_offset", pos = Vector(0, 0.3, 16.5), angle = Angle(0, 0, 180), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mbrake"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_muzzlebrake.mdl", bone = "attach", rel = "w_offset", pos = Vector(0, 0.4, 12.1), angle = Angle(0, 90, -90), size = Vector(1.65, 2.1, 1.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mboost"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_muzzleboost.mdl", bone = "attach", rel = "w_offset", pos = Vector(0, 0.4, 12.3), angle = Angle(0, 90, -90), size = Vector(1.8, 2.2, 1.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	
	["lasersight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_laser.mdl", bone = "attach", rel = "w_offset", pos = Vector(0, 1.1, 7.18), angle = Angle(0, -90, 180), size = Vector(1.0, 1.0, 1.0), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["flashlight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_flash.mdl", bone = "attach", rel = "w_offset", pos = Vector(-0.1, 1.9, 8.1), angle = Angle(0, -90, 180), size = Vector(1.0, 1.0, 1.0), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
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
		["type"] = TFA.Enum.ANIMATION_ACT,
		["value"] = ACT_VM_PRIMARYATTACK_1,
	}
}

SWEP.EventTable = {}

SWEP.RecoilTable = {
	Angle(-2.5531914893617, -3, 0),
	Angle(-2.1276595744681,  1, 0),
	Angle(-2.3404255319149, 0.25, 0),
	Angle(-2.1276595744681, -0.75, 0),
	Angle(-2.1276595744681, -1, 0),
	Angle(-2.1276595744681, -0.5, 0),
	Angle(-2.5531914893617, -0.75, 0),
	Angle(-2.3404255319149, -0.5, 0),
	Angle(-2.5531914893617, -0.5, 0),
	Angle(-2.5531914893617, 0.25, 0),
	Angle(-2.3404255319149, 0.75, 0),
	Angle(-2.1276595744681, 1.5, 0),
	Angle(-2.1276595744681, 1.25, 0),
	Angle(-2.1276595744681, 1.25, 0),
	Angle(-2.3404255319149, 1.25, 0),
	Angle(-2.3404255319149, 0, 0),
	Angle(-2.1276595744681, -1, 0),
	Angle(-2.1276595744681, -1.5, 0),
	Angle(-1.9148936170213, -1.5, 0),
	Angle(-1.9148936170213, -2.25, 0),
	Angle(-2.1276595744681, -2.25, 0),
	Angle(-1.9148936170213, 1.5, 0),
	Angle(-1.4893617021277, 1.75, 0),
	Angle(2.7659574468085, 0.5, 0),	
}
