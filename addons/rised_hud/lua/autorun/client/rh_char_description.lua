-- "addons\\rised_hud\\lua\\autorun\\client\\rh_char_description.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local ply_info = NULL
local function DrawDes()

    local self = LocalPlayer()
    if !self:Alive() then return end

    local trace = self:GetEyeTrace()
	local ent = trace.Entity

    if !IsValid(ent) or !ent:IsPlayer() or !ent:Alive() or ent:isCP() then return end

	local dist = self:GetPos():DistToSqr(ent:GetPos())
	if dist > 20000 then return end

	local angle = self:GetAngles()
	local angleOffset = Angle(0,270,0)
	
	angle.y = angle.y + math.sin( CurTime() ) * 4
	angle:RotateAroundAxis( angle:Up(), angleOffset.y )
	angle:RotateAroundAxis( angle:Forward(), 90 )
	
	local posAngle = self:GetAngles()
	local posAngle_ent = ent:GetAngles()
	local posOffset = Vector(0,-10,40)
	local pos = ent:GetPos() + posAngle:Right() * posOffset.x + posAngle:Forward() * posOffset.y + posAngle_ent:Up() * posOffset.z

	local k = 1.8
	local encsize = 1.5
	local textWidth = 300

	local height = math.Round(ent:GetNWString("Character_Height", 170))
	local constitution = ent:GetNWString("Character_Сonstitution", "Обычное")
	local eye_color = string.lower(ent:GetNWString("Character_EyeColor", "Зеленый"))
	local facial_hair = ent:GetNWInt("Character_FacialHair", 0)
	local physical_description = ent:GetNWString("Character_PhysicalDescription", "")

	if physical_description != "" then
		physical_description = ", " .. physical_description
	end

	if facial_hair != nil and facial_hair > 0 then
		facial_hair = "присутствует"
	else
		facial_hair = "отсутствует"
	end

	local text = "Рост: " .. height .. " см., телосложение " .. constitution .. ", цвет глаз " .. eye_color .. ", растительность на лице " .. facial_hair .. physical_description
	
	if ent.alpha_ply_info == nil then
		ent.alpha_ply_info = 0
	end
	ent.alpha_ply_info = math.min(ent.alpha_ply_info + 0.04, 200)

    local name = "Неизвестный"
	if self:Team() != TEAM_ADMINISTRATOR and self:Team() != TEAM_GMAN then
		if self:isCP() or self:Team() == TEAM_REBELSPY01 then
			if !ent:isCP() and ent:Team() != TEAM_REBELSPY01 then
				if FaceMemory_Check(ent) then
					name = ent:Name()
				end
			end
		elseif GAMEMODE.Rebels[self:Team()] and GAMEMODE.Rebels[ent:Team()] then
			name = ent:Name()
		elseif FaceMemory_Check(ent) and !GAMEMODE.ZombieJobs[ent:Team()] then
			name = ent:Name()
		end
	end

	name = name .. " | RP: " .. ent:GetNWInt("PersonalRPLevel")
	
	cam.Start3D2D(pos, angle, 0.1)

		draw.SimpleText(name, "DebugFixedSmall", 0, -10, Color(ent.alpha_ply_info,ent.alpha_ply_info,ent.alpha_ply_info,ent.alpha_ply_info), 1, 1)

		local size = drawMultiLine(text, "DebugFixedSmall", (textWidth-25), 25, -(textWidth-25)/2, 10, Color(ent.alpha_ply_info,ent.alpha_ply_info,ent.alpha_ply_info,ent.alpha_ply_info), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
	
		draw.RoundedBox( 0, -(textWidth/2)-encsize, -10-encsize + (k*25-30), encsize, 2+encsize*2, Color(ent.alpha_ply_info,ent.alpha_ply_info,ent.alpha_ply_info,ent.alpha_ply_info) )
		draw.RoundedBox( 0, -(textWidth/2), -10-encsize+ (k*25-30), 2+encsize, encsize, Color(ent.alpha_ply_info,ent.alpha_ply_info,ent.alpha_ply_info,ent.alpha_ply_info) )

		draw.RoundedBox( 0, (textWidth/2), -10-encsize+ (k*25-30), encsize, 2+encsize*2, Color(ent.alpha_ply_info,ent.alpha_ply_info,ent.alpha_ply_info,ent.alpha_ply_info) )
		draw.RoundedBox( 0, (textWidth/2)-encsize-2, -10-encsize+ (k*25-30), 2+encsize, encsize, Color(ent.alpha_ply_info,ent.alpha_ply_info,ent.alpha_ply_info,ent.alpha_ply_info) )

		draw.RoundedBox( 0, -(textWidth/2)-encsize, (size + 31), encsize, 2+encsize*2, Color(ent.alpha_ply_info,ent.alpha_ply_info,ent.alpha_ply_info,ent.alpha_ply_info) )
		draw.RoundedBox( 0, -(textWidth/2), (size + 35), 2+encsize, encsize, Color(ent.alpha_ply_info,ent.alpha_ply_info,ent.alpha_ply_info,ent.alpha_ply_info) )

		draw.RoundedBox( 0, (textWidth/2)-encsize-2, (size + 35), 2+encsize, encsize, Color(ent.alpha_ply_info,ent.alpha_ply_info,ent.alpha_ply_info,ent.alpha_ply_info) )
		draw.RoundedBox( 0, (textWidth/2), (size + 31), encsize, 2+encsize*2, Color(ent.alpha_ply_info,ent.alpha_ply_info,ent.alpha_ply_info,ent.alpha_ply_info) )
		
		draw.RoundedBox( 0, -textWidth/2, -10+ (k*25-30), textWidth, size + 25, Color(0,0,0,math.Clamp(ent.alpha_ply_info, 0, 125)) )
		
	cam.End3D2D()
end

hook.Add( "PostDrawOpaqueRenderables", "DrawDes", DrawDes )

hook.Add( "CalcView", "MyCalcView", function( ply, pos, angles, fov )
	-- if ply:SteamID() == "STEAM_0:1:38606392" then 
	-- 	local view = {
	-- 		origin = pos - ( angles:Forward() * 100 ),
	-- 		angles = angles,
	-- 		fov = fov,
	-- 		ortho = {
	-- 			left = -ScrW()*5,
	-- 			right = ScrW()*5,
	-- 			top = -ScrH()*5,
	-- 			bottom = ScrH()*5
	-- 		}
	-- 	}

	-- 	return view
	-- end
end )