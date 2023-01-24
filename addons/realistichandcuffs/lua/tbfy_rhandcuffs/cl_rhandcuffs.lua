-- "addons\\realistichandcuffs\\lua\\tbfy_rhandcuffs\\cl_rhandcuffs.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

local RHC_BoneManipulations = {
	["Cuffed"] = {
		["ValveBiped.Bip01_R_UpperArm"] = Angle(-28,18,-21),
		["ValveBiped.Bip01_L_Hand"] = Angle(0,0,119),
		["ValveBiped.Bip01_L_Forearm"] = Angle(15,20,40),
		["ValveBiped.Bip01_L_UpperArm"] = Angle(15, 26, 0),
		["ValveBiped.Bip01_R_Forearm"] = Angle(0,50,0),
		["ValveBiped.Bip01_R_Hand"] = Angle(45,34,-15),
		["ValveBiped.Bip01_L_Finger01"] = Angle(0,50,0),
		["ValveBiped.Bip01_R_Finger0"] = Angle(10,2,0),
		["ValveBiped.Bip01_R_Finger1"] = Angle(-10,0,0),
		["ValveBiped.Bip01_R_Finger11"] = Angle(0,-40,0),
		["ValveBiped.Bip01_R_Finger12"] = Angle(0,-30,0)
	},
	["HandsUp"] = {	
		["ValveBiped.Bip01_R_UpperArm"] = Angle(73,35,128),
		["ValveBiped.Bip01_L_Hand"] = Angle(-12,12,90),
		["ValveBiped.Bip01_L_Forearm"] = Angle(-28,-29,44),
		["ValveBiped.Bip01_R_Forearm"] = Angle(-22,1,15),
		["ValveBiped.Bip01_L_UpperArm"] = Angle(-77,-46,4),
		["ValveBiped.Bip01_R_Hand"] = Angle(33,39,-21),
		["ValveBiped.Bip01_L_Finger01"] = Angle(0,30,0),
		["ValveBiped.Bip01_L_Finger1"] = Angle(0,45,0),
		["ValveBiped.Bip01_L_Finger11"] = Angle(0,45,0),
		["ValveBiped.Bip01_L_Finger2"] = Angle(0,45,0),
		["ValveBiped.Bip01_L_Finger21"] = Angle(0,45,0),
		["ValveBiped.Bip01_L_Finger3"] = Angle(0,45,0),
		["ValveBiped.Bip01_L_Finger31"] = Angle(0,45,0),
		["ValveBiped.Bip01_R_Finger0"] = Angle(-10,0,0),
		["ValveBiped.Bip01_R_Finger11"] = Angle(0,30,0),
		["ValveBiped.Bip01_R_Finger2"] = Angle(20,25,0),
		["ValveBiped.Bip01_R_Finger21"] = Angle(0,45,0),
		["ValveBiped.Bip01_R_Finger3"] = Angle(20,35,0),
		["ValveBiped.Bip01_R_Finger31"] = Angle(0,45,0)
	}
}

net.Receive("rhc_bonemanipulate", function()
	local Player, Type, Reset = net.ReadEntity(), net.ReadString(), net.ReadBool()
	
	for k,v in pairs(RHC_BoneManipulations[Type]) do
		local Bone = Player:LookupBone(k)
		if Bone then
			if Reset then
				Player:ManipulateBoneAngles(Bone, Angle(0,0,0))
			else
				Player:ManipulateBoneAngles(Bone, v)			
			end
		end
	end
	if RHandcuffsConfig.DisablePlayerShadow then
		Player:DrawShadow(false)
	end	
end)

local PLAYER = FindMetaTable("Player")
//Whacky way to add text without overriding the function completely
hook.Add("loadCustomDarkRPItems", "rhc_set_drawPINFO", function()
	local OldDrawPlayerInfo = PLAYER.drawPlayerInfo
	function RHC_AddInCuffs(self)
		if RHandcuffsConfig.DisplayOverheadCuffed and self:GetNWBool("rhc_cuffed", false) then
			local pos = self:EyePos()

			pos.z = pos.z + 10
			pos = pos:ToScreen()
			if not self:getDarkRPVar("wanted") then
				pos.y = pos.y - 50
			end
			
			draw.DrawNonParsedText("Handcuffed", "DarkRPHUD2", pos.x + 1, pos.y - 19, Color(0,0,0,255), 1)
			draw.DrawNonParsedText("Handcuffed", "DarkRPHUD2", pos.x, pos.y - 20, Color(255,255,255,255) , 1)
		end
		OldDrawPlayerInfo(self)
	end
	PLAYER.drawPlayerInfo = RHC_AddInCuffs
end)
	
local RHC_ChatOpen = false
hook.Add("StartChat", "RHC_OnChatOpen", function()
	RHC_ChatOpen = true
end)

hook.Add("FinishChat", "RHC_OnChatOpen", function()
	RHC_ChatOpen = false
end)

net.Receive("rhc_send_inspect_information", function()
	local Player, WepTbl = net.ReadEntity(), net.ReadTable()
	
	local InsMenu = vgui.Create("rhc_inspect_menu")
	InsMenu:SetupInfo(Player, WepTbl)
	LocalPlayer().LastInspect = Player
end)

surface.CreateFont( "rhc_inspect_headline", {
	font = "Arial",
	size = 20,
	weight = 1000,
	antialias = true,
})

surface.CreateFont( "rhc_inspect_information", {
	font = "Arial",
	size = 20,
	weight = 100,
	antialias = true,
})

surface.CreateFont( "rhc_inspect_confiscate_weapon", {
	font = "Arial",
	size = 11,
	weight = 1000,
	antialias = true,
})

surface.CreateFont( "rhc_inspect_stealmoney", {
	font = "Arial",
	size = 14,
	weight = 1000,
	antialias = true,
})

surface.CreateFont( "rhc_inspect_weaponname", {
	font = "Arial",
	size = 14,
	weight = 100,
	antialias = true,
})

local MainPanelColor = Color(255,255,255,200)
local HeaderColor = Color(0,71,130,255)
local SecondPanelColor = Color(215,215,220,255)
local ButtonColor = Color(50,50,50,255)
local ButtonColorHovering = Color(0,71,130,200)
local ButtonColorPressed = Color(150,150,150,200)
local ButtonOutline = Color(0,0,0,200)

local PANEL = {}

function PANEL:Init()
	self.ButtonText = ""
	self.BColor = ButtonColor
	self.Font = "rhc_inspect_headline"	
	self:SetText("")
end

function PANEL:UpdateColours()

	if self:IsDown() or self.m_bSelected then self.BColor = ButtonColorPressed return end
	if self.Hovered and !self:GetDisabled() then self.BColor = ButtonColorHovering return end

	self.BColor = ButtonColor
	return
end

function PANEL:SetBText(Text)
	self.ButtonText = Text
end

function PANEL:SetBFont(Font)
	self.Font = Font
end

function PANEL:Paint(W,H)
	draw.RoundedBox(4, 0, 0, W, H, self.BColor)
	draw.SimpleText(self.ButtonText, self.Font, W/2, H/2, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )   
end
vgui.Register( "rhc_inspect_button", PANEL, "DButton")

local PANEL = {}

function PANEL:Init()
	self.Name = ""
	self.WID = 0
	
	self.ConfisItem = vgui.Create("rhc_inspect_button", self)
	self.ConfisItem:SetBText("CONFISCATE")
	self.ConfisItem:SetBFont("rhc_inspect_confiscate_weapon")
	self.ConfisItem.DoClick = function() net.Start("rhc_confiscate_weapon") net.WriteEntity(LocalPlayer().LastInspect) net.WriteFloat(self.WID) net.SendToServer() self:Remove() end
	
	self.WModel = vgui.Create( "ModelImage", self )
end

function PANEL:Paint(W,H)
	draw.SimpleText(self.Name, "rhc_inspect_weaponname", W/2, 0, Color(0,0,0,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )  
end

function PANEL:PerformLayout(W,H)	
	self.ConfisItem:SetPos(2.5,H-20)
	self.ConfisItem:SetSize(W-5,15)
	
	self.WModel:SetPos(2.5,10)
    self.WModel:SetSize(W-15,W-15)	
end

function PANEL:SetInfo(Wep, ID)
	local SWEPTable = weapons.GetStored(Wep)
	if SWEPTable.WorldModel then
		self.WModel:SetModel(SWEPTable.WorldModel)
	end
	self.Name = SWEPTable.PrintName
	self.WID = ID
end
vgui.Register( "rhc_weapon", PANEL)

local PANEL = {}

function PANEL:Init()	
	self:ShowCloseButton(false)
	self:SetTitle("")   
	self:MakePopup()
	
	self.Name = "INVALID"
	self.Job = "INVALID"
	self.SteamID = "INVALID"
	self.Wallet = 0
	self.WepItems = {}

    self.TopDPanel = vgui.Create("DPanel", self)
	self.TopDPanel.Paint = function(selfp, W,H)
		draw.RoundedBoxEx(8, 0, 0, W, H, HeaderColor, true, true, false, false)	
		draw.SimpleText("Inspecting: " .. self.Name, "rhc_inspect_headline", W/2, H/2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )			
	end	
	
    self.InfoDPanel = vgui.Create("DPanel", self)
	self.InfoDPanel.Paint = function(selfp, W,H) 
		draw.RoundedBoxEx(8, 0, 0, W, H, SecondPanelColor, false, false, true, true)
		local TW, TH = surface.GetTextSize("Name: ")
		draw.SimpleText("Name:", "rhc_inspect_headline", 5, 10, Color(0,0,0,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		draw.SimpleText(self.Name, "rhc_inspect_information", 5+TW, 10, Color(0,0,0,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		TW, TH = surface.GetTextSize("SteamID: ")
		draw.SimpleText("SteamID:", "rhc_inspect_headline", 5, 25, Color(0,0,0,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		draw.SimpleText(self.SteamID, "rhc_inspect_information", 5 + TW, 25, Color(0,0,0,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		TW, TH = surface.GetTextSize("Job: ")
		draw.SimpleText("Job:", "rhc_inspect_headline", 5, 40, Color(0,0,0,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		draw.SimpleText(self.Job, "rhc_inspect_information", 5 + TW, 40, Color(0,0,0,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )		
		TW, TH = surface.GetTextSize("Wallet: ")
		draw.SimpleText("Wallet:", "rhc_inspect_headline", 5, 55, Color(0,0,0,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		draw.SimpleText(self.Wallet, "rhc_inspect_information", 5 + TW, 55, Color(0,0,0,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
	end		
	
    self.WeaponHeader = vgui.Create("DPanel", self)
	self.WeaponHeader.Paint = function(selfp, W,H) 
		draw.RoundedBoxEx(8, 0, 0, W, H, HeaderColor, true, true, false, false)	
		draw.SimpleText("Weapon List", "rhc_inspect_headline", W/2, H/2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )			
	end		

	self.WeaponList = vgui.Create("DScrollPanel", self)
	self.WeaponList.Paint = function(selfp, W, H)
		draw.RoundedBoxEx(4, 0, 0, W-15, H, SecondPanelColor, false, false, true, true)
	end	
	
	self.WeaponList.VBar.Paint = function() end
	self.WeaponList.VBar.btnUp.Paint = function() end
    self.WeaponList.VBar.btnDown.Paint = function() end	
	self.WeaponList.VBar.btnGrip.Paint = function() end		
	
	self.CloseButton = vgui.Create("rhc_inspect_button", self)
	self.CloseButton:SetBText("X")
	self.CloseButton.DoClick = function() self:Remove() end		
end

function PANEL:SetupInfo(Player, WepTbl)
	self.Name = Player:Nick()
	self.Job = Player:getDarkRPVar("job")
	self.SteamID = Player:SteamID()
	self.Wallet = DarkRP.formatMoney(Player:getDarkRPVar("money"))
	
	for k,v in pairs(WepTbl) do
		if !RHandcuffsConfig.BlackListedWeapons[v] then
			local Wep = vgui.Create("rhc_weapon", self.WeaponList)
			Wep:SetInfo(v, k)
			
			self.WepItems[k] = Wep
		end
	end
end

local TopH = 25
local InfoH =75
local WeaponH = 25
local WeaponListH = 180
function PANEL:Paint(W,H)
	draw.RoundedBoxEx(8, 0, TopH, W, H-TopH, MainPanelColor,false,false,true,true)	
end

local WepsPerLine = 4
local Width, Height, Padding = 300, 330, 5
function PANEL:PerformLayout()	
	self:SetPos(ScrW()/2-Width/2, ScrH()/2-Height/2)
	self:SetSize(Width, TopH+InfoH+WeaponH+WeaponListH)
	
    self.TopDPanel:SetPos(0,0)
	self.TopDPanel:SetSize(Width,TopH)	
	
    self.InfoDPanel:SetPos(Padding,TopH+Padding)
	self.InfoDPanel:SetSize(Width-Padding*2,InfoH-Padding*2)	

    self.WeaponHeader:SetPos(Padding,TopH+InfoH)
	self.WeaponHeader:SetSize(Width-Padding*2,WeaponH)	
	
	self.WeaponList:SetPos(Padding,TopH+InfoH+WeaponH)
	self.WeaponList:SetSize(Width+Padding, WeaponListH-Padding)
	
	local WAvailable = self.WeaponList:GetWide()-15
	local WepWSize = WAvailable/WepsPerLine
	
	local NumSlots = 0
	local CRow = 0
	for k,v in pairs(self.WepItems) do
		if IsValid(v) then
			if NumSlots >= WepsPerLine then
				NumSlots = 0
				CRow = CRow + 1
			end
			v:SetPos(WepWSize*(NumSlots),CRow*(WepWSize+15))
			v:SetSize(WepWSize,WepWSize+15)
			NumSlots = NumSlots + 1
		end
	end		
	
	self.CloseButton:SetPos(Width-TopH,TopH/2-9)
	self.CloseButton:SetSize(20, 20)	
end
vgui.Register("rhc_inspect_menu", PANEL, "DFrame")