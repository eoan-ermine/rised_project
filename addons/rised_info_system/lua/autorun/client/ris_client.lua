-- "addons\\rised_info_system\\lua\\autorun\\client\\ris_client.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local alpha = 0
hook.Add("PostDrawOpaqueRenderables", "example", function()
	
	local trace = LocalPlayer():GetEyeTrace()

	local ent = trace.Entity
	if !IsValid(ent) then alpha = 0 return end
	local dist = LocalPlayer():GetPos():DistToSqr(ent:GetPos())

	if ent:GetClass() == 'worldspawn' then alpha = 0 end

	local entsToInfo = RISED.Config.Tutorial.Entities

	if !GetConVar("risedTutorial.enabled"):GetBool() then return end
	if !entsToInfo[ent:GetClass()] or dist > 20000 then return end
	
	local angle = ent:GetAngles()
	local angleOffset = entsToInfo[ent:GetClass()]['AnglesOffset']
	
	angle.y = angle.y + math.sin( CurTime() ) * 4
	angle:RotateAroundAxis( angle:Up(), angleOffset.y )
	angle:RotateAroundAxis( angle:Forward(), 90 )
	
	local posAngle = ent:GetAngles()
	local posOffset = entsToInfo[ent:GetClass()]['PositionOffset']
	local pos = ent:GetPos() + posAngle:Right() * posOffset.x + posAngle:Forward() * posOffset.y + posAngle:Up() * posOffset.z

	local k = 2
	local encsize = 2
	local textWidth = 300
	local text = entsToInfo[ent:GetClass()]['Text']

	alpha = alpha + 0.5

	cam.Start3D2D(pos, angle, 0.1)

		local size = drawMultiLine(text, "Trebuchet18", (textWidth-25), 25, -(textWidth-25)/2, 10, Color(255,255,255,alpha), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
	
		draw.RoundedBox( 0, -(textWidth/2)-encsize, -10-encsize + (k*25-30), encsize, 2+encsize*2, Color(255,255,255,alpha) )
		draw.RoundedBox( 0, -(textWidth/2), -10-encsize+ (k*25-30), 2+encsize, encsize, Color(255,255,255,alpha) )

		draw.RoundedBox( 0, (textWidth/2), -10-encsize+ (k*25-30), encsize, 2+encsize*2, Color(255,255,255,alpha) )
		draw.RoundedBox( 0, (textWidth/2)-encsize-2, -10-encsize+ (k*25-30), 2+encsize, encsize, Color(255,255,255,alpha) )

		draw.RoundedBox( 0, -(textWidth/2)-encsize, (size + 31), encsize, 2+encsize*2, Color(255,255,255,alpha) )
		draw.RoundedBox( 0, -(textWidth/2), (size + 35), 2+encsize, encsize, Color(255,255,255,alpha) )

		draw.RoundedBox( 0, (textWidth/2)-encsize-2, (size + 35), 2+encsize, encsize, Color(255,255,255,alpha) )
		draw.RoundedBox( 0, (textWidth/2), (size + 31), encsize, 2+encsize*2, Color(255,255,255,alpha) )
		
		draw.RoundedBox( 0, -textWidth/2, -10+ (k*25-30), textWidth, size + 25, Color(0,0,0,math.Clamp(alpha, 0, 125)) )
		
	cam.End3D2D()
end)

net.Receive("Rised_ChatNotification", function()

	local text = net.ReadString()
	local type = net.ReadString()
	local sound = net.ReadBool()
	local color = Color(255,255,255)

	if type == "success" then
		color = Color(240,173,78)
		if sound then
			surface.PlaySound("rised/combine/pano_ui_menu_close_01.wav")
		end
	elseif type == "error" then
		color = Color(187,33,36)
		if sound then
			surface.PlaySound("resource/warning.wav")
		end
	else
		color = Color(170,170,170)
		if sound then
			surface.PlaySound("rised/combine/beepclear.wav")
		end
	end

	chat.AddText(color, text)
end)