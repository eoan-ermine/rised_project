-- "addons\\bricks-crafting\\lua\\entities\\brickscrafting_benchbase\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName		= "Bench Base"
ENT.Category		= "Bricks Crafting"
ENT.Author			= "Brick Wall"
ENT.AutomaticFrameAdvance = true
ENT.Spawnable		= false

function ENT:SetupDataTables()
	self:NetworkVar( "Int", 0, "Health" )
	self:NetworkVar( "Int", 1, "UseCooldown" )
end

ENT.BenchHealth = 100
ENT.BenchType = ""