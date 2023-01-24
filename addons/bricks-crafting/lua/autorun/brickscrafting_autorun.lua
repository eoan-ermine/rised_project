-- "addons\\bricks-crafting\\lua\\autorun\\brickscrafting_autorun.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if( SERVER ) then
	resource.AddWorkshop( 1876135550 )
end

BRICKSCRAFTING = {}

--[[ CONFIG LOADER ]]--
BRICKSCRAFTING.CONFIG = {}

AddCSLuaFile( "brickscrafting_luaconfig.lua" )
include( "brickscrafting_luaconfig.lua" )
AddCSLuaFile( "brickscrafting_baseconfig.lua" )
include( "brickscrafting_baseconfig.lua" )

function BRICKSCRAFTING.LoadConfig()
	local ConfigTable = BRICKSCRAFTING.BASECONFIG

	if( file.Exists( "brickscrafting/config.txt", "DATA" ) ) then
		local FileTable = file.Read( "brickscrafting/config.txt", "DATA" )
		FileTable = util.JSONToTable( FileTable )
		
		if( FileTable != nil ) then
			if( istable( FileTable ) ) then
				ConfigTable = FileTable
			end
		end
	end

	BRICKSCRAFTING.CONFIG = ConfigTable
end
BRICKSCRAFTING.LoadConfig()

if( SERVER and not BRICKSCRAFTING.CONFIGLOADED ) then
	hook.Run( "BRCS.ConfigLoaded" )
	BRICKSCRAFTING.CONFIGLOADED = true
end

--[[ LOADS FILES ]]--
for k, v in pairs( file.Find( "brickscrafting/languages/*", "LUA" ) ) do
	if( string.Replace( v, ".lua" ) == (BRICKSCRAFTING.LUACONFIG.Language or "") ) then
		AddCSLuaFile( "brickscrafting/languages/" .. v )
		include( "brickscrafting/languages/" .. v )
		
		print( "[BRICKSCRAFTING] " .. BRICKSCRAFTING.LUACONFIG.Language .. " language loaded" )
	end
end

function BRICKSCRAFTING.L( languageString )
	if( BRICKSCRAFTING.Language and BRICKSCRAFTING.Language[languageString] ) then
		return BRICKSCRAFTING.Language[languageString]
	else
		return "MISSING LANGUAGE"
	end
end

AddCSLuaFile( "brickscrafting_types.lua" )
include( "brickscrafting_types.lua" )

local files, directories = file.Find( "brickscrafting/*", "LUA" )
for k, v in pairs( directories ) do
	if( v == "server" ) then
		for key2, val2 in pairs( file.Find( "brickscrafting/" .. v .. "/*.lua", "LUA" ) ) do
			if( SERVER ) then
				include( "brickscrafting/" .. v .. "/" .. val2 )
			end
			
			print( "[BRICKSCRAFTING] SERVER " .. val2 .. " loaded" )
		end
	elseif( v == "client" ) then
		for key2, val2 in pairs( file.Find( "brickscrafting/" .. v .. "/*.lua", "LUA" ) ) do
			if( CLIENT ) then
				include( "brickscrafting/" .. v .. "/" .. val2 )
			elseif( SERVER ) then
				AddCSLuaFile( "brickscrafting/" .. v .. "/" .. val2 )
			end
			
			print( "[BRICKSCRAFTING] CLIENT " .. val2 .. " loaded" )
		end
	end
end

for k, v in pairs( files ) do
	AddCSLuaFile( "brickscrafting/" .. v )
	include( "brickscrafting/" .. v )
	
	print( "[BRICKSCRAFTING] SHARED " .. v .. " loaded" )
end

function BRICKSCRAFTING.LoadEntities()
	--[[ CREATES BENCHES ]]--
	for k, v in pairs( BRICKSCRAFTING.CONFIG.Crafting ) do
		local ENT = {}
		ENT.Type = "anim"
		ENT.Base = "brickscrafting_benchbase"
		
		ENT.PrintName = v.Name
		ENT.Category		= "Bricks Crafting"
		ENT.Author			= "Brick Wall"
		
		ENT.AutomaticFrameAdvance = true
		ENT.Spawnable = true
		ENT.AdminSpawnable = true
		
		ENT.BenchType = k

		scripted_ents.Register( ENT, "brickscrafting_bench_" .. string.Replace( string.lower( k ), " ", "" ) )
	end

	--[[ CREATES RESOURCES ]]--
	for k, v in pairs( BRICKSCRAFTING.CONFIG.Resources ) do
		local ENT = {}
		ENT.Type = "anim"
		ENT.Base = "brickscrafting_resourcebase"
		
		ENT.PrintName = "Resource - " .. k
		ENT.Category		= "Bricks Crafting"
		ENT.Author			= "Brick Wall"
		
		ENT.Spawnable = true
		ENT.AdminSpawnable = true
		
		ENT.ResourceType = k

		scripted_ents.Register( ENT, "brickscrafting_resource" .. string.Replace( string.lower( k ), " ", "" ) )
	end

	--[[ CREATES MINING ROCKS ]]--
	for k, v in pairs( BRICKSCRAFTING.CONFIG.Mining ) do
		local ENT = {}
		ENT.Type = "anim"
		ENT.Base = "brickscrafting_miningbase"
		
		ENT.PrintName = "Rock - " .. k
		ENT.Category		= "Bricks Crafting"
		ENT.Author			= "Brick Wall"
		
		ENT.Spawnable = true
		ENT.AdminSpawnable = true
		
		ENT.MiningType = k

		scripted_ents.Register( ENT, "brickscrafting_mining" .. string.Replace( string.lower( k ), " ", "" ) )
	end

	--[[ CREATES TREES ]]--
	for k, v in pairs( BRICKSCRAFTING.CONFIG.WoodCutting ) do
		local ENT = {}
		ENT.Type = "anim"
		ENT.Base = "brickscrafting_treebase"
		
		ENT.PrintName = "Tree - " .. k
		ENT.Category		= "Bricks Crafting"
		ENT.Author			= "Brick Wall"
		
		ENT.Spawnable = true
		ENT.AdminSpawnable = true
		
		ENT.TreeType = k

		scripted_ents.Register( ENT, "brickscrafting_tree" .. string.Replace( string.lower( k ), " ", "" ) )
	end
end
BRICKSCRAFTING.LoadEntities()

--[[ Gets placeable entitites ]]--
function BRICKSCRAFTING.GetPlaceableEnts()
	local PlaceableEnts = {}
	PlaceableEnts["brickscrafting_npc"] = true
	PlaceableEnts["brickscrafting_garbage"] = true
	for k, v in pairs( BRICKSCRAFTING.CONFIG.Mining ) do
		PlaceableEnts["brickscrafting_mining" .. string.Replace( string.lower( k ), " ", "" )] = true
	end
	for k, v in pairs( BRICKSCRAFTING.CONFIG.WoodCutting ) do
		PlaceableEnts["brickscrafting_tree" .. string.Replace( string.lower( k ), " ", "" )] = true
	end

	return PlaceableEnts
end

--[[ Add experience ]]--
function BRICKSCRAFTING.AddExperience( ply, amount, reason )
	if( BRICKSCRAFTING.LUACONFIG.EnableLeveling != true ) then return end

	if( DARKRP_ESSENTIALS or DarkRPFoundation or UUI ) then
		ply:AddExperience( amount, (reason or "") )
	elseif( Sublime ) then
		ply:SL_AddExperience(amount, (reason or ""), true )
	else
		ply:addXP( amount, true )
	end
end