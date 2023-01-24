-- "addons\\zrewards\\lua\\zrewards\\vgui\\elements\\cl_prompt.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) VGUI ELEMENT - Prompt
    Developed by Zephruz
]]

if (CLIENT) then

surface.CreateFont("zrewards.prompt.SMALL", {
    font = "Abel",
    size = 18,
})

end

-- LOCAL METHODS
local function updateButton(pnl, btn, text, funcCalcX)
    if !(IsValid(btn)) then return end

    local pW, pH = pnl:GetSize()
    local tW, tH = zlib.util:GetTextSize(text, btn:GetFont())
    local bX = (funcCalcX && funcCalcX(pW, pH, tW, tH) || 0)

    btn:SetText(text)
    btn:SetWidth(tW + 10)
    btn:SetPos(bX, pH - (btn:GetTall() + 5))
end

-- PANEL
local PANEL = {}

function PANEL:Init()
    self:SetEnableCloseButton(false)
    self:SetSize(250, 100)
    self:Center()
    self:MakePopup()
    self:SetBackgroundBlur(true)

    self._closeOnChoice = true
    self._confirmText = "Yes"
    self._declineText = "No"
    self._questionText = "No question"
end

function PANEL:SetCloseOnChoice(close)
    self._closeOnChoice = (close != false)
end

function PANEL:SetQuestion(text)
    if !(text) then return end

    self._questionText = text

    // Resize menu
    local tW, tH = zlib.util:GetTextSize(text, "zrewards.prompt.SMALL")

    if (tW > self:GetWide()) then
        self:SetWide(tW + 30)
        self:Center()
    end
end

function PANEL:SetConfirmText(text)
    if !(text) then return end
    
    self._confirmText = text

    -- Update confirm button
    updateButton(self, self.btnConfirm, text, function(pW, pH, tW, tH) return 5 end)
end

function PANEL:SetDeclineText(text)
    if !(text) then return end

    self._declineText = text
    
    -- Update decline button
    updateButton(self, self.btnDecline, text, function(pW, pH, tW, tH) return pW - (tW + 15) end)
end

function PANEL:Open()
    if (IsValid(self.btnConfirm)) then self.btnConfirm:Remove() end
    if (IsValid(self.btnDecline)) then self.btnDecline:Remove() end

    local pW, pH = self:GetSize()

    -- Confirm
    local btnConfirm = vgui.Create("zrewards.Button", self)
    btnConfirm.DoClick = function(s,w,h) 
        self:onConfirm() 

        if (self._closeOnChoice) then
            self:Remove()
        end
    end

    -- Decline
    local btnDecline = vgui.Create("zrewards.Button", self)
    btnDecline.DoClick = function(s,w,h) 
        self:onDecline() 

        if (self._closeOnChoice) then
            self:Remove()
        end
    end

    self.btnConfirm = btnConfirm
    self.btnDecline = btnDecline

    self:SetConfirmText(self._confirmText)
    self:SetDeclineText(self._declineText)
end

function PANEL:PaintOver(w, h)
    local qText, qFont = self._questionText, "zrewards.prompt.SMALL"
    local tW, tH = zlib.util:GetTextSize(qText, qFont)

    draw.SimpleText(self._questionText,qFont,(w/2) - (tW/2),h/2,titleCol,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
end

-- STUBS
function PANEL:onConfirm() end
function PANEL:onDecline() end

vgui.Register("zrewards.Prompt", PANEL, "zrewards.Frame")