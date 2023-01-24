-- "addons\\darkrpmodification\\lua\\entities\\info_npc_markers\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Base = "base_ai" 
ENT.Type = "ai"
ENT.PrintName = "Info NPC Markers"
ENT.Instructions = "Info"
ENT.Author = "D-Rised"
ENT.Spawnable = true

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end