-- "addons\\rised_job_system\\lua\\entities\\npc_cwu\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Base = "base_ai" 
ENT.Type = "ai"
ENT.PrintName = "NPC - CWU"
ENT.Category = "A - Rised - [Работа]"
ENT.Instructions = "Info"
ENT.Author = "D-Rised"
ENT.Spawnable = true

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end