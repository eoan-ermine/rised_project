-- "lua\\weapons\\gmod_tool\\stools\\npctool_health.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
TOOL.Category = "NPC Control"
TOOL.Name = "NPC Health"
TOOL.Command = nil
TOOL.ConfigName = ""

if(CLIENT) then
	TOOL.ClientConVar["health"] = "100"
	TOOL.ClientConVar["invincible"] = 0
	
	language.Add("tool.npctool_health.name","NPC Health")
	language.Add("tool.npctool_health.desc","Change a NPC's health")
	language.Add("tool.npctool_health.0","Left-Click to change the health of a NPC to the set value.")
   
	function TOOL.BuildCPanel(pnl)
		pnl:AddControl("Header",{Text = "Health",Description = [[Left-Click to change the health of a NPC to the set value.
		]]})
		pnl:AddControl("CheckBox",{Label = "Invincible",Command = "npctool_health_invincible"})
		pnl:AddControl("Slider",{Label = "Health: ",min = 1,max = 5000,Command = "npctool_health_health"})
	end
	
	net.Receive("npctool_health_set",function(len)
		local ent = net.ReadEntity()
		if(!ent:IsValid()) then return end
		local cvHealth = GetConVar("npctool_health_health")
		local cvInvincible = GetConVar("npctool_health_invincible")
		local bWasInvincible = net.ReadUInt(1) != 0
		local hp = cvHealth:GetInt()
		local bInvincible = cvInvincible:GetBool()
		local name = language.GetPhrase("#" .. ent:GetClass())
		if(bInvincible) then if(!bWasInvincible) then notification.AddLegacy(name .. " is now invincible.",0,8) end
		else
			if(bWasInvincible) then notification.AddLegacy(name .. " is not invincible anymore.",0,8) end
			notification.AddLegacy("Set health of " .. name .. " to " .. hp,0,8)
		end
		surface.PlaySound("buttons/button14.wav")
	end)
	function TOOL:LeftClick(tr) return true end
else
	util.AddNetworkString("npctool_health_set")
	local tbEntsInvincible = {}
	function TOOL:LeftClick(tr)
		if(tr.Entity:IsValid() && tr.Entity:IsNPC()) then
			tr.Entity:SetHealth(self:GetClientNumber("health"))
			net.Start("npctool_health_set")
			net.WriteEntity(tr.Entity)
				if(self:GetClientNumber("invincible") != 0) then
					if(tr.Entity.bScripted) then
						local bInvincible = tr.Entity:IsInvincible()
						if(!bInvincible) then tr.Entity:SetInvincible(true) end
						net.WriteUInt(bInvincible && 1 || 0,1)
					elseif(!table.HasValue(tbEntsInvincible,tr.Entity)) then
						table.insert(tbEntsInvincible,tr.Entity)
						local idx = tr.Entity:EntIndex()
						local hk = "npctool_health_invincible" .. idx
						hook.Add("EntityTakeDamage",hk,function(npc,dmginfo)
							if(!tr.Entity:IsValid()) then hook.Remove("EntityTakeDamage",hk)
							elseif(npc == tr.Entity) then dmginfo:SetDamage(0) end
						end)
						net.WriteUInt(0,1)
					else net.WriteUInt(1,1) end
				else
					if(tr.Entity.bScripted) then
						net.WriteUInt(tr.Entity:IsInvincible() && 1 || 0,1)
						tr.Entity:SetInvincible(false)
					elseif(table.HasValue(tbEntsInvincible,tr.Entity)) then
						net.WriteUInt(1,1)
						for _,ent in ipairs(tbEntsInvincible) do
							if(ent == tr.Entity) then
								table.remove(tbEntsInvincible,_)
								break
							end
						end
						hook.Remove("EntityTakeDamage","npctool_health_invincible" .. tr.Entity:EntIndex())
					else net.WriteUInt(0,1) end
				end
			net.Send(self:GetOwner())
			return true
		end
	end
end