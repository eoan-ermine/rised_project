-- "addons\\rised_ration\\lua\\entities\\combine_foodstack.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

ENT.Type = "anim"

ENT.PrintName = "Combine FoodStack"

ENT.Author = "D-Rised"

ENT.Category = "HL2 RP"

ENT.Spawnable = true

ENT.AdminOnly = true

ENT.PhysgunDisable = true

ENT.PhysgunAllowAdmin = true
ENT.RenderGroup = 9

if (CLIENT) then
	function ENT:Draw()
		self:DrawModel()
	end
else
	function ENT:Initialize()
		self:SetModel("models/props/cs_militia/food_stack.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:DrawShadow(false)
		self:SetNWInt("Combine_FoodCount", 5)

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end
	end

	function ENT:Use(activator)
		if !activator:isCP() then return end

		local account = tostring(activator:AccountID())
		
		if self:GetNWInt(account) > CurTime() then
			DarkRP.notify(activator, 1,4, 'Ваша очередь ещё не подошла. Осталось: ' .. math.Round(self:GetNWInt(account) - CurTime(), 0))
			return
		end

		if self:GetNWInt("Combine_FoodCount") <= 0 then
			DarkRP.notify(activator, 1,4, 'Ящики с провизией пусты.')
			return
		end

		self:SetNWInt(account, CurTime() + 1800) // 30 минут

		local ent = ents.Create('combine_food')
		ent:SetPos(activator:GetEyeTrace().HitPos - activator:GetAngles():Forward() * 15 - activator:GetAngles():Up() * 15)
		ent:Spawn()
		self:EmitSound("physics/cardboard/cardboard_box_impact_hard" .. math.random(1,3) .. ".wav")
	end

	function ENT:PhysicsCollide(data, phys)
		if data.HitEntity:GetClass() == "rc_combine_food_box" then
			self:SetNWInt("Combine_FoodCount", self:GetNWInt("Combine_FoodCount") + 15)
			data.HitEntity:Remove()
		end
	end
end