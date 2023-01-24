-- "addons\\rised_cooking\\lua\\entities\\cm_bread_toast\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Тостовый хлеб"
ENT.Category = "A - Rised - [Еда]"
ENT.Author = "BananowyTasiemiec"
ENT.Spawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Int",0,"price")
	self:NetworkVar("Entity",1,"owning_ent")
end