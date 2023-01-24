-- "addons\\uweed\\lua\\entities\\uweed_npc\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
-- More basic setup
ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName = "[UWeed] NPC"
ENT.Author = "Owain Owjo"
ENT.Category = "UWeed"
ENT.Spawnable = true
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "SellPrice")
	self:NetworkVar("Int", 1, "Holding")
end
