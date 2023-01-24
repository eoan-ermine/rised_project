-- "addons\\zlib-1.3\\lua\\zlib\\sh_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    zlib - (SH) Init
    Developed by Zephruz
]]

--[[Load zlib Base]]
AddCSLuaFile("sh_util.lua")
AddCSLuaFile("sh_includes.lua")
AddCSLuaFile("sh_object.lua")
AddCSLuaFile("sh_cache.lua")
AddCSLuaFile("sh_http.lua")
AddCSLuaFile("sh_cmds.lua")
AddCSLuaFile("sh_data.lua")
AddCSLuaFile("sh_notifs.lua")
AddCSLuaFile("sh_language.lua")
AddCSLuaFile("sh_addons.lua")
AddCSLuaFile("networking/sh_networking.lua")

include("sh_util.lua")
include("sh_includes.lua")
include("sh_object.lua")
include("sh_cache.lua")
include("sh_http.lua")
include("sh_cmds.lua")
include("sh_data.lua")
include("sh_notifs.lua")
include("sh_language.lua")
include("sh_addons.lua")
include("networking/sh_networking.lua")

--[[Load Extra Utils]]
local files, dirs = file.Find("zlib/util/*", "LUA")

for k,v in pairs(files) do
    zlib.util:IncludeByPath(v, "util/")
end