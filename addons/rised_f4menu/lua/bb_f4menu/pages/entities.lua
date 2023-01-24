-- "addons\\rised_f4menu\\lua\\bb_f4menu\\pages\\entities.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
// Global vars
local _blackberry = _blackberry or {};
_blackberry.f4menu = _blackberry.f4menu or {};
_blackberry.f4menu.derma = _blackberry.f4menu.derma or {};
_blackberry.f4menu.pages = _blackberry.f4menu.pages or {};
_blackberry.f4menu.activeMenu = _blackberry.f4menu.activeMenu or nil;
_blackberry.f4menu.pages.ents_func = _blackberry.f4menu.pages.ents_func or {};

local align = 25;
local sx = ScrW();
local function col_count()
	return sx >= 1200 and math.floor(sx/200) or 5;
end;
local function col_size()
	return math.floor((sx-align*col_count())/col_count());
end;
local function getSize(col_count)
	return col_size()*col_count+align*(col_count-1);
end;

// local vars
local cfg = _blackberry.f4menu.config;
local L = _blackberry.f4menu.lang;

local function getCategories(array)
	local categories = {};
	for k,v in pairs(array) do
		if (!table.HasValue(categories, v.category)) then
			table.insert(categories, 1, v.category);
		end;
	end;
	return categories;
end;

function _blackberry.f4menu.pages.ents_func.init(parent)
	local sx = parent:GetWide();
	parent.ents = vgui.Create("DScrollPanel", parent);
	parent.ents:SetSize(sx, parent:GetTall()-20);
	parent.ents:SetPos(0, 20);
	parent.ents.Paint = function(self, w, h)
	end;

	parent.ents.item_list = vgui.Create( "DIconLayout", parent.ents )
	parent.ents.item_list:Dock(FILL);
	parent.ents.item_list:SetSpaceX(0);
	parent.ents.item_list:SetSpaceY(8);

	local sbar = parent.ents:GetVBar();
	sbar:SetWide(2);
	function sbar:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	function sbar.btnUp:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100)) 
	end
	function sbar.btnDown:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	function sbar.btnGrip:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
	end

	local start_item = vgui.Create("DPanel", parent.ents.item_list);
	start_item:SetSize(sx, 35);
	start_item.Paint = function(self, w, h)
		draw.SimpleText(L["entities"], "Raleway Bold 22", 0, h/2, Color(255, 255, 255, 255), 0, 1);

		surface.SetFont("Raleway Bold 22");
		local width, height = surface.GetTextSize(L["entities"]);
		draw.RoundedBox(0, 0, h-1, width/2, 2, Color(_blackberry.f4menu.config["main_color"].r, _blackberry.f4menu.config["main_color"].g, _blackberry.f4menu.config["main_color"].b));
	end;
	local avaliableCount = 0;
	/*---------------------------------------------------------------------------
	Entities
	---------------------------------------------------------------------------*/
    local categories = getCategories(DarkRPEntities);
    for _, category in pairs(categories) do
    	local cat_items = 0;

		local cat_info = vgui.Create("DPanel", parent.ents.item_list);
		cat_info:SetSize(sx, 20);
		cat_info.Paint = function(self, w, h)
			draw.SimpleText(category, "Raleway Bold 18", 0, h/2, Color(255, 255, 255, 100), 0, 1);
		end; 

	    for k,v in pairs(DarkRPEntities) do
		
			local needswepblock = true
			if v.workstatus != nil then
				if LocalPlayer():GetNWString("Player_WorkStatus") == v.workstatus then
					needswepblock = false
				end
			end
			
	    	if (v.category != category) then continue; end;
   			if (v.allowed and !table.HasValue(v.allowed, LocalPlayer():Team())) and needswepblock then continue; end
	    	if (v.customCheck and !v.customCheck(LocalPlayer())) then continue; end;
	    	avaliableCount = avaliableCount + 1;
	    	cat_items = cat_items + 1;

			local btn_panel = vgui.Create("DButton", parent.ents.item_list);
			btn_panel:SetSize(col_size(),48);
			btn_panel:SetText("");
			btn_panel.Paint = function(self, w, h)
				local bgColor = self.Active and 1 or 0;
				self.lerp1 = self.lerp1 or bgColor;
				self.lerp1 = Lerp(FrameTime()*5, self.lerp1, bgColor);

				draw.RoundedBox(0, 10, 0, 48, 48, Color(0, 0, 0, 100));
				//draw.RoundedBox(0, 58, 0, w-10-48, h, Color(0, 0, 0, 50));
				draw.RoundedBox(0, 58, 0, w-10-48, h, Color(_blackberry.f4menu.config["main_color"].r, _blackberry.f4menu.config["main_color"].g, _blackberry.f4menu.config["main_color"].b, 50*self.lerp1));

				draw.RoundedBox(0, 10/2-2, h/2-2, 4, 4, Color(0, 0, 0, 100));
				draw.RoundedBox(0, 10/2-2, h/2-2, 4, 4, Color(_blackberry.f4menu.config["main_color"].r, _blackberry.f4menu.config["main_color"].g, _blackberry.f4menu.config["main_color"].b, 150*self.lerp1));

				draw.SimpleText(v.name, "Raleway Bold 15", 10+48+5, 2, Color(255, 255, 255, 100), 0, 0);
				draw.SimpleText(v.name, "Raleway Bold 15", 10+48+5, 2, Color(255, 255, 255, 255*self.lerp1), 0, 0);

				local newPrice = v.price
				if LocalPlayer():GetNWBool("Rised_Premium") then
					newPrice = newPrice * 0.85
				end
		
				draw.SimpleText(L["max"]..": "..v.max, "Raleway 15", 10+48+5, 17, Color(255, 255, 255, 100), 0, 0);
				draw.SimpleText(L["price"]..": "..DarkRP.formatMoney(newPrice), "Raleway 15", 10+48+5, 32, Color(_blackberry.f4menu.config["main_color"].r, _blackberry.f4menu.config["main_color"].g, _blackberry.f4menu.config["main_color"].b, 150), 0, 0);

				draw.SimpleText(L["max"]..": "..v.max, "Raleway 15", 10+48+5, 17, Color(255, 255, 255, 255*self.lerp1), 0, 0);
				draw.SimpleText(L["price"]..": "..DarkRP.formatMoney(newPrice), "Raleway 15", 10+48+5, 32, Color(255, 255, 255, 255*self.lerp1), 0, 0);
			end;
			btn_panel.OnCursorEntered = function(self)
				surface.PlaySound(cfg["sound_hover"]);
				self.Active = true;
			end;
			btn_panel.OnCursorExited = function(self)
				self.Active = false;
			end;
			btn_panel.DoClick = function()
				surface.PlaySound(cfg["sound_click"]);
				RunConsoleCommand("DarkRP", v.cmd);
				_blackberry.f4menu.Close();
			end;
			local icon = vgui.Create("ModelImage", btn_panel);
			icon:SetSize(48, 48);
			icon:SetPos(10, 0);
			icon:SetModel(istable(v.model) and table.Random(v.model) or v.model, 1, "000000000");
	    end;
	    if (cat_items == 0) then
	    	cat_info:Remove();
	    end;
	end;
	/*---------------------------------------------------------------------------
	end
	---------------------------------------------------------------------------*/
    if (avaliableCount == 0) then
		local info = vgui.Create("DPanel", parent.ents.item_list);
		info:SetSize(sx, 20);
		info.Paint = function(self, w, h)
			draw.SimpleText(L["no_items_available"], "Raleway 18", 0, h/2, Color(255, 255, 255, 100), 0, 1);
		end;
    end;
end;

function _blackberry.f4menu.pages.entities(parent)
	_blackberry.f4menu.pages.ents_func.init(parent);
	_blackberry.f4menu.pages.ents_func.initInfo(parent);
end;

function _blackberry.f4menu.pages.ents_func.initInfo(parent)
	parent.moneyInfo = vgui.Create("DPanel", parent);
	parent.moneyInfo:SetSize(parent:GetWide(), 20);
	parent.moneyInfo:SetPos(0, 0);
	parent.moneyInfo.Paint = function(self, w, h)
		surface.SetFont("Raleway Bold 18");
		local width, _ = surface.GetTextSize(L["cash"]);
		draw.SimpleText(L["cash"], "Raleway Bold 18", 0, h/2, Color(255, 255, 255, 150), 0, 1);
		draw.SimpleText(DarkRP.formatMoney(LocalPlayer():getDarkRPVar("money")), "Raleway Bold 18", width+5, h/2, Color(_blackberry.f4menu.config["main_color"].r, _blackberry.f4menu.config["main_color"].g, _blackberry.f4menu.config["main_color"].b, 150), 0, 1);
	end;
end;
