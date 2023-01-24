-- "addons\\darkrpmodification\\lua\\darkrp_modules\\chat\\cl_chat.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[---------------------------------------------------------------------------
Gamemode function
---------------------------------------------------------------------------]]
function GM:OnPlayerChat()
end

--[[---------------------------------------------------------------------------
Add a message to chat
---------------------------------------------------------------------------]]

local dogText = {
    "Гав!",
    "Гааав!",
    "Ррррр",
    "Ррррр-Гав!!",
    "Гав.",
    "Гав-гав",
    "Ррр..",
}

local function AddToChat(bits)
    local col1 = Color(net.ReadUInt(8), net.ReadUInt(8), net.ReadUInt(8))
    local prefixText = net.ReadString()
    local ply = net.ReadEntity()
    ply = IsValid(ply) and ply or LocalPlayer()
    
    if not IsValid(ply) then return end
    if ply:Team() == TEAM_RAT then return end

    if prefixText == "" or not prefixText then
        prefixText = "Неизвестный"

        if LocalPlayer():Team() != TEAM_ADMINISTRATOR and LocalPlayer():Team() != TEAM_GMAN then
            if LocalPlayer():isCP() || LocalPlayer():Team() == TEAM_REBELSPY01 then
                if ply:isCP() || ply:Team() == TEAM_REBELSPY01 || FaceMemory_Check(ply) then
                    prefixText = ply:Name()
                end
            elseif !LocalPlayer():isCP() && LocalPlayer():Team() != TEAM_REBELSPY01 && (ply:isCP() || ply:Team() == TEAM_REBELSPY01) then
                prefixText = "Сотрудник Альянса"
            elseif LocalPlayer() == ply or (GAMEMODE.Rebels[LocalPlayer():Team()] and GAMEMODE.Rebels[ply:Team()]) or (FaceMemory_Check(ply) and !GAMEMODE.ZombieJobs[ply:Team()]) then
                prefixText = ply:Name()
            end
        end
    end

    local col2 = Color(net.ReadUInt(8), net.ReadUInt(8), net.ReadUInt(8))
    local text = net.ReadString()
    local rnd = net.ReadInt(16)
    local shouldShow

    if text and text == "glob" then
        chat.AddNonParsedText(col1, prefixText)
    elseif text and (text == "status") then
        chat.AddNonParsedText(Color(200,200,200,50), prefixText)
    elseif text and (text == "local_status") then
        chat.AddNonParsedText(Color(200,200,200,50), prefixText)
    elseif text and (text == "local_warning") then
        chat.AddNonParsedText(Color(220,100,0,75), prefixText)
    elseif text and (text == "local_danger") then
        chat.AddNonParsedText(Color(240,0,0,50), prefixText)
    elseif text and text ~= "" and text != "do" and text != "try" and text != "glob" and text != "l" and text != "looc" and text != "ooc" then
        if ply:Team() == TEAM_DOG then
            text = table.Random(dogText)
        end
        hook.Call("OnPlayerChat", GAMEMODE, ply, text, false, not ply:Alive(), prefixText, col1, col2)
        chat.AddNonParsedText(col1, prefixText, col2, ": " .. text)
    elseif text and text == "do" then
        col1 = Color(255, 255, 255)
        chat.AddNonParsedText(col1, prefixText)
    elseif prefixText and string.StartWith(prefixText, "[LOOC]") then
        chat.AddNonParsedText(col1, prefixText, col2, ": " .. text)
    elseif text and (text == "ooc") then
        chat.AddNonParsedText(col1, prefixText, col2, ": " .. text)
    elseif text and text == "try" then
        if rnd > 50 then
            col1 = Color(0, 225, 0)
        
            chat.AddNonParsedText(col1, prefixText .. " [Успех]")
        else
            col1 = Color(180, 0, 0)
        
            chat.AddNonParsedText(col1, prefixText .. " [Провал]")
        end
    else
        chat.AddNonParsedText(col1, prefixText)
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
