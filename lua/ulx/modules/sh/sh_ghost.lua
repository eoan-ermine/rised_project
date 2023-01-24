-- "lua\\ulx\\modules\\sh\\sh_ghost.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
CATEGORY_NAME = "DerTod's Extras"

------------------------------ ghost ------------------------------

function ulx.ghost( calling_ply, target_plys, silent, should_unghost )

	if not should_unghost then
		for i=1, #target_plys do
			target_plys[i]:SetMoveType( MOVETYPE_NOCLIP )
			ULib.invisible( target_plys[ i ], not should_unghost)
		end
	else
		for i=1, #target_plys do
			target_plys[i]:SetMoveType( MOVETYPE_WALK )
			ULib.invisible( target_plys[ i ], not should_unghost)
		end

	end


	if not silent then


		if should_unghost then
			ulx.fancyLog( {calling_ply }, "#P deactivated ghost mode for #T", calling_ply, target_plys)
		else
			ulx.fancyLog( {calling_ply }, "#P activated ghost mode for #T", calling_ply, target_plys)
		end


	else


		if should_unghost then
			ulx.fancyLogAdmin( calling_ply, true, "#P deactivated ghost mode for #T", calling_ply, target_plys)
		else
			ulx.fancyLogAdmin( calling_ply, true, "#P activated ghost mode for #T", calling_ply, target_plys)
		end


	end

end

local ghost = ulx.command( CATEGORY_NAME, "ulx ghost", ulx.ghost, "!ghost", true )
ghost:addParam{ type=ULib.cmds.PlayersArg}
ghost:addParam{ type=ULib.cmds.BoolArg, hint="Silent?", ULib.cmds.optional }
ghost:addParam{ type=ULib.cmds.BoolArg, invisible=true }
ghost:defaultAccess( ULib.ACCESS_ADMIN )
ghost:help( "Noclip and cloak a player." )
ghost:setOpposite( "ulx unghost", {_, _, _, true}, "!unghost" )

