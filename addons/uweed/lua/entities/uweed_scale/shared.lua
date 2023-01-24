-- "addons\\uweed\\lua\\entities\\uweed_scale\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "[UWeed] Scale"
ENT.Author = "Owain Owjo"
ENT.Category = "UWeed"
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "owning_ent")
	self:NetworkVar("Entity", 1, "CurrentBag")
end

ENT.Weight = 0.8
