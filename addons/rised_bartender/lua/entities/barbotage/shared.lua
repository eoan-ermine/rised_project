-- "addons\\rised_bartender\\lua\\entities\\barbotage\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Barbotage"
ENT.Author = "Lightblue"
ENT.Contact = "Steam"
ENT.Purpose = "english powa"
ENT.Instructions = "E" 
ENT.Category = "A - Rised - [Бармен]"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

function ENT:SetupModel()

	self.Entity:SetModel("models/barbotage/barbotage.mdl")
	
end