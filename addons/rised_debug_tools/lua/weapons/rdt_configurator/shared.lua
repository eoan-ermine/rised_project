-- "addons\\rised_debug_tools\\lua\\weapons\\rdt_configurator\\shared.lua"
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

	self:SetHoldType( "pistol" )
	--self:SetHoldType( "normal" )

	if CLIENT then
		for k,v in pairs(ents.FindByClass("prop_physics")) do
			v:DrawModel()
			v:DrawShadow(false)
		end
	end

	local tr = self.Owner:GetEyeTrace()
	local ent = tr.Entity
	if SERVER then
		ent:PrecacheGibs()
	end
	ent:GibBreakClient( self.Owner:GetEyeTrace().HitNormal * 1 ) -- Break in some direction

	if SERVER then
		local ent = self.Owner:GetEyeTrace().Entity
    	local Distance = self.Owner:EyePos():Distance(ent:GetPos())
		local a = self.Owner:GetEyeTrace().HitPos
		local b = ent:GetPos() + ent:GetAngles():Right() * -40 + ent:GetAngles():Up() * -40
		local ply = self.Owner
		
		ply:ChatPrint(tostring(ent))
		ply:ChatPrint(ent:GetName())
	end
end

function SWEP:SecondaryAttack()	
	if SERVER then
		local trEntity = self.Owner:GetEyeTrace().Entity
    	local Distance = self.Owner:EyePos():Distance(trEntity:GetPos());		
		
		self.Owner:ChatPrint( tostring(trEntity) )
		self.Owner:ChatPrint( tostring(self.Owner:GetAimVector()) )
		self.Owner:ChatPrint( self.Owner:GetModel() )
	end
end
