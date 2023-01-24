-- "gamemodes\\darkrp\\gamemode\\modules\\chat\\cl_chat.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[---------------------------------------------------------------------------
Gamemode function
---------------------------------------------------------------------------]]
function GM:OnPlayerChat()
end

--[[---------------------------------------------------------------------------
Add a message to chat
---------------------------------------------------------------------------]]
local function AddToChat(bits)
    local col1 = Color(net.ReadUInt(8), net.ReadUInt(8), net.ReadUInt(8))
    local prefixText = net.ReadString()
    local ply = net.ReadEntity()
    ply = IsValid(ply) and ply or LocalPlayer()
	
    if not IsValid(ply) then return end

    if prefixText == "" or not prefixText then
        prefixText = ply:Nick()
    end

    local col2 = Color(net.ReadUInt(8), net.ReadUInt(8), net.ReadUInt(8))
    local text = net.ReadString()
    local shouldShow
    if text and text == "glob" then
        shouldShow = hook.Call("OnPlayerChat", GAMEMODE, ply, text, false, not ply:Alive(), prefixText, col1, col2)
 
        if shouldShow ~= true then
            chat.AddNonParsedText(col1, prefixText)
        end
    elseif text and text ~= "" and text != "do" and text != "try" and text != "glob" then
        if IsValid(ply) then
            shouldShow = hook.Call("OnPlayerChat", GAMEMODE, ply, text, false, not ply:Alive(), prefixText, col1, col2)
        end

        if shouldShow ~= true then
            chat.AddNonParsedText(col1, prefixText, col2, ": " .. text)
        end
    elseif text and text == "do" then
		col1 = Color(255, 255, 255)
        shouldShow = hook.Call("OnPlayerChat", GAMEMODE, ply, text, false, not ply:Alive(), prefixText, col1, col2)

        if shouldShow ~= true then
            chat.AddNonParsedText(col1, prefixText)
        end
    elseif text and text == "try" then
		local rnd = math.random(0,100)
		
		if rnd > 50 then
			col1 = Color(0, 225, 0)
		
			shouldShow = hook.Call("OnPlayerChat", GAMEMODE, ply, text, false, not ply:Alive(), prefixText, col1, col2)
		
			if shouldShow ~= true then
				chat.AddNonParsedText(col1, ply:Nick() .. " " .. prefixText .. " [Успех]")
			end
		else
			col1 = Color(180, 0, 0)
		
			shouldShow = hook.Call("OnPlayerChat", GAMEMODE, ply, text, false, not ply:Alive(), prefixText, col1, col2)
		
			if shouldShow ~= true then
				chat.AddNonParsedText(col1, ply:Nick() .. " " .. prefixText .. " [Провал]")
			end
		end
    else
        shouldShow = hook.Call("OnPlayerChat", GAMEMODE, ply, text, false, not ply:Alive(), prefixText, col1, col2)

        if shouldShow ~= true then
            chat.AddNonParsedText(col1, prefixText)
        end
    end
end
net.Receive("DarkRP_Chat", AddToChat)

--[[---------------------------------------------------------------------------
Credits

Please only ADD to the credits.
---------------------------------------------------------------------------]]
local creds =
[[

LightRP was created by Rick darkalonio. LightRP was sandbox with some added RP elements.
LightRP was released at the end of January 2007

DarkRP was created as a spoof of LightRP by Rickster, somewhere during the summer of 2007.
Note: There was a DarkRP in 2006, but that was an entirely different gamemode.

Rickster went to serve his country and went to Afghanistan. During that time, the following people updated DarkRP:
Picwizdan
Sibre
[GNC] Matt
PhilXYZ
Chromebolt A.K.A. Unib5 (STEAM_0:1:19045957)

In 2008, Unib5 was administrator on a DarkRP server called EuroRP, owned by Jiggu. FPtje frequently joined this server to prop kill en masse. While Jiggu loved watching the chaos unfold, Unib5 hated it and banned FPtje on sight. Since Jiggu kept unbanning FPtje, Unib5 felt powerless. In an attempt to stop FPtje, Unib5 put FPtje's favourite prop killing props (the locker and the sawblade) in the default blacklist of DarkRP in an update. This in turn enraged FPtje, as he swore to make an update in secret that would suddenly pop up and overthrow the established version. As a result, DarkRP 2.3.1 was released in December 2008. After a bit of a fight, FPtje became the official updater of DarkRP.

Current developer:
    Falco A.K.A. FPtje Atheos (STEAM_0:0:8944068)

People who have contributed (ordered by commits, with at least two commits)
    Bo98
    Drakehawke (STEAM_0:0:22342869) (64 commits on old SVN)
    FiG-Scorn
    Noiwex
    KoZ
    Eusion (STEAM_0:0:20450406) (3 commits on old SVN)
    Gangleider
    MattWalton12
    TypicalRookie
]]

local function credits(um)
    chat.AddNonParsedText(Color(255, 0, 0, 255), "[", Color(50,50,50,255), GAMEMODE.Name, Color(255, 0, 0, 255), "] ", Color(255, 255, 255, 255), DarkRP.getPhrase("credits_see_console"))

    MsgC(Color(255, 0, 0, 255), DarkRP.getPhrase("credits_for", GAMEMODE.Name), Color(255, 255, 255, 255), creds)
end
usermessage.Hook("DarkRP_Credits", credits)
