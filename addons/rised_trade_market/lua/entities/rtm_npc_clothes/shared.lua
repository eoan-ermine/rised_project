-- "addons\\rised_trade_market\\lua\\entities\\rtm_npc_clothes\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Base = "base_ai" 
ENT.Type = "ai"
ENT.PrintName = "NPC - Торговец Одеждой"
ENT.Category = "A - Rised - [Персонажи]"
ENT.Instructions = "Info"
ENT.Author = "D-Rised"
ENT.Spawnable = true
ENT.AutomaticFrameAdvance = true

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end