-- "addons\\rebel_posters_system\\lua\\entities\\rps_poster_01_big\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName= "Постер 1B"
ENT.Author= "D-Rised"
ENT.Purpose		= ""
ENT.Instructions= ""
ENT.Category		= "A - Rised - [Повстанцы]"

ENT.Editable		= true
ENT.Spawnable		= true
ENT.AdminOnly		= true

function ENT:Initialize()
	-- if CLIENT then
	-- 	timer.Simple(1, function()
	-- 		CreateMaterial( "map_poster", "VertexLitGeneric", {
	-- 			["$basetexture"] = "plakat",
	-- 			["$model"] = 1,
	-- 			["$translucent"] = 1,
	-- 			["$vertexalpha"] = 1,
	-- 			["$vertexcolor"] = 1
	-- 		})

	-- 		self:SetMaterial("!map_poster" )
	-- 	end)
	-- end
end