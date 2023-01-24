-- "lua\\weapons\\rust_waterpipe\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SWEP.Base = "tfa_rust_recoilbase"

SWEP.PrintName = "Waterpipe Shotgun"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Category = "TFA Rust Weapons"
SWEP.HoldType = "shotgun"
SWEP.ViewModelFOV = 60
SWEP.Secondary.IronFOV = 60

SWEP.Type = "Shotgun"

SWEP.Slot = 3
SWEP.SlotPos = 74

SWEP.ViewModel = "models/weapons/darky_m/rust/c_waterpipe.mdl"
SWEP.WorldModel = "models/weapons/darky_m/rust/w_waterpipe.mdl"


SWEP.IronSightsPos = Vector(-5.16, -2.421, 2.68)
SWEP.IronSightsAng = Vector(2.338, 0.975, 0)

SWEP.IronSightsPos_msHolosight =  Vector(-5.055, -2.421, 1.24)
SWEP.IronSightsAng_msHolosight = Vector(2.338, 0.975, 0)

SWEP.IronSightsPos_Holo =  Vector(-5.058, -2.421, 1.792)
SWEP.IronSightsAng_Holo = Vector(2.338, 0.975, 0)

SWEP.IronSightsPos_8xscope =  Vector(-5.149, -2.421, 1.716)
SWEP.IronSightsAng_8xscope = Vector(2.338, 0.975, 0.4)

SWEP.IronSightsPos_4xscope =  Vector(-5.098, -2.421, 2.186)
SWEP.IronSightsAng_4xscope = Vector(2.338, 0.975, 0.4)



SWEP.Primary.Sound = "darky_rust.waterpipe-shotgun-attack"
SWEP.Primary.SilencedSound= "darky_rust.sawnoff-shotgun-attack-silenced" 

SWEP.Primary.Spread = .18
SWEP.Primary.IronAccuracy = .18

SWEP.Primary.Damage = 158/20
SWEP.Primary.NumShots = 20
SWEP.Primary.ClipSize = 1
SWEP.Primary.Ammo = "Buckshot"
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 240

SWEP.Primary.Range = 4096
SWEP.Primary.RangeFalloff = 0.8

SWEP.Attachments = {
	[2] = {atts = {"darky_rust_ms_holosight", "darky_rust_holo", "darky_rust_4x", "darky_rust_8x"}},
	[3] = {atts = {"darky_rust_laser", "darky_rust_flash"}},
	[4] = {atts = {"darky_rust_12gauge","darky_rust_12slug","darky_rust_12incendiary"}},
}

local rust_holo_material = Material( "models/darky_m/rust_weapons/mods/holosight.reticle.standard.png" )
local rust_ms_material = Material( "models/darky_m/rust_weapons/mods/xhair_highvis.png" )

SWEP.VElements = {
	["ms_holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_ms_holosight.mdl", bone = "main", rel = "", pos = Vector(0.05, -4.6, 4.0), angle = Angle(180, -90, -90), size = Vector(1.15, 1.15, 1.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["ms_holosight_xhair"] = { type = "Quad", bone = "main", rel = "ms_holosight", pos = Vector(0.519, 0, 0), angle = Angle(-90, 0, 90), size = 0.01, active = false, draw_func = function()   surface.SetDrawColor(255,255,255,255) surface.SetMaterial( rust_ms_material ) surface.DrawTexturedRect(-70, -70, 140, 140) end },

	["holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_holo.mdl", bone = "main", rel = "", pos = Vector(-0.125+0.05, -4.1, 4.0), angle = Angle(180, -90, 0), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["holosight_lens"] = { type = "Quad", bone = "main", rel = "holosight", pos = Vector(0.47, -0.123, 0.3), angle = Angle(0, -90, 0), size = 0.01, active = false, draw_func = function()     surface.SetDrawColor(255,0,0,255) surface.SetMaterial( rust_holo_material ) surface.DrawTexturedRect(-40, -40, 80, 80) end },
	["8xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_8xScope.mdl", bone = "main", rel = "", pos = Vector(-0.05, -3.2, 6.4), angle = Angle(180, 0, -90), size = Vector(1, 0.9, 1), color = Color(255, 255, 255, 255), surpresslightning = false, materials = {"","","!tfa_rtmaterial"}, skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["4xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_reddot.mdl", bone = "main", rel = "", pos = Vector(0.25, -4.8, 4.0), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, materials = {"","","!tfa_rtmaterial"}, skin = 0, bonemerge = false, active = false, bodygroup = {} },

	["lasersight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_laser.mdl", bone = "barrel", rel = "", pos = Vector(0, -0.5, 14.4), angle = Angle(0, -90, 180), size = Vector(0.9, 0.7, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["flashlight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_flash.mdl", bone = "barrel", rel = "", pos = Vector(0, -0.1, 14.4), angle = Angle(0, -90, 180), size = Vector(0.9, 0.9, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["laser_beam"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "main", rel = "lasersight", pos = Vector(0.5,0,0), angle = Angle(-90, 0, 0), size = Vector(2, 0.5, 0.5), color = Color(255, 255, 255, 32), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = false, active = false },
}

SWEP.WElements = {
	["w_offset"] = { type = "Quad", bone = "main", rel = "", pos = Vector(3, 0.7, -2), angle = Angle(0, -90, -100), size = 1, active = true, draw_func = nil },
	["w_offset2"] = { type = "Quad", bone = "main", rel = "", pos = Vector(8, 1, -2.8), angle = Angle(0, -90, -100), size = 1, active = true, draw_func = nil },

	["ms_holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_ms_holosight.mdl", bone = "main", rel = "w_offset", pos = Vector(0.05, -4.6, 4.0), angle = Angle(180, -90, -90), size = Vector(1.15, 1.15, 1.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_holo.mdl", bone = "main", rel = "w_offset", pos = Vector(-0.125+0.05, -4.1, 4.0), angle = Angle(180, -90, 0), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["8xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_8xScope.mdl", bone = "main", rel = "w_offset", pos = Vector(-0.05, -3.2, 6.4), angle = Angle(180, 0, -90), size = Vector(1, 0.9, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["4xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_reddot.mdl", bone = "main", rel = "w_offset", pos = Vector(0.25, -4.8, 4.0), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },

	["lasersight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_laser.mdl", bone = "barrel", rel = "w_offset2", pos = Vector(0, -0.5, 14.4), angle = Angle(0, -90, 180), size = Vector(0.9, 0.7, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["flashlight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_flash.mdl", bone = "barrel", rel = "w_offset2", pos = Vector(0, -0.1, 14.4), angle = Angle(0, -90, 180), size = Vector(0.9, 0.9, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["laser_dot"] = { type = "Sprite", sprite = "effects/tfalaserdot", bone = "main", rel = "lasersight", pos = Vector(0.4, 0, -2), size = { x = 4, y = 4 }, color = Color(255, 0, 0, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false, active = false},
	["flash_sprite"] = { type = "Sprite", sprite = "effects/blueflare1", bone = "main", rel = "flashlight", pos = Vector(0.3, 0, -4), size = { x = 15, y = 15 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false, active = false}
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

SWEP.EventTable = {}

SWEP.ShellMaterial = 2

SWEP.MaterialTable_V = {
	[SWEP.ShellMaterial] = "models/darky_m/rust_weapons/sawnoffshotgun/Shotgunshell_handmade",
}

SWEP.Primary.Recoil = 0.5
SWEP.RecoilLerp = 0.07
SWEP.RecoilShootReturnTime = 0.05

SWEP.RecoilTable = {
	Angle(-140, -70, 0),
}