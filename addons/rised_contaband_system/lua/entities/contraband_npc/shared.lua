-- "addons\\rised_contaband_system\\lua\\entities\\contraband_npc\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Base = "base_ai" 
ENT.Type = "ai"
ENT.PrintName = "NPC - Контрабанды"
ENT.Category = "A - Rised - [Криминал]"
ENT.Instructions = "Info"
ENT.Author = "D-Rised"
ENT.Spawnable = true

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end