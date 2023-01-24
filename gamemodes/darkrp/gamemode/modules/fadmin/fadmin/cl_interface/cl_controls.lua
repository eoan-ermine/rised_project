-- "gamemodes\\darkrp\\gamemode\\modules\\fadmin\\fadmin\\cl_interface\\cl_controls.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
FAdmin.PlayerIcon = {}
FAdmin.PlayerIcon.RightClickOptions = {}

function FAdmin.PlayerIcon.AddRightClickOption(name, func)
    FAdmin.PlayerIcon.RightClickOptions[name] = func
end

-- FAdminPanelList
local PANEL = {}

function PANEL:Init()
    self.Padding = 5
end

local timecolor = Color(150, 150, 150, 255)
local timetext = "Только пришел"
local timecolortext = Color(255, 255, 255, 255)
local function cattext(ply)
	
	-- Игроки --
	/*
	if ply:GetUTimeTotalTime() > 252000 then
		timecolor = Color(80, 0, 0, 255)
		timetext = "Ветеран"
		timecolortext = Color(255, 255, 255, 255)
	elseif ply:GetUTimeTotalTime() > 180000 then
		timecolor = Color(150, 0, 0, 255)
		timetext = "Мастер"
		timecolortext = Color(255, 255, 255, 255)
	elseif ply:GetUTimeTotalTime() > 108000 then
		timecolor = Color(255, 0, 0, 255)
		timetext = "Опытный"
		timecolortext = Color(255, 255, 255, 255)
	elseif ply:GetUTimeTotalTime() > 36000 then
		timecolor = Color(0, 0, 117, 255)
		timetext = "Бывалый"
		timecolortext = Color(255, 255, 255, 255)
	elseif ply:GetUTimeTotalTime() > 18000 then
		timecolor = Color(100, 100, 255, 255)
		timetext = "Местный"
		timecolortext = Color(255, 255, 255, 255)
	elseif ply:GetUTimeTotalTime() > 0 then
		timecolor = Color(205, 205, 255, 255)
		timetext = "Новичок"
		timecolortext = Color(255, 255, 255, 255)
	end
	*/
	
		timecolor = Color(135, 135, 135, 255)
		timetext = "Игрок"
		timecolortext = Color(255, 255, 255, 255)
	
	-- Администрация --
	if ply:GetNWString("usergroup") == "inf_moderator" or ply:GetNWString("usergroup") == "sup_moderator" then
		timecolor = Color(155, 155, 155, 255)
		timetext = "Модер"
		timecolortext = Color(0, 0, 0, 255)
	elseif ply:GetNWString("usergroup") == "administrator_I" or ply:GetNWString("usergroup") == "administrator_II" or ply:GetNWString("usergroup") == "administrator_III" then
		timecolor = Color(175, 175, 175, 255)
		timetext = "Админ"
		timecolortext = Color(0, 0, 0, 255)
	elseif ply:GetNWString("usergroup") == "rec_eventer" or ply:GetNWString("usergroup") == "inf_eventer" or ply:GetNWString("usergroup") == "sup_eventer" then
		timecolor = Color(195, 195, 195, 255)
		timetext = "Мейстер"
		timecolortext = Color(0, 0, 0, 255)
	elseif ply:GetNWString("usergroup") == "retinue" then
		timecolor = Color(215, 215, 215, 255)
		timetext = "Свита"
		timecolortext = Color(0, 0, 0, 255)
	elseif ply:GetNWString("usergroup") == "hand" then
		timecolor = Color(235, 235, 235, 255)
		timetext = "Десница"
		timecolortext = Color(0, 0, 0, 255)
	elseif ply:GetNWString("usergroup") == "superadmin" and ply:SteamID() == "STEAM_0:1:38606392" then
		timecolor = Color(255, 255, 255, 255)
		timetext = "Создатель"
		timecolortext = Color(0, 0, 0, 255)
	elseif ply:GetNWString("usergroup") == "superadmin" then
		timecolor = Color(255, 255, 255, 255)
		timetext = "Десница"
		timecolortext = Color(0, 0, 0, 255)
	end
	-- Персональные статусы --
	--if ply:SteamID() == "STEAM_0:1:38606392" then
		--timecolor = Color(255, 215, 0, 255)
		--timetext = "Легенда"
		--timecolortext = Color(255, 255, 255, 255)
	if ply:SteamID() == "STEAM_0:0:155388946" then
		timecolor = Color(0, 0, 0, 255)
		timetext = "Инферно"
		timecolortext = Color(255, 0, 0, 255)
	elseif ply:GetNWString("usergroup") == "vip" then
		timecolor = Color(55, 255, 0, 255)
		timetext = "ViP"
		timecolortext = Color(0, 0, 0, 255)
	elseif ply:GetNWString("usergroup") == "mecenat" then
		timecolor = Color(150, 0, 0, 255)
		timetext = "<<< Меценат >>>"
		timecolortext = Color(255, 255, 255, 255)
	end
	
end

function PANEL:SizeToContents()
    local w, h = self:GetSize()

    -- Fix size of w to have the same size as the scoreboard
    w = math.Clamp(w, ScrW() * 0.9, ScrW() * 0.9)
    h = math.Min(h, ScrH() * 0.95)

    -- It fucks up when there's only one icon in
    if #self:GetChildren() == 1 then
        h = math.Max(0, 120)
    end

    self:SetSize(w, h)
    self:PerformLayout()
end

function PANEL:Paint()
end

derma.DefineControl("FAdminPanelList", "DPanellist adapted for FAdmin", PANEL, "DPanelList")

-- FAdminPlayerCatagoryHeader
local PANEL2 = {}

function PANEL2:PerformLayout()
    self:SetFont("Trebuchet24")
end

derma.DefineControl("FAdminPlayerCatagoryHeader", "DCatagoryCollapse header adapted for FAdmin", PANEL2, "DCategoryHeader")

-- FAdminPlayerCatagory
local PANEL3 = {}

function PANEL3:Init()
    if self.Header then
        self.Header:Remove() -- the old header is still there don't ask me why
    end
    self.Header = vgui.Create("FAdminPlayerCatagoryHeader", self)
    self.Header:SetSize(20, 25)
    self:SetPadding(5)
    self.Header:Dock( TOP )

    self:SetExpanded(true)
    self:SetMouseInputEnabled(true)

    self:SetAnimTime(0.2)
    self.animSlide = Derma_Anim("Anim", self, self.AnimSlide)

    self:SetPaintBackgroundEnabled(true)

end

function PANEL3:Paint()
    if self.CatagoryColor then
        draw.RoundedBox(4, 0, 0, self:GetWide(), self.Header:GetTall(), self.CatagoryColor)
    end
end

derma.DefineControl("FAdminPlayerCatagory", "DCatagoryCollapse adapted for FAdmin", PANEL3, "DCollapsibleCategory")

-- FAdmin player row (from the sandbox player row)
PANEL = {}

local PlayerRowSize = CreateClientConVar("FAdmin_PlayerRowSize", 30, true, false)
function PANEL:Init()
    self.Size = PlayerRowSize:GetInt()

    self.lblName    = vgui.Create("DLabel", self)
    self.lblFrags   = vgui.Create("DLabel", self)
    self.lblTeam    = vgui.Create("DLabel", self)
    self.lblDeaths  = vgui.Create("DLabel", self)
    self.lblPing    = vgui.Create("DLabel", self)
    self.lblWanted  = vgui.Create("DLabel", self)

    -- If you don't do this it'll block your clicks
    self.lblName:SetMouseInputEnabled(false)
    self.lblTeam:SetMouseInputEnabled(false)
    self.lblFrags:SetMouseInputEnabled(false)
    self.lblDeaths:SetMouseInputEnabled(false)
    self.lblPing:SetMouseInputEnabled(false)
    self.lblWanted:SetMouseInputEnabled(false)

    self.lblName:SetColor(Color(255,255,255,200))
    self.lblTeam:SetColor(Color(255,255,255,200))
    self.lblFrags:SetColor(Color(255,255,255,200))
    self.lblDeaths:SetColor(Color(255,255,255,200))
    self.lblPing:SetColor(Color(255,255,255,200))
    self.lblWanted:SetColor(Color(255,255,255,200))

    self.imgAvatar = vgui.Create("AvatarImage", self)

    self:SetCursor("hand")
end

function PANEL:Paint()
    if not IsValid(self.Player) then return end
	cattext(self.Player)
    self.Size = PlayerRowSize:GetInt()
    self.imgAvatar:SetSize(self.Size - 4, self.Size - 4)

    local color = Color(100, 150, 245, 255)


    if GAMEMODE.Name == "Sandbox" then
        color = Color(100, 150, 245, 255)
        if self.Player:Team() == TEAM_CONNECTING then
            color = Color(200, 120, 50, 255)
        elseif self.Player:IsAdmin() then
            color = Color(30, 200, 50, 255)
        end

        if self.Player:GetFriendStatus() == "friend" then
            color = Color(236, 181, 113, 255)
        end
    else
        color = timecolor
    end

    local hooks = hook.GetTable().FAdmin_PlayerRowColour
    if hooks then
        for _, v in pairs(hooks) do
            color = (v and v(self.Player, color)) or color
            break
        end
    end

    draw.RoundedBox(4, 0, 0, self:GetWide(), self.Size, color)

    surface.SetTexture(0)
    if self.Player == LocalPlayer() or self.Player:GetFriendStatus() == "friend" then
        surface.SetDrawColor(255, 255, 255, 50 + math.sin(RealTime() * 2) * 50)
    end
    surface.DrawTexturedRect(0, 0, self:GetWide(), self.Size)
    return true
end

function PANEL:SetPlayer(ply)
    self.Player = ply

    self.imgAvatar:SetPlayer(ply)

    self:UpdatePlayerData()
end

function PANEL:UpdatePlayerData()
    if not self.Player then return end
    if not self.Player:IsValid() then return end
	cattext(self.Player)
    self.lblName:SetText(DarkRP.deLocalise(self.Player:SteamName()))
	self.lblName:SetColor(timecolortext)
    self.lblTeam:SetText(timetext)
	self.lblTeam:SetColor(timecolortext)
    self.lblTeam:SizeToContents()
    self.lblFrags:SetText(self.Player:Frags())
    self.lblDeaths:SetText(self.Player:Deaths())
    self.lblPing:SetText(self.Player:Ping())
    self.lblWanted:SetText(self.Player:isWanted() and DarkRP.getPhrase("Wanted_text") or "")
end

function PANEL:ApplySchemeSettings()
    self.lblName:SetFont("ScoreboardPlayerNameBig")
    self.lblTeam:SetFont("ScoreboardPlayerNameBig")
    self.lblFrags:SetFont("ScoreboardPlayerName")
    self.lblDeaths:SetFont("ScoreboardPlayerName")
    self.lblPing:SetFont("ScoreboardPlayerName")
    self.lblWanted:SetFont("ScoreboardPlayerNameBig")

    self.lblName:SetFGColor(color_white)
    self.lblTeam:SetFGColor(color_white)
    self.lblFrags:SetFGColor(color_white)
    self.lblDeaths:SetFGColor(color_white)
    self.lblPing:SetFGColor(color_white)
    self.lblWanted:SetFGColor(color_white)
end

function PANEL:DoClick(x, y)
    if not IsValid(self.Player) then self:Remove() return end
    FAdmin.ScoreBoard.ChangeView("Player", self.Player)
end

function PANEL:DoRightClick()
    if table.Count(FAdmin.PlayerIcon.RightClickOptions) < 1 then return end
    local menu = DermaMenu()

    menu:SetPos(gui.MouseX(), gui.MouseY())

    for Name, func in SortedPairs(FAdmin.PlayerIcon.RightClickOptions) do
        menu:AddOption(Name, function() if IsValid(self.Player) then func(self.Player, self) end end)
    end

    menu:Open()
end

function PANEL:Think()
    if not self.PlayerUpdate or self.PlayerUpdate < CurTime() then
        self.PlayerUpdate = CurTime() + 0.5
        self:UpdatePlayerData()
    end
end

function PANEL:PerformLayout()
    self.imgAvatar:SetPos(2, 2)
    self.imgAvatar:SetSize(32, 32)

    self:SetSize(self:GetWide(), self.Size)

    self.lblName:SizeToContents()
    self.lblName:SetPos(24, 2)
    self.lblName:MoveRightOf(self.imgAvatar, 8)

    local COLUMN_SIZE = 75

    self.lblPing:SetPos(self:GetWide() - COLUMN_SIZE * 0.4, 0)
    self.lblDeaths:SetPos(self:GetWide() - COLUMN_SIZE * 1.4, 0)
    self.lblFrags:SetPos(self:GetWide() - COLUMN_SIZE * 2.4, 0)

    self.lblTeam:SetPos(self:GetWide() / 2 - (0.5 * self.lblTeam:GetWide()))

    self.lblWanted:SizeToContents()
    self.lblWanted:SetPos(math.floor(self:GetWide() / 4), 2)
end
vgui.Register("FadminPlayerRow", PANEL, "Button")

-- FAdminActionButton
local PANEL6 = {}

function PANEL6:Init()
    self:SetDrawBackground(false)
    self:SetDrawBorder(false)
    self:SetStretchToFit(false)
    self:SetSize(120, 40)

    self.TextLabel = vgui.Create("DLabel", self)
    self.TextLabel:SetColor(Color(200,200,200,200))
    self.TextLabel:SetFont("ChatFont")

    self.m_Image2 = vgui.Create("DImage", self)

    self.BorderColor = Color(190,40,0,255)
end

function PANEL6:SetText(text)
    self.TextLabel:SetText(text)
    self.TextLabel:SizeToContents()

    self:SetWide(self.TextLabel:GetWide() + 44)
end

function PANEL6:PerformLayout()
    self.m_Image:SetSize(32,32)
    self.m_Image:SetPos(4,4)

    self.m_Image2:SetSize(32, 32)
    self.m_Image2:SetPos(4,4)

    self.TextLabel:SetPos(38, 8)
end

function PANEL6:SetImage2(Mat, bckp)
    self.m_Image2:SetImage(Mat, bckp)
end

function PANEL6:SetBorderColor(Col)
    self.BorderColor = Col or Color(190,40,0,255)
end

function PANEL6:Paint()
    local BorderColor = self.BorderColor
    if self.Hovered then
        BorderColor = Color(math.Min(BorderColor.r + 40, 255), math.Min(BorderColor.g + 40, 255), math.Min(BorderColor.b + 40, 255), BorderColor.a)
    end
    if self.Depressed then
        BorderColor = Color(0,0,0,0)
    end
    draw.RoundedBox(4, 0, 0, self:GetWide(), self:GetTall(), BorderColor)
    draw.RoundedBox(4, 2, 2, self:GetWide() - 4, self:GetTall() - 4, Color(40, 40, 40, 255))
end

function PANEL6:OnMousePressed(mouse)
    if self:GetDisabled() then return end

    self.m_Image:SetSize(24,24)
    self.m_Image:SetPos(8,8)
    self.Depressed = true
end

function PANEL6:OnMouseReleased(mouse)
    if self:GetDisabled() then return end

    self.m_Image:SetSize(32,32)
    self.m_Image:SetPos(4,4)
    self.Depressed = false
    self:DoClick()
end

derma.DefineControl("FAdminActionButton", "Button for doing actions", PANEL6, "DImageButton")
