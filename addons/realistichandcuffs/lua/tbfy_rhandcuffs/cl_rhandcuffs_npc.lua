-- "addons\\realistichandcuffs\\lua\\tbfy_rhandcuffs\\cl_rhandcuffs_npc.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

net.Receive("RHC_Jailer_Menu", function()
	local PlayerToJail = net.ReadEntity()

	local JailerMenu = vgui.Create("rhc_jailernpc_menu")
	JailerMenu:SetAPlayer(PlayerToJail)
end)

net.Receive("RHC_Bailer_Menu", function()
	vgui.Create("rhc_bailernpc_menu")
end)

net.Receive("rhc_sendjailtime", function()
	local Player, Arrester, Time = net.ReadEntity(), net.ReadString(), net.ReadFloat()
	
	Player.HCArrestedBy = Arrester
	Player.ArrestTime = Time
end)

surface.CreateFont( "rhc_bailer_pheader", {
	font = "trebuchet18",
	size = 12,
	weight = 1000,
	antialias = true,
})

surface.CreateFont( "rhc_npc_text", {
	font = "Verdana",
	size = 50,
	weight = 500,
	antialias = true,
})

local MainPanelColor = Color(50,50,50,200)
local MainPanelOutline = Color(0,0,0,200)
local HeaderH = 25
local HeaderColor = Color(0,0,0,200)
local HeaderOutline = Color(0,0,0,200)
local ButtonColor = Color(50,50,50,200)
local ButtonColorHovering = Color(75,75,75,200)
local ButtonColorPressed = Color(150,150,150,200)
local ButtonOutline = Color(0,0,0,200)
local BailerPlayerColor = Color(35,35,35,255)

local PANEL = {}

function PANEL:Init()
	self.ButtonText = ""
	self.BColor = ButtonColor
	self:SetText("")
end

function PANEL:UpdateColours()

	if self:IsDown() or self.m_bSelected then self.BColor = ButtonColorPressed return end
	if self.Hovered then self.BColor = ButtonColorHovering return end

	self.BColor = ButtonColor
	return
end

function PANEL:SetBText(Text)
	self.ButtonText = Text
end

function PANEL:Paint(W,H)
	surface.SetDrawColor(self.BColor)
	surface.DrawRect( 0, 0, W, H)
	surface.SetDrawColor(ButtonOutline)
	surface.DrawOutlinedRect( 0, 0, W, H ) 
	draw.SimpleText(self.ButtonText, "Trebuchet18", W/2, H/2, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )   
end
vgui.Register( "rhc_button", PANEL, "DButton")

local PANEL = {}

function PANEL:Init()	
	self:ShowCloseButton(false)
	self:SetTitle("")   
	self:MakePopup()
	self.JailNick = "Приведите подозреваемого"
	
    self.TopDPanel = vgui.Create("DPanel", self)
	self.TopDPanel.Paint = function(selfp, W,H) 
		surface.SetDrawColor(HeaderColor)
		surface.DrawRect( 0, 0, W, H)
		surface.SetDrawColor(HeaderOutline)
		surface.DrawOutlinedRect( 0, 0, W, H )
		draw.SimpleText("Тюремщик", "Trebuchet18", W/2, H/2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )		
	end	

	self.JailSlider = vgui.Create( "DNumSlider", self )
	self.JailSlider:SetText("Кол-во циклов:")
	self.JailSlider:SetMin(1)
	self.JailSlider:SetMax(RHandcuffsConfig.MaxJailYears)
	self.JailSlider:SetDecimals(0)	
	self.JailSlider:SetValue(1)	
	self.JailSlider.Scratch.OnMousePressed = function() end
	self.JailSlider.Scratch.OnMouseReleased = function() end
	self.JailSlider.Scratch:SetCursor("none")

	self.JailButton = vgui.Create("rhc_button", self)
	self.JailButton:SetBText("Посадить")
	
	
	self.JailButton.DoClick = function() net.Start("RHC_jail_player") net.WriteEntity(self.APlayer) net.WriteFloat(math.Clamp(self.JailSlider:GetValue(), 1, RHandcuffsConfig.MaxJailYears)) net.WriteString(math.Clamp(self.JailSlider:GetValue(), 1, RHandcuffsConfig.MaxJailYears)) net.SendToServer() self:Remove() end		
	
	self.JailReason = vgui.Create("DTextEntry", self)	
	
	self.CloseButton = vgui.Create("rhc_button", self)
	self.CloseButton:SetBText("X")
	self.CloseButton.DoClick = function() self:Remove() end	
end

function PANEL:SetAPlayer(Player)
	if !IsValid(Player) and !Player:IsPlayer() then return end
	self.JailNick = "Player: " .. Player:Nick()
	self.APlayer = Player
end

function PANEL:Paint(W,H)
    surface.SetDrawColor(MainPanelColor)
	surface.DrawRect( 0, 0, W, H)
	surface.SetDrawColor(MainPanelOutline)
	surface.DrawOutlinedRect( 0, 0, W, H )
	
	draw.SimpleText(self.JailNick, "Trebuchet18", W/2, HeaderH+5, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	draw.SimpleText("Причина:", "Trebuchet18", 5, HeaderH+55, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
end

local Width, Height = 200, 140
function PANEL:PerformLayout()
	self:SetPos(ScrW()/2-Width/2, ScrH()/2-Height/2)
	self:SetSize(Width, Height)
	
    self.TopDPanel:SetPos(0,0)
	self.TopDPanel:SetSize(Width,HeaderH+2)	

	self.JailSlider:SetPos(5,HeaderH+25)
	self.JailSlider:SetSize(Width-10,25)
	
	self.JailReason:SetPos(70, HeaderH+55)
	self.JailReason:SetSize(Width-80, 20)
	
	self.JailButton:SetPos(Width/2-37.5,Height-30)
	self.JailButton:SetSize(75,25)	
	
	self.CloseButton:SetPos(Width-HeaderH/2-7.5,HeaderH/2-7.5)
	self.CloseButton:SetSize(15, 15)	
end

vgui.Register("rhc_jailernpc_menu", PANEL, "DFrame")

local PANEL = {}

function PANEL:Init()	
	self.BailNick = ""
	self.Time = 0
	self.BailPrice = 0
	self.BailPlayer = nil
	self.ArrestedBy = ""
	
	self.Avatar = vgui.Create("AvatarImage", self)

	self.BailPButton = vgui.Create("rhc_button", self)
	self.BailPButton:SetBText("Bail Player")	
	self.BailPButton.DoClick = function()
		if !LocalPlayer():canAfford(self.BailPrice) then LocalPlayer():ChatPrint("You can't afford that!") return end
		net.Start("RHC_bail_player")
			net.WriteEntity(self.BailPlayer)
		net.SendToServer()
		
		local MainP = self.MainPanel
		MainP.BailPlayers[self.TID] = nil
		self:Remove()
		MainP:PerformLayout()		
	end
end

function PANEL:SetBailPlayer(Player)
	self.BailPlayer = Player
	self.BailNick = Player:Nick()
	if Player.ArrestTime and Player.HCArrestedBy then
		local Time = Player.ArrestTime/60
		self.Time = Time
		self.ArrestedBy  = Player.HCArrestedBy
		self.BailPrice = Time*RHandcuffsConfig.BailPricePerYear
	end
	self.Avatar:SetPlayer(Player, 128)		
end

function PANEL:Paint(W,H)
    surface.SetDrawColor(BailerPlayerColor)
	surface.DrawRect( 0, 0, W, H)
	surface.SetDrawColor(HeaderOutline)
	surface.DrawOutlinedRect( 0, 0, W, H )
	
	draw.SimpleText(self.BailNick, "rhc_bailer_pheader", W/2, 0, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP ) 
	
	local TextStartW = H
	
	draw.SimpleText("Arrested by: " .. self.ArrestedBy, "Trebuchet18", TextStartW, 30, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP ) 
	draw.SimpleText("Jail Time: " .. self.Time .. " years", "Trebuchet18", TextStartW, 45, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP ) 
	draw.SimpleText("Bail Price: $" .. self.BailPrice, "Trebuchet18", TextStartW, 60, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP ) 
end

function PANEL:PerformLayout(W,H)
	self.BailPButton:SetPos(W-105, H-30)
	self.BailPButton:SetSize(100,25)
	
	local AH = H - 10
	self.Avatar:SetPos(5,5)
	self.Avatar:SetSize(AH,AH)	
end

vgui.Register("rhc_bailernpc_player", PANEL)

local PANEL = {}

function PANEL:Init()	
	self:ShowCloseButton(false)
	self:SetTitle("")   
	self:MakePopup()
	
    self.TopDPanel = vgui.Create("DPanel", self)
	self.TopDPanel.Paint = function(selfp, W,H) 
		surface.SetDrawColor(HeaderColor)
		surface.DrawRect( 0, 0, W, H)
		surface.SetDrawColor(HeaderOutline)
		surface.DrawOutlinedRect( 0, 0, W, H )
		draw.SimpleText("Bailer NPC", "Trebuchet18", W/2, H/2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )		
	end	

	self.BailerList = vgui.Create("DScrollPanel", self)
	self.BailerList.Paint = function(selfp, W, H)
	end
	
	self.BailerList.VBar.Paint = function() end
	self.BailerList.VBar.btnUp.Paint = function() end
    self.BailerList.VBar.btnDown.Paint = function() end	
	self.BailerList.VBar.btnGrip.Paint = function() end		
	
	self.BailPlayers = {}
	for k,v in pairs(player.GetAll()) do
		if v:isArrested() then
			local BailP = vgui.Create("rhc_bailernpc_player", self.BailerList)
			BailP:SetBailPlayer(v)
			BailP.MainPanel = self
			BailP.TID = k
			self.BailPlayers[k] = BailP
		end	
	end
	
	self.CloseButton = vgui.Create("rhc_button", self)
	self.CloseButton:SetBText("X")
	self.CloseButton.DoClick = function() self:Remove() end	
end

function PANEL:Paint(W,H)
    surface.SetDrawColor(MainPanelColor)
	surface.DrawRect( 0, 0, W, H)
	surface.SetDrawColor(MainPanelOutline)
	surface.DrawOutlinedRect( 0, 0, W, H )
end

local Width, Height = 350, 392
function PANEL:PerformLayout()
	self:SetPos(ScrW()/2-Width/2, ScrH()/2-Height/2)
	self:SetSize(Width, Height)
	
	local HeaderH = 25	
	
    self.TopDPanel:SetPos(0,0)
	self.TopDPanel:SetSize(Width,HeaderH+2)	
	
	self.BailerList:SetPos(5,HeaderH+5)
	self.BailerList:SetSize(Width+5, Height-HeaderH-10)
	
	local BW = self.BailerList:GetWide()-15
	local SBH = 0
	for k,v in pairs(self.BailPlayers) do
		v:SetPos(0,SBH)
		v:SetSize(BW,90)
		SBH = SBH + 89
	end
	
	self.CloseButton:SetPos(Width-HeaderH/2-7.5,HeaderH/2-7.5)
	self.CloseButton:SetSize(15, 15)	
end

vgui.Register("rhc_bailernpc_menu", PANEL, "DFrame")