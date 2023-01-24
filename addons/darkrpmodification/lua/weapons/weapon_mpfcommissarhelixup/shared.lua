-- "addons\\darkrpmodification\\lua\\weapons\\weapon_mpfcommissarhelixup\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

AddCSLuaFile()

if CLIENT then
SWEP.PrintName			= "Повышение HELIX"
SWEP.Slot				= 4
SWEP.SlotPos			= 32
SWEP.DrawCrosshair		= false
end

SWEP.Author = "D-Rised";
SWEP.Contact = "";
SWEP.Instructions	= "Левый клик - повысить.   Правый клик - понизить."
SWEP.Category = "A - Rised - [Альянс]"

SWEP.ViewModel		= "models/props_lab/clipboard.mdl"
SWEP.WorldModel		= "models/props_lab/clipboard.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.HoldType			= "normal"
SWEP.AnimPrefix = "normal"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.Category = "A - Rised - [Альянс]"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

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

		if trEntity:IsPlayer() and GAMEMODE.MetropoliceJobs[trEntity:Team()] then
			trEntity:SetNWBool("MPF_HELIX_PERMISSION", true)
			DarkRP.notify(self.Owner,2,7,"Вы выдали ".. trEntity:Nick() .. " доступ к HELIX.")
			DarkRP.notify(trEntity,0,7,"Вам выдали доступ к HELIX!")
		end
		
		self:SetNextPrimaryFire(CurTime() + 1)
	end
end

function SWEP:SecondaryAttack()	
	if SERVER then
		local trEntity = self.Owner:GetEyeTrace().Entity
    	local Distance = self.Owner:EyePos():Distance(trEntity:GetPos());
		
   		if Distance > 100 then return false end

		if trEntity:IsPlayer() and trEntity:GetNWBool("MPF_HELIX_PERMISSION") == true then
			trEntity:SetNWBool("MPF_HELIX_PERMISSION", false)
			DarkRP.notify(self.Owner,2,7,"Вы забрали у ".. trEntity:Nick() .. " доступ к HELIX.")
			DarkRP.notify(trEntity,0,7,"У вас забрали доступ к HELIX!")
		end
	
		self:SetNextSecondaryFire(CurTime() + 1)
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

		self:SetMaterial("models/props_lab/clipboard.mdl")
		self:DrawModel()
	end
end

end
