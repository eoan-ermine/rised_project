-- "addons\\sh_reports\\lua\\reports\\cl_menu_performance.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local function L(...) return SH_REPORTS:L(...) end

local matBack = Material("shenesis/general/back.png")

function SH_REPORTS:ShowPerformanceReports()
	if (IsValid(_SH_REPORTS_PERF)) then
		_SH_REPORTS_PERF:Remove()
	end

	local styl = self.Style
	local th, m = self:GetPadding(), self:GetMargin()
	local m2 = m * 0.5
	local ss = self:GetScreenScale()

	local delay = 0
	if (self.ServerTime) then
		delay = self.ServerTime - os.time()
	end

	local curprep

	local frame = self:MakeWindow(L"performance_reports")
	frame:SetSize(800 * ss, 600 * ss)
	frame:Center()
	frame:MakePopup()
	_SH_REPORTS_PERF = frame

		frame:AddHeaderButton(matBack, function()
			frame:Close()
			self:ShowReports()
		end)

		local sel = vgui.Create("DScrollPanel", frame)
		sel:SetDrawBackground(false)
		sel:SetWide(140 * ss)
		sel:Dock(LEFT)
		sel.Paint = function(me, w, h)
			draw.RoundedBoxEx(4, 0, 0, w, h, styl.inbg, false, false, true, false)
		end
		self:PaintScroll(sel)

		local ilist_perf = vgui.Create("DListView", frame)
		ilist_perf:SetVisible(false)
		ilist_perf:SetSortable(false)
		ilist_perf:SetDrawBackground(false)
		ilist_perf:SetDataHeight(32)
		ilist_perf:Dock(FILL)
		ilist_perf:AddColumn(L"admin")
		ilist_perf:AddColumn(L"num_claimed")
		ilist_perf:AddColumn(L"num_closed")
		ilist_perf:AddColumn(L"time_spent")
		self:PaintList(ilist_perf)

		local ilist_rating = vgui.Create("DListView", frame)
		ilist_rating:SetVisible(false)
		ilist_rating:SetSortable(false)
		ilist_rating:SetDrawBackground(false)
		ilist_rating:SetDataHeight(32)
		ilist_rating:Dock(FILL)
		ilist_rating:AddColumn(L"admin")
		ilist_rating:AddColumn(L"rating")
		self:PaintList(ilist_rating)

		local ilist_history = vgui.Create("DListView", frame)
		ilist_history:SetVisible(false)
		ilist_history:SetSortable(false)
		ilist_history:SetDrawBackground(false)
		ilist_history:SetDataHeight(32)
		ilist_history:Dock(FILL)
		ilist_history:AddColumn(L"reporter")
		ilist_history:AddColumn(L"reported_player")
		ilist_history:AddColumn(L"reason")
		ilist_history:AddColumn(L"admin")
		ilist_history:AddColumn(L"rating")
		-- ilist_history.Think = function(me)
			-- local hover = vgui.GetHoveredPanel()
			-- if (!IsValid(_SH_REPORTS_HIST_DETAILS)) then
				-- if (!IsValid(hover) or !hover.m_HistoryReport) then
					-- return end
				
				-- _SH_REPORTS_HIST_DETAILS = NULL
			-- else
			
			-- end
		-- end
		self:PaintList(ilist_history)

		frame.ShowStaff = function(me, staffs)
			if (!ilist_perf:IsVisible()) then
				return end

			local i = 0
			for _, info in pairs (staffs) do
				local user = vgui.Create("DPanel", frame)
				user:SetDrawBackground(false)

					local avi = self:Avatar(info.steamid, 24, user)
					avi:SetPos(4, 4)

					local name = self:QuickLabel("...", "{prefix}Medium", styl.text, user)
					name:Dock(FILL)
					name:SetTextInset(ilist_perf:GetDataHeight(), 0)

					self:GetName(info.steamid, function(nick)
						if (IsValid(name)) then
							name:SetText(nick)
						end
					end)

				local line = ilist_perf:AddLine(user, info.claimed, info.closed, self:FullFormatTime(info.timespent))
				line:SetAlpha(0)
				line:AlphaTo(255, 0.1, 0.1 * i)
				self:LineStyle(line)

				i = i + 1
			end
		end

		frame.ShowRatings = function(me, ratings)
			if (!ilist_rating:IsVisible()) then
				return end

			ilist_rating:Clear()

			local i = 0
			for _, info in pairs (ratings) do
				if (info.num == 0) then
					continue end

				local frac = info.total / info.num / 5
				local tot = string.Comma(info.num)
				local tx = " " .. math.Round(frac * 100) .. "% (" .. tot .. ")"

				local user = vgui.Create("DPanel", frame)
				user:SetDrawBackground(false)

					local avi = self:Avatar(info.steamid, 24, user)
					avi:SetPos(4, 4)

					local name = self:QuickLabel("...", "{prefix}Medium", styl.text, user)
					name:Dock(FILL)
					name:SetTextInset(ilist_rating:GetDataHeight(), 0)

					self:GetName(info.steamid, function(nick)
						if (IsValid(name)) then
							name:SetText(nick)
						end
					end)

				local stars = vgui.Create("DPanel", frame)
				stars.Paint = function(me, w, h)
					local _x, _y = me:LocalToScreen(0, 0)

					surface.SetFont("SH_REPORTS.Large")
					local wi = surface.GetTextSize("★★★★★")

					surface.SetFont("SH_REPORTS.Medium")
					local wi2 = surface.GetTextSize(tx)

					local wid = wi + wi2

					draw.SimpleText("★★★★★", "SH_REPORTS.Large", w * 0.5 - wid * 0.5, h * 0.5, styl.inbg, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
					render.SetScissorRect(_x, _y, _x + w * 0.5 - wid * 0.5 + wi * frac, _y + h, true)
						draw.SimpleText("★★★★★", "SH_REPORTS.Large", w * 0.5 - wid * 0.5, h * 0.5, styl.rating, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
					render.SetScissorRect(0, 0, 0, 0, false)

					draw.SimpleText(tx, "SH_REPORTS.Medium", w * 0.5 - wid * 0.5 + wi, h * 0.5, styl.text, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				end

				local line = ilist_rating:AddLine(user, stars)
				line:SetAlpha(0)
				line:AlphaTo(255, 0.1, 0.1 * i)
				self:LineStyle(line)

				i = i + 1
			end
		end

		frame.ShowHistory = function(me, history)
			if (!ilist_history:IsVisible()) then
				return end

			ilist_history:Clear()

			local i = 0
			for _, info in pairs (history) do
				local reporter = vgui.Create("DPanel", frame)
				reporter:SetDrawBackground(false)

					local avi = self:Avatar(info.reporter, 24, reporter)
					avi:SetPos(4, 4)

					local name = self:QuickLabel("...", "{prefix}Medium", styl.text, reporter)
					name:Dock(FILL)
					name:SetTextInset(ilist_history:GetDataHeight(), 0)

					self:GetName(info.reporter, function(nick)
						if (IsValid(name)) then
							name:SetText(nick)
						end
					end)

				local reported = vgui.Create("DPanel", frame)
				reported:SetDrawBackground(false)

					local avi = self:Avatar(info.reported, 24, reported)
					avi:SetPos(4, 4)

					local name = self:QuickLabel("...", "{prefix}Medium", styl.text, reported)
					name:Dock(FILL)
					name:SetTextInset(ilist_history:GetDataHeight(), 0)

					if (info.reported == "0") then
						avi:SetVisible(false)
						name:SetText("[" .. L"other" .. "]")
						name:SetTextInset(0, 0)
						name:SetContentAlignment(5)
					else
						self:GetName(info.reported, function(nick)
							if (IsValid(name)) then
								name:SetText(nick)
							end
						end)
					end

				local admin = vgui.Create("DPanel", frame)
				admin:SetDrawBackground(false)

					local avi = self:Avatar(info.admin, 24, admin)
					avi:SetPos(4, 4)

					local name = self:QuickLabel("...", "{prefix}Medium", styl.text, admin)
					name:Dock(FILL)
					name:SetTextInset(ilist_history:GetDataHeight(), 0)

					self:GetName(info.admin, function(nick)
						if (IsValid(name)) then
							name:SetText(nick)
						end
					end)

				local rating
				if (info.rating > 0) then
					local frac = info.rating / 5

					rating = vgui.Create("DPanel", frame)
					rating.Paint = function(me, w, h)
						local _x, _y = me:LocalToScreen(0, 0)

						surface.SetFont("SH_REPORTS.Large")
						local wi = surface.GetTextSize("★★★★★")
						local wid = wi

						draw.SimpleText("★★★★★", "SH_REPORTS.Large", w * 0.5 - wid * 0.5, h * 0.5, styl.inbg, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
						render.SetScissorRect(_x, _y, _x + w * 0.5 - wid * 0.5 + wi * frac, _y + h, true)
							draw.SimpleText("★★★★★", "SH_REPORTS.Large", w * 0.5 - wid * 0.5, h * 0.5, styl.rating, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
						render.SetScissorRect(0, 0, 0, 0, false)
					end
				end

				local line = ilist_history:AddLine(reporter, reported, info.reason, admin, info.rating > 0 and rating or L"none")
				line:SetAlpha(0)
				line:AlphaTo(255, 0.1, 0.1 * i)
				line:SetToolTip(os.date(self.TimeFormat, info.date) .. "\n\n" .. L"waiting_time" .. ": " .. self:FullFormatTime(info.waiting_time) .. "\n\n" .. L"comment" .. ":\n" .. info.comment)
				self:LineStyle(line)
				
				// HAAAAAAAAACKS
				-- line.m_HistoryReport = info
				
				-- local function RecFix(s)
					-- for _, v in pairs (s:GetChildren()) do
						-- v.m_HistoryReport = info
						-- v.m_HistoryLine = line
						
						-- RecFix(v)
					-- end
				-- end
				
				-- RecFix(line)

				i = i + 1
			end
		end

		local function display_perf(start, prep)
			if (curprep == start) then
				return end

			curprep = start
			frame.m_iID = prep.id

			ilist_perf:Clear()
			ilist_perf:SetVisible(true)
			ilist_rating:SetVisible(false)
			ilist_history:SetVisible(false)

			local ds, de = os.date(self.DateFormat, start), os.date(self.DateFormat, prep.end_time)

			frame.m_Title:SetText(L"performance_reports" .. /* 76561198037478513 */ " (" .. ds .. " - " .. de .. ")")
			frame.m_Title:SizeToContentsX()

			if (prep.staff) then
				frame:ShowStaff(prep.staff)
			else
				easynet.SendToServer("SH_REPORTS.RequestPerfReportStaff", {id = prep.id})
			end

			self:Notify(L("displaying_perf_report_from_x_to_y", ds, de), 5, styl.success, frame)
		end

		local btn_ratings = self:QuickButton(L"rating", function()
			ilist_perf:SetVisible(false)
			ilist_history:SetVisible(false)
			ilist_rating:SetVisible(true)
			ilist_rating:Clear()

			frame.m_Title:SetText(L"performance_reports")
			frame.m_Title:SizeToContentsX()

			easynet.SendToServer("SH_REPORTS.RequestStaffRatings")
		end, sel)
		btn_ratings:SetContentAlignment(4)
		btn_ratings:SetTextInset(m + 2, 0)
		btn_ratings:Dock(TOP)
		btn_ratings:SetTall(32 * ss)
		btn_ratings.m_iRound = 0
		btn_ratings.PaintOver = function(me, w, h)
			if (ilist_rating:IsVisible()) then
				surface.SetDrawColor(styl.header)
				surface.DrawRect(0, 0, 4, h)
			end
		end

		local btn_history = self:QuickButton(L"history", function()
			ilist_perf:SetVisible(false)
			ilist_rating:SetVisible(false)
			ilist_history:SetVisible(true)
			ilist_history:Clear()

			frame.m_Title:SetText(L"performance_reports")
			frame.m_Title:SizeToContentsX()

			easynet.SendToServer("SH_REPORTS.RequestReportHistory")
		end, sel)
		btn_history:SetContentAlignment(4)
		btn_history:SetTextInset(m + 2, 0)
		btn_history:Dock(TOP)
		btn_history:SetTall(32 * ss)
		btn_history.m_iRound = 0
		btn_history.PaintOver = function(me, w, h)
			if (ilist_history:IsVisible()) then
				surface.SetDrawColor(styl.header)
				surface.DrawRect(0, 0, 4, h)
			end
		end

		for _, prep in SortedPairs (self.CachedPerfReports, true) do
			local btn = self:QuickButton(os.date(self.DateFormat, prep.start_time), function()
				display_perf(prep.start_time, prep)
			end, sel, nil, prep.end_time >= (os.time() + delay) and styl.success or styl.text)
			btn:SetContentAlignment(4)
			btn:SetTextInset(m + 2, 0)
			btn:Dock(TOP)
			btn:SetTall(32 * ss)
			btn.m_iRound = 0
			btn.PaintOver = function(me, w, h)
				if (curprep == prep.start_time and ilist_perf:IsVisible()) then
					surface.SetDrawColor(styl.header)
					surface.DrawRect(0, 0, 4, h)
				end
			end
		end

	frame:SetAlpha(0)
	frame:AlphaTo(255, 0.1)
end

easynet.Callback("SH_REPORTS.SendPerfReports", function(data)
	SH_REPORTS.CachedPerfReports = data.struct_perf_reports
	SH_REPORTS:ShowPerformanceReports()
end)

easynet.Callback("SH_REPORTS.SendPerfReportStaff", function(data)
	if (!IsValid(_SH_REPORTS_PERF) or _SH_REPORTS_PERF.m_iID ~= data.id) then
		return end

	_SH_REPORTS_PERF:ShowStaff(data.struct_perf_reports_staff)
end)

easynet.Callback("SH_REPORTS.SendRatings", function(data)
	if (!IsValid(_SH_REPORTS_PERF)) then
		return end

	_SH_REPORTS_PERF:ShowRatings(data.struct_rating)
end)

easynet.Callback("SH_REPORTS.SendHistoryList", function(data)
	if (!IsValid(_SH_REPORTS_PERF)) then
		return end

	local steamids = data.struct_history_steamids
	for _, dat in pairs (data.struct_history_list) do
		dat.reporter = steamids[dat.reporter_nid].steamid
		dat.reported = steamids[dat.reported_nid].steamid
		dat.admin = steamids[dat.admin_nid].steamid

		dat.reporter_nid = nil
		dat.reported_nid = nil
		dat.admin_nid = nil
	end

	_SH_REPORTS_PERF:ShowHistory(data.struct_history_list)
end)