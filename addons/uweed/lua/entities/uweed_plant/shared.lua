-- "addons\\uweed\\lua\\entities\\uweed_plant\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "[UWeed] Plant"
ENT.Author = "Owain Owjo"
ENT.Category = "UWeed"
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "owning_ent")
	self:NetworkVar("Int", 0, "Stage")
	self:NetworkVar("Int", 1, "NBodygroup")
	self:NetworkVar("Int", 2, "BudCount")
	self:NetworkVar("Int", 3, "LightLevel")
end
