-- "addons\\bricks-crafting\\lua\\brickscrafting\\brickscrafting_administration.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
function BRICKSCRAFTING.GetAdminGroup( ply )
	if( BRICKSCRAFTING.LUACONFIG.AdminSystem == "Serverguard" ) then
		return serverguard.player:GetRank(ply)
	elseif( BRICKSCRAFTING.LUACONFIG.AdminSystem == "xAdmin" ) then
		return ply:xAdminGetTag()
	else
		return ply:GetNWString("usergroup")
	end
end

function BRICKSCRAFTING.HasAdminAccess( ply )
	return BRICKSCRAFTING.LUACONFIG.AdminRanks[BRICKSCRAFTING.GetAdminGroup( ply )]
end

--[[ ADMINISTRATION MENU ]]--
if( SERVER ) then
	--[[ CONFIG ]]--
	function BRICKSCRAFTING.SaveConfig()
		local Config = BRICKSCRAFTING.CONFIG
		if( Config != nil ) then
			if( not istable( Config ) ) then
				BRICKSCRAFTING.LoadConfig()
				return
			end
		else
			BRICKSCRAFTING.LoadConfig()
			return
		end
		
		local ConfigJSON = util.TableToJSON( Config )

		if( not file.Exists( "brickscrafting", "DATA" ) ) then
			file.CreateDir( "brickscrafting" )
		end
		
		file.Write( "brickscrafting/config.txt", ConfigJSON )
	end

	util.AddNetworkString( "BCS_Net_SendConfig" )
	function BRICKSCRAFTING.SendConfig( ply )
		net.Start( "BCS_Net_SendConfig" )
			net.WriteTable( BRICKSCRAFTING.CONFIG )
		net.Send( ply )
	end

	hook.Add( "PlayerInitialSpawn", "BCSHooks_PlayerInitialSpawn_ConfigSend", function( ply )
		if( IsValid( ply ) ) then
			BRICKSCRAFTING.SendConfig( ply )
		end
	end )

	util.AddNetworkString( "BCS_Net_UpdateConfig" )
	net.Receive( "BCS_Net_UpdateConfig", function( len, ply )
		local NewConfig = net.ReadTable()

		if( not NewConfig ) then return end
		if( not BRICKSCRAFTING.HasAdminAccess( ply ) ) then return end

		if( istable( NewConfig ) ) then 
			BRICKSCRAFTING.CONFIG = NewConfig

			net.Start( "BCS_Net_SendConfig" )
				net.WriteTable( BRICKSCRAFTING.CONFIG )
			net.Broadcast()

			BRICKSCRAFTING.SaveConfig()

			ply:NotifyBCS_Chat( BRICKSCRAFTING.L("configSaved"), "materials/brickscrafting/general_icons/config.png" )

			BRICKSCRAFTING.LoadEntities()
		end
	end )

	util.AddNetworkString( "BCS_Net_CloseAdminMenu" )
	net.Receive( "BCS_Net_CloseAdminMenu", function( len, ply )
		if( not BRICKSCRAFTING.HasAdminAccess( ply ) ) then return end

		BRICKSCRAFTING.SendConfig( ply )
	end )

	-- Opening Menu --
	util.AddNetworkString( "BCS_Net_OpenAdmin" )
	hook.Add( "PlayerSay", "BCSHooks_PlayerSay_Administration", function( ply, text, teamChat )
		if( text == "!brickscrafting" ) then
			if( BRICKSCRAFTING.HasAdminAccess( ply ) ) then
				net.Start( "BCS_Net_OpenAdmin" )

				net.Send( ply )
			else
				ply:NotifyBCS( BRICKSCRAFTING.L("adminNoPermission") )
			end
		end
	end )

	-- Resource Giving --
	util.AddNetworkString( "BCS_Net_AssignResources" )
	net.Receive( "BCS_Net_AssignResources", function( len, ply )
		local SteamID64 = net.ReadString()
		local Resources = net.ReadTable()

		if( not SteamID64 or not Resources ) then return end
		if( not BRICKSCRAFTING.HasAdminAccess( ply ) ) then return end

		local receiver = player.GetBySteamID64( SteamID64 )

		if( IsValid( receiver ) ) then
			local AddResources = receiver:AddBCS_InventoryResource( Resources )

			if( AddResources != false ) then
				ply:NotifyBCS( string.format( BRICKSCRAFTING.L("adminResourcesAdded"), receiver:Nick() ) )
				
				local ResString = ""
				local Count = 0
				for k, v in pairs( Resources ) do

					if( Count == table.Count( Resources)-1 ) then
						ResString = ResString .. string.Comma( v ) .. " " .. k
					elseif( Count == table.Count( Resources)-2 ) then
						ResString = ResString .. string.Comma( v ) .. " " .. k .. " and "
						Count = Count+1
					else
						ResString = ResString .. string.Comma( v ) .. " " .. k .. ", "
						Count = Count+1
					end
				end

				receiver:NotifyBCS( string.format( BRICKSCRAFTING.L("adminAddedToStorage"), ResString ) )

				receiver:NotifyBCS_Chat( "+" .. ResString, "materials/brickscrafting/general_icons/newitem.png" )
			else
				ply:NotifyBCS( BRICKSCRAFTING.L("adminFailedToAddRes") )
			end
		else
			ply:NotifyBCS( BRICKSCRAFTING.L("invalidPlayer") )
		end
	end )

	-- Resource Giving --
	util.AddNetworkString( "BCS_Net_SetSkill" )
	net.Receive( "BCS_Net_SetSkill", function( len, ply )
		local SteamID64 = net.ReadString()
		local BenchType = net.ReadString()
		local SkillLevel = net.ReadInt( 32 )

		if( not SteamID64 or not BenchType or not SkillLevel ) then return end
		if( not BRICKSCRAFTING.HasAdminAccess( ply ) ) then return end

		local receiver = player.GetBySteamID64( SteamID64 )

		if( IsValid( receiver ) ) then
			receiver:SetBCS_SkillLevel( BenchType, SkillLevel )

			local Skill = BenchType
			if( BRICKSCRAFTING.CONFIG.Crafting[BenchType] and BRICKSCRAFTING.CONFIG.Crafting[BenchType].Skill and BRICKSCRAFTING.CONFIG.Crafting[BenchType].Skill[1] ) then
				Skill = BRICKSCRAFTING.CONFIG.Crafting[BenchType].Skill[1]
			end
			ply:NotifyBCS( string.format( BRICKSCRAFTING.L("vguiAdminPlayersSkillSet"), receiver:Nick(), Skill, SkillLevel ) )
			receiver:NotifyBCS( string.format( BRICKSCRAFTING.L("vguiAdminPlayersSkillYourSet"), Skill, SkillLevel ) )
		else
			ply:NotifyBCS( BRICKSCRAFTING.L("invalidPlayer") )
		end
	end )

	-- Storage Clearing --
	util.AddNetworkString( "BCS_Net_ClearStorage" )
	net.Receive( "BCS_Net_ClearStorage", function( len, ply )
		local SteamID64 = net.ReadString()
		local ClearResources = net.ReadBool()

		if( not SteamID64 or ClearResources == nil ) then return end
		if( not BRICKSCRAFTING.HasAdminAccess( ply ) ) then return end

		local receiver = player.GetBySteamID64( SteamID64 )

		if( IsValid( receiver ) ) then
			if( ClearResources ) then
				receiver:SetBCS_Inventory( {} )

				ply:NotifyBCS( string.format( BRICKSCRAFTING.L("adminStorageResCleared"), (receiver:Nick() or "Invalid") ) )
				receiver:NotifyBCS( BRICKSCRAFTING.L("adminYourStorageResCleared") )
			else
				local Resources = {}

				if( receiver:GetBCS_Inventory().Resources ) then
					Resources = receiver:GetBCS_Inventory().Resources
				end

				local NewInventory = {}
				NewInventory.Resources = Resources

				receiver:SetBCS_Inventory( NewInventory )

				ply:NotifyBCS( string.format( BRICKSCRAFTING.L("adminStorageCleared"), (receiver:Nick() or "Invalid") ) )
				receiver:NotifyBCS( BRICKSCRAFTING.L("adminYourStorageCleared") )
			end
		else
			ply:NotifyBCS( BRICKSCRAFTING.L("invalidPlayer") )
		end
	end )

	-- Data Clearing --
	util.AddNetworkString( "BCS_Net_ClearData" )
	net.Receive( "BCS_Net_ClearData", function( len, ply )
		local SteamID64 = net.ReadString()

		if( not SteamID64 ) then return end
		if( not BRICKSCRAFTING.HasAdminAccess( ply ) ) then return end

		local receiver = player.GetBySteamID64( SteamID64 )

		if( IsValid( receiver ) ) then
			receiver:SetBCS_Inventory( {} )
			receiver:SetBCS_MiscTable( {} )
			receiver:SetBCS_Skills( {} )

			ply:NotifyBCS( string.format( BRICKSCRAFTING.L("adminDataCleared"), (receiver:Nick() or "Invalid")) )
			receiver:NotifyBCS( BRICKSCRAFTING.L("adminYourDataCleared") )
		else
			ply:NotifyBCS( BRICKSCRAFTING.L("invalidPlayer") )
		end
	end )

	-- Assign Quests --
	util.AddNetworkString( "BCS_Net_AdminQuest" )
	net.Receive( "BCS_Net_AdminQuest", function( len, ply )
		local SteamID64 = net.ReadString()
		local QuestKey = net.ReadInt( 32 )
		local GiveRewards = net.ReadBool()

		if( not SteamID64 or not QuestKey or GiveRewards == nil ) then return end
		if( not BRICKSCRAFTING.HasAdminAccess( ply ) ) then return end
		if( not BRICKSCRAFTING.CONFIG.Quests[QuestKey] ) then return end

		local receiver = player.GetBySteamID64( SteamID64 )

		if( IsValid( receiver ) ) then
			if( GiveRewards ) then
				local GiveQuest = receiver:AddBCS_QuestCompleted( QuestKey, false )

				if( GiveQuest ) then
					ply:NotifyBCS(string.format( BRICKSCRAFTING.L("adminQuestRewardsGiven"), (receiver:Nick() or "Invalid"), BRICKSCRAFTING.CONFIG.Quests[QuestKey].Name ) )
					receiver:NotifyBCS( string.format(BRICKSCRAFTING.L("adminGivenQuestRewards"), BRICKSCRAFTING.CONFIG.Quests[QuestKey].Name) )
				else
					ply:NotifyBCS( BRICKSCRAFTING.L("adminFailedToGiveQuest") )
				end
			else
				local GiveQuest = receiver:AddBCS_QuestCompleted( QuestKey, true )

				if( GiveQuest ) then
					ply:NotifyBCS(string.format( BRICKSCRAFTING.L("adminQuestGiven"), (receiver:Nick() or "Invalid"), BRICKSCRAFTING.CONFIG.Quests[QuestKey].Name ) )
					receiver:NotifyBCS( string.format(BRICKSCRAFTING.L("adminGivenQuest"), BRICKSCRAFTING.CONFIG.Quests[QuestKey].Name) )
				else
					ply:NotifyBCS( BRICKSCRAFTING.L("adminFailedToGiveQuest") )
				end
			end
		else
			ply:NotifyBCS( BRICKSCRAFTING.L("invalidPlayer") )
		end
	end )

	-- Entity saving --
	concommand.Add( "bcs_saveentpositions", function( ply, cmd, args )
		if( BRICKSCRAFTING.HasAdminAccess( ply ) ) then
			local Entities = {}
			local PlaceableEnts = BRICKSCRAFTING.GetPlaceableEnts()
			for k, v in pairs( PlaceableEnts ) do
				for key, ent in pairs( ents.FindByClass( k ) ) do
					local EntVector = string.Explode(" ", tostring(ent:GetPos()))
					local EntAngles = string.Explode(" ", tostring(ent:GetAngles()))
					
					local EntTable = {
						Class = k,
						Position = ""..(EntVector[1])..";"..(EntVector[2])..";"..(EntVector[3])..";"..(EntAngles[1])..";"..(EntAngles[2])..";"..(EntAngles[3])..""
					}
					
					table.insert( Entities, EntTable )
				end
			end
			
			file.Write("brickscrafting/saved_ents/".. string.lower(game.GetMap()) ..".txt", util.TableToJSON( Entities ), "DATA")
			ply:NotifyBCS( "Entity positions updated." )
		else
			ply:NotifyBCS( "You don't have permission to use this command." )
		end
	end )
	
	concommand.Add( "drpf_clearentpositions", function( ply, cmd, args )
		if( BRICKSCRAFTING.HasAdminAccess( ply ) ) then
			local PlaceableEnts = BRICKSCRAFTING.GetPlaceableEnts()
			for k, v in pairs( ents.GetAll() ) do
				if( PlaceableEnts[v:GetClass()] ) then
					v:Remove()
				end
				
				if( file.Exists( "brickscrafting/saved_ents/".. string.lower(game.GetMap()) ..".txt", "DATA" ) ) then
					file.Delete( "brickscrafting/saved_ents/".. string.lower(game.GetMap()) ..".txt" )
				end
			end
		else
			ply:NotifyBCS( "You don't have permission to use this command." )
		end
	end )
	
	local function SpawnEntities()
		if not file.IsDir("brickscrafting/saved_ents", "DATA") then
			file.CreateDir("brickscrafting/saved_ents", "DATA")
		end
		
		local Entities = {}
		if( file.Exists( "brickscrafting/saved_ents/".. string.lower(game.GetMap()) ..".txt", "DATA" ) ) then
			Entities = ( util.JSONToTable( file.Read( "brickscrafting/saved_ents/".. string.lower(game.GetMap()) ..".txt", "DATA" ) ) )
		end
		
		BCS_ROCKS = {}
		BCS_GARBAGE = {}
		if( table.Count( Entities ) > 0 ) then
			local PlaceableEnts = BRICKSCRAFTING.GetPlaceableEnts()
			for k, v in pairs( Entities ) do
				if( PlaceableEnts[v.Class] ) then
					local ThePosition = string.Explode( ";", v.Position )
					
					local TheVector = Vector(ThePosition[1], ThePosition[2], ThePosition[3])
					local TheAngle = Angle(tonumber(ThePosition[4]), ThePosition[5], ThePosition[6])
					local NewEnt = ents.Create( v.Class )
					NewEnt:SetPos(TheVector)
					NewEnt:SetPos( TheVector )
					NewEnt:SetAngles(TheAngle)
					NewEnt:Spawn()

					if( string.StartWith( v.Class, "brickscrafting_mining" ) ) then
						local RockTable = { v.Class, TheVector, TheAngle }
						local Key = #BCS_ROCKS+1
						BCS_ROCKS[Key] = RockTable

						NewEnt:SetRockKey( Key )
					elseif( v.Class == "brickscrafting_garbage" ) then
						local GarbageTable = { TheVector, TheAngle }
						local Key = #BCS_GARBAGE+1
						BCS_GARBAGE[Key] = GarbageTable

						NewEnt:SetGarbageKey( Key )
					end
				else
					Entities[k] = nil
				end
			end
			
			print( "[Brick's Crafting] " .. table.Count( Entities ) .. " saved Entities were spawned." )
		else
			print( "[Brick's Crafting] No saved Entities were spawned." )
		end
	end
	hook.Add( "InitPostEntity", "BCSHooks_InitPostEntity_LoadEntities", SpawnEntities )
	hook.Add( "PostCleanupMap", "BCSHooks_PostCleanupMap_LoadEntities", SpawnEntities )

	-- Mining Saving --
elseif( CLIENT ) then
	-- CONFIG --
	net.Receive( "BCS_Net_SendConfig", function( len, ply )
		local ConfigTable = net.ReadTable()
		BRICKSCRAFTING.CONFIG = ConfigTable

		BRICKSCRAFTING.LoadEntities()

		if( not BRICKSCRAFTING.CONFIGLOADED ) then
			hook.Run( "BRCS.ConfigLoaded" )
			BRICKSCRAFTING.CONFIGLOADED = true
		end
	end )

	-- Admin Menu --
	net.Receive( "BCS_Net_OpenAdmin", function( len, ply )
		if( not IsValid( BCS_AdminMenu ) ) then
			BCS_AdminMenu = vgui.Create( "bcs_vgui_admin" )
		end
	end )
end