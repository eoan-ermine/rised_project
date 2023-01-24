-- "lua\\weapons\\rust_m249\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SWEP.Base = "tfa_rust_recoilbase"

SWEP.PrintName = "M249"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Category = "TFA Rust Weapons"
SWEP.HoldType = "shotgun"
SWEP.ViewModelFOV = 60
SWEP.Secondary.IronFOV = 60

SWEP.Type = "Light Machine Gun"

SWEP.Slot = 3
SWEP.SlotPos = 74

SWEP.ViewModel = "models/weapons/darky_m/rust/c_m249.mdl"
SWEP.WorldModel = "models/weapons/darky_m/rust/w_m249.mdl"


SWEP.IronSightsPos = Vector(-3.631, 0, 3.359)
SWEP.IronSightsAng = Vector(-0.102, 0.045, 0)

SWEP.IronSightsPos_msHolosight = Vector(-3.68, 0, 2.359)
SWEP.IronSightsAng_msHolosight = Vector(-0.25, -0.02, 0)

SWEP.IronSightsPos_Holo = Vector(-3.605, 0, 2.4)
SWEP.IronSightsAng_Holo = Vector(-0.25, -0.02, 0)

SWEP.IronSightsPos_8xscope = Vector(-3.595, 0, 2.892)
SWEP.IronSightsAng_8xscope = Vector(-0.79, 0.122, 0)

SWEP.IronSightsPos_4xscope = Vector(-3.605, 0, 2.892)
SWEP.IronSightsAng_4xscope = Vector(-0.25, 0.122, 0)


SWEP.Primary.Sound = "darky_rust.m249-attack"
SWEP.Primary.SilencedSound= "darky_rust.m249-attack-silenced" 

SWEP.Primary.Spread = .001746*10
SWEP.Primary.IronAccuracy = .001746

SWEP.Primary.Damage = 65
SWEP.Primary.ClipSize = 100
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.DefaultClip = 100
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
	["ms_holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_ms_holosight.mdl", bone = "cover", rel = "", pos = Vector(0.05+1.5, -1.05, -2), angle = Angle(180, 180, -90), size = Vector(1.15, 1.15, 1.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["ms_holosight_xhair"] = { type = "Quad", bone = "main", rel = "ms_holosight", pos = Vector(0.519, 0, 0), angle = Angle(-90, 0, 90), size = 0.01, active = false, draw_func = function()   surface.SetDrawColor(255,255,255,255) surface.SetMaterial( rust_ms_material ) surface.DrawTexturedRect(-70, -70, 140, 140) end },

	["holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_holo.mdl", bone = "cover", rel = "", pos = Vector(0.05+1.5, -1.1, -2), angle = Angle(180, 180, 0), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["holosight_lens"] = { type = "Quad", bone = "cover", rel = "holosight", pos = Vector(0.47, -0.123, 0.3), angle = Angle(0, -90, 0), size = 0.01, active = false, draw_func = function()     surface.SetDrawColor(255,0,0,255) surface.SetMaterial( rust_holo_material ) surface.DrawTexturedRect(-40, -40, 80, 80) end },
	["8xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_8xScope.mdl", bone = "cover", rel = "", pos = Vector(0.1, -1.01, -5), angle = Angle(180, -90, -90), size = Vector(1, .7, 1), color = Color(255, 255, 255, 255), surpresslightning = false, materials = {"","","!tfa_rtmaterial"}, skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["4xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_reddot.mdl", bone = "cover", rel = "", pos = Vector(0.05+2, -0.78, -3), angle = Angle(0, -90, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, materials = {"","","!tfa_rtmaterial"}, skin = 0, bonemerge = false, active = false, bodygroup = {} },
	

	["silencer"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_silencer.mdl", bone = "main", rel = "", pos = Vector(0, -1.85, 21+11), angle = Angle(0, 0, 180), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mbrake"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_muzzlebrake.mdl", bone = "main", rel = "", pos = Vector(0, -1.85, 18+11), angle = Angle(0, 90, -90), size = Vector(1.65, 2.1, 1.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mboost"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_muzzleboost.mdl", bone = "main", rel = "", pos = Vector(0, -1.85, 18+11), angle = Angle(0, 90, -90), size = Vector(1.8, 2.2, 1.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	
	["lasersight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_laser.mdl", bone = "main", rel = "", pos = Vector(0, 0.4, 7.18+12), angle = Angle(0, -90, 180), size = Vector(1.0, 1.0, 1.0), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["flashlight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_flash.mdl", bone = "main", rel = "", pos = Vector(-0.1, 1.2, 8.1+11), angle = Angle(0, -90, 180), size = Vector(1.0, 1.0, 1.0), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["laser_beam"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "main", rel = "lasersight", pos = Vector(0.5,0,0), angle = Angle(-90, 0, 0), size = Vector(2, 0.5, 0.5), color = Color(255, 255, 255, 32), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = false, active = false },
}

SWEP.WElements = {
	["w_offset"] = { type = "Quad", bone = "main", rel = "", pos = Vector(5, 0.7, -3.0), angle = Angle(0, -90, -100), size = 1, active = true, draw_func = nil },
	["w_offset2"] = { type = "Quad", bone = "main", rel = "", pos = Vector(11, 1.7, -6.8), angle = Angle(-100, 0, 0), size = 1, active = true, draw_func = nil },
	["ms_holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_ms_holosight.mdl", bone = "cover", rel = "w_offset2", pos = Vector(0.05+1.5, -1.05, -2), angle = Angle(180, 180, -90), size = Vector(1.15, 1.15, 1.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },

	["holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_holo.mdl", bone = "cover", rel = "w_offset2", pos = Vector(0.05+1.5, -1.1, -2), angle = Angle(180, 180, 0), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["8xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_8xScope.mdl", bone = "cover", rel = "w_offset2", pos = Vector(0.1, -1.01, -5), angle = Angle(180, -90, -90), size = Vector(1, .7, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["4xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_reddot.mdl", bone = "cover", rel = "w_offset2", pos = Vector(0.05+2, -0.78, -3), angle = Angle(0, -90, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	

	["silencer"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_silencer.mdl", bone = "main", rel = "w_offset", pos = Vector(0, -1.85, 21+11), angle = Angle(0, 0, 180), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mbrake"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_muzzlebrake.mdl", bone = "main", rel = "w_offset", pos = Vector(0, -1.85, 18+11), angle = Angle(0, 90, -90), size = Vector(1.65, 2.1, 1.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["mboost"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_muzzleboost.mdl", bone = "main", rel = "w_offset", pos = Vector(0, -1.85, 18+11), angle = Angle(0, 90, -90), size = Vector(1.8, 2.2, 1.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	
	["lasersight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_laser.mdl", bone = "main", rel = "w_offset", pos = Vector(0, 0.4, 7.18+12), angle = Angle(0, -90, 180), size = Vector(1.0, 1.0, 1.0), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["flashlight"] = { type = "Model", model = "models/weapons/darky_m/rust/w_mod_flash.mdl", bone = "main", rel = "w_offset", pos = Vector(-0.1, 1.2, 8.1+11), angle = Angle(0, -90, 180), size = Vector(1.0, 1.0, 1.0), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["laser_dot"] = { type = "Sprite", sprite = "effects/tfalaserdot", bone = "main", rel = "lasersight", pos = Vector(0.4, 0, -2), size = { x = 4, y = 4 }, color = Color(255, 0, 0, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false, active = false},
	["flash_sprite"] = { type = "Sprite", sprite = "effects/blueflare1", bone = "main", rel = "flashlight", pos = Vector(0.3, 0, -4), size = { x = 15, y = 15 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false, active = false}
}

SWEP.MuzzleFlashEffect = "tfa_muzzleflash_rifle"

SWEP.LuaShellEject               = true
SWEP.LuaShellEjectDelay          = 0.05

SWEP.LuaShellModel = "models/weapons/darky_m/rust/m249_link.mdl"
SWEP.LuaShellScale = 1
SWEP.LuaShellYaw = 0

SWEP.IronAnimation = {
	["shoot"] = {
		["type"] = TFA.Enum.ANIMATION_ACT,
		["value"] = ACT_VM_PRIMARYATTACK_1,
	}
}

SWEP.EventTable = {}

// full copy of base function
// but
// we removed last line so qc shell ejection started to work together with LuaShellEject

function SWEP:FireAnimationEvent(pos, ang, event, options)
	if self.CustomMuzzleFlash or not self.MuzzleFlashEnabled then
		-- Disables animation based muzzle event
		if (event == 21) then return true end
		-- Disable thirdperson muzzle flash
		if (event == 5003) then return true end

		-- Disable CS-style muzzle flashes, but chance our muzzle flash attachment if one is given.
		if (event == 5001 or event == 5011 or event == 5021 or event == 5031) then
			if self.AutoDetectMuzzleAttachment then
				self.MuzzleAttachmentRaw = math.Clamp(math.floor((event - 4991) / 10), 1, 4)
				self:ShootEffectsCustom(true)
			end

			return true
		end
	end

	-- if (self.LuaShellEject and event ~= 5004) then return true end
end
SWEP.RecoilIS = 0.6
SWEP.RecoilLerp = 0.07

SWEP.RecoilTable = {
	Angle(-6, 0, 0),
	Angle(-14, 0.25, 0),
	Angle(-14, 0.5, 0),
	Angle(-14, 0.75, 0),
	Angle(-14, 0.5, 0),
	Angle(-14, 0.25, 0),
}