-- "addons\\bricks-crafting\\lua\\entities\\brickscrafting_miningbase\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName		= "Mining Base"
ENT.Category		= "Bricks Crafting"
ENT.Author			= "Brick Wall"
ENT.AutomaticFrameAdvance = true
ENT.Spawnable		= false

function ENT:SetupDataTables()
    self:NetworkVar( "Int", 0, "RHealth" )
    self:NetworkVar( "Int", 1, "Stage" )
    self:NetworkVar( "Int", 2, "RockKey" )
    self:NetworkVar( "Bool", 0, "Egg" )
end

ENT.MiningType = ""