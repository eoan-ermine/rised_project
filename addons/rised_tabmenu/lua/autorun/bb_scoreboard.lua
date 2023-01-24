-- "addons\\rised_tabmenu\\lua\\autorun\\bb_scoreboard.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
// Init vars
_blackberry = _blackberry or {};
_blackberry.scoreboard = _blackberry.scoreboard or {};
_blackberry.scoreboard.dir = "bb_scoreboard";

function _blackberry:Error(msg)
	MsgC("[Blackberry] ", Color(255, 0, 0), "ERROR ", Color(255,255,255), msg, "\n");
end;
function _blackberry:Notify(msg)
	MsgC("[Blackberry] ", Color(0, 255, 255), "NOTIFY ", Color(255,255,255), msg, "\n");
end;
function _blackberry:Alert(msg)
	MsgC("[Blackberry] ", Color(255, 0, 255), "ALERT ", Color(255,255,255), msg, "\n");
end;

if (SERVER) then
	resource.AddWorkshop("1587543422"); // Font
	AddCSLuaFile(_blackberry.scoreboard.dir.."/init.lua");
end
include(_blackberry.scoreboard.dir.."/init.lua");