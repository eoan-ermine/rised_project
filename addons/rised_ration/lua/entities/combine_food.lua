-- "addons\\rised_ration\\lua\\entities\\combine_food.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

ENT.Type = "anim"

ENT.PrintName = "Combine Food"

ENT.Author = "D-Rised"

ENT.Category = "HL2 RP"

ENT.Spawnable = true

ENT.AdminOnly = true

ENT.PhysgunDisable = true

ENT.PhysgunAllowAdmin = true
ENT.RenderGroup = 9

ENT.Weight = 0.5

if (CLIENT) then
	function ENT:Draw()
		self:DrawModel()
	end
else
	function ENT:Initialize()
		self:SetModel("models/mres/consumables/zag_mre.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:DrawShadow(false)
		self.canUse = true


		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:Wake()
		end
	end

	function ENT:Use(activator)
		local clamp = math.Clamp(activator:getDarkRPVar("Energy") + 75, 0, 100)
		activator:setDarkRPVar("Energy", clamp)
		activator:EmitSound("physics/wood/wood_solid_impact_soft".. math.random(1,3) ..".wav")
		self:Remove()
	end
end