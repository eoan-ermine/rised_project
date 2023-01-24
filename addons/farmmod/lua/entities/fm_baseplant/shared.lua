-- "addons\\farmmod\\lua\\entities\\fm_baseplant\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Dirt"
ENT.Author = "D-Rised"
ENT.Category = "A - Rised - [Еда]"
ENT.Spawnable = false
ENT.AdminSpawnable = false

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "dist_harvest")
end