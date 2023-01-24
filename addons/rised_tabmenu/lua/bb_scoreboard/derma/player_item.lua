-- "addons\\rised_tabmenu\\lua\\bb_scoreboard\\derma\\player_item.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
// Global vars
local _blackberry = _blackberry or {};
_blackberry.scoreboard = _blackberry.scoreboard or {};
local core = _blackberry.scoreboard;
core.derma = core.derma or {};
core.derma.activeMenu = core.derma.activeMenu or nil;

local x, y, sx, sy = ScrW(), ScrH(), ScrW(), ScrH();

function core.derma:CreateFilterList(parent)
	local sheight = 0;
	/*---------------------------------------------------------------------------
	SortBy
	---------------------------------------------------------------------------*/
	local header = vgui.Create("DPanel", parent);
	header:SetSize(parent:GetWide(), 23);
	header:SetPos(0, 23+5); sheight = sheight + 23 + 5;
	header.Paint = function(self, w, h)
		draw.SimpleText("Сортировка по:", "Raleway 15", 0, h, Color(255, 255, 255, 150), 0, 4);
	end;

	local val1 = vgui.Create("DComboBox", parent)
	val1:SetPos(0, 23+5+sheight);
	val1:SetSize(parent:GetWide(), 20); sheight = sheight + 20 + 5;
	val1:SetValue("Профессии");
	val1:AddChoice("Профессии");
	val1:AddChoice("Имена");
	val1.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 50));
	end;
	val1.OnSelect = function( panel, index, value )
		core.derma.states.sortBy = value;
	end;

	local header = vgui.Create("DPanel", parent);
	header:SetSize(parent:GetWide(), 23);
	header:SetPos(0, 23+5+sheight); sheight = sheight + 23 + 5;
	header.Paint = function(self, w, h)
		draw.SimpleText("Фильтр по профессии:", "Raleway 15", 0, h, Color(255, 255, 255, 150), 0, 4);
	end;

	local val1 = vgui.Create("DComboBox", parent)
	val1:SetPos(0, 23+5+sheight);
	val1:SetSize(parent:GetWide(), 20); sheight = sheight + 20 + 5;
	val1:SetValue(core.derma.states.showGroup);
	val1:AddChoice("All");
	for k, v in pairs(DarkRP.getCategories().jobs) do
		val1:AddChoice(v.name);
	end;
	val1.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 50));
	end;
	val1.OnSelect = function( panel, index, value )
		core.derma.states.showGroup = value;
	end;

	return sheight;
end;

function core.derma:CreatePlayerItemMinimalistic(ply, parent, width)
	local profile = vgui.Create("DButton", parent);
	profile:SetSize(width,28);
	profile.ply = ply;
	profile.own = function(self)
		if (IsValid(self.ply) and self.ply:IsPlayer()) then return self.ply; end;
		return LocalPlayer();
	end;
	profile:SetText("");
	profile.Paint = function(self, w, h)
		local ply = self.own(self);
		self.lerp = Lerp(FrameTime()*4, self.lerp or 0, self.hovered and 1 or 0);
		local r, g, b = team.GetColor(ply:Team()).r, team.GetColor(ply:Team()).g, team.GetColor(ply:Team()).b;

		//local active_color = Color((r < 50 and 50+r or r), (g < 50 and 50 + g or g), (b < 50 and 50 + b or b), 100*self.lerp);
		local active_color = Color(r, g, b, 255*self.lerp);
		draw.RoundedBox(0, 0, 0, 2, h, Color(255, 255, 255, 50-50*self.lerp));
		draw.RoundedBox(0, 0, 0, 2, h, active_color);
		draw.RoundedBox(0, 0, h-2, w, 2, active_color);
		draw.RoundedBox(0, 2, 0, w-2, h, Color(0, 0, 0, 100*self.lerp));

		if (_blackberry.character_base and _blackberry.character_base.config["need_recognize"]) then
			draw.SimpleText((!ply:isCP() and !LocalPlayer()._char_rec[ply:SteamID()] and ply != LocalPlayer()) and "Unknown character" or ply:Name(), "Raleway 17", 28+5, 17/2, Color(255, 255, 255, 150 + 105*self.lerp), 0, 1);
		else
			if ply:GetNWBool("Rised_Premium") then
				draw.SimpleText("◈ " .. ply:SteamName() .. " ◈", "Raleway 17", 28+5, 17/2, Color(255, 215, 0, 255), 0, 1);
			elseif ply:GetNWString("usergroup") == "superadmin" then
				draw.SimpleText("≪ " .. ply:SteamName() .. " ≫", "ChatFont", 28+5, 17/2, Color(255, 255, 255, 255), 0, 1);
			elseif ply:GetNWString("usergroup") == "hand" then
				draw.SimpleText("≪ " .. ply:SteamName() .. " ≫", "ChatFont", 28+5, 17/2, Color(155, 0, 0, 255), 0, 1);
			elseif ply:GetNWString("usergroup") == "retinue" then
				draw.SimpleText("≪ " .. ply:SteamName() .. " ≫", "ChatFont", 28+5, 17/2, Color(155, 0, 0, 255), 0, 1);
			elseif ply:GetNWString("usergroup") == "rp_curator" then
				draw.SimpleText("「 " .. ply:SteamName() .. " 」", "Raleway 17", 28+5, 17/2, Color(100, 255, 100, 255), 0, 1);
			elseif ply:GetNWString("usergroup") == "censor" then
				draw.SimpleText("⊲ " .. ply:SteamName() .. " ⊳", "Raleway 17", 28+5, 17/2, Color(255, 125, 0, 255), 0, 1);
			elseif ply:GetNWString("usergroup") == "candidate" then
				draw.SimpleText("⊲ " .. ply:SteamName() .. " ⊳", "Raleway 17", 28+5, 17/2, Color(255, 125, 0, 255), 0, 1);
			elseif ply:GetNWString("usergroup") == "inf_moderator" then
				draw.SimpleText("⊲ " .. ply:SteamName() .. " ⊳", "Raleway 17", 28+5, 17/2, Color(255, 125, 0, 255), 0, 1);
			elseif ply:GetNWString("usergroup") == "sup_moderator" then
				draw.SimpleText("⊲ " .. ply:SteamName() .. " ⊳", "Raleway 17", 28+5, 17/2, Color(255, 125, 0, 255), 0, 1);
			elseif ply:GetNWString("usergroup") == "admin_III" then
				draw.SimpleText("☩ " .. ply:SteamName() .. " ☩", "Raleway 17", 28+5, 17/2, Color(255, 0, 0, 255), 0, 1);
			elseif ply:GetNWString("usergroup") == "admin_II" then
				draw.SimpleText("☩ " .. ply:SteamName() .. " ☩", "Raleway 17", 28+5, 17/2, Color(255, 0, 0, 255), 0, 1);
			elseif ply:GetNWString("usergroup") == "admin_I" then
				draw.SimpleText("☩ " .. ply:SteamName() .. " ☩", "Raleway 17", 28+5, 17/2, Color(255, 0, 0, 255), 0, 1);
			elseif ply:GetNWString("usergroup") == "rec_eventer" then
				draw.SimpleText("◭ " .. ply:SteamName() .. " ◭", "Raleway 17", 28+5, 17/2, Color(200, 200, 255, 255), 0, 1);
			elseif ply:GetNWString("usergroup") == "inf_eventer" then
				draw.SimpleText("◭ " .. ply:SteamName() .. " ◭", "Raleway 17", 28+5, 17/2, Color(200, 200, 255, 255), 0, 1);
			elseif ply:GetNWString("usergroup") == "sup_eventer" then
				draw.SimpleText("◭ " .. ply:SteamName() .. " ◭", "Raleway 17", 28+5, 17/2, Color(200, 200, 255, 255), 0, 1);
			elseif ply:GetNWString("usergroup") == "event_manager" then
				draw.SimpleText("◭ " .. ply:SteamName() .. " ◭", "Raleway 17", 28+5, 17/2, Color(200, 200, 255, 255), 0, 1);
			else
				draw.SimpleText(ply:SteamName(), "Raleway 17", 28+5, 17/2, Color(255, 255, 255, 150 + 105*self.lerp), 0, 1);
			end
		end;
		
		if LocalPlayer():Team() == TEAM_ADMINISTRATOR or LocalPlayer():Team() == TEAM_GMAN then
			if ply:GetNWBool("Rised_Premium") then
				draw.SimpleText(ply:Name() .. " - " .. team.GetName(ply:Team()), "Raleway Bold 13", 28+5, 20, Color(255, 215, 0, 255), 0, 1);
			elseif ply:GetNWString("usergroup") == "superadmin" then
				draw.SimpleText(ply:Name() .. " - " .. team.GetName(ply:Team()), "Raleway Bold 13", 28+5, 20, Color(255, 255, 255, 255), 0, 1);
			elseif ply:GetNWString("usergroup") == "hand" then
				draw.SimpleText(ply:Name() .. " - " .. team.GetName(ply:Team()), "Raleway Bold 13", 28+5, 20, Color(255, 255, 255, 255), 0, 1);
			elseif ply:GetNWString("usergroup") == "retinue" then
				draw.SimpleText(ply:Name() .. " - " .. team.GetName(ply:Team()), "Raleway Bold 13", 28+5, 20, Color(255, 255, 255, 255), 0, 1);
			elseif ply:GetNWString("usergroup") == "rp_curator" then
				draw.SimpleText(ply:Name() .. " - " .. team.GetName(ply:Team()), "Raleway Bold 13", 28+5, 20, Color(100, 255, 100, 255), 0, 1);
			elseif ply:GetNWString("usergroup") == "builder" then
				draw.SimpleText(ply:Name() .. " - " .. team.GetName(ply:Team()), "Raleway Bold 13", 28+5, 20, Color(45, 225, 45, 255), 0, 1);
			elseif ply:GetNWString("usergroup") == "censor" then
				draw.SimpleText(ply:Name() .. " - " .. team.GetName(ply:Team()), "Raleway Bold 13", 28+5, 20, Color(255, 125, 0, 255), 0, 1);
			elseif ply:GetNWString("usergroup") == "inf_moderator" then
				draw.SimpleText(ply:Name() .. " - " .. team.GetName(ply:Team()), "Raleway Bold 13", 28+5, 20, Color(255, 125, 0, 255), 0, 1);
			elseif ply:GetNWString("usergroup") == "sup_moderator" then
				draw.SimpleText(ply:Name() .. " - " .. team.GetName(ply:Team()), "Raleway Bold 13", 28+5, 20, Color(255, 125, 0, 255), 0, 1);
			elseif ply:GetNWString("usergroup") == "admin_III" then
				draw.SimpleText(ply:Name() .. " - " .. team.GetName(ply:Team()), "Raleway Bold 13", 28+5, 20, Color(255, 0, 0, 255), 0, 1);
			elseif ply:GetNWString("usergroup") == "admin_II" then
				draw.SimpleText(ply:Name() .. " - " .. team.GetName(ply:Team()), "Raleway Bold 13", 28+5, 20, Color(255, 0, 0, 255), 0, 1);
			elseif ply:GetNWString("usergroup") == "admin_I" then
				draw.SimpleText(ply:Name() .. " - " .. team.GetName(ply:Team()), "Raleway Bold 13", 28+5, 20, Color(255, 0, 0, 255), 0, 1);
			elseif ply:GetNWString("usergroup") == "inf_eventer" then
				draw.SimpleText(ply:Name() .. " - " .. team.GetName(ply:Team()), "Raleway Bold 13", 28+5, 20, Color(200, 200, 255, 255), 0, 1);
			elseif ply:GetNWString("usergroup") == "sup_eventer" then
				draw.SimpleText(ply:Name() .. " - " .. team.GetName(ply:Team()), "Raleway Bold 13", 28+5, 20, Color(200, 200, 255, 255), 0, 1);
			elseif ply:GetNWString("usergroup") == "event_manager" then
				draw.SimpleText(ply:Name() .. " - " .. team.GetName(ply:Team()), "Raleway Bold 13", 28+5, 20, Color(200, 200, 255, 255), 0, 1);
			else
				draw.SimpleText(ply:Name() .. " - " .. team.GetName(ply:Team()), "Raleway Bold 13", 28+5, 20, Color(255, 255, 255, 75 + 105*self.lerp), 0, 1);
			end
		else
			if LocalPlayer():isCP() and LocalPlayer():Team() != TEAM_MPF_JURY_Conscript then
				if FaceMemory_Check(ply) || LocalPlayer() == ply || ply:isCP() || ply:Team() == TEAM_REBELSPY01 then
					if ply:GetNWBool("Rised_Premium") then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 215, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "superadmin" then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 255, 255, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "hand" then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 255, 255, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "retinue" then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 255, 255, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "rp_curator" then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(100, 255, 100, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "censor" then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 125, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "meister" then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(200, 200, 255, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "inquisitor" then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 0, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "inf_moderator" then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 125, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "sup_moderator" then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 125, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "admin_III" then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 0, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "admin_II" then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 0, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "admin_I" then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 0, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "inf_eventer" then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(200, 200, 255, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "sup_eventer" then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(200, 200, 255, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "event_manager" then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(200, 200, 255, 255), 0, 1);
					else
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 255, 255, 75 + 105*self.lerp), 0, 1);
					end
				else
					if ply:GetNWBool("Rised_Premium") then
						draw.SimpleText("Недостаточно информации...", "Raleway Bold 13", 28+5, 20, Color(255, 215, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "superadmin" then
						draw.SimpleText("Недостаточно информации...", "Raleway Bold 13", 28+5, 20, Color(255, 255, 255, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "hand" then
						draw.SimpleText("Недостаточно информации......", "Raleway Bold 13", 28+5, 20, Color(255, 255, 255, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "retinue" then
						draw.SimpleText("Недостаточно информации......", "Raleway Bold 13", 28+5, 20, Color(255, 255, 255, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "rp_curator" then
						draw.SimpleText("Недостаточно информации...", "Raleway Bold 13", 28+5, 20, Color(100, 255, 100, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "censor" then
						draw.SimpleText("Недостаточно информации...", "Raleway Bold 13", 28+5, 20, Color(255, 125, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "meister" then
						draw.SimpleText("Недостаточно информации...", "Raleway Bold 13", 28+5, 20, Color(200, 200, 255, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "inquisitor" then
						draw.SimpleText("Недостаточно информации...", "Raleway Bold 13", 28+5, 20, Color(255, 0, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "inf_moderator" then
						draw.SimpleText("Недостаточно информации...", "Raleway Bold 13", 28+5, 20, Color(255, 125, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "sup_moderator" then
						draw.SimpleText("Недостаточно информации...", "Raleway Bold 13", 28+5, 20, Color(255, 125, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "admin_III" then
						draw.SimpleText("Недостаточно информации...", "Raleway Bold 13", 28+5, 20, Color(255, 0, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "admin_II" then
						draw.SimpleText("Недостаточно информации...", "Raleway Bold 13", 28+5, 20, Color(255, 0, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "admin_I" then
						draw.SimpleText("Недостаточно информации...", "Raleway Bold 13", 28+5, 20, Color(255, 0, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "inf_eventer" then
						draw.SimpleText("Недостаточно информации...", "Raleway Bold 13", 28+5, 20, Color(200, 200, 255, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "sup_eventer" then
						draw.SimpleText("Недостаточно информации...", "Raleway Bold 13", 28+5, 20, Color(200, 200, 255, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "event_manager" then
						draw.SimpleText("Недостаточно информации...", "Raleway Bold 13", 28+5, 20, Color(200, 200, 255, 255), 0, 1);
					else
						draw.SimpleText("Недостаточно информации...", "Raleway Bold 13", 28+5, 20, Color(255, 255, 255, 75 + 105*self.lerp), 0, 1);
					end
				end
			elseif GAMEMODE.Rebels[LocalPlayer():Team()] and GAMEMODE.Rebels[ply:Team()] then
				if ply:GetNWBool("Rised_Premium") then
					draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 215, 0, 255), 0, 1);
				elseif ply:GetNWString("usergroup") == "superadmin" then
					draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 255, 255, 255), 0, 1);
				elseif ply:GetNWString("usergroup") == "hand" then
					draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 255, 255, 255), 0, 1);
				elseif ply:GetNWString("usergroup") == "retinue" then
					draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 255, 255, 255), 0, 1);
				elseif ply:GetNWString("usergroup") == "rp_curator" then
					draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(100, 255, 100, 255), 0, 1);
				elseif ply:GetNWString("usergroup") == "censor" then
					draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 125, 0, 255), 0, 1);
				elseif ply:GetNWString("usergroup") == "meister" then
					draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(200, 200, 255, 255), 0, 1);
				elseif ply:GetNWString("usergroup") == "inquisitor" then
					draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 0, 0, 255), 0, 1);
				elseif ply:GetNWString("usergroup") == "inf_moderator" then
					draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 125, 0, 255), 0, 1);
				elseif ply:GetNWString("usergroup") == "sup_moderator" then
					draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 125, 0, 255), 0, 1);
				elseif ply:GetNWString("usergroup") == "admin_III" then
					draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 0, 0, 255), 0, 1);
				elseif ply:GetNWString("usergroup") == "admin_II" then
					draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 0, 0, 255), 0, 1);
				elseif ply:GetNWString("usergroup") == "admin_I" then
					draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 0, 0, 255), 0, 1);
				elseif ply:GetNWString("usergroup") == "inf_eventer" then
					draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(200, 200, 255, 255), 0, 1);
				elseif ply:GetNWString("usergroup") == "sup_eventer" then
					draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(200, 200, 255, 255), 0, 1);
				elseif ply:GetNWString("usergroup") == "event_manager" then
					draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(200, 200, 255, 255), 0, 1);
				else
					draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 255, 255, 75 + 105*self.lerp), 0, 1);
				end
			else
				if FaceMemory_Check(ply) then
					if ply:GetNWBool("Rised_Premium") then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 215, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "superadmin" then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 255, 255, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "hand" then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 255, 255, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "retinue" then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 255, 255, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "rp_curator" then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(100, 255, 100, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "censor" then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 125, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "meister" then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(200, 200, 255, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "inquisitor" then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 0, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "inf_moderator" then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 125, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "sup_moderator" then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 125, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "admin_III" then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 0, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "admin_II" then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 0, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "admin_I" then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 0, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "inf_eventer" then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(200, 200, 255, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "sup_eventer" then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(200, 200, 255, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "event_manager" then
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(200, 200, 255, 255), 0, 1);
					else
						draw.SimpleText(ply:Name(), "Raleway Bold 13", 28+5, 20, Color(255, 255, 255, 75 + 105*self.lerp), 0, 1);
					end
				else
					if ply:GetNWBool("Rised_Premium") then
						draw.SimpleText("Недостаточно информации...", "Raleway Bold 13", 28+5, 20, Color(255, 215, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "superadmin" then
						draw.SimpleText("Недостаточно информации...", "Raleway Bold 13", 28+5, 20, Color(255, 255, 255, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "hand" then
						draw.SimpleText("Недостаточно информации......", "Raleway Bold 13", 28+5, 20, Color(255, 255, 255, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "retinue" then
						draw.SimpleText("Недостаточно информации......", "Raleway Bold 13", 28+5, 20, Color(255, 255, 255, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "rp_curator" then
						draw.SimpleText("Недостаточно информации...", "Raleway Bold 13", 28+5, 20, Color(100, 255, 100, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "censor" then
						draw.SimpleText("Недостаточно информации...", "Raleway Bold 13", 28+5, 20, Color(255, 125, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "meister" then
						draw.SimpleText("Недостаточно информации...", "Raleway Bold 13", 28+5, 20, Color(200, 200, 255, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "inquisitor" then
						draw.SimpleText("Недостаточно информации...", "Raleway Bold 13", 28+5, 20, Color(255, 0, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "inf_moderator" then
						draw.SimpleText("Недостаточно информации...", "Raleway Bold 13", 28+5, 20, Color(255, 125, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "sup_moderator" then
						draw.SimpleText("Недостаточно информации...", "Raleway Bold 13", 28+5, 20, Color(255, 125, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "admin_III" then
						draw.SimpleText("Недостаточно информации...", "Raleway Bold 13", 28+5, 20, Color(255, 0, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "admin_II" then
						draw.SimpleText("Недостаточно информации...", "Raleway Bold 13", 28+5, 20, Color(255, 0, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "admin_I" then
						draw.SimpleText("Недостаточно информации...", "Raleway Bold 13", 28+5, 20, Color(255, 0, 0, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "inf_eventer" then
						draw.SimpleText("Недостаточно информации...", "Raleway Bold 13", 28+5, 20, Color(200, 200, 255, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "sup_eventer" then
						draw.SimpleText("Недостаточно информации...", "Raleway Bold 13", 28+5, 20, Color(200, 200, 255, 255), 0, 1);
					elseif ply:GetNWString("usergroup") == "event_manager" then
						draw.SimpleText("Недостаточно информации...", "Raleway Bold 13", 28+5, 20, Color(200, 200, 255, 255), 0, 1);
					else
						draw.SimpleText("Недостаточно информации...", "Raleway Bold 13", 28+5, 20, Color(255, 255, 255, 75 + 105*self.lerp), 0, 1);
					end
				end
			end
		end
	end;
	profile.OnCursorEntered = function(self)
		--surface.PlaySound("physics/metal/metal_popcan_impact_hard1.wav");
		self.hovered = true;
	end;
	profile.OnCursorExited = function(self)
		self.hovered = false;
	end;
	profile.DoClick = function(self)
		--surface.PlaySound("physics/metal/metal_popcan_impact_hard1.wav");
		core.derma.OpenProfile(self.own(self));
	end;

	local Avatar = vgui.Create("AvatarImage", profile);
	Avatar:SetSize(28, 28);
	Avatar:SetPos(2, 0);
	Avatar:SetPlayer(ply, 28);

	return profile;
end;

function core.derma:CreatePlayerItem(ply, parent, width) 
	if (!core.config["minimalistic"]) then
		local profile = core.derma:CreatePlayerItemMinimalistic(ply, parent, width);
		return profile;
	end;
	local profile = vgui.Create("DButton", parent);
	profile:SetSize(width,36);
	profile:SetText("");
	profile.own = ply;
	profile.Paint = function(self, w, h)
		local ply = self.own;
		self.lerp = Lerp(FrameTime()*4, self.lerp or 0, self.hovered and 1 or 0);
		local r, g, b = team.GetColor(ply:Team()).r, team.GetColor(ply:Team()).g, team.GetColor(ply:Team()).b;

		local active_color = Color((r < 50 and 50+r or r), (g < 50 and 50 + g or g), (b < 50 and 50 + b or b), 100*self.lerp);
		draw.RoundedBox(0, 0, 0, w, h, active_color);

		if (_blackberry.character_base) then
			draw.SimpleText((!ply:isCP() and !LocalPlayer()._char_rec[ply:SteamID()] and ply != LocalPlayer()) and "Unknown character" or ply:Name(), "Raleway 17", 36+4, 17/2, Color(255, 255, 255, 150 + 105*self.lerp), 0, 1);
			draw.SimpleText(ply:getChar():GetVar("description"), "Raleway 13", 36+4, 20, Color(255, 255, 255, 75), 0, 0);
		else
			draw.SimpleText(ply:SteamName(), "Raleway 17", 36+4, 17/2, Color(255, 255, 255, 150 + 105*self.lerp), 0, 1);
			if ply:GetUserGroup() == "superadmin" and ply:SteamID() == "STEAM_0:1:38606392" then
				draw.SimpleText("Создатель", "Raleway 13", 36+4, 20, Color(255, 255, 255, 75), 0, 0);
			else
				draw.SimpleText(core.config["staff_replace"][ply:GetUserGroup()] and core.config["staff_replace"][ply:GetUserGroup()] or ply:GetUserGroup(), "Raleway 13", 36+4, 20, Color(255, 255, 255, 75), 0, 0);
			end
		end;

		draw.SimpleText(ply:Ping().." ms", "Raleway 17", w-50, 17/2, Color(255, 255, 255, 255), 0, 1);
		draw.SimpleText(ply:Deaths(), "Raleway 17", w-125, 17/2, Color(255, 255, 255, 255), 0, 1);
		draw.SimpleText(ply:Frags(), "Raleway 17", w-175, 17/2, Color(255, 255, 255, 255), 0, 1);

		draw.SimpleText(team.GetName(ply:Team()), "Raleway 17", w/2, 17/2, Color(255, 255, 255, 255), 0, 1);

		surface.SetFont("Raleway 17");
		local width, height = surface.GetTextSize(team.GetName(ply:Team()));
		draw.DashedLine(w/2, 17+1, width+4, 1, 1, 2, Color(255, 255, 255, 50 + 205*self.lerp));

		//draw.DashedLine(0, h-1, w*self.lerp, 1, 1, 2, Color(255, 255, 255));
	end;
	profile.OnCursorEntered = function(self)
		--surface.PlaySound("physics/metal/chain_impact_hard2.wav");
		self.hovered = true;
	end;
	profile.OnCursorExited = function(self)
		self.hovered = false;
	end;
	profile.DoClick = function()
		if (!IsValid(ply)) then return; end;
		--surface.PlaySound("physics/metal/metal_popcan_impact_hard1.wav");
		core.derma.OpenProfile(ply);
	end;

	local Avatar = vgui.Create("AvatarImage", profile);
	Avatar:SetSize(36, 36);
	Avatar:SetPos(2, 0);
	Avatar:SetPlayer(ply, 36);

	return profile;
end;