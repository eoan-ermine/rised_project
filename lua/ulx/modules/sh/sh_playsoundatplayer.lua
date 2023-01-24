-- "lua\\ulx\\modules\\sh\\sh_playsoundatplayer.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
CATEGORY_NAME = "DerTod's Extras"

------------------------------ setmodel ------------------------------
function ulx.playsoundatplayer( calling_ply, target_plys, soundLvL, soundPitch, soundVol, silent, soundV)
	if not ULib.fileExists( "sound/" .. soundV  ) then
		ULib.tsayError( calling_ply, "That sound doesn't exist on the server!", true )
		return
	end

	for i=1, #target_plys do
		sound.Play(soundV,target_plys[i]:GetPos(),soundLvL,soundPitch,soundVol/100)
	end

	if not silent then
		ulx.fancyLog( {calling_ply }, "#P played #s at #P location(s)", calling_ply, soundV, target_plys)
	else
		ulx.fancyLogAdmin( calling_ply, true, "#P played #s at #P location(s)", calling_ply, soundV, target_plys)
	end
end
local playsoundatplayer = ulx.command( CATEGORY_NAME, "ulx playsoundatplayer", ulx.playsoundatplayer, "!playsoundatplayer" )
playsoundatplayer:addParam{ type=ULib.cmds.PlayersArg}
playsoundatplayer:addParam{ type=ULib.cmds.NumArg, min=20, max=180, default = 75, hint="Sound Level", ULib.cmds.round, ULib.cmds.optional }
playsoundatplayer:addParam{ type=ULib.cmds.NumArg, min=0, max=255, default = 100, hint="Pitch", ULib.cmds.round, ULib.cmds.optional }
playsoundatplayer:addParam{ type=ULib.cmds.NumArg, min=0, max=100, default = 50, hint="Volume", ULib.cmds.round, ULib.cmds.optional }
playsoundatplayer:addParam{ type=ULib.cmds.BoolArg, hint="Silent?", ULib.cmds.optional }
playsoundatplayer:addParam{ type=ULib.cmds.StringArg, hint="sound path" }
playsoundatplayer:defaultAccess( ULib.ACCESS_ADMIN )
playsoundatplayer:help( "Plays a sound (relative to sound dir) at a players location." )

