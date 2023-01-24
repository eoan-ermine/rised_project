-- "addons\\rised_f4menu\\lua\\bb_f4menu\\derma_functions.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if SERVER then return false; end;
// Global vars
local _blackberry = _blackberry or {};
_blackberry.f4menu = _blackberry.f4menu or {};
_blackberry.f4menu.btn_callbacks = _blackberry.f4menu.btn_callbacks or {};
_blackberry.f4menu.btn_customcheck = _blackberry.f4menu.btn_customcheck or {};
_blackberry.f4menu.pages = _blackberry.f4menu.pages or {};

// specialFunctions
function _blackberry.f4menu.CreateButton(id)
	local _tbl = {};
	_tbl["id"] = id;
	_tbl["name"] = "Init button";
	_tbl["type"] = "card";
	_tbl["priority"] = 0;
	_tbl["customCheck"] = false;
	_tbl["callback"] = false;

	_tbl["SetName"] = function(s, name)
		_tbl["name"] = name;
		return _tbl;
	end;
	_tbl["SetType"] = function(s, type)
		_tbl["type"] = type;
		return _tbl;
	end;
	_tbl["SetPriority"] = function(s, priority)
		_tbl["priority"] = priority;
		return _tbl;
	end;
	_tbl["SetCustomCheck"] = function(s, customCheck)
		_tbl["customCheck"] = customCheck;
		return _tbl;
	end;
	_tbl["SetCallback"] = function(s, callback)
		_tbl["callback"] = callback;
		return _tbl;
	end;

	return _tbl;
end;



// local
local callback_store = _blackberry.f4menu.btn_callbacks;
local customcheck_store = _blackberry.f4menu.btn_customcheck;

callback_store["dashboard"] = function(panel)
	local parent = _blackberry.f4menu.derma.CreateList(_blackberry.f4menu.config["buttons.name"]["dashboard"]);
	_blackberry.f4menu.pages.dashboard(parent);
end;
callback_store["shop"] = function(panel)
	local parent = _blackberry.f4menu.derma.CreateList(_blackberry.f4menu.config["buttons.name"]["shop"]);
	_blackberry.f4menu.pages.shop(parent)
end;
callback_store["jobs"] = function(panel)
	local parent = _blackberry.f4menu.derma.CreateList(_blackberry.f4menu.config["buttons.name"]["jobs"]);
	_blackberry.f4menu.pages.jobs(parent);
end;
callback_store["entities"] = function(panel)
	local parent = _blackberry.f4menu.derma.CreateList(_blackberry.f4menu.config["buttons.name"]["entities"]);
	_blackberry.f4menu.pages.entities(parent);
end;
callback_store["food"] = function(panel)
	local parent = _blackberry.f4menu.derma.CreateList(_blackberry.f4menu.config["buttons.name"]["food"]);
	_blackberry.f4menu.pages.food(parent);
end;
callback_store["settings"] = function(panel)
	local parent = _blackberry.f4menu.derma.CreateList(_blackberry.f4menu.config["buttons.name"]["settings"]);
	_blackberry.f4menu.pages.settings(parent);
end;
callback_store["exit"] = function(panel)
	_blackberry.f4menu.Close()
end;