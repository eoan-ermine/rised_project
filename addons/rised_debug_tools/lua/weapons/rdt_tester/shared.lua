-- "addons\\rised_debug_tools\\lua\\weapons\\rdt_tester\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

if CLIENT then
	SWEP.PrintName			= "Тестер"			
	SWEP.Slot				= 3
	SWEP.SlotPos			= 15
	SWEP.DrawCrosshair		= true
end

SWEP.Author = "D-Rised";
SWEP.Contact = "";
SWEP.Instructions	= ""
SWEP.Category = "A - Rised - [Админ]"

SWEP.ViewModel			= "models/weapons/c_pistol.mdl";
SWEP.WorldModel			= "models/weapons/w_Pistol.mdl";

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.HoldType			= "normal"
SWEP.AnimPrefix 		= "normal"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

function SWEP:Initialize()
	self:SetHoldType("pistol");
end

function SWEP:PrimaryAttack()
	if SERVER then
		local tr = self.Owner:GetEyeTrace()
		local ent = tr.Entity
		local ply = self.Owner
    	local distance = self.Owner:EyePos():Distance(ent:GetPos())

		if IsValid(ent) then
			ply:ChatPrint(tostring(ent)) -- Энтити
			ply:ChatPrint(ent:GetName()) -- Имя энтити
			ply:ChatPrint(ent:GetModel()) -- Модель энтити
			ply:ChatPrint("Расстояние: " .. distance) -- Расстояние до энтити
		end
	end
end

function SWEP:SecondaryAttack()	
	if SERVER then

	end
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
