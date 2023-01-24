-- "addons\\darkrp_classic_advert\\lua\\autorun\\darkrp-full-classic-advert.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local function init()
	DarkRP.removeChatCommand("advert")
	DarkRP.declareChatCommand({
		command = "advert",
		description = "Displays an advertisement to everyone in chat.",
		delay = 1.5
	})
	if (SERVER) then
		DarkRP.defineChatCommand("advert",function(ply,args)
			if args == "" then
				DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
				return ""
			end
			if !GAMEMODE.LoyaltyJobs[ply:Team()] and !ply:isCP() then
				DarkRP.notify(ply, 1, 4, "Данную функцию может использовать только Альянс!")
				return "" 
			end
			local DoSay = function(text)
				if text == "" then
					DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
					return
				end
				for k,v in pairs(player.GetAll()) do
					local col = Color(255, 165, 0, 255)
					DarkRP.talkToPerson(v, col, "[Вещание Альянса] " .. ply:Nick(), Color(255, 165, 0, 255), text, ply)
				end
			end
			hook.Call("playerAdverted", nil, ply, args)
			return args, DoSay
		end,1.5)
	end
end
if (SERVER) then
	if (#player.GetAll() > 0) then
		init()
	else
		hook.Add("PlayerInitialSpawn","dfca-load",function()
			init()
		end)
	end
else
	hook.Add("InitPostEntity","dfca-load",function()
		init()
	end)
end