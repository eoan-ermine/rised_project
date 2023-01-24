-- "addons\\uweed\\lua\\entities\\uweed_light_big\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "[UWeed] Big Light"
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.Author = "Owain Owjo"
ENT.Category = "UWeed"
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "owning_ent")
	self:NetworkVar("Bool", 0, "On")
	self:NetworkVar("Int", 0, "Battery")
	
	self:NetworkVar("Bool", 1, "FirstSpawn")
end
