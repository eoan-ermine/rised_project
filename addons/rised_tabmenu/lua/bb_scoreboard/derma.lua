-- "addons\\rised_tabmenu\\lua\\bb_scoreboard\\derma.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
// Global vars
local _blackberry = _blackberry or {};
_blackberry.scoreboard = _blackberry.scoreboard or {};
_blackberry.scoreboard.derma = _blackberry.scoreboard.derma or {};

function _blackberry.scoreboard.derma.loadBase()
	local files, directories = file.Find( _blackberry.scoreboard.dir.."/derma/*.lua", "LUA" );
	for k,v in pairs(files) do
		if (table.HasValue({"..", "."}, v)) then continue; end;
		if (SERVER) then
			AddCSLuaFile(_blackberry.scoreboard.dir.."/derma/"..v);
		else
			include(_blackberry.scoreboard.dir.."/derma/"..v);
		end
	end
end;


function _blackberry.scoreboard.derma.init()
	_blackberry.scoreboard.derma.loadBase();
	return true;
end;