-- "addons\\rised_medical_system\\lua\\entities\\hospital_npc_patient\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Base = "base_ai" 
ENT.Type = "ai"
ENT.PrintName = "NPC - пациент"
ENT.Instructions = "Base entity"
ENT.Category = "A - Rised - [Медицина]"
ENT.Author = "Angel Code"
ENT.Spawnable = true
ENT.AutomaticFrameAdvance = true

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end