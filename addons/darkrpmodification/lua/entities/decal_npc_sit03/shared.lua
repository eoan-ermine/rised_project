-- "addons\\darkrpmodification\\lua\\entities\\decal_npc_sit03\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Base = "base_ai" 
ENT.Type = "ai"
ENT.PrintName = "Потрачено"
ENT.Instructions = "Base entity"
ENT.Category = "A - Rised - [Персонажи]"
ENT.Author = "Angel Code"
ENT.Spawnable = true

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end