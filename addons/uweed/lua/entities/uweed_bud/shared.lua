-- "addons\\uweed\\lua\\entities\\uweed_bud\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "[UWeed] Bud"
ENT.Author = "Owain Owjo"
ENT.Category = "UWeed"
ENT.Spawnable = true
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "owning_ent")
	self:NetworkVar("Int", 0, "BudCounter")
	self:NetworkVar("Int", 1, "EstimateHigher")
	self:NetworkVar("Int", 1, "EstimateLower")
end

ENT.Weight = 0.2

