-- "addons\\rised_cargo_system\\lua\\entities\\npc_cargo\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Base = "base_ai" 
ENT.Type = "ai"
ENT.PrintName = "NPC - Поставщик мебели"
ENT.Category = "A - Rised - [Поставки]"
ENT.Instructions = "Info"
ENT.Author = "D-Rised"
ENT.Spawnable = true
ENT.AutomaticFrameAdvance = true

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end