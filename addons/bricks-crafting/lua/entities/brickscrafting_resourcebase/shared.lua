-- "addons\\bricks-crafting\\lua\\entities\\brickscrafting_resourcebase\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName		= "Resource Base"
ENT.Category		= "Bricks Crafting"
ENT.Author			= "Brick Wall"
ENT.AutomaticFrameAdvance = true
ENT.Spawnable		= false

function ENT:SetupDataTables()
    self:NetworkVar( "Int", 0, "Amount" )
end

ENT.ResourceType = ""