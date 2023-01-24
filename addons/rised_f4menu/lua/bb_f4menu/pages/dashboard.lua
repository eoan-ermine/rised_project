-- "addons\\rised_f4menu\\lua\\bb_f4menu\\pages\\dashboard.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
// Global vars
local _blackberry = _blackberry or {};
_blackberry.f4menu = _blackberry.f4menu or {};
_blackberry.f4menu.derma = _blackberry.f4menu.derma or {};
_blackberry.f4menu.pages = _blackberry.f4menu.pages or {};
_blackberry.f4menu.activeMenu = _blackberry.f4menu.activeMenu or nil;
_blackberry.f4menu.pages.dashboard_func = _blackberry.f4menu.pages.dashboard_func or {};

local align = 200;
local sx = ScrW();
local function col_count()
	return 3;
end;
local function col_size()
	return math.floor((sx-align*col_count())/col_count());
end;
local function getSize(col_count)
	return col_size()* col_count + align * (col_count-1);
end;

// local vars
local cfg = _blackberry.f4menu.config;
local L = _blackberry.f4menu.lang;
local commandList = {};

function __local_CreateMenuWithPlayers(callback)
	local menu = DermaMenu()
	for k,v in pairs(player.GetAll()) do
		menu:AddOption(v:Name(), function() 
			callback(v); 
		end);
	end;
	menu:Open();
end;

function _blackberry.f4menu.pages.dashboard_func.initProfile(panel)

	local ply = LocalPlayer()

	local profile_panel = vgui.Create("DScrollPanel", panel);
	profile_panel:SetSize(col_size(), panel:GetTall());

	local profile_item_list = vgui.Create( "DIconLayout", profile_panel )
	profile_item_list:Dock(FILL);
	profile_item_list:SetSpaceX(0);
	profile_item_list:SetSpaceY(8);

	local sbar = profile_panel:GetVBar();
	sbar:SetWide(2);
	function sbar:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	function sbar.btnUp:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	function sbar.btnDown:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	function sbar.btnGrip:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
	end

	local header = vgui.Create("DPanel", profile_item_list);
	header:SetSize(col_size(),35);
	header.Paint = function(self, w, h)
		draw.SimpleText(L["my_profile"], "Raleway 26", 0, h/2, Color(255, 255, 255, 255), 0, 1);

		surface.SetFont("Raleway 26");
		local width, height = surface.GetTextSize(L["my_profile"]);
		draw.RoundedBox(0, 0, h-1, width/2, 1, Color(_blackberry.f4menu.config["main_color"].r, _blackberry.f4menu.config["main_color"].g, _blackberry.f4menu.config["main_color"].b));
	end;

	local name = vgui.Create("DPanel", profile_item_list);
	name:SetSize(col_size(),35);
	name.Paint = function(self, w, h)
		draw.SimpleText(L["d_name"], "Raleway 15", 0, 15/2, Color(255, 200, 75, 55), 0, 1);
		draw.SimpleText(LocalPlayer():Name(), "Raleway 20", 0, 15+20/2, Color(255, 200, 75, 255), 0, 1);
	end;

	-- local rank = vgui.Create("DPanel", profile_item_list);
	-- rank:SetSize(col_size(),35);
	-- rank.Paint = function(self, w, h)
	-- 	draw.SimpleText(L["d_rank"], "Raleway 15", 0, 15/2, Color(255, 200, 75, 55), 0, 1);
	-- 	draw.SimpleText(LocalPlayer():GetUserGroup(), "Raleway 20", 0, 15+20/2, Color(255, 200, 75, 255), 0, 1);
	-- end;

	local job = vgui.Create("DPanel", profile_item_list);
	job:SetSize(col_size(),35);
	job.Paint = function(self, w, h)
		local work_status = GAMEMODE.CivilJobs[LocalPlayer():Team()] and " | "..LocalPlayer():GetNWString("Player_WorkStatus", "Безработный") or ""
		draw.SimpleText(L["d_job"], "Raleway 15", 0, 15/2, Color(255, 200, 75, 55), 0, 1);
		draw.SimpleText(LocalPlayer():getDarkRPVar("job") .. work_status, "Raleway 20", 0, 15+20/2, Color(255, 200, 75, 255), 0, 1);
	end;

	local money = vgui.Create("DPanel", profile_item_list);
	money:SetSize(col_size(),35)
	money.Paint = function(self, w, h)
		draw.SimpleText(L["d_money"], "Raleway 15", 0, 15/2, Color(255, 200, 75, 55), 0, 1);
		draw.SimpleText(DarkRP.formatMoney(LocalPlayer():getDarkRPVar("money")), "Raleway 20", 0, 15+20/2, Color(255, 200, 75, 255), 0, 1);

		draw.SimpleText(L["d_salary"], "Raleway 15", w, 15/2, Color(255, 200, 75, 55), 2, 1);
		draw.SimpleText(DarkRP.formatMoney(LocalPlayer():getDarkRPVar("salary")), "Raleway 20", w, 15+20/2, Color(255, 200, 75, 255), 2, 1);
	end;

	-- local gunlicense = vgui.Create("DPanel", profile_item_list);
	-- gunlicense:SetSize(col_size(),25)
	-- gunlicense.Paint = function(self, w, h)
	-- 	if (LocalPlayer():getDarkRPVar("HasGunlicense")) then
	-- 		draw.SimpleText(L["license_have"], "Raleway 18", 0, 20/2, Color(_blackberry.f4menu.config["main_color"].r, _blackberry.f4menu.config["main_color"].g, _blackberry.f4menu.config["main_color"].b, 255), 0, 1);
	-- 	else
	-- 		draw.SimpleText(L["license_not_have"], "Raleway 18", 0, 20/2, Color(255, 200, 75, 55), 0, 1);
	-- 	end
	-- end;

	local moodVal = tonumber(LocalPlayer():GetNWInt("Player_Mood", 80))
	local moodText = "Нормальное"
	if moodVal >= 90 then
		moodText = "Отличное | " .. LocalPlayer():GetNWString("MedicineDisease_02", "Без отклонений")
	elseif moodVal >= 80 then
		moodText = "Хорошее | " .. LocalPlayer():GetNWString("MedicineDisease_02", "Без отклонений")
	elseif moodVal >= 70 or ply:isCP() then
		moodText = "Нормальное | " .. LocalPlayer():GetNWString("MedicineDisease_02", "Без отклонений")
	elseif moodVal >= 60 then
		moodText = "Ниже среднего | " .. LocalPlayer():GetNWString("MedicineDisease_02", "Без отклонений")
	elseif moodVal >= 50 then
		moodText = "Грусть | " .. LocalPlayer():GetNWString("MedicineDisease_02", "Без отклонений")
	elseif moodVal >= 40 then
		moodText = "Беспокойство | " .. LocalPlayer():GetNWString("MedicineDisease_02", "Без отклонений")
	elseif moodVal >= 30 then
		moodText = "Подавленное | " .. LocalPlayer():GetNWString("MedicineDisease_02", "Без отклонений")
	elseif moodVal >= 20 then
		moodText = "Тревожное | " .. LocalPlayer():GetNWString("MedicineDisease_02", "Без отклонений")
	elseif moodVal >= 10 then
		moodText = "Мрачное | " .. LocalPlayer():GetNWString("MedicineDisease_02", "Без отклонений")
	elseif moodVal < 10 then
		moodText = "Отчаяние | " .. LocalPlayer():GetNWString("MedicineDisease_02", "Без отклонений")
	end
	local mood = vgui.Create("DPanel", profile_item_list);
	mood:SetSize(col_size(),35);
	mood.Paint = function(self, w, h)
		draw.SimpleText("Настроение", "Raleway 15", 0, 15/2, Color(255, 200, 75, 55), 0, 1);
		draw.SimpleText(moodText, "Raleway 20", 0, 15+20/2, Color(255, 200, 75, 255), 0, 1);
	end;

	local rplevel = vgui.Create("DPanel", profile_item_list);
	rplevel:SetSize(col_size(),35)
	rplevel.Paint = function(self, w, h)
		draw.SimpleText("Уровень RP", "Raleway 15", 0, 15/2, Color(255, 200, 75, 55), 0, 1);
		draw.SimpleText(LocalPlayer():GetNWInt("PersonalRPLevel", 0), "Raleway 20", 0, 15+20/2, Color(255, 200, 75, 255), 0, 1);
	end;

	local loyalty = vgui.Create("DPanel", profile_item_list);
	loyalty:SetSize(col_size(),35)
	loyalty.Paint = function(self, w, h)
		draw.SimpleText("Очки лояльности", "Raleway 15", 0, 15/2, Color(255, 200, 75, 55), 0, 1);
		draw.SimpleText(LocalPlayer():GetNWInt("LoyaltyTokens", 0), "Raleway 20", 0, 15+20/2, Color(255, 200, 75, 255), 0, 1);
	end;

	
	local revStatus
	if GetGlobalBool("RebelRevenge") == true then
		revStatus = "Революция сопротивления"
	else
		revStatus = "Контроль Альянса"
	end
	local cityStatus = vgui.Create("DPanel", profile_item_list);
	cityStatus:SetSize(col_size(),35)
	cityStatus.Paint = function(self, w, h)
		draw.SimpleText("Статус города", "Raleway 15", 0, 15/2, Color(255, 200, 75, 55), 0, 1);
		draw.SimpleText(revStatus, "Raleway 20", 0, 15+20/2, Color(255, 200, 75, 255), 0, 1);
	end;

	local headerAmmo = vgui.Create("DPanel", profile_item_list);
	headerAmmo:SetSize(col_size(),35);
	headerAmmo.Paint = function(self, w, h)
		draw.SimpleText("Патроны", "Raleway 26", 0, h/2, Color(255, 255, 255, 255), 0, 1);

		surface.SetFont("Raleway 26");
		local width, height = surface.GetTextSize("Патроны");
		draw.RoundedBox(0, 0, h-1, width/2, 1, Color(_blackberry.f4menu.config["main_color"].r, _blackberry.f4menu.config["main_color"].g, _blackberry.f4menu.config["main_color"].b));
	end;
	if LocalPlayer():GetActiveWeapon():IsValid() and LocalPlayer():GetActiveWeapon():Clip1() and LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()) then
		local clip = "Отсутствует"
		local pack = "Отсутствует"
		if LocalPlayer():GetActiveWeapon():Clip1() > 0 then clip = LocalPlayer():GetActiveWeapon():Clip1() end
		if LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()) > 0 then pack = LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()) end

		local ammo = vgui.Create("DPanel", profile_item_list);
		ammo:SetSize(col_size(),35)
		ammo.Paint = function(self, w, h)
			draw.SimpleText("Обойма", "Raleway 15", 0, 15/2, Color(255, 200, 75, 55), 0, 1);
			draw.SimpleText(clip, "Raleway 20", 0, 15+20/2, Color(255, 200, 75, 255), 0, 1);

			draw.SimpleText("Резерв", "Raleway 15", w, 15/2, Color(255, 200, 75, 55), 2, 1);
			draw.SimpleText(pack, "Raleway 20", w, 15+20/2, Color(255, 200, 75, 255), 2, 1);
		end;
	end

	local header = vgui.Create("DPanel", profile_item_list);
	header:SetSize(col_size(),35);
	header.Paint = function(self, w, h)
		draw.SimpleText("Опыт", "Raleway 26", 0, h/2, Color(255, 255, 255, 255), 0, 1);

		surface.SetFont("Raleway 26");
		local width, height = surface.GetTextSize("Опыт");
		draw.RoundedBox(0, 0, h-1, width/2, 1, Color(_blackberry.f4menu.config["main_color"].r, _blackberry.f4menu.config["main_color"].g, _blackberry.f4menu.config["main_color"].b));
	end

	local common_total_exp = ply.Player_ExpCommon or 0
	local common_nextlevel_exp = GetNextLevelTotalExp(common_total_exp)
	local common = vgui.Create("DPanel", profile_item_list)
	common:SetSize(col_size(),40)
	common.Paint = function(self, w, h)
		local exp_current = ply.Player_ExpCommon
		local level = ply.Player_LevelCommon
		local next_lvl_exp = ply.Player_NextLevelExpCommon
		local prev_total_lvl_exp = ply.Player_PrevTotalLevelExpCommon
		local next_total_lvl_exp = ply.Player_NextTotalLevelExpCommon
		local exp_current_start = exp_current - prev_total_lvl_exp
		local percentage = math.Round((exp_current_start / next_lvl_exp) * 100, 1)

		draw.RoundedBox(0, 0, 20, w, 20, Color(0, 0, 0, 100))
		draw.RoundedBox(4, 0, 20, w/100*percentage, 20, Color(255, 255, 255, math.random(200,255)))

		draw.SimpleText("Общий | " .. level .. " lvl", "Raleway 15", 0, 15/2, Color(255, 200, 75, 255), 0, 1)
		draw.SimpleText(exp_current_start .. "/" .. next_lvl_exp .. " ед. | " .. percentage .." %", "Raleway 15", w, 15/2, Color(255, 200, 75, 255), 2, 1)
	end

	local party_total_exp = ply.Player_ExpParty or 0
	local party_nextlevel_exp = GetNextLevelTotalExp(party_total_exp)
	local party = vgui.Create("DPanel", profile_item_list)
	party:SetSize(col_size(),40)
	party.Paint = function(self, w, h)
		local exp_current = ply.Player_ExpParty
		local level = ply.Player_LevelParty
		local next_lvl_exp = ply.Player_NextLevelExpParty
		local prev_total_lvl_exp = ply.Player_PrevTotalLevelExpParty
		local next_total_lvl_exp = ply.Player_NextTotalLevelExpParty
		local exp_current_start = exp_current - prev_total_lvl_exp
		
		local percentage = math.Round((exp_current_start / next_lvl_exp) * 100, 1)

		draw.RoundedBox(0, 0, 20, w, 20, Color(0, 0, 0, 100))
		draw.RoundedBox(4, 0, 20, w/100*percentage, 20, Color(255, 255, 255, math.random(200,255)))

		draw.SimpleText("Партия | " .. level .. " lvl", "Raleway 15", 0, 15/2, Color(255, 200, 75, 255), 0, 1)
		draw.SimpleText(exp_current_start .. "/" .. next_lvl_exp .. " ед. | " .. percentage .." %", "Raleway 15", w, 15/2, Color(255, 200, 75, 255), 2, 1)
	end

	local combine_total_exp = ply.Player_ExpCombine or 0
	local combine_nextlevel_exp = GetNextLevelTotalExp(combine_total_exp)
	local combine = vgui.Create("DPanel", profile_item_list)
	combine:SetSize(col_size(),40)
	combine.Paint = function(self, w, h)
		local exp_current = ply.Player_ExpCombine
		local level = ply.Player_LevelCombine
		local next_lvl_exp = ply.Player_NextLevelExpCombine
		local prev_total_lvl_exp = ply.Player_PrevTotalLevelExpCombine
		local next_total_lvl_exp = ply.Player_NextTotalLevelExpCombine
		local exp_current_start = exp_current - prev_total_lvl_exp
		local percentage = math.Round((exp_current_start / next_lvl_exp) * 100, 1)

		draw.RoundedBox(0, 0, 20, w, 20, Color(0, 0, 0, 100))
		draw.RoundedBox(4, 0, 20, w/100*percentage, 20, Color(255, 255, 255, math.random(200,255)))

		draw.SimpleText("Альянс | " .. level .. " lvl", "Raleway 15", 0, 15/2, Color(255, 200, 75, 255), 0, 1)
		draw.SimpleText(exp_current_start .. "/" .. next_lvl_exp .. " ед. | " .. percentage .." %", "Raleway 15", w, 15/2, Color(255, 200, 75, 255), 2, 1)
	end

	local rebel_total_exp = ply.Player_ExpRebel or 0
	local rebel_nextlevel_exp = GetNextLevelTotalExp(rebel_total_exp)
	local rebel = vgui.Create("DPanel", profile_item_list)
	rebel:SetSize(col_size(),40)
	rebel.Paint = function(self, w, h)
		local exp_current = ply.Player_ExpRebel
		local level = ply.Player_LevelRebel
		local next_lvl_exp = ply.Player_NextLevelExpRebel
		local prev_total_lvl_exp = ply.Player_PrevTotalLevelExpRebel
		local next_total_lvl_exp = ply.Player_NextTotalLevelExpRebel
		local exp_current_start = exp_current - prev_total_lvl_exp
		local percentage = math.Round((exp_current_start / next_lvl_exp) * 100, 1)

		draw.RoundedBox(0, 0, 20, w, 20, Color(0, 0, 0, 100))
		draw.RoundedBox(4, 0, 20, w/100*percentage, 20, Color(255, 255, 255, math.random(200,255)))

		draw.SimpleText("Сопротивление | " .. level .. " lvl", "Raleway 15", 0, 15/2, Color(255, 200, 75, 255), 0, 1)
		draw.SimpleText(exp_current_start .. "/" .. next_lvl_exp .. " ед. | " .. percentage .." %", "Raleway 15", w, 15/2, Color(255, 200, 75, 255), 2, 1)
	end
end

function _blackberry.f4menu.pages.dashboard_func.initStaffAndStats(panel)
	local staff_panel = vgui.Create("DScrollPanel", panel);
	staff_panel:SetSize(col_size(), panel:GetTall());
	staff_panel:SetPos(col_size()+25);
	staff_panel.Paint = function(self, w, h)
	end;

	local staff_item_list = vgui.Create( "DIconLayout", staff_panel )
	staff_item_list:Dock(FILL);
	staff_item_list:SetSpaceX(0);
	staff_item_list:SetSpaceY(8);

	local sbar = staff_panel:GetVBar();
	sbar:SetWide(2);
	function sbar:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	function sbar.btnUp:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	function sbar.btnDown:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	function sbar.btnGrip:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
	end

	local header = vgui.Create("DPanel", staff_item_list);
	header:SetSize(col_size(),35);
	header.Paint = function(self, w, h)
		draw.SimpleText("Статистика", "Raleway 26", 0, h/2, Color(255, 255, 255, 255), 0, 1);

		surface.SetFont("Raleway 26");
		local width, height = surface.GetTextSize("Статистика");
		draw.RoundedBox(0, 0, h-1, width/2, 1, Color(_blackberry.f4menu.config["main_color"].r, _blackberry.f4menu.config["main_color"].g, _blackberry.f4menu.config["main_color"].b));
	end;

	local stealthCount = 0
	for k,v in pairs(player.GetAll()) do
		if v:IsAdmin() and v:GetNWBool("Rised_Admin_Stealth") then stealthCount = stealthCount + 1 end
	end
	
	local players = vgui.Create("DPanel", staff_item_list);
	players:SetSize(col_size(),40);
	players.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 20, w, 20, Color(0, 0, 0, 100));
		draw.RoundedBox(0, 0, 20, w/game.MaxPlayers()*(#player.GetAll()), 20, Color(_blackberry.f4menu.config["main_color"].r, _blackberry.f4menu.config["main_color"].g, _blackberry.f4menu.config["main_color"].b, 100));

		draw.SimpleText(L["players"], "Raleway 15", 0, 15/2, Color(255, 200, 75, 55), 0, 1);
		draw.SimpleText((#player.GetAll() - stealthCount).." / "..game.MaxPlayers(), "Raleway 15", w, 15/2, Color(255, 200, 75, 255), 2, 1);
	end;

	local servermoney = vgui.Create("DPanel", staff_item_list);
	servermoney:SetSize(col_size(),35);
	servermoney.Paint = function(self, w, h)
		draw.SimpleText(L["money_on_server"], "Raleway 15", 0, 15/2, Color(255, 200, 75, 55), 0, 1);
		draw.SimpleText(DarkRP.formatMoney(math.Round(GetGlobalInt("_blackberry.f4menu.globalmoney"))), "Raleway 20", 0, 15+20/2, Color(255, 200, 75, 255), 0, 1);
	end;

	local header = vgui.Create("DPanel", staff_item_list);
	header:SetSize(col_size(),35);
	header.Paint = function(self, w, h)
		draw.SimpleText(L["staff"], "Raleway 26", 0, h/2, Color(255, 255, 255, 255), 0, 1);
		
		surface.SetFont("Raleway 26");
		local width, height = surface.GetTextSize(L["staff"]);
		draw.RoundedBox(0, 0, h-1, width/2, 1, Color(_blackberry.f4menu.config["main_color"].r, _blackberry.f4menu.config["main_color"].g, _blackberry.f4menu.config["main_color"].b));
	end;

	local showRanks = {
		'Inferior Moderator',
		'Superior Moderator',
		'Administrator',
		'Administrator',
		'Administrator I',
		'Administrator II',
		'Administrator III',
	}
	
	for k,v in pairs(player.GetAll()) do
		if (!table.HasValue(showRanks, v:GetUserGroup())) or (v:IsAdmin() and v:GetNWBool("Rised_Admin_Stealth")) then continue; end;
		local staff_profile = vgui.Create("DPanel", staff_item_list);
		staff_profile:SetSize(col_size(),64);
		staff_profile.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100));
			draw.RoundedBox(0, 0, 0, 64, 64, Color(0, 0, 0, 50));
			draw.SimpleText(v:SteamName(), "Raleway 18", 64+2, 20/2, Color(255, 200, 75, 55), 0, 1);
			draw.SimpleText(v:GetUserGroup(), "Raleway 15", 64+2, 20+15/2, Color(_blackberry.f4menu.config["main_color"].r, _blackberry.f4menu.config["main_color"].g, _blackberry.f4menu.config["main_color"].b, 150), 0, 1);
		end;

		local Avatar = vgui.Create("AvatarImage", staff_profile);
		Avatar:SetSize(60, 60);
		Avatar:SetPos(2, 2);
		Avatar:SetPlayer(v, 64);
	end

	local sector01text = ""
	local sector02text = ""
	local sector03text = ""
	local sector04text = ""
	local sector05text = ""
	local sector06text = ""
	local sector07text = ""

	local mainRad = ""
	local subRad = ""
		
	if !GetGlobalBool("SectorT01_Captured") then
		sector01text = "Под контролем Альянса"
	else
		sector01text = "Захвачен сопротивлением"
	end
	
	if !GetGlobalBool("SectorT02_Captured") then
		sector02text = "Под контролем Альянса"
	else
		sector02text = "Захвачен сопротивлением"
	end
	
	if !GetGlobalBool("SectorT03_Captured") then
		sector03text = "Под контролем Альянса"
	else
		sector03text = "Захвачен сопротивлением"
	end
	
	if !GetGlobalBool("SectorT04_Captured") then
		sector04text = "Под контролем Альянса"
	else
		sector04text = "Захвачен сопротивлением"
	end
	
	if !GetGlobalBool("SectorT05_Captured") then
		sector05text = "Под контролем Альянса"
	else
		sector05text = "Захвачен сопротивлением"
	end
	
	if !GetGlobalBool("SectorT06_Captured") then
		sector06text = "Под контролем Альянса"
	else
		sector06text = "Захвачен сопротивлением"
	end
	
	if !GetGlobalBool("SectorT07_Captured") then
		sector07text = "Под контролем Альянса"
	else
		sector07text = "Захвачен сопротивлением"
	end
	
	if LocalPlayer():isCP() then

		local headerCity = vgui.Create("DPanel", staff_item_list);
		headerCity:SetSize(col_size(),35);
		headerCity.Paint = function(self, w, h)
			draw.SimpleText("Сектора города", "Raleway 26", 0, h/2, Color(255, 255, 255, 255), 0, 1);
			
			surface.SetFont("Raleway 26");
			local width, height = surface.GetTextSize("Сектора города");
			draw.RoundedBox(0, 0, h-1, width/2, 1, Color(_blackberry.f4menu.config["main_color"].r, _blackberry.f4menu.config["main_color"].g, _blackberry.f4menu.config["main_color"].b));
		end;
		
		local sector01 = vgui.Create("DPanel", staff_item_list);
		sector01:SetSize(col_size(),35);
		sector01.Paint = function(self, w, h)
			draw.SimpleText("Сектор 1", "Raleway 15", 0, 15/2, Color(255, 200, 75, 55), 0, 1);
			draw.SimpleText(sector01text, "Raleway 20", 0, 15+20/2, Color(255, 200, 75, 255), 0, 1);
		end;
		local sector02 = vgui.Create("DPanel", staff_item_list);
		sector02:SetSize(col_size(),35);
		sector02.Paint = function(self, w, h)
			draw.SimpleText("Сектор 2", "Raleway 15", 0, 15/2, Color(255, 200, 75, 55), 0, 1);
			draw.SimpleText(sector02text, "Raleway 20", 0, 15+20/2, Color(255, 200, 75, 255), 0, 1);
		end;
		local sector03 = vgui.Create("DPanel", staff_item_list);
		sector03:SetSize(col_size(),35);
		sector03.Paint = function(self, w, h)
			draw.SimpleText("Сектор 3", "Raleway 15", 0, 15/2, Color(255, 200, 75, 55), 0, 1);
			draw.SimpleText(sector03text, "Raleway 20", 0, 15+20/2, Color(255, 200, 75, 255), 0, 1);
		end;
		local sector04 = vgui.Create("DPanel", staff_item_list);
		sector04:SetSize(col_size(),35);
		sector04.Paint = function(self, w, h)
			draw.SimpleText("Сектор 4", "Raleway 15", 0, 15/2, Color(255, 200, 75, 55), 0, 1);
			draw.SimpleText(sector04text, "Raleway 20", 0, 15+20/2, Color(255, 200, 75, 255), 0, 1);
		end;
		local sector05 = vgui.Create("DPanel", staff_item_list);
		sector05:SetSize(col_size(),35);
		sector05.Paint = function(self, w, h)
			draw.SimpleText("Сектор 5", "Raleway 15", 0, 15/2, Color(255, 200, 75, 55), 0, 1);
			draw.SimpleText(sector05text, "Raleway 20", 0, 15+20/2, Color(255, 200, 75, 255), 0, 1);
		end;
		local sector06 = vgui.Create("DPanel", staff_item_list);
		sector06:SetSize(col_size(),35);
		sector06.Paint = function(self, w, h)
			draw.SimpleText("Сектор 6", "Raleway 15", 0, 15/2, Color(255, 200, 75, 55), 0, 1);
			draw.SimpleText(sector06text, "Raleway 20", 0, 15+20/2, Color(255, 200, 75, 255), 0, 1);
		end;
		local sector07 = vgui.Create("DPanel", staff_item_list);
		sector07:SetSize(col_size(),35);
		sector07.Paint = function(self, w, h)
			draw.SimpleText("Сектор 7", "Raleway 15", 0, 15/2, Color(255, 200, 75, 55), 0, 1);
			draw.SimpleText(sector07text, "Raleway 20", 0, 15+20/2, Color(255, 200, 75, 255), 0, 1);
		end;
	elseif GAMEMODE.Rebels[LocalPlayer():Team()] then

		local headerCity = vgui.Create("DPanel", staff_item_list);
		headerCity:SetSize(col_size(),35);
		headerCity.Paint = function(self, w, h)
			draw.SimpleText("Сектора города", "Raleway 26", 0, h/2, Color(255, 255, 255, 255), 0, 1);
			
			surface.SetFont("Raleway 26");
			local width, height = surface.GetTextSize("Сектора города");
			draw.RoundedBox(0, 0, h-1, width/2, 1, Color(_blackberry.f4menu.config["main_color"].r, _blackberry.f4menu.config["main_color"].g, _blackberry.f4menu.config["main_color"].b));
		end;
		
		local sector01 = vgui.Create("DPanel", staff_item_list);
		sector01:SetSize(col_size(),35);
		sector01.Paint = function(self, w, h)
			draw.SimpleText("Сектор 1", "Raleway 15", 0, 15/2, Color(255, 200, 75, 55), 0, 1);
			draw.SimpleText(sector01text, "Raleway 20", 0, 15+20/2, Color(255, 200, 75, 255), 0, 1);
		end;
		local sector02 = vgui.Create("DPanel", staff_item_list);
		sector02:SetSize(col_size(),35);
		sector02.Paint = function(self, w, h)
			draw.SimpleText("Сектор 2", "Raleway 15", 0, 15/2, Color(255, 200, 75, 55), 0, 1);
			draw.SimpleText(sector02text, "Raleway 20", 0, 15+20/2, Color(255, 200, 75, 255), 0, 1);
		end;
		local sector03 = vgui.Create("DPanel", staff_item_list);
		sector03:SetSize(col_size(),35);
		sector03.Paint = function(self, w, h)
			draw.SimpleText("Сектор 3", "Raleway 15", 0, 15/2, Color(255, 200, 75, 55), 0, 1);
			draw.SimpleText(sector03text, "Raleway 20", 0, 15+20/2, Color(255, 200, 75, 255), 0, 1);
		end;
		local sector04 = vgui.Create("DPanel", staff_item_list);
		sector04:SetSize(col_size(),35);
		sector04.Paint = function(self, w, h)
			draw.SimpleText("Сектор 4", "Raleway 15", 0, 15/2, Color(255, 200, 75, 55), 0, 1);
			draw.SimpleText(sector04text, "Raleway 20", 0, 15+20/2, Color(255, 200, 75, 255), 0, 1);
		end;
		local sector05 = vgui.Create("DPanel", staff_item_list);
		sector05:SetSize(col_size(),35);
		sector05.Paint = function(self, w, h)
			draw.SimpleText("Сектор 5", "Raleway 15", 0, 15/2, Color(255, 200, 75, 55), 0, 1);
			draw.SimpleText(sector05text, "Raleway 20", 0, 15+20/2, Color(255, 200, 75, 255), 0, 1);
		end;
		local sector06 = vgui.Create("DPanel", staff_item_list);
		sector06:SetSize(col_size(),35);
		sector06.Paint = function(self, w, h)
			draw.SimpleText("Сектор 6", "Raleway 15", 0, 15/2, Color(255, 200, 75, 55), 0, 1);
			draw.SimpleText(sector06text, "Raleway 20", 0, 15+20/2, Color(255, 200, 75, 255), 0, 1);
		end;
		local sector07 = vgui.Create("DPanel", staff_item_list);
		sector07:SetSize(col_size(),35);
		sector07.Paint = function(self, w, h)
			draw.SimpleText("Сектор 7", "Raleway 15", 0, 15/2, Color(255, 200, 75, 55), 0, 1);
			draw.SimpleText(sector07text, "Raleway 20", 0, 15+20/2, Color(255, 200, 75, 255), 0, 1);
		end;
	end

	local headerRadio = vgui.Create("DPanel", staff_item_list);
	headerRadio:SetSize(col_size(),35);
	headerRadio.Paint = function(self, w, h)
		draw.SimpleText("Радиочастоты", "Raleway 26", 0, h/2, Color(255, 255, 255, 255), 0, 1);
		
		surface.SetFont("Raleway 26");
		local width, height = surface.GetTextSize("Радиочастоты");
		draw.RoundedBox(0, 0, h-1, width/2, 1, Color(_blackberry.f4menu.config["main_color"].r, _blackberry.f4menu.config["main_color"].g, _blackberry.f4menu.config["main_color"].b));
	end;

	if LocalPlayer():isCP() then
		mainRad = tostring(90+GetGlobalString("Rised_MainRadioChannel_Combine", 95)/10)
		subRad = tostring(90+GetGlobalString("Rised_SubRadioChannel_Combine", 94)/10)

		local radio_mp = vgui.Create("DPanel", staff_item_list);
		radio_mp:SetSize(col_size(),35);
		radio_mp.Paint = function(self, w, h)
			draw.SimpleText("Метрополиция", "Raleway 15", 0, 15/2, Color(255, 200, 75, 55), 0, 1);
			draw.SimpleText("Частота: " .. mainRad, "Raleway 20", 0, 15+20/2, Color(255, 200, 75, 255), 0, 1);
		end;

		local radio_ota = vgui.Create("DPanel", staff_item_list);
		radio_ota:SetSize(col_size(),35);
		radio_ota.Paint = function(self, w, h)
			draw.SimpleText("Сверхчеловеческий отдел", "Raleway 15", 0, 15/2, Color(255, 200, 75, 55), 0, 1);
			draw.SimpleText("Частота: " .. subRad, "Raleway 20", 0, 15+20/2, Color(255, 200, 75, 255), 0, 1);
		end;
	elseif GAMEMODE.Rebels[LocalPlayer():Team()] then
		mainRad = tostring(90+GetGlobalString("Rised_MainRadioChannel", 55)/10)
		subRad = tostring(90+GetGlobalString("Rised_SubRadioChannel", 32)/10)

		local radio_mp = vgui.Create("DPanel", staff_item_list);
		radio_mp:SetSize(col_size(),35);
		radio_mp.Paint = function(self, w, h)
			draw.SimpleText("Основная", "Raleway 15", 0, 15/2, Color(255, 200, 75, 55), 0, 1);
			draw.SimpleText("Частота: " .. mainRad, "Raleway 20", 0, 15+20/2, Color(255, 200, 75, 255), 0, 1);
		end;

		local radio_ota = vgui.Create("DPanel", staff_item_list);
		radio_ota:SetSize(col_size(),35);
		radio_ota.Paint = function(self, w, h)
			draw.SimpleText("Резервная", "Raleway 15", 0, 15/2, Color(255, 200, 75, 55), 0, 1);
			draw.SimpleText("Частота: " .. subRad, "Raleway 20", 0, 15+20/2, Color(255, 200, 75, 255), 0, 1);
		end;
	end
end;


function _blackberry.f4menu.pages.dashboard_func.initCommands(panel)
	local panel_size = panel:GetWide()-col_size()*2-25*2;
	local panel_duble = false;
	local cmd_panel_second, cmd_item_list_second;
	if (panel_size >= 529) then
		panel_size = panel_size - col_size() - 25;

		cmd_panel_second = vgui.Create("DScrollPanel", panel);
		cmd_panel_second:SetSize(panel_size, panel:GetTall());
		cmd_panel_second:SetPos(col_size()*2+25*2+250+25);
		cmd_panel_second.Paint = function(self, w, h)
		end;

		cmd_item_list_second = vgui.Create("DIconLayout", cmd_panel_second)
		cmd_item_list_second:Dock(FILL);
		cmd_item_list_second:SetSpaceX(0);
		cmd_item_list_second:SetSpaceY(8);

		panel_duble = true;

		local sbar = cmd_panel_second:GetVBar();
		sbar:SetWide(2);
		function sbar:Paint(w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
		end
		function sbar.btnUp:Paint(w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
		end
		function sbar.btnDown:Paint(w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
		end
		function sbar.btnGrip:Paint(w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
		end
	end

	local cmd_panel = vgui.Create("DScrollPanel", panel);
	cmd_panel:SetSize(panel:GetWide()/3.8, panel:GetTall());
	cmd_panel:SetPos(col_size()*2+25*2);
	cmd_panel.Paint = function(self, w, h)
	end;

	local cmd_item_list = vgui.Create( "DIconLayout", cmd_panel )
	cmd_item_list:Dock(FILL);
	cmd_item_list:SetSpaceX(0);
	cmd_item_list:SetSpaceY(8);

	local sbar = cmd_panel:GetVBar();
	sbar:SetWide(2);
	function sbar:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	function sbar.btnUp:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	function sbar.btnDown:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	function sbar.btnGrip:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
	end

	local tasksList = GetCurrentTeamTaskList(LocalPlayer())
	local item_count = 1
	
	local header = vgui.Create("DPanel", cmd_item_list)
	header:SetSize(col_size(),35)
	header.Paint = function(self, w, h)
		draw.SimpleText("План на день:", "Raleway 26", 0, h/2, Color(255, 255, 255, 255), 0, 1)

		surface.SetFont("Raleway 26")
		local width, height = surface.GetTextSize("План на день:")
		draw.RoundedBox(0, 0, h-1, width/2, 1, color_white or Color(_blackberry.f4menu.config["main_color"].r, _blackberry.f4menu.config["main_color"].g, _blackberry.f4menu.config["main_color"].b))
	end

	for k, v in pairs(tasksList) do
		if v.MaxIterations == -1 then continue end

		local text = v.Name .. ":   " .. v.Iterations .. " / " .. v.MaxIterations
		local width, height = surface.GetTextSize(text)

		local btn_panel = vgui.Create("DPanel", cmd_item_list)
		btn_panel:SetSize(col_size(),22)
		btn_panel.Paint = function(self, w, h)
		end

		local btn = _blackberry.f4menu.derma.createButtonlist(text, 1)
		btn:SetParent(btn_panel)
		btn:SetEnabled(false)
		btn.DoClick = function()
		end
		btn.starttime = SysTime()+(item_count)*0.1

		local current_width = width * v.Iterations / v.MaxIterations
		
		local btn_line = vgui.Create("DLabel", btn_panel)
		btn_line:SetSize(col_size(),22)
		btn_line:SetText("")
		btn_line.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, h-1, current_width, 12, Color(255,165,0,math.random(-25,155)))
		end
		
		item_count = item_count + 1
	end
end

function _blackberry.f4menu.pages.dashboard(parent)
	_blackberry.f4menu.pages.dashboard_func.initProfile(parent)
	_blackberry.f4menu.pages.dashboard_func.initStaffAndStats(parent)
	_blackberry.f4menu.pages.dashboard_func.initCommands(parent)
end;