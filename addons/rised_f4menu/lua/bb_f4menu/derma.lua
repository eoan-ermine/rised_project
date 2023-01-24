-- "addons\\rised_f4menu\\lua\\bb_f4menu\\derma.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
// Global vars
local _blackberry = _blackberry or {};
_blackberry.f4menu = _blackberry.f4menu or {};
_blackberry.f4menu.derma = _blackberry.f4menu.derma or {};

function _blackberry.f4menu.derma.loadBase()
	local files, directories = file.Find( _blackberry.f4menu.dir.."/derma/*.lua", "LUA" );
	for k,v in pairs(files) do
		if (table.HasValue({"..", "."}, v)) then continue; end;
		if (SERVER) then
			AddCSLuaFile(_blackberry.f4menu.dir.."/derma/"..v);
		else
			include(_blackberry.f4menu.dir.."/derma/"..v);
		end
	end
end;

function _blackberry.f4menu.derma.loadPages()
	local files, directories = file.Find( _blackberry.f4menu.dir.."/pages/*.lua", "LUA" );
	for k,v in pairs(files) do
		if (table.HasValue({"..", "."}, v)) then continue; end;
		if (SERVER) then
			AddCSLuaFile(_blackberry.f4menu.dir.."/pages/"..v);
		else
			include(_blackberry.f4menu.dir.."/pages/"..v);
		end
	end
	return true;
end;


function _blackberry.f4menu.derma.init()
	_blackberry.f4menu.derma.loadBase();
	_blackberry.f4menu.derma.loadPages();
	return true;
end;