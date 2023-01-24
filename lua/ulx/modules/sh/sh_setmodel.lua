-- "lua\\ulx\\modules\\sh\\sh_setmodel.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
CATEGORY_NAME = "DerTod's Extras"

------------------------------ setmodel ------------------------------

function ulx.setmodel( calling_ply, target_plys, message )
	if not ULib.fileExists( message  ) or string.Explode("/",message)[1] != "models" then
		ULib.tsayError( calling_ply, "That model doesn't exist on the server!", true )
		return
	end

	if not message or message == "model path" or message == "" then 
		ULib.tsayError( calling_ply, "No model path given.", true )
		return 
	end

	// I know, the following code looks shitty and inefficient. But is will do for now. If you have suggestions that can improve it, while 
	// maintaining its current functionality, please let me know. It is 3am and I want to sleep :D

	// Names of the players that already have the choosen model.
	local already = {}

	// Players that already have the choosen model.
	local already2 = {}

	local message = string.lower(message)
	
	for k,v in pairs(target_plys) do
		local playermodel = string.lower(target_plys[k]:GetModel())
		if playermodel == message then 
			// Adds some juicy players to the tables (if they already have the choosen model).
			already[#already+1] = v:GetName()
			already2[#already2+1] = v
		else
			// Sets the models of the targeted players (if they don't already have it).
			target_plys[k]:SetModel(tostring(message))
			local string = message
		end
	end
	// Are you still reading this? This tells the calling player that the targeted players already have the choosen model.
	local already_string = table.concat(already, ", ", 1, #already)
	if already_string and already_string != "" then
		ULib.tsay( calling_ply, already_string.." already has/have this model!", true )
	end
	// This removes the players that already have the choosen model from the targeted players. Only the ones that don't have the choosen model remain.
	for k,v in pairs(already2) do
		table.RemoveByValue(target_plys, v)	
	end
	// This logs the executed command in the usual ULX fashion. Nice and easy.
	ulx.fancyLog( {calling_ply }, "#P changed the model of #T to #s", calling_ply, target_plys, message )	
end

local setmodel = ulx.command( CATEGORY_NAME, "ulx setmodel", ulx.setmodel, "!setmodel", true )
setmodel:addParam{ type=ULib.cmds.PlayersArg}
setmodel:addParam{ type=ULib.cmds.StringArg, hint="model path" }
setmodel:defaultAccess( ULib.ACCESS_ADMIN )
setmodel:help( "Set the model of a player." )