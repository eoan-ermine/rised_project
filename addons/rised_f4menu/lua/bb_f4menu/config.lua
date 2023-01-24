-- "addons\\rised_f4menu\\lua\\bb_f4menu\\config.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
/*---------------------------------------------------------------------------
	> START: Don't touch this!!!!!
---------------------------------------------------------------------------*/
// Global vars
local _blackberry = _blackberry or {};
_blackberry.f4menu = _blackberry.f4menu or {};
_blackberry.f4menu.config = _blackberry.f4menu.config or {};

// local vars
local cfg = _blackberry.f4menu.config;

// Config external files
if (SERVER) then
	AddCSLuaFile(_blackberry.f4menu.dir.."/derma_functions.lua");
	return;
end
include(_blackberry.f4menu.dir.."/derma_functions.lua");
/*---------------------------------------------------------------------------
	> END: Don't touch this!!!!!
=============================================================================
	Config vars - Touch it :)
---------------------------------------------------------------------------*/

cfg["title"]			= "Rised Project";		// Name of window
cfg["button"] 			= KEY_F4;					// Button for open menu
cfg["main_color"] 		= Color(255, 255, 225);		// Default: Color(255, 209, 55) 76561198037478504
cfg["food_enabled"] 	= false;					// Food module
cfg["search_line"]		= true;					// Search line for job section
cfg["double_job_line"]	= false;					// Add second line if width of resolution >= 1000 px :3
cfg["model_chooser"]	= true;					// model chooser for jobs with many models
cfg["disable_commands"] = false;					// Disable all commands in dashboard
cfg["job_scale"]		= false;

cfg["sound_click"]		= "garrysmod/ui_click.wav";
cfg["sound_hover"]		= "garrysmod/ui_hover.wav";

-- Buttons: name
cfg["buttons.name"] = {								// List of names for buttons
	["dashboard"] 		= "Основное",
	["jobs"] 			= "Профессии",
	["shop"] 			= "Магазин",
	["entities"] 		= "Предметы",
	["food"] 			= "Еда",
	["settings"] 		= "Настройки",
	["exit"] 			= "Выйти"
};

-- Buttons: disabled
cfg["buttons.disabled"] = {							// Use 'true' for remove button from list
	["dashboard"] 		= false,
	["jobs"] 			= true,
	["shop"] 			= false,
	["entities"] 		= false,
	["food"] 			= !cfg["food_enabled"],
	["disabled"] 		= true,
	["settings"] 		= false,
};

/*---------------------------------------------------------------------------
	Buttons list
	> Ann: 	Please, don't remove anythink from this, use for it `cfg["buttons.disabled"]`
---------------------------------------------------------------------------*/
cfg["buttons"] = {};

///////////////////////////////////////////////////////////
local item = _blackberry.f4menu.CreateButton("dashboard")
:SetName(cfg["buttons.name"]["dashboard"])
:SetPriority(1)
:SetCustomCheck(false)
:SetCallback(_blackberry.f4menu.btn_callbacks["dashboard"]);
table.insert(cfg["buttons"], 1, item); item = nil;

///////////////////////////////////////////////////////////
--local item =  _blackberry.f4menu.CreateButton("jobs")
--:SetName(cfg["buttons.name"]["jobs"])
--:SetPriority(2)
--:SetCustomCheck(false)
--:SetCallback(_blackberry.f4menu.btn_callbacks["jobs"]);
--table.insert(cfg["buttons"], 1, item); item = nil;

///////////////////////////////////////////////////////////
local item =  _blackberry.f4menu.CreateButton("shop")
:SetName(cfg["buttons.name"]["shop"])
:SetPriority(3)
:SetCustomCheck(false)
:SetCallback(_blackberry.f4menu.btn_callbacks["shop"]);
table.insert(cfg["buttons"], 1, item); item = nil;

///////////////////////////////////////////////////////////
local item = _blackberry.f4menu.CreateButton("entities")
:SetName(cfg["buttons.name"]["entities"])
:SetPriority(4)
:SetCustomCheck(false)
:SetCallback(_blackberry.f4menu.btn_callbacks["entities"]);
table.insert(cfg["buttons"], 1, item); item = nil;

///////////////////////////////////////////////////////////
--local item = _blackberry.f4menu.CreateButton("food")
--:SetName(cfg["buttons.name"]["food"])
--:SetPriority(5)
--:SetCustomCheck(false)
--:SetCallback(_blackberry.f4menu.btn_callbacks["food"]);
--table.insert(cfg["buttons"], 1, item); item = nil;

///////////////////////////////////////////////////////////
local item =  _blackberry.f4menu.CreateButton("settings")
:SetName(cfg["buttons.name"]["settings"])
:SetPriority(6)
:SetCustomCheck(false)
:SetCallback(_blackberry.f4menu.btn_callbacks["settings"]);
table.insert(cfg["buttons"], 1, item); item = nil;

///////////////////////////////////////////////////////////
local item = _blackberry.f4menu.CreateButton("exit")
:SetName(cfg["buttons.name"]["exit"])
:SetPriority(99)
:SetCallback(_blackberry.f4menu.btn_callbacks["exit"]);
table.insert(cfg["buttons"], 1, item); item = nil;
