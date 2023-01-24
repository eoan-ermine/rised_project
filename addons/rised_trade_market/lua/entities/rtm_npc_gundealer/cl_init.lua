-- "addons\\rised_trade_market\\lua\\entities\\rtm_npc_gundealer\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

net.Receive("TradeNPC.GunDealer.OpenMenu", function()
	TradeNPCGunDealerMenuOpen()
end)

function TradeNPCGunDealerMenuOpen()
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

		draw.SimpleText("Инкогнито", "marske8", w/2, ScrH()/2 - 355, Color(255, 255, 255, 255), 1, 2)
		draw.RoundedBox(0, w/2 - 150, ScrH()/2 - 320, 300, 1, Color(255, 255, 255, 255));
		draw.SimpleText("Торговец оружием", "marske6", w/2, ScrH()/2 - 310, Color(255, 255, 255, 255), 1, 2)
		
		self.ready = true;
	end
	
	local buttonClose = vgui.Create("DButton", frame)
	buttonClose:SetText("X")
	buttonClose:SetSize(25,25)
	buttonClose:SetPos(ScrW()/1.5 - 25,ScrH()/10)
	buttonClose.Paint = function(me, w, h)
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

	local items_to_trade = {}

	local i1 = GetGlobalInt("TradeNPC.GunDealer_Item_01")
	local i2 = GetGlobalInt("TradeNPC.GunDealer_Item_02")
	local i3 = GetGlobalInt("TradeNPC.GunDealer_Item_03")
	local i4 = GetGlobalInt("TradeNPC.GunDealer_Item_04")
	local i5 = GetGlobalInt("TradeNPC.GunDealer_Item_05")
	
	local DScrollPanel = vgui.Create( "DScrollPanel", frame )
	DScrollPanel:SetSize(800,500)
	DScrollPanel:SetPos(ScrW()/2 - 400,ScrH()/2 - 250)
	
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

	for i=1, RISED.Config.Trade.GunDealer.MaxItems do
		items_to_trade[i] = RISED.Config.Trade.GunDealer.Items[GetGlobalInt("TradeNPC.GunDealer_Item_" .. i)]
	end

	
	local displayCategory = true
	local categoryOffset = 0
	local offset = 15
	for k,v in pairs(items_to_trade) do

		if v.ItemCategory != "Оружие" then continue end

		if displayCategory then
			displayCategory = false
			categoryOffset = 100
			local categoryLabel = DScrollPanel:Add("DLabel")
			categoryLabel:SetSize(500,50)
			categoryLabel:SetPos(150, offset - 25)
			categoryLabel:SetText(v.ItemCategory)
			categoryLabel:SetFont("marske8")
		end

		local buttonAdd = DScrollPanel:Add("DButton")
		buttonAdd:SetSize(800, 75)
		buttonAdd:SetPos(100, offset + 35)
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
				draw.RoundedBox(0,0,h-1,w/4,1,Color(255, 165, 0,buttonAdd.alpha));
				draw.SimpleText(self.Text .. "     -     " .. self.Cost .. " T.", "marske5", 20, h/2, Color(255, 165, 0, buttonAdd.alpha), 0, 1);
				return;
			end
			
			draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 125));
			
			draw.SimpleText(self.Text .. "     -     " .. self.Cost .. " T.", "marske5", 20, h/2, Color(255, 255, 255, buttonAdd.alpha), 0, 1);
		end;
		buttonAdd.OnCursorEntered = function(self)
			if (self.disabled) then return false end
			self.hovered = true
			surface.PlaySound("garrysmod/ui_hover.wav")
		end
		buttonAdd.OnMousePressed = function(self)
			if (self.disabled) then return false end
			surface.PlaySound("garrysmod/ui_click.wav")
			-- frame:Close()
			
			net.Start("TradeNPC.GunDealer.Server")
			net.WriteInt(k,10)
			net.SendToServer()
		end
		buttonAdd.OnCursorExited = function(self)
			self.hovered = false
		end

		local itemModel = DScrollPanel:Add("DModelPanel")
		itemModel:SetSize(350,350)
		itemModel:SetFOV(45)
		itemModel:SetLookAt( Vector( 0, -10, 25 ) )
		itemModel:SetPos(400, offset - 260)
		itemModel:SetModel( v.ItemModel )
		function itemModel:LayoutEntity( Entity ) return end
		
		offset = offset + 150
	end
	
	offset = offset + categoryOffset
	displayCategory = true
	categoryOffset = 0
	for k,v in pairs(items_to_trade) do

		if v.ItemCategory != "Патроны" then continue end
		
		if displayCategory then
			displayCategory = false
			categoryOffset = 100
			local categoryLabel = DScrollPanel:Add("DLabel")
			categoryLabel:SetSize(500,50)
			categoryLabel:SetPos(150, offset - 25)
			categoryLabel:SetText(v.ItemCategory)
			categoryLabel:SetFont("marske8")
		end

		local buttonAdd = DScrollPanel:Add("DButton")
		buttonAdd:SetSize(800, 75)
		buttonAdd:SetPos(100, offset + 35)
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
				draw.RoundedBox(0,0,h-1,w/4,1,Color(255, 165, 0,buttonAdd.alpha));
				draw.SimpleText(self.Text .. "     -     " .. self.Cost .. " T.", "marske5", 20, h/2, Color(255, 165, 0, buttonAdd.alpha), 0, 1);
				return;
			end
			
			draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 125));
			
			draw.SimpleText(self.Text .. "     -     " .. self.Cost .. " T.", "marske5", 20, h/2, Color(255, 255, 255, buttonAdd.alpha), 0, 1);
		end;
		buttonAdd.OnCursorEntered = function(self)
			if (self.disabled) then return false end
			self.hovered = true
			surface.PlaySound("garrysmod/ui_hover.wav")
		end
		buttonAdd.OnMousePressed = function(self)
			if (self.disabled) then return false end
			surface.PlaySound("garrysmod/ui_click.wav")
			-- frame:Close()
			
			net.Start("TradeNPC.GunDealer.Server")
			net.WriteInt(k,10)
			net.SendToServer()
		end
		buttonAdd.OnCursorExited = function(self)
			self.hovered = false
		end

		local itemModel = DScrollPanel:Add("DModelPanel")
		itemModel:SetSize(350,350)
		itemModel:SetFOV(45)
		itemModel:SetLookAt( Vector( 0, -10, 25 ) )
		itemModel:SetPos(400, offset - 260)
		itemModel:SetModel( v.ItemModel )
		function itemModel:LayoutEntity( Entity ) return end
		
		offset = offset + 150
	end

	offset = offset + categoryOffset
	displayCategory = true
	categoryOffset = 0
	for k,v in pairs(items_to_trade) do

		if v.ItemCategory != "Броня" then continue end
		
		if displayCategory then
			displayCategory = false
			categoryOffset = 100
			local categoryLabel = DScrollPanel:Add("DLabel")
			categoryLabel:SetSize(500,50)
			categoryLabel:SetPos(150, offset - 25)
			categoryLabel:SetText(v.ItemCategory)
			categoryLabel:SetFont("marske8")
		end

		local buttonAdd = DScrollPanel:Add("DButton")
		buttonAdd:SetSize(800, 75)
		buttonAdd:SetPos(100, offset + 35)
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
				draw.RoundedBox(0,0,h-1,w/4,1,Color(255, 165, 0,buttonAdd.alpha));
				draw.SimpleText(self.Text .. "     -     " .. self.Cost .. " T.", "marske5", 20, h/2, Color(255, 165, 0, buttonAdd.alpha), 0, 1);
				return;
			end
			
			draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 125));
			
			draw.SimpleText(self.Text .. "     -     " .. self.Cost .. " T.", "marske5", 20, h/2, Color(255, 255, 255, buttonAdd.alpha), 0, 1);
		end;
		buttonAdd.OnCursorEntered = function(self)
			if (self.disabled) then return false end
			self.hovered = true
			surface.PlaySound("garrysmod/ui_hover.wav")
		end
		buttonAdd.OnMousePressed = function(self)
			if (self.disabled) then return false end
			surface.PlaySound("garrysmod/ui_click.wav")
			-- frame:Close()
			
			net.Start("TradeNPC.GunDealer.Server")
			net.WriteInt(k,10)
			net.SendToServer()
		end
		buttonAdd.OnCursorExited = function(self)
			self.hovered = false
		end

		local itemModel = DScrollPanel:Add("DModelPanel")
		itemModel:SetSize(350,350)
		itemModel:SetFOV(45)
		itemModel:SetLookAt( Vector( 0, -10, 25 ) )
		itemModel:SetPos(400, offset - 260)
		itemModel:SetModel( v.ItemModel )
		function itemModel:LayoutEntity( Entity ) return end
		
		offset = offset + 150
	end
	
	offset = offset + categoryOffset
	displayCategory = true
	categoryOffset = 0
	for k,v in pairs(items_to_trade) do

		if v.ItemCategory != "Инструменты" then continue end

		if displayCategory then
			displayCategory = false
			categoryOffset = 100
			local categoryLabel = DScrollPanel:Add("DLabel")
			categoryLabel:SetSize(500,50)
			categoryLabel:SetPos(150, offset - 25)
			categoryLabel:SetText(v.ItemCategory)
			categoryLabel:SetFont("marske8")
		end

		local buttonAdd = DScrollPanel:Add("DButton")
		buttonAdd:SetSize(800, 75)
		buttonAdd:SetPos(100, offset + 35)
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
				draw.RoundedBox(0,0,h-1,w/4,1,Color(255, 165, 0,buttonAdd.alpha));
				draw.SimpleText(self.Text .. "     -     " .. self.Cost .. " T.", "marske5", 20, h/2, Color(255, 165, 0, buttonAdd.alpha), 0, 1);
				return;
			end
			
			draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 125));
			
			draw.SimpleText(self.Text .. "     -     " .. self.Cost .. " T.", "marske5", 20, h/2, Color(255, 255, 255, buttonAdd.alpha), 0, 1);
		end;
		buttonAdd.OnCursorEntered = function(self)
			if (self.disabled) then return false end
			self.hovered = true
			surface.PlaySound("garrysmod/ui_hover.wav")
		end
		buttonAdd.OnMousePressed = function(self)
			if (self.disabled) then return false end
			surface.PlaySound("garrysmod/ui_click.wav")
			-- frame:Close()
			
			net.Start("TradeNPC.GunDealer.Server")
			net.WriteInt(k,10)
			net.SendToServer()
		end
		buttonAdd.OnCursorExited = function(self)
			self.hovered = false
		end

		local itemModel = DScrollPanel:Add("DModelPanel")
		itemModel:SetSize(350,350)
		itemModel:SetFOV(45)
		itemModel:SetLookAt( Vector( 0, -10, 25 ) )
		itemModel:SetPos(400, offset - 260)
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
				
				draw.SimpleText("Инкогнито", "marske6", -20, -1100, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
				surface.SetDrawColor( 255, 255, 255, 50 )
				surface.DrawLine( -90, -1085, 50, -1085 )
				draw.SimpleText("Торговец оружием", "Trebuchet18", -20, -1075, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);

			cam.End3D2D();
		end
	end 
end 