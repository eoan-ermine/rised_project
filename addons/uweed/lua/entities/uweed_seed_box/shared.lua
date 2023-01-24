-- "addons\\uweed\\lua\\entities\\uweed_seed_box\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "[UWeed] Seed Box"
ENT.Author = "Owain Owjo"
ENT.Category = "UWeed"
ENT.Spawnable = true
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "SeedCount")
	self:NetworkVar("Entity", 0, "owning_ent")

	self:NetworkVar("Bool", 0, "FirstSpawn")
end

ENT.Weight = 1.6
