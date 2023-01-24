-- "addons\\sh_reports\\lua\\reports\\cl_main.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if (!SH_REPORTS.ActiveReports) then
	SH_REPORTS.ActiveReports = {}
end

function SH_REPORTS:ReportCreated(data)
	chat.AddText(self.Style.header, "[" .. self:L("reports") .. "] ", color_white, self:L("report_received", data.reporter_name, data.reported_name, self.ReportReasons[data.reason_id])) -- 76561198037478513

	if (self.NewReportSound.enabled) then
		surface.PlaySound(self.NewReportSound.path)
	end

	self:MakeNotification(data)
	self:MakePending(data)

	if (!self.ActiveReports) then
		self.ActiveReports = {}
	end
	table.insert(self.ActiveReports, data)
end

hook.Add("Think", "SH_REPORTS.Ready", function()
	if (IsValid(LocalPlayer())) then
		hook.Remove("Think", "SH_REPORTS.Ready")
		easynet.SendToServer("SH_REPORTS.PlayerReady")
	end
end)

easynet.Callback("SH_REPORTS.SendList", function(data)
	local pendings = {}
	for _, report in pairs (SH_REPORTS.ActiveReports) do
		if (IsValid(report.pending)) then
			pendings[report.id] = report.pending
		end
	end

	SH_REPORTS.ServerTime = data.server_time
	SH_REPORTS.ActiveReports = data.struct_reports

	for _, report in pairs (SH_REPORTS.ActiveReports) do
		report.pending = pendings[report.id]
	end
	
	SH_REPORTS:ShowReports()
end)

easynet.Callback("SH_REPORTS.MinimizeReport", function(data)
	if (IsValid(_SH_REPORTS_VIEW)) then
		_SH_REPORTS_VIEW:Close()
	end

	local report
	for _, rep in pairs (SH_REPORTS.ActiveReports) do
		if (rep.id == data.report_id) then
			report = rep
			break
		end
	end

	if (report) then
		SH_REPORTS:MakeTab(report)
	end
end)

easynet.Callback("SH_REPORTS.ReportClosed", function(data)
	for k, rep in pairs (SH_REPORTS.ActiveReports) do
		if (rep.id == data.report_id) then
			if (IsValid(rep.line)) then
				rep.line:Close()
			end

			if (IsValid(rep.pending)) then
				rep.pending:Close()
			end

			SH_REPORTS.ActiveReports[k] = nil
		end
	end

	if (IsValid(_SH_REPORTS_TAB) and _SH_REPORTS_TAB.id == data.report_id) then
		_SH_REPORTS_TAB:Close()
	end

	SH_REPORTS:ClosePendingPanel(data.report_id)
end)

easynet.Callback("SH_REPORTS.ReportClaimed", function(data)
	for _, rep in pairs (SH_REPORTS.ActiveReports) do
		if (rep.id == data.report_id) then
			rep.admin_id = data.admin_id

			if (IsValid(rep.line)) then
				rep.line.claimed.avi:SetSteamID(data.admin_id)
				rep.line.claimed.avi:SetVisible(true)

				local admin = player.GetBySteamID64(data.admin_id)
				if (IsValid(admin)) then
					rep.line.claimed.name:SetTextInset(32, 0)
					rep.line.claimed.name:SetContentAlignment(4)
					rep.line.claimed.name:SetText(admin:SteamName())
				end
			end

			if (IsValid(rep.pending)) then
				rep.pending:Close()
			end

			if (data.admin_id ~= LocalPlayer():SteamID64() and IsValid(rep.line) and IsValid(rep.line.delete)) then
				rep.line.delete:Remove()
			end
		end
	end

	SH_REPORTS:ClosePendingPanel(data.report_id)
end)

easynet.Callback("SH_REPORTS.Notify", function(data)
	-- do NOT do this
	SH_REPORTS:Notify(SH_REPORTS:L(unpack(string.Explode("\t", data.msg))), nil, data.positive and SH_REPORTS.Style.success or SH_REPORTS.Style.failure)
end)

easynet.Callback("SH_REPORTS.Chat", function(data)
	chat.AddText(SH_REPORTS.Style.header, "[" .. SH_REPORTS:L("reports") .. "] ", color_white, data.msg)
end)

easynet.Callback("SH_REPORTS.ReportCreated", function(data)
	SH_REPORTS:ReportCreated(data)
end)

easynet.Callback("SH_REPORTS.ReportsPending", function(data)
	chat.AddText(SH_REPORTS.Style.header, "[" .. SH_REPORTS:L("reports") .. "] ", color_white, SH_REPORTS:L("there_are_x_reports_pending", data.num)) -- 76561198037478513

	SH_REPORTS.ActiveReports = table.Copy(data.struct_reports)

	for _, report in pairs (SH_REPORTS.ActiveReports) do
		SH_REPORTS:MakePending(report)
	end
end)

easynet.Callback("SH_REPORTS.AdminLeft", function(data)
	for _, rep in pairs (SH_REPORTS.ActiveReports) do
		if (rep.id == data.report_id) then
			rep.admin_id = ""

			if (IsValid(rep.line)) then
				rep.line.claimed.avi:SetVisible(false)

				rep.line.claimed.name:SetTextInset(0, 0)
				rep.line.claimed.name:SetContentAlignment(5)
				rep.line.claimed.name:SetText(SH_REPORTS:L("unclaimed"))
			end
		end
	end
end)