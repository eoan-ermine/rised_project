-- "addons\\darkrpmodification\\lua\\weapons\\weapon_ticket\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

AddCSLuaFile()

if CLIENT then	
SWEP.PrintName			= "Миг. билет"		
SWEP.Slot				= 0
SWEP.SlotPos			= 6
SWEP.DrawCrosshair		= false
end

SWEP.PrintName			= "Миг. билет"
SWEP.Author = "D-Rised";
SWEP.Contact = "";
SWEP.Instructions	= ""
SWEP.Category = "A - Rised - [Карты]"

SWEP.ViewModel		= "models/props_lab/clipboard.mdl"
SWEP.WorldModel		= "models/props_lab/clipboard.mdl"

SWEP.Weight				= 0.05
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

SWEP.TicketCity			= "none"
SWEP.TicketDate			= "none"

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
		local Distance = self.Owner:EyePos():Distance(trEntity:GetPos())
		if Distance > 100 then return false end
		if trEntity:IsPlayer() then
			self.Owner:ChatPrint("Вы показали свой миграционный билет.")
			
			net.Start("idcards_show_ticket")
			net.WriteString(self.Owner:Name())
			net.WriteString(self.Owner:GetNWString("Ticket_City"))
			net.WriteString(self.Owner:GetNWString("Ticket_Date"))
			net.Send(trEntity)
		end
		
		self:SetNextPrimaryFire(CurTime() + 2)
	end
end

function SWEP:SecondaryAttack()	
	if SERVER then
		self.Owner:ChatPrint("Вы посмотрели на свой миграционный билет:")
		
		net.Start("idcards_show_ticket")
		net.WriteString(self.Owner:Name())
		net.WriteString(self.Owner:GetNWString("Ticket_City"))
		net.WriteString(self.Owner:GetNWString("Ticket_Date"))
		net.Send(self.Owner)
		
	end
		
	self:SetNextSecondaryFire(CurTime() + 2)
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
