-- "lua\\autorun\\talkicon.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local flags = FCVAR_ARCHIVE + FCVAR_REPLICATED + FCVAR_SERVER_CAN_EXECUTE
local computecolor = CreateConVar('talkicon_computablecolor', 1, flags, 'Compute color from location brightness.')
local showtextchat = CreateConVar('talkicon_showtextchat', 1, flags, 'Show icon on using text chat.')
local noteamchat = CreateConVar('talkicon_ignoreteamchat', 1, flags, 'Disable over-head icon on using team chat.')

if SERVER then
	RunConsoleCommand('mp_show_voice_icons', '0')

	resource.AddFile('materials/talkicon/voice.png')
	resource.AddFile('materials/talkicon/text.png')

	util.AddNetworkString('TalkIconChat')

	net.Receive('TalkIconChat', function(_, ply)
		local bool = net.ReadBool()
		ply:SetNW2Bool('ti_istyping', (bool ~= nil) and bool or false)
	end)
else
	local voice_mat = Material('talkicon/voice.png')
	local text_mat = Material('talkicon/text.png')

	hook.Add('PostPlayerDraw', 'TalkIcon', function(ply)
		if ply == LocalPlayer() and GetViewEntity() == LocalPlayer() and not ply:ShouldDrawLocalPlayer() then return end
		if not ply:Alive() then return end

		if not ply:IsSpeaking() and not (showtextchat:GetBool() and ply:GetNW2Bool('ti_istyping')) then return end

		local pos = ply:GetPos() + Vector(0, 0, ply:GetModelRadius() + 15)

		local attachment = ply:GetAttachment(ply:LookupAttachment('eyes'))
		if attachment then
			pos = ply:GetAttachment(ply:LookupAttachment('eyes')).Pos + Vector(0, 0, 15)
		end

		render.SetMaterial(ply:IsSpeaking() and voice_mat or text_mat)

		local color_var = 255

		if computecolor:GetBool() then
			local computed_color = render.ComputeLighting(ply:GetPos(), Vector(0, 0, 1))
			local max = math.max(computed_color.x, computed_color.y, computed_color.z)
			color_var = math.Clamp(max * 255 * 1.11, 0, 255)
		end

		render.DrawSprite(pos, 12, 12, Color(color_var, color_var, color_var, 255))
	end)

	hook.Add('StartChat', 'TalkIcon', function(isteam)
		if isteam and noteamchat:GetBool() then return end

		net.Start('TalkIconChat')
			net.WriteBool(true)
		net.SendToServer()
	end)

	hook.Add('FinishChat', 'TalkIcon', function()
		net.Start('TalkIconChat')
			net.WriteBool(false)
		net.SendToServer()
	end)

	hook.Add("InitPostEntity", "RemoveChatBubble", function()
		hook.Remove("StartChat", "StartChatIndicator")
		hook.Remove("FinishChat", "EndChatIndicator")

		hook.Remove("PostPlayerDraw", "DarkRP_ChatIndicator")
		hook.Remove("CreateClientsideRagdoll", "DarkRP_ChatIndicator")
		hook.Remove("player_disconnect", "DarkRP_ChatIndicator")
	end)
end
