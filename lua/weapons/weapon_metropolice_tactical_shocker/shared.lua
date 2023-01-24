-- "lua\\weapons\\weapon_metropolice_tactical_shocker\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if SERVER then
AddCSLuaFile( "shared.lua" )
SWEP.HoldType = "pistol"
end
if CLIENT then
language.Add("weapon_metropolice_tactical_shocker", "TS-750")
killicon.Add( "wpn_tr_assaultrifle", "effects/killicons/weapon_metropolice_tactical_shocker", color_white )

SWEP.WepSelectIcon = surface.GetTextureID("HUD/swepicons/tactical_shocker_00_01_icon")
SWEP.DrawWeaponInfoBox	= false
SWEP.BounceWeaponIcon = false

SWEP.PrintName = "TS-750"
SWEP.Slot = 1
SWEP.SlotPos = 4
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = true
SWEP.ViewModelFOV = 58
SWEP.ViewModelFlip = false
end

SWEP.ViewModel = "models/weapons/metropolice_smg/usp/v_usp_match.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.Category 			= "Civil Protection"
SWEP.HoldType			= "pistol"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.FiresUnderwater	= false

SWEP.ViewModelBoneMods = {
	["ValveBiped.square"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["ammocount+++"] = { type = "Model", model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.base", rel = "ammoid", pos = Vector(-0.16, -0.084, 0), angle = Angle(0, 0, 0), size = Vector(0.009, 0.009, 0.079), color = Color(0, 255, 255, 255), surpresslightning = true, material = "model_color", skin = 0, bodygroup = {} },
	["glow"] = { type = "Sprite", sprite = "effects/blueflare1", bone = "ValveBiped.base", rel = "base", pos = Vector(0, -2.11, 6.349), size = { x = 3.6, y = 3.6 }, color = Color(105, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["taser"] = { type = "Model", model = "models/props_combine/combine_smallmonitor001.mdl", bone = "ValveBiped.base", rel = "base", pos = Vector(1.041, -1.502, -3.142), angle = Angle(90, 0, 0), size = Vector(0.208, 0.082, 0.072), color = Color(115, 115, 115, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },
	["ammocount++++"] = { type = "Model", model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.base", rel = "ammoid", pos = Vector(-0.32, -0.084, 0), angle = Angle(0, 0, 0), size = Vector(0.009, 0.009, 0.079), color = Color(0, 255, 255, 255), surpresslightning = true, material = "model_color", skin = 0, bodygroup = {} },
	["ammoid"] = { type = "Model", model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(0.076, -2.168, -3.899), angle = Angle(0, -0.77, -19.217), size = Vector(0.071, 0.018, 0.071), color = Color(155, 155, 155, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },
	["ammocount+"] = { type = "Model", model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.base", rel = "ammoid", pos = Vector(0.159, -0.084, 0), angle = Angle(0, 0, 0), size = Vector(0.009, 0.009, 0.079), color = Color(0, 255, 255, 255), surpresslightning = true, material = "model_color", skin = 0, bodygroup = {} },
	["ammocount++"] = { type = "Model", model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.base", rel = "ammoid", pos = Vector(0, -0.084, 0), angle = Angle(0, 0, 0), size = Vector(0.009, 0.009, 0.079), color = Color(0, 255, 255, 255), surpresslightning = true, material = "model_color", skin = 0, bodygroup = {} },
	["body+"] = { type = "Model", model = "models/props_combine/combine_light002a.mdl", bone = "ValveBiped.base", rel = "base", pos = Vector(0, -1.121, 6.757), angle = Angle(180, 90, 0), size = Vector(0.194, 0.194, 0.229), color = Color(115, 115, 115, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },
	["body++"] = { type = "Model", model = "models/Items/battery.mdl", bone = "ValveBiped.base", rel = "base", pos = Vector(0, -2.464, 0.107), angle = Angle(0, 90, 0), size = Vector(0.286, 0.286, 0.546), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/metropolice_smg/items/battery02", skin = 0, bodygroup = {} },
	["base"] = { type = "Model", model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.009, 0.009, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["ammocount"] = { type = "Model", model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.base", rel = "ammoid", pos = Vector(0.319, -0.084, 0), angle = Angle(0, 0, 0), size = Vector(0.009, 0.009, 0.079), color = Color(0, 255, 255, 255), surpresslightning = true, material = "model_color", skin = 0, bodygroup = {} },
	["body"] = { type = "Model", model = "models/props_combine/combine_window001.mdl", bone = "ValveBiped.base", rel = "base", pos = Vector(0, -2.303, 6.031), angle = Angle(-111.04, 90, 0), size = Vector(0.021, 0.014, 0.009), color = Color(0, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["V952"] = { type = "Quad", bone = "ValveBiped.base", rel = "", pos = Vector(0.6, -1.52, -1.68), angle = Angle(-90, 0, 0), size = 0.055, draw_func = nil},
	["disid+"] = { type = "Sprite", sprite = "particle/particle_glow_05", bone = "ValveBiped.base", rel = "disid", pos = Vector(0, 0, 0.079), size = { x = 1.098, y = 1.473 }, color = Color(0, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = true},
	["disid"] = { type = "Model", model = "models/Items/battery.mdl", bone = "ValveBiped.base", rel = "base", pos = Vector(-0.536, -1.713, -5.886), angle = Angle(-90, 0, 90), size = Vector(0.023, 0.023, 0.023), color = Color(0, 255, 255, 255), surpresslightning = true, material = "model_color", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["ammocount+++"] = { type = "Model", model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "ammoid", pos = Vector(-0.16, -0.084, 0), angle = Angle(0, 0, 0), size = Vector(0.009, 0.009, 0.079), color = Color(0, 255, 255, 255), surpresslightning = true, material = "model_color", skin = 0, bodygroup = {} },
	["taser"] = { type = "Model", model = "models/props_combine/combine_smallmonitor001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(1.041, -1.502, -3.142), angle = Angle(90, 0, 0), size = Vector(0.208, 0.082, 0.072), color = Color(115, 115, 115, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },
	["glow"] = { type = "Sprite", sprite = "effects/blueflare1", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, -2.11, 6.349), size = { x = 3.6, y = 3.6 }, color = Color(105, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["ammocount++++"] = { type = "Model", model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "ammoid", pos = Vector(-0.32, -0.084, 0), angle = Angle(0, 0, 0), size = Vector(0.009, 0.009, 0.079), color = Color(0, 255, 255, 255), surpresslightning = true, material = "model_color", skin = 0, bodygroup = {} },
	["ammocount+"] = { type = "Model", model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "ammoid", pos = Vector(0.159, -0.084, 0), angle = Angle(0, 0, 0), size = Vector(0.009, 0.009, 0.079), color = Color(0, 255, 255, 255), surpresslightning = true, material = "model_color", skin = 0, bodygroup = {} },
	["body"] = { type = "Model", model = "models/props_combine/combine_window001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, -2.303, 6.031), angle = Angle(-111.04, 90, 0), size = Vector(0.021, 0.014, 0.009), color = Color(0, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["ammocount++"] = { type = "Model", model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "ammoid", pos = Vector(0, -0.084, 0), angle = Angle(0, 0, 0), size = Vector(0.009, 0.009, 0.079), color = Color(0, 255, 255, 255), surpresslightning = true, material = "model_color", skin = 0, bodygroup = {} },
	["body+"] = { type = "Model", model = "models/props_combine/combine_light002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, -1.121, 6.757), angle = Angle(180, 90, 0), size = Vector(0.194, 0.194, 0.229), color = Color(115, 115, 115, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },
	["body++"] = { type = "Model", model = "models/Items/battery.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, -2.464, 0.107), angle = Angle(0, 90, 0), size = Vector(0.286, 0.286, 0.546), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/metropolice_smg/items/battery02", skin = 0, bodygroup = {} },
	["base"] = { type = "Model", model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.611, 1.919, -2.057), angle = Angle(174.141, 88.359, 85.319), size = Vector(0.009, 0.009, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["ammocount"] = { type = "Model", model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "ammoid", pos = Vector(0.319, -0.084, 0), angle = Angle(0, 0, 0), size = Vector(0.009, 0.009, 0.079), color = Color(0, 255, 255, 255), surpresslightning = true, material = "model_color", skin = 0, bodygroup = {} },
	["ammoid"] = { type = "Model", model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0.076, -2.168, -3.899), angle = Angle(0, -0.77, -19.217), size = Vector(0.071, 0.018, 0.071), color = Color(155, 155, 155, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} }
}

game.AddAmmoType( { name = "ts750" } )
if ( CLIENT ) then language.Add( "ts750_ammo", "TS-750 energy cells" ) end

SWEP.Primary.ClipSize = 5
SWEP.Primary.DefaultClip = 100
SWEP.Primary.Automatic = false
SWEP.Primary.Delay = 0.35
SWEP.Primary.Ammo = "ts750"
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.Spread = 0
SWEP.Primary.Force = 0
SWEP.Primary.Damage = 1500
SWEP.Primary.NumberofShots = 1

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

function SWEP:Deploy()
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration())
	self:SetNextSecondaryFire( CurTime() + self:SequenceDuration())
	self:NextThink( CurTime() + self:SequenceDuration() )
	self.Owner:EmitSound(Sound("weapons/metropolice_smg/shocker/shocker_draw.wav"))
	self:Idle()
	return true
end


function SWEP:Think()
	local trace = self.Owner:GetEyeTrace()

	if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 245 then
	self.VElements["disid"].color = Color(0, 255, 255, 255)
	self.VElements["disid+"].color = Color(0, 255, 255, 225)
	else
	self.VElements["disid"].color = Color(255, 0, 0, 255)
	self.VElements["disid+"].color = Color(255, 0, 0, 225)
	end
	
	if self.Weapon:Clip1() == 5 then
		self.VElements["ammocount"].color = Color(0, 255, 255, 255)
		self.VElements["ammocount+"].color = Color(0, 255, 255, 255)
		self.VElements["ammocount++"].color = Color(0, 255, 255, 255)
		self.VElements["ammocount+++"].color = Color(0, 255, 255, 255)
		self.VElements["ammocount++++"].color = Color(0, 255, 255, 255)
	elseif self.Weapon:Clip1() == 4 then
		self.VElements["ammocount"].color = Color(0, 25, 25, 255)
		self.VElements["ammocount+"].color = Color(0, 255, 255, 255)
		self.VElements["ammocount++"].color = Color(0, 255, 255, 255)
		self.VElements["ammocount+++"].color = Color(0, 255, 255, 255)
		self.VElements["ammocount++++"].color = Color(0, 255, 255, 255)
	elseif self.Weapon:Clip1() == 3 then
		self.VElements["ammocount"].color = Color(0, 25, 25, 255)
		self.VElements["ammocount+"].color = Color(0, 25, 25, 255)
		self.VElements["ammocount++"].color = Color(0, 255, 255, 255)
		self.VElements["ammocount+++"].color = Color(0, 255, 255, 255)
		self.VElements["ammocount++++"].color = Color(0, 255, 255, 255)
	elseif self.Weapon:Clip1() == 2 then
		self.VElements["ammocount"].color = Color(0, 25, 25, 255)
		self.VElements["ammocount+"].color = Color(0, 25, 25, 255)
		self.VElements["ammocount++"].color = Color(0, 25, 25, 255)
		self.VElements["ammocount+++"].color = Color(0, 255, 255, 255)
		self.VElements["ammocount++++"].color = Color(0, 255, 255, 255)
	elseif self.Weapon:Clip1() == 1 then
		self.VElements["ammocount"].color = Color(0, 25, 25, 255)
		self.VElements["ammocount+"].color = Color(0, 25, 25, 255)
		self.VElements["ammocount++"].color = Color(0, 25, 25, 255)
		self.VElements["ammocount+++"].color = Color(0, 25, 25, 255)
		self.VElements["ammocount++++"].color = Color(0, 255, 255, 255)
	elseif self.Weapon:Clip1() == 0 then
		self.VElements["ammocount"].color = Color(0, 25, 25, 255)
		self.VElements["ammocount+"].color = Color(0, 25, 25, 255)
		self.VElements["ammocount++"].color = Color(0, 25, 25, 255)
		self.VElements["ammocount+++"].color = Color(0, 25, 25, 255)
		self.VElements["ammocount++++"].color = Color(0, 25, 25, 255)
	end
	
	self.VElements["glow"].color = Color(0, 255, 255, math.random(125,255))

	if ( self.Owner:KeyReleased( IN_ATTACK ) || ( !self.Owner:KeyDown( IN_ATTACK ) && self.Sound ) ) then		
		self:Idle()
	end
end


function SWEP:Reload()
	if self.Weapon:DefaultReload(ACT_VM_RELOAD) then
		self:SetNextPrimaryFire( CurTime() + self:SequenceDuration())
		self:NextThink( CurTime() + self:SequenceDuration() )
		self.Owner:EmitSound(Sound("weapons/metropolice_smg/shocker/shocker_reload.wav")) 
		self:Idle()
	end
end


function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	local trace = self.Owner:GetEyeTrace()

	if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 245 then
	
	local bullet = {}
		bullet.Num = self.Primary.NumberofShots
		bullet.Src = self.Owner:GetShootPos()
		bullet.Dir = self.Owner:GetAimVector()
		bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
		bullet.Tracer = 1
		bullet.Force = self.Primary.Force
		bullet.Damage = self.Primary.Damage
		bullet.AmmoType = self.Primary.Ammo
		bullet.TracerName = "ToolTracer"
		bullet.Callback = function ( attacker, tr, dmginfo ) 
			dmginfo:SetDamageType(DMG_SHOCK)
		end
	local rnda = -1.2
	local rndb = 0
	self:ShootEffects()
	self.Owner:FireBullets( bullet )
	self.Owner:EmitSound("npc/roller/mine/rmine_explode_shock1.wav", 85, math.random(95,105))
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) )
	self:TakePrimaryAmmo(self.Primary.TakeAmmo)
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	
	else
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		self.Owner:EmitSound("npc/roller/mine/rmine_shockvehicle1.wav", 85, math.random(115,130))
		self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay / 2 )
	end

end


function SWEP:SecondaryAttack()	
	self.Weapon:SetNextSecondaryFire( CurTime() + 2 )

	if SERVER then
		self.Owner:EmitSound("vo/npc/metropolice_beta/chuckle.wav")
	end
end


function SWEP:FireAnimationEvent( pos, ang, event, options )
	if ( event == 20 ) then return true end
	if ( event == 21 ) then return true end
	if ( event == 5001 ) then return true end
	if ( event == 5003 ) then return true end
	if ( event == 5011 ) then return true end
	if ( event == 5021 ) then return true end
	if ( event == 5031 ) then return true end
	if ( event == 6001 ) then return true end

end


function SWEP:Idle()
if ( CLIENT || !IsValid( self.Owner ) ) then return end
timer.Create( "weapon_idle" .. self:EntIndex(), self:SequenceDuration() - 0.2, 1, function()
if ( !IsValid( self ) ) then return end
self:DoIdle()
end )
end


function SWEP:DoIdleAnimation()
self:SendWeaponAnim( ACT_VM_IDLE )
end


function SWEP:DoIdle()
self:DoIdleAnimation()
timer.Adjust( "weapon_idle" .. self:EntIndex(), self:SequenceDuration(), 0, function()
if ( !IsValid( self ) ) then timer.Destroy( "weapon_idle" .. self:EntIndex() ) return end
self:DoIdleAnimation()
end )
end


function SWEP:StopIdle()
timer.Destroy( "weapon_idle" .. self:EntIndex() )
end


function SWEP:DoImpactEffect( tr )
		if (tr.HitSky) then return end
				local effect = EffectData()
				effect:SetOrigin(tr.HitPos)
				effect:SetNormal( tr.HitNormal )
				util.Effect("cball_explode", effect)

    return true
end


/********************************************************
	SWEP Construction Kit base code
		Created by Clavus
	Available for public use, thread at:
	   facepunch.com/threads/1032378
	   
	   
	DESCRIPTION:
		This script is meant for experienced scripters 
		that KNOW WHAT THEY ARE DOING. Don't come to me 
		with basic Lua questions.
		
		Just copy into your SWEP or SWEP base of choice
		and merge with your own code.
		
		The SWEP.VElements, SWEP.WElements and
		SWEP.ViewModelBoneMods tables are all optional
		and only have to be visible to the client.
********************************************************/

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
	if CLIENT then
			self.VElements["V952"].draw_func = function( weapon )
				draw.SimpleText("V952", "default", 0, 0, Color(0,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
		end

	// other initialize code goes here

	if CLIENT then
	
		// Create a new table for every weapon instance
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

		self:CreateModels(self.VElements) // create viewmodels
		self:CreateModels(self.WElements) // create worldmodels
		
		// init view model bone build function
		if IsValid(self.Owner) then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
				
				// Init viewmodel visibility
				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetColor(Color(255,255,255,255))
				else
					// we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
					vm:SetColor(Color(255,255,255,1))
					// ^ stopped working in GMod 13 because you have to do Entity:SetRenderMode(1) for translucency to kick in
					// however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
					vm:SetMaterial("Debug/hsv")			
				end
			end
		end
		
	end

end

function SWEP:Holster()
	self:StopIdle()
	
	if CLIENT and IsValid(self.Owner) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end
	
	return true
end

function SWEP:OnRemove()
	self:Holster()
end

if CLIENT then

	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn()
		
		local vm = self.Owner:GetViewModel()
		if !IsValid(vm) then return end
		
		if (!self.VElements) then return end
		
		self:UpdateBonePositions(vm)

		if (!self.vRenderOrder) then
			
			// we build a render order because sprites need to be drawn after models
			self.vRenderOrder = {}

			for k, v in pairs( self.VElements ) do
				if (v.type == "Model") then
					table.insert(self.vRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.vRenderOrder, k)
				end
			end
			
		end

		for k, name in ipairs( self.vRenderOrder ) do
		
			local v = self.VElements[name]
			if (!v) then self.vRenderOrder = nil break end
			if (v.hide) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (!v.bone) then continue end
			
			local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
			
			if (!pos) then continue end
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	SWEP.wRenderOrder = nil
	function SWEP:DrawWorldModel()
		
		if (self.ShowWorldModel == nil or self.ShowWorldModel) then
			self:DrawModel()
		end
		
		if (!self.WElements) then return end
		
		if (!self.wRenderOrder) then

			self.wRenderOrder = {}

			for k, v in pairs( self.WElements ) do
				if (v.type == "Model") then
					table.insert(self.wRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.wRenderOrder, k)
				end
			end

		end
		
		if (IsValid(self.Owner)) then
			bone_ent = self.Owner
		else
			// when the weapon is dropped
			bone_ent = self
		end
		
		for k, name in pairs( self.wRenderOrder ) do
		
			local v = self.WElements[name]
			if (!v) then self.wRenderOrder = nil break end
			if (v.hide) then continue end
			
			local pos, ang
			
			if (v.bone) then
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
			else
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
			end
			
			if (!pos) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
		
		local bone, pos, ang
		if (tab.rel and tab.rel != "") then
			
			local v = basetab[tab.rel]
			
			if (!v) then return end
			
			// Technically, if there exists an element with the same name as a bone
			// you can get in an infinite loop. Let's just hope nobody's that stupid.
			pos, ang = self:GetBoneOrientation( basetab, v, ent )
			
			if (!pos) then return end
			
			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
		else
		
			bone = ent:LookupBone(bone_override or tab.bone)

			if (!bone) then return end
			
			pos, ang = Vector(0,0,0), Angle(0,0,0)
			local m = ent:GetBoneMatrix(bone)
			if (m) then
				pos, ang = m:GetTranslation(), m:GetAngles()
			end
			
			if (IsValid(self.Owner) and self.Owner:IsPlayer() and 
				ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
				ang.r = -ang.r // Fixes mirrored models
			end
		
		end
		
		return pos, ang
	end

	function SWEP:CreateModels( tab )

		if (!tab) then return end

		// Create the clientside models here because Garry says we can't do it in the render hook
		for k, v in pairs( tab ) do
			if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
					string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
				
				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
				if (IsValid(v.modelEnt)) then
					v.modelEnt:SetPos(self:GetPos())
					v.modelEnt:SetAngles(self:GetAngles())
					v.modelEnt:SetParent(self)
					v.modelEnt:SetNoDraw(true)
					v.createdModel = v.model
				else
					v.modelEnt = nil
				end
				
			elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
				and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
				
				local name = v.sprite.."-"
				local params = { ["$basetexture"] = v.sprite }
				// make sure we create a unique name based on the selected options
				local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
				for i, j in pairs( tocheck ) do
					if (v[j]) then
						params["$"..j] = 1
						name = name.."1"
					else
						name = name.."0"
					end
				end

				v.createdSprite = v.sprite
				v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
				
			end
		end
		
	end
	
	local allbones
	local hasGarryFixedBoneScalingYet = false

	function SWEP:UpdateBonePositions(vm)
		
		if self.ViewModelBoneMods then
			
			if (!vm:GetBoneCount()) then return end
			
			// !! WORKAROUND !! //
			// We need to check all model names :/
			local loopthrough = self.ViewModelBoneMods
			if (!hasGarryFixedBoneScalingYet) then
				allbones = {}
				for i=0, vm:GetBoneCount() do
					local bonename = vm:GetBoneName(i)
					if (self.ViewModelBoneMods[bonename]) then 
						allbones[bonename] = self.ViewModelBoneMods[bonename]
					else
						allbones[bonename] = { 
							scale = Vector(1,1,1),
							pos = Vector(0,0,0),
							angle = Angle(0,0,0)
						}
					end
				end
				
				loopthrough = allbones
			end
			// !! ----------- !! //
			
			for k, v in pairs( loopthrough ) do
				local bone = vm:LookupBone(k)
				if (!bone) then continue end
				
				// !! WORKAROUND !! //
				local s = Vector(v.scale.x,v.scale.y,v.scale.z)
				local p = Vector(v.pos.x,v.pos.y,v.pos.z)
				local ms = Vector(1,1,1)
				if (!hasGarryFixedBoneScalingYet) then
					local cur = vm:GetBoneParent(bone)
					while(cur >= 0) do
						local pscale = loopthrough[vm:GetBoneName(cur)].scale
						ms = ms * pscale
						cur = vm:GetBoneParent(cur)
					end
				end
				
				s = s * ms
				// !! ----------- !! //
				
				if vm:GetManipulateBoneScale(bone) != s then
					vm:ManipulateBoneScale( bone, s )
				end
				if vm:GetManipulateBoneAngles(bone) != v.angle then
					vm:ManipulateBoneAngles( bone, v.angle )
				end
				if vm:GetManipulateBonePosition(bone) != p then
					vm:ManipulateBonePosition( bone, p )
				end
			end
		else
			self:ResetBonePositions(vm)
		end
		   
	end
	 
	function SWEP:ResetBonePositions(vm)
		
		if (!vm:GetBoneCount()) then return end
		for i=0, vm:GetBoneCount() do
			vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
			vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
			vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
		end
		
	end

	/**************************
		Global utility code
	**************************/

	// Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).
	// Does not copy entities of course, only copies their reference.
	// WARNING: do not use on tables that contain themselves somewhere down the line or you'll get an infinite loop
	function table.FullCopy( tab )

		if (!tab) then return nil end
		
		local res = {}
		for k, v in pairs( tab ) do
			if (type(v) == "table") then
				res[k] = table.FullCopy(v) // recursion ho!
			elseif (type(v) == "Vector") then
				res[k] = Vector(v.x, v.y, v.z)
			elseif (type(v) == "Angle") then
				res[k] = Angle(v.p, v.y, v.r)
			else
				res[k] = v
			end
		end
		
		return res
		
	end
	
end