-- "addons\\bricks-crafting\\lua\\entities\\brickscrafting_npc\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include('shared.lua')

function ENT:Draw()
	self:DrawModel()
end

BCS_NPC_ENTS = BCS_NPC_ENTS or {}
function ENT:Initialize()
	BCS_NPC_ENTS[self:EntIndex()] = self
end

function ENT:OnRemove()
	BCS_NPC_ENTS[self:EntIndex()] = nil
end

hook.Add( "HUDPaint", "BCSHooks_HUDPaint_DrawNPCs", function()
	for k, v in pairs( BCS_NPC_ENTS ) do
		if( not IsValid( v ) ) then
			BCS_NPC_ENTS[k] = nil
			continue
		end

		local Distance = LocalPlayer():GetPos():DistToSqr( v:GetPos() )

		local AlphaMulti = 1-(Distance/BRICKSCRAFTING.LUACONFIG.Defaults.DisplayDist3D2D)

		if( Distance < BRICKSCRAFTING.LUACONFIG.Defaults.DisplayDist3D2D ) then
			local zOffset = 3+v:OBBMaxs().z
			local Pos = v:GetPos()
			local x = Pos.x
			local y = Pos.y
			local z = Pos.z
			local pos = Vector(x,y,z+zOffset)
			local pos2d = pos:ToScreen()

			surface.SetAlphaMultiplier( AlphaMulti )
				draw.SimpleText( v.PrintName or "", "BCS_Roboto_25", pos2d.x, pos2d.y, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )
			surface.SetAlphaMultiplier( 1 )
		end
	end
end )

net.Receive( "BCS_Net_UpdateSWEP", function( len, ply )
	if( IsValid( LocalPlayer():GetActiveWeapon() ) and LocalPlayer():GetActiveWeapon().UpdateSWEPColour ) then
		LocalPlayer():GetActiveWeapon():UpdateSWEPColour()
	end
end )

net.Receive( "BCS_Net_UseNPC", function( len, ply )
	if( not IsValid( BCS_NPCMenu ) ) then
		BCS_NPCMenu = vgui.Create( "brickscrafting_vgui_npc" )

		if( BCS_HighlightNPC == true ) then
			BCS_HighlightNPC = false
			notification.AddLegacy( BRICKSCRAFTING.L("foundCraftingNPC"), 0, 5 )
		end
	end
end )

local function GetClosestNPC( pos )
	local dist = math.huge
	local NPC
	for k, v in pairs( BCS_NPC_ENTS or {} ) do
		if( not IsValid( v ) ) then
			BCS_NPC_ENTS[k] = nil
			continue
		end

		if( v:GetClass() == "brickscrafting_npc" ) then
			local newdist = pos:DistToSqr( v:GetPos() )
			if( newdist < dist ) then
				NPC = v
				dist = newdist
			end
		end
	end
	return NPC
end

hook.Add( "PreDrawHalos", "BCSHooks_PreDrawHalos_HighlightNPC", function()
	if( BCS_HighlightNPC or BCS_TrackedQuest_Completed ) then
		halo.Add( {GetClosestNPC( LocalPlayer():GetPos() )}, Color( 0, 255, 0 ), 5, 5, 2, true, true )
	end
end )

local X, Y, W, H = 25, 25, 50+(50-50*0.65)/2+75, 50
local SubH = 35
local Spacing = 10

local function DrawInstruction( SlotPos, Text, done )
	surface.SetFont( "BCS_Roboto_22" )
	local TxtX, TxtY = surface.GetTextSize( Text )

	TxtX = TxtX+20

	if( not BRICKSCRAFTING.LUACONFIG.DisableShadows ) then
		BCS_BSHADOWS.BeginShadow()
		if( not done ) then
			surface.SetDrawColor( 30, 30, 44, 255 )
		else
			surface.SetDrawColor( 220, 255, 220, 255 )
		end
		surface.DrawRect( X, Y+H+Spacing+(SlotPos*(Spacing+SubH)), TxtX, SubH )			
		BCS_BSHADOWS.EndShadow(1, 2, 2)
	else
		if( not done ) then
			surface.SetDrawColor( 30, 30, 44, 255 )
		else
			surface.SetDrawColor( 220, 255, 220, 255 )
		end
		surface.DrawRect( X, Y+H+Spacing+(SlotPos*(Spacing+SubH)), TxtX, SubH )	
	end

	draw.SimpleText( Text, "BCS_Roboto_22", X+(TxtX/2), Y+H+Spacing+(SubH/2)+(SlotPos*(Spacing+SubH)), Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
end

hook.Add( "HUDPaint", "BCSHooks_HUDPaint_HighlightNPC", function()
	local MiscTable = LocalPlayer():GetBCS_MiscTable()

	local Distance = 0
	if( IsValid(GetClosestNPC( LocalPlayer():GetPos() ))) then
		Distance = LocalPlayer():GetPos():DistToSqr( GetClosestNPC( LocalPlayer():GetPos() ):GetPos() )
	end

	local Text = ""
	if( BCS_HighlightNPC ) then
		Text = string.format( BRICKSCRAFTING.L("craftingNPCHighlighted"), Distance/10000 )
	elseif( BCS_TrackedQuest and MiscTable and MiscTable.Quests and MiscTable.Quests[BCS_TrackedQuest] and MiscTable.Quests[BCS_TrackedQuest].Status != true ) then
		local QuestTable = BRICKSCRAFTING.CONFIG.Quests[BCS_TrackedQuest]
		local MiscQuestTable = MiscTable.Quests[BCS_TrackedQuest]
		if( QuestTable ) then
			local CompletedQuests = 0
			local TotalQuests = 0
			local QuestOrder = {}
			local GoalTable = QuestTable.Goal
			for k, v in pairs( GoalTable ) do
				if( k == "Resource" ) then
					TotalQuests = TotalQuests+table.Count( v )
					for key, val in pairs( v ) do
						if( MiscQuestTable.Progress and MiscQuestTable.Progress[k] and MiscQuestTable.Progress[k][key] and BRICKSCRAFTING.QuestTypes[k] and BRICKSCRAFTING.QuestTypes[k].MeetsGoal ) then
							if( BRICKSCRAFTING.QuestTypes[k].MeetsGoal( val, MiscQuestTable.Progress[k][key] ) ) then continue end
						end
						
						table.insert( QuestOrder, { k, key } )
					end
				elseif( k == "Craft" ) then
					for key, val in pairs( v ) do
						if( MiscQuestTable.Progress and MiscQuestTable.Progress[k] and MiscQuestTable.Progress[k][key] and BRICKSCRAFTING.QuestTypes[k] and BRICKSCRAFTING.QuestTypes[k].MeetsGoal ) then
							if( BRICKSCRAFTING.QuestTypes[k].MeetsGoal( val, MiscQuestTable.Progress[k][key] ) ) then continue end
						end

						TotalQuests = TotalQuests+table.Count( val )

						for key2, val2 in pairs( val ) do
							table.insert( QuestOrder, { k, key, key2 } )
						end
					end
				end

				for key, val in pairs( GoalTable[k] ) do
					if( MiscQuestTable.Progress and MiscQuestTable.Progress[k] and MiscQuestTable.Progress[k][key] and BRICKSCRAFTING.QuestTypes[k] and BRICKSCRAFTING.QuestTypes[k].MeetsGoal ) then
						if( BRICKSCRAFTING.QuestTypes[k].MeetsGoal( val, MiscQuestTable.Progress[k][key] ) ) then
							CompletedQuests = CompletedQuests+1
						end
					end
				end
			end

			if( not BCS_TrackedQuest_Completed ) then
				for k, v in pairs( QuestOrder ) do
					if( GoalTable[v[1]] ) then
						if( v[1] == "Resource" ) then
							if( GoalTable[v[1]][v[2]] ) then
								if( MiscQuestTable.Progress and MiscQuestTable.Progress[v[1]] and MiscQuestTable.Progress[v[1]][v[2]] ) then
									if( MiscQuestTable.Progress[v[1]][v[2]] != GoalTable[v[1]][v[2]] ) then
										DrawInstruction( k-1, v[2] .. ": " .. MiscQuestTable.Progress[v[1]][v[2]] .. "/" .. GoalTable[v[1]][v[2]] )
									else
										DrawInstruction( k-1, v[2] .. ": " .. MiscQuestTable.Progress[v[1]][v[2]] .. "/" .. GoalTable[v[1]][v[2]], true )
									end
								else
									DrawInstruction( k-1, v[2] .. ": 0/" .. GoalTable[v[1]][v[2]] )
								end
							end
						elseif( v[1] == "Craft" ) then
							if( GoalTable[v[1]][v[2]] and GoalTable[v[1]][v[2]][v[3]] ) then
								local itemConfig = BRICKSCRAFTING.CONFIG.Crafting[v[2]].Items[v[3]]
								if( not itemConfig ) then continue end

								if( MiscQuestTable.Progress and MiscQuestTable.Progress[v[1]] and MiscQuestTable.Progress[v[1]][v[2]] and MiscQuestTable.Progress[v[1]][v[2]][v[3]] ) then
									if( MiscQuestTable.Progress[v[1]][v[2]][v[3]] != GoalTable[v[1]][v[2]][v[3]] ) then
										DrawInstruction( k-1, itemConfig.Name .. ": " .. MiscQuestTable.Progress[v[1]][v[2]][v[3]] .. "/" .. GoalTable[v[1]][v[2]][v[3]] )
									else
										DrawInstruction( k-1, itemConfig.Name .. ": " .. MiscQuestTable.Progress[v[1]][v[2]][v[3]] .. "/" .. GoalTable[v[1]][v[2]][v[3]], true )
									end
								else
									DrawInstruction( k-1, itemConfig.Name .. ": 0/" .. GoalTable[v[1]][v[2]][v[3]] )
								end
							end
						end
					end
				end
			end

			local Completed = CompletedQuests/TotalQuests
			Text = QuestTable.Name .. " - " .. math.Clamp( math.Round(Completed*100), 0, 100 ) .. "%"

			if( CompletedQuests == TotalQuests and not BCS_TrackedQuest_Completed ) then
				BCS_TrackedQuest_Completed = true
			end
		end
	elseif( BCS_TrackedQuest and ( not MiscTable or not MiscTable.Quests or not MiscTable.Quests[BCS_TrackedQuest] or MiscTable.Quests[BCS_TrackedQuest].Status == true ) ) then
		BCS_TrackedQuest_Completed = false
		BCS_TrackedQuest = nil
	end

	surface.SetFont( "BCS_Roboto_24" )
	local TxtX, TxtY = surface.GetTextSize( Text )

	W = TxtX+50+(50-50*0.65)/2+10

	if( BCS_HighlightNPC or (BCS_TrackedQuest and MiscTable and MiscTable.Quests and MiscTable.Quests[BCS_TrackedQuest]) ) then
		if( not BRICKSCRAFTING.LUACONFIG.DisableShadows ) then
			BCS_BSHADOWS.BeginShadow()
			surface.SetDrawColor( 30, 30, 44, 255 )
			surface.DrawRect( X, Y, W, H )			
			BCS_BSHADOWS.EndShadow(1, 2, 2)
		else
			surface.SetDrawColor( 30, 30, 44, 255 )
			surface.DrawRect( X, Y, W, H )		
		end

		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( BCS_DRAWING.GetMaterial( "IconAlert" ) )
		local IconSize = H*0.65
		surface.DrawTexturedRect( X+(H-IconSize)/2, Y+(H-IconSize)/2, IconSize, IconSize )

		draw.SimpleText( Text, "BCS_Roboto_24", X+H, Y+(H/2), Color( 255, 255, 255, 255 ), 0, TEXT_ALIGN_CENTER )

		if( BCS_TrackedQuest_Completed ) then
			DrawInstruction( 0, string.format( BRICKSCRAFTING.L("craftingNPCTurnIn"), Distance/10000 ) )
		end
	end
end )

--[[ Quest Tracking ]]--
net.Receive( "BCS_Net_ActiveQuest", function( len, ply )
	local QuestKey = net.ReadInt( 32 )
	
	if( not QuestKey ) then return end

	local MiscTable = LocalPlayer():GetBCS_MiscTable()
	
	local TrackQuest = false
	if( not BCS_TrackedQuest ) then
		TrackQuest = true
	else
		if( MiscTable and MiscTable.Quests and not MiscTable.Quests[BCS_TrackedQuest] ) then
			TrackQuest = true
		end
	end

	if( TrackQuest == true and MiscTable and MiscTable.Quests and MiscTable.Quests[QuestKey] ) then
		BCS_TrackedQuest = QuestKey
	end
end )

--[[ Resource Sell Return ]]--
net.Receive( "BCS_Net_SellResources_Return", function( len, ply )
	if( IsValid( BCS_NPCMenu ) and BCS_NPCMenu.CreatedPages["Shop"] ) then
		if( IsValid( BCS_NPCMenu.CreatedPages["Shop"] ) ) then
			BCS_NPCMenu.CreatedPages["Shop"]:RefreshResources()
		end
	end
end )