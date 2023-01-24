-- "addons\\rised_factory_metal\\lua\\entities\\mf_npc\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type 		= "ai"
ENT.Base 		= "base_ai"
ENT.Spawnable		= true
ENT.AdminSpawnable	= true

ENT.Category 		= "A - Rised - [ГСР Завод - металл]"
ENT.PrintName	= "NPC - Raw metal"
ENT.Author		= "D-Rised"
ENT.AutomaticFrameAdvance = true

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end
