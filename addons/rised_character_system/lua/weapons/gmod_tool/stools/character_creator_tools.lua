-- "addons\\rised_character_system\\lua\\weapons\\gmod_tool\\stools\\character_creator_tools.lua"
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
TOOL.Name = "Chc-Configuration"
TOOL.Author = "Kobralost"

if CLIENT then
	language.Add("tool.character_creator_tools.desc", "Npc Generator - Character Creator" )
	language.Add("tool.character_creator_tools.0", "Left-Click to place Npc" )
	language.Add("tool.character_creator_tools.name", "Character-Creator")
end

function TOOL:RightClick(trace)
	local ply = self:GetOwner()
	if SERVER then
		if self:GetOwner():IsSuperAdmin() then
			if (trace.Entity:GetClass() == "character_creator_menuopen" ) then 
				trace.Entity:Remove() 
			end 
		end 
	end 
end  

function TOOL:LeftClick(trace)
	local ply = self:GetOwner()
	if SERVER then
		timer.Create("chc_antispam_leftclick", 0.00000001, 1, function()
			if not IsValid( ply ) && not ply:IsPlayer() then return end  
			local trace = ply:GetEyeTrace()
			local position = trace.HitPos
			local angle = ply:GetAngles()
			local team = ply:GetUserGroup()
			if ply:IsSuperAdmin() then
				chc_createent = ents.Create( "character_creator_menuopen" )
				chc_createent:SetPos(position + Vector(0, 0, 0))
				chc_createent:SetAngles(Angle(0,angle.Yaw+180, 0))
				chc_createent:Spawn()
				chc_createent:Activate() 			
			end
		end)
	end
end 

function TOOL.BuildCPanel( CPanel )
	CPanel:AddControl("label", {
	Text = "Save Character Creator Entities" })
	CPanel:Button("Save Entities", "chc_save")

	CPanel:AddControl("label", {
	Text = "Remove all Entities in The Data" })
	CPanel:Button("Remove Entities Data", "chc_removedata")

	CPanel:AddControl("label", {
	Text = "Remove all Entities in The Map" })
	CPanel:Button("Remove Entities Map", "chc_cleaupentities")

	CPanel:AddControl("label", {
	Text = "Reload all Entities in The Map" })
	CPanel:Button("Reload Entities Map", "chc_reloadentities")
end

function TOOL:CreateRWCEnt()	
	if CLIENT then
		if IsValid(self.CHCEnt) then else
 			self.CHCEnt = ClientsideModel("models/player/Group01/male_01.mdl", RENDERGROUP_OPAQUE)
			self.CHCEnt:SetModel("models/player/Group01/male_01.mdl")
			self.CHCEnt:SetMaterial("models/wireframe")
			self.CHCEnt:SetPos(Vector(0,0,0))
			self.CHCEnt:SetAngles(Angle(0,0,0))
			self.CHCEnt:Spawn()
			self.CHCEnt:Activate()	
			self.CHCEnt.Ang = Angle(0,0,0)
			self.CHCEnt:SetRenderMode(RENDERMODE_TRANSALPHA)
			self.CHCEnt:SetColor(Color( 255, 255, 255, 150))
		end
	end 
end

function TOOL:Think() 
	if IsValid(self.CHCEnt) then
		ply = self:GetOwner()
		trace = util.TraceLine(util.GetPlayerTrace(ply))
		ang = ply:GetAimVector():Angle() 
		Pos = Vector(trace.HitPos.X, trace.HitPos.Y, trace.HitPos.Z)
		Ang = Angle(0, ang.Yaw+180, 0) + self.CHCEnt.Ang
		self.CHCEnt:SetPos(Pos)
		self.CHCEnt:SetAngles(Ang)
	else 
		self:CreateRWCEnt() 
	end 
end 

function TOOL:Holster()
	if IsValid(self.CHCEnt) then  
		self.CHCEnt:Remove()
	end 
end
