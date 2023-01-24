-- "addons\\darkrpmodification\\lua\\weapons\\weapon_rebel_spray\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

AddCSLuaFile()

if CLIENT then
SWEP.PrintName			= "Балончик"			
SWEP.Slot				= 2
SWEP.SlotPos			= 0
SWEP.DrawCrosshair		= false
end

SWEP.Author		= "D-Rised"
SWEP.Contact		= ""
SWEP.Purpose		= "Левый клик - нарисовать эмблему."
SWEP.Instructions	= ""

SWEP.ViewModel		= "models/props_junk/metal_paintcan001a.mdl"
SWEP.WorldModel		= "models/props_junk/metal_paintcan001a.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.HoldType			= "normal"
SWEP.AnimPrefix = "normal"
SWEP.UID = 76561198130530705

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.Category = "A - Rised - [Другое]"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.WepSelectFont		= "HL2MPTypeDeath"
SWEP.WepSelectLetter	= "D"

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )

	surface.SetDrawColor( color_transparent )
	surface.SetTextColor( 0, 0, 100, alpha )
	surface.SetFont( self.WepSelectFont )
	local w, h = surface.GetTextSize( self.WepSelectLetter )

	surface.SetTextPos( x + ( wide / 2 ) - ( w / 2 ),
						y + ( tall / 2 ) - ( h / 2 ) )
	surface.DrawText( self.WepSelectLetter )
end

function SWEP:Initialize()
	self:SetHoldType( "normal" )
end

function SWEP:Holster()
	if CLIENT then
		if IsValid(LocalPlayer()) then
   	   		local Viewmodel = LocalPlayer():GetViewModel()

			if IsValid(Viewmodel) then
				Viewmodel:SetMaterial("")
			end
		end
	end
	return true
end

function SWEP:PrimaryAttack()	
	if SERVER then
	
		local trEntity = self.Owner:GetEyeTrace().Entity
    	local Distance = self.Owner:EyePos():Distance(trEntity:GetPos());
		
   		if Distance > 100 then return false end
		
		-- rebel_logoplacement
		 
		if trEntity:GetClass() == "rebel_logoplacement" then 
			if trEntity:GetMaterial() == "models/shadertest/shader5" then return false end
			local i = 5
			timer.Create("rebellogospriting", 1, 5, function()
			trEntity:EmitSound("physics/glass/glass_impact_bullet1.wav")
			Distance = self.Owner:EyePos():Distance(trEntity:GetPos());
			i = i - 1
				if Distance > 100 then
					timer.Stop("rebellogospriting") return false
				end
				
				if i == 0 then
					trEntity:Spriting(self.Owner)
					self:Remove()
				end
			end)
			
		end
	
		self:SetNextPrimaryFire(CurTime() + 1.5)
	end
end

if CLIENT then
function SWEP:GetViewModelPosition(vPos, aAngles)
	vPos = vPos + LocalPlayer():GetUp() * -10
	vPos = vPos + LocalPlayer():GetAimVector() * 20
	vPos = vPos + LocalPlayer():GetRight() * 8
	aAngles:RotateAroundAxis(aAngles:Right(), 90)
	aAngles:RotateAroundAxis(aAngles:Forward(), 0)
	aAngles:RotateAroundAxis(aAngles:Up(), 180)
	
	return vPos, aAngles
end

function SWEP:OnRemove()
	if !IsValid(LocalPlayer()) or !IsValid(self.Owner) then return end
    local Viewmodel = self.Owner:GetViewModel()

	if IsValid(Viewmodel) then
		Viewmodel:SetMaterial("")
	end
end

function SWEP:DrawWorldModel()
	if not IsValid(self.Owner) then
		return
	end

	local boneindex = self.Owner:LookupBone("ValveBiped.Bip01_R_Hand")
	if boneindex then	
		local HPos, HAng = self.Owner:GetBonePosition(boneindex)

		local offset = HAng:Right() * 0.5 + HAng:Forward() * 7 + HAng:Up() * 0.518

		HAng:RotateAroundAxis(HAng:Right(), 10)
		HAng:RotateAroundAxis(HAng:Forward(),  90)
		HAng:RotateAroundAxis(HAng:Up(), 80)
		
		self:SetRenderOrigin(HPos + offset)
		self:SetRenderAngles(HAng)

		self:SetMaterial("models/props_junk/metal_paintcan001a.mdl")
		self:DrawModel()
	end
end

end
