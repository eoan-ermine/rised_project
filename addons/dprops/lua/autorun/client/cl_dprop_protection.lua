-- "addons\\dprops\\lua\\autorun\\client\\cl_dprop_protection.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

surface.CreateFont( "dprop_font_24", { font = "Roboto", size = 24, weight = 600, bold = true})
surface.CreateFont( "dprop_font_22", { font = "Roboto", size = 22, weight = 600, bold = true})
surface.CreateFont( "dprop_font_20", { font = "Roboto", size = 20, weight = 600, bold = true})
surface.CreateFont( "dprop_font_16", { font = "Roboto", size = 16, weight = 600, bold = true})

net.Receive("dprops_notify", function()

	local msg = net.ReadString()
	chat.AddText(Color(26,116,219), "[DPROPS] ", color_white, msg)

end)

local col,col2,col3 = Color(255,0,0), Color(255,255,0), Color(0,0,255)
local mat = Material("editor/wireframe")
hook.Add("HUDPaint", "BoundingBoxes", function()

	if DPROP.Debugging then 
		cam.Start3D()
			for k,ent in pairs(ents.FindByClass("prop_physics")) do 
				if ent == LocalPlayer() then continue end
				local amin, amax = ent:GetCollisionBounds()
				local bmin, bmax = ent:GetRotatedAABB(amin, amax)

				render.SetMaterial(mat)
				render.DrawBox(ent:GetPos(), Angle(0,0,0), amin, amax, col2)
				render.DrawBox(ent:GetPos(), Angle(0,0,0), bmin, bmax, col3)
				render.DrawBox(ent:GetPos(), ent:GetAngles(), amin, amax, col )
			end 
		cam.End3D()
	end 
end)

local mainOptions = {
	[1] = {
		name = "View Player Info",
		callback = function()
			DPROP.Menu:Remove() 
			DPROP.OpenPlayerInfo()
		end},
	[2] = {
		name = "Freeze All Props",
		callback = function() 
			net.Start("dprops_freezeProps")
			net.SendToServer()
	 	end},
	[3] = {
		name = "Remove All Props",
		callback = function()
	  		net.Start("dprops_removeProps")
			net.WriteEntity(nil)
			net.WriteTable(ents.FindByClass("prop_physics"))
			net.SendToServer() 
		end},
	[4] = {
		name = "Ghost All Props",
		callback = function()
	  		net.Start("dprops_ghostProps")
			net.SendToServer() 
		end},
	[5] = {
		name = "UnGhost All Props",
		callback = function()
	  		net.Start("dprops_unghostProps")
			net.SendToServer() 
		end},
}

function DPROP.OpenMenu()
	local scrw, scrh = ScrW(), ScrH()
	DPROP.Menu = vgui.Create("DFrame")
	local menu = DPROP.Menu
	menu:SetSize(scrw * .3, scrh * .6)
	menu:Center()
	menu:SetTitle("")
	menu:MakePopup()
	menu:ShowCloseButton(false)
	menu.Paint = function(me,w,h)
		surface.SetDrawColor(0,0,0,200)
		surface.DrawRect(0,0,w,h)
		surface.DrawRect(0,0,w,h * .05)
		draw.SimpleText("DPROPS", "dprop_font_22", w / 2, h * .025, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	local closeButton = vgui.Create("DButton", menu)
	closeButton:SetSize(menu:GetTall() * .05, menu:GetTall() * .05)
	closeButton:SetPos(menu:GetWide() - closeButton:GetWide(), 0)
	closeButton:SetText("")
	closeButton.DoClick = function()
		DPROP.Menu:Remove()
	end
	closeButton.Paint = function(me,w,h)
		surface.SetDrawColor(255,0,0)
		surface.DrawRect(0,0,w,h)
		draw.SimpleText("X", "dprop_font_20", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	menu.scroll = vgui.Create("DScrollPanel", menu)
	menu.scroll:SetPos(0, menu:GetTall() * .055)
	menu.scroll:SetSize(menu:GetWide(), menu:GetTall() * .945)

	local ypos = 0
	for k,v in ipairs(mainOptions) do
		local mainOption = vgui.Create("DButton", menu.scroll)
		mainOption:SetPos(0, ypos)
		mainOption:SetText("")
		mainOption:SetSize(menu.scroll:GetWide(), menu.scroll:GetTall() * .05)
		mainOption.Paint = function(me,w,h)
			local bgColor = Color(0,0,0,200)
			local textColor = color_white
			if me:IsHovered() then
				bgColor = color_white
				textColor = color_black
			end 
			surface.SetDrawColor(bgColor)
			surface.DrawRect(0,0,w,h)
			draw.SimpleText(v.name, "dprop_font_20", w / 2, h / 2, textColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		mainOption.DoClick = function()
			v.callback()
		end 
		ypos = ypos + mainOption:GetTall() * 1.1 
	end 

end 

local ShowPlayerProps = {}
local ShownPlayer 
local function hoverColors(panel)
	if panel:IsHovered() then
		panel.bgColor = color_white
		panel.textColor = color_black
	else
		panel.bgColor = Color(0,0,0,200)
		panel.textColor = color_white
	end
end 
function DPROP.OpenPlayerInfo()
	local scrw, scrh = ScrW(), ScrH()
	DPROP.PlayerInfoMenu = vgui.Create("DFrame")
	local menu = DPROP.PlayerInfoMenu
	menu:SetSize(scrw * .3, scrh * .6)
	menu:Center()
	menu:SetTitle("")
	menu:MakePopup()
	menu:ShowCloseButton(false)
	menu.Paint = function(me,w,h)
		surface.SetDrawColor(0,0,0,200)
		surface.DrawRect(0,0,w,h)
		surface.DrawRect(0,0,w,h * .05)
		draw.SimpleText("Player Info", "dprop_font_22", w / 2, h * .025, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	local closeButton = vgui.Create("DButton", menu)
	closeButton:SetSize(menu:GetTall() * .05, menu:GetTall() * .05)
	closeButton:SetPos(menu:GetWide() - closeButton:GetWide(), 0)
	closeButton:SetText("")
	closeButton.DoClick = function()
		DPROP.PlayerInfoMenu:Remove()
		DPROP.OpenMenu()
	end
	closeButton.Paint = function(me,w,h)
		surface.SetDrawColor(255,0,0)
		surface.DrawRect(0,0,w,h)
		draw.SimpleText("X", "dprop_font_20", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	menu.scroll = vgui.Create("DScrollPanel", menu)
	menu.scroll:SetPos(0, menu:GetTall() * .055)
	menu.scroll:SetSize(menu:GetWide(), menu:GetTall() * .945)
	local sbar = menu.scroll:GetVBar()
	function sbar:Paint( w, h ) end
	function sbar.btnUp:Paint( w, h )end
	function sbar.btnDown:Paint( w, h )end
	function sbar.btnGrip:Paint( w, h ) end
	menu.scroll:SetSize(menu:GetWide() + sbar:GetWide(), menu:GetTall() * .945)
	local ypos = 0
	for k,v in pairs(player.GetAll()) do
		local playerPanel = vgui.Create("DPanel", menu.scroll)
		playerPanel:SetPos(0, ypos)
		playerPanel:SetText("")
		playerPanel:SetSize(menu.scroll:GetWide(), menu.scroll:GetTall() * .1)
		local avatarImage = vgui.Create("AvatarImage", playerPanel)
		avatarImage:SetSize(playerPanel:GetTall() * .8, playerPanel:GetTall() * .8)
		avatarImage:SetPos(playerPanel:GetTall() * .1, playerPanel:GetTall() * .1)
		avatarImage:SetPlayer(v, avatarImage:GetTall())
		playerPanel.Paint = function(me,w,h)

			surface.SetDrawColor(0,0,0,200)
			surface.DrawRect(0,0,w,h)
			draw.SimpleText(v:Name() , "dprop_font_20", avatarImage:GetWide() * 1.15, h * .25, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.SimpleText("Props: " .. v:GetCount("props") , "dprop_font_20", avatarImage:GetWide() * 1.15, h * .5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
		local showProps = vgui.Create("DButton", playerPanel)
		showProps:SetSize(playerPanel:GetWide() * .2, playerPanel:GetTall() * .6)
		showProps:SetPos(playerPanel:GetWide() * .75, playerPanel:GetTall() * .2)
		showProps:SetText("")
		showProps.Paint = function(me,w,h)
			hoverColors(me)
			surface.SetDrawColor(me.bgColor)
			surface.DrawRect(0,0,w,h)
			local text = "Show Props"
			if ShownPlayer == v then 
				text = "Highlighted"
			end 
			draw.SimpleText(text, "dprop_font_16", w / 2, h / 2, me.textColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		showProps.DoClick = function()
			if ShownPlayer == v then
				ShownPlayer = nil
				ShowPlayerProps = {}
				return
			end 
			ShowPlayerProps = {}
			ShownPlayer = v 
			for _,prop in pairs(ents.FindByClass("prop_physics")) do
				if DPROP.GetOwner(prop) == v then
					table.insert(ShowPlayerProps, prop)
				end  
			end 
		end

		local removeProps = vgui.Create("DButton", playerPanel)
		removeProps:SetSize(playerPanel:GetWide() * .2, playerPanel:GetTall() * .6)
		removeProps:SetPos(playerPanel:GetWide() * .54, playerPanel:GetTall() * .2)
		removeProps:SetText("")
		removeProps.Paint = function(me,w,h)
			hoverColors(me)
			surface.SetDrawColor(me.bgColor)
			surface.DrawRect(0,0,w,h)
			draw.SimpleText("Remove Props", "dprop_font_16", w / 2, h / 2, me.textColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		removeProps.DoClick = function()
			local props = {}
			for _,prop in pairs(ents.FindByClass("prop_physics")) do
				if DPROP.GetOwner(prop) == v then
					table.insert(props, prop)
				end  
			end 
			net.Start("dprops_removeProps")
			net.WriteEntity(v)
			net.WriteTable(props)
			net.SendToServer()
		end

		local banProps = vgui.Create("DButton", playerPanel)
		banProps:SetSize(playerPanel:GetWide() * .2, playerPanel:GetTall() * .6)
		banProps:SetPos(playerPanel:GetWide() * .33, playerPanel:GetTall() * .2)
		banProps:SetText("")
		banProps.Paint = function(me,w,h)
			hoverColors(me)
			surface.SetDrawColor(me.bgColor)
			surface.DrawRect(0,0,w,h)
			if v:GetNWBool("dprops_propBan") then 
				draw.SimpleText("Enable Props", "dprop_font_16", w / 2, h / 2, me.textColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			else 
				draw.SimpleText("Disable Props", "dprop_font_16", w / 2, h / 2, me.textColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end
		banProps.DoClick = function()
			net.Start("dprops_disableProps")
			net.WriteEntity(v)
			net.SendToServer()
		end

		ypos = ypos + playerPanel:GetTall() * 1.1 
	end
end 

net.Receive("dprops_openMenu", function()

	DPROP.OpenMenu()

end)

timer.Create( "DPROP:ClearDecals", DPROP.ClearDecalsTime, 0, function()
	LocalPlayer():ConCommand("r_cleardecals")
end)

hook.Add( "PreDrawHalos", "ShowPlayerProps", function()
	halo.Add( ShowPlayerProps, Color( 255, 0, 0 ), 5, 5, 2, true, true )
end )
