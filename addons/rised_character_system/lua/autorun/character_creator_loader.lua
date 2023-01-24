-- "addons\\rised_character_system\\lua\\autorun\\character_creator_loader.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[

 _____ _                          _                   _____                _             
|  __ \ |                        | |                 |  __ |              | |            
| /  \/ |__   __ _ _ __ __ _  ___| |_ ___ _ __ ______| /  \|_ __ ___  __ _| |_ ___  _ __ 
| |   | '_ \ / _` | '__/ _` |/ __| __/ _ \ '__|______| |   | '__/ _ \/ _` | __/ _ \| '__|
| \__/\ | | | (_| | | | (_| | (__| ||  __/ |         | \__/\ | |  __/ (_| | || (_) | |   
|_____/_| |_|\__,_|_|  \__,_|\___|\__\___|_|         |_____/_|  \___|\__,_|\__\___/|_|   
                                                                                                                                                                                  

]]

CharacterCreator = {}
include("character_creator/sh_chc_config.lua")
include("character_creator/sh_chc_lang.lua")
include("character_creator/sh_chc_materials.lua")
	
if SERVER then

	AddCSLuaFile("character_creator/sh_chc_config.lua")
	AddCSLuaFile("character_creator/sh_chc_lang.lua")
	AddCSLuaFile("character_creator/sh_chc_materials.lua")
	
	AddCSLuaFile("character_creator/client/cl_character_creator.lua")
	AddCSLuaFile("character_creator/client/cl_character_creator_admin.lua")
	AddCSLuaFile("character_creator/client/cl_character_creator_fonts.lua")

	include("character_creator/server/sv_character_creator_save.lua")
	include("character_creator/server/sv_character_creator_tool.lua")

elseif CLIENT then

	include("character_creator/client/cl_character_creator.lua")
	include("character_creator/client/cl_character_creator_admin.lua")
	include("character_creator/client/cl_character_creator_fonts.lua")
	
end
