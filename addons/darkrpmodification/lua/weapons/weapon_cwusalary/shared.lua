-- "addons\\darkrpmodification\\lua\\weapons\\weapon_cwusalary\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

AddCSLuaFile()

if CLIENT then
SWEP.PrintName			= "Выдача ЗП"			
SWEP.Slot				= 3
SWEP.SlotPos			= 14
SWEP.DrawCrosshair		= false
end

SWEP.Author = "D-Rised"
SWEP.Contact = ""
SWEP.Instructions	= "Левый клик - выдать зарплату."
SWEP.Category = "A - Rised - [Гражданское]"

SWEP.ViewModel		= "models/props_lab/clipboard.mdl"
SWEP.WorldModel		= "models/props_lab/clipboard.mdl"

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
	self:SetHoldType( "normal" )
end

function SWEP:SetupDataTables()
    self:NetworkVar("Float", 2, "NextSoundTime")
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
		
		if trEntity:IsPlayer() then
			if trEntity:GetNWInt("Player_SalaryPoint") > 0 then
				
				local money = math.Round(trEntity:GetNWInt("Player_SalaryPoint") * 0.8)
				local nalog = math.Round(trEntity:GetNWInt("Player_SalaryPoint") * 0.2)
				
				if nalog < 1 then
					nalog = 1
					money = money - nalog
				end
				
				trEntity:addMoney(money)
				
				trEntity:SetNWInt("Player_SalaryPoint", 0)
				
				hook.Call("playerNotConfirmedTokensOL", GAMEMODE, trEntity)
				
				DarkRP.notify(self.Owner,2,7,"Вы собрали налог в размере " .. nalog .. " Т.")
				self.Owner:addMoney(nalog)
				
				DarkRP.notify(self.Owner,2,7,"Вы выдали " .. money .. " Т.")
				DarkRP.notify(trEntity,2,7,"Вы получили " .. money .. " Т.")
			else
				DarkRP.notify(self.Owner,2,7,"У гражданина 0 зарплатных пунктов.")
				DarkRP.notify(trEntity,2,7,"У вас 0 зарплатных пунктов.")
			end

			if trEntity:GetNWInt("Player_LoyaltyPoint") >= 1 then
		
				local loyalty = math.floor(trEntity:GetNWInt("Player_LoyaltyPoint"))
				
				trEntity:SetNWInt("LoyaltyTokens", math.Clamp(trEntity:GetNWInt("LoyaltyTokens", 0) + loyalty, -20, 100))
				hook.Call("playerLoyaltyChanged", GAMEMODE, trEntity, trEntity:GetNWInt("LoyaltyTokens"))
				
				trEntity:SetNWInt("Player_LoyaltyPoint", trEntity:GetNWInt("Player_LoyaltyPoint") - loyalty)
				
				hook.Call("playerNotConfirmedTokensOL", GAMEMODE, trEntity)
				
				DarkRP.notify(self.Owner,2,7,"Вы выдали " .. loyalty .. " очков лояльности.")
				DarkRP.notify(trEntity,2,7,"Вы получили " .. loyalty .. " очков лояльности.")
			else
				DarkRP.notify(self.Owner,2,7,"У гражданина 0 неподтвержденных ОЛ.")
				DarkRP.notify(trEntity,2,7,"У вас 0 неподтвержденных ОЛ.")
			end
		end
		
		self:SetNextPrimaryFire(CurTime() + 1)
	end
end

function SWEP:Think()
	if SERVER then
		if self.Owner:GetNWInt("Entity_Timer", 0) > 0 and CurTime() <= self:GetNextSoundTime() then 
			self.Owner:SetNWInt("Entity_Timer", self.Owner:GetNWInt("Entity_Timer") - 1)
			self:SetNextSoundTime(CurTime() + 1)
		end
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
