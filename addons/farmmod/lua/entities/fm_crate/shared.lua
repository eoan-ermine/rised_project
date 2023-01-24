-- "addons\\farmmod\\lua\\entities\\fm_crate\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Ящик"
ENT.Author = "D-Rised"
ENT.Category = "A - Rised - [Еда]"
ENT.Spawnable = true
ENT.AdminSpawnable = false

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Value")
end