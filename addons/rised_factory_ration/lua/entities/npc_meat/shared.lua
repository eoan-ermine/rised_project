-- "addons\\rised_factory_ration\\lua\\entities\\npc_meat\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type 		= "ai"
ENT.Base 		= "base_ai"
ENT.Spawnable		= true
ENT.AdminSpawnable	= true

ENT.Category 		= "A - Rised - [ГСР]"
ENT.PrintName	= "NPC - Meat"
ENT.Author		= "D-Rised"
ENT.AutomaticFrameAdvance = true

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end
