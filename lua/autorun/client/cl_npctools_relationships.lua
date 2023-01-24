-- "lua\\autorun\\client\\cl_npctools_relationships.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local D_HT = 1
local D_FR = 2
local D_LI = 3
local D_NU = 4

CreateClientConVar("npctool_relman_enabled",1,true,true)
local cvOnMapSpawn = CreateClientConVar("npctool_relman_mapspawn","",true)
local cvSel = CreateClientConVar("npctool_relman_select","")
CreateClientConVar("npctool_relman_revert",1)

local tRelationships = {}
local UpdateMenu

local function AddRelationship(src,tgt,disp)
	src = string.lower(src)
	tgt = string.lower(tgt)
	tRelationships[src] = tRelationships[src] || {}
	tRelationships[src][tgt] = disp
	net.Start("npctool_relman_add")
		net.WriteString(src)
		net.WriteString(tgt)
		net.WriteUInt(disp,3)
	net.SendToServer()
end
local function RemoveRelationship(src,tgt)
	if(tRelationships[src]) then tRelationships[src][tgt] = nil end
	net.Start("npctool_relman_rem")
		net.WriteString(src)
		net.WriteString(tgt)
	net.SendToServer()
end

local function GetSelected()
	local sel = cvSel:GetString()
	local vals = string.Explode(":",sel)
	if(!vals[1] || !vals[2]) then return end
	return vals[1],vals[2]
end

cvars.AddChangeCallback("npctool_relman_enabled",function(cv,prev,new)
	net.Start("npctool_relman_en")
		net.WriteUInt(tonumber(new) != 0 && 1 || 0,1)
	net.SendToServer()
end)

concommand.Add("npctool_relman_add",function(pl,cmd,args)
	local src,tgt,disp = unpack(args)
	disp = disp && tonumber(disp)
	if(src && tgt && disp) then
		AddRelationship(src,tgt,disp)
		if(GetConVarNumber("npctool_relman_revert") != 0 && tgt != "player") then
			AddRelationship(tgt,src,disp)
		end
		UpdateMenu()
		return
	end
	local w,h = 205,180
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
	l:SetText("Source:")
	l:SetPos(12,35)
	l:SizeToContents()
	
	local source
	local target
	local teSrc = vgui.Create("DComboBox",p)
	teSrc:SetSize(100,16)
	teSrc:SetPos(80,35)
	teSrc.OnSelect = function(teSrc,idx,val,data)
		source = data
	end
	local choices = {}
	for _,npc in pairs(list.Get("NPC")) do
		table.insert(choices,{
			name = npc.Name,
			class = npc.Class
		})
	end
	table.sort(choices,function(a,b) return a.name < b.name end)
	for _,choice in ipairs(choices) do
		teSrc:AddChoice(choice.name,choice.class)
	end
	
	local l = vgui.Create("DLabel",p)
	l:SetText("Disposition:")
	l:SetPos(12,60)
	l:SizeToContents()
	
	local disp
	local teVal = vgui.Create("DComboBox",p)
	teVal:SetSize(100,16)
	teVal:SetPos(80,60)
	teVal.OnSelect = function(teSrc,idx,val,data)
		disp = data
	end
	teVal:AddChoice("Hate",D_HT)
	teVal:AddChoice("Fear",D_FR)
	teVal:AddChoice("Like",D_LI)
	teVal:AddChoice("Neutral",D_NU)
	
	local l = vgui.Create("DLabel",p)
	l:SetText("Target:")
	l:SetPos(12,85)
	l:SizeToContents()
	
	local teTgt = vgui.Create("DComboBox",p)
	teTgt:SetSize(100,16)
	teTgt:SetPos(80,85)
	teTgt.OnSelect = function(teTgt,idx,val,data)
		target = data
	end
	local choices = {}
	for _,npc in pairs(list.Get("NPC")) do
		table.insert(choices,{
			name = npc.Name,
			class = npc.Class
		})
	end
	table.insert(choices,{name = "Player",class = "player"})
	table.sort(choices,function(a,b) return a.name < b.name end)
	for _,choice in ipairs(choices) do
		teTgt:AddChoice(choice.name,choice.class)
	end
	
	local l = vgui.Create("DLabel",p)
	l:SetText("Revert:")
	l:SetPos(12,110)
	l:SizeToContents()
	
	local pCb = vgui.Create("DCheckBox",p)
	pCb:SetConVar("npctool_relman_revert")
	pCb:SetText("Revert")
	pCb:SetPos(80,110)
	
	local b = vgui.Create("DButton",p)
	b:SetText("OK")
	b:SetSize(40,21)
	b:SetPos(30,135)
	b.DoClick = function(b)
		p:Close()
		if(source && target && disp) then
			RunConsoleCommand("npctool_relman_add",source,target,disp)
		end
	end
	
	local b = vgui.Create("DButton",p)
	b:SetText("Cancel")
	b:SetSize(50,21)
	b:SetPos(100,135)
	b.DoClick = function(b)
		p:Close()
	end
end)

concommand.Add("npctool_relman_remove",function(pl,cmd,args)
	local src,tgt = GetSelected()
	if(!src) then return end
	RemoveRelationship(src,tgt)
	UpdateMenu()
end)

concommand.Add("npctool_relman_clear",function(pl,cmd,args)
	tRelationships = {}
	net.Start("npctool_relman_clr")
	net.SendToServer()
	UpdateMenu()
end)

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
local function LoadPreset(val)
	preset = val
	local content = file.Read("npcrelationships/" .. val .. ".txt","DATA")
	if(!content) then return false end
	tRelationships = util.JSONToTable(content)
	net.Start("npctool_relman_up")
		net.WriteUInt(table.Count(tRelationships),12)
		for src,rels in pairs(tRelationships) do
			net.WriteString(src)
			net.WriteUInt(table.Count(rels),12)
			for tgt,disp in pairs(rels) do
				net.WriteString(tgt)
				net.WriteUInt(disp,3)
			end
		end
	net.SendToServer()
	UpdateMenu()
	return true
end
UpdateMenu = function()
	local pnl = controlpanel.Get("NPC Relationships")
	pnl:ClearControls()
	
	local tbFiles = file.Find("npcrelationships/*.txt","DATA")
	local p = vgui.Create("DPanel",pnl)
	p.Paint = function() end
	pnl:AddItem(p)
	
	local l = vgui.Create("DLabel",p)
	l:SetText("Preset to load on map spawn:")
	l:SetPos(0,0)
	l:SizeToContents()
	l:SetColor(Color(0,0,0))
	
	local pCBoxMap = vgui.Create("DComboBox",p)
	local map = cvOnMapSpawn:GetString()
	pCBoxMap:AddChoice("",true)
	local imap
	for _,f in ipairs(tbFiles) do
		local n = string.sub(f,1,-5)
		local i = pCBoxMap:AddChoice(n)
		if(n == map) then imap = i end
	end
	if(imap) then pCBoxMap:ChooseOptionID(imap) end
	pCBoxMap.OnSelect = function(pCBoxMap,idx,val,data)
		RunConsoleCommand("npctool_relman_mapspawn",val)
	end
	pCBoxMap:SetPos(l:GetWide() +5)
	pCBoxMap:SetWide(150)
	p:SetTall(pCBoxMap:GetTall())
	
	local p = vgui.Create("DPanel",pnl)
	p.Paint = function() end
	pnl:AddItem(p)
	local pCBox = vgui.Create("DComboBox",p)
	local IDSelected
	for _,f in ipairs(tbFiles) do
		local n = string.sub(f,1,-5)
		local i = pCBox:AddChoice(n)
		if(n == preset) then IDSelected = i end
	end
	if(IDSelected) then pCBox:ChooseOptionID(IDSelected) end
	pCBox.OnSelect = function(pCBox,idx,val,data)
		LoadPreset(val)
	end
	pCBox:SetWide(280)
	p:SetTall(pCBox:GetTall())
	
	local b = vgui.Create("DImageButton",p)
	b:SetImage("gui/silkicons/disk.vmt")
	b:SetSize(16,16)
	b:SetPos(pCBox:GetWide() +4,pCBox:GetTall() *0.5 -8)
	b:SizeToContents()
	b.OnMousePressed = function(b)
		CreateSaveDialog("NPC Relationships",function(name)
			if(string.Right(name,4) != ".txt") then name = name .. ".txt" end
			local data = tRelationships
			file.CreateDir("npcrelationships")
			file.Write("npcrelationships/" .. name,util.TableToJSON(data))
			UpdateMenu()
		end)
	end
	
	local options = {}
	local tRels = {}
	for src,rels in pairs(tRelationships) do
		for tgt,disp in pairs(rels) do
			local str = language.GetPhrase("#" .. src)
			if(str[1] == "#") then str = src end
			str = "'" .. str .. "'"
			if(disp == D_HT) then str = str .. " hates"
			elseif(disp == D_FR) then str = str .. " fears"
			elseif(disp == D_LI) then str = str .. " likes"
			else str = str .. " is neutral to" end
			local name = language.GetPhrase("#" .. tgt)
			if(name[1] == "#") then name = tgt end
			str = str .. " '" .. name .. "'"
			options[str] = {npctool_relman_select = (src .. ":" .. tgt)}
		end
	end
	pnl:AddControl("ListBox",{Label = "Relationships",MenuButton = 0,Height = 250,Options = options})
	pnl:AddControl("CheckBox",{Label = "Active",Command = "npctool_relman_enabled"})
	pnl:AddControl("Button",{Label = "Add Relationship",Text = "Add Relationship",Command = "npctool_relman_add"})
	pnl:AddControl("Button",{Label = "Remove Relationship",Text = "Remove Relationship",Command = "npctool_relman_remove"})
	pnl:AddControl("Button",{Label = "Clear Relationships",Text = "Clear Relationships",Command = "npctool_relman_clear"})
end
hook.Add("PopulateToolMenu","NPCTools_rels_initmenu",function()
	spawnmenu.AddToolMenuOption("Utilities","NPC Tools","NPC Relationships","NPC Relationships","","",UpdateMenu)
end)
hook.Add("InitPostEntity","NPCTools_rels_initmap",function()
	local mapSet = cvOnMapSpawn:GetString()
	if(LoadPreset(mapSet)) then RunConsoleCommand("npctool_relman_enabled",1) end
end)