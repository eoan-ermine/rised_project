-- "addons\\rised_bartender\\lua\\entities\\npc_drunker\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type = "ai"
ENT.Base = "base_ai" 
ENT.RenderGroup = RENDERGROUP_OPAQUE

ENT.PrintName = "NPC - Пьяница"
ENT.Author = "D-Rised"
ENT.Category = "A - Rised - [Бармен]"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

function ENT:SetupModel()
	self.Entity:SetModel("models/Humans/Group01/male_07.mdl")
end