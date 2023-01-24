-- "lua\\weapons\\gmod_tool\\stools\\npctool_relationships.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
TOOL.Category = "NPC Control"
TOOL.Name = "NPC Relationships"
TOOL.Command = nil
TOOL.ConfigName = ""

if(CLIENT) then
	local D_HT = 1
	local D_FR = 2
	local D_LI = 3
	local D_NU = 4
	TOOL.ClientConVar["disposition"] = D_HT
	TOOL.ClientConVar["revert"] = 1
	language.Add("tool.npctool_relationships.name","NPC Relationships")
	language.Add("tool.npctool_relationships.desc","Change an NPC's relationship to another NPC or player")
	language.Add("tool.npctool_relationships.0","Left-Click to select a source NPC or player, Right-Click to apply the relationship to the target you're looking at, Reload to set yourself as target.")
	function TOOL.BuildCPanel(pnl)
		pnl:AddControl("Header",{Text = "Relationships",Description = [[Left-Click to select a source NPC or player.
		Right-Click to apply the relationship to the target you're looking at.
		Reload to set yourself as target.
		]]})
		local lbl = vgui.Create("DLabel",pnl)
		lbl:SetColor(Color(0,0,0,255))
		lbl:SetText("Disposition:")
		
		local pCBox = vgui.Create("DComboBox",pnl)
		pCBox:AddChoice("Hate",D_HT,true)
		pCBox:AddChoice("Fear",D_FR)
		pCBox:AddChoice("Like",D_LI)
		pCBox:AddChoice("Neutral",D_NU)
		pCBox.OnSelect = function(pCBox,idx,val,data) RunConsoleCommand("npctool_relationships_disposition",data) end
		pCBox:SetWide(130)
		pnl:AddItem(lbl,pCBox)
		pnl:AddControl("CheckBox",{Label = "Revert",Command = "npctool_relationships_revert"})
	end
	local tbSelected = {}
	net.Receive("npctool_rel_add",function(len)
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
			ParticleEffectAttach("plate_green",PATTACH_ABSORIGIN_FOLLOW,ent,0)
			table.insert(tbSelected,ent)
		end
	end)
	net.Receive("npctool_rel_set",function(len)
		local bMultiple = net.ReadUInt(1) == 1
		local src
		if(!bMultiple) then
			src = net.ReadEntity()
			if(!src:IsValid()) then return end
		end
		local tgt = net.ReadEntity()
		if(!tgt:IsValid()) then return end
		surface.PlaySound("buttons/button14.wav")
		local nameSrc
		if(!bMultiple) then nameSrc = language.GetPhrase("#" .. src:GetClass())
		else nameSrc = "Source NPCs" end
		local nameTgt
		if(tgt:IsPlayer()) then nameTgt = tgt:GetName()
		else nameTgt = language.GetPhrase("#" .. tgt:GetClass()) end
		local cvDisp = GetConVar("npctool_relationships_disposition")
		local cvRevert = GetConVar("npctool_relationships_revert")
		local disp = cvDisp:GetInt()
		local bRevert = cvRevert:GetBool()
		if(disp == D_HT) then disp = "Hate"
		elseif(disp == D_FR) then disp = "Fear"
		elseif(disp == D_LI) then disp = "Like"
		else disp = "Neutral" end
		notification.AddLegacy("Set disposition from " .. nameSrc .. " to " .. nameTgt .. " to '" .. disp .. "'.",0,8)
		if(bRevert && !tgt:IsPlayer()) then notification.AddLegacy("Set disposition from " .. nameTgt .. " to " .. nameSrc .. " to '" .. disp .. "'.",0,8) end
	end)
	net.Receive("npctool_relationships_deploy",function(len)
		for _,ent in ipairs(tbSelected) do
			if(ent:IsValid()) then
				ParticleEffectAttach("plate_green",PATTACH_ABSORIGIN_FOLLOW,ent,0)
			end
		end
	end)
	net.Receive("npctool_relationships_holster",function(len)
		for _,ent in ipairs(tbSelected) do
			if(ent:IsValid()) then ent:StopParticles() end
		end
	end)
else
	util.AddNetworkString("npctool_rel_add")
	util.AddNetworkString("npctool_rel_set")
	util.AddNetworkString("npctool_relationships_holster")
	util.AddNetworkString("npctool_relationships_deploy")
	function TOOL:Deploy()
		net.Start("npctool_relationships_deploy")
		net.Send(self:GetOwner())
	end
	function TOOL:ApplyDisposition(ent)
		local disp = self:GetClientNumber("disposition")
		local revert = self:GetClientNumber("revert")
		for _,src in ipairs(self.m_tbSelected) do
			src:AddEntityRelationship(ent,disp,100)
			if(revert != 0 && ent:IsNPC()) then
				ent:AddEntityRelationship(src,disp,100)
			end
		end
		local num = #self.m_tbSelected
		net.Start("npctool_rel_set")
			net.WriteUInt(num > 1 && 1 || 0,1)
			if(num == 1) then net.WriteEntity(self.m_tbSelected[1]) end
			net.WriteEntity(ent)
		net.Send(self:GetOwner())
	end
	function TOOL:CheckSource()
		if(!self.m_tbSelected) then return false end
		for i = #self.m_tbSelected,1,-1 do
			if(!self.m_tbSelected[i]:IsValid()) then
				table.remove(self.m_tbSelected,i)
			end
		end
		if(#self.m_tbSelected == 0) then
			local l = "notification.AddLegacy(\"No source NPCs selected.\",1,8);"
			l = l .. "surface.PlaySound(\"buttons/button10.wav\")"
			self:GetOwner():SendLua(l)
			return false
		end
		return true
	end
end

function TOOL:LeftClick(tr)
	if(tr.Entity:IsValid() && tr.Entity:IsNPC()) then
		if(CLIENT) then return true end
		self.m_tbSelected = self.m_tbSelected || {}
		net.Start("npctool_rel_add")
		net.WriteEntity(tr.Entity)
		for _,ent in ipairs(self.m_tbSelected) do
			if(ent == tr.Entity) then
				self:GetOwner():SendLua("notification.AddLegacy(language.GetPhrase(\"#" .. tr.Entity:GetClass() .. "\") .. \" deselected.\",0,8)")
				table.remove(self.m_tbSelected,_)
				net.WriteUInt(0,1)
				net.Send(self:GetOwner())
				return
			end
		end
		self:GetOwner():SendLua("notification.AddLegacy(language.GetPhrase(\"#" .. tr.Entity:GetClass() .. "\") .. \" selected.\",0,8)")
		table.insert(self.m_tbSelected,tr.Entity)
		net.WriteUInt(1,1)
		net.Send(self:GetOwner())
		return true
	end
	return false
end

function TOOL:RightClick(tr)
	if(!tr.Entity:IsValid() || (!tr.Entity:IsNPC() && !tr.Entity:IsPlayer())) then return false end
	if(CLIENT) then return true end
	if(!self:CheckSource()) then return false end
	self:ApplyDisposition(tr.Entity)
	return true
end

function TOOL:Reload(tr)
	if(CLIENT) then return true end
	if(!self:CheckSource()) then return false end
	self:ApplyDisposition(self:GetOwner())
end

function TOOL:Holster()
	if(CLIENT) then return end
	net.Start("npctool_relationships_holster")
	net.Send(self:GetOwner())
end