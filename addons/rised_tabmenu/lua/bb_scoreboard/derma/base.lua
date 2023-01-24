-- "addons\\rised_tabmenu\\lua\\bb_scoreboard\\derma\\base.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
// Global vars
local _blackberry = _blackberry or {};
_blackberry.scoreboard = _blackberry.scoreboard or {};
local core = _blackberry.scoreboard;
core.derma = core.derma or {};
core.derma.activeMenu = core.derma.activeMenu or nil;
core.derma.states = {
	sortBy = core.config["sort_by_default"],
	showGroup = "All",
};
local x, y, sx, sy = ScrW(), ScrH(), ScrW(), ScrH();
local align = 25;

local function col_count()
	return sx >= 1200 and math.floor(sx/250) or 4;
end;
local function col_size()
	return math.floor((sx-align*col_count())/col_count());
end;
local function player_col_count()
	local count = core.config["double_line"] and 2 or 1;
	return sx >= 1600 and count+1 or count;
end;
local function getSize(col_count)
	return col_size()*col_count+align*(col_count-1);
end;



function core.derma.createWindow()
	local main_color = core.config["main_color"];
	if (IsValid(core.derma.activeMenu)) then
		core.derma.Close();
	end
	
	core.derma.activeMenu = vgui.Create("DFrame");
	local _frame = core.derma.activeMenu;
	_frame:SetSize(sx, sy);
	_frame:SetPos(x/2-sx/2, y/2-sy/2);
	_frame:SetTitle("");
	_frame:SetDraggable(false);
	_frame:MakePopup();
	_frame:ShowCloseButton(false);
	_frame.startTime = SysTime();
	_frame.Paint = function(self, w, h)
		Derma_DrawBackgroundBlur(self, self.startTime);
		draw.SimpleText(core.config.title, "Raleway ExtraBold 36", align, align, Color(main_color.r, main_color.g, main_color.b, 255), 0, 2);
	end;
end;

function core.derma.createStaff(staff_list)
	if (!IsValid(core.derma.activeMenu)) then return false; end;
	local parent = core.derma.activeMenu;
	local main_color = core.config["main_color"];
	if (IsValid(parent.list)) then parent.list:Close(); end;

	local item_list = vgui.Create("DScrollPanel", parent);
	parent.list = item_list;
	item_list:SetSize(getSize(player_col_count()), sy-align*3-36);
	item_list:SetPos(align, align*2+36);
	item_list.parents = {};
	item_list.Close = function(self)
		for k,v in pairs(self.parents) do
			if (IsValid(v)) then
				v:Remove();
			end;
		end;
		self:Remove();
	end;

	local items = vgui.Create("DIconLayout", item_list);
	items:Dock(FILL);
	items:SetSpaceX(10);
	items:SetSpaceY(10);
	items.Paint = function(self, w, h)
	end;

	local sbar = item_list:GetVBar();
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

	local btn = vgui.Create("DButton", items);
	btn:SetSize(23,23);
	btn:SetText("");
	btn.Paint = function(self, w, h)
		self.lerp = Lerp(FrameTime()*6, self.lerp or 0, self.hover and 1 or 0);
		local s1 = 10+10*self.lerp;
		local s2 = 6+6*self.lerp;
		draw.RoundedBox(0, w/2-s1/2, h/2-s1/2, s1, s1, Color(0, 0, 0, 65));
		draw.RoundedBox(0, w/2-s2/2, h/2-s2/2, s2, s2, Color(0, 0, 0, 150 - 150 * self.lerp));
		draw.RoundedBox(0, w/2-s2/2, h/2-s2/2, s2, s2, Color(main_color.r, main_color.g, main_color.b, 150*self.lerp));

		draw.DashedLine(0, h-1, w, 1, 1, 2, Color(255, 255, 255, 25 + 150*self.lerp));
	end;
	btn.OnCursorEntered = function(self)
		--surface.PlaySound("physics/metal/metal_popcan_impact_hard1.wav");
		self.hover = true;
	end;
	btn.OnCursorExited = function(self)
		self.hover = false;
	end;
	btn.DoClick = function()
		if (IsValid(item_list.parents["list"])) then item_list.parents["list"]:Remove(); end;
		item_list.parents["list"] = vgui.Create("DFrame", parent);
		item_list.parents["list"]:SetSize(col_size(), 200);
		item_list.parents["list"]:SetPos(align, align*2+36+23);
		item_list.parents["list"]:SetDraggable(false);
		item_list.parents["list"]:ShowCloseButton(false);
		item_list.parents["list"]:SetTitle("");
		item_list.parents["list"].startTime = SysTime();
		item_list.parents["list"].Paint = function(self, w, h)
			Derma_DrawBackgroundBlur(self, self.startTime);
			local col = Color(main_color.r, main_color.g, main_color.b, 150);
			draw.DashedLine(0, 23, w, 1, 1, 2, Color(255, 255, 255, 50));
			draw.DashedLine(0, h-23, w, 1, 1, 2, col);

			draw.SimpleText("Filters:", "Raleway Bold 17", 0, 23/2, Color(255, 255, 255, 255), 0, 1);
		end;
		local sheight = core.derma:CreateFilterList(item_list.parents["list"]);

		item_list.parents["list"]:SetTall(sheight+23*2+5*2);

		item_list.parents["list"].close = vgui.Create("DButton", item_list.parents["list"]);
		item_list.parents["list"].close:SetSize(col_size(), 23);
		item_list.parents["list"].close:SetPos(0, sheight+23+5*2);
		item_list.parents["list"].close:SetText("");
		item_list.parents["list"].close.Paint = function(self, w, h)
			self.lerp = Lerp(FrameTime()*6, self.lerp or 0, self.hover and 1 or 0);
			draw.SimpleText("Apply", "Raleway Bold 15", w/2, h/2, Color(255, 255, 255, 150 + 150*self.lerp), 1, 1);
		end;
		item_list.parents["list"].close.OnCursorEntered = function(self)
			--surface.PlaySound("physics/metal/metal_popcan_impact_hard1.wav");
			self.hover = true;
		end;
		item_list.parents["list"].close.OnCursorExited = function(self)
			self.hover = false;
		end;
		item_list.parents["list"].close.DoClick = function(self)
			item_list.parents["list"]:Remove();
			core.derma.createStaff(staff_list);
		end;
	end;

	local font_size = player_col_count() == 1 and 15 or 21;
	surface.SetFont("Raleway "..font_size);
	local width, height = surface.GetTextSize("Player list");
	local btn = vgui.Create("DButton", items);
	btn:SetSize(width+20,23);
	btn:SetText("");
	btn.Paint = function(self, w, h)
		self.lerp = Lerp(FrameTime()*6, self.lerp or 0, self.hover and 1 or 0);
		draw.SimpleText("Список игроков", "Raleway Bold 15", w/2, h/2, !staff_list and main_color or Color(255, 255, 255, 150 + 150*self.lerp), 1, 1);

		draw.DashedLine(0, h-1, w, 1, 1, 2, !staff_list and main_color or Color(255, 255, 255, 25 + 150*self.lerp));
	end;
	btn.OnCursorEntered = function(self)
		--surface.PlaySound("physics/metal/metal_popcan_impact_hard1.wav");
		self.hover = true;
	end;
	btn.OnCursorExited = function(self)
		self.hover = false;
	end;
	btn.DoClick = function(self)
		if (staff_list) then
			core.derma.createStaff();
		end;
	end;

	surface.SetFont("Raleway "..font_size);
	local width, height = surface.GetTextSize("Staff online");
	local btn = vgui.Create("DButton", items);
	btn:SetSize(width+20,23);
	btn:SetText("");
	btn.Paint = function(self, w, h)
		self.lerp = Lerp(FrameTime()*6, self.lerp or 0, self.hover and 1 or 0);
		draw.SimpleText("Администрация", "Raleway Bold 15", w/2, h/2, staff_list and main_color or Color(255, 255, 255, 150 + 150*self.lerp), 1, 1);

		draw.DashedLine(0, h-1, w, 1, 1, 2, staff_list and main_color or Color(255, 255, 255, 25 + 150*self.lerp));
	end;
	btn.OnCursorEntered = function(self)
		--surface.PlaySound("physics/metal/metal_popcan_impact_hard1.wav");
		self.hover = true;
	end;
	btn.OnCursorExited = function(self)
		self.hover = false;
	end;
	btn.DoClick = function(self)
		if (!staff_list) then
			core.derma.createStaff(true);
		end;
	end;

    local categories = DarkRP.getCategories().jobs;
    if (core.derma.states.sortBy != "Names") then
	    for _, cat in pairs(categories) do
	    	if (core.derma.states.showGroup != "All" and cat.name != core.derma.states.showGroup) then continue; end;
	    	
	    	local member_count = 0;
			local header = vgui.Create("DPanel", items);
			header:SetSize(item_list:GetWide(),32);
			header.Paint = function(self, w, h)
				draw.SimpleText(cat.name, "Raleway Bold 26", 0, h/2, Color(255, 255, 255, 175), 0, 1);
			end;

			for k, v in pairs(player.GetAll()) do
				if (staff_list and !v:IsAdmin()) or (v:IsAdmin() and v:GetNWBool("Rised_Admin_Stealth")) then continue; end;
				if istable(RPExtraTeams[v:Team()]) and (RPExtraTeams[v:Team()].category != cat.name) then continue; end;
				member_count = member_count + 1;
			    local profile = core.derma:CreatePlayerItem(v, items, col_size());
			end;
			if (member_count == 0) then
				header:Remove();
			end;
	    end;
    else
		for k, v in pairs(player.GetAll()) do
			if (staff_list and !v:IsAdmin()) then continue; end;

		    local profile = core.derma:CreatePlayerItem(v, items, col_size());
		end;
    end

	core.derma.OpenProfile();
end;

function core.derma.OpenProfile(ply)
	local function lply()
		return (!IsValid(ply) or !ply:IsPlayer()) and LocalPlayer() or ply;
	end;
	if (!IsValid(core.derma.activeMenu)) then return false; end;
	if (IsValid(core.derma.activeMenu.active_list)) then core.derma.activeMenu.active_list:Remove(); end;
	if (!IsValid(ply) or !ply:IsPlayer()) then ply = LocalPlayer(); end;
	local sizex, sizey = getSize(col_count() - player_col_count())-align, sy-align*3-36;
	local parent = core.derma.activeMenu;
	local main_color = core.config["main_color"];

	local info_list = vgui.Create("DScrollPanel", parent)
	core.derma.activeMenu.active_list = info_list;
	info_list:SetSize(sizex, sizey);
	info_list:SetPos(sx-align-sizex, align*2+36);
	info_list.Paint = function(self, w, h)
	end;
	info_list.Think = function(self)
		if (!IsValid(lply())) then
			self:Remove();
			core.derma.OpenProfile();
		end;
	end;

	local info_items = vgui.Create("DIconLayout", info_list);
	info_items:Dock(FILL);
	info_items:SetSpaceX(8);
	info_items:SetSpaceY(8);
	info_items.Paint = function(self, w, h)
		//draw.DashedLineVertical(0, 40, 1, h-40, 1, 2, Color(255, 255, 255, 25));
	end;

	local sbar = info_list:GetVBar();
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

	local header = vgui.Create("DPanel", info_items);
	header:SetSize(sizex,32);
	header.Paint = function(self, w, h)
		draw.SimpleText("Информация об игроке", "Raleway Bold 15", 0, h/2, Color(255, 255, 255, 255), 0, 1);
		draw.DashedLine(0, h-1, w, 2, 2, 2, main_color);
	end;

	local Avatar = vgui.Create("AvatarImage", info_items);
	Avatar:SetSize(64, 64);
	Avatar:SetPlayer(lply(), 60);

	local header = vgui.Create("DPanel", info_items);
	header:SetSize(sizex - 64 - 8,64);
	header.Paint = function(self, w, h)
		draw.SimpleText(lply():SteamName(), "Raleway Bold 29", 0, 0, main_color, 0, 0);
		if ply:GetUserGroup() == "superadmin" and ply:SteamID() == "STEAM_0:1:38606392" then
			draw.SimpleText("Ранг: Создатель", "Raleway 15", 0, 29, Color(255, 255, 255, 150), 0, 0);
		else
			draw.SimpleText("Ранг: "..(core.config["staff_replace"][lply():GetUserGroup()] and core.config["staff_replace"][lply():GetUserGroup()] or lply():GetUserGroup()), "Raleway 15", 0, 29, Color(255, 255, 255, 150), 0, 0);
		end
		if (_blackberry.character_base) then
			draw.SimpleText(lply():getChar():GetVar("description"), "Raleway 15", 0, 45, Color(255, 255, 255, 150), 0, 0);
		end;
	end;

	local header = vgui.Create("DPanel", info_items);
	header:SetSize(sizex,23);
	header.Paint = function(self, w, h)
		draw.SimpleText("Основная информация", "Raleway Bold 17", 0, h/2, main_color, 0, 1);
		surface.SetFont("Raleway Bold 17");
		local w1, _ = surface.GetTextSize("Main info");
		draw.RoundedBox(0, w1+100, h/2+1, w-w1-5, 2, Color(255, 255, 255, 50));
	end;

	local kills = vgui.Create("DPanel", info_items);
	kills:SetSize(sizex, 15);
	kills.Paint = function(self, w, h)
		draw.SimpleText("Количество убийств", "Raleway Bold 15", 0, h/2, Color(255, 255, 255), 0, 1);
		draw.SimpleText(lply():Frags(), "Raleway 15", col_size(), h/2, Color(255, 255, 255, 150), 0, 1);
	end;

	local deaths = vgui.Create("DPanel", info_items);
	deaths:SetSize(sizex, 15);
	deaths.Paint = function(self, w, h)
		draw.SimpleText("Количество смертей", "Raleway Bold 15", 0, h/2, Color(255, 255, 255), 0, 1);

		draw.SimpleText(lply():Deaths(), "Raleway 15", col_size(), h/2, Color(255, 255, 255, 150), 0, 1);
	end;

	local deaths = vgui.Create("DPanel", info_items);
	deaths:SetSize(sizex, 15);
	deaths.Paint = function(self, w, h)
		draw.SimpleText("Пинг", "Raleway Bold 15", 0, h/2, Color(255, 255, 255), 0, 1);
		draw.SimpleText(lply():Ping().." ms", "Raleway 15", col_size(), h/2, Color(255, 255, 255, 150), 0, 1);
	end;

	local job = vgui.Create("DPanel", info_items);
	job:SetSize(sizex, 15);
	job.Paint = function(self, w, h)
		draw.SimpleText("Профессия", "Raleway Bold 15", 0, h/2, Color(255, 255, 255), 0, 1);
		if LocalPlayer():IsAdmin() then
			local pp = lply():GetNWInt("Player_CombineRank") or 0
			pp = math.Round(pp)
			draw.SimpleText(team.GetName(lply():Team()) .. " | ".. lply():getDarkRPVar("money") .. " Токенов", "Raleway 15", col_size(), h/2, Color(255, 255, 255, 150), 0, 1);
		else
			draw.SimpleText(RPExtraTeams[lply():Team()].category, "Raleway 15", col_size(), h/2, Color(255, 255, 255, 150), 0, 1);
		end
	end;

	local ugroup = vgui.Create("DPanel", info_items);
	ugroup:SetSize(sizex, 15);
	ugroup.Paint = function(self, w, h)
		draw.SimpleText("Личный RP уровень", "Raleway Bold 15", 0, h/2, Color(255, 255, 255), 0, 1);

		local rplevel = lply():GetNWInt("PersonalRPLevel")
		if tonumber(rplevel) > 75 then
			draw.SimpleText("Больше 75", "Raleway 15", col_size(), h/2, Color(255, 255, 0, 150), 0, 1);
		elseif tonumber(rplevel) < 50 then
			draw.SimpleText("Меньше 50", "Raleway 15", col_size(), h/2, Color(255, 0, 0, 150), 0, 1);
		else
			draw.SimpleText("Меньше 50", "Raleway 15", col_size(), h/2, Color(150, 150, 150, 150), 0, 1);
		end
	end;

	local s3 = (sizex-16)/3;
	local s2 = (sizex-8)/2;

	local header = vgui.Create("DPanel", info_items);
	header:SetSize(sizex,23);
	header.Paint = function(self, w, h)
		draw.SimpleText("Профиль Steam", "Raleway Bold 17", 0, h/2, main_color, 0, 1);
		surface.SetFont("Raleway Bold 17");
		local w1, _ = surface.GetTextSize("Steam Profile");
		draw.RoundedBox(0, w1+28, h/2+1, w-w1-5, 2, Color(255, 255, 255, 50));
	end;

	local steam_data = vgui.Create("DButton", info_items);
	steam_data:SetSize(sizex,16);
	steam_data:SetText("");
	steam_data.Paint = function(self, w, h)
		self.lerp = Lerp(FrameTime()*4, self.lerp or 0, self.hovered and 1 or 0);
		draw.SimpleText("Ник в Steam:", "Raleway Bold 15", 0, h/2, Color(255, 255, 255), 0, 1);
		draw.SimpleText(lply():SteamName(), "Raleway 15", s3,h/2, Color(255, 255, 255, 150), 0, 1);
		draw.DashedLine(s3, h-1, s3*2*self.lerp, 1, 1, 2, Color(255, 255, 255, 50));
	end;
	steam_data.DoClick = function()
		--surface.PlaySound("physics/metal/chain_impact_hard2.wav");
		SetClipboardText(lply():SteamName());
	end;
	steam_data.OnCursorEntered = function(self)
		--surface.PlaySound("physics/metal/metal_popcan_impact_hard1.wav");
		self.hovered = true;
	end;
	steam_data.OnCursorExited = function(self)
		self.hovered = false;
	end; 

	local steam_data = vgui.Create("DButton", info_items);
	steam_data:SetSize(sizex,16);
	steam_data:SetText("");
	steam_data.Paint = function(self, w, h)
		self.lerp = Lerp(FrameTime()*4, self.lerp or 0, self.hovered and 1 or 0);
		draw.SimpleText("Ссылка на профиль:", "Raleway Bold 15", 0, h/2, Color(255, 255, 255), 0, 1);
		draw.SimpleText("https://steamcommunity.com/profiles/" .. (lply():SteamID64() or "BOT"), "Raleway 15", s3,h/2, Color(255, 255, 255, 150), 0, 1);
		draw.DashedLine(s3, h-1, s3*2*self.lerp, 1, 1, 2, Color(255, 255, 255, 50));
	end;
	steam_data.DoClick = function()
		--surface.PlaySound("physics/metal/chain_impact_hard2.wav");
		SetClipboardText("https://steamcommunity.com/profiles/" .. (lply():SteamID64() or "BOT"));
	end;
	steam_data.OnCursorEntered = function(self)
		--surface.PlaySound("physics/metal/metal_popcan_impact_hard1.wav");
		self.hovered = true;
	end;
	steam_data.OnCursorExited = function(self)
		self.hovered = false;
	end;

	local steam_data = vgui.Create("DButton", info_items);
	steam_data:SetSize(sizex,16);
	steam_data:SetText("");
	steam_data.Paint = function(self, w, h)
		self.lerp = Lerp(FrameTime()*4, self.lerp or 0, self.hovered and 1 or 0);
		draw.SimpleText("Steam ID:", "Raleway Bold 15", 0, h/2, Color(255, 255, 255), 0, 1);
		draw.SimpleText((lply():SteamID() or "BOT"), "Raleway 15", s3,h/2, Color(255, 255, 255, 150), 0, 1);
		draw.DashedLine(s3, h-1, s3*2*self.lerp, 1, 1, 2, Color(255, 255, 255, 50));
	end;
	steam_data.DoClick = function()
		--surface.PlaySound("physics/metal/chain_impact_hard2.wav");
		SetClipboardText(lply():SteamID() or "BOT");
	end;
	steam_data.OnCursorEntered = function(self)
		--surface.PlaySound("physics/metal/metal_popcan_impact_hard1.wav");
		self.hovered = true;
	end;
	steam_data.OnCursorExited = function(self)
		self.hovered = false;
	end;

	local ULXActions = {
		[1] = {
			["Name"] = "Kick",
			["Action"] = "ulx kick",
		},
		[2] = {
			["Name"] = "Mute",
			["Action"] = "ulx mute",
		},
		[3] = {
			["Name"] = "UnMute",
			["Action"] = "ulx unmute",
		},
		[4] = {
			["Name"] = "Freeze",
			["Action"] = "ulx freeze",
		},
		[5] = {
			["Name"] = "UnFreeze",
			["Action"] = "ulx unfreeze",
		},
		[6] = {
			["Name"] = "God",
			["Action"] = "ulx god",
		},
		[7] = {
			["Name"] = "UnGod",
			["Action"] = "ulx ungod",
		},
		[8] = {
			["Name"] = "Ignite",
			["Action"] = "ulx ignite",
		},
		[9] = {
			["Name"] = "UnIgnite",
			["Action"] = "ulx unignite",
		},
		[10] = {
			["Name"] = "Ragdoll",
			["Action"] = "ulx ragdoll",
		},
		[11] = {
			["Name"] = "UnRagdoll",
			["Action"] = "ulx unragdoll",
		},
		[12] = {
			["Name"] = "Slay",
			["Action"] = "ulx slay",
		},
		[13] = {
			["Name"] = "Strip Weapons",
			["Action"] = "ulx strip",
		},
		[14] = {
			["Name"] = "Stealth",
			["Action"] = "ulx stealthmode",
		},
		[15] = {
			["Name"] = "Teleport",
			["Action"] = "ulx teleport",
		},
		[16] = {
			["Name"] = "Bring",
			["Action"] = "ulx bring",
		},
		[17] = {
			["Name"] = "GoTo",
			["Action"] = "ulx goto",
		},
		[18] = {
			["Name"] = "Return",
			["Action"] = "ulx return",
		},
		[19] = {
			["Name"] = "Spectate",
			["Action"] = function(ply)
				if not IsValid(ply) then return end
				RunConsoleCommand("FSpectate", ply:UserID()) 
			end,
		},
		[20] = {
			["Name"] = "Cloak",
			["Action"] = "ulx cloak",
		},
		[21] = {
			["Name"] = "UnCloak",
			["Action"] = "ulx uncloak",
		},
		[22] = {
			["Name"] = "Set Team",
			["Action"] = function(ply, button)
				local menu = DermaMenu()

				local Padding = vgui.Create("DPanel")
				Padding:SetPaintBackgroundEnabled(false)
				Padding:SetSize(1,5)
				menu:AddPanel(Padding)

				local Title = vgui.Create("DLabel")
				Title:SetText("  Teams:\n")
				Title:SetFont("UiBold")
				Title:SizeToContents()
				Title:SetTextColor(color_black)

				menu:AddPanel(Title)
				for k, v in SortedPairsByMemberValue(team.GetAllTeams(), "Name") do
					local uid = ply:UserID()
					
					menu:AddOption(v.Name, function() lply():ConCommand('ulx setteam "'..lply():Name()..'" '..k) end)
				end
				menu:Open() 
			end,
		},
		[23] = {
			["Name"] = "Respawn",
			["Action"] = "ulx respawn",
		},
	}

	if (core.config["fadmin"]) then
		local header = vgui.Create("DPanel", info_items);
		header:SetSize(sizex,23);
		header.Paint = function(self, w, h)
			draw.SimpleText("Меню FAdmin", "Raleway Bold 17", 0, h/2, main_color, 0, 1);
			surface.SetFont("Raleway Bold 17");
			local w1, _ = surface.GetTextSize("FAdmin commands");
			draw.RoundedBox(0, w1-25, h/2+1, w-w1-5, 2, Color(255, 255, 255, 50));
		end;

	    for _, v in ipairs(ULXActions) do
	        local name = v.Name
		    name = DarkRP.deLocalise(name);
			surface.SetFont("Raleway 15");
			local width, height = surface.GetTextSize(name);

			local btn = vgui.Create("DButton", info_items);
			btn:SetSize(width+20,16);
			btn:SetText("");
			btn.name = name;
			btn.Paint = function(self, w, h)
				self.lerp = Lerp(FrameTime()*4, self.lerp or 0, self.hovered and 1 or 0);
				draw.SimpleText(self.name, "Raleway Bold 15", w/2, h/2, Color(255, 255, 255, 100-100*self.lerp), 1, 1);

				draw.SimpleText(self.name, "Raleway Bold 15", w/2, h/2, Color(main_color.r, main_color.g, main_color.b, 255*self.lerp), 1, 1);
			end;
			btn.OnCursorEntered = function(self)
				--surface.PlaySound("physics/metal/metal_popcan_impact_hard1.wav");
				self.hovered = true;
			end;
			btn.OnCursorExited = function(self)
				self.hovered = false;
			end;
			btn.DoClick = function(self)
				--surface.PlaySound("physics/metal/chain_impact_hard2.wav");
				if not IsValid(lply()) then return end
				if isstring(v.Action) then
					return lply():ConCommand(v.Action..' "'..lply():Name()..'"')
				elseif isfunction(v.Action) then
					return v.Action(lply(), self)
				end
			end;
			btn.SetImage2 = function() end;
			function btn:SetText(text)
				self.name = text;
				surface.SetFont("Raleway 15");
				local width, height = surface.GetTextSize(text);
				self:SetWide(width+10);
			end;
	    end
	end;

	if (_blackberry.character_base and table.HasValue(_blackberry.character_base.config["access_groups"], LocalPlayer():GetUserGroup())) then
		local header = vgui.Create("DPanel", info_items);
		header:SetSize(sizex,23);
		header.Paint = function(self, w, h)
			draw.SimpleText("Character base", "Raleway Bold 17", 0, h/2, main_color, 0, 1);
			surface.SetFont("Raleway Bold 17");
			local w1, _ = surface.GetTextSize("Character base");
			draw.RoundedBox(0, w1+5, h/2+1, w-w1-5, 2, Color(255, 255, 255, 50));
		end;

	    for _, v in ipairs(_blackberry.character_base.config["commands"]) do
	        if (v.group != "admin") then continue; end;

            local name = v.name
			surface.SetFont("Raleway 15");
			local width, height = surface.GetTextSize(name);

        	local btn = vgui.Create("DButton", info_items);
			btn:SetSize(width+20,16);
			btn:SetText("");
			btn.name = name;
			btn.Paint = function(self, w, h)
				self.lerp = Lerp(FrameTime()*4, self.lerp or 0, self.hovered and 1 or 0);
				draw.SimpleText(self.name, "Raleway Bold 15", w/2, h/2, Color(255, 255, 255, 100-100*self.lerp), 1, 1);

				draw.SimpleText(self.name, "Raleway Bold 15", w/2, h/2, Color(main_color.r, main_color.g, main_color.b, 255*self.lerp), 1, 1);
			end;
			btn.OnCursorEntered = function(self)
				--surface.PlaySound("physics/metal/metal_popcan_impact_hard1.wav");
				self.hovered = true;
			end;
			btn.OnCursorExited = function(self)
				self.hovered = false;
			end;
            btn.DoClick = function()
				--surface.PlaySound("physics/metal/chain_impact_hard2.wav");
                if not IsValid(lply()) then return; end;
                v.callback(LocalPlayer(), lply());
            end;
	    end;
	end;
end;

function core.derma.Open()
	core.derma.createWindow();
	core.derma.createStaff();
end;

function core.derma.Close()
	if (!IsValid(core.derma.activeMenu)) then return false; end;
	core.derma.activeMenu:Close();
end;

function core.derma.Toggle()
	if (IsValid(core.derma.activeMenu)) then core.derma.Close(); return false; end;
	core.derma.Open(); return true;
end;

concommand.Add("+_blackberry_scoreboard_open", function()
	_blackberry.scoreboard.derma.Open();
end);
concommand.Add("-_blackberry_scoreboard_open", function()
	_blackberry.scoreboard.derma.Close();
end);

timer.Create("_blackberry.scoreboard.init",0.1,0,function()
	if (!FAdmin or !IsValid(FAdmin.ScoreBoard)) then
		timer.Destroy("_blackberry.scoreboard.init");
	end;
	hook.Remove("ScoreboardHide", "FAdmin_scoreboard");	// remove default scoreboard
	hook.Remove("ScoreboardShow", "FAdmin_scoreboard");	// remove default scoreboard

	hook.Add("ScoreboardShow", "_blackberry.scoreboard", function()
		if (FAdmin and IsValid(FAdmin.ScoreBoard)) then FAdmin.ScoreBoard:Remove(); end;	// remove default scoreboard
		_blackberry.scoreboard.derma.Open();
		return true;
	end)
	hook.Add("ScoreboardHide", "_blackberry.scoreboard", function()
		_blackberry.scoreboard.derma.Close();
		return true;
	end)
end);