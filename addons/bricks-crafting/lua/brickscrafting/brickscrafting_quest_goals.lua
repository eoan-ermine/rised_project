-- "addons\\bricks-crafting\\lua\\brickscrafting\\brickscrafting_quest_goals.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

if( SERVER ) then
	--[[ Resource Goal ]]--
	hook.Add("BCS.Hooks.ResourceAdd", "BCSHooks_BCS.Hooks.ResourceAdd_QuestType", function( ply, resource, amount, dropped )
		if( not dropped and IsValid( ply ) ) then
			for k, v in pairs( BRICKSCRAFTING.CONFIG.Quests ) do
				if( v.Goal and v.Goal["Resource"] and v.Goal["Resource"][resource] ) then
					local MiscTable = ply:GetBCS_MiscTable()
					if( MiscTable.Quests and MiscTable.Quests[k] ) then
						local QuestGoal = ply:GetBCS_QuestGoal( k, "Resource", resource )

						if( QuestGoal and isnumber( QuestGoal ) ) then
							ply:UpdateBCS_QuestGoal( k, "Resource", resource, math.Clamp( QuestGoal+amount, 0, v.Goal["Resource"][resource] ) )
						else
							ply:UpdateBCS_QuestGoal( k, "Resource", resource, math.Clamp( amount, 0, v.Goal["Resource"][resource] ) )
						end
					end
				end
			end
		end
	end)

	--[[ Craft Goal ]]--
	hook.Add("BCS.Hooks.CraftItem", "BCSHooks_BCS.Hooks.CraftItem_QuestType", function( ply, benchType, itemKey )
		if( IsValid( ply ) ) then
			for k, v in pairs( BRICKSCRAFTING.CONFIG.Quests ) do
				if( v.Goal and v.Goal["Craft"] and v.Goal["Craft"][benchType] and v.Goal["Craft"][benchType][itemKey] ) then
					local MiscTable = ply:GetBCS_MiscTable()
					if( MiscTable.Quests and MiscTable.Quests[k] ) then
						local QuestGoal = ply:GetBCS_QuestGoal( k, "Craft", benchType )

						if( not QuestGoal ) then
							QuestGoal = {}
						end

						local CraftVal = 1
						if( QuestGoal[itemKey] and isnumber( QuestGoal[itemKey] ) ) then
							CraftVal = math.Clamp( QuestGoal[itemKey]+1, 0, v.Goal["Craft"][benchType][itemKey] )
						end

						QuestGoal[itemKey] = CraftVal

						ply:UpdateBCS_QuestGoal( k, "Craft", benchType, QuestGoal )
					end
				end
			end
		end
	end)
elseif( CLIENT ) then

end