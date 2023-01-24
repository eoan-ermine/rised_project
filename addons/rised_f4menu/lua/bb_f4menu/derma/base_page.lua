-- "addons\\rised_f4menu\\lua\\bb_f4menu\\derma\\base_page.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
// Global vars
local _blackberry = _blackberry or {};
_blackberry.f4menu = _blackberry.f4menu or {};
_blackberry.f4menu.derma = _blackberry.f4menu.derma or {};
_blackberry.f4menu.activeMenu = _blackberry.f4menu.activeMenu or nil;
_blackberry.f4menu.activeElement = _blackberry.f4menu.activeElement or "...";


_blackberry.f4menu.derma.CreateList = function(activeName)
	if (!IsValid(_blackberry.f4menu.activeMenu)) then return; end;
	if (IsValid(_blackberry.f4menu.activeMenu.activePanel)) then _blackberry.f4menu.activeMenu.activePanel:Remove(); end;
	local psx, psy = _blackberry.f4menu.activeMenu:GetWide(), _blackberry.f4menu.activeMenu:GetTall();

	_blackberry.f4menu.activeMenu.activePanel = vgui.Create("DPanel", _blackberry.f4menu.activeMenu);
	local panel = _blackberry.f4menu.activeMenu.activePanel;
	panel:SetSize(psx-50, psy-10-150);
	panel:SetPos(25, 155);
	panel.Paint = function() end;
	_blackberry.f4menu.activeElement = activeName;
	
	return panel;
end;