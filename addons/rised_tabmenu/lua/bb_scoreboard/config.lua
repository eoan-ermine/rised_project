-- "addons\\rised_tabmenu\\lua\\bb_scoreboard\\config.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
/*---------------------------------------------------------------------------
	> START: Don't touch this!!!!!
---------------------------------------------------------------------------*/
/*-don't touch-*/	// Global vars core.config["minimalistic"]
/*-don't touch-*/	local _blackberry = _blackberry or {};
/*-don't touch-*/	_blackberry.scoreboard = _blackberry.scoreboard or {};
/*-don't touch-*/	local core = _blackberry.scoreboard;
/*-don't touch-*/	core.config = core.config or {};
/*---------------------------------------------------------------------------
	> END: Don't touch this!!!!!
=============================================================================
	Config vars - Touch it :)
---------------------------------------------------------------------------*/

core.config["title"]			= "Rised Project";		// Name of window
core.config["main_color"] 		= Color(255, 255, 225);		// Default: Color(255, 209, 55)
core.config["fadmin"]			= true;  					// Add commands from fadmin
core.config["sort_by_default"]	= "Jobs";					// Available: Jobs or Names
core.config["double_line"]		= false;

core.config["staff_replace"]	= {							// replace usergroup to normal show
	["superadmin"]				= "Десница",
	["hand"]					= "Десница",
	["retinue"]					= "Свита",
	["guard"]					= "Гвард",
	["meister"]					= "Мейстер",
	["inquisitor"]				= "Инквизитор",
	["censor"]					= "Цензор",
	["cerber"]					= "Цербер",
	["user"]					= "Игрок",
	["mecenat"]					= "Меценат",
	
	["builder"]						= "Билдер",
	["candidate"]					= "Кандидат",
	["inf_moderator"]				= "Модератор",
	["sup_moderator"]				= "Ст. Модератор",
	["admin_III"]					= "Администратор III",
	["admin_II"]					= "Администратор II",
	["admin_I"]						= "Администратор I",
	["rec_eventer"]					= "Мл. Ивентер",
	["inf_eventer"]					= "Ивентер",
	["sup_eventer"]					= "Ст. Ивентер",
	["event_manager"]				= "Ивент Менеджер",
}