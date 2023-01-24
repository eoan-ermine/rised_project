-- "lua\\ulx\\modules\\sh\\sh_respawn.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
CATEGORY_NAME = "DerTod's Extras"

------------------------------ respawn ------------------------------

function ulx.respawn( calling_ply, target_plys, path )
	for i=1, #target_plys do
		target_plys[i]:Spawn()
	end

	ulx.fancyLog( { calling_ply }, "#P respawned #P", calling_ply, target_plys )
	
end
local respawn = ulx.command( CATEGORY_NAME, "ulx respawn", ulx.respawn, "!respawn", false )
respawn:addParam{ type=ULib.cmds.PlayersArg}
respawn:defaultAccess( ULib.ACCESS_ADMIN )
respawn:help( "Respawn a player." )

