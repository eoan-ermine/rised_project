-- "addons\\bricks-crafting\\lua\\entities\\brickscrafting_npc\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Base = "base_ai" 
ENT.Type = "ai"
 
ENT.PrintName		= BRICKSCRAFTING.L("craftingNPC")
ENT.Category		= "Bricks Crafting"
ENT.Author			= "Brick Wall"
ENT.AutomaticFrameAdvance = true
ENT.Spawnable		= true

function ENT:SetupDataTables()
    self:NetworkVar( "Int", 0, "UseCooldown" )
end

BCS_CraftingNPCs = {}
function ENT:Initialize()
	BCS_CraftingNPCs[self] = true
end

function ENT:OnRemove()
    BCS_CraftingNPCs[self] = nil
end