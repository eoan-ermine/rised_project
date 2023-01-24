-- "addons\\lcdprinters\\lua\\entities\\lcd_printer\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[---------------------------------------------------------------------------
This is an example of a custom entity.
---------------------------------------------------------------------------]]
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "LCD Printer"
ENT.Author = "jurplel"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Category = "A - Rised - [Крафт]"

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "price")
	self:NetworkVar("Entity", 0, "owning_ent")
end
