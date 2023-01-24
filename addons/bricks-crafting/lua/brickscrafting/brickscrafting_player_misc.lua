-- "addons\\bricks-crafting\\lua\\brickscrafting\\brickscrafting_player_misc.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local ply_meta = FindMetaTable( "Player" )

function ply_meta:GetBCS_MiscTable()
	local MiscTable = {}

	if( CLIENT ) then
		if( BCS_MISCTABLE ) then
			MiscTable = BCS_MISCTABLE
		end
	elseif( SERVER ) then
		if( self.BCS_MiscTable ) then
			MiscTable = self.BCS_MiscTable
		end
	end

	return MiscTable
end

function ply_meta:GetBCS_QuestCompleted( QuestKey )
	local QuestTable = BRICKSCRAFTING.CONFIG.Quests[QuestKey]
	if( QuestTable ) then
		if( not QuestTable.Goal ) then
			return true
		end
	else
		return false
	end

	local MiscTable = self:GetBCS_MiscTable()

	if( MiscTable and MiscTable.Quests and MiscTable.Quests[QuestKey] and MiscTable.Quests[QuestKey].Status == false ) then
		if( MiscTable.Quests[QuestKey].Progress ) then
			if( table.Count( MiscTable.Quests[QuestKey].Progress ) >= table.Count( QuestTable.Goal ) ) then
				for k, v in pairs( QuestTable.Goal ) do
					if( MiscTable.Quests[QuestKey].Progress[k] and BRICKSCRAFTING.QuestTypes[k] and BRICKSCRAFTING.QuestTypes[k].MeetsGoal ) then
						for key, val in pairs( v ) do
							if( MiscTable.Quests[QuestKey].Progress[k][key] ) then
								if( not BRICKSCRAFTING.QuestTypes[k].MeetsGoal( val, MiscTable.Quests[QuestKey].Progress[k][key] ) ) then
									return false
								end
							else
								return false
							end
						end
					end
				end
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end

	return true
end

if( SERVER ) then
	util.AddNetworkString( "BCS_Net_UpdateClientMisc" )
	function ply_meta:BCS_UpdateClientMisc()
		local MiscTable = self:GetBCS_MiscTable() or {}
		
		net.Start( "BCS_Net_UpdateClientMisc" )
			net.WriteTable( MiscTable )
		net.Send( self )
	end	
	
	util.AddNetworkString( "BCS_Net_Notify" )
	function ply_meta:NotifyBCS( Message )
		net.Start( "BCS_Net_Notify" )
			net.WriteString( Message )
		net.Send( self )
	end

	function ply_meta:SetBCS_MiscTable( MiscTable, nosave )
		if( not MiscTable ) then return end
		self.BCS_MiscTable = MiscTable
		
		self:BCS_UpdateClientMisc()
		
		if( not nosave ) then
			self:SaveBCS_MiscTable()
		end
	end
	
	function ply_meta:SaveBCS_MiscTable()
		local MiscTable = self:GetBCS_MiscTable()
		if( MiscTable != nil ) then
			if( not istable( MiscTable ) ) then
				MiscTable = {}
			end
		else
			MiscTable = {}
		end
		
		local MiscTableJSON = util.TableToJSON( MiscTable )
		
		if( BRICKSCRAFTING.LUACONFIG.UseMySQL != true ) then
			if( not file.Exists( "brickscrafting/misctable", "DATA" ) ) then
				file.CreateDir( "brickscrafting/misctable" )
			end
			
			file.Write( "brickscrafting/misctable/" .. self:SteamID64() .. ".txt", MiscTableJSON )
		else
			self:BCS_UpdateDBValue( "misc", MiscTableJSON )
		end
	end
	
	hook.Add( "PlayerInitialSpawn", "BCSHooks_PlayerInitialSpawn_MiscTableLoad", function( ply )
		local MiscTable = {}
	
		if( BRICKSCRAFTING.LUACONFIG.UseMySQL != true ) then
			if( file.Exists( "brickscrafting/misctable/" .. ply:SteamID64() .. ".txt", "DATA" ) ) then
				local FileTable = file.Read( "brickscrafting/misctable/" .. ply:SteamID64() .. ".txt", "DATA" )
				FileTable = util.JSONToTable( FileTable )
				
				if( FileTable != nil ) then
					if( istable( FileTable ) ) then
						MiscTable = FileTable
					end
				end
			end
			
			ply:SetBCS_MiscTable( MiscTable, true )
		else
			ply:BCS_FetchDBValue( "misc", function( value )
				if( value ) then
					local FileTable = util.JSONToTable( value )

					if( FileTable != nil ) then
						if( istable( FileTable ) ) then
							MiscTable = FileTable
						end
					end

					ply:SetBCS_MiscTable( MiscTable, true )
				end
			end )
		end
	end )

	--[[ Pickaxe Upgrades ]]--
	function ply_meta:BCS_UpgradePickaxe()
		local MiscTable = self:GetBCS_MiscTable()

		if( BRICKSCRAFTING.CONFIG.Tools.Pickaxe[(MiscTable.PickaxeLevel or 0)+1] ) then
			MiscTable.PickaxeLevel = math.Clamp( (MiscTable.PickaxeLevel or 0)+1, 0, #BRICKSCRAFTING.CONFIG.Tools.Pickaxe )
		else
			return false
		end

		self:SetBCS_MiscTable( MiscTable )
		return true
	end

	--[[ LumberAxe Upgrades ]]--
	function ply_meta:BCS_UpgradeLumberAxe()
		local MiscTable = self:GetBCS_MiscTable()

		if( BRICKSCRAFTING.CONFIG.Tools.LumberAxe[(MiscTable.LumberAxeLevel or 0)+1] ) then
			MiscTable.LumberAxeLevel = math.Clamp( (MiscTable.LumberAxeLevel or 0)+1, 0, #BRICKSCRAFTING.CONFIG.Tools.LumberAxe )
		else
			return false
		end

		self:SetBCS_MiscTable( MiscTable )
		return true
	end

	--[[ Learnt Crafts ]]--
	function ply_meta:AddBCS_CraftLearnt( BenchType, ItemKey )
		local MiscTable = self:GetBCS_MiscTable()

		if( not MiscTable or not MiscTable.LearntCrafts or not MiscTable.LearntCrafts[BenchType] or not table.HasValue( MiscTable.LearntCrafts[BenchType], ItemKey ) ) then
			if( not MiscTable.LearntCrafts ) then
				MiscTable.LearntCrafts = {}
			end

			if( not MiscTable.LearntCrafts[BenchType] ) then
				MiscTable.LearntCrafts[BenchType] = {}
			end

			table.insert( MiscTable.LearntCrafts[BenchType], ItemKey )
		else
			return false
		end

		self:SetBCS_MiscTable( MiscTable )
		return true
	end

	--[[ Quests ]]--
	function ply_meta:AddBCS_Quest( QuestKey )
		if( not BRICKSCRAFTING.CONFIG.Quests[QuestKey] ) then return false end
		
		local QuestTable = BRICKSCRAFTING.CONFIG.Quests[QuestKey]
		local MiscTable = self:GetBCS_MiscTable()

		if( not MiscTable or not MiscTable.Quests or not MiscTable.Quests[QuestKey] ) then
			if( not MiscTable.Quests ) then
				MiscTable.Quests = {}
			end

			MiscTable.Quests[QuestKey] = {}
			MiscTable.Quests[QuestKey].Status = false
			MiscTable.Quests[QuestKey].Progress = {}
		elseif( MiscTable and MiscTable.Quests and MiscTable.Quests[QuestKey] and QuestTable.Daily ) then
			local TimeLeft = ((MiscTable.Quests[QuestKey].Time or 0)+(BRICKSCRAFTING.LUACONFIG.Defaults.QuestResetTime or 86400))-os.time()
			if( TimeLeft <= 0 ) then
				if( not MiscTable.Quests ) then
					MiscTable.Quests = {}
				end
	
				MiscTable.Quests[QuestKey] = {}
				MiscTable.Quests[QuestKey].Status = false
				MiscTable.Quests[QuestKey].Progress = {}
			else
				return false
			end
		else
			return false
		end

		self:SetBCS_MiscTable( MiscTable )
		return true
	end

	function ply_meta:RemoveBCS_Quest( QuestKey )
		if( not BRICKSCRAFTING.CONFIG.Quests[QuestKey] ) then return false end

		local MiscTable = self:GetBCS_MiscTable()

		if( MiscTable and MiscTable.Quests and MiscTable.Quests[QuestKey] ) then
			MiscTable.Quests[QuestKey] = nil
		else
			return false
		end

		self:SetBCS_MiscTable( MiscTable )
		return true
	end

	function ply_meta:GetBCS_ActiveQuests()
		local MiscTable = self:GetBCS_MiscTable()

		if( MiscTable and MiscTable.Quests ) then
			local ActiveQuests = 0

			for k, v in pairs( BRICKSCRAFTING.CONFIG.Quests ) do
				if( MiscTable.Quests[k] and MiscTable.Quests[k].Status == false ) then
					ActiveQuests = ActiveQuests+1
				end
			end

			return ActiveQuests
		else
			return 0
		end
	end

	function ply_meta:GetBCS_QuestGoal( QuestKey, GoalType, GoalKey )
		local MiscTable = self:GetBCS_MiscTable()

		if( MiscTable and MiscTable.Quests and MiscTable.Quests[QuestKey] and MiscTable.Quests[QuestKey].Status == false ) then
			if( MiscTable.Quests[QuestKey].Progress and MiscTable.Quests[QuestKey].Progress[GoalType] and MiscTable.Quests[QuestKey].Progress[GoalType][GoalKey] ) then
				return MiscTable.Quests[QuestKey].Progress[GoalType][GoalKey] or false
			end
		else
			return false
		end
	end

	function ply_meta:UpdateBCS_QuestGoal( QuestKey, GoalType, GoalKey, Value )
		local MiscTable = self:GetBCS_MiscTable()

		if( MiscTable and MiscTable.Quests and MiscTable.Quests[QuestKey] and MiscTable.Quests[QuestKey].Status == false ) then
			if( not MiscTable.Quests[QuestKey].Progress ) then
				MiscTable.Quests[QuestKey].Progress = {}
			end

			if( not MiscTable.Quests[QuestKey].Progress[GoalType] ) then
				MiscTable.Quests[QuestKey].Progress[GoalType] = {}
			end

			MiscTable.Quests[QuestKey].Progress[GoalType][GoalKey] = Value
		else
			return false
		end

		self:SetBCS_MiscTable( MiscTable )
		return true
	end

	function ply_meta:AddBCS_QuestCompleted( QuestKey, noRewards )
		local QuestTable = BRICKSCRAFTING.CONFIG.Quests[QuestKey]
		if( not QuestTable ) then return false end

		local MiscTable = self:GetBCS_MiscTable()

		if( MiscTable and MiscTable.Quests and MiscTable.Quests[QuestKey] ) then
			if( MiscTable.Quests[QuestKey].Status != true ) then
				MiscTable.Quests[QuestKey].Status = true
				MiscTable.Quests[QuestKey].Progress = nil
				MiscTable.Quests[QuestKey].Time = os.time()
			else
				return false
			end
		else
			if( not MiscTable.Quests ) then
				MiscTable.Quests = {}
			end

			MiscTable.Quests[QuestKey] = {}
			MiscTable.Quests[QuestKey].Status = true
			MiscTable.Quests[QuestKey].Time = os.time()
		end

		self:NotifyBCS_Chat( string.format( BRICKSCRAFTING.L("completedQuest"), QuestTable.Name ), "materials/brickscrafting/general_icons/quest.png" )

		self:SetBCS_MiscTable( MiscTable )

		if( QuestTable.Rewards and not noRewards ) then
			for k, v in pairs( QuestTable.Rewards ) do
				if( BRICKSCRAFTING.RewardTypes[k] and BRICKSCRAFTING.RewardTypes[k].RewardFunc ) then
					BRICKSCRAFTING.RewardTypes[k].RewardFunc( self, v )
				end
			end

			if( QuestTable.Rewards and QuestTable.Rewards["Resources"] ) then
				if( table.Count( QuestTable.Rewards["Resources"] ) > 1 ) then
					local ResString = "+"
					local Count = 0

					for k, v in pairs( QuestTable.Rewards["Resources"] ) do
						if( Count == table.Count( QuestTable.Rewards["Resources"] )-1 ) then
							ResString = ResString .. string.Comma( v ) .. " " .. k
						elseif( Count == table.Count( QuestTable.Rewards["Resources"] )-2 ) then
							ResString = ResString .. string.Comma( v ) .. " " .. k .. " and +"
							Count = Count+1
						else
							ResString = ResString .. string.Comma( v ) .. " " .. k .. ", +"
							Count = Count+1
						end
					end

					self:NotifyBCS_Chat( ResString, "materials/brickscrafting/general_icons/newitem.png" )
				else
					for k, v in pairs( QuestTable.Rewards["Resources"] ) do
						self:NotifyBCS_Chat( "+" .. v .. " " .. k, (BRICKSCRAFTING.CONFIG.Resources[k] or {}).icon or "" )
					end
				end
			end

			BRICKSCRAFTING.AddExperience( self, BRICKSCRAFTING.LUACONFIG.ExpForQuest, "Quest" )
		end

		return true
	end
elseif( CLIENT ) then
	net.Receive( "BCS_Net_UpdateClientMisc", function( len, ply )
		local MiscTable = net.ReadTable() or {}

		BCS_MISCTABLE = MiscTable
		if( IsValid( BCS_NPCMenu ) ) then
			BCS_NPCMenu.CreatedPages["Training"]:RefreshTraining()
			BCS_NPCMenu.CreatedPages["Quests"]:RefreshQuests()
			BCS_NPCMenu.CreatedPages["Tools"]:RefreshPickaxe()
		end
	end )

	net.Receive( "BCS_Net_Notify", function( len, ply )
		local Message = net.ReadString()

		if( not Message ) then return end

		notification.AddLegacy( Message, 1, 3 )
	end )
end