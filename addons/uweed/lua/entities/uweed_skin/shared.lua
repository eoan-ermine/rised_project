-- "addons\\uweed\\lua\\entities\\uweed_skin\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "[UWeed] Rolling Skin"
ENT.Author = "Owain Owjo"
ENT.Category = "UWeed"
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Progress")
	self:NetworkVar("Int", 0, "Stage")
	self:NetworkVar("Entity", 0, "owning_ent")
	self:NetworkVar("Bool", 0, "FirstSpawn")
end

ENT.Weight = 0.1
