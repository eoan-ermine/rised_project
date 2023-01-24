-- "addons\\rised_jeff\\lua\\autorun\\jeff_vision.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

hook.Add("PrePlayerDraw", "Rised_PrePlayerDraw", function(ply, flags)
	if IsValid(ply) and ply:GetNWBool("Rised_JeffPlayerMoved") and LocalPlayer() != ply and LocalPlayer():Team() == TEAM_JEFF and ply:Team() != TEAM_JEFF then
		return false
	elseif IsValid(ply) and !ply:GetNWBool("Rised_JeffPlayerMoved") and LocalPlayer() != ply and LocalPlayer():Team() == TEAM_JEFF then
		return true
	end
end)

hook.Add( "Move" , "Rised_Move" , function( ply, movedata )
	if movedata:GetVelocity():Length() > 80 then
		ply:SetNWBool("Rised_JeffPlayerMoved", true)
	else
		ply:SetNWBool("Rised_JeffPlayerMoved", false)
	end
end )