-- "lua\\weapons\\rust_revolver\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SWEP.Base = "tfa_rust_recoilbase"

SWEP.PrintName = "Revolver"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Category = "TFA Rust Weapons"
SWEP.HoldType = "revolver"
SWEP.ViewModelFOV = 60
SWEP.Secondary.IronFOV = 60

SWEP.Type = "Pistol"

SWEP.Slot = 1
SWEP.SlotPos = 74

SWEP.ViewModel = "models/weapons/darky_m/rust/c_revolver.mdl"
SWEP.WorldModel = "models/weapons/darky_m/rust/w_revolver.mdl"


SWEP.IronSightsPos = Vector(-3.32, 0, 0.839)
SWEP.IronSightsAng = Vector(1.129, 0.035, 0)

SWEP.Primary.Sound = "darky_rust.revolver-attack"
SWEP.Primary.SilencedSound= "darky_rust.silenced_shot" 

SWEP.Primary.Spread = .0065475*10
SWEP.Primary.IronAccuracy = .0065475

SWEP.Primary.Damage = 35
SWEP.Primary.ClipSize = 8
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.DefaultClip = 8
SWEP.Primary.Automatic = false 
SWEP.Primary.RPM = 343

SWEP.Primary.Range = 2048
SWEP.Primary.RangeFalloff = 0.8


SWEP.Attachments = {
	[1] = {atts = {"darky_rust_silencer", "darky_rust_muzzlebrake", "darky_rust_muzzleboost"}},
	[2] = {atts = {"darky_rust_9hv","darky_rust_9inc"}},
}

SWEP.VElements = {
	["silencer"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_silencer.mdl", bone = "barrel", rel = "", pos = Vector(-2.2, -2.15, 10), angle = Angle(0, 90, 180), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mbrake"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_muzzlebrake.mdl", bone = "barrel", rel = "", pos = Vector(-2.2, -2.15, 7.0), angle = Angle(0, 0, -90), size = Vector(1.65, 2.1, 1.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mboost"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_muzzleboost.mdl", bone = "barrel", rel = "", pos = Vector(-2.2, -2.15, 7.0), angle = Angle(0, 0, -90), size = Vector(1.8, 2.2, 1.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
}

SWEP.WElements = {
	["w_offset"] = { type = "Quad", bone = "main", rel = "", pos = Vector(9, 3.0, -3.2), angle = Angle(0, -90, -100), size = 1, active = true, draw_func = nil },
	
	["silencer"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_silencer.mdl", bone = "barrel", rel = "w_offset", pos = Vector(-2.2, -2.15, 10), angle = Angle(0, 90, 180), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mbrake"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_muzzlebrake.mdl", bone = "barrel", rel = "w_offset", pos = Vector(-2.2, -2.15, 7.0), angle = Angle(0, 0, -90), size = Vector(1.65, 2.1, 1.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mboost"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_muzzleboost.mdl", bone = "barrel", rel = "w_offset", pos = Vector(-2.2, -2.15, 7.0), angle = Angle(0, 0, -90), size = Vector(1.8, 2.2, 1.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
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

SWEP.RecoilIS = 0.5 -- 
SWEP.RecoilLerp = 0.04
SWEP.RecoilShootReturnTime = 0.05

SWEP.RecoilTable = {
	Angle(-2.5*10, 0.4*2, 0),
}