-- "addons\\rised_cargo_system\\lua\\entities\\npc_cargo\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

net.Receive("TradeNPC.Furniture.OpenMenu", function()
	TradeNPCFurnitureMenuOpen()
end)

function TradeNPCFurnitureMenuOpen()
	local frame = vgui.Create("DFrame") 
	frame:SetPos(0,0)
	frame:SetSize(ScrW(),ScrH())
	frame:SetTitle("")
	frame:Center()
	frame:SetDraggable(false)
	frame:ShowCloseButton(false)
	frame:SetBackgroundBlur(false)
	frame:MakePopup()
	frame.startTime = SysTime()
	frame.Paint = function(self, w, h)
		Derma_DrawBackgroundBlur(self, self.startTime)
		draw.RoundedBox(2, w/2 - 400, h/2 - 400, 800, 800, Color(10, 10, 10, 75));
		draw.DrawOutlinedRoundedRect(800, 800, Color(125, 125, 125, 5), w/2 - 400, h/2 - 400)

		draw.SimpleText("Михаил Ларионов", "marske8", w/2, ScrH()/2 - 355, Color(255, 255, 255, 255), 1, 2)
		draw.RoundedBox(0, w/2 - 150, ScrH()/2 - 320, 300, 1, Color(255, 255, 255, 255));
		draw.SimpleText("Продавец одежды", "marske6", w/2, ScrH()/2 - 310, Color(255, 255, 255, 255), 1, 2)
		
		self.ready = true;
	end
	
	local buttonClose = vgui.Create("DButton", frame)
	buttonClose:SetText("")
	buttonClose:SetSize(25,25)
	buttonClose:SetPos(ScrW()/1.5 - 25,ScrH()/2 - 355)
	buttonClose.Paint = function(me, w, h)
		draw.SimpleText("X", "marske5", w/2-6, h/2-8, Color(255,255,255), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER)
		draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		if (me.Hovered) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 10, 255), false, true, false, false)
		end

		if (me:IsDown()) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 5, 255), false, true, false, false)
		end
	end
	buttonClose.DoClick = function()
		frame:Close()
	end

	local playerModel = vgui.Create("DModelPanel", frame)
	playerModel:SetSize(350,500)
	playerModel:SetPos(ScrW()/2 - 400,ScrH()/2 - 250)
	playerModel:SetFOV(30)
	playerModel:SetCamPos( Vector( 95, -25, 65 ) )
	playerModel:SetModel(LocalPlayer():GetModel())
	function playerModel:LayoutEntity( Entity ) return end

	for i = 1, 14 do
		playerModel.Entity:SetBodygroup(i, LocalPlayer():GetBodygroup(i))
	end

	local items_to_trade = {}

	local i1 = GetGlobalInt("TradeNPC.Furniture_Item_01")
	local i2 = GetGlobalInt("TradeNPC.Furniture_Item_02")
	local i3 = GetGlobalInt("TradeNPC.Furniture_Item_03")
	local i4 = GetGlobalInt("TradeNPC.Furniture_Item_04")
	local i5 = GetGlobalInt("TradeNPC.Furniture_Item_05")
	
	local DScrollPanel = vgui.Create("DScrollPanel", frame)
	DScrollPanel:SetSize(500,600)
	DScrollPanel:SetPos(ScrW()/2 - 100,ScrH()/2 - 250)
	
	local sbar = DScrollPanel:GetVBar()
	function sbar:Paint(w, h)
		draw.RoundedBox(10, 0, 15, w, h-30, Color(10, 10, 10, 125))
	end
	function sbar.btnUp:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 0))
	end
	function sbar.btnDown:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 0))
	end
	function sbar.btnGrip:Paint(w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(255, 255, 255, 1))
	end

	local itemsIndex = {}
	for k,v in pairs(RISED.Config.Trade.Furniture.Items) do
		if v["Blocked"] == false then
			table.insert(itemsIndex, k)
		end
	end
	if RISED.Config.Trade.Furniture.IsRandomRotation then
		for i=1, RISED.Config.Trade.Furniture.MaxItems do
			items_to_trade[i] = RISED.Config.Trade.Furniture.Items[GetGlobalInt("TradeNPC.Furniture_Item_" .. i)]
		end
	else
		for i=1, #itemsIndex do
			items_to_trade[i] = RISED.Config.Trade.Furniture.Items[GetGlobalInt("TradeNPC.Furniture_Item_" .. i)]
		end
	end
	
	local offset = 15
	for k,v in pairs(items_to_trade) do
		
		local buttonAdd = DScrollPanel:Add("DButton")
		buttonAdd:SetSize(800, 75)
		buttonAdd:SetPos(100, offset)
		buttonAdd:SetText("")
		buttonAdd:SetFont( "marske4" )
		buttonAdd.Text = v.ItemName
		buttonAdd.Cost = v.ItemCost
		local width, height = surface.GetTextSize(buttonAdd.Text)
		buttonAdd.hovered = false
		buttonAdd.disabled = false
		buttonAdd.alpha = 0
		buttonAdd.starttime = SysTime();
		buttonAdd.Paint = function(self, w, h)
			if (buttonAdd.starttime < SysTime()) then
				buttonAdd.alpha = buttonAdd.alpha or 0
				buttonAdd.alpha = Lerp(FrameTime(), buttonAdd.alpha, 255)
			end
			
			if (self.disabled) then
				draw.SimpleText(self.Text .. "     -     " .. self.Cost .. " T.", "marske5", 20, h/2, Color(145, 145, 145, buttonAdd.alpha), 0, 1);
				return;
			end
			if (self.hovered) then
				if istable(v.PlayerBodygroups) then
					for id,bodygroup in pairs(v.PlayerBodygroups) do
						if bodygroup == 0 then continue end
						playerModel.Entity:SetBodygroup(id, bodygroup)
					end
				end
				draw.RoundedBox(0,0,h-1,w/4,1,Color(255, 165, 0,buttonAdd.alpha));
				draw.SimpleText(self.Text, "marske5", 20, h/2 - 5, Color(255, 165, 0, buttonAdd.alpha), 0, 1);
				draw.SimpleText(self.Cost .. " T.", "marske4", 35, h/2 + 20, Color(255, 165, 0, buttonAdd.alpha), 0, 1);
				return;
			end
			
			draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 125));
			draw.SimpleText(self.Text, "marske5", 20, h/2 - 5, Color(255, 255, 255, buttonAdd.alpha), 0, 1);
			draw.SimpleText(self.Cost .. " T.", "marske4", 65, h/2 + 20, Color(255, 255, 255, buttonAdd.alpha), 0, 1);
		end;
		buttonAdd.OnCursorEntered = function(self)
			if (self.disabled) then return false end
			self.hovered = true
			surface.PlaySound("garrysmod/ui_hover.wav")
		end
		buttonAdd.OnMousePressed = function(self)
			if (self.disabled) then return false end
			surface.PlaySound("garrysmod/ui_click.wav")
			frame:Close()
			
			net.Start("TradeNPC.Furniture.Server")
			net.WriteInt(k,10)
			net.SendToServer()
		end
		buttonAdd.OnCursorExited = function(self)
			self.hovered = false
		end
		
		local itemModel = DScrollPanel:Add("DModelPanel")
		itemModel:SetSize(175,175)
		itemModel:SetFOV(65)
		itemModel:SetLookAt(Vector( 0, 0, 0 ))
		itemModel:SetPos(350, offset - 50)
		itemModel:SetModel( v.ItemModel )
		function itemModel:LayoutEntity( Entity ) return end
		
		offset = offset + 150
	end
end

function ENT:Draw()
	self:DrawModel()
	local pos = self:GetPos()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 85)
	if LocalPlayer():GetPos():Distance(self:GetPos()) < 500 then
		if (self:GetDTInt(1) == 0) then
			cam.Start3D2D(pos + ang:Up()*0, Angle(0, LocalPlayer():EyeAngles().y-90, 90), 0.07)
				
				draw.SimpleText("Михаил Ларионов", "marske6", -20, -1100, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
				surface.SetDrawColor( 255, 255, 255, 50 )
				surface.DrawLine( -90, -1085, 50, -1085 )
				draw.SimpleText("Продавец одежды", "Trebuchet18", -20, -1075, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);

			cam.End3D2D();
		end
	end 
end 