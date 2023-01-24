-- "addons\\ulx\\lua\\ulx\\modules\\sh\\risedproject.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local CATEGORY_NAME = "Rised Project"

------------------------------ Изменить RP имя ------------------------------
function ulx.changerpname( calling_ply, target_ply, name, surname )
	target_ply:setRPName( name .. " " .. surname, false)
	ulx.fancyLogAdmin( calling_ply, "#A поменял RP имя игроку #T", target_ply, value )
end
local changerpname = ulx.command( CATEGORY_NAME, "ulx changerpname", ulx.changerpname )
changerpname:addParam{ type=ULib.cmds.PlayerArg }
changerpname:addParam{ type=ULib.cmds.StringArg, hint="Имя" }
changerpname:addParam{ type=ULib.cmds.StringArg, hint="Фамилия" }
changerpname:defaultAccess( ULib.ACCESS_ADMIN )
changerpname:help( "Сменить игроку RP имя и фамилию." )



------------------------------ Установить ОЛ ------------------------------
function ulx.setloyalty( calling_ply, target_ply, value )
	target_ply:SetNWInt("LoyaltyTokens", value)
	hook.Call("playerLoyaltyChanged", GAMEMODE, target_ply, target_ply:GetNWInt("LoyaltyTokens"))
	ulx.fancyLogAdmin( calling_ply, "#A сделал уровень ОЛ для игрока #T равными #i", target_ply, value )
end
local setloyalty = ulx.command( CATEGORY_NAME, "ulx setloyalty", ulx.setloyalty )
setloyalty:addParam{ type=ULib.cmds.PlayerArg }
setloyalty:addParam{ type=ULib.cmds.NumArg, min=-20, max=100, default=0, hint="Количество", ULib.cmds.round }
setloyalty:defaultAccess( ULib.ACCESS_ADMIN )
setloyalty:help( "Установить игроку уровень ОЛ." )



------------------------------ Установить RP уровень ------------------------------
function ulx.setrplevel( calling_ply, target_ply, value )
	hook.Call("playerRPLevelChanged", GAMEMODE, target_ply, value)
	ulx.fancyLogAdmin( calling_ply, "#A сделал уровень RP для игрока #T равными #i", target_ply, value )
end
local setrplevel = ulx.command( CATEGORY_NAME, "ulx setrplevel", ulx.setrplevel )
setrplevel:addParam{ type=ULib.cmds.PlayerArg }
setrplevel:addParam{ type=ULib.cmds.NumArg, min=-100, max=100, default=50, hint="Количество", ULib.cmds.round }
setrplevel:defaultAccess( ULib.ACCESS_ADMIN )
setrplevel:help( "Установить игроку RP уровень." )



------------------------------ Stealth-режим ------------------------------
function ulx.stealthmode( calling_ply )
	if calling_ply:GetNWBool("Rised_Admin_Stealth") == false then
		calling_ply:SetNWBool("Rised_Admin_Stealth", true)
		DarkRP.notify(calling_ply,2,7,"Вы включили Stealth-режим!")
		
		-- net.Start("EasyChatModuleJoinLeave")
		-- net.WriteBool(false)
		-- net.WriteString(calling_ply:SteamName())
		-- net.WriteString("Disconnect by user.")
		-- net.Broadcast()
	else
		calling_ply:SetNWBool("Rised_Admin_Stealth", false)
		DarkRP.notify(calling_ply,2,7,"Вы отключили Stealth-режим!")
		
		-- net.Start("EasyChatModuleJoinLeave")
		-- net.WriteBool(true)
		-- net.WriteString(calling_ply:SteamName())
		-- net.Broadcast()
	end
end
local stealthmode = ulx.command( CATEGORY_NAME, "ulx stealthmode", ulx.stealthmode, "!stealthmode" )
stealthmode:defaultAccess( ULib.ACCESS_ADMIN )
stealthmode:help( "Перейти в Stealth-режим." )



------------------------------ Наказать ------------------------------
function ulx.punish( calling_ply, target_ply, minutes, reason )
	if target_ply:IsListenServerHost() or target_ply:IsBot() then
		ULib.tsayError( calling_ply, "This player is immune to banning", true )
		return
	end

	local time = "for #s"
	if minutes == 0 then time = "permanently" end
	local str = "#A banned #T " .. time
	if reason and reason ~= "" then str = str .. " (#s)" end

    local ptime = minutes * 60
	
	if minutes == 0 then
		ptime = 500000 * 60
	end
	
	RisedPunish_System(target_ply, ptime, reason, calling_ply)
end
local punish = ulx.command( CATEGORY_NAME, "ulx punish", ulx.punish, "!punish", false, false, true )
punish:addParam{ type=ULib.cmds.PlayerArg }
punish:addParam{ type=ULib.cmds.NumArg, hint="minutes, 0 for perma", ULib.cmds.optional, ULib.cmds.allowTimeString, min=0 }
punish:addParam{ type=ULib.cmds.StringArg, hint="reason", ULib.cmds.optional, ULib.cmds.takeRestOfLine, completes=ulx.common_kick_reasons }
punish:defaultAccess( ULib.ACCESS_ADMIN )
punish:help( "Punishes target." )

------------------------------ Наказать по SteamID ------------------------------
function ulx.punishid( calling_ply, steamid, minutes, reason )

	steamid = steamid:upper()
	if not ULib.isValidSteamID( steamid ) then
		ULib.tsayError( calling_ply, "Invalid steamid." )
		return
	end

	local target_ply
	local plys = player.GetAll()
	for i=1, #plys do
		if plys[ i ]:SteamID() == steamid then
			target_ply = plys[ i ]
			break
		end
	end

	if target_ply and (target_ply:IsListenServerHost() or target_ply:IsBot()) then
		ULib.tsayError( calling_ply, "This player is immune to banning", true )
		return
	end

	local time = "for #s"
	if minutes == 0 then time = "permanently" end
	local str = "#A banned #T " .. time
	if reason and reason ~= "" then str = str .. " (#s)" end

    local ptime = minutes * 60
	
	if minutes == 0 then
		ptime = 500000 * 60
	end
	
	RisedPunishID_System(steamid, ptime, reason, calling_ply)
end
local punishid = ulx.command( CATEGORY_NAME, "ulx punishid", ulx.punishid, "!punishid", false, false, true )
punishid:addParam{ type=ULib.cmds.StringArg, hint="steamid" }
punishid:addParam{ type=ULib.cmds.NumArg, hint="minutes, 0 for perma", ULib.cmds.optional, ULib.cmds.allowTimeString, min=0 }
punishid:addParam{ type=ULib.cmds.StringArg, hint="reason", ULib.cmds.optional, ULib.cmds.takeRestOfLine, completes=ulx.common_kick_reasons }
punishid:defaultAccess( ULib.ACCESS_SUPERADMIN )
punishid:help( "Punishes steamid." )

------------------------------ Разнаказать ------------------------------
function ulx.depunish( calling_ply, steamid )
	steamid = steamid:upper()
	if not ULib.isValidSteamID( steamid ) then
		ULib.tsayError( calling_ply, "Invalid steamid." )
		return
	end

	RisedDePunish_System(steamid, calling_ply)
end
local depunish = ulx.command( CATEGORY_NAME, "ulx depunish", ulx.depunish, "!depunish", false, false, true )
depunish:addParam{ type=ULib.cmds.StringArg, hint="steamid" }
depunish:defaultAccess( ULib.ACCESS_ADMIN )
depunish:help( "De-Punishes steamid." )

------------------------------ Установить профессию ------------------------------
function ulx.setteam( calling_ply, target_ply, value )

	if isstring(value) then
		for k,v in pairs(RPExtraTeams) do
		   if v.name == value then
		   		value = k
			end
		end
	end

	if isstring(value) then
		value = tonumber(value)
	end

	target_ply:changeTeam( value, true )

end
local setteam = ulx.command( CATEGORY_NAME, "ulx setteam", ulx.setteam, "!setteam", false, false, true )
setteam:addParam{ type=ULib.cmds.PlayerArg }
setteam:addParam{ type=ULib.cmds.StringArg, hint="Имя" }
setteam:defaultAccess( ULib.ACCESS_ADMIN )
setteam:help( "Set team." )