-- "addons\\sh_reports\\lua\\autorun\\autorun_reports.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SH_REPORTS = {}

include("reports/lib_easynet.lua")
include("reports/sh_main.lua")
include("reports_config.lua")

IncludeCS("reports/language/" .. (SH_REPORTS.LanguageName or "english") .. ".lua")

if (SERVER) then
	AddCSLuaFile("reports/lib_loungeui.lua")
	AddCSLuaFile("reports/lib_easynet.lua")
	AddCSLuaFile("reports/sh_main.lua")
	AddCSLuaFile("reports/cl_main.lua")
	AddCSLuaFile("reports/cl_menu_main.lua")
	AddCSLuaFile("reports/cl_menu_make.lua")
	AddCSLuaFile("reports/cl_menu_performance.lua")
	AddCSLuaFile("reports/cl_menu_rating.lua")
	AddCSLuaFile("reports_config.lua")

	include("reports/lib_database.lua")
	include("reports/sv_main.lua")
else
	include("reports/lib_loungeui.lua")
	include("reports/cl_main.lua")
	include("reports/cl_menu_main.lua")
	include("reports/cl_menu_make.lua")
	include("reports/cl_menu_performance.lua")
	include("reports/cl_menu_rating.lua")
end