-- "lua\\weapons\\rust_doublebarrel\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SWEP.Base = "tfa_rust_recoilbase"

SWEP.PrintName = "Double Barrel Shotgun"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.HoldType = "shotgun"
SWEP.ViewModelFOV = 60
SWEP.Secondary.IronFOV = 60
SWEP.Category = "TFA Rust Weapons"
SWEP.Type = "Shotgun"

SWEP.Slot = 3
SWEP.SlotPos = 74

SWEP.ViewModel = "models/weapons/darky_m/rust/c_doublebarrel.mdl"
SWEP.WorldModel = "models/weapons/darky_m/rust/w_doublebarrel.mdl"


SWEP.IronSightsPos = Vector(-4.49, 0.019, 3.95)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.IronSightsPos_msHolosight = Vector(-4.487, 0, 2.97)
SWEP.IronSightsAng_msHolosight = Vector(0.209, 0, 0)

SWEP.IronSightsPos_Holo = Vector(-4.494, 0, 2.96)
SWEP.IronSightsAng_Holo = Vector(0.209, 0, 0)

SWEP.IronSightsPos_4xscope = Vector(-4.501, 0, 3.23)
SWEP.IronSightsAng_4xscope = Vector(0.209, 0, 0)

SWEP.IronSightsPos_8xscope = Vector(-4.356, 0, 3.462)
SWEP.IronSightsAng_8xscope = Vector(0.209, 0, 0)


SWEP.Primary.Sound = "darky_rust.double-shotgun-attack"

SWEP.Primary.Spread = .15
SWEP.Primary.IronAccuracy = .15

SWEP.Primary.Damage = 180/20
SWEP.Primary.NumShots = 20
SWEP.Primary.ClipSize = 2
SWEP.Primary.Ammo = "Buckshot"
SWEP.Primary.DefaultClip = 2
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 120

SWEP.Primary.Range = 1024
SWEP.Primary.RangeFalloff = 0.8


SWEP.Attachments = {
	[1] = {atts = {"darky_rust_ms_holosight", "darky_rust_holo", "darky_rust_4x", "darky_rust_8x"}},
	[2] = {atts = {"darky_rust_laser", "darky_rust_flash"}},
	[3] = {atts = {"darky_rust_12gauge","darky_rust_12slug","darky_rust_12incendiary"}},
}

local rust_holo_material = Material( "models/darky_m/rust_weapons/mods/holosight.reticle.standard.png" )
local rust_ms_material = Material( "models/darky_m/rust_weapons/mods/xhair_highvis.png" )

SWEP.VElements = {
	["ms_holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_ms_holosight.mdl", bone = "barrel", rel = "", pos = Vector(-0.02-3.5, -1.4+1.63, -0.65-2.9), angle = Angle(180, 0, -90), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["ms_holosight_xhair"] = { type = "Quad", bone = "main", rel = "ms_holosight", pos = Vector(0.519, 0, 0), angle = Angle(-90, 0, 90), size = 0.01, active = false, draw_func = function()   surface.SetDrawColor(255,255,255,255) surface.SetMaterial( rust_ms_material ) surface.DrawTexturedRect(-70, -70, 140, 140) end },

	["holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_holo.mdl", bone = "barrel", rel = "", pos = Vector(-0.09-3.5, -1.2+1.52, -0.5-2.9), angle = Angle(180, 0, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["holosight_lens"] = { type = "Quad", bone = "slide", rel = "holosight", pos = Vector(0.47, -0.083, 0.3), angle = Angle(0, -90, 0), size = 0.01, active = false, draw_func = function()     surface.SetDrawColor(255,0,0,255) surface.SetMaterial( rust_holo_material ) surface.DrawTexturedRect(-40, -40, 80, 80) end },
	["8xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_8xScope.mdl", bone = "barrel", rel = "", pos = Vector(-2.01, 0.1, 1), angle = Angle(180, 90, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, materials = {"","","!tfa_rtmaterial"}, skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["4xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_reddot.mdl", bone = "barrel", rel = "", pos = Vector(0.18-4.5, -1.9+2-0.1, -1.9), angle = Angle(0, 90, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, materials = {"","","!tfa_rtmaterial"}, skin = 0, bonemerge = false, active = false, bodygroup = {} },
	

	["lasersight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_laser.mdl", bone = "barrel", rel = "", pos = Vector(2, 0.1, 11), angle = Angle(0, 0, 180), size = Vector(0.9, 0.7, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["flashlight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_pistol_flash.mdl", bone = "barrel", rel = "", pos = Vector(2, 0.1, 11), angle = Angle(0, 180, 180), size = Vector(0.9, 0.9, 1.0), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["laser_beam"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "main", rel = "lasersight", pos = Vector(0.5,0,0), angle = Angle(-90, 0, 0), size = Vector(2, 0.5, 0.5), color = Color(255, 255, 255, 32), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = false, active = false },
}

SWEP.WElements = {
	["w_offset"] = { type = "Quad", bone = "main", rel = "", pos = Vector(15.5, 1.1, -5.2), angle = Angle(80, 0, 180), size = 1, active = true, draw_func = nil },

	["ms_holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_ms_holosight.mdl", bone = "barrel", rel = "w_offset", pos = Vector(-0.02-3.5, -1.4+1.63, -0.65-2.9), angle = Angle(180, 0, -90), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },

	["holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_holo.mdl", bone = "barrel", rel = "w_offset", pos = Vector(-0.09-3.5, -1.2+1.52, -0.5-2.9), angle = Angle(180, 0, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["8xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_8xScope.mdl", bone = "barrel", rel = "w_offset", pos = Vector(-2.01, 0.1, 1), angle = Angle(180, 90, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["4xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_reddot.mdl", bone = "barrel", rel = "w_offset", pos = Vector(0.18-4.5, -1.9+2-0.1, -1.9), angle = Angle(0, 90, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	

	["lasersight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_laser.mdl", bone = "barrel", rel = "w_offset", pos = Vector(2, 0.1, 11), angle = Angle(0, 0, 180), size = Vector(0.9, 0.7, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["flashlight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_pistol_flash.mdl", bone = "barrel", rel = "w_offset", pos = Vector(2, 0.1, 11), angle = Angle(0, 180, 180), size = Vector(0.9, 0.9, 1.0), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["laser_dot"] = { type = "Sprite", sprite = "effects/tfalaserdot", bone = "main", rel = "lasersight", pos = Vector(0.4, 0, -2), size = { x = 4, y = 4 }, color = Color(255, 0, 0, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false, active = false},
	["flash_sprite"] = { type = "Sprite", sprite = "effects/blueflare1", bone = "main", rel = "flashlight", pos = Vector(0.3, 0, -4), size = { x = 15, y = 15 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false, active = false}
}

SWEP.MuzzleFlashEffect = "tfa_muzzleflash_shotgun"

SWEP.LuaShellEject = false
SWEP.LuaShellEjectDelay = 0
SWEP.LuaShellEffect = "RifleShellEject"
SWEP.LuaShellModel = "models/weapons/darky_m/rust/shotgun_shell_handmade.mdl"
SWEP.ShellMaterial = 4


SWEP.MuzzleAttachment = "0"

SWEP.EventTable = {
	[ACT_VM_RELOAD] = {
		{ ["time"] = 296/60, ["type"] = "lua", ["value"] = function(wep, vm)
			local effectdata = EffectData()
			effectdata:SetEntity(vm)
			effectdata:SetAttachment(3)
			effectdata:SetScale(0.5)
			util.Effect("CrossbowLoad", effectdata)
		end, ["client"] = true, ["server"] = false }
	},
}

SWEP.MaterialTable_V = {
	[SWEP.ShellMaterial] = "models/darky_m/rust_weapons/sawnoffshotgun/Shotgunshell_handmade",
}
SWEP.Primary.Recoil = 0.5
SWEP.RecoilLerp = 0.04
SWEP.RecoilShootReturnTime = 0.08

SWEP.RecoilTable = {
	Angle(-160, -60, 0),
}