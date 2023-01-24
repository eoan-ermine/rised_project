-- "addons\\visualmarkers\\lua\\autorun\\client\\cl_vmarkers.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

net.Receive("callcpnetwork",function()

	local ent = net.ReadEntity()
	local what = net.ReadInt(10)

	if IsValid(ent) then
		local playerpos = ent:GetPos()

		local ent_index = ent:EntIndex()
		if ent:IsPlayer() then
			ent_index = ent:AccountID()
		end

		if what == 1 then
			local material = Material( "icon16/error.png" )
			if LocalPlayer():isCP() then
				chat.AddText( Color( 128, 255, 245 ), "Поступил экстренный вызов от: " .. ent:Name())
				hook.Add( "HUDPaint", "CallCPHudIconDraw"..ent_index, function()
					local pos = playerpos:ToScreen()
					local dist = playerpos:Distance( LocalPlayer():GetPos() )
							
					surface.SetDrawColor( color_white )
					surface.SetMaterial( material )
					surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
							
					dist = math.Round( ( dist / 17.3 ) - 3, 0 )
					
					if dist >= 0 && ent:IsValid() then
						draw.SimpleText( dist .. "m - Вызов: " .. ent:Nick(), "zejton20", pos.x + 21, pos.y, color_orange )
					else
						for k, v in pairs(player.GetAll()) do
							hook.Remove( "HUDPaint", "CallCPHudIconDraw"..ent_index )
						end
					end
				end )
			end
			
			timer.Stop("CallCpTimer"..ent:SteamID())
			timer.Create("CallCpTimer"..ent:SteamID(), 150, 1, function()
				if ent:IsValid() then
					hook.Remove( "HUDPaint", "CallCPHudIconDraw"..ent_index)
				end
			end )
		elseif what == 2 then
			local material = Material( "icon16/lightning.png" )
			local playername = ent:Name()
			hook.Add( "HUDPaint", "DeadCPHudIconDraw"..ent:EntIndex(), function()
				if LocalPlayer():isCP() then
					local pos = playerpos:ToScreen()
					local dist = playerpos:Distance( LocalPlayer():GetPos() )
							
					surface.SetDrawColor( color_white )
					surface.SetMaterial( material )
					surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
							
					dist = math.Round( ( dist / 17.3 ) - 3, 0 )
					if dist >= 0 && ent:IsValid() then
						draw.SimpleText( dist .. "m | " .. "UNIT BIO-SIGNAL LOST", "zejton20", pos.x + 21, pos.y, color_orange )
						draw.SimpleText( playername, "zejton20", pos.x + 21, pos.y + 21, color_orange )
					else
						for k, v in pairs(player.GetAll()) do
							hook.Remove( "HUDPaint", "DeadCPHudIconDraw"..ent:EntIndex() )
						end
					end
				end
			end )

			timer.Stop("DeadCpTimer"..ent:SteamID())
			timer.Create("DeadCpTimer"..ent:SteamID(), 150, 1, function()
				if ent:IsValid() then
					hook.Remove( "HUDPaint", "DeadCPHudIconDraw"..ent:EntIndex() )
				end
			end )
		elseif what == 3 then
			if LocalPlayer():isCP() then
				LocalPlayer():EmitSound("ambient/alarms/scanner_alert_pass1.wav")
			end
			local material = Material( "icon16/computer_error.png" )
			hook.Add( "HUDPaint", "DisturbCPHudIconDraw"..ent:EntIndex(), function()
				if LocalPlayer():isCP() then
					local pos = playerpos:ToScreen()
					local dist = playerpos:Distance( LocalPlayer():GetPos() )
							
					surface.SetDrawColor( color_white )
					surface.SetMaterial( material )
					surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
							
					dist = math.Round( ( dist / 17.3 ) - 3, 0 )
					if dist >= 0 && ent:IsValid() then
						draw.SimpleText( dist .. "m - " .. "Силовое поле взломано!", "Trebuchet18", pos.x + 21, pos.y, color_white )
					else
						for k, v in pairs(player.GetAll()) do
							hook.Remove( "HUDPaint", "DisturbCPHudIconDraw"..ent:EntIndex() )
						end
					end
				end
			end )

			timer.Stop("DisturbCpTimer"..ent:SteamID())
			timer.Create("DisturbCpTimer"..ent:SteamID(), 150, 1, function()
				if ent:IsValid() then
					hook.Remove( "HUDPaint", "DisturbCPHudIconDraw"..rnd )
				end
			end )
		elseif what == 4 then
			local goalPos = net.ReadVector()
			local material = Material( "icon16/arrow_in.png" )
			hook.Add( "RenderScreenspaceEffects", "DispachMovepoint01CPHudIconDraw", function() 
				if LocalPlayer():isCP() then
					local pos = goalPos:ToScreen()
					local dist = goalPos:Distance( LocalPlayer():GetPos() )
							
					surface.SetDrawColor( color_white )
					surface.SetMaterial( material )
					surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
							
					dist = math.Round( ( dist / 17.3 ) - 3, 0 )
					if dist >= 0 && ent:IsValid() then
						draw.SimpleText( dist .. "m | " .. "POINT", "zejton20", pos.x + 21, pos.y, color_orange )
					else
						for k, v in pairs(player.GetAll()) do
							hook.Remove( "RenderScreenspaceEffects", "DispachMovepoint01CPHudIconDraw" )
						end
					end
				end
			end )

			timer.Stop("DispachMovepoint01CpTimer")
			timer.Create("DispachMovepoint01CpTimer", 150, 1, function()
				if ent:IsValid() then
					hook.Remove( "HUDPaint", "DispachMovepoint01CPHudIconDraw" )
				end
			end )
		elseif what == 5 then
			local goalPos = net.ReadVector()
			local material = Material( "icon16/lightning.png" )
			hook.Add( "RenderScreenspaceEffects", "DispachClear01CPHudIconDraw", function() 
				if LocalPlayer():isCP() then
					local pos = goalPos:ToScreen()
					local dist = goalPos:Distance( LocalPlayer():GetPos() )
							
					surface.SetDrawColor( color_white )
					surface.SetMaterial( material )
					surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
							
					dist = math.Round( ( dist / 17.3 ) - 3, 0 )
					if dist >= 0 && ent:IsValid() then
						draw.SimpleText( dist .. "m | " .. "CLEAR", "zejton20", pos.x + 21, pos.y, color_orange )
					else
						for k, v in pairs(player.GetAll()) do
							hook.Remove( "RenderScreenspaceEffects", "DispachClear01CPHudIconDraw" )
						end
					end
				end
			end )

			timer.Stop("DispachClear01CpTimer")
			timer.Create("DispachClear01CpTimer", 150, 1, function()
				if ent:IsValid() then
					hook.Remove( "HUDPaint", "DispachClear01CPHudIconDraw" )
				end
			end )
		elseif what == 6 then
			if LocalPlayer():isCP() then
				LocalPlayer():EmitSound("ambient/alarms/scanner_alert_pass1.wav")
			end
			local material = Material( "icon16/cog_error.png" )
			hook.Add( "HUDPaint", "DestroyFieldCPHudIconDraw"..ent:EntIndex(), function()
				if LocalPlayer():isCP() then
					local pos = playerpos:ToScreen()
					local dist = playerpos:Distance( LocalPlayer():GetPos() )
							
					surface.SetDrawColor( color_white )
					surface.SetMaterial( material )
					surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
					dist = math.Round( ( dist / 17.3 ) - 3, 0 )
					if dist >= 0 && LocalPlayer():IsValid() then
						draw.SimpleText( dist .. "m | " .. "FIELD", "zejton20", pos.x + 21, pos.y, color_orange )
					else
						for k, v in pairs(player.GetAll()) do
							hook.Remove( "HUDPaint", "DestroyFieldCPHudIconDraw"..ent:EntIndex() )
						end
					end
				end
			end )

			timer.Stop("DestroyFieldCpTimer"..ent:EntIndex())
			timer.Create("DestroyFieldCpTimer"..ent:EntIndex(), 150, 1, function()
				if ent:IsValid() then
					hook.Remove( "HUDPaint", "DestroyFieldCPHudIconDraw"..ent:EntIndex() )
				end
			end )
		elseif what == 7 then
			if LocalPlayer():isCP() then
				LocalPlayer():EmitSound("ambient/alarms/scanner_alert_pass1.wav")
			end
			local material = Material( "icon16/brick_error.png" )
			hook.Add( "HUDPaint", "CaptureSectorCPHudIconDraw"..ent:EntIndex(), function()
				if LocalPlayer():isCP() then
					local pos = playerpos:ToScreen()
					local dist = playerpos:Distance( LocalPlayer():GetPos() )
							
					surface.SetDrawColor( color_white )
					surface.SetMaterial( material )
					surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
					dist = math.Round( ( dist / 17.3 ) - 3, 0 )
					if dist >= 0 && LocalPlayer():IsValid() then
						draw.SimpleText( dist .. "m | " .. "SECTOR", "zejton20", pos.x + 21, pos.y, color_orange )
					else
						for k, v in pairs(player.GetAll()) do
							hook.Remove( "HUDPaint", "CaptureSectorCPHudIconDraw"..ent:EntIndex() )
						end
					end
				end
			end )

			timer.Stop("CaptureSectorCpTimer"..ent:EntIndex())
			timer.Create("CaptureSectorCpTimer"..ent:EntIndex(), 150, 1, function()
				if ent:IsValid() then
					hook.Remove( "HUDPaint", "CaptureSectorCPHudIconDraw"..ent:EntIndex() )
				end
			end )
		elseif what == 8 then

			if LocalPlayer():isCP() then
				LocalPlayer():EmitSound("rised/combine/combine_machines_crafting_ui_rollover_01.wav")
			end
			local material = Material( "icon16/arrow_in.png" )
			hook.Add( "HUDPaint", "MPF_PostMarker", function()
				if LocalPlayer():isCP() then
					local pos = playerpos:ToScreen()
					local dist = playerpos:Distance( LocalPlayer():GetPos() )
							
					surface.SetDrawColor( color_white )
					surface.SetMaterial( material )
					surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
					dist = math.Round( ( dist / 17.3 ) - 3, 0 )
					draw.SimpleText( dist .. "m | " .. "POST", "zejton20", pos.x + 21, pos.y, color_orange )
					-- if dist >= 2 && LocalPlayer():IsValid() then
					-- 	draw.SimpleText( dist .. "m | " .. "POST", "zejton20", pos.x + 21, pos.y, color_orange )
					-- else
					-- 	hook.Remove( "HUDPaint", "MPF_PostMarker"..ent:EntIndex() )
					-- end
				end
			end )
		elseif what == 81 then
			hook.Remove( "HUDPaint", "MPF_PostMarker" )
		end
	end
end)

net.Receive("jobinfomarkers",function()
	local what = net.ReadInt(10)
	local ply = LocalPlayer()
	if what == 1 then
		-- local ply = LocalPlayer()
		-- local playerpos = ply:GetPos()
		-- local material = Material( "icon16/database_refresh.png" )
		
		-- local rnd = math.random(1,999)
		-- hook.Add( "HUDPaint", "RubbishInfoMarkerHudIconDraw"..rnd, function()
			-- local markerPos = Vector(4209.576660, 3957.497803, 440.031250)
			-- local pos = markerPos:ToScreen()
			-- local dist = markerPos:Distance( LocalPlayer():GetPos() )
						
			-- surface.SetDrawColor( color_white )
			-- surface.SetMaterial( material )
			-- surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
						
			-- dist = math.Round( ( dist / 17.3 ) - 3, 0 )
			-- if dist >= 2 then
				-- draw.SimpleText( dist .. "m " .. "Отнести мусор", "Trebuchet18", pos.x + 21, pos.y, color_white )
			-- elseif ply:IsValid() then
				-- hook.Remove( "HUDPaint", "RubbishInfoMarkerHudIconDraw"..rnd )
			-- end
		-- end )
	elseif what == 2 then
		local ply = LocalPlayer()
		local playerpos = ply:GetPos()
		local material = Material( "icon16/package.png" )
		local rnd1 = math.random(1,999)
		hook.Add( "HUDPaint", "MeatInfoMarkerHudIconDraw"..rnd1, function()
			local markerPos = RISED.Config.Tutorial.Marks.FactoryRations_MeatSpawn
			local pos = markerPos:ToScreen()
			local dist = markerPos:Distance( LocalPlayer():GetPos() )
						
			surface.SetDrawColor( color_white )
			surface.SetMaterial( material )
			surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
						
			dist = math.Round( ( dist / 17.3 ) - 3, 0 )
			if dist >= 2 then
				draw.SimpleText( dist .. "m " .. "Поставка мяса", "Trebuchet18", pos.x + 21, pos.y, color_white )
			elseif ply:IsValid() then
				hook.Remove( "HUDPaint", "MeatInfoMarkerHudIconDraw"..rnd1 )
			end
		end )
		
	elseif what == 22 then
		local ply = LocalPlayer()
		local playerpos = ply:GetPos()
		local material = Material( "icon16/package.png" )
		local rnd2 = math.random(1,999)
		hook.Add( "HUDPaint", "EnzymesInfoMarkerHudIconDraw"..rnd2, function()
			local markerPos = RISED.Config.Tutorial.Marks.FactoryRations_EnzymesSpawn
			local pos = markerPos:ToScreen()
			local dist = markerPos:Distance( LocalPlayer():GetPos() )
						
			surface.SetDrawColor( color_white )
			surface.SetMaterial( material )
			surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
						
			dist = math.Round( ( dist / 17.3 ) - 3, 0 )
			if dist >= 2 then
				draw.SimpleText( dist .. "m " .. "Поставка энзимов", "Trebuchet18", pos.x + 21, pos.y, color_white )
			elseif ply:IsValid() then
				hook.Remove( "HUDPaint", "EnzymesInfoMarkerHudIconDraw"..rnd2 )
			end
		end )
	elseif what == 3 then
		local ply = LocalPlayer()
		local playerpos = ply:GetPos()
		local material = Material( "icon16/package_go.png" )
		
		local rnd = math.random(1,999)
		hook.Add( "HUDPaint", "MeatTableInfoMarkerHudIconDraw"..rnd, function()
			local markerPos = RISED.Config.Tutorial.Marks.FactoryRations_MeatFinish
			local pos = markerPos:ToScreen()
			local dist = markerPos:Distance( LocalPlayer():GetPos() )
						
			surface.SetDrawColor( color_white )
			surface.SetMaterial( material )
			surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
						
			dist = math.Round( ( dist / 17.3 ) - 3, 0 )
			if dist >= 2 then
				draw.SimpleText( dist .. "m " .. "Доставить", "Trebuchet18", pos.x + 21, pos.y, color_white )
			elseif ply:IsValid() then
				hook.Remove( "HUDPaint", "MeatTableInfoMarkerHudIconDraw"..rnd )
			end
		end )
	elseif what == 4 then
		local ply = LocalPlayer()
		local playerpos = ply:GetPos()
		local material = Material( "icon16/package_go.png" )
		
		local rnd = math.random(1,999)
		hook.Add( "HUDPaint", "EnzymesContainerInfoMarkerHudIconDraw"..rnd, function()
			local markerPos = RISED.Config.Tutorial.Marks.FactoryRations_EnzymesFinish
			local pos = markerPos:ToScreen()
			local dist = markerPos:Distance( LocalPlayer():GetPos() )
						
			surface.SetDrawColor( color_white )
			surface.SetMaterial( material )
			surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
						
			dist = math.Round( ( dist / 17.3 ) - 3, 0 )
			if dist >= 2 then
				draw.SimpleText( dist .. "m " .. "Доставить", "Trebuchet18", pos.x + 21, pos.y, color_white )
			elseif ply:IsValid() then
				hook.Remove( "HUDPaint", "EnzymesContainerInfoMarkerHudIconDraw"..rnd )
			end
		end )
	elseif what == 5 then
		local ply = LocalPlayer()
		local playerpos = ply:GetPos()
		local material = Material( "icon16/cog.png" )
		
		local rnd = math.random(1,999)
		hook.Add( "HUDPaint", "MeatWorkInfoMarkerHudIconDraw"..rnd, function()
			local markerPos = RISED.Config.Tutorial.Marks.FactoryRations_MeatDetox
			local pos = markerPos:ToScreen()
			local dist = markerPos:Distance( LocalPlayer():GetPos() )
						
			surface.SetDrawColor( color_white )
			surface.SetMaterial( material )
			surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
						
			dist = math.Round( ( dist / 17.3 ) - 3, 0 )
			if dist >= 2 then
				draw.SimpleText( dist .. "m " .. "Обработка мяса", "Trebuchet18", pos.x + 21, pos.y, color_white )
			elseif ply:IsValid() then
				hook.Remove( "HUDPaint", "MeatWorkInfoMarkerHudIconDraw"..rnd )
			end
		end )
	elseif what == 6 then
		local ply = LocalPlayer()
		local playerpos = ply:GetPos()
		local material = Material( "icon16/cog.png" )
		local material2 = Material( "icon16/brick_add.png" )
		
		local rnd1 = math.random(1,999)
		hook.Add( "HUDPaint", "RationWorkInfoMarkerHudIconDraw"..rnd1, function()
			local markerPos = RISED.Config.Tutorial.Marks.FactoryRations_RationCompile
			local pos = markerPos:ToScreen()
			local dist = markerPos:Distance( LocalPlayer():GetPos() )
						
			surface.SetDrawColor( color_white )
			surface.SetMaterial( material )
			surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
						
			dist = math.Round( ( dist / 17.3 ) - 3, 0 )
			if dist >= 2 then
				draw.SimpleText( dist .. "m " .. "Сборка рационов", "Trebuchet18", pos.x + 21, pos.y, color_white )
			elseif ply:IsValid() then
				hook.Remove( "HUDPaint", "RationWorkInfoMarkerHudIconDraw"..rnd1 )
			end
		end )
		
		local rnd2 = math.random(1,999)
		hook.Add( "HUDPaint", "RationFillInfoMarkerHudIconDraw"..rnd2, function()
			local markerPos = RISED.Config.Tutorial.Marks.RationsDispenser
			local pos = markerPos:ToScreen()
			local dist = markerPos:Distance( LocalPlayer():GetPos() )
						
			surface.SetDrawColor( color_white )
			surface.SetMaterial( material2 )
			surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
						
			dist = math.Round( ( dist / 17.3 ) - 3, 0 )
			if dist >= 2 then
				draw.SimpleText( dist .. "m " .. "Заправить", "Trebuchet18", pos.x + 21, pos.y, color_white )
			elseif ply:IsValid() then
				hook.Remove( "HUDPaint", "RationFillInfoMarkerHudIconDraw"..rnd2 )
			end
		end )
	elseif what == 7 then
		local ply = LocalPlayer()
		local playerpos = ply:GetPos()
		local material = Material( "icon16/heart_add.png" )

		local rnd = math.random(1,999)
		hook.Add( "HUDPaint", "DoctorInfoMarkerHudIconDraw"..rnd, function()
			local markerPos = RISED.Config.Tutorial.Marks.Hospital
			local pos = markerPos:ToScreen()
			local dist = markerPos:Distance( LocalPlayer():GetPos() )
						
			surface.SetDrawColor( color_white )
			surface.SetMaterial( material )
			surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
						
			dist = math.Round( ( dist / 17.3 ) - 3, 0 )
			if dist >= 2 then
				draw.SimpleText( dist .. "m " .. "Больница", "Trebuchet18", pos.x + 21, pos.y, color_white )
			elseif ply:IsValid() then
				hook.Remove( "HUDPaint", "DoctorInfoMarkerHudIconDraw"..rnd )
			end
		end )
	elseif what == 8 then
		local ply = LocalPlayer()
		local playerpos = ply:GetPos()
		local material = Material( "icon16/package.png" )

		local rnd = math.random(1,999)
		hook.Add( "HUDPaint", "ExtraFoodInfoMarkerHudIconDraw"..rnd, function()
			local markerPos = RISED.Config.Tutorial.Marks.ProvisorStorage
			local pos = markerPos:ToScreen()
			local dist = markerPos:Distance( LocalPlayer():GetPos() )
						
			surface.SetDrawColor( color_white )
			surface.SetMaterial( material )
			surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
						
			dist = math.Round( ( dist / 17.3 ) - 3, 0 )
			if dist >= 2 then
				draw.SimpleText( dist .. "m " .. "Склад с провизией", "Trebuchet18", pos.x + 21, pos.y, color_white )
			elseif ply:IsValid() then
				hook.Remove( "HUDPaint", "ExtraFoodInfoMarkerHudIconDraw"..rnd )
			end
		end )
	elseif what == 9 then
		local ply = LocalPlayer()
		local playerpos = ply:GetPos()
		local material = Material( "icon16/ruby.png" )

		local rnd = math.random(1,999)
		hook.Add( "HUDPaint", "BarInfoMarkerHudIconDraw"..rnd, function()
			local markerPos = RISED.Config.Tutorial.Marks.Bar
			local pos = markerPos:ToScreen()
			local dist = markerPos:Distance( LocalPlayer():GetPos() )
						
			surface.SetDrawColor( color_white )
			surface.SetMaterial( material )
			surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
						
			dist = math.Round( ( dist / 17.3 ) - 3, 0 )
			if dist >= 2 then
				draw.SimpleText( dist .. "m " .. "Бар", "Trebuchet18", pos.x + 21, pos.y, color_white )
			elseif ply:IsValid() then
				hook.Remove( "HUDPaint", "BarInfoMarkerHudIconDraw"..rnd )
			end
		end )
	elseif what == 10 then
		local ply = LocalPlayer()
		local playerpos = ply:GetPos()
		local material = Material( "icon16/ruby.png" )
		local material2 = Material( "icon16/ruby_gear.png" )
		local material3 = Material( "icon16/ruby_put.png" )

		local rnd1 = math.random(1,999)
		hook.Add( "HUDPaint", "FilmInfoMarkerHudIconDraw"..rnd1, function()
			local markerPos = Vector(3745.015381, -1925.311035, 448.031250)
			local pos = markerPos:ToScreen()
			local dist = markerPos:Distance( LocalPlayer():GetPos() )
						
			surface.SetDrawColor( color_white )
			surface.SetMaterial( material )
			surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
						
			dist = math.Round( ( dist / 17.3 ) - 3, 0 )
			if dist >= 2 then
				draw.SimpleText( dist .. "m " .. "Кинотеатр", "Trebuchet18", pos.x + 21, pos.y, color_white )
			elseif ply:IsValid() then
				hook.Remove( "HUDPaint", "FilmInfoMarkerHudIconDraw"..rnd1 )
			end
		end )
	elseif what == 11 then
		local ply = LocalPlayer()
		local material = Material( "icon16/package_go.png" )
		local contraband_pos = net.ReadVector()
		
		local rnd = math.random(1,999)
		hook.Add( "HUDPaint", "ContrabandInfoMarkerHudIconDraw"..rnd, function()
			local markerPos = contraband_pos
			local pos = markerPos:ToScreen()
			local dist = markerPos:Distance( LocalPlayer():GetPos() )
						
			surface.SetDrawColor( color_white )
			surface.SetMaterial( material )
			surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
						
			dist = math.Round( ( dist / 17.3 ) - 3, 0 )
			if dist >= 2 then
				draw.SimpleText( dist .. "m " .. "Контрабанда", "Trebuchet18", pos.x + 21, pos.y, color_white )
			elseif ply:IsValid() then
				hook.Remove( "HUDPaint", "ContrabandInfoMarkerHudIconDraw"..rnd )
			end
		end )
	elseif what == 12 then
		local ply = LocalPlayer()
		local material = Material( "icon16/key.png" )
		local apartment_pos = net.ReadVector()
		
		hook.Add( "HUDPaint", "ApartmentInfoMarkerHudIconDraw", function()
			local markerPos = apartment_pos
			local pos = markerPos:ToScreen()
			local dist = markerPos:Distance( LocalPlayer():GetPos() )
						
			surface.SetDrawColor( color_white )
			surface.SetMaterial( material )
			surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
						
			dist = math.Round( ( dist / 17.3 ) - 3, 0 )
			if dist >= 2 then
				draw.SimpleText( dist .. "m " .. "Дом", "Trebuchet18", pos.x + 21, pos.y, color_white )
			elseif ply:IsValid() then
				hook.Remove( "HUDPaint", "ApartmentInfoMarkerHudIconDraw" )
			end
		end )
	elseif what == 13 then
		local ply = LocalPlayer()
		local material = Material( "icon16/user_gray.png" )
		
		hook.Add( "HUDPaint", "NewPatientInfoMarkerHudIconDraw", function()
			local markerPos = RISED.Config.Tutorial.Marks.HospitalClient
			local pos = markerPos:ToScreen()
			local dist = markerPos:Distance( LocalPlayer():GetPos() )
						
			surface.SetDrawColor( color_white )
			surface.SetMaterial( material )
			surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
						
			dist = math.Round( ( dist / 17.3 ) - 3, 0 )
			if dist >= 2 then
				draw.SimpleText( dist .. "m " .. "Новый пациент", "zejton20", pos.x + 21, pos.y, color_white )
			elseif ply:IsValid() then
				hook.Remove( "HUDPaint", "NewPatientInfoMarkerHudIconDraw" )
			end
		end )
	elseif what == 14 then
		local ply = LocalPlayer()
		local material = Material( "icon16/user_add.png" )
		
		hook.Add( "HUDPaint", "NewCWUInfoMarkerHudIconDraw", function()
			local markerPos = RISED.Config.Tutorial.Marks.CWU
			local pos = markerPos:ToScreen()
			local dist = markerPos:Distance( LocalPlayer():GetPos() )
						
			surface.SetDrawColor( color_white )
			surface.SetMaterial( material )
			surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
						
			dist = math.Round( ( dist / 17.3 ) - 3, 0 )
			if dist >= 2 then
				draw.SimpleText( dist .. "m " .. "Кандидат в ГСР", "zejton20", pos.x + 21, pos.y, color_white )
			elseif ply:IsValid() then
				hook.Remove( "HUDPaint", "NewCWUInfoMarkerHudIconDraw" )
			end
		end )
	elseif what == 15 then
		local ply = LocalPlayer()
		local material = Material( "icon16/money.png" )
		local target_pos = net.ReadVector()
		
		hook.Add( "HUDPaint", "TheifQuestMarkerHudIconDraw", function()
			local pos = target_pos:ToScreen()
			local dist = target_pos:Distance( LocalPlayer():GetPos() )
						
			surface.SetDrawColor( Color(175,175,175) )
			surface.SetMaterial( material )
			surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
						
			dist = math.Round( ( dist / 17.3 ) - 3, 0 )
			if dist >= 2 then
				draw.SimpleText( dist .. "m " .. "Обворовать", "zejton20", pos.x + 21, pos.y, Color(175,175,175) )
			elseif ply:IsValid() then
				hook.Remove( "HUDPaint", "TheifQuestMarkerHudIconDraw" )
			end
		end )
	elseif what == 155 then
		hook.Remove( "HUDPaint", "TheifQuestMarkerHudIconDraw" )
	elseif what == -1 then
		if ply:IsValid() then
		
			local i = 0
	
			while i <= 1000 do
			
				i = i + 1
				
				hook.Remove( "HUDPaint", "RubbishInfoMarkerHudIconDraw"..i )
				
				hook.Remove( "HUDPaint", "MeatInfoMarkerHudIconDraw"..i )
				hook.Remove( "HUDPaint", "EnzymesInfoMarkerHudIconDraw"..i )
				hook.Remove( "HUDPaint", "ResourceInfoMarkerHudIconDraw"..i )
				
				hook.Remove( "HUDPaint", "MeatTableInfoMarkerHudIconDraw"..i )
				hook.Remove( "HUDPaint", "EnzymesContainerInfoMarkerHudIconDraw"..i )
				
				hook.Remove( "HUDPaint", "MeatWorkInfoMarkerHudIconDraw"..i )
				
				hook.Remove( "HUDPaint", "RationWorkInfoMarkerHudIconDraw"..i )
				hook.Remove( "HUDPaint", "RationFillInfoMarkerHudIconDraw"..i )
				
				hook.Remove( "HUDPaint", "DoctorInfoMarkerHudIconDraw"..i )
				hook.Remove( "HUDPaint", "ExtraFoodInfoMarkerHudIconDraw"..i )
				hook.Remove( "HUDPaint", "BarInfoMarkerHudIconDraw"..i )
				hook.Remove( "HUDPaint", "FilmInfoMarkerHudIconDraw"..i )
				
			end
			
			hook.Remove( "HUDPaint", "HUDInfoMarker01" )
			hook.Remove( "HUDPaint", "HUDInfoMarker02" )
			hook.Remove( "HUDPaint", "HUDInfoMarker03" )
			hook.Remove( "HUDPaint", "HUDInfoMarker04" )
			hook.Remove( "HUDPaint", "HUDInfoMarker05" )
			hook.Remove( "HUDPaint", "HUDInfoMarker06" )

			hook.Remove( "HUDPaint", "TheifQuestMarkerHudIconDraw" )
		end
	end
end)