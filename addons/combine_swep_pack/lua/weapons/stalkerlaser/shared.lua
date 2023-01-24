-- "addons\\combine_swep_pack\\lua\\weapons\\stalkerlaser\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SWEP.Base = "weapon_base"
SWEP.AdminSpawnable = true

SWEP.AutoSwitchTo = false
SWEP.Slot = 0
SWEP.PrintName = "Stalker Laser"
SWEP.Author = "D-Rised"
SWEP.Spawnable = true
SWEP.AutoSwitchFrom = false
SWEP.FiresUnderwater = false
SWEP.Weight = 5
SWEP.DrawCrosshair = false
SWEP.Category = "A - Rised - [Другое]"
SWEP.SlotPos = 0
SWEP.DrawAmmo = false
SWEP.Instructions = "Hold left mouse button to fire a laser that restores armor."
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.HoldType = "normal"
SWEP.ViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/c_smg1.mdl"
SWEP.WorldModel = "models/weapons/w_smg1.mdl"
SWEP.UseHands = false
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false

if( CLIENT ) then
	surface.CreateFont( "HalfLife2",
	    {
		font = "HalfLife2",
		size = ScreenScale(45),
		weight = 300
		})
	
	SWEP.IconLetter = "L"
	
end
if CLIENT then
	function SWEP:DrawWeaponSelection(x, y, w, h, a)
		surface.SetDrawColor(255, 255, 255, a)
		surface.SetMaterial(self.WepSelectIcon)
		
		local size = math.min(w, h)
		surface.DrawTexturedRect(x + 40, y, size - 25, size - 25)
	end
end
SWEP.WepSelectIcon = Material("Rubrictextures/selection_SuitCharger.png")

//General Variables\\
SWEP.PrimaryReloadSound = Sound("Crane_magnet_release")
SWEP.PrimarySound = Sound("buttons/combine_button3.wav")

//Primary Fire Variables\\
SWEP.Primary.Damage = 10
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 70
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.DefaultClip = 140
SWEP.Primary.Spread = 1
SWEP.Primary.Cone = 0.6
SWEP.IronCone = 0.6
SWEP.DefaultCone = 0.6
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Recoil = 0.5
SWEP.Primary.Delay = 0.1
SWEP.Primary.Force = 3
SWEP.AmmoText = 0
SWEP.Tracer = 6
SWEP.IronFOV = 0

local LASER = Material('trails/laser')
SWEP.Secondary.Damage = 10
SWEP.Secondary.Sound = "buttons/combine_button3.wav"
SWEP.Secondary.TakeAmmo = 2
SWEP.Secondary.ClipSize = 70
SWEP.Secondary.Ammo = "ar2"
SWEP.Secondary.DefaultClip = 140
SWEP.Secondary.Spread = 1
SWEP.Secondary.Cone = 0.6
SWEP.Secondary.NumberofShots = 1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Recoil = 0.5
SWEP.Secondary.Delay =0.4
SWEP.Secondary.Force = 3



function SWEP:Setup(ply)
	if ply.GetViewModel and ply:GetViewModel():IsValid() then
		local attachmentIndex = ply:GetViewModel():LookupAttachment("muzzle")
			self.VM = ply:GetViewModel()
			self.Attach = attachmentIndex
	end
	if ply:IsValid() then
		local attachmentIndex = ply:LookupAttachment("anim_attachment_RH")
		if ply:GetAttachment(attachmentIndex) then
			self.WM = ply
			self.WAttach = attachmentIndex
		end
	end
end
function SWEP:Deploy()
	self:SetHoldType( self.HoldType )	
	self.Weapon:SetNWBool("Reloading", true)

	return true
	
end

local delay = 15
local canVoice = true

function SWEP:Reload()
	self.Weapon:DefaultReload(ACT_VM_RELOAD)

		if (self.Weapon:Clip1() < self.Primary.ClipSize) and (self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
			self.Weapon:SetNWBool("Reloading", false)
		end
			self.Zoomed = false
		if SERVER then
			self.Owner:SetFOV( 0, 0.3 ) -- Setting to 0 resets the FOV
		end

		if canVoice then
			canVoice = false
			timer.Simple( delay, function() canVoice = true end )
			self.Owner:EmitSound( "stalker/go_alert" .. math.random(1,3) .. ".wav", 45 )
		end
		
		if not (CLIENT) then

			self.Owner:DrawViewModel(true)

		end
		local waitdammit = (self.Owner:GetViewModel():SequenceDuration())
	timer.Simple(waitdammit + .1, 
	function() 
		if self.Weapon == nil then return end
		self.Weapon:SetNWBool("Reloading", true)
	end)
	
end

function SWEP:PrimaryAttack()
	
	if ( !self:CanPrimaryAttack() ) then return end

	self.Owner:EmitSound(self.PrimarySound)
	self.Owner:StopSound(self.PrimarySound)

	local ply = self.Owner
	local pos = ply:GetShootPos()
	local ang = ply:GetAimVector()

	local tracedata = {}
	tracedata.start = pos
	tracedata.endpos = pos + (ang * 5000)
	tracedata.filter = ply
	tracedata.mins = ply:OBBMins() * .3
	tracedata.maxs = ply:OBBMaxs() * .3


	local tr = self.Owner:GetEyeTrace()
	local fx 		= EffectData()
	fx:SetOrigin(tr.HitPos)
	fx:SetNormal(VectorRand(), VectorRand(), VectorRand())

	util.Effect( "cball_bounce" ,fx)

	local trace = util.TraceHull( tracedata )
	if trace.Hit and trace.HitNonWorld then
		if trace.Entity:IsValid() then
			local target = trace.Entity
			if SERVER then
				if target:IsPlayer() && (target:isCP() or target:Team() == TEAM_REBELSPY01) then
					local max_armor = RPExtraTeams[target:Team()].maxarmor
					if target:Armor() < max_armor then
						target:SetArmor( math.min( max_armor, target:Armor() + 10 ) )
						if target:Armor() >= max_armor then
							AddTaskExperience(self.Owner, "Восстановление брони")
						end
					end
				elseif target:GetClass() == "fieldterminal" then
					if target:GetNWBool("TERMIsBroken", false) then
						target:Repair()
						AddTaskExperience(self.Owner, "Ремонт силового поля")
					end
				elseif target:GetClass() == "combine_dispenser" then
					target:Repair()
				else
					target:Ignite(1)
					target:TakeDamage(1)
				end
			end	
		end
	end

	self:TakePrimaryAmmo(2)
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
end

function SWEP:SecondaryAttack()
	self:Reload()
end

SWEP.ViewModelBoneMods = {
	["ValveBiped.base"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["handle+"] = { type = "Model", model = "models/props_combine/combinecrane002.mdl", bone = "ValveBiped.base", rel = "suitcharger", pos = Vector(0.231, 3.101, 9.951), angle = Angle(0, 0, 90), size = Vector(0.021, 0.021, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["barrel"] = { type = "Model", model = "models/items/combine_rifle_ammo01.mdl", bone = "ValveBiped.base", rel = "suitcharger", pos = Vector(0, -0.552, 2.234), angle = Angle(0, 0, 0), size = Vector(0.379, 0.379, 1.967), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["handle"] = { type = "Model", model = "models/props_combine/combinecrane002.mdl", bone = "ValveBiped.base", rel = "suitcharger", pos = Vector(0.3, 3.101, 0.859), angle = Angle(-0.747, -5.312, 90), size = Vector(0.021, 0.021, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["suitcharger"] = { type = "Model", model = "models/props_combine/suit_charger001.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(-0.471, 0, -3.409), angle = Angle(0, 0, 0), size = Vector(0.208, 0.208, 0.54), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["dropship"] = { type = "Model", model = "models/gibs/gunship_gibs_nosegun.mdl", bone = "ValveBiped.base", rel = "suitcharger", pos = Vector(-0.03, -0.331, -0.741), angle = Angle(90, 0, 90), size = Vector(0.128, 0.128, 0.126), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["suittop"] = { type = "Model", model = "models/Items/battery.mdl", bone = "ValveBiped.base", rel = "suitcharger", pos = Vector(0.136, -1.461, -4.357), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 1.735), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },

}

SWEP.WElements = {
	["handle+"] = { type = "Model", model = "models/props_combine/combinecrane002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "suitcharger", pos = Vector(0.231, 3.101, 9.951), angle = Angle(0, 0, 90), size = Vector(0.021, 0.021, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["barrel"] = { type = "Model", model = "models/items/combine_rifle_ammo01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "suitcharger", pos = Vector(0.061, -0.552, 9.097), angle = Angle(0, 0, 0), size = Vector(0.379, 0.379, 0.795), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["handle"] = { type = "Model", model = "models/props_combine/combinecrane002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "suitcharger", pos = Vector(0.3, 3.101, 0.859), angle = Angle(-0.747, -5.312, 90), size = Vector(0.021, 0.021, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["suitcharger"] = { type = "Model", model = "models/props_combine/suit_charger001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.788, 0.578, -4.549), angle = Angle(0, -90, -100), size = Vector(0.208, 0.208, 0.54), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["suitcharger+"] = { type = "Model", model = "models/props_combine/suit_charger001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "suitcharger", pos = Vector(-0.292, 0.196, 0.23), angle = Angle(-180, -5.844, -180), size = Vector(0.208, 0.208, 0.54), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["suittop"] = { type = "Model", model = "models/Items/battery.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "suitcharger", pos = Vector(0.136, -1.461, -4.357), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 1.735), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["dropship"] = { type = "Model", model = "models/gibs/gunship_gibs_nosegun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "suitcharger", pos = Vector(-0.03, -0.331, -0.741), angle = Angle(90, 0, 90), size = Vector(0.128, 0.128, 0.126), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

function SWEP:Think()
	self.AmmoText = self.Weapon:Clip1()
if self.Owner:KeyDown(IN_ATTACK) and !self.Owner:KeyDown(IN_ATTACK2) and ( self.Weapon:Clip1() > 0 ) and self.Weapon:GetNWBool("Reloading", false) then
self.Weapon:SetNWBool("Active", true)

else
self.Weapon:SetNWBool("Active", false)
end
if self.Owner:KeyDown(IN_ATTACK2) and !self.Owner:KeyDown(IN_ATTACK) and ( self.Weapon:Clip1() > 0 ) and self.Weapon:GetNWBool("Reloading", false) then
self.Weapon:SetNWBool("Active2", true)

else
//if !self.Owner:KeyDown(IN_ATTACK) then
self.Weapon:SetNWBool("Active2", false)
end
	local vm = self.Owner:GetViewModel()
	vm:SetMaterial("Debug/hsv")
end

function SWEP:Initialize()
	// other initialize code goes here
	
	if CLIENT then
   //if self.SetHoldType then
   //   self:SetHoldType(self.HoldType or "pistol")
  // end
		self:SetWeaponHoldType( self.HoldType )	
		// Create a new table for every weapon instance
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

		self:CreateModels(self.VElements) // create viewmodels
		self:CreateModels(self.WElements) // create worldmodels
		
		// init view model bone build function
		if IsValid(self.Owner) and self.Owner:IsPlayer() then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
				
				--[[// Init viewmodel visibility
				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetColor(Color(255,255,255,255))
				else
					// we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
					vm:SetColor(Color(255,255,255,1))
					// ^ stopped working in GMod 13 because you have to do Entity:SetRenderMode(1) for translucency to kick in
					// however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
					vm:SetMaterial("Debug/hsv")			
				end]]--
			end
		end
	end
		self:Setup(self:GetOwner())
end

if CLIENT then

	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn()
	if self.Weapon:GetNWBool("Active") and self.VM then
        //Draw the laser beam.
        render.SetMaterial( LASER )
		render.DrawBeam(self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_Head1")) + Vector(4,0,3),self:GetOwner():GetEyeTrace().HitPos, 4, 0, 12.5, Color(255, 0, 0, 255)) // r, g, b, alpha (opacity)
		local tr = self.Owner:GetEyeTrace()
		render.SetMaterial( Material( "sprites/orangecore1" ) )
        render.DrawSprite( tr.HitPos,5,5,Color( 255,255,255 ) )
    end
		local vm = self.Owner:GetViewModel()
		
		if ( IsValid( vm ) ) and self.Laser == 1 then
	local tr = self.Owner:GetEyeTrace()
		          render.SetMaterial( Material( "effects/redflare" ) )
                  render.DrawSprite( tr.HitPos,15,15,Color( 255,255,255 ) )
		end
		
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
				--model:DrawModel()
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
		--self.Weapon:DrawModel()
	if self.Weapon:GetNWBool("Active") and self.WM then
        //Draw the laser beam.
        render.SetMaterial( LASER )
		local posang = self.WM:GetAttachment(self.WAttach)
		render.DrawBeam(self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_Head1")) + Vector(4,0,3),self:GetOwner():GetEyeTrace().HitPos, 10, 10, 12.5, Color(255, 0, 0, 255)) // <---
    end
		if (self.ShowWorldModel == nil or self.ShowWorldModel) then
			--self:DrawModel()
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
				--model:DrawModel()
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

function SWEP:DrawHUD()


	local x = ScrW() / 2.0
	local y = ScrH() / 2.0
	local scale = 10 * self.Primary.Cone
	local scale = 10 * self.Secondary.Cone
	

	local LastShootTime = self.Weapon:GetNetworkedFloat( "LastShootTime", 0 )
	scale = scale * (2 - math.Clamp( (CurTime() - LastShootTime) * 5, 0.0, 1.0 ))
	
	surface.SetDrawColor( 0, 0, 255, 255 )
	

	local gap = 0.5 * scale
	local length = gap + 1 * scale
	surface.DrawLine( x - length, y, x - gap, y )
	surface.DrawLine( x + length, y, x + gap, y )
	surface.DrawLine( x, y - length, x, y - gap )
	surface.DrawLine( x, y + length, x, y + gap )

end
