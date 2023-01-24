-- "addons\\rised_bartender\\lua\\entities\\chicagofizz\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Chicago fizz"
ENT.Author = "Lightblue"
ENT.Contact = "Steam"
ENT.Purpose = "chocolate nit cream and liqueur"
ENT.Instructions = "E" 
ENT.Category = "A - Rised - [Бармен]"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

function ENT:SetupModel()

	self.Entity:SetModel("models/chicago fizz/chicago fizz.mdl")
	
end