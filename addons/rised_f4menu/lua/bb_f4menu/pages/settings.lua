-- "addons\\rised_f4menu\\lua\\bb_f4menu\\pages\\settings.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
// Global vars
local _blackberry = _blackberry or {};
_blackberry.f4menu = _blackberry.f4menu or {};
_blackberry.f4menu.derma = _blackberry.f4menu.derma or {};
_blackberry.f4menu.pages = _blackberry.f4menu.pages or {};
_blackberry.f4menu.activeMenu = _blackberry.f4menu.activeMenu or nil;
_blackberry.f4menu.pages.settings_func = _blackberry.f4menu.pages.settings_func or {};

CreateClientConVar( "rised_headdrag_enable", "0", true, false)
CreateClientConVar( "rised_thirdpersonview_enable", "0", true, false)
CreateClientConVar( "settings_shoulddraw", "10000", true, false)
CreateClientConVar( "rised_shadowrender_enable", "1", true, false)
CreateClientConVar( "rised_cinematic_overlay", "1", true, false)
CreateClientConVar( "risedMusic.enabled", "1", true, false)
CreateClientConVar( "risedTutorial.enabled", "1", true, false)

CreateClientConVar( "rised_HUD_enable", "1", true, false)
CreateClientConVar( "rised_HUD_Vital_enable", "1", true, false)
CreateClientConVar( "rised_HUD_Ammo_enable", "1", true, false)
CreateClientConVar( "rised_HUD_CombineInfo_enable", "1", true, false)
CreateClientConVar( "rised_HUD_MicroInfo_enable", "1", true, false)
CreateClientConVar( "rised_HUD_Visor_value", "50", true, false)

local align = 1;
local sx = ScrW();
local function col_count()
	return 1;
end;
local function col_size()
	return math.floor((sx-align*col_count())/col_count());
end;
local function getSize(col_count)
	return col_size()*col_count+align* (col_count-1);
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

function _blackberry.f4menu.pages.settings_func.initProfile(panel)
	local profile_panel = vgui.Create("DScrollPanel", panel);
	profile_panel:SetSize(col_size(), panel:GetTall());

	local profile_item_list = vgui.Create( "DIconLayout", profile_panel )
	profile_item_list:Dock(FILL);
	profile_item_list:SetSpaceX(250);
	profile_item_list:SetSpaceY(16);

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

	local header = vgui.Create("DPanel", profile_panel);
	header:SetSize(250,35);
	header.Paint = function(self, w, h)
		draw.SimpleText("Основные настройки", "Raleway 26", 0, h/2, Color(255, 255, 255, 255), 0, 1);

		surface.SetFont("Raleway 26");
		local width, height = surface.GetTextSize(L["my_profile"]);
		draw.RoundedBox(0, 0, h-1, width/2, 1, Color(_blackberry.f4menu.config["main_color"].r, _blackberry.f4menu.config["main_color"].g, _blackberry.f4menu.config["main_color"].b));
	end;
	
	local offset = 0

	local name2 = vgui.Create("DPanel", profile_panel);
	name2:SetSize(250,35);
	name2:SetPos( 0, 50 + offset  )
	name2.Paint = function(self, w, h)
		draw.SimpleText("Покачивание головы:", "Raleway 20", 0, 10, Color(255, 255, 255, 255), 0, 1);
	end;
	
	local headdrag_enable = GetConVar( "rised_headdrag_enable" )
	
	local checkbox2 = profile_panel:Add( "DCheckBox" )
	checkbox2:SetPos( 400, 50 + offset  )
	checkbox2:SetValue(headdrag_enable:GetBool())
	checkbox2:SetConVar("rised_headdrag_enable")

	offset = offset + 35
	
	local name3 = vgui.Create("DPanel", profile_panel);
	name3:SetSize(250,35);
	name3:SetPos( 0, 50 + offset  )
	name3.Paint = function(self, w, h)
		draw.SimpleText("Вид глазами персонажа:", "Raleway 20", 0, 10, Color(255, 255, 255, 255), 0, 1);
	end;
	
	local eyeview_enable = GetConVar( "eyeview_enabled" )
	
	local checkbox3 = profile_panel:Add( "DCheckBox" )
	checkbox3:SetPos( 400, 50 + offset  )
	checkbox3:SetValue(eyeview_enable:GetBool())
	checkbox3:SetConVar("eyeview_enabled")

	offset = offset + 35
	
	local name4 = vgui.Create("DPanel", profile_panel);
	name4:SetSize(450,35);
	name4:SetPos( 0, 50 + offset  )
	name4.Paint = function(self, w, h)
		draw.SimpleText("Вид от 3 лица: [bind F1 togglethirdperson]", "Raleway 20", 0, 10, Color(255, 255, 255, 255), 0, 1);
	end;
	
	local thirdpersonview_enable = GetConVar( "rised_thirdpersonview_enable" )
	
	local checkbox4 = profile_panel:Add( "DCheckBox" )
	checkbox4:SetPos( 400, 50 + offset  )
	checkbox4:SetValue(thirdpersonview_enable:GetBool())
	checkbox4:SetConVar("rised_thirdpersonview_enable")
	function checkbox4:OnChange( val )
		if val then
			togglethirdperson()
		else
			togglethirdperson()
		end
	end

	offset = offset + 35
	
	local name5 = vgui.Create("DPanel", profile_panel);
	name5:SetSize(250,35);
	name5:SetPos( 0, 50 + offset  )
	name5.Paint = function(self, w, h)
		draw.SimpleText("Дальность прорисовки предметов:", "Raleway 20", 0, 10, Color(255, 255, 255, 255), 0, 1);
	end;
	
	local settings_shoulddraw = GetConVar( "settings_shoulddraw" )
	
	local slider01 = vgui.Create("DNumSlider", profile_panel)
	slider01:SetPos( 250, 50 + offset  )
	slider01:SetSize( 250, 25 )
	slider01:SetText( "" )
	slider01:SetDark( false )
	slider01:SetMin( 0 )
	slider01:SetMax( 25000 )
	slider01:SetValue(settings_shoulddraw:GetBool())
	slider01:SetDecimals( 0 )
	slider01:SetConVar( "settings_shoulddraw" )

	offset = offset + 35
	
	local name6 = vgui.Create("DPanel", profile_panel);
	name6:SetSize(250,35);
	name6:SetPos( 0, 50 + offset  )
	name6.Paint = function(self, w, h)
		draw.SimpleText("Прорисовка теней:", "Raleway 20", 0, 10, Color(255, 255, 255, 255), 0, 1);
	end;
	
	local shadowrender_enable = GetConVar( "rised_shadowrender_enable" )
	
	local checkbox6 = profile_panel:Add( "DCheckBox" )
	checkbox6:SetPos( 400, 50 + offset  )
	checkbox6:SetValue(shadowrender_enable:GetBool())
	checkbox6:SetConVar("rised_shadowrender_enable")
	function checkbox6:OnChange( val )
		if val then
			RunConsoleCommand("r_shadows", "1")
		else
			RunConsoleCommand("r_shadows", "0")
		end
	end

	offset = offset + 35
	
	local name7 = vgui.Create("DPanel", profile_panel);
	name7:SetSize(450,35);
	name7:SetPos( 0, 50 + offset  )
	name7.Paint = function(self, w, h)
		draw.SimpleText("Кинематографичный оверлей", "Raleway 20", 0, 10, Color(255, 255, 255, 255), 0, 1);
	end;
	
	local rised_cinematic_overlay_enable = GetConVar( "rised_cinematic_overlay" )
	
	local checkbox7 = profile_panel:Add( "DCheckBox" )
	checkbox7:SetPos( 400, 50 + offset  )
	checkbox7:SetValue(rised_cinematic_overlay_enable:GetBool())
	checkbox7:SetConVar("rised_cinematic_overlay")

	offset = offset + 35

	local name = vgui.Create("DPanel", profile_panel);
	name:SetSize(250,35);
	name:SetPos( 0, 50 + offset )
	name.Paint = function(self, w, h)
		draw.SimpleText("Фоновая музыка:", "Raleway 20", 0, 10, Color(255, 255, 255, 255), 0, 1);
	end;
	
	local music_enable = GetConVar( "risedMusic.enabled" )
	
	local checkbox6 = profile_panel:Add( "DCheckBox" )
	checkbox6:SetPos( 400, 50 + offset  )
	checkbox6:SetValue(music_enable:GetBool())
	checkbox6:SetConVar("risedMusic.enabled")

	offset = offset + 35

	local name = vgui.Create("DPanel", profile_panel);
	name:SetSize(250,35);
	name:SetPos( 0, 50 + offset )
	name.Paint = function(self, w, h)
		draw.SimpleText("Громкость музыки:", "Raleway 20", 0, 10, Color(255, 255, 255, 255), 0, 1);
	end;
	
	local music_volume = GetConVar( "risedMusic.volume" )
	
	local slider01 = vgui.Create("DNumSlider", profile_panel)
	slider01:SetPos( 250, 50 + offset  )
	slider01:SetSize( 250, 25 )
	slider01:SetText( "" )
	slider01:SetDark( false )
	slider01:SetMin( 0 )
	slider01:SetMax( 100 )
	slider01:SetDecimals( 0 )
	slider01:SetConVar( "risedMusic.volume" )

	offset = offset + 35

	local name = vgui.Create("DPanel", profile_panel);
	name:SetSize(250,35);
	name:SetPos( 0, 50 + offset )
	name.Paint = function(self, w, h)
		draw.SimpleText("Режим обучения:", "Raleway 20", 0, 10, Color(255, 255, 255, 255), 0, 1);
	end;
	
	local tutorial_enable = GetConVar( "risedTutorial.enabled" )
	
	local checkbox7 = profile_panel:Add( "DCheckBox" )
	checkbox7:SetPos( 400, 50 + offset  )
	checkbox7:SetValue(tutorial_enable:GetBool())
	checkbox7:SetConVar("risedTutorial.enabled")





	offset = -50

	local header = vgui.Create("DPanel", profile_panel);
	header:SetSize(250,35);
	header:SetPos( ScrW()/2, 50 + offset )
	header.Paint = function(self, w, h)
		draw.SimpleText("Настройка интерфейса", "Raleway 26", 0, h/2, Color(255, 255, 255, 255), 0, 1);

		surface.SetFont("Raleway 26");
		local width, height = surface.GetTextSize(L["my_profile"]);
		draw.RoundedBox(0, 0, h-1, width/2, 1, Color(_blackberry.f4menu.config["main_color"].r, _blackberry.f4menu.config["main_color"].g, _blackberry.f4menu.config["main_color"].b));
	end;

	offset = offset + 55

	local name = vgui.Create("DPanel", profile_panel);
	name:SetSize(250,35);
	name:SetPos( ScrW()/2, 50 + offset )
	name.Paint = function(self, w, h)
		draw.SimpleText("Отображение HUD", "Raleway 20", 0, 10, Color(255, 255, 255, 255), 0, 1);
	end;
	
	local HUD_enable = GetConVar( "rised_HUD_enable" )
	
	local HUDCheckbox = profile_panel:Add( "DCheckBox" )
	HUDCheckbox:SetPos( ScrW()/2 + 400, 50 + offset  )
	HUDCheckbox:SetValue(HUD_enable:GetBool())
	HUDCheckbox:SetConVar("rised_HUD_enable")

	offset = offset + 35

	local name = vgui.Create("DPanel", profile_panel);
	name:SetSize(250,35);
	name:SetPos( ScrW()/2, 50 + offset )
	name.Paint = function(self, w, h)
		draw.SimpleText("Витальная информация", "Raleway 20", 0, 10, Color(255, 255, 255, 255), 0, 1);
	end;
	
	local HUD_Ammo_enable = GetConVar( "rised_HUD_Vital_enable" )
	
	local HUDCheckbox = profile_panel:Add( "DCheckBox" )
	HUDCheckbox:SetPos( ScrW()/2 + 400, 50 + offset  )
	HUDCheckbox:SetValue(HUD_Ammo_enable:GetBool())
	HUDCheckbox:SetConVar("rised_HUD_Vital_enable")

	offset = offset + 35

	local name = vgui.Create("DPanel", profile_panel);
	name:SetSize(250,35);
	name:SetPos( ScrW()/2, 50 + offset )
	name.Paint = function(self, w, h)
		draw.SimpleText("Патроны", "Raleway 20", 0, 10, Color(255, 255, 255, 255), 0, 1);
	end;
	
	local HUD_Ammo_enable = GetConVar( "rised_HUD_Ammo_enable" )
	
	local HUDCheckbox = profile_panel:Add( "DCheckBox" )
	HUDCheckbox:SetPos( ScrW()/2 + 400, 50 + offset  )
	HUDCheckbox:SetValue(HUD_Ammo_enable:GetBool())
	HUDCheckbox:SetConVar("rised_HUD_Ammo_enable")

	offset = offset + 35

	local name = vgui.Create("DPanel", profile_panel);
	name:SetSize(250,35);
	name:SetPos( ScrW()/2, 50 + offset )
	name.Paint = function(self, w, h)
		draw.SimpleText("Информация альянса", "Raleway 20", 0, 10, Color(255, 255, 255, 255), 0, 1);
	end;
	
	local HUD_Ammo_enable = GetConVar( "rised_HUD_CombineInfo_enable" )
	
	local HUDCheckbox = profile_panel:Add( "DCheckBox" )
	HUDCheckbox:SetPos( ScrW()/2 + 400, 50 + offset  )
	HUDCheckbox:SetValue(HUD_Ammo_enable:GetBool())
	HUDCheckbox:SetConVar("rised_HUD_CombineInfo_enable")

	offset = offset + 35

	local name = vgui.Create("DPanel", profile_panel);
	name:SetSize(250,35);
	name:SetPos( ScrW()/2, 50 + offset )
	name.Paint = function(self, w, h)
		draw.SimpleText("Микрофон и режим голоса", "Raleway 20", 0, 10, Color(255, 255, 255, 255), 0, 1);
	end;
	
	local HUD_Ammo_enable = GetConVar( "rised_HUD_MicroInfo_enable" )
	
	local HUDCheckbox = profile_panel:Add( "DCheckBox" )
	HUDCheckbox:SetPos( ScrW()/2 + 400, 50 + offset  )
	HUDCheckbox:SetValue(HUD_Ammo_enable:GetBool())
	HUDCheckbox:SetConVar("rised_HUD_MicroInfo_enable")

	offset = offset + 35
	
	local name5 = vgui.Create("DPanel", profile_panel);
	name5:SetSize(250,35);
	name5:SetPos( ScrW()/2, 50 + offset  )
	name5.Paint = function(self, w, h)
		draw.SimpleText("Визор Альянса:", "Raleway 20", 0, 10, Color(255, 255, 255, 255), 0, 1);
	end;
	
	local HUD_Visor_value = GetConVar( "rised_HUD_Visor_value" )
	
	local slider01 = vgui.Create("DNumSlider", profile_panel)
	slider01:SetPos( ScrW()/2 + 250, 50 + offset  )
	slider01:SetSize( 250, 25 )
	slider01:SetText( "" )
	slider01:SetDark( false )
	slider01:SetMin( 0 )
	slider01:SetMax( 100 )
	slider01:SetValue(HUD_Visor_value:GetBool())
	slider01:SetDecimals( 0 )
	slider01:SetConVar( "rised_HUD_Visor_value" )

end;

function _blackberry.f4menu.pages.settings(parent)
	_blackberry.f4menu.pages.settings_func.initProfile(parent)
end;










