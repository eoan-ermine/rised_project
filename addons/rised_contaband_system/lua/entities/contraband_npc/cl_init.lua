-- "addons\\rised_contaband_system\\lua\\entities\\contraband_npc\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

net.Receive("ContrabandNPC.OpenMenu", function()
	ContrabandMenuOpen()
end)

function ContrabandMenuOpen()
	local frame = vgui.Create("DFrame") 
	frame:SetPos(0,0)
	frame:SetSize(ScrW(),1920)
	frame:SetTitle("")
	frame:Center()
	frame:SetDraggable(false)
	frame:ShowCloseButton(false)
	frame:SetBackgroundBlur(false)
	frame:MakePopup()
	frame.startTime = SysTime()
	frame.Paint = function(self, w, h)
		Derma_DrawBackgroundBlur(self, self.startTime)

		draw.SimpleText("Митчел Брейкстоун", "marske6", w/2, ScrH()/10, Color(255, 255, 255, 255), 1, 2)
		draw.RoundedBox(0, w/2 - 150, ScrH()/10 + 35, 300, 1, Color(255, 255, 255, 255));
		draw.SimpleText("Контрабанда", "marske5", w/4, ScrH()/10 + 125, Color(255, 195, 87, 255), 0, 2)
		
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

	local i1 = GetGlobalInt("Contraband_Item_01")
	local i2 = GetGlobalInt("Contraband_Item_02")
	local i3 = GetGlobalInt("Contraband_Item_03")
	local i4 = GetGlobalInt("Contraband_Item_04")
	local i5 = GetGlobalInt("Contraband_Item_05")

	items_to_trade[1] = RISED.Config.Trade.Contraband.Items[GetGlobalInt("Contraband_Item_1")]
	items_to_trade[2] = RISED.Config.Trade.Contraband.Items[GetGlobalInt("Contraband_Item_2")]
	items_to_trade[3] = RISED.Config.Trade.Contraband.Items[GetGlobalInt("Contraband_Item_3")]
	items_to_trade[4] = RISED.Config.Trade.Contraband.Items[GetGlobalInt("Contraband_Item_4")]
	items_to_trade[5] = RISED.Config.Trade.Contraband.Items[GetGlobalInt("Contraband_Item_5")]
	items_to_trade[6] = RISED.Config.Trade.Contraband.Items[GetGlobalInt("Contraband_Item_6")]
	items_to_trade[7] = RISED.Config.Trade.Contraband.Items[GetGlobalInt("Contraband_Item_7")]
	items_to_trade[8] = RISED.Config.Trade.Contraband.Items[GetGlobalInt("Contraband_Item_8")]
	items_to_trade[9] = RISED.Config.Trade.Contraband.Items[GetGlobalInt("Contraband_Item_9")]
	items_to_trade[10] = RISED.Config.Trade.Contraband.Items[GetGlobalInt("Contraband_Item_10")]
	items_to_trade[11] = RISED.Config.Trade.Contraband.Items[GetGlobalInt("Contraband_Item_11")]
	items_to_trade[12] = RISED.Config.Trade.Contraband.Items[GetGlobalInt("Contraband_Item_12")]
	items_to_trade[13] = RISED.Config.Trade.Contraband.Items[GetGlobalInt("Contraband_Item_13")]
	items_to_trade[14] = RISED.Config.Trade.Contraband.Items[GetGlobalInt("Contraband_Item_14")]
	items_to_trade[15] = RISED.Config.Trade.Contraband.Items[GetGlobalInt("Contraband_Item_15")]
	items_to_trade[16] = RISED.Config.Trade.Contraband.Items[GetGlobalInt("Contraband_Item_16")]
	items_to_trade[17] = RISED.Config.Trade.Contraband.Items[GetGlobalInt("Contraband_Item_17")]
	items_to_trade[18] = RISED.Config.Trade.Contraband.Items[GetGlobalInt("Contraband_Item_18")]
	items_to_trade[19] = RISED.Config.Trade.Contraband.Items[GetGlobalInt("Contraband_Item_19")]
	items_to_trade[20] = RISED.Config.Trade.Contraband.Items[GetGlobalInt("Contraband_Item_20")]
	items_to_trade[21] = RISED.Config.Trade.Contraband.Items[GetGlobalInt("Contraband_Item_21")]
	items_to_trade[22] = RISED.Config.Trade.Contraband.Items[GetGlobalInt("Contraband_Item_22")]
	items_to_trade[23] = RISED.Config.Trade.Contraband.Items[GetGlobalInt("Contraband_Item_23")]
	items_to_trade[24] = RISED.Config.Trade.Contraband.Items[GetGlobalInt("Contraband_Item_24")]
	items_to_trade[25] = RISED.Config.Trade.Contraband.Items[GetGlobalInt("Contraband_Item_25")]
	
	local DScrollPanel = vgui.Create( "DScrollPanel", frame )
	DScrollPanel:SetSize(800,400)
	DScrollPanel:SetPos(500,350)
	
	local sbar = DScrollPanel:GetVBar()
	function sbar:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	function sbar.btnUp:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 15))
	end
	function sbar.btnDown:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 15))
	end
	function sbar.btnGrip:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 15))
	end
	
	local offset = 15
	for k,v in pairs(items_to_trade) do
		
		local buttonAdd = DScrollPanel:Add("DButton")
		buttonAdd:SetSize(800, 25)
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
				draw.RoundedBox(0,0,h-1,w,1,Color(145,145,145,buttonAdd.alpha));
				draw.SimpleText(self.Text .. "     -     " .. self.Cost .. " T.", "marske5", 0, h/2, Color(145,145,145,buttonAdd.alpha), 0, 1);
				return;
			end
			if (self.hovered) then
				draw.RoundedBox(0,0,h-1,w/2,1,Color(255, 195, 87,buttonAdd.alpha));
				draw.SimpleText(self.Text .. "     -     " .. self.Cost .. " T.", "marske5", 0, h/2, Color(255, 195, 87,buttonAdd.alpha), 0, 1);
				return;
			end
			
			draw.RoundedBox(0,0,h-1,w/2.7,1,Color(255, 255, 255,buttonAdd.alpha));
			draw.SimpleText(self.Text .. "     -     " .. self.Cost .. " T.", "marske5", 0, h/2, Color(255, 255, 255,buttonAdd.alpha), 0, 1);
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
			
			net.Start("ContrabandNPC.Server")
			net.WriteInt(1,10)
			net.WriteInt(k,10)
			net.SendToServer()
		end
		buttonAdd.OnCursorExited = function(self)
			self.hovered = false
		end
		
		offset = offset + 64
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
				
				draw.SimpleText("Митчел Брейкстоун", "marske6", -20, -1100, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
				surface.SetDrawColor( 255, 255, 255, 50 )
				surface.DrawLine( -90, -1085, 50, -1085 )
				draw.SimpleText("Контрабандист", "Trebuchet18", -20, -1075, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);

			cam.End3D2D();
		end
	end 
end 