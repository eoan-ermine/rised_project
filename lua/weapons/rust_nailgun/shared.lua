-- "lua\\weapons\\rust_nailgun\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SWEP.Base = "tfa_rust_recoilbase"

SWEP.PrintName = "Nailgun"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Category = "TFA Rust Weapons"
SWEP.HoldType = "revolver"
SWEP.ViewModelFOV = 60
SWEP.Secondary.IronFOV = 60

SWEP.Type = "Pistol"

SWEP.Slot = 5
SWEP.SlotPos = 74

SWEP.ViewModel = "models/weapons/darky_m/rust/c_nailgun.mdl"
SWEP.WorldModel = "models/weapons/darky_m/rust/w_nailgun.mdl"


SWEP.IronSightsPos = Vector(-4.441, -7.068, 1.6)
SWEP.IronSightsAng = Vector(0.6, 0, 0)

SWEP.Primary.Sound = "darky_rust.nailgun-attack"

SWEP.Primary.Spread = .0065475*10
SWEP.Primary.IronAccuracy = .0065475

SWEP.Primary.Damage = 18
SWEP.Primary.ClipSize = 16
SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.DefaultClip = 16
SWEP.Primary.Automatic = false 
SWEP.Primary.RPM = 400

SWEP.Primary.Range = (200 * 16) 
SWEP.Primary.RangeFalloff = 0.7

SWEP.Primary.RangeFalloffLUT = {
	bezier = false,
	range_func = "linear",
	units = "meters",
	lut = {
		{range = 5, damage = 1},
		{range = 16, damage = 0.1},
		{range = 25, damage = 0},
	}
}

SWEP.Attachments = {}

SWEP.VElements = {}

SWEP.WElements = {}

SWEP.MuzzleFlashEnabled = false

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

SWEP.RecoilLerp = 0.04
SWEP.RecoilShootReturnTime = 0.05
SWEP.Primary.Recoil = 1.2
SWEP.RecoilTable = {
	Angle(-2.5*6, 0.4, 0),
}