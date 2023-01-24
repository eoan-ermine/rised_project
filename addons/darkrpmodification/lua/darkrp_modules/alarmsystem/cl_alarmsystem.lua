-- "addons\\darkrpmodification\\lua\\darkrp_modules\\alarmsystem\\cl_alarmsystem.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

local ConVars = {}

local Color = Color
local CurTime = CurTime
local DarkRP = DarkRP
local draw = draw
local hook = hook
local IsValid = IsValid
local localplayer
local math = math
local ScrW, ScrH = ScrW, ScrH


local function LockDown()
	local t = GetGlobalFloat("HoursTimeFloat")
    local chbxX, chboxY = chat.GetChatBoxPos()
    if GetGlobalBool("DarkRP_LockdownCodeRed") then
        local cin = (math.sin(CurTime()) + 1) / 2
        local chatBoxSize = math.floor(Scrh / 8)
        draw.DrawNonParsedText("Внимание! Смертная казнь по усмотрению. Статус: красный", "marske4", chbxX, chboxY + chatBoxSize, Color(cin * 255, 0, 0, 255), TEXT_ALIGN_LEFT)
	elseif GetGlobalBool("DarkRP_LockdownCodeOrange") then
		local cin = (math.sin(CurTime()) + 1) / 2
        local chatBoxSize = math.floor(Scrh / 8)
        draw.DrawNonParsedText("Внимание! Повышенная готовность, осуждение на месте. Статус: оранжевый", "marske4", chbxX, chboxY + chatBoxSize, Color(cin * 255, cin * 155, 0, 255), TEXT_ALIGN_LEFT)
    elseif GetGlobalBool("DarkRP_LockdownCodeYellow") then
	    local cin = (math.sin(CurTime()) + 1) / 2
        local chatBoxSize = math.floor(Scrh / 8)
        draw.DrawNonParsedText("Внимание! Признаки антиобщественной деятельности. Статус: жёлтый", "marske4", chbxX, chboxY + chatBoxSize, Color(cin * 255, cin * 255, 0, 255), TEXT_ALIGN_LEFT)
    elseif GetGlobalBool("DarkRP_LockdownCodeGreen") then
        local cin = (math.sin(CurTime()) + 1) / 2
		local chatBoxSize = math.floor(Scrh / 8)
        draw.DrawNonParsedText("Ситуация под контролем. Статус: зеленый", "marske4", chbxX, chboxY + chatBoxSize, Color(0, 128, 0, cin * 255), TEXT_ALIGN_LEFT)
	elseif GetGlobalBool("DarkRP_LockdownCodeMiss") then
	    local cin = (math.sin(CurTime()) + 1) / 2
        local chatBoxSize = math.floor(Scrh / 8)
        draw.DrawNonParsedText("Внимание! Отклонение численности населения. Сотрудничество награждается.", "marske4", chbxX, chboxY + chatBoxSize, Color(cin * 255, cin * 255, cin * 255, 255), TEXT_ALIGN_LEFT)
	elseif GetGlobalBool("DarkRP_LockdownCodeHome") then
	    local cin = (math.sin(CurTime()) + 1) / 2
        local chatBoxSize = math.floor(Scrh / 8)
        draw.DrawNonParsedText("Внимание! Инспекция жилого квартала. Всем присутствовать по месту жительства.", "marske4", chbxX, chboxY + chatBoxSize, Color(cin * 255, cin * 255, cin * 255, 255), TEXT_ALIGN_LEFT)
	elseif GetGlobalBool("DarkRP_LockdownCodeIdent") then
	    local cin = (math.sin(CurTime()) + 1) / 2
        local chatBoxSize = math.floor(Scrh / 8)
        draw.DrawNonParsedText("Внимание! Проверка идентификации. Всем прийти к нексусу.", "marske4", chbxX, chboxY + chatBoxSize, Color(cin * 255, cin * 255, cin * 255, 255), TEXT_ALIGN_LEFT)
	elseif GetGlobalBool("DarkRP_LockDown") then
        local cin = (math.sin(CurTime()) + 1) / 2
        local chatBoxSize = math.floor(Scrh / 4)
        -draw.DrawNonParsedText(DarkRP.getPhrase("lockdown_started"), "marske4", chbxX, chboxY + chatBoxSize, Color(cin * 255, cin * 255, cin * 255, 255), TEXT_ALIGN_LEFT)
	elseif (t > 8 and t < 10) or (t > 18 and t < 20) then
	    local cin = (math.sin(CurTime()) + 1) / 2
        local chatBoxSize = math.floor(Scrh / 6)
        draw.DrawNonParsedText("Производится плановая выдача пищевых едениц. \n\nВсем гражданам прибыть в обозначенное место.", "marske4", chbxX, chboxY + chatBoxSize, Color(cin * 255, cin * 255, cin * 255, 255), TEXT_ALIGN_LEFT)
	end
end

local function DrawHUD() 
    Scrw, Scrh = ScrW(), ScrH()
    RelativeX, RelativeY = 0, Scrh

    LockDown()
end

hook.Add("HUDPaint", "PaintAlert", function()
    --localplayer = localplayer and IsValid(localplayer) and localplayer or LocalPlayer()
    --if not IsValid(localplayer) or !GetConVar("rised_HUD_CityCode_enable"):GetBool() then return end
	
    --DrawHUD()
end)
