-- "addons\\led_screens\\lua\\entities\\gb_rp_sign_wire\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type = "anim"
ENT.Base = "base_wire_entity"
ENT.PrintName = "Spawned Sign Wire"
ENT.WireDebugName	= "LED Screen"
ENT.Author = "Mac"
ENT.Spawnable = false
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "Text")
	self:NetworkVar("Vector", 0, "TColor")
	self:NetworkVar("Int", 0, "Type")
	self:NetworkVar("Int", 1, "Speed")
	self:NetworkVar("Int", 2, "Wide")
	self:NetworkVar("Int", 3, "On")
	self:NetworkVar("Int", 4, "FX")
end