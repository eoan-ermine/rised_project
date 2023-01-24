-- "addons\\combine_sniper\\lua\\entities\\csniper_ammo.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

ENT.Type 					= "anim"
ENT.Base 					= "base_gmodentity"

ENT.PrintName 				= "Sniper Ammo"

ENT.Author 					= "TankNut"
ENT.Category 				= "Half-Life 2"

ENT.Spawnable 				= true

ENT.Model 					= Model("models/items/sniper_round_box.mdl")
ENT.Amount 					= 10

if CLIENT then
	language.Add("SniperRound_ammo", "Combine Sniper Ammo")
end

function ENT:Initialize()
	self:SetModel(self.Model)

	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		self:SetUseType(SIMPLE_USE)
	end
end

function ENT:Use(ply)
	ply:GiveAmmo(10, "SniperRound")

	self:Remove()
end