-- "addons\\rised_craft_system\\lua\\autorun\\cl_rised_craft.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if SERVER then return end

local supported_clothes_model = {
	"models/player/hl2rp/male_01.mdl",
	"models/player/hl2rp/male_02.mdl",
	"models/player/hl2rp/male_03.mdl",
	"models/player/hl2rp/male_04.mdl",
	"models/player/hl2rp/male_05.mdl",
	"models/player/hl2rp/male_06.mdl",
	"models/player/hl2rp/male_07.mdl",
	"models/player/hl2rp/male_08.mdl",
	"models/player/hl2rp/male_09.mdl",

	"models/player/hl2rp/female_01.mdl",
	"models/player/hl2rp/female_02.mdl",
	"models/player/hl2rp/female_03.mdl",
	"models/player/hl2rp/female_04.mdl",
	"models/player/hl2rp/female_06.mdl",
	"models/player/hl2rp/female_07.mdl",
}

net.Receive("RisedCraft.Open", function()

	local netlenth = net.ReadInt(32)
	local fileData = net.ReadData(netlenth)
	local text = util.Decompress(fileData)
	local inv = util.JSONToTable(text)
	local mine = net.ReadInt(10)

	if mine == 1 then

		---=== SETUP ===---
		local ply = LocalPlayer()

		ply.Inv = {}
		ply.Inv.Wear = {}
		ply.Inv.Equipped = {}
		ply.Inv.Weight = 0

		for i=1,3 do
	      ply.Inv.Wear[i] = {}
		end
		for k,v in pairs(ply.Inv.Wear)do
		    for i=1,11 do
		        ply.Inv.Wear[k][i] = false
		    end
		end

		local netlenth2 = net.ReadInt(32)
		local fileData2 = net.ReadData(netlenth2)
		local text2 = util.Decompress(fileData2)
		local storage = util.JSONToTable(text2)

		local plymeta = FindMetaTable("Player")
		function plymeta:GetInvItem(x,y)
		    return self.Inv.Wear[x][y]
		end

		_Storage = {}

	    _Storage[1] = {}
	    _Storage[2] = {}
	    _Storage[3] = {}
	    for i=1,5 do
	        _Storage[1][i] = false
	    end
	    _Storage[2][1] = false
	    _Storage[3][1] = false

		---=== INVENTORY PANEL ===---
		local PANEL = {}

		AccessorFunc(PANEL, "m_ItemPanel", "ItemPanel")
		AccessorFunc(PANEL, "m_Color", "Color")

		function PANEL:Init()
		    self.m_Coords = {x = 0, y = 0}
		    self:SetSize(50,50)
		    self:SetColor(Color(125,125,125))
		    self:SetItemPanel(false)

		    self:Receiver("invitem", function(pnl, item, drop, i, x, y) --Drag-drop
				if drop then
					
					item = item[1]
					local x1,y1 = pnl:GetPos()
					local x2,y2 = item:GetPos()
					if math.Dist(x1,y1,x2,y2) <= 2500 then --Find the top left slot.
						if not pnl:GetItemPanel() then
							local itm = item:GetItem()
							local x,y = pnl:GetCoords()
							local cloth = itm:GetClothes()
							local cloth_index = itm:GetClothIndex()
							local cloth_texture = itm:GetClothTexture()
							local xT, yT = item:GetCoords()

							if item:GetParent():GetName() == "DFrame" then

								local itmw, itmh = itm:GetSize()
								local full = false
								for i1=x, (x+itmw)-1 do
									if full then break end
									for i2=y, (y+itmh)-1 do
										if LocalPlayer():GetInvItem(i1,i2):GetItemPanel() then --check if the panels in the area are full.
											full = true
											break
										end
									end
								end
								if not full then --If none of them are full then
									for i1=x, (x+itmw)-1 do
										for i2=y, (y+itmh)-1 do
											LocalPlayer():GetInvItem(i1,i2):SetItemPanel(item) -- Tell all the things below it that they are now full of this item.
										end
									end
									item:SetRoot(pnl)
									item:SetPos(pnl:GetPos()) --move the item.
									local xT, yT = item:GetCoords()
									LocalPlayer():GetInvItem(xT,yT):SetItemPanel(false)
									item:SetCoords(x,y)

									if x == 3 and (y == 1 or y == 2 or y == 3) then
										item:SetSize(200,50)
										min, max = item.Entity:GetRenderBounds()
										item:SetFOV(55)
										item:SetCamPos( Vector( 1, 1, 1 ) * min:Distance( max ) )
										item:SetLookAt( ( min + max ) / 2 )
									else
										item:SetSize(50,50)
										min, max = item.Entity:GetRenderBounds()
										item:SetFOV(25)
										item:SetCamPos( Vector( 1, 1, 1 ) * min:Distance( max ) )
										item:SetLookAt( ( min + max ) / 2 )
									end

									net.Start("RisedCraft.Craft")
									net.WriteInt(-4,10)
									net.WriteInt(xT,10)
									net.WriteInt(yT,10)
									net.WriteInt(x,10)
									net.WriteInt(y,10)
									net.SendToServer()

									ResultCheck()
								end
							elseif item:GetParent():GetName() == "StorageSlot" then
								local itmw, itmh = itm:GetSize()
								local full = false
								for i1=x, (x+itmw)-1 do
									if full then break end
									for i2=y, (y+itmh)-1 do
										if LocalPlayer():GetInvItem(i1,i2):GetItemPanel() then --check if the panels in the area are full.
											full = true
											break
										end
									end
								end
								if not full then --If none of them are full then
									for i1=x, (x+itmw)-1 do
										for i2=y, (y+itmh)-1 do
											LocalPlayer():GetInvItem(i1,i2):SetItemPanel(item) -- Tell all the things below it that they are now full of this item.
										end
									end
									item:SetParent(dfram)
									local xT, yT = item:GetCoords()
									_Storage[xT][yT]:SetItemPanel(false)
									item:SetCoords(x,y)

									if x == 3 and (y == 1 or y == 2 or y == 3) then
										item:SetSize(200,50)
										min, max = item.Entity:GetRenderBounds()
										item:SetFOV(55)
										item:SetCamPos( Vector( 1, 1, 1 ) * min:Distance( max ) )
										item:SetLookAt( ( min + max ) / 2 )
									else
										item:SetSize(50,50)
										min, max = item.Entity:GetRenderBounds()
										item:SetFOV(25)
										item:SetCamPos( Vector( 1, 1, 1 ) * min:Distance( max ) )
										item:SetLookAt( ( min + max ) / 2 )
									end

									net.Start("RisedCraft.Craft")
									net.WriteInt(-2,10)
									net.WriteInt(xT,10)
									net.WriteInt(yT,10)
									net.WriteInt(x,10)
									net.WriteInt(y,10)
									net.SendToServer()
									item:SetRoot(pnl)
									item:SetPos(pnl:GetPos()) --move the item.

									ResultCheck()
								end
							end
						end
					end
				else
					--Something about coloring of hovered slots.
				end
			end, {})
		end

		function PANEL:SetCoords(x,y)
			self.m_Coords.x = x
			self.m_Coords.y = y
		end

		function PANEL:GetCoords()
			return self.m_Coords.x, self.m_Coords.y
		end

		local col
		local mat_frame = Material( "rised_inventory/item_slot.png" )
		function PANEL:Paint(w,h)
			draw.NoTexture()
			col = self:GetColor()
			self:SetZPos( 0 )

			surface.SetDrawColor( 125, 125, 125, 75 )
			surface.SetMaterial( mat_frame )
			surface.DrawTexturedRect( 0, 0, w, h )
		end

		vgui.Register("InvSlot", PANEL, "DPanel")

		---=== CRAFT PANEL ===---
		local PANEL = {}

		AccessorFunc(PANEL, "m_ItemPanel", "ItemPanel")
		AccessorFunc(PANEL, "m_Color", "Color")

		function PANEL:Init()
		    self.m_Coords = {x = 0, y = 0}
		    self:SetSize(50,50)
		    self:SetColor(Color(125,125,125))
		    self:SetItemPanel(false)

		    self:Receiver("invitem", function(pnl, item, drop, i, x, y) --Drag-drop
				if drop then
					
					item = item[1]
					local x1,y1 = pnl:GetPos()
					local x2,y2 = item:GetPos()
					if math.Dist(x1,y1,x2,y2) <= 2500 then --Find the top left slot.
						if not pnl:GetItemPanel() then
							local itm = item:GetItem()
							local x,y = pnl:GetCoords()
							local cloth = itm:GetClothes()
							local cloth_index = itm:GetClothIndex()
							local cloth_texture = itm:GetClothTexture()
							local xT, yT = item:GetCoords()

							if item:GetParent():GetName() == "DFrame" then

								local itmw, itmh = itm:GetSize()
								local full = false
								for i1=x, (x+itmw)-1 do
									if full then break end
									for i2=y, (y+itmh)-1 do
										if _Storage[i1][i2]:GetItemPanel() then --check if the panels in the area are full.
											full = true
											break
										end
									end
								end

								if not full then --If none of them are full then
									for i1=x, (x+itmw)-1 do
										for i2=y, (y+itmh)-1 do
											_Storage[i1][i2]:SetItemPanel(item) -- Tell all the things below it that they are now full of this item.
										end
									end
									item:SetParent(pnl)
									item:SetPos(0,0) --move the item.
									local xT, yT = item:GetCoords()
									LocalPlayer():GetInvItem(xT,yT):SetItemPanel(false)
									item:SetCoords(x,y)

									item:SetSize(50,50)
									min, max = item.Entity:GetRenderBounds()
									item:SetFOV(25)
									item:SetCamPos( Vector( 1, 1, 1 ) * min:Distance( max ) )
									item:SetLookAt( ( min + max ) / 2 )

									net.Start("RisedCraft.Craft")
									net.WriteInt(-1,10)
									net.WriteInt(xT,10)
									net.WriteInt(yT,10)
									net.WriteInt(x,10)
									net.WriteInt(y,10)
									net.SendToServer()

									ResultCheck()
								end
							elseif item:GetParent():GetName() == "StorageSlot" then

								local itmw, itmh = itm:GetSize()
								local full = false
								for i1=x, (x+itmw)-1 do
									if full then break end
									for i2=y, (y+itmh)-1 do
										if _Storage[i1][i2]:GetItemPanel() then --check if the panels in the area are full.
											full = true
											break
										end
									end
								end

								if not full then --If none of them are full then
									for i1=x, (x+itmw)-1 do
										for i2=y, (y+itmh)-1 do
											_Storage[i1][i2]:SetItemPanel(item) -- Tell all the things below it that they are now full of this item.
										end
									end

									item:SetParent(pnl)
									item:SetPos(0,0)
									local xT, yT = item:GetCoords()
									_Storage[xT][yT]:SetItemPanel(false)
									item:SetCoords(x,y)

									item:SetSize(50,50)
									min, max = item.Entity:GetRenderBounds()
									item:SetFOV(25)
									item:SetCamPos( Vector( 1, 1, 1 ) * min:Distance( max ) )
									item:SetLookAt( ( min + max ) / 2 )

									net.Start("RisedCraft.Craft")
									net.WriteInt(-3,10)
									net.WriteInt(xT,10)
									net.WriteInt(yT,10)
									net.WriteInt(x,10)
									net.WriteInt(y,10)
									net.SendToServer()

									ResultCheck()
								end
							end
						end
					end
				else
					--Something about coloring of hovered slots.
				end
			end, {})
		end

		function PANEL:SetCoords(x,y)
			self.m_Coords.x = x
			self.m_Coords.y = y
		end

		function PANEL:GetCoords()
			return self.m_Coords.x, self.m_Coords.y
		end

		local col
		local mat_frame = Material( "rised_inventory/item_slot.png" )
		function PANEL:Paint(w,h)
			draw.NoTexture()
			col = self:GetColor()
			local x,y = self:GetCoords()
			if x == 1 then
				surface.SetDrawColor( 125, 125, 125, 75 )
				surface.SetMaterial( mat_frame )
				surface.DrawTexturedRect( 0, 0, 50, 50 )
			elseif x == 2 then
				surface.SetDrawColor( 125, 125, 100, 125 )
				surface.SetMaterial( mat_frame )
				surface.DrawTexturedRect( 0, 0, 100, 100 )
			elseif x == 3 then
				surface.SetDrawColor( 255, 255, 255, 45 )
				surface.SetMaterial( mat_frame )
				surface.DrawTexturedRect( 0, 0, 50, 50 )
			end
		end

		vgui.Register("StorageSlot", PANEL, "DPanel")

		dfram = vgui.Create("DFrame")
		dfram:SetSize(565, 95)
		dfram:SetPos(ScrW()/2 - 282.5, ScrH()/2 + 175)
		dfram:SetTitle("")
		dfram:MakePopup()
		dfram:SetDraggable( false )
		dfram.Paint = function(s,w,h)
			draw.RoundedBox(1,0,0,w,h,Color(0,0,0,190))
			draw.RoundedBox(1,0,0,w,25,Color(0,0,0,140))
			draw.SimpleText( "Личный инвентарь", "DermaDefault", 10, 5, color_white )
		end
		for k,v in pairs(ply.Inv.Wear) do
			for i = 1,11 do
				if k == 2 then
					ply.Inv.Wear[k][i] = vgui.Create("InvSlot", dfram)
					ply.Inv.Wear[k][i]:SetPos(-40 + i*50,35)
					ply.Inv.Wear[k][i]:SetCoords(k,i)
				end
			end
		end

		local mat = Material( "rised_inventory/bg.png" )
		dfram_box = vgui.Create("DFrame")
		dfram_box:SetSize(800, 250)
		dfram_box:SetPos(ScrW()/2 - 400,ScrH()/2 - 150)
		dfram_box:SetTitle("")
		dfram_box:MakePopup()
		-- dfram_box:ShowCloseButton( false )
		dfram_box:SetDraggable( false )
		dfram_box.Paint = function(s,w,h)
			draw.RoundedBox(1,0,0,w,h,Color(0,0,0,155))
			
			surface.SetDrawColor( 255, 255, 255, 5 )
			surface.SetMaterial( mat )
			surface.DrawTexturedRect( 5, 5, 790, 240 )

			surface.SetDrawColor(155,155,155,255)
			surface.DrawLine(80,82,80,88)
			surface.DrawLine(80+(100*1),82,80+(100*1),88)
			surface.DrawLine(80+(100*2),82,80+(100*2),88)
			surface.DrawLine(80+(100*3),82,80+(100*3),88)
			surface.DrawLine(80+(100*4),82,80+(100*4),88)
		end
		for i = 1,5 do
			_Storage[1][i] = vgui.Create("StorageSlot", dfram_box)
			_Storage[1][i]:SetPos(-45 + i*100,30)
			_Storage[1][i]:SetSize(50,50)
			_Storage[1][i]:SetCoords(1,i)
		end

		_Storage[2][1] = vgui.Create("StorageSlot", dfram_box)
		_Storage[2][1]:SetPos(-45 + 11*60,75)
		_Storage[2][1]:SetSize(100,100)
		_Storage[2][1]:SetCoords(2,1)

		_Storage[3][1] = vgui.Create("StorageSlot", dfram_box)
		_Storage[3][1]:SetPos(-45 + 4*100,155)
		_Storage[3][1]:SetSize(50,50)
		_Storage[3][1]:SetCoords(3,1)

		local item_to_craft = ""

		function ResultCheck()

			local ing01 = false
			local ing02 = false
			local ing03 = false
			local ing04 = false
			local ing05 = false

			local schema = false

			if _Storage[3][1]:GetItemPanel() then
				local schema_name = _Storage[3][1]:GetItemPanel():GetItem():GetSchema()

				if schema_name != nil then
					DLabelIng1:SetText(RisedCraft_Items[schema_name][1])
					DLabelIng2:SetText(RisedCraft_Items[schema_name][2])
					DLabelIng3:SetText(RisedCraft_Items[schema_name][3])
					DLabelIng4:SetText(RisedCraft_Items[schema_name][4])
					DLabelIng5:SetText(RisedCraft_Items[schema_name][5])
				end

				if schema_name == item_to_craft then
					schema = true
				else
					schema = false
				end

			else
				DLabelIng1:SetText("    ?")
				DLabelIng2:SetText("    ?")
				DLabelIng3:SetText("    ?")
				DLabelIng4:SetText("    ?")
				DLabelIng5:SetText("    ?")
			end

			if DLabelIng1:GetText() != "" and _Storage[1][1]:GetItemPanel() then
				local ing_name = _Storage[1][1]:GetItemPanel():GetItem():GetInfo()
				if ing_name == DLabelIng1:GetText() then
					ing01 = true
				end
			elseif DLabelIng1:GetText() == "" then
				ing01 = true
			end

			if DLabelIng2:GetText() != "" and _Storage[1][2]:GetItemPanel() then
				local ing_name = _Storage[1][2]:GetItemPanel():GetItem():GetInfo()
				if ing_name == DLabelIng2:GetText() then
					ing02 = true
				end
			elseif DLabelIng2:GetText() == "" then
				ing02 = true
			end

			if DLabelIng3:GetText() != "" and _Storage[1][3]:GetItemPanel() then
				local ing_name = _Storage[1][3]:GetItemPanel():GetItem():GetInfo()
				if ing_name == DLabelIng3:GetText() then
					ing03 = true
				end
			elseif DLabelIng3:GetText() == "" then
				ing03 = true
			end

			if DLabelIng4:GetText() != "" and _Storage[1][4]:GetItemPanel() then
				local ing_name = _Storage[1][4]:GetItemPanel():GetItem():GetInfo()
				if ing_name == DLabelIng4:GetText() then
					ing04 = true
				end
			elseif DLabelIng4:GetText() == "" then
				ing04 = true
			end

			if DLabelIng5:GetText() != "" and _Storage[1][5]:GetItemPanel() then
				local ing_name = _Storage[1][5]:GetItemPanel():GetItem():GetInfo()
				if ing_name == DLabelIng5:GetText() then
					ing05 = true
				end
			elseif DLabelIng5:GetText() == "" then
				ing05 = true
			end

			if ing01 and ing02 and ing03 and ing04 and ing05 and schema then
				DModelResult:SetColor(Color(255, 255, 255, 255))
			else
				DModelResult:SetColor(Color(255, 255, 255, 100))
			end
		end

		DLabelIng1 = vgui.Create( "DLabel", dfram_box )
		DLabelIng1:SetPos( 55, 90 )
		DLabelIng1:SetSize( 80, 50 )
		DLabelIng1:SetText( "?" )
		DLabelIng1:SetFont( "DermaDefault" )
		DLabelIng1:SetColor(Color(155, 155, 155))
		DLabelIng1:SetWrap( true )
		DLabelIng1:SetContentAlignment(7)

		DLabelIng2 = vgui.Create( "DLabel", dfram_box )
		DLabelIng2:SetPos( 155, 90 )
		DLabelIng2:SetSize( 80, 50 )
		DLabelIng2:SetText( "    ?" )
		DLabelIng2:SetFont( "DermaDefault" )
		DLabelIng2:SetColor(Color(155, 155, 155))
		DLabelIng2:SetWrap( true )
		DLabelIng2:SetContentAlignment(7)
		
		DLabelIng3 = vgui.Create( "DLabel", dfram_box )
		DLabelIng3:SetPos( 255, 90 )
		DLabelIng3:SetSize( 80, 50 )
		DLabelIng3:SetText( "    ?" )
		DLabelIng3:SetFont( "DermaDefault" )
		DLabelIng3:SetColor(Color(155, 155, 155))
		DLabelIng3:SetWrap( true )
		DLabelIng3:SetContentAlignment(7)
		
		DLabelIng4 = vgui.Create( "DLabel", dfram_box )
		DLabelIng4:SetPos( 355, 90 )
		DLabelIng4:SetSize( 80, 50 )
		DLabelIng4:SetText( "    ?" )
		DLabelIng4:SetFont( "DermaDefault" )
		DLabelIng4:SetColor(Color(155, 155, 155))
		DLabelIng4:SetWrap( true )
		DLabelIng4:SetContentAlignment(7)
		
		DLabelIng5 = vgui.Create( "DLabel", dfram_box )
		DLabelIng5:SetPos( 455, 90 )
		DLabelIng5:SetSize( 80, 50 )
		DLabelIng5:SetText( "?" )
		DLabelIng5:SetFont( "DermaDefault" )
		DLabelIng5:SetColor(Color(155, 155, 155))
		DLabelIng5:SetWrap( true )
		DLabelIng5:SetContentAlignment(7)

		DLabelSchema = vgui.Create( "DLabel", dfram_box )
		DLabelSchema:SetPos( 353, 205 )
		DLabelSchema:SetSize( 100, 25 )
		DLabelSchema:SetText( "Чертеж" )
		DLabelSchema:SetFont( "marske4" )
		DLabelSchema:SetWrap( true )
		DLabelSchema:SetContentAlignment(5)
		
		DModelResult = vgui.Create( "DModelPanel", dfram_box )
		DModelResult:SetSize(150,150)
		DModelResult:SetPos( 590, 55 )
		DModelResult:SetModel( "" )
		DModelResult.DoClick = function()
			if DModelResult:GetColor() == Color(255,255,255,255) then
				net.Start("RisedCraft.Craft")
				net.WriteInt(1,10)
				net.WriteString(item_to_craft)
				net.SendToServer()

				dfram_box:Close()
			end
		end


		local DScrollPanel = vgui.Create( "DScrollPanel", dfram_box )
		DScrollPanel:SetPos(50, 155)
		DScrollPanel:SetSize(300, 90)
	
		local sbar = DScrollPanel:GetVBar()
		function sbar:Paint(w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 145))
		end
		function sbar.btnUp:Paint(w, h)
			draw.RoundedBox(0, 0, 0, w, h-10, Color(145, 145, 145, 255))
		end
		function sbar.btnDown:Paint(w, h)
			draw.RoundedBox(0, 0, 10, w, h-10, Color(145, 145, 145, 255))
		end
		function sbar.btnGrip:Paint(w, h)
			draw.RoundedBox(0, 0, -5, w, h, Color(145, 145, 145, 255))
		end

		for k,v in pairs(RisedCraft_Items) do
			local item = scripted_ents.Get(k)
			if !istable(item) then
				item = weapons.GetStored(k)
			end
			local item_name = item.PrintName
			local item_model = item.WorldModel
			local DButton = DScrollPanel:Add( "DButton" )
			DButton:SetText("")
			DButton:Dock( TOP )
			DButton:DockMargin( 0, 0, 0, 5 )
			DButton.DoClick = function()

				DModelResult:SetModel(item_model)
				local min, max = DModelResult.Entity:GetRenderBounds()
				DModelResult:SetFOV(30)
				DModelResult:SetCamPos( Vector( 1, 1, 1 ) * min:Distance( max ) )
				DModelResult:SetLookAt( ( min + max ) / 2 )
				function DModelResult:LayoutEntity( Entity ) return end

				item_to_craft = k

				ResultCheck()
			end
			DButton.Paint = function(s,w,h)
				draw.RoundedBox(1,5,5,w-10,h-10,Color(100,100,100,145))
				draw.RoundedBox(1,0,0,w,h,Color(0,0,0,150))
				draw.SimpleText( item_name, "marske4", 150, 10, color_white, 1, 1 )
				
				surface.SetDrawColor( 255, 255, 255, 255 )
			end
		end

		dfram_box.OnClose = function()
			if IsValid(dfram) then
				dfram:Close()
			end
		end
		dfram.OnClose = function()
			if IsValid(dfram_box) then
				dfram_box:Close()
			end
		end

		local dfram1 = vgui.Create("DFrame", dfram)
		dfram1:SetSize(ScrW(), ScrH())
		dfram1:MakePopup()
		dfram1:MoveToBack()
		dfram1:SetTitle("")
		dfram1:ShowCloseButton(false)
		dfram1.startTime = SysTime()
		dfram1.Paint = function(s,w,h)
			Derma_DrawBackgroundBlur(s, s.startTime)
			if dfram1:IsActive() then
				if IsValid(dfram) then
					dfram:Close()
				end
				if IsValid(dfram_box) then
					dfram_box:Close()
				end
			end
		end

		---=== ITEM PANEL ===---
		PANEL = {}

		AccessorFunc(PANEL, "m_Item", "Item")
		AccessorFunc(PANEL, "m_Root", "Root")
		AccessorFunc(PANEL, "m_Color", "Color")

		function PANEL:Init()
		    self.m_Coords = {x=0,y=0}
			self:SetSize(50,50)
			self:SetItem(false) --false means no item.
			self:Droppable("invitem")
			self:SetModel( "models/balloons/balloon_classicheart.mdl" )

			min, max = self.Entity:GetRenderBounds()
			self:SetCamPos( Vector( 0.4, 0.4, 0.4 ) * min:Distance( max ) )
			self:SetLookAt( ( min + max ) / 3.5 )

			function self:LayoutEntity( Entity ) return end
		end

		function PANEL:SetCoords(x,y)
			self.m_Coords.x = x
			self.m_Coords.y = y
		end

		function PANEL:GetCoords()
			return self.m_Coords.x, self.m_Coords.y
		end

		function PANEL:GetIcon()
		    return "models/props_borealis/bluebarrel001.mdl"
		end

		local item_info = vgui.Create("DFrame", dfram)
		item_info:SetSize(500, 500)
		item_info:SetPos(-1000, -1000)
		item_info:MakePopup()
		item_info:SetTitle("")
		item_info:ShowCloseButton(false)
		item_info.info = "none"
		item_info.weight = 0
		item_info.Paint = function(s,w,h)
			if istable(item_info.info) then
				local i = 0
				for k,v in pairs(item_info.info) do
					draw.SimpleText( v, "marske4", 5, i * 20, color_white )
					i = i + 1
				end
			else
				draw.SimpleText( "Инфо: " .. item_info.info, "marske4", 5, 0, color_white )
			end
			if item_info.weight != nil then
				draw.SimpleText( "Вес: " .. item_info.weight .. " кг.", "marske4", 5, 15, color_white )
			end
		end

		function PANEL:OnCursorMoved()

		    local itm = self:GetItem()
		    item_info.info = itm:GetInfo()
		    if item_info.info == "Мед карта" then
		   	 	item_info.info = itm:GetMedData()
		    end
		    item_info.weight = itm:GetWeight()

			local x,y = self:CursorPos()
			y = y
			x = x + 50
		    item_info:SetPos(self:LocalToScreen(x,y))

		end

		function PANEL:OnCursorExited()
			local x,y = -1000, -1000
		    item_info:SetPos(x,y)
		end

		vgui.Register("InvItem", PANEL, "DModelPanel")

		function IsRoomFor(item, set_x, set_y)
			pnl = LocalPlayer().Inv.Wear[set_x][set_y]
			if not pnl:GetItemPanel() then
				local x,y = pnl:GetCoords()
				local itmw, itmh = item:GetSize()
				local full = false
				for i1=x, (x+itmw)-1 do
					if full then break end
					for i2=y, (y+itmh)-1 do
						if LocalPlayer():GetInvItem(i1,i2):GetItemPanel() then
							full = true
							break
						end
					end
				end
				if !full then
					return pnl
				end
			end

			return false
		end

		function PickupItem(item)
			local set_x, set_y = item:GetPos()

			local place = IsRoomFor(item, set_x, set_y)
			if place then
				
				local itm = vgui.Create("InvItem", dfram)
				itm:SetItem(item)
				itm:SetModel( item.Model )
				itm:SetRoot(place)
				itm:SetPos(place:GetPos())

				if set_x == 3 and (set_y == 1 or set_y == 2 or set_y == 3) then
					itm:SetSize(200,50)
					min, max = itm.Entity:GetRenderBounds()
					itm:SetFOV(55)
					itm:SetCamPos( Vector( 1, 1, 1 ) * min:Distance( max ) )
					itm:SetLookAt( ( min + max ) / 2 )
				else
					itm:SetSize(50,50)
					min, max = itm.Entity:GetRenderBounds()
					itm:SetFOV(25)
					itm:SetCamPos( Vector( 1, 1, 1 ) * min:Distance( max ) )
					itm:SetLookAt( ( min + max ) / 2 )
				end
				
				local x,y = place:GetCoords()
				local itmw, itmh = item:GetSize()
				for i1=x, (x+itmw)-1 do
					for i2=y, (y+itmh)-1 do
						LocalPlayer():GetInvItem(i1,i2):SetItemPanel(itm)
						itm:SetCoords(i1,i2)
					end
				end
				
				return true
				
			else
				return false
			end
		end

		if inv.Wear != nil then
		    for i = 1,11 do
		    	if istable(inv.Wear[2][i]) then
					local Item = {}
					Item.Name = inv.Wear[2][i].PrintName
					Item.Model = inv.Wear[2][i].Model
					function Item:GetPos()
						return 2, i
					end
					function Item:GetSize()
						return 1, 1
					end
					function Item:GetIcon()
						return Material("entities/weapon_pistol.png")
					end
					function Item:GetClothes()
						return inv.Wear[2][i].Clothes
					end
					function Item:GetClothIndex()
						return inv.Wear[2][i].Index
					end
					function Item:GetClothTexture()
						return inv.Wear[2][i].Texture
					end
					function Item:GetWeaponClass()
						if inv.Wear[2][i].DT != nil then
							return inv.Wear[2][i].DT.WeaponClass
						else
							return ""
						end
					end
					function Item:GetInfo()
						if inv.Wear[2][i].PrintName == "Food" then
							return inv.Wear[2][i].FoodName
						end
						if inv.Wear[2][i].Notepad_ID != nil then
							return inv.Wear[2][i].Notepad_ID
						end
						if inv.Wear[2][i].PrintName == "Spawned Weapon" then
							return string.sub(inv.Wear[2][i].DT.WeaponClass, 5, 20 )
						end
						if inv.Wear[2][i].PrintName == "ID карта" then
							return inv.Wear[2][i].IDCard_Person
						end
						return inv.Wear[2][i].PrintName
					end
					function Item:GetSchema()
						if inv.Wear[2][i].CraftSchema != nil then
							return inv.Wear[2][i].CraftSchema
						end
						return ""
					end
					function Item:GetMedData()
						if inv.Wear[2][i].PrintName == "Мед карта" then
							local tbl = {
								inv.Wear[2][i].MedCard_Person,
								inv.Wear[2][i].MedCard_Height,
								inv.Wear[2][i].MedCard_Weight,
								inv.Wear[2][i].MedCard_Physics,
								inv.Wear[2][i].MedCard_Mental,
								inv.Wear[2][i].MedCard_BloodGroup,
								inv.Wear[2][i].MedCard_Disease,
							}
							return tbl
						end
						return {}
					end
					function Item:GetWeight()
						return inv.Wear[2][i].Weight
					end

		    		PickupItem(Item)
		    	end
			end
		end

		function IsRoomForStorage(item, set_x, set_y)
			pnl = _Storage[set_x][set_y]
			if not pnl:GetItemPanel() then
				local x,y = pnl:GetCoords()
				local itmw, itmh = item:GetSize()
				local full = false
				for i1=x, (x+itmw)-1 do
					if full then break end
					for i2=y, (y+itmh)-1 do
						if _Storage[i1][i2]:GetItemPanel() then
							full = true
							break
						end
					end
				end
				if !full then
					return pnl
				end
			end

			return false
		end

		function PlaceStorageItem(item)
			local set_x, set_y = item:GetPos()

			local place = IsRoomForStorage(item, set_x, set_y)
			if place then
				
				local itm = vgui.Create("InvItem", dfram_box)
				itm:SetItem(item)
				itm:SetModel(item.Model)
				itm:SetParent(place)
				itm:SetPos(0,0)

				itm:SetSize(50,50)
				min, max = itm.Entity:GetRenderBounds()
				itm:SetFOV(25)
				itm:SetCamPos( Vector( 1, 1, 1 ) * min:Distance( max ) )
				itm:SetLookAt( ( min + max ) / 2 )
				
				local x,y = place:GetCoords()
				local itmw, itmh = item:GetSize()
				for i1=x, (x+itmw)-1 do
					for i2=y, (y+itmh)-1 do
						_Storage[i1][i2]:SetItemPanel(itm)
						itm:SetCoords(i1,i2)
					end
				end
				
				return true
				
			else
				return false
			end
		end

		if storage != nil then
			for k,v in pairs(storage) do
			    for i = 1,5 do
			    	if istable(storage[k][i]) and (k==1 or k==2 and i==1 or k==3 and i==1) then

						local Item = {}
						Item.Name = storage[k][i].PrintName
						Item.Model = storage[k][i].Model
						function Item:GetPos()
							return k, i
						end
						function Item:GetSize()
							return 1, 1
						end
						function Item:GetIcon()
							return Material("entities/weapon_pistol.png")
						end
						function Item:GetClothes()
							return storage[k][i].Clothes
						end
						function Item:GetClothIndex()
							return storage[k][i].Index
						end
						function Item:GetClothTexture()
							return storage[k][i].Texture
						end
						function Item:GetWeaponClass()
							if storage[k][i].DT != nil then
								return storage[k][i].DT.WeaponClass
							else
								return ""
							end
						end
						function Item:GetInfo()
							if storage[k][i].PrintName == "Food" then
								return storage[k][i].FoodName
							end
							if storage[k][i].Notepad_ID != nil then
								return storage[k][i].Notepad_ID
							end
							if storage[k][i].PrintName == "Spawned Weapon" then
								return string.sub(storage[k][i].DT.WeaponClass, 5, 20 )
							end
							if storage[k][i].PrintName == "ID карта" then
								return storage[k][i].IDCard_Person
							end
							return storage[k][i].PrintName
						end
						function Item:GetSchema()
							if storage[k][i].CraftSchema != nil then
								return storage[k][i].CraftSchema
							end
							return ""
						end
						function Item:GetMedData()
							if storage[k][i].PrintName == "Мед карта" then
								local tbl = {
									storage[k][i].MedCard_Person,
									storage[k][i].MedCard_Height,
									storage[k][i].MedCard_Weight,
									storage[k][i].MedCard_Physics,
									storage[k][i].MedCard_Mental,
									storage[k][i].MedCard_BloodGroup,
									storage[k][i].MedCard_Disease,
								}
								return tbl
							end
							return {}
						end
						function Item:GetWeight()
							return storage[k][i].Weight
						end

			    		PlaceStorageItem(Item)
			    	end
			    end
			end
		end

		ResultCheck()
	end
end)