-- "addons\\rised_f4menu\\lua\\bb_f4menu\\derma\\base.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
// Global vars
local _blackberry = _blackberry or {};
_blackberry.f4menu = _blackberry.f4menu or {};
_blackberry.f4menu.derma = _blackberry.f4menu.derma or {};
_blackberry.f4menu.activeMenu = _blackberry.f4menu.activeMenu or nil;
_blackberry.f4menu.activeElement = _blackberry.f4menu.activeElement or "...";

local x, y, sx, sy = ScrW(), ScrH(), ScrW(), ScrH();

local shadow = Material( "_blackberry/shadow_s.png" );
local gradient = Material( "_blackberry/gradient_d.png" );

function _blackberry.f4menu.createWindow()
	if (IsValid(_blackberry.f4menu.activeMenu)) then
		_blackberry.f4menu.Close();
	end
	_blackberry.f4menu.activeElement = "...";
	
	_blackberry.f4menu.activeMenu = vgui.Create("DFrame");
	local _frame = _blackberry.f4menu.activeMenu;
	_frame:SetSize(sx, sy);
	_frame:SetPos(x/2-sx/2, y/2-sy/2);
	_frame:SetTitle("");
	_frame:SetDraggable(false);
	_frame:MakePopup();
	_frame:ShowCloseButton(false);
	_frame.startTime = SysTime();
	_frame.Paint = function(self, w, h)
		Derma_DrawBackgroundBlur(self, self.startTime);

		draw.SimpleText(_blackberry.f4menu.config.title, "Raleway ExtraBold 36", 25, 25, Color(_blackberry.f4menu.config["main_color"].r, _blackberry.f4menu.config["main_color"].g, _blackberry.f4menu.config["main_color"].b, 255), 0, 2);
		draw.SimpleText(_blackberry.f4menu.activeElement, "Raleway 24", 25, 25+36, Color(255, 255, 255, 255), 0, 2);

		self.ready = true;
	end;
	_frame.Think = function(self)
		if (self.ready && !self.hookCalled) then
			self.hookCalled = true;
			hook.Call("_blackberry.f4menu.derma.animInit");
		end;
	end;
end;

function _blackberry.f4menu.createButtonList()
	if (!IsValid(_blackberry.f4menu.activeMenu)) then return false; end;

	local buttonList = {};
	local startx = 25;
	local priorityTable = {};

	for k,v in pairs(_blackberry.f4menu.config.buttons) do
		if (!istable(priorityTable[v["priority"]])) then
			priorityTable[v["priority"]] = {};
		end
		table.insert(priorityTable[v["priority"]],v);
	end

	local pi = 0;
	for k1,v1 in pairs(priorityTable) do
		for k, v in pairs(v1) do
			if (!isfunction(v["callback"])) then
				v["callback"] = function() return true; end;
			end;
			if (!isfunction(v["customCheck"])) then
				v["customCheck"] = function() return true; end;
			end;
			buttonList[k1..k] = _blackberry.f4menu.derma.createButtonlist("• "..v["name"]);
			buttonList[k1..k]:SetParent(_blackberry.f4menu.activeMenu);
			buttonList[k1..k]:SetPos(startx, 25+36+24*2);
			buttonList[k1..k].DoClick = v["callback"];
			buttonList[k1..k].starttime = SysTime()+pi*0.1;
			startx = startx + 30 + buttonList[k1..k]:GetWide();

			if (!v["customCheck"]() || _blackberry.f4menu.config["buttons.disabled"][v["id"]]) then
				buttonList[k1..k].disabled = true;
			end
			pi = pi + 1;
		end
	end
end;
hook.Add("_blackberry.f4menu.derma.animInit", "_blackberry.f4menu.derma.animInit", _blackberry.f4menu.createButtonList);

function _blackberry.f4menu.Open()
	_blackberry.f4menu.createWindow();
	_blackberry.f4menu.btn_callbacks["dashboard"]();
end;

function _blackberry.f4menu.Close()
	if (!IsValid(_blackberry.f4menu.activeMenu)) then return false; end;
	_blackberry.f4menu.activeMenu:Close();
end;

function _blackberry.f4menu.Toggle()
	if (IsValid(_blackberry.f4menu.activeMenu)) then _blackberry.f4menu.Close(); return false; end;
	_blackberry.f4menu.Open(); return true;
end;

concommand.Add("_blackberry_f4menu_open", function()
	_blackberry.f4menu.Open();
end);


local F4Bind
hook.Add("PlayerBindPress", "_blackberry.f4menu", function(ply, bind, pressed)
    if string.find(bind, "gm_showspare2", 1, true) then
        F4Bind = input.KeyNameToNumber(input.LookupBinding(bind))
    end
end)

local toggled = false;
hook.Add("Think", "_blackberry.f4menu.toggle", function()
	local F4Bind = F4Bind or input.KeyNameToNumber(input.LookupBinding("gm_showspare2"));
	if (input.IsKeyDown(F4Bind)) then
		if (!toggled) then
			_blackberry.f4menu.Toggle();
			toggled = true;
		end
	else
		toggled = false;
	end;
end);