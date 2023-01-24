-- "addons\\sh_reports\\lua\\reports\\sh_main.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
function SH_REPORTS:GetMidnight(offset)
	return os.time() - tonumber(os.date("%H")) * 3600 - tonumber(os.date("%M")) * 60 - tonumber(os.date("%S")) + 86400 * (offset or /* 76561198037478513 */ 0)
end

-- fresh from NEP
local d = {
	[86400 * 31] = "mo",
	[86400 * 7] = "w",
	[86400] = "d",
	[3600] = "h",
	[60] = "min",
	[1] = "s",
}
local c2 = {}
function SH_REPORTS:FullFormatTime(i)
	if (c2[i]) then
		return c2[i]
	end

	local f = i
	local t = {}
	for ti, s in SortedPairs(d, true) do
		local f = math.floor(i / ti)
		if (f > 0) then
			table.insert(t, f .. s)
			i = i - f * ti
		end
	end
	
	t = table.concat(t, " ")
	c2[f] = t

	return t
end

function SH_REPORTS:IsAdmin(ply)
	return self.Usergroups[ply:GetUserGroup()] ~= nil
end

-- SERVER -> CLIENT
easynet.Start("SH_REPORTS.SendList")
	easynet.Add("server_time", EASYNET_UINT32)
	easynet.Add("struct_reports", EASYNET_STRUCTURES)
easynet.Register()

easynet.Start("SH_REPORTS.Notify")
	easynet.Add("msg", EASYNET_STRING)
	easynet.Add("positive", EASYNET_BOOL)
easynet.Register()

easynet.Start("SH_REPORTS.Chat")
	easynet.Add("msg", EASYNET_STRING)
easynet.Register()

easynet.Start("SH_REPORTS.ReportCreated")
	easynet.Add("id", EASYNET_UINT32)
	easynet.Add("reporter_id", EASYNET_STRING)
	easynet.Add("reporter_name", EASYNET_STRING)
	easynet.Add("reported_id", EASYNET_STRING)
	easynet.Add("reported_name", EASYNET_STRING)
	easynet.Add("reason_id", EASYNET_UINT8)
	easynet.Add("comment", EASYNET_STRING)
	easynet.Add("time", EASYNET_UINT32)
	easynet.Add("admin_id", EASYNET_STRING)
easynet.Register()

easynet.Start("SH_REPORTS.ReportClaimed")
	easynet.Add("report_id", EASYNET_UINT8)
	easynet.Add("admin_id", EASYNET_STRING)
easynet.Register()

easynet.Start("SH_REPORTS.ReportClosed")
	easynet.Add("report_id", EASYNET_UINT8)
easynet.Register()

easynet.Start("SH_REPORTS.QuickReport")
	easynet.Add("comment", EASYNET_STRING)
	easynet.Add("lastkiller", EASYNET_PLAYER)
	easynet.Add("lastarrester", EASYNET_PLAYER)
easynet.Register()

easynet.Start("SH_REPORTS.MinimizeReport")
	easynet.Add("report_id", EASYNET_UINT32)
easynet.Register()

easynet.Start("SH_REPORTS.SendPerfReports")
	easynet.Add("struct_perf_reports", EASYNET_STRUCTURES)
easynet.Register()

easynet.Start("SH_REPORTS.SendPerfReportStaff")
	easynet.Add("id", EASYNET_UINT32)
	easynet.Add("struct_perf_reports_staff", EASYNET_STRUCTURES)
easynet.Register()

easynet.Start("SH_REPORTS.ReportsPending")
	easynet.Add("num", EASYNET_UINT16)
	easynet.Add("struct_reports", EASYNET_STRUCTURES)
easynet.Register()

easynet.Start("SH_REPORTS.AdminLeft")
	easynet.Add("report_id", EASYNET_UINT32)
easynet.Register()

easynet.Start("SH_REPORTS.PromptRating")
	easynet.Add("report_id", EASYNET_UINT32)
	easynet.Add("admin_name", EASYNET_STRING)
easynet.Register()

easynet.Start("SH_REPORTS.SendRatings")
	easynet.Add("struct_rating", EASYNET_STRUCTURES)
easynet.Register()

easynet.Start("SH_REPORTS.SendHistoryList")
	easynet.Add("struct_history_steamids", EASYNET_STRUCTURES)
	easynet.Add("struct_history_list", EASYNET_STRUCTURES)
easynet.Register()

easynet.Start("SH_REPORTS.SendReportValid")
	easynet.Add("report_id", EASYNET_UINT32)
	easynet.Add("valid", EASYNET_BOOL)
easynet.Register()

-- CLIENT -> SERVER
easynet.Start("SH_REPORTS.PlayerReady")
easynet.Register()

easynet.Start("SH_REPORTS.NewReport")
	easynet.Add("reported_name", EASYNET_STRING)
	easynet.Add("reported_id", EASYNET_STRING)
	easynet.Add("reason_id", EASYNET_UINT8)
	easynet.Add("comment", EASYNET_STRING)
easynet.Register()

easynet.Start("SH_REPORTS.RequestList")
easynet.Register()

easynet.Start("SH_REPORTS.ClaimAndTeleport")
	easynet.Add("id", EASYNET_UINT32)
	easynet.Add("bring", EASYNET_BOOL)
	easynet.Add("bring_reported", EASYNET_BOOL)
easynet.Register()

easynet.Start("SH_REPORTS.Claim")
	easynet.Add("id", EASYNET_UINT32)
easynet.Register()

easynet.Start("SH_REPORTS.ClaimAndCSit")
	easynet.Add("id", EASYNET_UINT32)
easynet.Register()

easynet.Start("SH_REPORTS.CloseReport")
	easynet.Add("id", EASYNET_UINT32)
	easynet.Add("tp", EASYNET_BOOL)
easynet.Register()

easynet.Start("SH_REPORTS.RequestPerfReports")
easynet.Register()

easynet.Start("SH_REPORTS.RequestPerfReportStaff")
	easynet.Add("id", EASYNET_UINT32)
easynet.Register()

easynet.Start("SH_REPORTS.RateAdmin")
	easynet.Add("report_id", EASYNET_UINT32)
	easynet.Add("rating", EASYNET_UINT8)
easynet.Register()

easynet.Start("SH_REPORTS.RequestStaffRatings")
easynet.Register()

easynet.Start("SH_REPORTS.RequestReportHistory")
easynet.Register()

easynet.Start("SH_REPORTS.RequestReportValid")
	easynet.Add("report_id", EASYNET_UINT32)
easynet.Register()

-- STRUCTURES
easynet.Start("struct_reports")
	easynet.Add("id", EASYNET_UINT32)
	easynet.Add("reporter_id", EASYNET_STRING)
	easynet.Add("reporter_name", EASYNET_STRING)
	easynet.Add("reported_id", EASYNET_STRING)
	easynet.Add("reported_name", EASYNET_STRING)
	easynet.Add("reason_id", EASYNET_UINT8)
	easynet.Add("comment", EASYNET_STRING)
	easynet.Add("time", EASYNET_UINT32)
	easynet.Add("admin_id", EASYNET_STRING)
easynet.Register()

easynet.Start("struct_perf_reports")
	easynet.Add("id", EASYNET_UINT32)
	easynet.Add("start_time", EASYNET_UINT32)
	easynet.Add("end_time", EASYNET_UINT32)
easynet.Register()

easynet.Start("struct_perf_reports_staff")
	easynet.Add("steamid", EASYNET_STRING)
	easynet.Add("claimed", EASYNET_UINT16)
	easynet.Add("closed", EASYNET_UINT16)
	easynet.Add("timespent", EASYNET_UINT16)
easynet.Register()

easynet.Start("struct_rating")
	easynet.Add("steamid", EASYNET_STRING)
	easynet.Add("total", EASYNET_UINT32)
	easynet.Add("num", EASYNET_UINT16)
easynet.Register()

easynet.Start("struct_history_steamids")
	easynet.Add("steamid", EASYNET_STRING)
easynet.Register()

easynet.Start("struct_history_list")
	easynet.Add("report_id", EASYNET_UINT32)
	easynet.Add("reporter_nid", EASYNET_UINT16)
	easynet.Add("reported_nid", EASYNET_UINT16)
	easynet.Add("reason", EASYNET_STRING)
	easynet.Add("comment", EASYNET_STRING)
	easynet.Add("rating", EASYNET_UINT8)
	easynet.Add("date", EASYNET_UINT32)
	easynet.Add("waiting_time", EASYNET_UINT16)
	easynet.Add("admin_nid", EASYNET_UINT16)
easynet.Register()