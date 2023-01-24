-- "addons\\rised_voice_system\\lua\\autorun\\client\\cl_voice_system.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

hook.Add("PlayerStartVoice", "CombineRadioSoundVoiceStart", function( ply )
	if ply:GetNWInt("PersonalRPLevel", 50) < -50 then
		notification.AddLegacy( "Уровень вашего РП слишком низок для голосового чата!", NOTIFY_UNDO, 2 )
	end

	if ply == LocalPlayer() and ply:isCP() then
		net.Start( "NetworkCombineVoiceSoundStart" )
		net.SendToServer()
	end
end)

hook.Add("PlayerEndVoice", "CombineRadioSoundVoiceEnd", function( ply )
	if ply == LocalPlayer() and ply:isCP() then
		net.Start( "NetworkCombineVoiceSoundEnd" )
		net.SendToServer()
	end
end)

hook.Add("PlayerStartVoice", "ImageOnVoice", function()
	-- return true
end)

-- hook.Add( "StartChat", "CombineChatSoundStart", function(ply)
-- 	if ply == LocalPlayer() and ply:isCP() then
-- 		net.Start( "NetworkCombineChatSoundStart" )
-- 		net.SendToServer()
-- 	end
-- end)

-- hook.Add( "OnPlayerChat", "CombineChatSoundEnd", function(ply)
-- 	if ply == LocalPlayer() and ply:isCP() then
-- 		net.Start( "NetworkCombineChatSoundEnd" )
-- 		net.SendToServer()
-- 	end
-- end)