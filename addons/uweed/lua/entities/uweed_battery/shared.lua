-- "addons\\uweed\\lua\\entities\\uweed_battery\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "[UWeed] Battery"
ENT.Author = "Owain Owjo"
ENT.Category = "UWeed"
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "owning_ent")
end

ENT.Weight = 0.2