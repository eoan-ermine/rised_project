-- "addons\\sh_reports\\lua\\reports\\cl_menu_rating.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local function L(...) return SH_REPORTS:L(...) end

local matStar = Material("shenesis/reports/star.png", "noclamp smooth")

function SH_REPORTS:ShowRating(report_id, admin_name)
	if (IsValid(_SH_REPORTS_RATE)) then
		_SH_REPORTS_RATE:Remove()
	end

	local styl = self.Style
	local th, m = self:GetPadding(), self:GetMargin()
	local m2 = m * 0.5
	local ss = self:GetScreenScale()

	local cur_rate = 3
	local is = 64 * ss

	local frame = self:MakeWindow(L"rating")
	frame:SetSize(1, 144 * ss + m * 2)
	frame:MakePopup()
	_SH_REPORTS_RATE = frame

		local stars = vgui.Create("DPanel", frame)
		stars:SetDrawBackground(false)
		stars:Dock(FILL)
		stars:DockMargin(m, m, m, m)

			for i = 1, 5 do
				local st = vgui.Create("DButton", stars)
				st:SetToolTip(i .. "/" .. 5)
				st:SetText("")
				st:SetWide(64 * ss)
				st:Dock(LEFT)
				st:DockMargin(0, 0, m2, 0)
				st.Paint = function(me, w, h)
					if (!me.m_CurColor) then
						me.m_CurColor = styl.inbg
					else
						me.m_CurColor = self:LerpColor(FrameTime() * 20, me.m_CurColor, cur_rate >= i and styl.rating or styl.inbg)
					end

					surface.SetMaterial(matStar)
					surface.SetDrawColor(me.m_CurColor)
					surface.DrawTexturedRect(0, 0, w, h)
				end
				st.OnCursorEntered = function()
					cur_rate = i
				end
				st.DoClick = function()
					easynet.SendToServer("SH_REPORTS.RateAdmin", {report_id = report_id, rating = i})
					frame:Close()
				end
			end

		local lbl = self:QuickLabel(L("rate_question", admin_name), "{prefix}Large", styl.text, frame)
		lbl:SetContentAlignment(5)
		lbl:Dock(BOTTOM)
		lbl:DockMargin(0, 0, 0, m)
		
	frame:SetWide(math.max(400 * ss, lbl:GetWide() + m * 2))
	frame:Center()
	
	local sp = math.ceil((frame:GetWide() - (64 * ss) * 5 - m * 4) * 0.5)
	stars:DockPadding(sp, 0, sp, 0)
end

easynet.Callback("SH_REPORTS.PromptRating", function(data)
	SH_REPORTS:ShowRating(data.report_id, data.admin_name)
end)