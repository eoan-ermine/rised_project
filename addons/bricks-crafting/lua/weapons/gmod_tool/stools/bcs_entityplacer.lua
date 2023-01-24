-- "addons\\bricks-crafting\\lua\\weapons\\gmod_tool\\stools\\bcs_entityplacer.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
TOOL.Category = "Bricks Crafting"
TOOL.Name = BRICKSCRAFTING.L("toolName")
TOOL.Command = nil
TOOL.ConfigName = "" --Setting this means that you do not have to create external configuration files to define the layout of the tool config-hud 
 
if( SERVER ) then
	concommand.Add( "bcs_stoolcmd_entityclass", function( ply, cmd, args )
		if( args[1] ) then
			ply:SetNWString( "bcs_stoolcmd_entityclass", args[1] )
		end
	end )
end

function TOOL:LeftClick( trace )
	if( !trace.HitPos || IsValid( trace.Entity ) && trace.Entity:IsPlayer() ) then return false end
	if( CLIENT ) then return true end

	local ply = self:GetOwner()
	if( not BRICKSCRAFTING.HasAdminAccess( ply ) ) then
		ply:NotifyBCS( BRICKSCRAFTING.L("toolNoPermission") )
		return
	end

	local PlaceableEnts = BRICKSCRAFTING.GetPlaceableEnts()
	if( PlaceableEnts[ply:GetNWString( "bcs_stoolcmd_entityclass" )] ) then
		local Ent = ents.Create( ply:GetNWString( "bcs_stoolcmd_entityclass" ) )
		if( !IsValid( Ent ) ) then
			ply:NotifyBCS( ply, 1, 2, BRICKSCRAFTING.L("toolInvalidEnt") )
			return
		end
		if( string.StartWith( ply:GetNWString( "bcs_stoolcmd_entityclass" ), "brickscrafting_mining" ) ) then
			Ent:SetPos( trace.HitPos + Ent:GetUp()*5 )
		else
			Ent:SetPos( trace.HitPos )
		end
		local EntAngles = Ent:GetAngles()
		local PlayerAngle = ply:GetAngles()
		Ent:SetAngles( Angle( EntAngles.p, PlayerAngle.y+180, EntAngles.r ) )
		Ent:Spawn()
		
		ply:NotifyBCS( BRICKSCRAFTING.L("toolEntPlaced") )
		ply:ConCommand( "bcs_saveentpositions" )

		if( string.StartWith( ply:GetNWString( "bcs_stoolcmd_entityclass" ), "brickscrafting_mining" ) ) then
			if( not BCS_ROCKS ) then BCS_ROCKS = {} end

			local RockTable = { ply:GetNWString( "bcs_stoolcmd_entityclass" ), Ent:GetPos(), Ent:GetAngles() }
			local Key = #BCS_ROCKS+1
			BCS_ROCKS[Key] = RockTable

			Ent:SetRockKey( Key )
		elseif( ply:GetNWString( "bcs_stoolcmd_entityclass" ) == "brickscrafting_garbage" ) then
			if( not BCS_GARBAGE ) then BCS_GARBAGE = {} end

			local GarbageTable = { Ent:GetPos(), Ent:GetAngles() }
			local Key = #BCS_GARBAGE+1
			BCS_GARBAGE[Key] = GarbageTable

			Ent:SetGarbageKey( Key )
		end
	else
		ply:NotifyBCS( BRICKSCRAFTING.L("toolInvalidEnt") )
	end
end
 
function TOOL:RightClick( trace )
	if( !trace.HitPos ) then return false end
	if( !IsValid( trace.Entity ) or trace.Entity:IsPlayer() ) then return false end
	if( CLIENT ) then return true end

	local ply = self:GetOwner()

	if( not BRICKSCRAFTING.HasAdminAccess( ply ) ) then
		ply:NotifyBCS( BRICKSCRAFTING.L("toolNoPermission") )
		return
	end
	
	local PlaceableEnts = BRICKSCRAFTING.GetPlaceableEnts()
	if( PlaceableEnts[trace.Entity:GetClass()] ) then
		if( string.StartWith( trace.Entity:GetClass(), "brickscrafting_mining" ) and trace.Entity:GetRockKey() ) then
			if( BCS_ROCKS[trace.Entity:GetRockKey() or 0] ) then
				table.remove( BCS_ROCKS, trace.Entity:GetRockKey() or 0 )
			end
		end

		trace.Entity:Remove()
		ply:NotifyBCS( BRICKSCRAFTING.L("toolEntRemoved") )
		ply:ConCommand( "bcs_saveentpositions" )
	else
		ply:NotifyBCS( BRICKSCRAFTING.L("toolEntOnlyBCS") )
		return false
	end
end

function TOOL.BuildCPanel( panel )
	panel:AddControl("Header", { Text = BRICKSCRAFTING.L("toolEntType"), Description = BRICKSCRAFTING.L("toolInfo") })
 
	local combo = panel:AddControl( "ComboBox", { Label = BRICKSCRAFTING.L("toolEntType"), ConVar = "testcommand" } )
	local PlaceableEnts = BRICKSCRAFTING.GetPlaceableEnts()
	for k, v in pairs( PlaceableEnts ) do
		combo:AddOption( k, { bcs_stoolcmd_entityclass = k } )
	end
end