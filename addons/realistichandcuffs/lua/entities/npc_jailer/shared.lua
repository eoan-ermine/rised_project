-- "addons\\realistichandcuffs\\lua\\entities\\npc_jailer\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.Category = "A - Rised - [Альянс]"

ENT.Spawnable = true
ENT.PrintName		= "NPC - Тюремщик"
ENT.Author			= "ToBadForYou"
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions	= ""
ENT.AutomaticFrameAdvance = true

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end