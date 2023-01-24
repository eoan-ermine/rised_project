-- "lua\\weapons\\gmod_tool\\stools\\npctool_proficiency.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
TOOL.Category = "NPC Control"
TOOL.Name = "NPC Proficiency"
TOOL.Command = nil
TOOL.ConfigName = ""

if(CLIENT) then
	local function NumSlider(self,strLabel,strConVar,numMin,numMax,numDecimals)
		local left = vgui.Create("DNumSliderLegacy",self)
		left:SetText(strLabel)
		left:SetMinMax(numMin,numMax)
		left:SetDark(true)
		
		if(numDecimals != nil) then left:SetDecimals(numDecimals) end
		left:SetConVar(strConVar)
		left:SizeToContents()
		self:AddItem(left,nil)
		return left
	end
	TOOL.ClientConVar["value"] = WEAPON_PROFICIENCY_AVERAGE
	language.Add("tool.npctool_proficiency.name","NPC Proficiency")
	language.Add("tool.npctool_proficiency.desc","Change a NPC's weapon proficiency.")
	language.Add("tool.npctool_proficiency.0","Left-Click on a NPC to change his proficiency, Right-Click to change the proficiency of all active NPCs of this class.")
	
	local values = {
		[WEAPON_PROFICIENCY_POOR] = "Poor",
		[WEAPON_PROFICIENCY_AVERAGE] = "Average",
		[WEAPON_PROFICIENCY_GOOD] = "Good",
		[WEAPON_PROFICIENCY_VERY_GOOD] = "Very Good",
		[WEAPON_PROFICIENCY_PERFECT] = "Perfect"
	}
	local bWarned
	local addon = 118115179
	local function ShowWarning()
		bWarned = true
		if(!game.SinglePlayer()) then return end
		if(!steamworks.IsSubscribed(addon) || !steamworks.ShouldMountAddon(addon)) then return end
		steamworks.FileInfo(addon,function(r)
			r = r || {title = "Error"}
			local w = 500
			local pnl = vgui.Create("DFrame")
			pnl:SetTitle("NPC Proficiency - Warning")
			pnl:SizeToContents()
			pnl:MakePopup()

			local y = 40
			local function AddLine(line)
				local l = vgui.Create("DLabel",pnl)
				l:SetText(line)
				l:SetPos(20,y)
				l:SizeToContents()
				
				y = y +l:GetTall()
			end
			AddLine("You have the '" .. r.title .. "' Addon installed, which is incompatible with this tool.")
			AddLine("Using this tool will have no effect.")
			local h = y +60
			local x,yPnl = ScrW() *0.5 -w *0.5,ScrH() *0.5 -h *0.5
			pnl:SetSize(w,h)
			pnl:SetPos(x,yPnl)

			local p = vgui.Create("DButton",pnl)
			p:SetText("OK")
			p.DoClick = function() pnl:Close() end
			p:SetPos(w *0.5 -p:GetWide() *0.5,y +20)
		end)
	end
	function TOOL.BuildCPanel(pnl)
		if(!bWarned) then ShowWarning() end
		pnl:AddControl("Header",{Text = "Viewcam",Description = [[Left-Click on a NPC to change his proficiency.
		Right-Click to change the proficiency of all active NPCs of this class.
		]]})
		local pSl = NumSlider(pnl,"Proficiency:",nil,1,5,0)
		local prof = values[GetConVarNumber("npctool_proficiency_value")] || "Poor"
		pSl.Wang:SetText(prof)
		local i
		for _,val in ipairs(values) do if(val == prof) then i = _ +1; break end end
		if(i) then pSl.Slider:SetSlideX((i -1) /4) end
		pSl.TranslateSliderValues = function(...)
			local x,y = select(2,...)
			local num = tonumber(x *4 +1) || 0
			num = math.Round(num)
			local val = math.Clamp(num,1,5)
			pSl.Wang:SetText(values[val -1] || "Poor")
			RunConsoleCommand("npctool_proficiency_value",val -1)
			return ((num -1) /4),y
		end
	end
	local tbProficiency
	net.Receive("npctool_proficiency_update",function(len)
		local ent = net.ReadEntity()
		if(!ent:IsValid()) then return end
		local prof = net.ReadUInt(3)
		local bType = net.ReadUInt(1) == 1
		local text
		if(!bType) then
			tbProficiency[ent] = prof
			text = "Set proficiency of " .. language.GetPhrase("#" .. ent:GetClass()) .. " to " .. string.lower(values[prof] || "poor") .. "."
		else
			local num = 0
			for _,ent in ipairs(ents.FindByClass(ent:GetClass())) do
				num = num +1
				tbProficiency[ent] = prof
			end
			text = "Set proficiency of all NPCs of type '" .. language.GetPhrase("#" .. ent:GetClass()) .. "' (" .. num .. ") to " .. string.lower(values[prof] || "poor") .. "."
		end
		notification.AddLegacy(text,0,8)
	end)
	net.Receive("npctool_proficiency_deploy",function(len)
		net.Start("sv_npctool_proficiency_request")
		net.SendToServer()
	end)
	net.Receive("npctool_proficiency_holster",function(len)
		local wep = LocalPlayer():GetActiveWeapon()
		if(wep:IsValid() && wep:GetClass() == "gmod_tool" && wep:GetMode() == "npctool_proficiency") then // False alarm
			return
		end
		tbProficiency = nil
		hook.Remove("RenderScreenspaceEffects","npctool_proficiency_draw")
		hook.Remove("OnEntityCreated","npctool_proficiency_update")
	end)
	net.Receive("cl_npctool_proficiency_request_sng",function(len)
		if(!tbProficiency) then return end
		local ent = net.ReadEntity()
		if(!ent:IsValid()) then return end
		local prof = net.ReadUInt(3)
		tbProficiency[ent] = prof
	end)
	net.Receive("cl_npctool_proficiency_request",function(len)
		tbProficiency = {}
		local num = net.ReadUInt(12)
		for i = 1,num do
			local ent = net.ReadEntity()
			local prof = net.ReadUInt(3)
			if(ent:IsValid()) then tbProficiency[ent] = prof end
		end
		hook.Add("OnEntityCreated","npctool_proficiency_update",function(ent)
			if(ent:IsValid() && ent:IsNPC()) then
				net.Start("sv_npctool_proficiency_request_sng")
					net.WriteEntity(ent)
				net.SendToServer()
			end
		end)
		hook.Add("RenderScreenspaceEffects","npctool_proficiency_draw",function()
			cam.Start3D(EyePos(),EyeAngles())
			for ent,prof in pairs(tbProficiency) do
				if(!ent:IsValid()) then tbProficiency[ent] = nil
				else
					local ang = LocalPlayer():EyeAngles()
					ang:RotateAroundAxis(ang:Forward(),90)
					ang:RotateAroundAxis(ang:Right(),90)
					local pos = ent:GetPos() +Vector(0,0,ent:OBBMaxs().z +16)
					cam.Start3D2D(pos,Angle(0,ang.y,90),0.5)
						draw.DrawText("Proficiency:","default",2,2,colText,TEXT_ALIGN_CENTER)
					cam.End3D2D()
					pos.z = pos.z -6
					cam.Start3D2D(pos,Angle(0,ang.y,90),0.5)
						draw.DrawText(values[prof] || "Poor","default",2,2,colText,TEXT_ALIGN_CENTER)
					cam.End3D2D()
				end
			end
			cam.End3D()
		end)
	end)
else
	util.AddNetworkString("npctool_proficiency_update")
	util.AddNetworkString("npctool_proficiency_holster")
	util.AddNetworkString("npctool_proficiency_deploy")
	util.AddNetworkString("sv_npctool_proficiency_request")
	util.AddNetworkString("cl_npctool_proficiency_request")
	util.AddNetworkString("sv_npctool_proficiency_request_sng")
	util.AddNetworkString("cl_npctool_proficiency_request_sng")
	net.Receive("sv_npctool_proficiency_request_sng",function(len,pl)
		local ent = net.ReadEntity()
		if(!ent:IsValid() || !ent:IsNPC()) then return end
		local prof = ent:GetCurrentWeaponProficiency()
		net.Start("cl_npctool_proficiency_request_sng")
			net.WriteEntity(ent)
			net.WriteUInt(prof,3)
		net.Send(pl)
	end)
	net.Receive("sv_npctool_proficiency_request",function(len,pl)
		local tbEnts = {}
		local num = 0
		for _,ent in ipairs(ents.GetAll()) do
			if(ent:IsNPC()) then
				num = num +1
				tbEnts[ent] = ent:GetCurrentWeaponProficiency()
			end
		end
		net.Start("cl_npctool_proficiency_request")
			net.WriteUInt(num,12)
			for ent,prof in pairs(tbEnts) do
				net.WriteEntity(ent)
				net.WriteUInt(prof,3)
			end
		net.Send(pl)
	end)
	function TOOL:Deploy()
		net.Start("npctool_proficiency_deploy")
		net.Send(self:GetOwner())
	end
end

function TOOL:LeftClick(tr)
	if(CLIENT) then return true end
	if(tr.Entity:IsValid() && tr.Entity:IsNPC()) then
		local prof = self:GetClientNumber("value")
		tr.Entity:SetCurrentWeaponProficiency(prof)
		net.Start("npctool_proficiency_update")
			net.WriteEntity(tr.Entity)
			net.WriteUInt(prof,3)
			net.WriteUInt(0,1)
		net.Send(self:GetOwner())
		return true
	end
	return false
end

function TOOL:RightClick(tr)
	if(CLIENT) then return true end
	if(tr.Entity:IsValid() && tr.Entity:IsNPC()) then
		local prof = self:GetClientNumber("value")
		for _,ent in ipairs(ents.FindByClass(tr.Entity:GetClass())) do
			ent:SetCurrentWeaponProficiency(prof)
		end
		net.Start("npctool_proficiency_update")
			net.WriteEntity(tr.Entity)
			net.WriteUInt(prof,3)
			net.WriteUInt(1,1)
		net.Send(self:GetOwner())
		return true
	end
	return false
end

function TOOL:Holster()
	if(CLIENT) then return end
	net.Start("npctool_proficiency_holster")
	net.Send(self:GetOwner())
end