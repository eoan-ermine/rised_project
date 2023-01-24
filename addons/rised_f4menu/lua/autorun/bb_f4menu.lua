-- "addons\\rised_f4menu\\lua\\autorun\\bb_f4menu.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
// Init vars 76561198037478504
_blackberry = _blackberry or {};
_blackberry.f4menu = _blackberry.f4menu or {};
_blackberry.f4menu.dir = "bb_f4menu";

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
	AddCSLuaFile(_blackberry.f4menu.dir.."/init.lua");
end
include(_blackberry.f4menu.dir.."/init.lua");