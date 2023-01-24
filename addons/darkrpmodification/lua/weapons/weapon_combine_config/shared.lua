-- "addons\\darkrpmodification\\lua\\weapons\\weapon_combine_config\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

AddCSLuaFile()

if CLIENT then
SWEP.PrintName			= "Конфигуратор"			
SWEP.Slot				= 3
SWEP.SlotPos			= 14
SWEP.DrawCrosshair		= true
end

SWEP.Author = "D-Rised";
SWEP.Contact = "";
SWEP.Instructions	= ""
SWEP.Category = "A - Rised - [Альянс]"

SWEP.ViewModel			= "models/props_lab/tpplug.mdl";
SWEP.WorldModel			= "models/props_lab/tpplug.mdl";

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.HoldType			= "normal"
SWEP.AnimPrefix = "normal"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

function SWEP:Initialize()
	self:SetHoldType( "pistol" );
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
		if IsValid(trEntity) then
			if trEntity:GetClass() == "combine_doorlock" then
				net.Start("CombineLock.OpenMenu")
				net.WriteEntity(trEntity)
				net.Send(self.Owner)
				
				local ang = Angle(0, self.Owner:GetAngles().yaw + 90, 0)
				local ang2 = Angle(0,0,0)
				trEntity:SetAngles(ang:SnapTo("yaw", 90))
			end
		end
	end
end

function SWEP:SecondaryAttack()	
	if SERVER then
		local trEntity = self.Owner:GetEyeTrace().Entity
    	local Distance = self.Owner:EyePos():Distance(trEntity:GetPos());		
		
		
	end
end
if CLIENT then
function SWEP:GetViewModelPosition(vPos, aAngles)
	vPos = vPos + LocalPlayer():GetUp() * -10
	vPos = vPos + LocalPlayer():GetAimVector() * 20
	vPos = vPos + LocalPlayer():GetRight() * 8
	aAngles:RotateAroundAxis(aAngles:Right(), 10)
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

		local offset = HAng:Right() * 0.5 + HAng:Forward() * 11 + HAng:Up() * -5

		HAng:RotateAroundAxis(HAng:Right(), 90)
		HAng:RotateAroundAxis(HAng:Forward(),  90)
		HAng:RotateAroundAxis(HAng:Up(), 80)
		
		self:SetRenderOrigin(HPos + offset)
		self:SetRenderAngles(HAng)

		self:SetMaterial("models/props_lab/tpplug.mdl")
		self:DrawModel()
	end
end

end 
