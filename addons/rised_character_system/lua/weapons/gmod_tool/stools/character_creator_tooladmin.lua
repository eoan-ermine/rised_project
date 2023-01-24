-- "addons\\rised_character_system\\lua\\weapons\\gmod_tool\\stools\\character_creator_tooladmin.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[

 _____ _                          _                   _____                _             
|  __ \ |                        | |                 |  __ |              | |            
| /  \/ |__   __ _ _ __ __ _  ___| |_ ___ _ __ ______| /  \|_ __ ___  __ _| |_ ___  _ __ 
| |   | '_ \ / _` | '__/ _` |/ __| __/ _ \ '__|______| |   | '__/ _ \/ _` | __/ _ \| '__|
| \__/\ | | | (_| | | | (_| | (__| ||  __/ |         | \__/\ | |  __/ (_| | || (_) | |   
|_____/_| |_|\__,_|_|  \__,_|\___|\__\___|_|         |_____/_|  \___|\__,_|\__\___/|_|   
                                                                                                                                                                                  

]]

AddCSLuaFile()

TOOL.Category = "Character Creator"
TOOL.Name = "Chc-Administration"
TOOL.Author = "Kobralost"

if CLIENT then
	language.Add("tool.character_creator_tooladmin.desc", "Administration - Character Creator" )
	language.Add("tool.character_creator_tooladmin.0", "Left-Click : Player Information / Right-Click : Your Information" )
	language.Add("tool.character_creator_tooladmin.name", "Character-Creator")
end

function TOOL:LeftClick(trace)
	local ply = self:GetOwner()
	local trace = ply:GetEyeTrace()
	if SERVER then 
		if CharacterCreator.RankToOpenAdmin[ply:GetUserGroup()] then  
			if IsValid(trace.Entity) and trace.Entity:IsPlayer() then 
				net.Start("CharacterCreator:MenuAdminOpen")
				net.WriteEntity(trace.Entity)
				net.Send(ply)
			end 
		end 
	end 
end 

function TOOL:RightClick(trace)
	local ply = self:GetOwner()
	if SERVER then
		if CharacterCreator.RankToOpenAdmin[ply:GetUserGroup()] then  
			if IsValid(ply) and ply:IsPlayer() then 
				net.Start("CharacterCreator:MenuAdminOpen")
				net.WriteEntity(ply)
				net.Send(ply)
			end 
		end 
	end 
end 


