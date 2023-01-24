-- "addons\\darkrpmodification\\lua\\darkrp_modules\\disablevoicebox\\cl_voicebox.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
hook.Remove("StartChat", "DarkRP_StartFindChatReceivers")
hook.Remove("PlayerStartVoice", "DarkRP_VoiceChatReceiverFinder")