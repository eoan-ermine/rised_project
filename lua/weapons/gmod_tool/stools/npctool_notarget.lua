-- "lua\\weapons\\gmod_tool\\stools\\npctool_notarget.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
TOOL.Category = "NPC Control"
TOOL.Name = "NPC Notarget"
TOOL.Command = nil
TOOL.ConfigName = ""

if(CLIENT) then
	language.Add("tool.npctool_notarget.name","No Target")
	language.Add("tool.npctool_notarget.desc","Enable/Disable notarget for a NPC or yourself")
	language.Add("tool.npctool_notarget.0","Left-Click to enable/disable notarget for the NPC you're looking at. Right click to enable/disable notarget for yourself.")
	
	function TOOL.BuildCPanel(pnl)
		pnl:AddControl("Header",{Text = "Notarget",Description = [[Left-Click to enable/disable notarget for the NPC you're looking at.
		Right click to enable/disable notarget for yourself.
		]]})
	end
else
	local _R = debug.getregistry()
	local meta = _R.Player
	if(!meta.GetNoTarget) then
		local SetNoTarget = meta.SetNoTarget
		function meta:SetNoTarget(...)
			self.m_bNoTarget = ...
			return SetNoTarget(self,...)
		end
		function meta:GetNoTarget() return self.m_bNoTarget || false end
	end
	local meta = _R.NPC
	if(!meta.SetNoTarget) then
		local tbNPCsNoTarget = {}
		local AddEntityRelationship = meta.AddEntityRelationship
		function meta:AddEntityRelationship(...)
			local ent,disp = ...
			local dispCur = self:Disposition(ent)
			if(tbNPCsNoTarget[self]) then
				tbNPCsNoTarget[self][ent] = disp
				return
			end
			return AddEntityRelationship(self,...)
		end
		function meta:SetNoTarget(bNoTarget)
			if(bNoTarget) then
				if(!tbNPCsNoTarget[self]) then
					tbNPCsNoTarget[self] = {}
					for _,ent in ipairs(ents.GetAll()) do
						if(ent:IsNPC() && ent != self) then
							tbNPCsNoTarget[self][ent] = ent:Disposition(self)
							AddEntityRelationship(ent,self,D_NU,100)
						end
					end
				end
				return
			end
			for ent,disp in pairs(tbNPCsNoTarget[self]) do
				if(ent:IsValid()) then
					AddEntityRelationship(ent,self,disp,100)
				end
			end
			tbNPCsNoTarget[self] = nil
		end
		hook.Add("OnEntityCreated","ApplyNoTarget",function(ent)
			if(ent:IsValid() && ent:IsNPC()) then
				for entTgt,_ in pairs(tbNPCsNoTarget) do
					if(entTgt:IsValid()) then
						tbNPCsNoTarget[entTgt][ent] = ent:Disposition(entTgt)
						AddEntityRelationship(ent,entTgt,D_NU,100)
					else tbNPCsNoTarget[entTgt] = nil end
				end
			end
		end)
		function meta:GetNoTarget()
			return tbNPCsNoTarget[self] && true || false
		end
	end
end

function TOOL:LeftClick(tr)
	if(CLIENT) then return true end
	if(tr.Entity:IsValid() && tr.Entity:IsNPC()) then
		local bNoTarget = !tr.Entity:GetNoTarget()
		tr.Entity:SetNoTarget(bNoTarget)
		local l = "notification.AddLegacy(\"" .. (bNoTarget && "Enabled " || "Disabled ") .. "notarget for \" .. language.GetPhrase(\"#" .. tr.Entity:GetClass() .. "\") .. \".\",1,8);"
		l = l .. "surface.PlaySound(\"buttons/button14.wav\")"
		self:GetOwner():SendLua(l)
		return true
	end
end

function TOOL:RightClick(tr)
	if(CLIENT) then return true end
	local owner = self:GetOwner()
	local bNoTarget = !owner:GetNoTarget()
	owner:SetNoTarget(bNoTarget)
	local l = "notification.AddLegacy(\"" .. (bNoTarget && "Enabled " || "Disabled ") .. "notarget for " .. owner:GetName() .. ".\",1,8);"
	l = l .. "surface.PlaySound(\"buttons/button14.wav\")"
	owner:SendLua(l)
	return false
end