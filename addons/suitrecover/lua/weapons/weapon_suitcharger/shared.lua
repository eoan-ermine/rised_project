-- "addons\\suitrecover\\lua\\weapons\\weapon_suitcharger\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

AddCSLuaFile()

if CLIENT then
SWEP.PrintName			= "Улучшенный ремонт брони"			
SWEP.Slot				= 3
SWEP.SlotPos			= 14
SWEP.DrawCrosshair		= false
end

SWEP.Author = "D-Rised";
SWEP.Contact = "";
SWEP.Category = "A - Rised - [Повстанцы]"

SWEP.ViewModel		= "models/Items/battery.mdl"
SWEP.WorldModel		= "models/Items/battery.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.HoldType			= "normal"
SWEP.AnimPrefix = "normal"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 50
SWEP.Primary.DefaultClip	= 50
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "Battery"
SWEP.Primary.Delay = 1

SWEP.Secondary.Delay = 0.1
SWEP.Secondary.Recoil = 0
SWEP.Secondary.Damage = 0
SWEP.Secondary.NumberofShots = 1
SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

function SWEP:Initialize()
	self:SetHoldType( "normal" )
    self.Timer = CurTime()
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

function SWEP:Think()
	if ( self:GetNextPrimaryFire() > CurTime() ) then return end
    if CurTime() > self.Timer + 1 then
		self.Timer = CurTime()
    end
end

function SWEP:Reload() // Функция при перезарядке
	if SERVER then
		if self:GetNextPrimaryFire() > CurTime() || self:GetNWBool("Entity_Timer") || self.Owner:GetAmmoCount("Battery") >= 50 then return end
		if GAMEMODE.MetropolicePlunger[self.Owner:Team()] or self.Owner:Team() == TEAM_OTA_Tech then
			if self.Owner:GetNWInt("Rised_Player_Metal_Count") > 0 then
				self.Owner:GiveAmmo(10, "Battery", true)
				self.Owner:EmitSound("items/battery_pickup.wav", 40)
				self.Owner:SetNWInt("Rised_Player_Metal_Count", math.Clamp(self.Owner:GetNWInt("Rised_Player_Metal_Count") - 1, 0, 10))
			else
				DarkRP.notify(self.Owner,0,7,"У вас недостаточно металла Альянса")
				self:SetNWBool("Entity_Timer", true)
				timer.Simple(1, function() self:SetNWBool("Entity_Timer", false) end)
				return
			end
		else
			self.Owner:GiveAmmo(2, "Battery", true)
			self.Owner:EmitSound("items/battery_pickup.wav", 40)
		end
		self:SetNWBool("Entity_Timer", true)
		timer.Simple(1, function() self:SetNWBool("Entity_Timer", false) end)
	end
end

function SWEP:PrimaryAttack()
	if SERVER then
		if self.Owner:GetAmmoCount("Battery") <= 0 then return end
		
		local trEntity = self.Owner:GetEyeTrace().Entity
    	local Distance = self.Owner:EyePos():Distance(trEntity:GetPos());
		
   		if Distance > 100 or self.Owner:GetNWBool("Player_CantRepairArmor") then return false end	
		self.Owner:SetNWBool("Player_CantRepairArmor", true)
		timer.Simple(1, function() self.Owner:SetNWBool("Player_CantRepairArmor", false) end)
		
		if trEntity:IsPlayer() and trEntity:Team() != TEAM_VORTIGAUNTSLAVE and trEntity:Team() != TEAM_VORTIGAUNT then
			local max_armor = RPExtraTeams[trEntity:Team()].maxarmor
			if trEntity:Armor() < max_armor then
				trEntity:SetArmor(math.Clamp(trEntity:Armor() + 2, 0, RPExtraTeams[trEntity:Team()].maxarmor))
				self.Owner:EmitSound("items/suitchargeok1.wav")
				self.Owner:SetAmmo(math.Clamp(self.Owner:GetAmmoCount("Battery") - 2, 0, 50), "Battery")

				if trEntity:Armor() >= max_armor then
					AddTaskExperience(self.Owner, "Восстановление брони")
				end
			end
			
			if GAMEMODE.Rebels[trEntity:Team()] then
				if trEntity:IsPlayer() and trEntity:Armor() < trEntity:GetMaxArmor()*0.7 then
					trEntity:SetArmor(math.Clamp(trEntity:Armor() + 2, 0, trEntity:GetMaxArmor()*0.7))
					self.Owner:EmitSound("items/suitchargeok1.wav")
					self.Owner:SetAmmo(math.Clamp(self.Owner:GetAmmoCount("Battery") - 2, 0, 50), "Battery")
				end
			end
		end
		
		self:SetNextPrimaryFire(CurTime() + 1)
	end
end

function SWEP:SecondaryAttack()
	if SERVER then
		if self.Owner:GetAmmoCount("Battery") <= 0 then return end
		
		local trEntity = self.Owner
		if trEntity:IsPlayer() and trEntity:Armor() < trEntity:GetMaxArmor()*0.7 then
			trEntity:SetArmor(math.Clamp(trEntity:Armor() + 2, 0, trEntity:GetMaxArmor()*0.7))
			self.Owner:EmitSound("items/suitchargeok1.wav")
			self.Owner:SetAmmo(math.Clamp(self.Owner:GetAmmoCount("Battery") - 2, 0, 50), "Battery")
		end
		
		self:SetNextPrimaryFire(CurTime() + 1)
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

		self:SetMaterial("models/Items/battery.mdl")
		self:DrawModel()
	end
end

end
