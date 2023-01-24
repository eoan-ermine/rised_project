-- "addons\\bricks-crafting\\lua\\entities\\brickscrafting_treebase\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName		= "Tree Base"
ENT.Category		= "Bricks Crafting"
ENT.Author			= "Brick Wall"
ENT.AutomaticFrameAdvance = true
ENT.Spawnable		= false

function ENT:SetupDataTables()
end

ENT.TreeType = ""