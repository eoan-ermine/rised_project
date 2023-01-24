-- "addons\\rised_tabmenu\\lua\\bb_scoreboard\\init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
// Global vars
local _blackberry = _blackberry or {};
_blackberry.scoreboard = _blackberry.scoreboard or {}; 

// Config Include
if (SERVER) then
	AddCSLuaFile(_blackberry.scoreboard.dir.."/config.lua");
	AddCSLuaFile(_blackberry.scoreboard.dir.."/derma.lua");
end
include(_blackberry.scoreboard.dir.."/config.lua");
include(_blackberry.scoreboard.dir.."/derma.lua");

// Derma Init
_blackberry.scoreboard.derma.init();