-- "lua\\weapons\\gmod_tool\\stools\\npctool_spawner.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
TOOL.Category = "NPC Control"
TOOL.Name = "NPC Spawn Creator"
TOOL.Command = nil
TOOL.ConfigName = ""

local WEAPON_PROFICIENCY_RANDOM = 5
local WEAPON_PROFICIENCY_DEFAULT = 6
if(CLIENT) then
	local D_HT = 1
	local D_FR = 2
	local D_LI = 3
	local D_NU = 4
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
	require("json")
	local tbCvars = {
		["class"] = "npc_zombie",
		["squad"] = "",
		["spawnflags"] = "0",
		["equipment"] = "",
		//["soundtrack"] = "",
		["delay"] = "4",
		["max"] = "4",
		["total"] = "0",
		["turnon"] = "",
		["turnoff"] = "",
		["starton"] = "1",
		["startburrowed"] = "1",
		["deleteonremove"] = "1",
		["patroltype"] = "1",
		["patrolwalk"] = "0",
		["patrolshow"] = "1",
		["patrolstrict"] = "0",
		["showeffects"] = "1",
		["proficiency"] = WEAPON_PROFICIENCY_DEFAULT
	}
	for cv,def in pairs(tbCvars) do
		TOOL.ClientConVar[cv] = def
	end
	local tbPatrolPoints = {}
	local tbPPEffects = {}
	local function CreatePatrolPointEffect(pos)
		local tbEnts = ents.GetAll()
		util.Effect("effect_cube",EffectData())
		local e = ents.GetAll()[#tbEnts +1]
		if(!e) then return end
		e:SetOrigin(pos)
		return e
	end
	local function CreatePatrolPoint(pos)
		if(GetConVarNumber("npctool_spawner_patrolshow") != 0) then
			local e = CreatePatrolPointEffect(pos)
			if(e) then e:SetID(table.insert(tbPPEffects,e)) end
		end
		table.insert(tbPatrolPoints,pos)
		net.Start("sv_npctool_spawner_ppoint")
		net.SendToServer()
	end
	local function GetTraceEffect()
		local pl = LocalPlayer()
		local pos = pl:GetShootPos()
		local dir = pl:GetAimVector()
		local eClosest
		local distClosest = math.huge
		for _,e in ipairs(tbPPEffects) do
			local hit,norm = util.IntersectRayWithOBB(pos,dir *32768,e:GetPos(),Angle(0,0,0),e:GetRenderBounds())
			if(hit) then
				local d = e:GetPos():Distance(pos)
				if(d < distClosest) then
					distClosest = d
					eClosest = _
				end
			end
		end
		return tbPPEffects[eClosest],eClosest
	end
	local mat = Material("trails/laser")
	local function ShowPatrolPoints(b)
		hook.Remove("RenderScreenspaceEffects","npctool_spawner_renderppoints")
		for _,ent in ipairs(tbPPEffects) do ent.m_bRemove = true end
		table.Empty(tbPPEffects)
		if(!b) then return end
		for _,pos in ipairs(tbPatrolPoints) do
			tbPPEffects[_] = CreatePatrolPointEffect(pos)
			tbPPEffects[_]:SetID(_)
		end
		local offset = Vector(0,0,6)
		local col = Color(255,255,255,255)
		local cv = GetConVar("npctool_spawner_patroltype")
		local colDefault = Color(255,255,255,255)
		local colSelected = Color(255,0,0,255)
		hook.Add("RenderScreenspaceEffects","npctool_spawner_renderppoints",function()
			cam.Start3D(EyePos(),EyeAngles())
			render.SetMaterial(mat)
			local num = #tbPPEffects
			for i = 2,num do
				local p = tbPPEffects[i]
				local pPrev = tbPPEffects[i -1]
				render.DrawBeam(pPrev:GetPos() +offset,p:GetPos() +offset,5,0,0,col)
			end
			if(num > 2 && cv:GetInt() == 3) then
				local last = tbPPEffects[num]
				local first = tbPPEffects[1]
				render.DrawBeam(last:GetPos() +offset,first:GetPos() +offset,5,0,0,col)
			end
			cam.End3D()
			local eTrace = GetTraceEffect()
			for _,e in ipairs(tbPPEffects) do
				if(e == eTrace) then e:SetColor(colSelected)
				else e:SetColor(colDefault) end
			end
		end)
	end
	cvars.AddChangeCallback("npctool_spawner_patrolshow",function(cvar,old,new)
		ShowPatrolPoints(tobool(new))
	end)
	local cvPPointSelected = CreateClientConVar("npctool_spawner_ppoints_select",0,true)
	concommand.Add("npctool_spawner_ppoints_add",function(pl,cmd,args)
		local tr = util.TraceLine(util.GetPlayerTrace(pl))
		CreatePatrolPoint(tr.HitPos)
	end)
	local function RemovePatrolPoint(ID)
		if(!tbPatrolPoints[ID]) then return end
		table.remove(tbPatrolPoints,ID)
		local ent = tbPPEffects[ID]
		if(ent && ent:IsValid()) then
			ent.m_bRemove = true
			table.remove(tbPPEffects,ID)
		end
		for i = ID,#tbPatrolPoints do
			local e = tbPPEffects[i]
			e:SetID(i)
		end
	end
	local function ClearPatrolPoints()
		for _,ent in ipairs(tbPPEffects) do
			if(ent:IsValid()) then ent.m_bRemove = true end
		end
		table.Empty(tbPatrolPoints)
		table.Empty(tbPPEffects)
	end
	net.Receive("npctool_spawner_ppoint_remove",function(len) RemovePatrolPoint(#tbPatrolPoints) end)
	concommand.Add("npctool_spawner_ppoints_remove",function(pl,cmd,args) RemovePatrolPoint(cvPPointSelected:GetInt()) end)
	concommand.Add("npctool_spawner_ppoints_clear",ClearPatrolPoints)
	local tbKeyValues = {}
	local tbRelationships = {}
	CreateClientConVar("npctool_spawner_keyvalues_select","",true)
	CreateClientConVar("npctool_spawner_relationships_select","",true)
	local function CreateSaveDialog(title,fcSave)
		local w, h = 220,110
		local x,y = ScrW() *0.5 -w *0.5,ScrH() *0.5 -h *0.5
		local p = vgui.Create("DFrame")
		p:SetSize(w,h) 
		p:SetPos(x,y)
		p:MakePopup()
		p:ShowCloseButton(true)
		p:SetTitle(title)
		
		local l = vgui.Create("DLabel", p)
		l:SetText("Name:")
		l:SetPos(20,40)
		
		local teName = vgui.Create("DTextEntry", p)
		teName:SetSize(146,16)
		teName:SetPos(55,42)
		
		local bSave = vgui.Create("DButton", p)
		bSave:SetText("Save")
		bSave:SetSize(80,21)
		bSave:SetPos(20,70)
		bSave.DoClick = function(bSave)
			p:Close()
			if(teName:GetValue() != "") then fcSave(teName:GetValue()) end
		end
		
		local bCancel = vgui.Create("DButton", p)
		bCancel:SetText("Cancel")
		bCancel:SetSize(80,21)
		bCancel:SetPos(120,70)
		bCancel.DoClick = function()
			p:Close()
		end
	end
	local preset
	local function MainMenu(pnl)
		pnl:ClearControls()
		pnl:AddControl("Header",{Text = "Spawner",Description = [[Left-Click to create the spawner.
		Right-Click to create or remove a patrol point.
		]]})
		local p = vgui.Create("DPanel",pnl)
		p.Paint = function() end
		pnl:AddItem(p)
		local pCBox = vgui.Create("DComboBox",p)
		pCBox:AddChoice("Default",true)
		local IDSelected
		if(preset == "Default") then IDSelected = 1 end
		for _,f in ipairs(file.Find("npcspawner/*.txt","DATA")) do
			local n = string.sub(f,1,-5)
			local i = pCBox:AddChoice(n)
			if(n == preset) then IDSelected = i end
		end
		if(IDSelected) then pCBox:ChooseOptionID(IDSelected) end
		pCBox.OnSelect = function(pCBox,idx,val,data)
			net.Start("npctool_spawner_clearundo")
			net.SendToServer()
			preset = val
			ClearPatrolPoints()
			table.Empty(tbKeyValues)
			table.Empty(tbRelationships)
			if(val == "Default") then
				if(tbCvars.class) then RunConsoleCommand("npctool_spawner_class",tbCvars.class) end
				if(tbCvars.proficiency) then RunConsoleCommand("npctool_spawner_proficiency",tbCvars.proficiency) end
				timer.Simple(0.05,function()
					MainMenu(controlpanel.Get("npctool_spawner"))
					timer.Simple(0,function()
						for cv,def in pairs(tbCvars) do
							if(cv != "class" && cv != "proficiency") then RunConsoleCommand("npctool_spawner_" .. cv,def) end
						end
					end)
				end)
				return
			end
			local content = file.Read("npcspawner/" .. val .. ".txt","DATA")
			if(!content) then return end
			local data = util.JSONToTable(content)
			if(data.keyvalues) then tbKeyValues = data.keyvalues end
			if(data.relationships) then tbRelationships = data.relationships end
			if(data.patrolpoints) then
				for _,pos in ipairs(data.patrolpoints) do
					CreatePatrolPoint(pos)
				end
			end
			if(data.cvars) then
				if(data.cvars.class) then RunConsoleCommand("npctool_spawner_class",data.cvars.class); data.cvars.class = nil end // Need to set the class before reloading the menu
				if(data.cvars.proficiency) then RunConsoleCommand("npctool_spawner_proficiency",data.cvars.proficiency); data.cvars.proficiency = nil end
				if(data.cvars.delay) then RunConsoleCommand("npctool_spawner_delay",data.cvars.delay); data.cvars.delay = nil end
				if(data.cvars.max) then RunConsoleCommand("npctool_spawner_max",data.cvars.max); data.cvars.max = nil end
				if(data.cvars.total) then RunConsoleCommand("npctool_spawner_total",data.cvars.total); data.cvars.total = nil end
			end
			timer.Simple(0.05,function()
				MainMenu(controlpanel.Get("npctool_spawner"))
				if(data.cvars) then
					timer.Simple(0,function()
						for cv,val in pairs(data.cvars) do
							if(cv != "class" && cv != "proficiency") then RunConsoleCommand("npctool_spawner_" .. cv,val) end
						end
					end)
				end
			end)
		end
		pCBox:SetWide(194)
		p:SetTall(pCBox:GetTall())
		
		local b = vgui.Create("DImageButton",p)
		b:SetImage("gui/silkicons/disk.vmt")
		b:SetSize(16,16)
		b:SetPos(pCBox:GetWide() +4,pCBox:GetTall() *0.5 -8)
		b:SizeToContents()
		b.OnMousePressed = function(b)
			CreateSaveDialog("NPC Spawner Settings",function(name)
				if(string.Right(name,4) != ".txt") then name = name .. ".txt" end
				local data = {}
				data.cvars = {}
				for cv in pairs(tbCvars) do
					data.cvars[cv] = GetConVarString("npctool_spawner_" .. cv)
				end
				data.keyvalues = tbKeyValues
				data.patrolpoints = tbPatrolPoints
				data.relationships = tbRelationships
				file.CreateDir("npcspawner")
				file.Write("npcspawner/" .. name,util.TableToJSON(data))
				MainMenu(controlpanel.Get("npctool_spawner"))
			end)
		end
		local options = {}
		for _,npc in pairs(list.Get("NPC")) do
			options[npc.Name .. " [" .. npc.Class .. "]"] = {npctool_spawner_class = _}
		end
		pnl:AddControl("ListBox",{Label = "NPC",MenuButton = 0,Height = 150,Options = options})
		pnl:AddControl("TextBox",{Label = "Squadname",MaxLength = 20,WaitForEnter = false,Type = "Float",Command = "npctool_spawner_squad"})
		pnl:AddControl("TextBox",{Label = "Spawnflags",MaxLength = 20,WaitForEnter = false,Type = "Integer",Command = "npctool_spawner_spawnflags"})
		//pnl:AddControl("TextBox",{Label = "Soundtrack",MaxLength = 60,WaitForEnter = false,Type = "String",Command = "npctool_spawner_soundtrack"})
		//pnl:AddControl("Label",{Text = "                                  (This track will play as long as                                   this spawner is active. Only one soundtrack can                                   play at a time.)"})
		local options = {}
		local tbWeps = {}
		for class,data in pairs(list.Get("Weapon")) do
			if(data.Spawnable || (data.AdminSpawnable && LocalPlayer():IsAdmin())) then
				options[data.PrintName] = {npctool_spawner_equipment = class}
			end
		end
		options["No Weapon"] = {npctool_spawner_equipment = ""}
		pnl:AddControl("ComboBox",{Label = "Equipment",Options = options})
		
		local values = {
			[WEAPON_PROFICIENCY_POOR] = "Poor",
			[WEAPON_PROFICIENCY_AVERAGE] = "Average",
			[WEAPON_PROFICIENCY_GOOD] = "Good",
			[WEAPON_PROFICIENCY_VERY_GOOD] = "Very Good",
			[WEAPON_PROFICIENCY_PERFECT] = "Perfect",
			[WEAPON_PROFICIENCY_RANDOM] = "Random",
			[WEAPON_PROFICIENCY_DEFAULT] = "Default"
		}
		local pSl = NumSlider(pnl,"Weapon Proficiency:",nil,1,7,0)
		local prof = values[GetConVarNumber("npctool_spawner_proficiency")] || "Poor"
		pSl.Wang:SetText(prof)
		local i
		for _,val in ipairs(values) do if(val == prof) then i = _ +1; break end end
		if(i) then pSl.Slider:SetSlideX((i -1) /6) end
		pSl.TranslateSliderValues = function(...)
			local x,y = select(2,...)
			local num = tonumber(x *6 +1) || 0
			num = math.Round(num)
			local val = math.Clamp(num,1,7)
			pSl.Wang:SetText(values[val -1] || "Poor")
			RunConsoleCommand("npctool_spawner_proficiency",val -1)
			return ((num -1) /6),y
		end
		
		pnl:AddControl("Slider",{Label = "Spawn delay",min = 1,max = 30,Type = "Float",Command = "npctool_spawner_delay"})
		pnl:AddControl("Slider",{Label = "Max alive NPCs",min = 1,max = 25,Type = "Integer",Command = "npctool_spawner_max"})
		pnl:AddControl("Slider",{Label = "Total NPC amount",min = 0,max = 250,Command = "npctool_spawner_total"})
		pnl:AddControl("Label",{Text = "                                  (0 = infinite)"})
		pnl:AddControl("Numpad",{Label = "#Turn On",Label2 = "#Turn Off",Command = "npctool_spawner_turnon",Command2 = "npctool_spawner_turnoff",ButtonSize = 22})
		
		pnl:AddControl("CheckBox",{Label = "Show Effects",Command = "npctool_spawner_showeffects"})
		pnl:AddControl("CheckBox",{Label = "Start On",Command = "npctool_spawner_starton"})
		pnl:AddControl("CheckBox",{Label = "Start burrowed (Antlions and headcrabs)",Command = "npctool_spawner_startburrowed"})
		pnl:AddControl("CheckBox",{Label = "Remove spawned NPCs on removal",Command = "npctool_spawner_deleteonremove"})
		
		if(GetConVarNumber("npctool_spawner_patrolshow") != 0) then ShowPatrolPoints(true) end
		pnl:AddControl("Label",{Label = "",Text = ""})
		pnl:AddControl("Label",{Label = "Patrol",Text = "Patrol"})
		pnl:AddControl("CheckBox",{Label = "Show patrol points",Command = "npctool_spawner_patrolshow"})
		pnl:AddControl("CheckBox",{Label = "Walk",Command = "npctool_spawner_patrolwalk"})
		pnl:AddControl("CheckBox",{Label = "Strict (NPC may not move to attack)",Command = "npctool_spawner_patrolstrict"})
		pnl:AddControl("ComboBox",{Label = "Patrol Type",Options = {
			["Just forth"] = {npctool_spawner_patroltype = "1"},
			["Back and forth"] = {npctool_spawner_patroltype = "2"},
			["Circles"] = {npctool_spawner_patroltype = "3"}
		}})
		pnl:AddControl("Button",{Label = "Clear Patrol Points",Text = "Clear Patrol Points",Command = "npctool_spawner_ppoints_clear"})
		
		pnl:AddControl("Label",{Label = "",Text = ""})
		local options = {}
		for key,val in pairs(tbKeyValues) do
			options[key .. " = " .. val] = {npctool_spawner_keyvalues_select = key}
		end
		pnl:AddControl("ListBox",{Label = "Keyvalues",MenuButton = 0,Height = 150,Options = options})
		pnl:AddControl("Button",{Label = "Add Keyvalue",Text = "Add Keyvalue",Command = "npctool_spawner_keyvalues_add"})
		pnl:AddControl("Button",{Label = "Remove Keyvalue",Text = "Remove Keyvalue",Command = "npctool_spawner_keyvalues_remove"})
		pnl:AddControl("Button",{Label = "Clear Keyvalues",Text = "Clear Keyvalues",Command = "npctool_spawner_keyvalues_clear"})
		
		local options = {}
		for tgt,disp in pairs(tbRelationships) do
			local str
			if(disp == D_HT) then str = "Hates"
			elseif(disp == D_FR) then str = "Fears"
			elseif(disp == D_LI) then str = "Likes"
			else str = "Is neutral to" end
			local name = language.GetPhrase("#" .. tgt)
			if(name[1] == "#") then name = tgt end
			str = str .. " '" .. name .. "'"
			options[str] = {npctool_spawner_relationships_select = tgt}
		end
		pnl:AddControl("ListBox",{Label = "Relationships",MenuButton = 0,Height = 150,Options = options})
		pnl:AddControl("Button",{Label = "Add Relationship",Text = "Add Relationship",Command = "npctool_spawner_relationships_add"})
		pnl:AddControl("Button",{Label = "Remove Relationship",Text = "Remove Relationship",Command = "npctool_spawner_relationships_remove"})
		pnl:AddControl("Button",{Label = "Clear Relationships",Text = "Clear Relationships",Command = "npctool_spawner_relationships_clear"})
	end
	concommand.Add("npctool_spawner_submenu_main",function(pl,cmd,args)
		MainMenu(controlpanel.Get("npctool_spawner"))
	end)
	language.Add("tool.npctool_spawner.name","NPC Spawn Creator")
	language.Add("tool.npctool_spawner.desc","Create an automatic NPC spawner")
	language.Add("tool.npctool_spawner.0","Left-Click to create the spawner, Right-Click to create or remove a patrol point.")
	
	function TOOL.BuildCPanel(pnl)
		MainMenu(pnl)
	end
	
	concommand.Add("npctool_spawner_relationships_remove",function(pl,cmd,args)
		local sel = GetConVarString("npctool_spawner_relationships_select")
		tbRelationships[sel] = nil
		MainMenu(controlpanel.Get("npctool_spawner"))
	end)
	concommand.Add("npctool_spawner_relationships_clear",function(pl,cmd,args)
		tbRelationships = {}
		MainMenu(controlpanel.Get("npctool_spawner"))
	end)
	concommand.Add("npctool_spawner_relationships_add",function(pl,cmd,args)
		local tgt = args[1]
		local disp = args[2]
		if(tgt && disp) then
			tbRelationships[tgt] = tonumber(disp) || D_NU
			MainMenu(controlpanel.Get("npctool_spawner"))
			return
		end
		local w,h = 205,145
		local x,y = gui.MousePos()
		local p = vgui.Create("DFrame")
		p:SetSize(w,h)
		p:SetPos(x -w *0.5,y -h *0.5)
		p:MakePopup()
		p:ShowCloseButton(true)
		p:SetTitle("Add Relationship")
		local col = Color(56,56,56,240)
		p.Paint = function(p)
			draw.RoundedBox(8,0,0,w,h,col)
			surface.SetDrawColor(75,75,75,200)
			surface.DrawLine(0,20,w,20)
		end
		local l = vgui.Create("DLabel",p)
		l:SetText("Target:")
		l:SetPos(12,35)
		l:SizeToContents()
		
		local class
		local teKey = vgui.Create("DComboBox",p)
		teKey:SetSize(100,16)
		teKey:SetPos(80,35)
		teKey.OnSelect = function(teKey,idx,val,data)
			class = data
		end
		local choices = {{name = "Player",class = "player"}}
		for _,npc in pairs(list.Get("NPC")) do
			table.insert(choices,{
				name = npc.Name,
				class = npc.Class
			})
		end
		table.sort(choices,function(a,b) return a.name < b.name end)
		for _,choice in ipairs(choices) do
			teKey:AddChoice(choice.name,choice.class)
		end
		
		local l = vgui.Create("DLabel",p)
		l:SetText("Disposition:")
		l:SetPos(12,60)
		l:SizeToContents()
		
		local disp
		local teVal = vgui.Create("DComboBox",p)
		teVal:SetSize(100,16)
		teVal:SetPos(80,60)
		teVal.OnSelect = function(teKey,idx,val,data)
			disp = data
		end
		teVal:AddChoice("Hate",D_HT)
		teVal:AddChoice("Fear",D_FR)
		teVal:AddChoice("Like",D_LI)
		teVal:AddChoice("Neutral",D_NU)
		
		local b = vgui.Create("DButton",p)
		b:SetText("OK")
		b:SetSize(40,21)
		b:SetPos(30,100)
		b.DoClick = function(b)
			p:Close()
			if(class && disp) then
				RunConsoleCommand("npctool_spawner_relationships_add",class,disp)
			end
		end
		
		local b = vgui.Create("DButton",p)
		b:SetText("Cancel")
		b:SetSize(50,21)
		b:SetPos(100,100)
		b.DoClick = function(b)
			p:Close()
		end
	end)
	
	concommand.Add("npctool_spawner_keyvalues_remove",function(pl,cmd,args)
		local sel = GetConVarString("npctool_spawner_keyvalues_select")
		tbKeyValues[sel] = nil
		MainMenu(controlpanel.Get("npctool_spawner"))
	end)
	concommand.Add("npctool_spawner_keyvalues_clear",function(pl,cmd,args)
		tbKeyValues = {}
		MainMenu(controlpanel.Get("npctool_spawner"))
	end)
	concommand.Add("npctool_spawner_keyvalues_add",function(pl,cmd,args)
		local key = args[1]
		local val = args[2]
		if(key && val) then
			tbKeyValues[key] = val
			MainMenu(controlpanel.Get("npctool_spawner"))
			return
		end
		local w,h = 175,145
		local x,y = gui.MousePos()
		local p = vgui.Create("DFrame")
		p:SetSize(w,h)
		p:SetPos(x -w *0.5,y -h *0.5)
		p:MakePopup()
		p:ShowCloseButton(true)
		p:SetTitle("Add Keyvalue")
		local col = Color(56,56,56,240)
		p.Paint = function(p)
			draw.RoundedBox(8,0,0,w,h,col)
			surface.SetDrawColor(75,75,75,200)
			surface.DrawLine(0,20,w,20)
		end
		local l = vgui.Create("DLabel",p)
		l:SetText("Key:")
		l:SetPos(12,35)
		l:SizeToContents()
		
		local teKey = vgui.Create("DTextEntry",p)
		teKey:SetSize(100,16)
		teKey:SetPos(50,35)
		
		local l = vgui.Create("DLabel",p)
		l:SetText("Value:")
		l:SetPos(12,60)
		l:SizeToContents()
		
		local teVal = vgui.Create("DTextEntry",p)
		teVal:SetSize(100,16)
		teVal:SetPos(50,60)
		
		local b = vgui.Create("DButton",p)
		b:SetText("OK")
		b:SetSize(40,21)
		b:SetPos(30,100)
		b.DoClick = function(b)
			p:Close()
			local key = teKey:GetValue()
			local val = teVal:GetValue()
			if(key != "" && val != "") then
				RunConsoleCommand("npctool_spawner_keyvalues_add",key,val)
			end
		end
		
		local b = vgui.Create("DButton",p)
		b:SetText("Cancel")
		b:SetSize(50,21)
		b:SetPos(100,100)
		b.DoClick = function(b)
			p:Close()
		end
	end)
	net.Receive("cl_npctool_spawner_ppoint",function(len)
		local e,eID = GetTraceEffect()
		if(e) then RemovePatrolPoint(eID); return end
		local pos = net.ReadVector()
		CreatePatrolPoint(pos)
	end)
	net.Receive("cl_npctool_spawner_spawn",function(len)
		local yaw = net.ReadFloat()
		local pos = net.ReadVector()
		net.Start("sv_npctool_spawner_spawn")
			net.WriteVector(pos)
			net.WriteFloat(yaw)
			net.WriteString(GetConVarString("npctool_spawner_class"))
			net.WriteString(GetConVarString("npctool_spawner_squad"))
			net.WriteUInt(GetConVarNumber("npctool_spawner_spawnflags"),25)
			net.WriteString(GetConVarString("npctool_spawner_equipment"))
			//net.WriteString(GetConVarString("npctool_spawner_soundtrack"))
			net.WriteUInt(GetConVarNumber("npctool_spawner_proficiency"),4)
			net.WriteFloat(GetConVarNumber("npctool_spawner_delay"))
			net.WriteUInt(GetConVarNumber("npctool_spawner_max"),6)
			net.WriteUInt(GetConVarNumber("npctool_spawner_total"),14)
			net.WriteUInt(GetConVarNumber("npctool_spawner_turnon"),13)
			net.WriteUInt(GetConVarNumber("npctool_spawner_turnoff"),13)
			net.WriteUInt(GetConVarNumber("npctool_spawner_showeffects"),1)
			net.WriteUInt(GetConVarNumber("npctool_spawner_starton"),1)
			net.WriteUInt(GetConVarNumber("npctool_spawner_startburrowed"),1)
			net.WriteUInt(GetConVarNumber("npctool_spawner_deleteonremove"),1)
			net.WriteUInt(GetConVarNumber("npctool_spawner_patrolwalk"),1)
			net.WriteUInt(GetConVarNumber("npctool_spawner_patroltype"),2)
			net.WriteUInt(GetConVarNumber("npctool_spawner_patrolstrict"),1)
			net.WriteUInt(table.Count(tbKeyValues),8)
			for key,val in pairs(tbKeyValues) do
				net.WriteString(key)
				net.WriteString(val)
			end
			local numPPoints = #tbPatrolPoints
			net.WriteUInt(numPPoints,12)
			for i = 1,numPPoints do
				net.WriteVector(tbPatrolPoints[i])
			end
			net.WriteUInt(table.Count(tbRelationships),8)
			for class,disp in pairs(tbRelationships) do
				net.WriteString(class)
				net.WriteUInt(disp,3)
			end
		net.SendToServer()
	end)
	net.Receive("npctool_spawner_deploy",function(len)
		if(GetConVarNumber("npctool_spawner_patrolshow") != 0) then ShowPatrolPoints(true) end
	end)
	net.Receive("npctool_spawner_holster",function(len)
		local wep = LocalPlayer():GetActiveWeapon()
		if(wep:IsValid() && wep:GetClass() == "gmod_tool" && wep:GetMode() == "npctool_spawner") then // False alarm
			if(GetConVarNumber("npctool_spawner_patrolshow") != 0) then ShowPatrolPoints(true) end
			return
		end
		ShowPatrolPoints(false)
	end)
else
	util.AddNetworkString("cl_npctool_spawner_spawn")
	util.AddNetworkString("sv_npctool_spawner_spawn")
	util.AddNetworkString("cl_npctool_spawner_ppoint")
	util.AddNetworkString("sv_npctool_spawner_ppoint")
	util.AddNetworkString("npctool_spawner_ppoint_remove")
	util.AddNetworkString("npctool_spawner_clearundo")
	util.AddNetworkString("npctool_spawner_holster")
	util.AddNetworkString("npctool_spawner_deploy")
	function TOOL:Deploy()
		net.Start("npctool_spawner_deploy")
		net.Send(self:GetOwner())
	end
	net.Receive("npctool_spawner_clearundo",function(len,pl)
		for _,undo in pairs(undo.GetTable()) do
			for i = #undo,1,-1 do
				local data = undo[i]
				if(data.Name == "PatrolPoint" && data.Owner == pl) then
					table.remove(undo,i)
				end
			end
		end
	end)
	net.Receive("sv_npctool_spawner_ppoint",function(len,pl)
		undo.Create("PatrolPoint")
			undo.AddFunction(function()
				net.Start("npctool_spawner_ppoint_remove")
				net.Send(pl)
			end)
			undo.SetPlayer(pl)
			undo.SetCustomUndoText("Undone Patrol Point")
		undo.Finish("Patrol Point")
	end)
	net.Receive("sv_npctool_spawner_spawn",function(len,pl)
		local pos = net.ReadVector()
		local yaw = net.ReadFloat()
		local type = net.ReadString()
		local npcData = list.Get("NPC")[type]
		if(!npcData) then ErrorNoHalt("Warning: Trying to use invalid NPC Type '" .. type .. "' for NPC Spawner! Ignoring..."); return end
		local class = npcData.Class
		if(!class) then ErrorNoHalt("Warning: NPC Type '" .. type .. "' does not have an assigned class for NPC Spawner! Ignoring..."); return end
		local squad = net.ReadString()
		local spawnflags = net.ReadUInt(25)
		local equipment = net.ReadString()
		local weps = list.Get("Weapon")
		local data = weps[equipment]
		if(!data || (!data.Spawnable && (!data.AdminSpawnable || !pl:IsAdmin()))) then equipment = "" end
		//local soundtrack = net.ReadString()
		local proficiency = net.ReadUInt(4)
		local delay = net.ReadFloat()
		local max = net.ReadUInt(6)
		local total = net.ReadUInt(14)
		local turnon = net.ReadUInt(13)
		local turnoff = net.ReadUInt(13)
		local effects = net.ReadUInt(1)
		local starton = net.ReadUInt(1)
		local startburrowed = net.ReadUInt(1)
		local deleteonremove = net.ReadUInt(1)
		local patrolwalk = net.ReadUInt(1)
		local patroltype = net.ReadUInt(2)
		local patrolstrict = net.ReadUInt(1)
		local numKeyValues = net.ReadUInt(8)
		local tbKeyValues = {}
		for i = 1,numKeyValues do
			local key = net.ReadString()
			local val = net.ReadString()
			tbKeyValues[key] = val
		end
		local numPPoints = net.ReadUInt(12)
		local tbPatrolPoints = {}
		for i = 1,numPPoints do
			local pos = net.ReadVector()
			table.insert(tbPatrolPoints,pos)
		end
		local numRelationships = net.ReadUInt(8)
		local tbRelationships = {}
		for i = 1,numRelationships do
			local class = net.ReadString()
			local disp = net.ReadUInt(3)
			tbRelationships[class] = disp
		end
		/*
		print("Creating NPC Spawner:")
		MsgN("Class: ",class)
		MsgN("Squad: ",squad)
		MsgN("Spawnflags: ",spawnflags)
		MsgN("Equipment: ",equipment)
		MsgN("Soundtrack: ",soundtrack)
		MsgN("Proficiency: ",proficiency)
		MsgN("Delay: ",delay)
		MsgN("Max: ",max)
		MsgN("Total: ",total)
		MsgN("Turn On: ",turnon)
		MsgN("Turn Off: ",turnoff)
		MsgN("Start On: ",starton)
		MsgN("Start Burrowed: ",startburrowed)
		MsgN("Delete On Remove: ",deleteonremove)
		MsgN("Patrol Walk: ",patrolwalk)
		MsgN("Patrol Type: ",patroltype)
		MsgN("Patrol Strict: ",patrolstrict)
		MsgN("Key Values:")
		PrintTable(tbKeyValues)
		MsgN("Patrol Points:")
		PrintTable(tbPatrolPoints)
		MsgN("Relationships:")
		PrintTable(tbRelationships)
		*/
		local ent = ents.Create("obj_npcspawner")
		ent:SetPos(pos)
		ent:SetAngles(Angle(0,yaw,0))
		ent:SetNPCClass(class)
		ent:SetNPCData(npcData)
		ent:SetNPCBurrowed(tobool(startburrowed))
		ent:SetNPCKeyValues(tbKeyValues)
		if(equipment != "") then ent:SetNPCEquipment(equipment) end
		if(spawnflags > 0) then ent:SetNPCSpawnflags(spawnflags) end
		ent:SetNPCProficiency(proficiency)
		ent:SetEntityOwner(pl)
		ent:SetKeyTurnOn(turnon)
		ent:SetKeyTurnOff(turnoff)
		ent:SetSpawnDelay(delay)
		ent:SetMaxNPCs(max)
		ent:SetTotalNPCs(total)
		//ent:SetSoundtrack(soundtrack)
		ent:SetStartOn(tobool(starton))
		ent:SetPatrolWalk(tobool(patrolwalk))
		ent:SetPatrolType(patroltype)
		ent:SetStrictMovement(tobool(patrolstrict))
		ent:SetDeleteOnRemove(tobool(deleteonremove))
		if(squad != "") then ent:SetSquad(squad) end
		for _,p in ipairs(tbPatrolPoints) do
			ent:AddPatrolPoint(p)
		end
		for class,disp in pairs(tbRelationships) do
			ent:SetDisposition(class,disp)
		end
		ent:Spawn()
		ent:Activate()
		ent:ShowEffects(effects == 1)
		cleanup.Add(pl,"npcs",ent)
		undo.Create("SENT")
			undo.AddEntity(ent)
			undo.SetPlayer(pl)
			undo.SetCustomUndoText("Undone NPC Spawner")
		undo.Finish("Scripted Entity (NPC Spawner)")
	end)
end

function TOOL:LeftClick(tr)
	if(CLIENT) then return true end
	net.Start("cl_npctool_spawner_spawn")
		net.WriteFloat(self:GetOwner():GetAimVector():Angle().y)
		net.WriteVector(tr.HitPos)
	net.Send(self:GetOwner())
	return true
end

function TOOL:RightClick(tr)
	if(CLIENT) then return true end
	net.Start("cl_npctool_spawner_ppoint")
		net.WriteVector(tr.HitPos)
	net.Send(self:GetOwner())
	return true
end

function TOOL:Holster()
	if(CLIENT) then return end
	net.Start("npctool_spawner_holster")
	net.Send(self:GetOwner())
end