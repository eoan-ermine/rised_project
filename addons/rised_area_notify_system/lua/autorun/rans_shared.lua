-- "addons\\rised_area_notify_system\\lua\\autorun\\rans_shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

local alpha = 0
hook.Add( "HUDPaint", "AreaNotifySystem", function() 
	local areaNotifyColor = ColorAlpha(GetFractionColor(LocalPlayer():Team()), 255)

	if !LocalPlayer():GetNWBool("Player_AreaNotify_StartNotify") then
		alpha = math.max(0, alpha - 45*FrameTime())
	else
		alpha = math.min(100, alpha + 45*FrameTime())
	end

	local alphaPercent = alpha/100
	areaNotifyColor.a = 255 * alphaPercent

	if alpha == 100 then
		LocalPlayer():SetNWBool("Player_AreaNotify_StartNotify", false)
	end

	draw.DrawText( LocalPlayer():GetNWString("Player_AreaNotify_CurrentArea"), "marske12", ScrW() * 0.5, ScrH() * 0.15, areaNotifyColor, TEXT_ALIGN_CENTER )

end)