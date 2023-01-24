-- "addons\\rised_f4menu\\lua\\bb_f4menu\\pages\\jobs.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
// Global vars
local _blackberry = _blackberry or {};
_blackberry.f4menu = _blackberry.f4menu or {};
_blackberry.f4menu.derma = _blackberry.f4menu.derma or {};
_blackberry.f4menu.pages = _blackberry.f4menu.pages or {};
_blackberry.f4menu.activeMenu = _blackberry.f4menu.activeMenu or nil;
_blackberry.f4menu.pages.jobs_func = _blackberry.f4menu.pages.jobs_func or {};

local align = 25;
local sx = ScrW();
local function col_count()
	return sx >= 1200 and math.floor(sx/250) or 4;
end;
local function col_size()
	return math.floor((sx-align*col_count())/col_count());
end;
local function getSize(col_count)
	return col_size()*col_count+align*(col_count-1);
end;

local cfg = _blackberry.f4menu.config;
local L = _blackberry.f4menu.lang;


function _blackberry.f4menu.pages.jobs_func.initJobList(parent)
	if (cfg["search_line"]) then
		parent.search = vgui.Create("DTextEntry", parent);
		parent.search:SetSize(cfg["double_job_line"] and getSize(2) or getSize(1), 50);
		parent.search:SetPos(0, 0);
		parent.search:SetText("");
		parent.search.Paint = function(self, w, h)
			self.alpha = self.alpha or 0; 
			draw.RoundedBox(0, 0, 0, w, 25, Color(0, 0, 0, 100));
			if (self:IsEditing()) then
				self.alpha = Lerp(FrameTime()*4, self.alpha, 1); 
			else
				self.alpha = Lerp(FrameTime()*2, self.alpha, 0); 
			end;
			draw.RoundedBox(0, 0, 0, w, 25, Color(cfg["main_color"].r, cfg["main_color"].g, cfg["main_color"].b, 75*self.alpha));
			if (self:GetText() == "") then
				draw.SimpleText("Search by name"..(cfg["search_category"] and " or category name" or ""), "Raleway 15", 5, 25/2, Color(255, 255, 255, 100), 0, 1);
			end;
			draw.SimpleText(self:GetText(), "Raleway Bold 15", 5, 25/2, Color(255, 255, 255, 255), 0, 1);

			draw.SimpleText(L["search_press"], "Raleway 11", 1, 27, Color(cfg["main_color"].r, cfg["main_color"].g, cfg["main_color"].b, 100), 0, 0);
		end;
		parent.search.OnEnter = function()
			parent.BuildJobPanel();
		end
	end

	local job_panel = vgui.Create("DScrollPanel", parent);
	job_panel:SetSize(cfg["double_job_line"] and getSize(2) or getSize(1), parent:GetTall() - (cfg["search_line"] and 50 or 0));
	job_panel:SetPos(0, cfg["search_line"] and 50 or 0);
	job_panel.Paint = function(self, w, h)
	end;

	local job_item_list = vgui.Create( "DIconLayout", job_panel )
	job_item_list:Dock(FILL);
	job_item_list:SetSpaceX(10);
	job_item_list:SetSpaceY(10);

	local sbar = job_panel:GetVBar();
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

	function parent.BuildJobPanel()
		job_item_list:Clear();
		local teamsInList = {};
    	local categories = DarkRP.getCategories().jobs;

	    for _, cat in pairs(categories) do
	    	if (cat.canSee and !cat.canSee(LocalPlayer())) then continue; end;
	    	if (#cat.members == 0) then continue; end;
	    	local member_count = 0;
			local header = vgui.Create("DPanel", job_item_list);
			header:SetSize(parent:GetWide(), 35);
			header.Paint = function(self, w, h)
				draw.SimpleText(cat.name, "Raleway Bold 22", 0, h/2, Color(255, 255, 255, 255), 0, 1);

				surface.SetFont("Raleway Bold 22");
				local width, height = surface.GetTextSize(cat.name);
				draw.RoundedBox(0, 0, h-1, width/2, 2, Color(255, 255, 255));
				draw.RoundedBox(0, 0, h-1, width/2, 2, cat.color or Color(cfg["main_color"].r, cfg["main_color"].g, cfg["main_color"].b));
			end;

	    	for k, v in pairs(cat.members) do
	    		teamsInList[v.team] = true;
	    		if (v.team == LocalPlayer():Team()) then continue; end;
	    		if (v.NeedToChangeFrom) then
	    			if (istable(v.NeedToChangeFrom) and !table.HasValue(v.NeedToChangeFrom,LocalPlayer():Team())) then continue; end;
	    			if (isnumber(v.NeedToChangeFrom) and LocalPlayer():Team() != v.NeedToChangeFrom) then continue; end;
	    		end
	    		if (v.customCheck and !v.customCheck(LocalPlayer())) then continue; end;
	    		if (cfg["search_line"]) then
					local txt_search = string.Replace(parent.search:GetText():lower()," ","+.+");
					txt_search = txt_search or "";
					local find_res1, _, _ = string.find(v.name:lower(), txt_search);
					local find_res2, _, _ = string.find(cat.name:lower(), txt_search);

					if (!find_res1 and !find_res2) then continue; end;
				end;
				member_count = member_count + 1;
				local btn_panel = vgui.Create("DButton", job_item_list);
				btn_panel:SetSize(col_size()/*cfg["double_job_line"] and 200 or 250 76561198037478504*/,cfg["job_scale"] and 48 or 32);
				btn_panel.sy = cfg["job_scale"] and 48 or 32;
				btn_panel:SetText("");
				btn_panel.Paint = function(self, w, h)
					local bgColor = self.Active and 1 or 0;
					self.lerp1 = self.lerp1 or bgColor;
					self.lerp1 = Lerp(FrameTime()*5, self.lerp1, bgColor);

					draw.RoundedBox(0, 10, 0, self.sy, self.sy, Color(0, 0, 0, 100));
					draw.RoundedBox(0, 10+self.sy, 0, w-10-self.sy, h, Color(v.color.r, v.color.g, v.color.b, 150*self.lerp1));

					draw.RoundedBox(0, 10/2-2, h/2-2, 4, 4, Color(0, 0, 0, 100));
					draw.RoundedBox(0, 10/2-2, h/2-2, 4, 4, v.color);

					draw.SimpleText(v.name, "Raleway Bold "..(cfg["job_scale"] and 17 or 13), 10+self.sy+5, h/2, Color(255, 255, 255, 100), 0, 1);
					draw.SimpleText(v.name, "Raleway Bold "..(cfg["job_scale"] and 17 or 13), 10+self.sy+5, h/2, Color(255, 255, 255, 255*self.lerp1), 0, 1);
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
					parent.playerJobList.item_list.BuildPlayers(v.team, v.name, v.max);
					_blackberry.f4menu.pages.jobs_func.initPlayerInfoList(parent, v);
				end;

				local icon = vgui.Create("ModelImage", btn_panel);
				icon:SetSize(cfg["job_scale"] and 48 or 32, cfg["job_scale"] and 48 or 32);
				icon:SetPos(10, 0);
	    		icon:SetModel(istable(v.model) and table.Random(v.model) or v.model, 1, "000000000");
			end;
			if (member_count == 0) then
				header:Remove();
			end;
	    end;
	    
    	local member_count = 0;
		local header = vgui.Create("DPanel", job_item_list);
		header:SetSize(parent:GetWide(), 35);
		header.Paint = function(self, w, h)
			draw.SimpleText("...", "Raleway Bold 22", 0, h/2, Color(255, 255, 255, 255), 0, 1);

			surface.SetFont("Raleway Bold 22");
			local width, height = surface.GetTextSize("...");
			draw.RoundedBox(0, 0, h-1, width/2, 2, Color(255, 255, 255));
		end;

	    for k,v in pairs(RPExtraTeams) do
	    	if (teamsInList[v.team]) then continue; end;
    		if (v.team == LocalPlayer():Team()) then continue; end;
    		if (v.NeedToChangeFrom) then
    			if (istable(v.NeedToChangeFrom) and !table.HasValue(v.NeedToChangeFrom,LocalPlayer():Team())) then continue; end;
    			if (LocalPlayer():Team() != v.NeedToChangeFrom) then continue; end;
    		end
    		if (v.customCheck and !v.customCheck(LocalPlayer())) then continue; end;

    		if (cfg["search_line"]) then
				local txt_search = string.Replace(parent.search:GetText():lower()," ","+.+");
				txt_search = txt_search or "";
				local find_res1, _, _ = string.find(v.name:lower(), txt_search);

				if (!find_res1 and !find_res2) then continue; end;
			end;
			member_count = member_count + 1;
			local btn_panel = vgui.Create("DButton", job_item_list);
			btn_panel:SetSize(col_size()/*cfg["double_job_line"] and 200 or 250*/,32);
			btn_panel.sy = 32;
			btn_panel:SetText("");
			btn_panel.Paint = function(self, w, h)
				local bgColor = self.Active and 1 or 0;
				self.lerp1 = self.lerp1 or bgColor;
				self.lerp1 = Lerp(FrameTime()*5, self.lerp1, bgColor);

				draw.RoundedBox(0, 10, 0, 32, 32, Color(0, 0, 0, 100));
				draw.RoundedBox(0, 42, 0, w-10-32, h, Color(v.color.r, v.color.g, v.color.b, 150*self.lerp1));

				draw.RoundedBox(0, 10/2-2, h/2-2, 4, 4, Color(0, 0, 0, 100));
				draw.RoundedBox(0, 10/2-2, h/2-2, 4, 4, v.color);

				draw.SimpleText(v.name, "Raleway Bold 13", 10+32+5, h/2, Color(255, 255, 255, 100), 0, 1);
				draw.SimpleText(v.name, "Raleway Bold 13", 10+32+5, h/2, Color(255, 255, 255, 255*self.lerp1), 0, 1);
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
				parent.playerJobList.item_list.BuildPlayers(v.team, v.name, v.max);
				_blackberry.f4menu.pages.jobs_func.initPlayerInfoList(parent, v);
			end;

			local icon = vgui.Create("ModelImage", btn_panel);
			icon:SetSize(32, 32);
			icon:SetPos(10, 0);
    		icon:SetModel(istable(v.model) and table.Random(v.model) or v.model, 1, "000000000");
	    end;

		if (member_count == 0) then
			header:Remove();
		end;
	end;
	parent.BuildJobPanel();
end;

function _blackberry.f4menu.pages.jobs_func.initPlayerInfoList(parent, job)
	local weaponString = fn.Compose{fn.Curry(fn.Flip(table.concat), 2)("\n"), fn.Curry(fn.Seq, 2)(table.sort), getWeaponNames, table.Copy}
	if (IsValid(parent.job_info_list)) then parent.job_info_list:Remove(); end;
	local sx, startx = cfg["double_job_line"] and getSize(col_count()-3) or getSize(col_count()-2), cfg["double_job_line"] and getSize(3)+align or getSize(2)+align;

	parent.job_info_list = vgui.Create("DScrollPanel", parent);
	parent.job_info_list:SetSize(sx, parent:GetTall());
	parent.job_info_list:SetPos(startx, 0);
	parent.job_info_list.Paint = function(self, w, h)
	end;

	parent.job_info_list.item_list = vgui.Create( "DIconLayout", parent.job_info_list )
	parent.job_info_list.item_list:Dock(FILL);
	parent.job_info_list.item_list:SetSpaceX(8);
	parent.job_info_list.item_list:SetSpaceY(8);

	local sbar = parent.job_info_list:GetVBar();
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

	local start_item = vgui.Create("DPanel", parent.job_info_list.item_list);
	start_item:SetSize(sx, 35);
	start_item.Paint = function(self, w, h)
		draw.SimpleText(job.name, "Raleway Bold 22", 0, h/2, Color(255, 255, 255, 255), 0, 1);

		surface.SetFont("Raleway Bold 22");
		local width, height = surface.GetTextSize(job.name);
		draw.RoundedBox(0, 0, h-1, width/2, 2, Color(cfg["main_color"].r, cfg["main_color"].g, cfg["main_color"].b));
	end;

	--[[-------------------------------------------------------------------------
	salary
	---------------------------------------------------------------------------]]
	start_item.salary_hed = vgui.Create("DPanel", parent.job_info_list.item_list);
	start_item.salary_hed:SetSize(sx, 20);
	start_item.salary_hed.Paint = function(self, w, h)
		draw.SimpleText(L["d_salary"], "Raleway Bold 19", 0, h/2, Color(cfg["main_color"].r, cfg["main_color"].g, cfg["main_color"].b, 150), 0, 1);
	end;

	start_item.salary_hed = vgui.Create("DPanel", parent.job_info_list.item_list);
	start_item.salary_hed:SetSize(sx, 16);
	start_item.salary_hed.Paint = function(self, w, h)
		draw.SimpleText("$"..job.salary, "Raleway 16", 0, h/2, Color(255, 255, 255, 100), 0, 1);
	end;
	--[[-------------------------------------------------------------------------
	Description
	---------------------------------------------------------------------------]]
	start_item.desc = vgui.Create("DPanel", parent.job_info_list.item_list);
	start_item.desc:SetSize(sx, 20);
	start_item.desc.Paint = function(self, w, h)
		draw.SimpleText(L["description"], "Raleway Bold 19", 0, h/2, Color(cfg["main_color"].r, cfg["main_color"].g, cfg["main_color"].b, 150), 0, 1);
	end;

    local text = DarkRP.textWrap(DarkRP.deLocalise(job.description or ""):gsub('\t', ''), "Raleway 16", sx - 20)
    surface.SetFont("Raleway 16")
    local _, h = surface.GetTextSize(text)

    start_item.lblDescription = vgui.Create("DLabel", parent.job_info_list.item_list)
    start_item.lblDescription:SetWide(sx);
    start_item.lblDescription:SetFont("Raleway 16")
    start_item.lblDescription:SetAutoStretchVertical(true)
    start_item.lblDescription:SetText(text)
    start_item.lblDescription:SetTall(h)
    --[[-------------------------------------------------------------------------
    Weapons 76561198037478513
    ---------------------------------------------------------------------------]]
	start_item.desc = vgui.Create("DPanel", parent.job_info_list.item_list);
	start_item.desc:SetSize(sx, 20);
	start_item.desc.Paint = function(self, w, h)
		draw.SimpleText(L["wep_list"], "Raleway Bold 19", 0, h/2, Color(cfg["main_color"].r, cfg["main_color"].g, cfg["main_color"].b, 150), 0, 1);
	end;

    local weps
    if not job.weapons then
        weps = DarkRP.getPhrase("no_extra_weapons");
    else
        weps = weaponString(job.weapons);
        weps = weps ~= "" and weps or DarkRP.getPhrase("no_extra_weapons");
    end

    local text = DarkRP.textWrap(weps:gsub('\t', ''), "Raleway 16", sx - 20)
    surface.SetFont("Raleway 16")
    local _, h = surface.GetTextSize(text)

    start_item.weapon_list = vgui.Create("DLabel", parent.job_info_list.item_list)
    start_item.weapon_list:SetWide(sx);
    start_item.weapon_list:SetFont("Raleway 16")
    start_item.weapon_list:SetAutoStretchVertical(true)
    start_item.weapon_list:SetText(text)
    start_item.weapon_list:SetTall(h)
    --[[-------------------------------------------------------------------------
    Models
    ---------------------------------------------------------------------------]]
	if (istable(job.model)) then
		start_item.desc = vgui.Create("DPanel", parent.job_info_list.item_list);
		start_item.desc:SetSize(sx, 20);
		start_item.desc.Paint = function(self, w, h)
			draw.SimpleText(L["choose_model"], "Raleway Bold 19", 0, h/2, Color(cfg["main_color"].r, cfg["main_color"].g, cfg["main_color"].b, 150), 0, 1);
		end;
		local last_active = start_item.desc;
		start_item.models = {};
		for k,v in pairs(job.model) do
			start_item.models[k] = vgui.Create("DPanel", parent.job_info_list.item_list);
			start_item.models[k]:SetSize(48, 48);
			start_item.models[k].Paint = function(self, w, h)
				draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100));
				if (last_active == self) then
					draw.RoundedBox(0, 0, 0, w, h, Color(cfg["main_color"].r, cfg["main_color"].g, cfg["main_color"].b, 150));
				end
				if (self.hovered) then
					draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 75));
				end
			end;
			if (DarkRP.getPreferredJobModel(job.team) == v) then
				last_active = start_item.models[k];
				start_item.models[k].active = true;
			end

			local icon = vgui.Create("ModelImage", start_item.models[k]);
			icon:SetSize(44, 44);
			icon:SetPos(2, 2);
    		icon:SetModel(v, 1, "000000000");

    		local btn = vgui.Create("DButton", start_item.models[k]);
    		btn:SetSize(48, 48);
    		btn.strModel = v;
    		btn:SetText("");
			btn.Paint = function(self, w, h) end;
			btn.OnCursorEntered = function(self)
				surface.PlaySound(cfg["sound_hover"]);
				self:GetParent().hovered = true;
			end;
			btn.OnCursorExited = function(self)
				self:GetParent().hovered = false;
			end;
			btn.DoClick = function(self)
				surface.PlaySound(cfg["sound_click"]);
				last_active.active = false;
				last_active = self:GetParent();
				self:GetParent().active = true;
				DarkRP.setPreferredJobModel(job.team, self.strModel)
			end;

		end
	end

    //DarkRP.setPreferredJobModel(self.job.team, self.strModel) 76561198037478513
	--[[-------------------------------------------------------------------------
	Become
	---------------------------------------------------------------------------]]
	local become = _blackberry.f4menu.derma.createButtonlist((job.vote or job.RequiresVote and job.RequiresVote(LocalPlayer(), job.team)) and "Create a vote to become a "..job.name or "To become a "..job.name);
	become:SetParent(parent.job_info_list.item_list);
	become:SetWide(sx);
	if job.vote or job.RequiresVote and job.RequiresVote(LocalPlayer(), job.team) then
		become.DoClick = fn.Compose{_blackberry.f4menu.Close, fn.Partial(RunConsoleCommand, "darkrp", "vote" .. job.command)}
	else
		become.DoClick = fn.Compose{_blackberry.f4menu.Close, fn.Partial(RunConsoleCommand, "darkrp", job.command)}
	end;
end;

function _blackberry.f4menu.pages.jobs_func.initPlayerJobList(parent)
	parent.playerJobList = vgui.Create("DScrollPanel", parent);
	parent.playerJobList:SetSize(col_size(), parent:GetTall());
	parent.playerJobList:SetPos(cfg["double_job_line"] and getSize(2)+align or col_size()+align, 0);
	parent.playerJobList.Paint = function(self, w, h)
	end;

	parent.playerJobList.item_list = vgui.Create( "DIconLayout", parent.playerJobList )
	parent.playerJobList.item_list:Dock(FILL);
	parent.playerJobList.item_list:SetSpaceX(0);
	parent.playerJobList.item_list:SetSpaceY(10);

	local sbar = parent.playerJobList:GetVBar();
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

	function parent.playerJobList.item_list.BuildPlayers(team_id, team_name, max)
		local self = parent.playerJobList.item_list;
		self:Clear();
		if (!max or max < 1) then
			max = team.NumPlayers(team_id);
		end;

		local header = vgui.Create("DPanel", self);
		header:SetSize(col_size(), 35);
		header.Paint = function(self, w, h)
			draw.SimpleText(L["players_by_job"], "Raleway Bold 22", 0, h/2, Color(255, 255, 255, 255), 0, 1);

			surface.SetFont("Raleway Bold 22");
			local width, height = surface.GetTextSize(L["players_by_job"]);
			draw.RoundedBox(0, 0, h-1, width/2, 2, Color(cfg["main_color"].r, cfg["main_color"].g, cfg["main_color"].b));
		end;

		if (!team_id) then return false; end;

		local players = vgui.Create("DPanel", self);
		players:SetSize(col_size(),40);
		players.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 20, w, 20, Color(0, 0, 0, 100));
			draw.RoundedBox(0, 0, 20, w/max*math.Clamp(team.NumPlayers(team_id), 0, max), 20, Color(cfg["main_color"].r, cfg["main_color"].g, cfg["main_color"].b, 100));

			draw.SimpleText(L["max"], "Raleway 15", 0, 15/2, Color(255, 255, 255, 255), 0, 1);
			draw.SimpleText(team.NumPlayers(team_id).." / "..max, "Raleway 15", w, 15/2, Color(255, 255, 255, 150), 2, 1);
		end;

		for k, v in pairs(team.GetPlayers(team_id)) do
			local ply_profile = vgui.Create("DPanel", self);
			ply_profile:SetSize(col_size(),32);
			ply_profile.Paint = function(self, w, h)
				--draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100));
				draw.RoundedBox(0, 0, 0, 32, 32, Color(0, 0, 0, 50));
				draw.RoundedBox(0, 32, 0, w-32, 32, Color(0, 0, 0, 100));
				draw.SimpleText(v:Name(), "Raleway Bold 13", 32+2, h/2, Color(255, 255, 255, 100), 0, 1);
			end;

			local Avatar = vgui.Create("AvatarImage", ply_profile);
			Avatar:SetSize(30, 30);
			Avatar:SetPos(1, 1);
			Avatar:SetPlayer(v, 32);
		end;

		timer.Simple(0.05, function()
			if (!IsValid(parent) or !IsValid(parent.playerJobList)) then return; end;
			parent.playerJobList:Rebuild();
		end);
	end;
end;


function _blackberry.f4menu.pages.jobs(parent)
	if (cfg["double_job_line"] and ScrW() < 1000) then
		cfg["double_job_line"] = false;
	end;
	_blackberry.f4menu.pages.jobs_func.initPlayerJobList(parent)
	_blackberry.f4menu.pages.jobs_func.initJobList(parent)
end;