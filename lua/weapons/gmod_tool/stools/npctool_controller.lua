-- "lua\\weapons\\gmod_tool\\stools\\npctool_controller.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
TOOL.Category = "NPC Control"
TOOL.Name = "NPC Controller"
TOOL.Command = nil
TOOL.ConfigName = ""

if(CLIENT) then
	TOOL.ClientConVar["walk"] = 0
	TOOL.ClientConVar["showcircle"] = 1
	language.Add("tool.npctool_controller.name","NPC Controller")
	language.Add("tool.npctool_controller.desc","Control a NPC")
	language.Add("tool.npctool_controller.0","Left-Click to de/select a NPC, or make the selected NPC move to a position/attack a NPC; Right-Click to possess the selected NPC")
	
	function TOOL.BuildCPanel(pnl)
		pnl:AddControl("Header",{Text = "Controller",Description = [[Left-Click to de/select a NPC.
		Right-Click to make all selected NPCs attack a target or move to a position.
		]]})
		pnl:AddControl("CheckBox",{Label = "Walk to position",Command = "npctool_controller_walk"})
		pnl:AddControl("CheckBox",{Label = "Show circle",Command = "npctool_controller_showcircle"})
	end
	
	local tbSelected = {}
	cvars.AddChangeCallback("npctool_controller_showcircle",function(cvar,prev,new)
		if(tobool(new)) then
			for _,ent in ipairs(tbSelected) do // TODO: Don't do this if tool isn't equipped
				if(ent:IsValid()) then
					ent:StopParticles()
					ParticleEffectAttach("plate_green",PATTACH_ABSORIGIN_FOLLOW,ent,0)
				end
			end
			return
		end
		for _,ent in ipairs(tbSelected) do
			if(ent:IsValid()) then
				ent:StopParticles()
			end
		end
	end)
	
	local matMove = surface.GetTextureID("HUD/crosshairs/hlr_stool_commander_crosshair2")
	local matAttack = surface.GetTextureID("HUD/crosshairs/hlr_stool_commander_crosshair1")
	function TOOL:DrawHUD()
		local tr = util.TraceLine(util.GetPlayerTrace(LocalPlayer()))
		local mat
		if(tr.Entity:IsValid() && (tr.Entity:IsNPC() || tr.Entity:IsPlayer())) then
			if(table.HasValue(tbSelected,tr.Entity)) then return end
			mat = matAttack
		else mat = matMove end
		surface.SetTexture(mat)
		surface.SetDrawColor(255,0,0,255)
		surface.DrawTexturedRect(ScrW() *0.5 -12,ScrH() *0.5 -12,24,24)
	end
	
	net.Receive("npctool_contr_add",function(len)
		local ent = net.ReadEntity()
		if(!ent:IsValid()) then return end
		local bSelected = net.ReadUInt(1) == 1
		if(!bSelected) then
			ent:StopParticles()
			for _,entTgt in ipairs(tbSelected) do
				if(entTgt == ent) then
					table.remove(tbSelected,_)
					break
				end
			end
		else
			table.insert(tbSelected,ent)
			if(GetConVarNumber("npctool_controller_showcircle") != 0) then ParticleEffectAttach("plate_green",PATTACH_ABSORIGIN_FOLLOW,ent,0) end
		end
	end)
	
	net.Receive("npctool_controller_deploy",function(len)
		if(GetConVarNumber("npctool_controller_showcircle") == 0) then return end
		for _,ent in ipairs(tbSelected) do
			if(ent:IsValid()) then
				ParticleEffectAttach("plate_green",PATTACH_ABSORIGIN_FOLLOW,ent,0)
			end
		end
	end)
	
	net.Receive("npctool_controller_holster",function(len)
		for _,ent in ipairs(tbSelected) do
			if(ent:IsValid()) then ent:StopParticles() end
		end
	end)
else
	util.AddNetworkString("npctool_contr_add")
	util.AddNetworkString("npctool_controller_holster")
	util.AddNetworkString("npctool_controller_deploy")
	function TOOL:Deploy()
		net.Start("npctool_controller_deploy")
		net.Send(self:GetOwner())
	end
	function TOOL:StopControl(ent)
		for _,entTgt in ipairs(self.m_tbNPCs) do
			if(entTgt == ent) then
				table.remove(self.m_tbNPCs,_)
				break
			end
		end
		for entTgt,disp in pairs(self.m_tbDisp[ent]) do
			if(entTgt:IsValid()) then
				ent:AddEntityRelationship(entTgt,disp,100)
				if(self.m_tbDisp[entTgt] && self.m_tbDisp[entTgt][ent] && !entTgt.m_bControlled) then
					entTgt:AddEntityRelationship(ent,self.m_tbDisp[entTgt][ent],100)
					self.m_tbDisp[entTgt][ent] = nil
				elseif(entTgt:IsNPC()) then entTgt:AddEntityRelationship(ent,disp,100) end
			end
		end
		self.m_tbDisp[ent] = nil
		ent.m_bControlled = false
		net.Start("npctool_contr_add")
			net.WriteEntity(ent)
			net.WriteUInt(1,0)
		net.Send(self:GetOwner())
	end
	function TOOL:StartControl(ent)
		self.m_tbDisp = self.m_tbDisp || {}
		self.m_tbDisp[ent] = {}
		ent.m_bControlled = true
		for _,entTgt in ipairs(ents.GetAll()) do
			if(entTgt:IsNPC() || entTgt:IsPlayer()) then
				self.m_tbDisp[ent][entTgt] = ent:Disposition(entTgt)
				ent:AddEntityRelationship(entTgt,D_LI,100)
				if(entTgt:IsNPC()) then
					self.m_tbDisp[entTgt] = self.m_tbDisp[entTgt] || {}
					self.m_tbDisp[entTgt][ent] = entTgt:Disposition(ent)
					entTgt:AddEntityRelationship(ent,D_LI,100)
				end
			end
		end
		table.insert(self.m_tbNPCs,ent)
		net.Start("npctool_contr_add")
			net.WriteEntity(ent)
			net.WriteUInt(1,1)
		net.Send(self:GetOwner())
	end
end

function TOOL:LeftClick(tr)
	if(!tr.Entity:IsValid() || !tr.Entity:IsNPC()) then return false end
	if(CLIENT) then return true end
	self.m_tbNPCs = self.m_tbNPCs || {}
	if(table.HasValue(self.m_tbNPCs,tr.Entity)) then
		local l = "notification.AddLegacy(language.GetPhrase(\"#" .. tr.Entity:GetClass() .. "\") .. \" deselected.\",0,8);"
		l = l .. "surface.PlaySound(\"buttons/button14.wav\")"
		self:GetOwner():SendLua(l)
		self:StopControl(tr.Entity)
		return true
	elseif(tr.Entity.m_bControlled) then
		local l = "notification.AddLegacy(\"This NPC is already being controlled by someone else.\",1,8);"
		l = l .. "surface.PlaySound(\"buttons/button10.wav\")"
		self:GetOwner():SendLua(l)
		return false
	elseif(tr.Entity.IsPossessed && tr.Entity:IsPossessed()) then
		local l = "notification.AddLegacy(\"This NPC is already being possessed by someone.\",1,8);"
		l = l .. "surface.PlaySound(\"buttons/button10.wav\")"
		self:GetOwner():SendLua(l)
		return false
	end
	local l = "notification.AddLegacy(language.GetPhrase(\"#" .. tr.Entity:GetClass() .. "\") .. \" selected.\",0,8);"
	l = l .. "surface.PlaySound(\"buttons/button14.wav\")"
	self:GetOwner():SendLua(l)
	self:StartControl(tr.Entity)
	return true
end

function TOOL:RightClick(tr)
	if(CLIENT) then return false end
	self.m_tbNPCs = self.m_tbNPCs || {}
	for i = #self.m_tbNPCs,1,-1 do
		if(!self.m_tbNPCs[i]:IsValid()) then
			table.remove(self.m_tbNPCs,i)
		end
	end
	if(!self.m_tbNPCs[1]) then
		local l = "notification.AddLegacy(\"No npcs selected.\",1,8);"
		l = l .. "surface.PlaySound(\"buttons/button10.wav\")"
		self:GetOwner():SendLua(l)
		return false
	end
	if(tr.Entity:IsValid() && (tr.Entity:IsNPC() || tr.Entity:IsPlayer())) then
		for _,ent in ipairs(self.m_tbNPCs) do
			ent:AddEntityRelationship(tr.Entity,D_HT,100)
			ent:SetEnemy(tr.Entity)
			if(tr.Entity:IsNPC()) then tr.Entity:AddEntityRelationship(ent,D_HT,100) end
		end
		return true
	end
	local schd
	if(self:GetClientNumber("walk") == 1) then schd = SCHED_FORCED_GO
	else schd = SCHED_FORCED_GO_RUN end
	for _,ent in ipairs(self.m_tbNPCs) do
		ent:SetLastPosition(tr.HitPos)
		ent:SetSchedule(schd)
	end
	return true
end

function TOOL:Holster()
	if(CLIENT) then return end
	net.Start("npctool_controller_holster")
	net.Send(self:GetOwner())
end