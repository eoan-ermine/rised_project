-- "lua\\weapons\\gmod_tool\\stools\\npctool_follower.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
TOOL.Category = "NPC Control"
TOOL.Name = "NPC Follower"
TOOL.Command = nil
TOOL.ConfigName = ""

if(CLIENT) then
	language.Add("tool.npctool_follower.name","NPC Follower")
	language.Add("tool.npctool_follower.desc","Make a NPC follow an entity.")
	language.Add("tool.npctool_follower.0","Left-Click to select a NPC, Right-Click to make all selected NPCs follow a target, Reload to make them follow yourself.")
	
	function TOOL.BuildCPanel(pnl)
		pnl:AddControl("Header",{Text = "Notarget",Description = [[Left-Click to select a NPC.
		Right-Click to make all selected NPCs follow a target.
		Reload to make them follow yourself.
		]]})
	end
	
	local tbEntsSelected = {}
	net.Receive("npctool_follower_select",function(len)
		local ent = net.ReadEntity()
		if(!ent:IsValid()) then return end
		local bSelected = net.ReadUInt(1) == 1
		if(!bSelected) then
			notification.AddLegacy(language.GetPhrase("#" .. ent:GetClass()) .. " deselected.",0,8)
			ent:StopParticles()
			for _,entTgt in ipairs(tbEntsSelected) do
				if(ent == entTgt) then
					table.remove(tbEntsSelected,_)
					break
				end
			end
		else
			notification.AddLegacy(language.GetPhrase("#" .. ent:GetClass()) .. " selected.",0,8)
			ParticleEffectAttach("plate_green",PATTACH_ABSORIGIN_FOLLOW,ent,0)
			table.insert(tbEntsSelected,ent)
		end
	end)
	
	net.Receive("npctool_follower_start",function(len)
		local num = net.ReadUInt(8)
		local bLocal = net.ReadUInt(1) == 1
		if(bLocal) then
			if(num == 1) then notification.AddLegacy("1 NPC is now following you.",0,8)
			else notification.AddLegacy(num .. " NPCs are now following you.",0,8) end
			return
		end
		local ent = net.ReadEntity()
		if(!ent:IsValid()) then return end
		if(num == 1) then notification.AddLegacy("1 NPC is now following " .. language.GetPhrase("#" .. ent:GetClass()) .. ".",0,8)
		else notification.AddLegacy(num .. " NPCs are now following " .. language.GetPhrase("#" .. ent:GetClass()) .. ".",0,8) end
	end)
	
	net.Receive("npctool_follower_deploy",function(len)
		for _,ent in ipairs(tbEntsSelected) do
			if(ent:IsValid()) then
				ParticleEffectAttach("plate_green",PATTACH_ABSORIGIN_FOLLOW,ent,0)
			end
		end
	end)
	
	net.Receive("npctool_follower_holster",function(len)
		for _,ent in ipairs(tbEntsSelected) do
			if(ent:IsValid()) then ent:StopParticles() end
		end
	end)
else
	util.AddNetworkString("npctool_follower_select")
	util.AddNetworkString("npctool_follower_start")
	util.AddNetworkString("npctool_follower_holster")
	util.AddNetworkString("npctool_follower_deploy")
	function TOOL:Deploy()
		net.Start("npctool_follower_deploy")
		net.Send(self:GetOwner())
	end
end

function TOOL:StartFollowing(src,tgt)
	self:StopFollowing(src)
	self.m_tbDisp = self.m_tbDisp || {}
	local hk = "npctool_follower" .. src:EntIndex() .. tgt:EntIndex()
	self.m_tbDisp[src] = self.m_tbDisp[src] || {}
	self.m_tbDisp[src][tgt] = src:Disposition(tgt)
	if(tgt:IsNPC()) then
		self.m_tbDisp[tgt] = self.m_tbDisp[tgt] || {}
		self.m_tbDisp[tgt][src] = tgt:Disposition(src)
		tgt:AddEntityRelationship(src,D_LI,100)
	end
	if(tgt:IsNPC() || tgt:IsPlayer()) then src:AddEntityRelationship(tgt,D_LI,100) end
	if(src.bScripted) then src.fFollowDistance = 200; src:SetBehavior(1,tgt); return end
	local nextUpdate = CurTime()
	local last
	hook.Add("Think",hk,function()
		if(!src:IsValid() || !tgt:IsValid()) then hook.Remove("Think",hk)
		elseif(CurTime() >= nextUpdate) then
			nextUpdate = CurTime() +0.5
			local posSrc = src:GetPos()
			local posTgt = tgt:GetPos()
			if(!last || !src:IsCurrentSchedule(SCHED_FORCED_GO_RUN) || posTgt:Distance(last) > 200) then
				last = posTgt
				local d = math.max(posSrc:Distance(posTgt) -(src:OBBMaxs().x +tgt:OBBMaxs().x),0)
				local schd = SCHED_FORCED_GO_RUN
				if(d > 200) then
					src:SetLastPosition(posTgt)
					src:SetSchedule(schd)
				elseif(src:IsCurrentSchedule(schd)) then src:ClearSchedule(); src:StopMoving() end
			end
		end
	end)
end

function TOOL:StopFollowing(src)
	if(!self.m_tbDisp) then return end
	if(!self.m_tbDisp[src]) then return end
	for tgt,disp in pairs(self.m_tbDisp[src]) do
		if(tgt:IsValid()) then
			hook.Remove("Think","npctool_follower" .. src:EntIndex() .. tgt:EntIndex())
			src:AddEntityRelationship(tgt,disp,100)
			self.m_tbDisp[src][tgt] = nil
			if(!tgt:IsPlayer()) then
				if(self.m_tbDisp[tgt] && self.m_tbDisp[tgt][src]) then
					tgt:AddEntityRelationship(src,self.m_tbDisp[tgt][src],100)
					self.m_tbDisp[tgt][src] = nil
				else tgt:AddEntityRelationship(src,disp,100) end
			end
		end
	end
end

function TOOL:Holster()
	if(CLIENT) then return end
	net.Start("npctool_follower_holster")
	net.Send(self:GetOwner())
end

function TOOL:LeftClick(tr)
	if(CLIENT) then return true end
	if(tr.Entity:IsValid() && tr.Entity:IsNPC()) then
		self.m_tbNPCs = self.m_tbNPCs || {}
		local bExists
		for _,ent in ipairs(self.m_tbNPCs) do
			if(ent == tr.Entity) then
				table.remove(self.m_tbNPCs,_)
				bExists = true
				break
			end
		end
		if(!bExists) then
			table.insert(self.m_tbNPCs,tr.Entity)
		end
		net.Start("npctool_follower_select")
			net.WriteEntity(tr.Entity)
			net.WriteUInt(bExists && 0 || 1,1)
		net.Send(self:GetOwner())
		return true
	end
	return false
end

function TOOL:RightClick(tr)
	if(!self.m_tbNPCs) then return false end
	if(!tr.Entity:IsValid()) then return false end
	if(CLIENT) then return true end
	local num = 0
	for _,ent in ipairs(self.m_tbNPCs) do
		if(ent:IsValid()) then
			self:StartFollowing(ent,tr.Entity)
			num = num +1
		end
	end
	if(num > 0) then
		net.Start("npctool_follower_start")
			net.WriteUInt(num,8)
			net.WriteUInt(0,1)
			net.WriteEntity(tr.Entity)
		net.Send(self:GetOwner())
	end
	return false
end

function TOOL:Reload()
	if(CLIENT) then return end
	if(!self.m_tbNPCs) then return end
	local pl = self:GetOwner()
	local num = 0
	for _,ent in ipairs(self.m_tbNPCs) do
		if(ent:IsValid()) then
			num = num +1
			self:StartFollowing(ent,pl)
		end
	end
	if(num > 0) then
		net.Start("npctool_follower_start")
			net.WriteUInt(num,8)
			net.WriteUInt(1,1)
		net.Send(self:GetOwner())
	end
end