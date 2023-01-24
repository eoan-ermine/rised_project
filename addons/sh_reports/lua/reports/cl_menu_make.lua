-- "addons\\sh_reports\\lua\\reports\\cl_menu_make.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local function L(...) return SH_REPORTS:L(...) end

local matBack = Material("shenesis/general/back.png")

function SH_REPORTS:ShowMakeReports(c, d)
	if (IsValid(_SH_REPORTS_MAKE)) then
		_SH_REPORTS_MAKE:Remove()
	end

	local styl = self.Style
	local th, m = self:GetPadding(), self:GetMargin()
	local m2 = m * 0.5
	local ss = self:GetScreenScale()

	local frame = self:MakeWindow(L"new_report")
	frame:SetSize(500 * ss, 500 * ss)
	frame:Center()
	frame:MakePopup()
	_SH_REPORTS_MAKE = frame

		frame:AddHeaderButton(matBack, function()
			frame:Close()
			self:ShowReports()
		end)

		local body = vgui.Create("DPanel", frame)
		body:SetDrawBackground(false)
		body:Dock(FILL)
		body:DockMargin(m, m, m, m)

			local lbl = self:QuickLabel(L"reason" .. ":", "{prefix}Large", styl.text, body)
			lbl:Dock(TOP)

				local reason = self:QuickComboBox(lbl)
				reason:Dock(FILL)
				reason:DockMargin(lbl:GetWide() + m, 0, 0, 0)

				for rid, r in pairs (self.ReportReasons) do
					reason:AddChoice(r, rid)
				end

			local lbl = self:QuickLabel(L"player_to_report" .. ":", "{prefix}Large", styl.text, body)
			lbl:Dock(TOP)
			lbl:DockMargin(0, m, 0, m)

				local target = self:QuickComboBox(lbl)
				target:SetSortItems(false)
				target:Dock(FILL)
				target:DockMargin(lbl:GetWide() + m, 0, 0, 0)

				local toadd = {}
				for _, ply in ipairs (player.GetAll()) do
					if (ply == LocalPlayer()) then
						continue end

					if (self:IsAdmin(ply) and !self.StaffCanBeReported) then
						continue end

					table.insert(toadd, {nick = ply:SteamName(), steamid = ply:SteamID64()})
				end

				for _, d in SortedPairsByMemberValue (toadd, "nick") do
					target:AddChoice(d.nick, d.steamid)
				end

				if (self.CanReportOther) then
					target:AddChoice("​[" .. L"other" .. "]", "0")
				end

			local p = vgui.Create("DPanel", body)
			p:SetTall(64 * ss + m)
			p:Dock(TOP)
			p:DockPadding(m2, m2, m2, m2)
			p.Paint = function(me, w, h)
				draw.RoundedBox(4, 0, 0, w, h, styl.inbg)
			end

				local pc = vgui.Create("DPanel", p)
				pc:SetPaintedManually(true)
				pc:SetDrawBackground(false)
				pc:Dock(FILL)

					local avi = self:Avatar("", 64 * ss, pc)
					avi:Dock(LEFT)
					avi:DockMargin(0, 0, m2, 0)

					local nick = self:QuickLabel("", "{prefix}Large", styl.text, pc)
					nick:Dock(TOP)

					local steamid = self:QuickLabel("", "{prefix}Medium", styl.text, pc)
					steamid:Dock(TOP)

			local lbl = self:QuickLabel(L"comment" .. ":" /* 76561198037478513 */, "{prefix}Large", styl.text, body)
			lbl:SetContentAlignment(7)
			lbl:Dock(FILL)
			lbl:DockMargin(0, m, 0, 0)

				local comment = self:QuickEntry("", lbl)
				comment:SetValue(c or "")
				comment:SetMultiline(true)
				comment:Dock(FILL)
				comment:DockMargin(0, lbl:GetTall() + m2, 0, 0)

			local btns = vgui.Create("DPanel", body)
			btns:SetDrawBackground(false)
			btns:Dock(BOTTOM)
			btns:DockMargin(0, m, 0, 0)

				local submit = self:QuickButton(L"submit_report", function()
					local name, steamid = target:GetSelected()
					if (!steamid) then
						self:Notify(L"select_player_first", nil, styl.failure, frame)
						return
					end

					local _, rid = reason:GetSelected()
					if (!rid) then
						self:Notify(L"select_reason_first", nil, styl.failure, frame)
						return
					end

					easynet.SendToServer("SH_REPORTS.NewReport", {
						reported_name = name,
						reported_id = steamid,
						reason_id = rid,
						comment = comment:GetValue():sub(1, self.MaxCommentLength),
					})

					frame:Close()
				end, btns)
				submit:Dock(RIGHT)

			-- cbs
			if (d) then
				reason.OnSelect = function(me, index, value, data)
					local k = self.ReasonAutoTarget[value]
					if (!k) then
						return end

					local p = d["last" .. k]
					if (IsValid(p)) then
						local i
						for k, v in pairs (target.Choices) do
							if (v == p:SteamName()) then
								i = k
								break
							end
						end

						if (i) then
							target:ChooseOption(p:SteamName(), i)
						end
					end
				end
			end
			target.OnSelect = function(me, index, value, data)
				pc:SetPaintedManually(false)
				pc:SetAlpha(0)
				pc:AlphaTo(255, 0.2)

				avi:SetVisible(data ~= "0")
				avi:SetSteamID(data)
				nick:SetText(value)
				steamid:SetText(data ~= "0" and util.SteamIDFrom64(data) or "")
				steamid:InvalidateParent(true)
			end

	frame:SetAlpha(0)
	frame:AlphaTo(255, 0.1)
end

easynet.Callback("SH_REPORTS.QuickReport", function(data)
	SH_REPORTS:ShowMakeReports(data.comment, data)
end)