-- "addons\\rised_bartender\\lua\\entities\\blackvelvet\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Black velvet"
ENT.Author = "Lightblue"
ENT.Contact = "Steam"
ENT.Purpose = "english powa"
ENT.Instructions = "E" 
ENT.Category = "A - Rised - [Бармен]"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

function ENT:SetupModel()

	self.Entity:SetModel("models/black velvet/black velvet.mdl")
	
end