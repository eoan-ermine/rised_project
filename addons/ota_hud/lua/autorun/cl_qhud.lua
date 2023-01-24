-- "addons\\ota_hud\\lua\\autorun\\cl_qhud.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if SERVER then
	resource.AddFile( "resource/fonts/zektonrg.ttf" )
	resource.AddFile( "sound/notify.wav" )
	resource.AddFile( "sound/respawn.wav" )
	resource.AddFile( "sound/dead.wav" )
	resource.AddFile( "materials/cross.png" )
	resource.AddFile( "materials/grenade.png" )
	resource.AddFile( "materials/loading.png" )
	return 
end

for i=1, 60 do
	surface.CreateFont( "zejton"..i, {
		font = "Zekton Rg",
		size = i,
		weight = 400,
	})
end

function CanUseRadar()
	return GAMEMODE.CombineJobs[LocalPlayer():Team()]
end

CreateClientConVar("hud_on", 1)
CreateClientConVar("hud_flick", 1)
CreateClientConVar("hud_flickamount", 15)
CreateClientConVar("hud_glitch", 0)
CreateClientConVar("hud_time",1)
CreateClientConVar("hud_cross",1) 
CreateClientConVar("hud_entd",0)
CreateClientConVar("hud_entdistance",600)
CreateClientConVar("hud_size", 0)
CreateClientConVar("hud_stright", 0)
CreateClientConVar("hud_stup", 0)
CreateClientConVar("hud_ammoright", 0)
CreateClientConVar("hud_ammodesign", 1)
CreateClientConVar("hud_ammoup", 0)
CreateClientConVar("hud_grenaderight", 0)
CreateClientConVar("hud_grenadeup", 0)
CreateClientConVar("hud_grenade", 1)
CreateClientConVar("hud_ammofade", 0)
CreateClientConVar("hud_load", 1)
CreateClientConVar("hud_radar", 0)
CreateClientConVar("hud_radarpl", 0)
CreateClientConVar("hud_rright", 0)
CreateClientConVar("hud_rup", 0)
CreateClientConVar("hud_warn", 1)
CreateClientConVar("hud_viewbob", 1)
CreateClientConVar("hud_viewbobk", 10)
CreateClientConVar("hud_kdot", 15)
CreateClientConVar("hud_deathop", 0)
CreateClientConVar("hud_deathscr", 1)


if CLIENT then
	function drawCir(kx,ky,angles,anglee,width,height,color)
		local x, y, r = 0, 0, 1
		for i = (angles), (anglee) do
			local angle = i * math.pi /  180
			local x, y = x + r * math.cos( angle )*kx, y + r * math.sin( angle )*ky
			draw.RoundedBox(0,width+x+1.7,height+y+1.7,1,1, color )
		end
	end

	function PointOnCircle( ang, radius, offX, offY )
		ang = math.rad( ang )
		local rx = math.cos( ang ) * -radius + offX
		local ry = math.sin( ang ) * radius + offY
		return rx, ry
	end 

	local hide = {}
	if GetConVarNumber("hud_cross") == 1 then
		hide = {
			["CHudAmmo"] = true,
			["CHudSecondaryAmmo"] = true,
			["CHudHealth"] = true,
			["CHudBattery"] = true,
			["CHudDamageIndicator"] = true,
			["CHudCrosshair"] = true,
		}
	else
		hide = {
			["CHudAmmo"] = true,
			["CHudSecondaryAmmo"] = true,
			["CHudHealth"] = true,
			["CHudBattery"] = true,
			["CHudDamageIndicator"] = true,
			["CHudCrosshair"] = false,
		}
	end

	hook.Add("HUDShouldDraw", "QuantumHideHud", function(name)
		if GetConVarNumber("hud_on") == 1 then
			if hide[name] then return false end
		end
	end)

	local opacity1 = 0
	local update1 = 0
	local opacity2 = 0
	local update2 = 0
	local opacity1d = 0
	local wepopacity = 0
	local loading = 0 --"Loading" time
	local loadingafterdead = 0
	local nxtdsnd = 0
	local nxtrsnd = 0
	local nxtsnd = 0
	local deathopacity = 0
	local crossopacity = 0

	if GetConVarNumber("hud_load") == 1 then
		loading = 10
	end

	--[[

	local weapon = {}

	local function WeaponInitialize( ply )
	if LocalPlayer():Alive() then
		weapon = {}

		for k, v in pairs(LocalPlayer():GetWeapons()) do
			table.insert(weapon, v)
		end
	end
	end 

	This is for me :)

	hook.Add("PlayerHurt","QuantumPlayerHurt",function( ply, attacker, hprem, damagetaken )
		if ply:Health() <= 30 and nxtsnd < CurTime() then
			ply:EmitSound("sound/crdmg.wav")
			nxtsnd = CurTime() + 3
		end
	end)

	local entsnd = 0

	function quantumEntSnd()
	if CLIENT then
		local p = LocalPlayer()
		
		local trace = p:GetEyeTrace()
		if IsEntity(trace.Entity) and trace.Entity:IsValid() and entsnd < CurTime() then
			entsnd = CurTime() + 90000
			sound.PlayFile( "sound/notify.wav", "", function( notify )
			if ( IsValid( notify ) ) then notify:Play() end end )
		return
		end
		entsnd = 0
	end
	end

	hook.Add("Think", "QuantumThink", quantumEntSnd  )
	]]

	function GetCoordinates(ent)
		local min,max = ent:OBBMins(),ent:OBBMaxs()
		local center = ent:OBBCenter()
		local corners = {
			Vector(min.x,min.y,min.z),
			Vector(min.x,min.y,max.z),
			Vector(min.x,max.y,min.z),
			Vector(min.x,max.y,max.z),
			Vector(max.x,min.y,min.z),
			Vector(max.x,min.y,max.z),
			Vector(max.x,max.y,min.z),
			Vector(max.x,max.y,max.z) 
		}
		local centers = {
			Vector(center.x,center.y,center.z)
		}

		local minx,miny,maxx,maxy = ScrW() * 2,ScrH() * 2,0,0
		for _,corner in pairs(corners) do
			local screen = ent:LocalToWorld(corner):ToScreen()
			minx,miny = math.min(minx,screen.x),math.min(miny,screen.y)
			maxx,maxy = math.max(maxx,screen.x),math.max(maxy,screen.y)
		end
		return minx,miny,maxx,maxy
	end


	local health = 0
	local armor = 0
	local stamina = 0

	local dcd = 0
	function QuantumPaint()

		local ply = LocalPlayer()
		
		if ply:GetViewEntity() != ply then return end
		if ply:InVehicle() then return end
		if ply:GetNWBool("Rised_Combot_Entered", false) then return end

		local w = ScrW()
		local h = ScrH()
		local wh = math.Round(w/h, 2)
		local m_left = -116.6161 * wh - 6.6574
		local m_right = -m_left - 7
		local m_bottom = -115
		local m_top = -m_bottom + 7

		if (w > 3000) then
			 m_left = -86.6161 * wh - 6.6574
			 m_bottom = -85
		end

		local p = LocalPlayer()
		local wep = p:GetActiveWeapon()
		local healthnolerp = LocalPlayer():Health() / (LocalPlayer():GetMaxHealth()/100) 

		local Loading = Material("materials/loading.png", "unlitgeneric")
		local Cross = Material("materials/cross.png", "unlitgeneric")
		local Grenades = Material("materials/grenade.png", "unlitgeneric")
		

		local flickamount = GetConVarNumber( "hud_flickamount" )
		
		local position = 0
		if health < 70 and GetConVarNumber( "hud_flick" ) == 1 then
			position = math.random(0,0.005*flickamount*0.3*((70 - health)*0.18))
		end
		
		local alpha1 = math.random(230-flickamount*1.15-(70-health)*0.95,230)
		local alpha2 = math.random(255-flickamount*1.15-(70-health)*0.95,255)
		
		local r = 215
		local g = 225
		local b = 100

		local rs = 255
		local gs = 255
		local bs = 255

		if GAMEMODE.CombineJobs[p:Team()] then
			r = 255
			g = 255
			b = 255
			rs = 255
			gs = 0
			bs = 0
		elseif p:isCP() then
			r = 255
			g = 165
			b = 0
			rs = 255
			gs = 195
			bs = 0
		elseif GAMEMODE.Rebels[p:Team()] then
			r = 255
			g = 255
			b = 255
			rs = 45
			gs = 195
			bs = 45
		elseif GAMEMODE.LoyaltyJobs[p:Team()] then
			r = 255
			g = 255
			b = 255
			rs = 155
			gs = 255
			bs = 155
		end
		
		local rb,gb,bb = 0,	0,0

		local main = Color(r, g, b, 210 )
		local secondary = Color(rs, gs, bs, 210 )
		local back = Color(rb, gb, bb, 145 )
		local back_offset = 7

		local size3d2d = GetConVarNumber( "hud_size" )
		local stright = 0
		if ScrW() < 1050 then
			stright = 3.5
		elseif ScrW() < 1300 then
			stright = 1
		end
		local stup = 0
		local ammoright = GetConVarNumber( "hud_ammoright" )
		local ammoup = GetConVarNumber( "hud_ammoup" )
		local grenaderight = GetConVarNumber( "hud_grenaderight" )
		local grenadeup = GetConVarNumber( "hud_grenadeup" )
		local rright = 0.2
		local rup = 3
		local rdot = Color(r,g,b, 210)
		local crosshair = Color( r, g, b, 230)
		local white = Color(255, 255, 255, 255)
		local orange = Color(255, 185, 15, 255)
		local red = Color(255, 50, 50, 255)
		local green = Color(50, 255, 100, 255)
		local blue = Color(80, 200, 255, 255)
		local black = Color(30, 30, 30, 210)
		if health < 75 and GetConVarNumber( "hud_flick" ) == 1 then
			main = Color( r, g, b, alpha1)
			crosshair = Color( r, g, b, alpha2)  	
			green = Color(50, 255, 50, alpha2)
			red = Color(255, 50, 50, alpha2)
			blue = Color(80, 200, 255, alpha2)
			rdot = Color(r, g, b, alpha1)
		end
		
		local doom3na = {
			[1] = "weapon_doom3_chaingun",
			[2] = "weapon_doom3_plasmagun",
			[3] = "weapon_doom3_machinegun",
			[4] = "weapon_doom3_bfg"
		}  
		local doom3a = {
			[1]="weapon_doom3_doublebarrel",
			[2]="weapon_doom3_shotgun",
			[3]="weapon_doom3_rocketlauncher",
			[4]="weapon_doom3_grenade",
			[5]="weapon_doom3_pistol"
		}
		local doom3 = {
			[1] = "weapon_doom3_doublebarrel",
			[2] = "weapon_doom3_shotgun",
			[3] = "weapon_doom3_rocketlauncher",
			[4] = "weapon_doom3_grenade",
			[5] = "weapon_doom3_pistol",
			[6] = "weapon_doom3_chaingun",
			[7] = "weapon_doom3_plasmagun",
			[8] = "weapon_doom3_machinegun",
			[9] = "weapon_doom3_bfg"
		}
		local m9kshotguns = {
			[1] = "m9k_m3",
			[2] = "m9k_browningauto5",
			[3] = "m9k_dbarrel",
			[4] = "m9k_ithacam37",
			[5] = "m9k_mossberg590",
			[6] = "m9k_jackhammer",
			[7] = "m9k_remington870",
			[8] = "m9k_spas12",
			[9] = "m9k_striker12",
			[10] = "m9k_usas",
			[11] = "m9k_1897winchester",
			[12] = "m9k_1887winchester"
		}

		if p:KeyDown(IN_ATTACK2) and !(p:KeyDown(IN_SPEED)) then
			crossopacity = Lerp(FrameTime()*12,crossopacity,0)
		else
			crossopacity = 230
		end
		
		local ammotextw = 0
		
		if wep:IsValid() then
			if wep:GetClass() == doom3[1]
			or wep:GetClass() == doom3[2]
			or wep:GetClass() == doom3[3]
			or wep:GetClass() == doom3[4]
			or wep:GetClass() == doom3[5]
			or wep:GetClass() == doom3[6]
			or wep:GetClass() == doom3[7]
			or wep:GetClass() == doom3[8]
			or wep:GetClass() == doom3[9] 
			or wep:GetClass() == "weapon_crossbow"
			or wep:GetClass() == "weapon_357"
			or wep:GetClass() == "weapon_ar2"
			or wep:GetClass() == "weapon_smg1"
			or wep:GetClass() == "weapon_shotgun"
			or wep:GetClass() == "weapon_pistol" then
				crossopacity = 230
			end
			ammotextw = select(1,surface.GetTextSize(p:GetAmmoCount(wep:GetPrimaryAmmoType())))
		end
		
		if update1 < CurTime() then
			opacity1 = Lerp(FrameTime()*5, opacity1, 7000)
			update1 = CurTime()+1
		else
			opacity1 = Lerp(FrameTime()*3, opacity1, 50)
		end
		
		if update2 < CurTime() then
			opacity2 = Lerp(FrameTime()*10, opacity2, 5000)
			update2 = CurTime()+0.6
		else
			opacity2 = Lerp(FrameTime()*5, opacity2, 50)
		end

		local deathop = GetConVarNumber("hud_deathop")
		local warningred = Color(255, 30, 30, opacity1)
		local warningred2 = Color(255, 30, 30, opacity2)
		if !(p:Alive()) && GAMEMODE.CombineJobs[p:Team()] then
			deathopacity = Lerp(FrameTime()*2,deathopacity,615+(deathop*6.15))
		elseif p:Alive() or GetConVarNumber("hud_deathscr") == 0 then
			deathopacity = Lerp(FrameTime()*3,deathopacity,0)
		end
		
		draw.RoundedBox(0,0,0,w,h, Color(18, 47, 170, deathopacity ))
		draw.DrawText("Problems have been detected:","zejton40", 100, 80,Color(r, g, b, deathopacity/2 ) ,0 )
		draw.DrawText("ERROR:","zejton20", 100, 150, Color(200, 50, 10, deathopacity/2 ),0 )
		draw.DrawText("Hard drive not responding","zejton20", 160, 150, Color(r,g,b, deathopacity/2 ),0 )
		draw.DrawText("ERROR: Implants offline","zejton20", 100, 180, Color(r,g,b,deathopacity/2),0 )
		draw.DrawText("ERROR: Interface offline","zejton20", 100, 210, Color(r,g,b,deathopacity/2),0 )
		draw.DrawText("Technical information:","zejton18", 100, 260, Color(r,g,b,deathopacity/2),0 )
		draw.DrawText("*** STOP: 0x00000101 (0xFFFFFA60005B99D0, 0xFFFFFFFFC0000034, 0x0000000000000000)","zejton18", 100, 300, Color(r,g,b,deathopacity/2),0 )
		draw.DrawText("Collecting data from crash dump...","zejton18", 100, 340, Color(r,g,b,deathopacity/2),0 )
		draw.DrawText("Initializing disk for crash dump...","zejton18", 100, 360, Color(r,g,b,deathopacity/2),0 )
		draw.DrawText("Beginning dump of physical memory.","zejton18", 100, 380, Color(r,g,b,deathopacity/2),0 )
		draw.DrawText("Dumping physical memory to disk: 40","zejton18", 100, 400, Color(r,g,b,deathopacity/2),0)
		
		dtime = 0
		if math.Round(p:GetNWInt('EDS.RespawnTime', 0), 0) > 0 then
			dtime = math.Round(p:GetNWInt('EDS.RespawnTime', 0))
		end
		if dcd != dtime then
			opacity1d = Lerp(FrameTime()*5, opacity1d, 7000)
			dcd = dtime
		else
			opacity1d = Lerp(FrameTime()*3, opacity1d, 50)
		end
		if !(p:Alive()) then 
			if nxtdsnd < CurTime() then
				nxtdsnd = math.huge
				-- p:EmitSound("dead.wav")
			end
			if GetConVarNumber("hud_deathscr") == 1 then
				if dtime != 0 then
					draw.DrawText("Осталось до возрождения " .. dtime,"zejton30", w-150, h-150, Color(r,g,b,opacity1d),2 )
				else
					draw.DrawText("Нажмите любую кнопку для возрождения","zejton30", w-150, h-150, Color(r,g,b,opacity1),2 )
				end
			end
			if GetConVarNumber("hud_load") == 1 && GAMEMODE.CombineJobs[p:Team()] then
				loadingafterdead = CurTime() + 5
			end
			nxtrsnd = 0
			return
		end
		
		draw.DrawText("SUCCESS!","zejton40", w-150, h-150, Color(r,g,b,deathopacity/2),2 )
		if nxtrsnd < CurTime() and loadingafterdead > loading then
			nxtrsnd = math.huge
			-- p:EmitSound("respawn.wav")
		end
		nxtdsnd = 0
		
		local trace = p:GetEyeTrace()
		local cx, cy = trace.HitPos:ToScreen().x, trace.HitPos:ToScreen().y
		local trace = p:GetEyeTrace()
		local shootPos = Vector(0,0,0)
		
		if wep:IsValid() and wep:GetClass() != "keys" and wep:GetClass() != "pocket" then --[[  You can remove this (leave only shootPos = p:GetViewModel():GetPos()) if you added this in keys and pocket shared.lua :
																							SWEP.ViewModel = "models/weapons/v_pistol.mdl"
																							SWEP.WorldModel = "models/weapons/w_357.mdl"  ]]--
			shootPos = p:GetViewModel():GetPos()
		else
			shootPos = p:GetShootPos()
		end
		
		local fixfas1 = 1 
		local fixfas2 = 10 
		
		local forward = p:EyeAngles():Forward()
		local right = p:EyeAngles():Right()
		local pangle = p:GetAngles().y
		local up = p:EyeAngles():Up()
		
		local angle = p:EyeAngles() + p:GetViewPunchAngles()
		angle:RotateAroundAxis( angle:Right(),90)
		angle:RotateAroundAxis( angle:Up(), -90 )
		angle:RotateAroundAxis( angle:Forward(), 0 )
		
		local angle1 = p:EyeAngles() + p:GetViewPunchAngles()
		angle1 = angle1 * 1
		angle1:RotateAroundAxis( angle1:Right(),90)
		angle1:RotateAroundAxis( angle1:Up(), -80 )
		angle1:RotateAroundAxis( angle1:Forward(), -7 )
		
		local angle2 = p:EyeAngles() + p:GetViewPunchAngles()
		angle2 = angle2 * 1
		angle2:RotateAroundAxis( angle2:Right(),90)
		angle2:RotateAroundAxis( angle2:Up(), -100 )
		angle2:RotateAroundAxis( angle2:Forward(), 7 )
		
		local angle3 = p:EyeAngles() + p:GetViewPunchAngles()
		angle3 = angle3 * 1
		angle3:RotateAroundAxis( angle3:Right(),90)
		angle3:RotateAroundAxis( angle3:Up(), -80 )
		angle3:RotateAroundAxis( angle3:Forward(), 7 )
		
		-- Stats --
		if p:IsSuitEquipped() == true then
			local info = "Preparing status display..."
			if CurTime() > 4 and CurTime() < 6 then 
				info = "Launching ammo counter..."
			elseif CurTime() > 6 and CurTime() < 8 then
				info = "Launching entity display..."
			elseif CurTime() > 8 then
				info = "Configuring..."
			end

			if loading > CurTime() and loadingafterdead < loading then --loading 
				draw.SimpleText("Loading...","zejton18", w/2-280, h/2-20, Color(255, 255, 255, opacity1) )
				draw.SimpleText(math.Round(CurTime()*10).." %","zejton18", w/2+250, h/2-20, Color(255, 255, 255, 230) )
				draw.DrawText(info,"zejton18", w/2, h/2+40, Color(255, 255, 255, 230),1 )
				draw.RoundedBox(3,w/2-280,h/2,CurTime()*56,15, Color(235, 235, 235, 255))
				draw.RoundedBox(3,w/2-280,h/2,560,15,Color(130,130,130,80))
				surface.SetMaterial(Loading)
				surface.SetDrawColor(Color(255, 255, 255, math.random(200,255)))
				surface.DrawTexturedRect( w/2-330+math.random(0,0.03), h/2-200+math.random(0,0.03), 680, 218)
			elseif loadingafterdead > CurTime() then --respawn loading
				if GetConVarNumber("hud_cross") == 1 and wep:IsValid() then
					if (loadingafterdead - 2.5) > CurTime() then
						draw.DrawText("Loading...","zejton20", cx, cy, Color(255, 255, 255, opacity1), 1)
					else
						if wep:GetClass() == "weapon_shotgun" 
						or wep:GetClass() == "weapon_doom3_shotgun" 
						or wep:GetClass() == "weapon_doom3_bfg" 
						or wep:GetClass() == "weapon_doom3_doublebarrel" 
						or wep:GetClass() == "tfa_widowmaker" 
						or wep:GetClass() == m9kshotguns[1]
						or wep:GetClass() == m9kshotguns[2]
						or wep:GetClass() == m9kshotguns[3]
						or wep:GetClass() == m9kshotguns[4]
						or wep:GetClass() == m9kshotguns[5]
						or wep:GetClass() == m9kshotguns[6]
						or wep:GetClass() == m9kshotguns[7]
						or wep:GetClass() == m9kshotguns[8]
						or wep:GetClass() == m9kshotguns[9]
						or wep:GetClass() == m9kshotguns[10]
						or wep:GetClass() == m9kshotguns[11] 
						or wep:GetClass() == m9kshotguns[12] then
							drawCir(50,50,145,215,cx+position-1.5,cy+position-1.85,Color(r,g,b,crossopacity/2))
							drawCir(50,50,325,395,cx+position-1.5,cy+position-1.85,Color(r,g,b,crossopacity/2))	
						else 
							draw.RoundedBox(3,cx+position-1.5, cy+position-1.85, 4, 4, Color(r,g,b,crossopacity))					
						end					
					end
				end
				cam.Start3D()
					if armor < 5 then
					cam.Start3D2D( shootPos + (forward * 160)   + ( right * (-195+(stright*15)) ) +  (up * (-75+(stup*10)) ) , angle1, 0.15+(size3d2d/100))
						if (loadingafterdead - 2) > CurTime() then
							if (loadingafterdead - 3) > CurTime() then
								draw.SimpleText("Loading...","zejton40", position+100, position+100, Color(255, 255, 255, opacity1))
							else
								draw.SimpleText("Configuring...","zejton40", position+110, position+100, Color(255, 255, 255, opacity1))
							end
						else
							draw.SimpleText(p:Health(),"zejton50", position, position+100, main )
							draw.RoundedBox(1,surface.GetTextSize(p:Health())+10+position+math.Clamp( 300 * ( health / 100 ), 0, 300 ),position+105,2,40,orange)
							if healthnolerp > 30 then
							draw.RoundedBox(3,surface.GetTextSize(p:Health())+10+position,position+110,math.Clamp( 300 * ( health / 100 ), 0, 300 ),30,green)
							draw.RoundedBox(1,surface.GetTextSize(p:Health())+10+position+math.Clamp( 300 * ( health / 100 ), 0, 300 ),position+105,2,40,orange)
							else
							draw.RoundedBox(3,surface.GetTextSize(p:Health())+10+position,position+110,math.Clamp( 300 * ( health / 100 ), 0, 300 ),30,red)
							draw.RoundedBox(1,surface.GetTextSize(p:Health())+10+position+math.Clamp( 300 * ( health / 100 ), 0, 300 ),position+105,2,40,orange)
							end
							draw.RoundedBox(3,surface.GetTextSize(p:Health())+10+position,position+110,300,30,Color(130,130,130,alpha1/1.77))		
							if GetConVarNumber("hud_time") == 1 then
								draw.DrawText(os.date( "%d/%m/%Y, %H:%M" ,os.time() ),"zejton20",surface.GetTextSize(p:Health())+position+10,position+ 75,main, TEXT_ALIGN_LEFT)
							end
						end
					cam.End3D2D()
					elseif armor > 5 then
					cam.Start3D2D( shootPos + (forward * 160)  + ( right * (-195+(stright*15)) ) + (up * (-65+(stup*10)))  , angle1, 0.15+(size3d2d/100))
					if (loadingafterdead - 2) > CurTime() then
						if (loadingafterdead - 3) > CurTime() then
							draw.SimpleText("Loading...","zejton40", position+100, position+100, Color(255, 255, 255, opacity1))
						else
							draw.SimpleText("Configuring...","zejton40", position+110, position+100, Color(255, 255, 255, opacity1))
						end
					else
						draw.SimpleText(p:Health(),"zejton50", position, position+100, main )	
						draw.RoundedBox(1,surface.GetTextSize(p:Health())+10+position+math.Clamp( 300 * ( health / 100 ), 0, 300 ),position+105,2,40,orange)
						if healthnolerp > 30 then
						draw.RoundedBox(3,surface.GetTextSize(p:Health())+10+position,position+110,math.Clamp( 300 * ( health / 100 ), 0, 300 ),30,green)
						else
						draw.RoundedBox(3,surface.GetTextSize(p:Health())+10+position,position+110,math.Clamp( 300 * ( health / 100 ), 0, 300 ),30,red)
						end
						draw.RoundedBox(3,surface.GetTextSize(p:Health())+10+position,position+110,300,30,Color(130,130,130,alpha1/1.79))
						draw.SimpleText(p:Armor(),"zejton50", position, position+170, main )
						draw.RoundedBox(3,surface.GetTextSize(p:Armor())+10+position,position+180,3*armor,30,blue)
						draw.RoundedBox(1,surface.GetTextSize(p:Armor())+10+position+3*armor,position+175,2,40,orange)
						draw.RoundedBox(3,surface.GetTextSize(p:Armor())+10+position,position+180,300,30,Color(130,130,130,alpha1/1.79))
						if GetConVarNumber("hud_time") == 1 then
							draw.DrawText(os.date( "%d/%m/%Y, %H:%M" ,os.time() ),"zejton20",surface.GetTextSize(p:Health())+position+10,position+ 75,main, TEXT_ALIGN_LEFT)
						end
					end		
					cam.End3D2D()
					end
					if GetConVarNumber("hud_radar") == 1 then
						cam.Start3D2D( shootPos + (forward * m_left)  + ( right * (110-((stright+rright)*12)) ) + (up * (105-((stup+rup)*18)))*(fixfas2/10) , angle3, 0.16+(size3d2d/100))
							if (loadingafterdead - 0.5) > CurTime() then
								draw.SimpleText("Loading...","zejton30", position+350, position+100, Color(255, 255, 255, opacity1))
							else
								draw.RoundedBox(10,position +300, position +100, 256, 192, Color(100,100,100,alpha1/5.75) )
								draw.DrawText("Configuring...","zejton30",position +426, position +182, Color(255, 255, 255, opacity1),1)
								draw.RoundedBoxEx(10,position +300, position +80, 256, 32, rdot, true,true )
								draw.DrawText("radar.exe", "zejton20",  position + 390,  position+85, Color(100,100,100,alpha2),  TEXT_ALIGN_RIGHT)
								surface.SetMaterial(Cross)
								surface.SetDrawColor(100,100,100,alpha2)
								surface.DrawTexturedRect(position + 520 , position+87, 18, 18)
							end
						cam.End3D2D()
					end
					if wep:IsValid() then
						if wep:Clip1() > 0 then
							cam.Start3D2D( shootPos + (forward * 160)  + ( right * (145-(stright*15)) ) + (up * (-70+(stup*10)))  , angle2, 0.2+(size3d2d/100))
								draw.DrawText("Loading...","zejton30", 230+position, 50+position, Color(255, 255, 255, opacity1),1)
							cam.End3D2D()
						end
					end
				cam.End3D()
			else
				if CurTime() < loading*1.01 and GetConVarNumber("hud_load") == 1 then 
					-- p:EmitSound("notify.wav")
				end

				cam.Start3D()
					--Stats--
					local fov = LocalPlayer():GetFOV()
					local offset_fov = -2.8378 * fov + 416.6216
					local offset_x = m_left + 15
					local offset_y = m_bottom + 57
					
					if GetConVar("rised_HUD_Vital_enable"):GetBool() then
		
						local lifesText = "♥"
						if LocalPlayer():GetNWInt( "PlayerLifes" ) == 0 then
							lifesText = "♥"
						elseif LocalPlayer():GetNWInt( "PlayerLifes" ) == 1 then
							lifesText = "♥♥"
						elseif LocalPlayer():GetNWInt( "PlayerLifes" ) == 2 then
							lifesText = "♥♥♥"
						elseif LocalPlayer():GetNWInt( "PlayerLifes" ) > 2 then
							lifesText = "♥♥♥+"
						end

						cam.Start3D2D(shootPos + (forward * offset_fov)  + (right * offset_x ) + (up * offset_y), angle1, 0.15+(size3d2d/100))
							
							local item_offset = 0

							local asize = math.Clamp( 300 * ( armor / 100 ), 0, 300)
							if p:Armor() > 0 then
								item_offset = -70
								draw.RoundedBox(3,surface.GetTextSize(p:Armor())+160+position,position+180,asize,30,secondary)
								draw.RoundedBox(3,surface.GetTextSize(p:Armor())+160+position,position+200,asize,5,Color(rs-100,gs-100,bs-100,150))
								draw.RoundedBox(1,surface.GetTextSize(p:Armor())+160+position+asize,position+175,2,40,secondary)
								draw.SimpleText("Броня:","zejton50", position+back_offset, position+168+back_offset, back )
								draw.SimpleText("Броня:","zejton50", position, position+168, main )
								draw.SimpleText(p:Armor(),"zejton50", position+130+back_offset, position+170+back_offset, back )
								draw.SimpleText(p:Armor(),"zejton50", position+130, position+170, main )
							end
							
							if LocalPlayer():GetNWBool("Player_Watch") == true or GAMEMODE.LoyaltyJobs[LocalPlayer():Team()] or LocalPlayer():Team() == TEAM_REBELSPY01 or LocalPlayer():isCP() then
								local time_text = (GetGlobalFloat("HoursTimeFloat") < 10 and "0" .. GetGlobalFloat("HoursTimeFloat") or GetGlobalFloat("HoursTimeFloat")) .. " : " .. (GetGlobalFloat("MinutsTimeFloat") < 10 and "0" .. GetGlobalFloat("MinutsTimeFloat") or GetGlobalFloat("MinutsTimeFloat"))
								draw.DrawText(time_text,"zejton30",position+10+back_offset,position+140+item_offset+back_offset,back, TEXT_ALIGN_LEFT)
								draw.DrawText(time_text,"zejton30",position+10,position+140+item_offset,main, TEXT_ALIGN_LEFT)
							end
							if LocalPlayer():Team() == TEAM_OTA_Razor then
								local stealthMode = !ply:GetNWBool("Player_Razor_Ghosted") && "Off" || "On"
								draw.SimpleText("Stealth mode: " .. stealthMode,"zejton30", position+280+back_offset, position+140+item_offset+back_offset, back )
								draw.SimpleText("Stealth mode: " .. stealthMode,"zejton30", position+280, position+140+item_offset, main )
							end
							
							draw.SimpleText("Здоровье:","zejton50", position+back_offset, position+168+item_offset+back_offset, back)
							draw.SimpleText("Здоровье:","zejton50", position, position+168+item_offset, main)
							draw.SimpleText(p:Health(),"zejton50", position+200+back_offset, position+170+item_offset+back_offset, back)
							draw.SimpleText(p:Health(),"zejton50", position+200, position+170+item_offset, main)

							local hsize = math.Clamp( 300 * ( health / 100 ), 0, 300)
							if p:Health() > 30 then
								draw.RoundedBox(3,surface.GetTextSize(p:Health())+210+position,position+180+item_offset,hsize,30,secondary)
								draw.RoundedBox(1,surface.GetTextSize(p:Health())+210+position,position+193+item_offset,hsize,5,Color(rs-100,gs-100,bs-100,150))
								draw.RoundedBox(1,surface.GetTextSize(p:Health())+210+position,position+200+item_offset,hsize,5,Color(rs-100,gs-100,bs-100,150))
								draw.RoundedBox(1,surface.GetTextSize(p:Health())+210+position+hsize,position+175+item_offset,2,40,secondary)
							else
								draw.RoundedBox(3,surface.GetTextSize(p:Health())+210+position,position+180+item_offset,hsize,30,Color(rs-100,gs-100,bs-100,150))
								draw.RoundedBox(1,surface.GetTextSize(p:Health())+210+position+hsize,position+175+item_offset,2,40,secondary)
							end

							draw.RoundedBox(1,0,position+224+item_offset,3*p:GetNWInt("Rised_Player_Stamina_Max"),7,Color(rs-100,gs-100,bs-100,150))
							local stamina_col = secondary
							if p:GetNWInt("Rised_Player_Stamina") < 10 then
								stamina_col = Color(rs,gs-175,bs-175,150)
							end
							draw.RoundedBox(3,0,position+220+item_offset,3*p:GetNWInt("Rised_Player_Stamina"),7,stamina_col)

							if LocalPlayer():isCP() then
								draw.SimpleText("Unit: " .. LocalPlayer():Name() .. " | " .. lifesText,"zejton40", position+back_offset, position+228+back_offset, back )
								draw.SimpleText("Unit: " .. LocalPlayer():Name() .. " | " .. lifesText,"zejton40", position, position+228, main )
							else
								draw.SimpleText("Личность: " .. LocalPlayer():Name() .. " | " .. lifesText,"zejton40", position+back_offset, position+228+back_offset, back )
								draw.SimpleText("Личность: " .. LocalPlayer():Name() .. " | " .. lifesText,"zejton40", position, position+228, main )
							end
							
							local hunger = LocalPlayer().DarkRPVars and math.Round( LocalPlayer().DarkRPVars.Energy or 0 ) or 0
							local hunger_text = "Насыщение:"
							local bar_width = surface.GetTextSize("             " .. LocalPlayer():Name()) - surface.GetTextSize(hunger_text) + 80
							draw.SimpleText(hunger_text,"zejton27", position+back_offset, position+268+back_offset, back )
							draw.SimpleText(hunger_text,"zejton27", position, position+268, main )
							draw.RoundedBox(3, surface.GetTextSize(hunger_text)+position+10, position+281, math.Clamp(bar_width*(hunger/100), 0, bar_width),6,secondary)
							draw.RoundedBox(7, surface.GetTextSize(hunger_text)+position+8, position+279, math.Clamp(bar_width*(hunger/100), 0, bar_width),11,Color(rs,gs,bs,math.random(5,55)))
							draw.RoundedBox(3, surface.GetTextSize(hunger_text)+position+8, position+279, math.Clamp(bar_width*100, 0, bar_width),11,Color(rs,gs,bs,5))

							local mood = math.Clamp(LocalPlayer():GetNWInt("Player_Mood", 100), 0, 100)
							local mood_text = "Настроение:"
							draw.SimpleText(mood_text,"zejton27", position+back_offset, position+290+back_offset, back )
							draw.SimpleText(mood_text,"zejton27", position, position+290, main )
							draw.RoundedBox(3, surface.GetTextSize(mood_text)+position+10, position+303, math.Clamp(bar_width*(mood/100), 0, bar_width),6,secondary)
							draw.RoundedBox(7, surface.GetTextSize(mood_text)+position+8, position+301, math.Clamp(bar_width*(mood/100), 0, bar_width),11,Color(rs,gs,bs,math.random(5,55)))
							draw.RoundedBox(3, surface.GetTextSize(mood_text)+position+8, position+301, math.Clamp(bar_width*100, 0, bar_width),11,Color(rs,gs,bs,5))

							if ply.Player_ExpCommon then
								local exp_current = ply.Player_ExpCommon
								local level = ply.Player_LevelCommon
								local next_lvl_exp = ply.Player_NextLevelExpCommon
								local prev_total_lvl_exp = ply.Player_PrevTotalLevelExpCommon
								local next_total_lvl_exp = ply.Player_NextTotalLevelExpCommon
								if p:isCP() then
									exp_current = ply.Player_ExpCombine
									level = ply.Player_LevelCombine
									next_lvl_exp = ply.Player_NextLevelExpCombine
									prev_total_lvl_exp = ply.Player_PrevTotalLevelExpCombine
									next_total_lvl_exp = ply.Player_NextTotalLevelExpCombine
								elseif GAMEMODE.Rebels[p:Team()] then
									exp_current = ply.Player_ExpRebel
									level = ply.Player_LevelRebel
									next_lvl_exp = ply.Player_NextLevelExpRebel
									prev_total_lvl_exp = ply.Player_PrevTotalLevelExpRebel
									next_total_lvl_exp = ply.Player_NextTotalLevelExpRebel
								elseif GAMEMODE.LoyaltyJobs[p:Team()] then
									exp_current = ply.Player_ExpParty
									level = ply.Player_LevelParty
									next_lvl_exp = ply.Player_NextLevelExpParty
									prev_total_lvl_exp = ply.Player_PrevTotalLevelExpParty
									next_total_lvl_exp = ply.Player_NextTotalLevelExpParty
								end

								local exp_current_start = exp_current - prev_total_lvl_exp
								local percentage = math.Round((exp_current_start / next_lvl_exp) * 100, 1)

								local experience = math.Clamp(LocalPlayer():GetNWInt("Player_Mood", 100), 0, 100)
								local experience_text = "Опыт:"
								local bar_width = surface.GetTextSize("     " .. LocalPlayer():Name()) - surface.GetTextSize(hunger_text) + 80
								draw.SimpleText(experience_text,"zejton27", position+back_offset, position+312+back_offset, back )
								draw.SimpleText(experience_text,"zejton27", position, position+312, main )
								draw.RoundedBox(3, surface.GetTextSize(experience_text	)+position+10, position+325, math.Clamp(bar_width*(percentage/100), 0, bar_width),6,secondary)
								draw.RoundedBox(7, surface.GetTextSize(experience_text)+position+8, position+324, math.Clamp(bar_width*(percentage/100), 0, bar_width),11,Color(rs,gs,bs,math.random(5,55)))
							end
						cam.End3D2D()
					end

					-- Radar --
					if CanUseRadar() and GetConVar("rised_HUD_CombineInfo_enable"):GetBool() then
						local offset_x = m_right - 95
						local offset_y = m_top - 35
						cam.Start3D2D( shootPos + (forward * offset_fov * 0.85) + ( right * offset_x ) + (up * offset_y), angle3, 0.16+(size3d2d/100))
							
							draw.RoundedBox(10,position, position+100, 256, 192, Color(100,100,100,40) )
							draw.RoundedBox(6,position+126, position +198, 12, 12, rdot )

							local ZombieJobs = {
								[TEAM_ZOMBIE] = true,
								[TEAM_ZOMBIECP] = true,
								[TEAM_FASTZOMBIE] = true,
								[TEAM_COMBINEZOMBIE] = true,
								[TEAM_JEFF] = true,
							}

							for k, v in pairs ( players or player.GetAll()) do
								local dist = p:GetPos():Distance(v:GetPos())
								local rx, ry = PointOnCircle( (v:GetPos() - p:GetPos()):Angle().yaw - p:EyeAngles().yaw  - 90 , dist/20, position +126, position +198 )
								if dist < 1600 then
									if v:IsPlayer() and v != p and (v:isCP() or v:Team() == TEAM_REBELSPY01) then
										draw.RoundedBox(6,position +rx, position +ry, 12, 12, Color(100,255,100,opacity1) )
									elseif v:IsPlayer() and ZombieJobs[v:Team()] then
										draw.RoundedBox(6,position +rx, position +ry, 12, 12, Color(255,100,100,opacity2) )
									end
								end
							end

							for k, v in pairs (ents.FindByClass("npc_*")) do
								local dist = p:GetPos():Distance(v:GetPos())
								local rx, ry = PointOnCircle( (v:GetPos() - p:GetPos()):Angle().yaw - p:EyeAngles().yaw  - 90 , dist/20, position +126, position +198 )
								if dist < 1600 then
									if v:GetClass() == "npc_turret_floor" then
										draw.RoundedBox(6,position +rx, position +ry, 8, 8, Color(200,200,200,opacity3) )
									elseif v:IsNPC() then
										draw.RoundedBox(6,position +rx, position +ry, 12, 12, Color(255,100,100,opacity2) )
									end
								end
							end

							nxtnotify = CurTime()+5

							draw.RoundedBoxEx(10,position, position +80, 256, 32, rdot, true,true )
							draw.DrawText("Bio radar", "marske5",  position + 110,  position+90, Color(0,0,0),  TEXT_ALIGN_RIGHT)
							surface.SetMaterial(Cross)
							surface.SetDrawColor(100,100,100,250)
							surface.DrawTexturedRect(position + 220 , position+87, 18, 18)

						cam.End3D2D()
					end
				cam.End3D()

				--[[        
				cam.Start3D() 
					cam.Start3D2D(shootPos + (forward * 160) + ( right * (-165+(stright*15)) ) +  (up * (70+(stup*10)) ) , angle, 0.15+(size3d2d/100))
						draw.RoundedBox(2,800,30,(w-2*800+25),15,main)
						for k, v in pairs (ents.FindByClass("npc_*")) do
							local dist = p:GetPos():Distance(v:GetPos())
							if dist < 1600 and v:GetPos():ToScreen().x > 800 and v:GetPos():ToScreen().x < w-800 then
								draw.DrawText( math.Clamp(math.Round(dist/30),0,999),"zejton20",v:GetPos():ToScreen().x +5, 50, main, 1 )
								draw.RoundedBox(4,v:GetPos():ToScreen().x,30,15,15,Color(230,50,0,250))
							end
						end
					cam.End3D2D()
				cam.End3D()]] 

				--Low hp warn--
				if health <= 30 and GAMEMODE.CombineJobs[LocalPlayer():Team()] then
					cam.Start3D()
						cam.Start3D2D( shootPos + (forward * 135) + ( right * m_left ) + (up * m_top * 1.3), angle2, 0.15+(size3d2d/100))
							draw.DrawText("НЕОБХОДИМО МЕДИЦИНСКОЕ ВМЕШАТЕЛЬСТВО", "marske8",  position + 40,  position+10, main,  TEXT_ALIGN_LEFT)
							draw.RoundedBox(3,position,position+7,30,30,warningred)
						cam.End3D2D()
					cam.End3D()
				end


				-- Glitch Effect --

				if health < 70 and GetConVarNumber("hud_glitch") == 1 then
				if flickamount >= 10 then
						if math.random(0,100) > 80 then
						draw.RoundedBox(0,math.random(10,w-10),math.random(10,h-10),math.random(1,(70-health)/3 + flickamount/2),math.random(0.1,(70-health)/30 + flickamount/30),Color(r,g,b,(70-health)*(1.3+flickamount/65)))
						end
						if math.random(0,100) > 80 then
						draw.RoundedBox(0,math.random(10,w-10),math.random(10,h-10),math.random(1,(70-health)/3 + flickamount/2),math.random(0.1,(70-health)/30 + flickamount/30),Color(r,g,b,(70-health)*(1.3+flickamount/65)))
						end
						if math.random(0,100) > 80 then
						draw.RoundedBox(0,math.random(10,w-10),math.random(10,h-10),math.random(1,(70-health)/3 + flickamount/2),math.random(0.1,(70-health)/30 + flickamount/30),Color(r,g,b,(70-health)*(1.3+flickamount/65)))
						end
					elseif flickamount >= 40 then
						if math.random(0,100) > 80    then
						draw.RoundedBox(0,math.random(10,w-10),math.random(10,h-10),math.random(1,(70-health)/3 + flickamount/2),math.random(0.1,(70-health)/30 + flickamount/30),Color(r,g,b,(70-health)*(1.3+flickamount/65)))
						end
						if math.random(0,100) >= 80    then
						draw.RoundedBox(0,math.random(10,w-10),math.random(10,h-10),math.random(1,(70-health)/3 + flickamount/2),math.random(0.1,(70-health)/30 + flickamount/30),Color(r,g,b,(70-health)*(1.3+flickamount/65)))
						end
						if math.random(0,100) >= 80 then
						draw.RoundedBox(0,math.random(10,w-10),math.random(10,h-10),math.random(1,(70-health)/3 + flickamount/2),math.random(0.1,(70-health)/30 + flickamount/30),Color(r,g,b,(70-health)*(1.3+flickamount/65)))
						end
						if math.random(0,100) >= 80 then
						draw.RoundedBox(0,math.random(10,w-10),math.random(10,h-10),math.random(1,(70-health)/3 + flickamount/2),math.random(0.1,(70-health)/30 + flickamount/30),Color(r,g,b,(70-health)*(1.3+flickamount/65)))
						end
					elseif flickamount >= 60 then
						if math.random(0,100) >= 80   then
						draw.RoundedBox(0,math.random(10,w-10),math.random(10,h-10),math.random(1,(70-health)/3 + flickamount/2),math.random(0.1,(70-health)/30 + flickamount/30),Color(r,g,b,(70-health)*(1.3+flickamount/65)))
						end
						if math.random(0,100) >= 80   then
						draw.RoundedBox(0,math.random(10,w-10),math.random(10,h-10),math.random(1,(70-health)/3 + flickamount/2),math.random(0.1,(70-health)/30 + flickamount/30),Color(r,g,b,(70-health)*(1.3+flickamount/65)))
						end
						if math.random(0,100) >= 80  then
						draw.RoundedBox(0,math.random(10,w-10),math.random(10,h-10),math.random(1,(70-health)/3 + flickamount/2),math.random(0.1,(70-health)/30 + flickamount/30),Color(r,g,b,(70-health)*(1.3+flickamount/65)))
						end
						if math.random(0,100) >= 75 then
						draw.RoundedBox(0,math.random(10,w-10),math.random(10,h-10),math.random(1,(70-health)/3 + flickamount/2),math.random(0.1,(70-health)/30 + flickamount/30),Color(r,g,b,(70-health)*(1.3+flickamount/65)))
						end
						if math.random(0,100) >= 75 then
						draw.RoundedBox(0,math.random(10,w-10),math.random(10,h-10),math.random(1,(70-health)/3 + flickamount/2),math.random(0.1,(70-health)/30 + flickamount/30),Color(r,g,b,(70-health)*(1.3+flickamount/65)))
						end
					elseif flickamount >= 80 then
						if math.random(0,100) >= 80 then
						draw.RoundedBox(0,math.random(10,w-10),math.random(10,h-10),math.random(1,(70-health)/3 + flickamount/2),math.random(0.1,(70-health)/30 + flickamount/30),Color(r,g,b,(70-health)*(1.3+flickamount/65)))
						end
						if math.random(0,100) >= 80 then
						draw.RoundedBox(0,math.random(10,w-10),math.random(10,h-10),math.random(1,(70-health)/3 + flickamount/2),math.random(0.1,(70-health)/30 + flickamount/30),Color(r,g,b,(70-health)*(1.3+flickamount/65)))
						end
						if math.random(0,100) >= 80 then
						draw.RoundedBox(0,math.random(10,w-10),math.random(10,h-10),math.random(1,(70-health)/3 + flickamount/2),math.random(0.1,(70-health)/30 + flickamount/30),Color(r,g,b,(70-health)*(1.3+flickamount/65)))
						end
						if math.random(0,100) >= 75 then
						draw.RoundedBox(0,math.random(10,w-10),math.random(10,h-10),math.random(1,(70-health)/3 + flickamount/2),math.random(0.1,(70-health)/30 + flickamount/30),Color(r,g,b,(70-health)*(1.3+flickamount/65)))
						end
						if math.random(0,100) >= 75  then
						draw.RoundedBox(0,math.random(10,w-10),math.random(10,h-10),math.random(1,(70-health)/3 + flickamount/2),math.random(0.1,(70-health)/30 + flickamount/30),Color(r,g,b,(70-health)*(1.3+flickamount/65)))
						end
						if math.random(0,100) >= 75  then
						draw.RoundedBox(0,math.random(10,w-10),math.random(10,h-10),math.random(1,(70-health)/3 + flickamount/2),math.random(0.1,(70-health)/30 + flickamount/30),Color(r,g,b,(70-health)*(1.3+flickamount/65)))
						end
					elseif flickamount == 100 then
						if math.random(0,100) >= 80     then
						draw.RoundedBox(0,math.random(10,w-10),math.random(10,h-10),math.random(1,(70-health)/3 + flickamount/2),math.random(0.1,(70-health)/30 + flickamount/30),Color(r,g,b,(70-health)*(1.3+flickamount/65)))
						end
						if math.random(0,100) >= 75     then
						draw.RoundedBox(0,math.random(10,w-10),math.random(10,h-10),math.random(1,(70-health)/3 + flickamount/2),math.random(0.1,(70-health)/30 + flickamount/30),Color(r,g,b,(70-health)*(1.3+flickamount/65)))
						end
						if math.random(0,100) >= 75 then
						draw.RoundedBox(0,math.random(10,w-10),math.random(10,h-10),math.random(1,(70-health)/3 + flickamount/2),math.random(0.1,(70-health)/30 + flickamount/30),Color(r,g,b,(70-health)*(1.3+flickamount/65)))
						end
						if math.random(0,100) >= 75 then
						draw.RoundedBox(0,math.random(10,w-10),math.random(10,h-10),math.random(1,(70-health)/3 + flickamount/2),math.random(0.1,(70-health)/30 + flickamount/30),Color(r,g,b,(70-health)*(1.3+flickamount/65)))
						end
						if math.random(0,100) >= 75  then
						draw.RoundedBox(0,math.random(10,w-10),math.random(10,h-10),math.random(1,(70-health)/3 + flickamount/2),math.random(0.1,(70-health)/30 + flickamount/30),Color(r,g,b,(70-health)*(1.3+flickamount/65)))
						end
						if math.random(0,100) >= 75  then
						draw.RoundedBox(0,math.random(10,w-10),math.random(10,h-10),math.random(1,(70-health)/3 + flickamount/2),math.random(0.1,(70-health)/30 + flickamount/30),Color(r,g,b,(70-health)*(1.3+flickamount/65)))
						end
						if math.random(0,100) >= 70  then
						draw.RoundedBox(0,math.random(10,w-10),math.random(10,h-10),math.random(1,(70-health)/3 + flickamount/2),math.random(0.1,(70-health)/30 + flickamount/30),Color(r,g,b,(70-health)*(1.3+flickamount/65)))
						end
					end
				end--End of glitch

				-- Entity Display --
				if GetConVarNumber("hud_entd") == 1 then 

					--Entity types--
					local barrel = {
					[1] = "models/props_borealis/bluebarrel001.mdl",
					[2] = "models/props_c17/oildrum001.mdl",
					}
					local statue = {
					[1] = "models/props_c17/gravestone_statue001a.mdl",
					[2] = "models/props_c17/gravestone_cross001a.mdl",
					[3] = "models/props_c17/gravestone_cross001b.mdl",
					[4] = "models/props_combine/breenbust.mdl"
					}
					local furniture = {
					[1] = "models/props_interiors/furniture_couch01a.mdl",
					[2] = "models/props_interiors/furniture_couch02a.mdl",
					[3] = "models/props_interiors/furniture_desk01a.mdl",
					[4] = "models/props_c17/furniturecouch002a.mdl",
					[5] = "models/props_c17/furniturecouch001a.mdl",
					[6] = "models/props_interiors/furniture_shelf01a.mdl",
					[7] = "models/props_interiors/furniture_lamp01a.mdl",
					[8] = "models/props_interiors/furniture_vanity01a.mdl",
					[9] = "models/props_interiors/furniture_chair01a.mdl",
					[10] = "models/props_interiors/furniture_chair03a.mdl",
					[11] = "models/props_combine/breendesk.mdl",
					[12] = "models/props_combine/breenchair.mdl",
					[13] = "models/props_c17/furniturecupboard001a.mdl",
					[14] = "models/props_c17/furnituredrawer001a.mdl",
					[15] = "models/props_c17/furniturechair001a.mdl",
					[16] = "models/props_c17/furnituredrawer003a.mdl",
					[17] = "models/props_c17/furnituredrawer003a.mdl",
					[18] = "models/props_c17/furnituredrawer002a.mdl",
					[19] = "models/props_c17/furnituretable001a.mdl",
					[20] = "models/props_c17/furnituretable003a.mdl",
					[21] = "models/props_c17/furnituretable002a.mdl"
					}
					local trash = {
					[1] = "models/props_junk/trashdumpster01a.mdl",
					[2] = "models/props_junk/trashdumpster02.mdl",
					[3] = "models/props_junk/trashbin01a.mdl",
					[4] = "models/props_trainstation/trashcan_indoor001b.mdl",
					[5] = "models/props_trainstation/trashcan_indoor001a.mdl",
					[6] = "models/props/cs_office/trash_can.mdl"
					}
					local crate = {
					[1] = "models/props_junk/wood_crate002a.mdl",
					[2] = "models/props_junk/wood_crate001a.mdl",
					[3] = "models/props_junk/wood_crate001a_damaged.mdl",
					[4] = "models/items/item_item_crate.mdl",
					[5] = "models/items/ammocrate_ar2.mdl",
					[6] = "models/items/ammocrate_grenade.mdl",
					[7] = "models/items/ammocrate_smg1.mdl",
					[8] = "models/items/ammocrate_rockets.mdl"
					}
					local box = {
					[1] = "models/props_junk/cardboard_box001a.mdl",
					[2] = "models/props_junk/cardboard_box002a.mdl",
					[3] = "models/props_junk/cardboard_box003a.mdl",
					[4] = "models/props_junk/cardboard_box001b.mdl",
					[5] = "models/props_junk/cardboard_box002b.mdl",
					[6] = "models/props_junk/cardboard_box003b.mdl",
					[7] = "models/props/cs_assault/dryer_box2.mdl",
					[8] = "models/props/cs_assault/dryer_box.mdl"
					}
					local healthitems = {
					[1] = "item_healthcharger",
					[2] = "item_healthkit",
					[3] = "item_healthvial"
					}
					local armoritems = {
					[1] = "item_battery",
					[2] = "item_suitcharger",
					}
					local ammoitems = {
					[1] = "item_ammo_357",
					[2] = "item_ammo_ar2",
					[3] = "item_ammo_ar2_altfire",
					[4] = "item_ammo_crossbow",
					[5] = "item_ammo_pistol",
					[6] = "item_ammo_smg1",
					[7] = "item_ammo_smg1_grenade",
					[8] = "item_rpg_round",
					[9] = "item_box_buckshot"
					}

					local m9kammoitems = {
					[1] = "m9k_ammo_buckshot",
					[2] = "m9k_ammo_pistol",
					[3] = "m9k_ammo_ar2",
					[4] = "m9k_ammo_smg",
					[5] = "m9k_ammo_sniper_round",
					[6] = "m9k_ammo_winchester",
					[7] = "m9k_ammo_357"
					}

					local class = {
					[1] = "item_*",
					[2] = "prop_physics*",
					[3] = "func_door_rotating*",
					[4] = "npc_*",
					[5] = "m9k_ammo_*",
					[6] = "tfa_ammo_*"
					}

					local distance = 1000
					local kdot = 20
					for k,v in pairs (ents.FindByClass(class[1])) do 
					local directionAng = math.pi / 8
					local aimvector = p:GetAimVector()
					local entVector = v:GetPos() - p:GetShootPos()
					local dot = aimvector:Dot( entVector ) / entVector:Length()
					local name = "Unidentified"

					local tr = util.TraceLine( {
						start = EyePos(),
						endpos = v:GetPos(),
						filter = function( ent ) if ( ent:GetClass() == class[1] ) then return true end end	
					} )

					if v:GetClass() == ammoitems[1]
					or v:GetClass() == ammoitems[2] 
					or v:GetClass() == ammoitems[3] 
					or v:GetClass() == ammoitems[4] 
					or v:GetClass() == ammoitems[5]
					or v:GetClass() == ammoitems[6]
					or v:GetClass() == ammoitems[7]
					or v:GetClass() == ammoitems[8] 
					or v:GetClass() == ammoitems[9] then
						name = "Ammo"
					elseif v:GetClass() == healthitems[1] 
					or v:GetClass() == healthitems[2] then
						name = "HP"
					elseif v:GetClass() == armoritems[1] 
					or v:GetClass() == armoritems[2] then
						name = "AR"
					end

					if v:IsValid() and dot/(2.77-kdot/10) > directionAng then
						local x1,y1,x2,y2 = GetCoordinates(v)
						if x1 < 50 then 
						x1 = 50
						end
						if x2 > ScrW()-50 then 
						x2 = ScrW()-50
						end
						if y1 < 50 then 
						y1 = 50
						end
						if y2 > ScrH()-40 then 
						y2 = ScrH()- 40
						end

						if IsEntity(v) and tr.HitWorld == false and y2 - y1 > 40 and x2-x1 > surface.GetTextSize(name)+10 then
							if p:GetPos():Distance(v:GetPos()) < distance then 
							
								if v:GetClass() == ammoitems[1]
								or v:GetClass() == ammoitems[2] 
								or v:GetClass() == ammoitems[3] 
								or v:GetClass() == ammoitems[4] 
								or v:GetClass() == ammoitems[5]
								or v:GetClass() == ammoitems[6]
								or v:GetClass() == ammoitems[7]
								or v:GetClass() == ammoitems[8] 
								or v:GetClass() == ammoitems[9] 
								or v:GetClass() == healthitems[1] 
								or v:GetClass() == healthitems[2] 
								or v:GetClass() == armoritems[1] 
								or v:GetClass() == armoritems[2]  then
								draw.DrawText(name, "zejton18", x1 + 5 , y1 - 13, orange, 0)
								end	
								
								
								if v:GetClass() == healthitems[1] 
								or v:GetClass() == healthitems[2] 
								or v:GetClass() == healthitems[3] then
								surface.SetDrawColor(100,250,100,opacity2)
								elseif v:GetClass() == armoritems[1] 
								or v:GetClass() == armoritems[2] then 
								surface.SetDrawColor(80,200,250,opacity2)
								elseif v:GetClass() == "item_suit" then
								surface.SetDrawColor(r,g,b, opacity2) 
								draw.DrawText("Suit", "zejton18", x1 + 5.5 , y1 - 13.5, orange, 0)
								elseif v:GetClass() == ammoitems[1]
								or v:GetClass() == ammoitems[2] 
								or v:GetClass() == ammoitems[3] 
								or v:GetClass() == ammoitems[4] 
								or v:GetClass() == ammoitems[5]
								or v:GetClass() == ammoitems[6]
								or v:GetClass() == ammoitems[7]
								or v:GetClass() == ammoitems[8] 
								or v:GetClass() == ammoitems[9] then
								surface.SetDrawColor(250,250,140, opacity2)
								end
								
								if v:GetClass() == healthitems[1] 
								or v:GetClass() == healthitems[2] 
								or v:GetClass() == healthitems[3] 
								or v:GetClass() == armoritems[1] 
								or v:GetClass() == armoritems[2] 
								or v:GetClass() == ammoitems[1]
								or v:GetClass() == ammoitems[2] 
								or v:GetClass() == ammoitems[3] 
								or v:GetClass() == ammoitems[4] 
								or v:GetClass() == ammoitems[5]
								or v:GetClass() == ammoitems[6]
								or v:GetClass() == ammoitems[7]
								or v:GetClass() == ammoitems[8] 
								or v:GetClass() == ammoitems[9] 
								or v:GetClass() == "item_suit" then
								surface.DrawLine(x1,y1+4,x1,y1 - 18)
								surface.DrawLine(x1,y1-18,x1+20,y1-18)
								surface.DrawLine(x2,y1+4,x2,y1 - 18)
								surface.DrawLine(x2,y1-18,x2-20,y1-18)
								surface.DrawLine(x1,y2+4,x1,y2 - 18)
								surface.DrawLine(x2,y2+5,x2-20,y2+5)
								surface.DrawLine(x2,y2+4,x2,y2 - 18)
								surface.DrawLine(x1,y2+5,x1+20,y2+5)
								end
							end
						end
					end
				end

				for k,v in pairs (ents.FindByClass(class[2])) do 
					local directionAng = math.pi / 8
					local aimvector = p:GetAimVector()
					local entVector = v:GetPos() - p:GetShootPos()
					local dot = aimvector:Dot( entVector ) / entVector:Length()
					local name = "Unidentified"
					local tr = util.TraceLine( {
						start = EyePos(),
						endpos = v:GetPos(),
						filter = function( ent ) if ( ent:GetClass() == class[2] ) then return true end end	
					} )
					if v:GetModel() == barrel[1]
					or v:GetModel() == barrel[2] then
						name = "Barrel"
					elseif v:GetModel() == statue[1]
					or v:GetModel() == statue[2] 
					or v:GetModel() == statue[3] 
					or v:GetModel() == statue[4] then
						name = "Statue"
					elseif v:GetModel() == crate[5]
					or v:GetModel() == crate[6]
					or v:GetModel() == crate[7]
					or v:GetModel() == crate[8] then
						name = "Crate"
					elseif v:GetModel() == trash[1]
					or v:GetModel() == trash[2] 
					or v:GetModel() == trash[3]
					or v:GetModel() == trash[4] 
					or v:GetModel() == trash[5] 
					or v:GetModel() == trash[6] then
						name = "Trash"
					elseif v:GetModel() == box[7]
					or v:GetModel() == box[8] then
						name = "Box"
					elseif v:GetModel() == crate[1]
					or v:GetModel() == crate[2] 
					or v:GetModel() == crate[3] 
					or v:GetModel() == crate[4]
					or v:GetModel() == box[1]
					or v:GetModel() == box[2]
					or v:GetModel() == box[3]
					or v:GetModel() == box[4]
					or v:GetModel() == box[5]
					or v:GetModel() == box[6]
					or v:GetModel() == "models/props_junk/wood_pallet001a.mdl"  then
						name = "Destroyable"
					elseif v:GetModel() == "models/props_c17/oildrum001_explosive.mdl" 
					or v:GetModel() == "models/props_junk/gascan001a.mdl" 
					or v:GetClass() == "grenade_helicopter" then
						name = "Explosive"
					elseif v:GetClass() == "npc_civ" then
						name = "Citizen"
					elseif v:GetModel() == "models/props_trainstation/trainstation_clock001.mdl" 
					or v:GetModel() == "models/props/de_nuke/clock.mdl" then
						name = "Time: " ..os.date( "%H:%M" ,os.time())
					elseif v:GetModel() == "models/props_lab/citizenradio.mdl" 
					or v:GetModel() == "models/props/cs_office/radio.mdl" then
						name = "Radio"
					elseif v:GetModel() == "models/props_interiors/pot01a.mdl"
					or v:GetModel() == "models/props_interiors/pot02a.mdl" then
						name = "Pot"
					end
					if v:IsValid() and dot/(2.77-kdot/10) > directionAng then
						local x1,y1,x2,y2 = GetCoordinates(v)
						if x1 < 50 then 
						x1 = 50
						end
						if x2 > ScrW()-50 then 
						x2 = ScrW()-50
						end
						if y1 < 50 then 
						y1 = 50
						end
						if y2 > ScrH()-40 then 
						y2 = ScrH()- 40
						end
						if IsEntity(v) and tr.HitWorld == false and y2 - y1 > 40 and x2-x1 > surface.GetTextSize(name)+10 then
							if p:GetPos():Distance(v:GetPos()) < distance/1.2 then
								if v:GetModel() == barrel[1]
								or v:GetModel() == barrel[2]
								or v:GetModel() == statue[1]
								or v:GetModel() == statue[2] 
								or v:GetModel() == statue[3] 
								or v:GetModel() == statue[4]	
								or v:GetModel() == crate[5]
								or v:GetModel() == crate[6]
								or v:GetModel() == crate[7]
								or v:GetModel() == crate[8] 
								or v:GetModel() == trash[1]
								or v:GetModel() == trash[2] 
								or v:GetModel() == trash[3]
								or v:GetModel() == trash[4] 
								or v:GetModel() == trash[5] 
								or v:GetModel() == trash[6] 
								or v:GetModel() == box[7]
								or v:GetModel() == box[8] 
								or v:GetModel() == "models/props_lab/citizenradio.mdl" 
								or v:GetModel() == "models/props/cs_office/radio.mdl" 
								or v:GetModel() == "models/props_interiors/pot01a.mdl"
								or v:GetModel() == "models/props_interiors/pot02a.mdl" then
								draw.DrawText(name, "zejton18", x1 + 5 , y1 - 13, orange, 0)
								elseif v:GetModel() == "models/props/de_nuke/clock.mdl" 
								or v:GetModel() == "models/props_trainstation/trainstation_clock001.mdl" then
								draw.DrawText("Clock", "zejton18", x1 + 5 , y1 - 13, orange, 0)
								draw.DrawText(name, "zejton18", x2 - 7.5 , y2 - 18, orange, 2)
								elseif v:GetModel() == box[1]
								or v:GetModel() == box[2]
								or v:GetModel() == box[3]
								or v:GetModel() == box[4]
								or v:GetModel() == box[5]
								or v:GetModel() == box[6] then 
								draw.DrawText("Box", "zejton18", x1 + 5 , y1 - 13, orange, 0)
								elseif v:GetModel() == crate[1]
								or v:GetModel() == crate[2] 
								or v:GetModel() == crate[3] 
								or v:GetModel() == crate[4] then
								draw.DrawText("Crate", "zejton18", x1 + 5 , y1 - 13, orange, 0)
								end	
								
								if v:GetModel() == crate[1]
								or v:GetModel() == crate[2] 
								or v:GetModel() == crate[3] 
								or v:GetModel() == crate[4]
								or v:GetModel() == box[1]
								or v:GetModel() == box[2]
								or v:GetModel() == box[3]
								or v:GetModel() == box[4]
								or v:GetModel() == box[5]
								or v:GetModel() == box[6]
								or v:GetModel() == "models/props_junk/wood_pallet001a.mdl"  then
								draw.DrawText(name, "zejton18", x2 - 7.5 , y2 - 18, warningred, 2)
								elseif v:GetModel() == "models/props_c17/oildrum001_explosive.mdl" 
								or v:GetModel() == "models/props_junk/gascan001a.mdl" then
								draw.DrawText(name, "zejton18", x1 + 5.5 , y1 - 13.5, warningred, 0)		
								end
								
								surface.SetDrawColor(orange) 
								
								if v:GetModel() == barrel[1]
								or v:GetModel() == barrel[2]
								or v:GetModel() == statue[1]
								or v:GetModel() == statue[2] 
								or v:GetModel() == statue[3] 
								or v:GetModel() == statue[4] 
								or v:GetModel() == crate[1]
								or v:GetModel() == crate[2] 
								or v:GetModel() == crate[3] 
								or v:GetModel() == crate[4]
								or v:GetModel() == crate[5] 
								or v:GetModel() == crate[6]
								or v:GetModel() == crate[7]
								or v:GetModel() == crate[8] 
								or v:GetModel() == box[1]
								or v:GetModel() == box[2]
								or v:GetModel() == box[3]
								or v:GetModel() == box[4]
								or v:GetModel() == box[5]
								or v:GetModel() == box[6]
								or v:GetModel() == box[7]
								or v:GetModel() == box[8]
								or v:GetModel() == trash[1]
								or v:GetModel() == trash[2] 
								or v:GetModel() == trash[3]
								or v:GetModel() == trash[4] 
								or v:GetModel() == trash[5]
								or v:GetModel() == trash[6]
								or v:GetModel() == "models/props/cs_assault/money.mdl"
								or v:GetModel() == "models/props_interiors/pot01a.mdl"
								or v:GetModel() == "models/props_interiors/pot02a.mdl"
								or v:GetModel() == "models/props_trainstation/trainstation_clock001.mdl"
								or v:GetModel() == "models/props/de_nuke/clock.mdl"
								or v:GetModel() == "models/props_lab/citizenradio.mdl"
								or v:GetModel() == "models/props/cs_office/radio.mdl"
								or v:GetModel() == "models/airboat.mdl"
								or v:GetModel() == "models/buggy.mdl" 
								or v:GetModel() == "models/props_junk/wood_pallet001a.mdl" 
								or v:GetModel() == "models/props_c17/oildrum001_explosive.mdl" 
								or v:GetModel() == "models/props_junk/gascan001a.mdl" then
								surface.DrawLine(x1,y1+4,x1,y1 - 18)
								surface.DrawLine(x1,y1-18,x1+20,y1-18)
								surface.DrawLine(x2,y1+4,x2,y1 - 18)
								surface.DrawLine(x2,y1-18,x2-20,y1-18)
								surface.DrawLine(x1,y2+4,x1,y2 - 18)
								surface.DrawLine(x2,y2+5,x2-20,y2+5)
								surface.DrawLine(x2,y2+4,x2,y2 - 18)
								surface.DrawLine(x1,y2+5,x1+20,y2+5)
								end
							end
						end
					end
				end

				for k,v in pairs (ents.FindByClass(class[5])) do -- M9K Ammo
					local directionAng = math.pi / 8
					local aimvector = p:GetAimVector()
					local entVector = v:GetPos() - p:GetShootPos()
					local dot = aimvector:Dot( entVector ) / entVector:Length()
					local name = "Unidentified"
					local tr = util.TraceLine( {
						start = EyePos(),
						endpos = v:GetPos(),
						filter = function( ent ) if ( ent:GetClass() == class[5] ) then return true end end	
					} )
					if v:IsValid() and dot/(2.77-kdot/10) > directionAng and v != LocalPlayer():GetWeapons() then
					local x1,y1,x2,y2 = GetCoordinates(v)
					if x1 < 50 then 
					x1 = 50
					end
					if x2 > ScrW()-50 then 
					x2 = ScrW()-50
					end
					if y1 < 50 then 
					y1 = 50
					end
					if y2 > ScrH()-40 then 
					y2 = ScrH()- 40
					end
						if IsEntity(v) and tr.HitWorld == false and y2 - y1 > 40 and x2-x1 > surface.GetTextSize(name)+10 then
							if p:GetPos():Distance(v:GetPos()) < distance then
								draw.DrawText("Ammo", "zejton18", x1 + 5 , y1 - 13, orange, 0)
								surface.SetDrawColor(250,250,140, opacity2)
								surface.DrawLine(x1,y1+4,x1,y1 - 18)
								surface.DrawLine(x1,y1-18,x1+20,y1-18)
								surface.DrawLine(x2,y1+4,x2,y1 - 18)
								surface.DrawLine(x2,y1-18,x2-20,y1-18)
								surface.DrawLine(x1,y2+4,x1,y2 - 18)
								surface.DrawLine(x2,y2+5,x2-20,y2+5)
								surface.DrawLine(x2,y2+4,x2,y2 - 18)
								surface.DrawLine(x1,y2+5,x1+20,y2+5)
							end
						end
					end
					end
					for k,v in pairs (ents.FindByClass(class[6])) do -- TFA Ammo
					local directionAng = math.pi / 8
					local aimvector = p:GetAimVector()
					local entVector = v:GetPos() - p:GetShootPos()
					local dot = aimvector:Dot( entVector ) / entVector:Length()
					local name = "Unidentified"
					local tr = util.TraceLine( {
						start = EyePos(),
						endpos = v:GetPos(),
						filter = function( ent ) if ( ent:GetClass() == class[6] ) then return true end end	
					} )
					if v:IsValid() and dot/(2.77-kdot/10) > directionAng and v != LocalPlayer():GetWeapons() then
					local x1,y1,x2,y2 = GetCoordinates(v)
					if x1 < 50 then 
					x1 = 50
					end
					if x2 > ScrW()-50 then 
					x2 = ScrW()-50
					end
					if y1 < 50 then 
					y1 = 50
					end
					if y2 > ScrH()-40 then 
					y2 = ScrH()- 40
					end
						if IsEntity(v) and tr.HitWorld == false and y2 - y1 > 40 and x2-x1 > surface.GetTextSize(name)+10 then
							if p:GetPos():Distance(v:GetPos()) < distance then
								draw.DrawText("Ammo", "zejton18", x1 + 5 , y1 - 13, orange, 0)
								surface.SetDrawColor(250,250,140, opacity2)
								surface.DrawLine(x1,y1+4,x1,y1 - 18)
								surface.DrawLine(x1,y1-18,x1+20,y1-18)
								surface.DrawLine(x2,y1+4,x2,y1 - 18)
								surface.DrawLine(x2,y1-18,x2-20,y1-18)
								surface.DrawLine(x1,y2+4,x1,y2 - 18)
								surface.DrawLine(x2,y2+5,x2-20,y2+5)
								surface.DrawLine(x2,y2+4,x2,y2 - 18)
								surface.DrawLine(x1,y2+5,x1+20,y2+5)
							end
						end
					end
				end

				for k,v in pairs(ents.FindByClass(class[4]) ) do
					local directionAng = math.pi / 8
					local aimvector = p:GetAimVector()
					local entVector = v:GetPos() - p:GetShootPos()
					local dot = aimvector:Dot( entVector ) / entVector:Length()
					local tr = util.TraceLine( {
						start = EyePos(),
						endpos = v:GetPos(),
						filter = function( ent ) if ( ent:GetClass() == class[4] ) then return true end end	
					} )
					if v:IsValid() and dot/(2.77-kdot/10) > directionAng then
						local x1,y1,x2,y2 = GetCoordinates(v)
						if x1 < 50 then 
						x1 = 50
						end
						if x2 > ScrW()-50 then 
						x2 = ScrW()-50
						end
						if y1 < 50 then 
						y1 = 50
						end
						if y2 > ScrH()-40 then 
						y2 = ScrH()- 40
						end
						local name = "Unidentified"
						if IsEnemyEntityName(v:GetClass()) == true then
							name = ""
						elseif IsFriendEntityName(v:GetClass()) == true then
							name = ""
						else
							name = ""
						end
						if v:IsNPC() and tr.HitWorld == false and y2 - y1 > 40 and x2-x1 > surface.GetTextSize(name)+10 and x2-x1 > surface.GetTextSize(v:Health().."HP")+10 then
							if p:GetPos():Distance(v:GetPos()) <  distance/1.2  then
								if IsEnemyEntityName(v:GetClass()) == true then
									draw.DrawText("", "zejton18", x1 + 5 , y1 - 13, Color(180,0,0), 0)
									draw.DrawText("BIOTIC", "zejton18", x2 - 7.5 , y2 - 18, Color(180,0,0), 2)
								
									surface.SetDrawColor(Color(180,0,0))
									surface.DrawLine(x1,y1+4,x1,y1 - 18)
									surface.DrawLine(x1,y1-18,x1+20,y1-18)
									surface.DrawLine(x2,y1+4,x2,y1 - 18)
									surface.DrawLine(x2,y1-18,x2-20,y1-18)
									surface.DrawLine(x1,y2+4,x1,y2 - 18)
									surface.DrawLine(x2,y2+5,x2-20,y2+5)
									surface.DrawLine(x2,y2+4,x2,y2 - 18)
									surface.DrawLine(x1,y2+5,x1+20,y2+5)
								end
							end
						end
					end
				end

				CombineJobs = {
					[TEAM_OTA_Grunt] = true,
					[TEAM_OTA_Suppressor] = true,
					[TEAM_OTA_Hammer] = true,
					[TEAM_OTA_Ordinal] = true,
					[TEAM_OTA_Soldier] = true,
					[TEAM_OTA_Striker] = true,
					[TEAM_OTA_Razor] = true,
					[TEAM_OTA_Assassin] = true,
					[TEAM_OTA_Tech] = true,
					[TEAM_OTA_Commander] = true,
					[TEAM_OTA_Elite] = true,
					[TEAM_OTA_Crypt] = true,
					[TEAM_SYNTH_CREMATOR] = true,
					[TEAM_SYNTH_GUARD] = true,
					[TEAM_OTA_Broken] = true,
				}

				for k,v in pairs (players or player.GetAll()) do
					local directionAng = math.pi / 8
					local aimvector = p:GetAimVector()
					local entVector = v:GetPos() - p:GetShootPos()
					local dot = aimvector:Dot( entVector ) / entVector:Length()
					local tr = util.TraceLine( {
						start = EyePos(),
						endpos = v:GetPos(),
						filter = function( ent ) if ( ent:GetClass() == "players" ) then return true end end	
					} )
					if v:IsValid() then
						local x1,y1,x2,y2 = GetCoordinates(v)

						if v:IsPlayer() and tr.HitWorld == false and v != p and y2 - y1 > 40 then
							
							if p:GetPos():Distance(v:GetPos()) < distance/2 then

								if !v:isCP() and v:Team() != TEAM_REBELSPY01 and FaceMemory_Check(v) then

									if x2-x1 > surface.GetTextSize(v:Name())+10 then
										draw.DrawText(v:Name(), "marske4", x1 + 5 , y1 - 13, orange, 0)
										draw.DrawText("ОЛ: " .. v:GetNWInt("LoyaltyTokens"), "marske4", x1 + 5 , y1  + 5, orange, 0)
									end

									surface.SetDrawColor(main)
									surface.DrawLine(x1,y1+4,x1,y1 - 18)
									surface.DrawLine(x1,y1-18,x1+20,y1-18)
									surface.DrawLine(x2,y1+4,x2,y1 - 18)
									surface.DrawLine(x2,y1-18,x2-20,y1-18)
									surface.DrawLine(x1,y2+4,x1,y2 - 18)
									surface.DrawLine(x2,y2+5,x2-20,y2+5)
									surface.DrawLine(x2,y2+4,x2,y2 - 18)
									surface.DrawLine(x1,y2+5,x1+20,y2+5)

								elseif v:isCP() or v:Team() == TEAM_REBELSPY01 then

									if x2-x1 > surface.GetTextSize(v:Name()) - 50 then
										draw.DrawText(v:Name(), "marske2.5", x1 + 5 , y1 - 13, Color(125,125,195), 0)
										draw.DrawText("Rank: " .. v:GetNWInt("Player_CombineRank"), "marske2.5", x1 + 5 , y1  - 5, Color(125,125,195), 0)
									end
									if x2-x1 > surface.GetTextSize(v:Name()) - 50 and CombineJobs[v:Team()] then
										draw.DrawText("Stimdose: " .. v:Health(), "marske2.5", x2 -70 , y2 - 15, Color(125,125,195), 0)
										draw.DrawText("Shield: " .. v:Armor(), "marske2.5", x2 -70 , y2 - 5, Color(125,125,195), 0)
									end
									
									surface.SetDrawColor(Color(125,125,195))
									surface.DrawLine(x1,y1+4,x1,y1 - 18)
									surface.DrawLine(x1,y1-18,x1+20,y1-18)
									surface.DrawLine(x2,y1+4,x2,y1 - 18)
									surface.DrawLine(x2,y1-18,x2-20,y1-18)
									surface.DrawLine(x1,y2+4,x1,y2 - 18)
									surface.DrawLine(x2,y2+5,x2-20,y2+5)
									surface.DrawLine(x2,y2+4,x2,y2 - 18)
									surface.DrawLine(x1,y2+5,x1+20,y2+5)

								elseif GAMEMODE.ZombieJobs[v:Team()] then

									if x2-x1 > surface.GetTextSize("no data")+10 then
										draw.DrawText("no data", "marske4", x1 + 5 , y1 - 13, Color(180,0,0), 0)
									end
									
									surface.SetDrawColor(Color(180,0,0))
									surface.DrawLine(x1,y1+4,x1,y1 - 18)
									surface.DrawLine(x1,y1-18,x1+20,y1-18)
									surface.DrawLine(x2,y1+4,x2,y1 - 18)
									surface.DrawLine(x2,y1-18,x2-20,y1-18)
									surface.DrawLine(x1,y2+4,x1,y2 - 18)
									surface.DrawLine(x2,y2+5,x2-20,y2+5)
									surface.DrawLine(x2,y2+4,x2,y2 - 18)
									surface.DrawLine(x1,y2+5,x1+20,y2+5)

								elseif v:Team() != TEAM_ADMINISTRATOR and v:Team() != TEAM_GMAN and v:IsPlayer() then
									if x2-x1 > surface.GetTextSize("no data")+10 then
										draw.DrawText("no data", "marske4", x1 + 5 , y1 - 13, orange, 0)
									end
									
									surface.SetDrawColor(orange)
									surface.DrawLine(x1,y1+4,x1,y1 - 18)
									surface.DrawLine(x1,y1-18,x1+20,y1-18)
									surface.DrawLine(x2,y1+4,x2,y1 - 18)
									surface.DrawLine(x2,y1-18,x2-20,y1-18)
									surface.DrawLine(x1,y2+4,x1,y2 - 18)
									surface.DrawLine(x2,y2+5,x2-20,y2+5)
									surface.DrawLine(x2,y2+4,x2,y2 - 18)
									surface.DrawLine(x1,y2+5,x1+20,y2+5)

								end
							end
						end
					end
				end
			end--End of ent. display


			-- Crosshair and ammo --
			if GetConVarNumber( "hud_ammofade" ) == 1 then
				if p:KeyDown(IN_ATTACK) or p:KeyDown(IN_RELOAD) then
					wepopacity = Lerp(FrameTime(), wepopacity, 120000)
				else
					wepopacity = Lerp(FrameTime()*3, wepopacity, 0)
				end
			elseif health < 75 and GetConVarNumber( "hud_flick" ) == 1 then
				wepopacity = alpha2
			else
				wepopacity = 230
			end

			local ammo = Color(r, g, b, wepopacity) 

			if wep:IsValid() then

				if wep:GetClass() == "weapon_rpg" then
					cam.Start3D()
						cam.Start3D2D(shootPos + forward*20 + right*(-14.5+ammoright) + up*(15.5+ammoup),angle,0.03+(size3d2d/500))
							if p:GetAmmoCount(wep:GetPrimaryAmmoType()) >= 1 then 
								draw.DrawText("РАКЕТЫ: ".. p:GetAmmoCount(wep:GetPrimaryAmmoType()),"zejton30",cx+90+position,cy+position,ammo,1)
							else
								draw.DrawText("НЕТ РАКЕТ","zejton30",cx+90+position,cy+position,warningred,1)
							end
						cam.End3D2D()
					cam.End3D()
					return
				end
				
				if GetConVarNumber("hud_cross") == 1 then
					if wep:GetClass() == "weapon_bugbait"
					or wep:GetClass() == "weapon_physcannon" then
						draw.RoundedBox(3,cx+position-1.5, cy+position-1.85, 4, 4, main )
					elseif wep:GetClass() == "combineidcard"
					or wep:GetClass() == "citizenidcard"
					or wep:GetClass() == "medicalcard"
					or wep:GetClass() == "weapon_controllable_city_scanner" then
					else
						draw.RoundedBox(3,cx+position-1.5, cy+position-1.85, 4, 4, Color(r,g,b,crossopacity))
					end
				end--End of crosshair
				if GetConVar("rised_HUD_Ammo_enable"):GetBool() and (wep:Clip1() > 0 or wep:GetClass() == "sfw_pandemic" or wep:GetClass() == "weapon_synth_cremator") then
					if p:KeyDown(IN_ATTACK2) == false 
					and wep:GetClass() != "sfw_pandemic" 
					and wep:GetClass() != "sfw_eblade" 
					and wep:GetClass() != doom3na[1]	
					and wep:GetClass() != doom3na[2]
					and wep:GetClass() != doom3na[3]
					and wep:GetClass() != doom3na[4]
					or wep:GetClass() == "sfw_alchemy" 
					or wep:GetClass() == "weapon_ar2" 
					or wep:GetClass() == "weapon_357" 
					or wep:GetClass() == "weapon_crossbow" 
					or wep:GetClass() == "weapon_pistol" 
					or wep:GetClass() == "weapon_shotgun" 
					or wep:GetClass() == "weapon_smg1" 
					or wep:GetClass() == doom3a[1]
					or wep:GetClass() == doom3a[2]
					or wep:GetClass() == doom3a[3]
					or wep:GetClass() == doom3a[4] 
					or wep:GetClass() == doom3a[5] then
						cam.Start3D()
							if GetConVarNumber("hud_ammodesign") == 1 then
							cam.Start3D2D( shootPos + (forward * 160)  + ( right * (145-(stright*15)) ) + (up * (-70+(stup*10))) , angle2, 0.2+(size3d2d/100))
								surface.SetFont("zejton30")
								if wep:Clip1() != -1 then
									if wep:Clip1() <= wep:GetMaxClip1()/2 then
										draw.DrawText(wep:Clip1(),"zejton50",240 - select(1,surface.GetTextSize(p:GetAmmoCount(wep:GetPrimaryAmmoType()))) + position,50+position,warningred,2)
									else
										draw.DrawText(wep:Clip1(),"zejton50",240 - select(1,surface.GetTextSize(p:GetAmmoCount(wep:GetPrimaryAmmoType())))+ position,50+position,ammo,2)
									end
								end
								if wep.FireModeDisplay != nil then
									draw.DrawText(wep.FireModeDisplay,"zejton30",340 - select(1,surface.GetTextSize(p:GetAmmoCount(wep:GetPrimaryAmmoType())))+ position,100+position,ammo,2)
								end
								if p:GetWeapon( "weapon_frag" ):IsValid() and GetConVarNumber("hud_grenade") == 1 then
								surface.SetDrawColor(ammo)
								surface.SetMaterial(Grenades)
								surface.DrawTexturedRect(position + 150 - select(1,surface.GetTextSize(wep:Clip1())) , 66+position, 24, 24)
								draw.DrawText(p:GetAmmoCount(p:GetWeapon("weapon_frag"):GetPrimaryAmmoType()),"zejton30",150+position-select(1,surface.GetTextSize(wep:Clip1())),65+position,ammo,2)
								end
								draw.DrawText(p:GetAmmoCount(wep:GetPrimaryAmmoType()),"zejton30",250+position,45+position,ammo,2)
							cam.End3D2D()
							elseif GetConVarNumber("hud_ammodesign") == 2 then
							cam.Start3D2D( shootPos + forward * 12.5 + ( right * (10 - (ammoright*0.95))) + up * ammoup , angle, 0.02+(size3d2d/1000))
								if wep:Clip1() <= wep:GetMaxClip1()/2 then					
									draw.DrawText(wep:Clip1(),"zejton40",40+position, position, warningred,1 )
								else
									draw.DrawText(wep:Clip1(),"zejton40",40+position, position, ammo,1 )
								end
								draw.DrawText(p:GetAmmoCount(wep:GetPrimaryAmmoType()),"zejton30",40+position, 40+position, ammo,1)
							cam.End3D2D()
							cam.Start3D2D( shootPos + forward * 12.5 + ( right * (2 - (grenaderight*0.95))) + up * (-3.5+grenadeup) , angle, 0.02+(size3d2d/1000))
								if p:GetWeapon( "weapon_frag" ):IsValid() and GetConVarNumber("hud_grenade") == 1 then
									surface.SetDrawColor(ammo)
									surface.SetMaterial(Grenades)
									if p:GetAmmoCount(wep:GetSecondaryAmmoType()) <= 0 then
										draw.DrawText(p:GetAmmoCount(p:GetWeapon("weapon_frag"):GetPrimaryAmmoType()),"zejton40",100+position,65+position,ammo,2)
										surface.DrawTexturedRect(100+position  , 68+position, 30, 30)
									else
										draw.DrawText(p:GetAmmoCount(p:GetWeapon("weapon_frag"):GetPrimaryAmmoType()),"zejton40",100+position,20+position,ammo,2)
										surface.DrawTexturedRect(100+position  , 23+position, 30, 30)
										draw.DrawText("ALT: "..p:GetAmmoCount(wep:GetSecondaryAmmoType()),"zejton40",150+position,65+position,ammo,2)
									end
								elseif p:GetAmmoCount(wep:GetSecondaryAmmoType()) > 0 and GetConVarNumber("hud_grenade") == 0 or !(p:GetWeapon( "weapon_frag" ):IsValid()) and p:GetAmmoCount(wep:GetSecondaryAmmoType()) > 0 then
									draw.DrawText("ALT: "..p:GetAmmoCount(wep:GetSecondaryAmmoType()),"zejton40",150+position,65+position,ammo,2)
								end
							cam.End3D2D()
							end
						cam.End3D()				
					elseif p:KeyDown(IN_ATTACK2) == true and !(p:KeyDown(IN_SPEED))
					and wep:GetClass() != "sfw_pandemic" 
					and wep:GetClass() != "sfw_alchemy" 
					and wep:GetClass() != "weapon_rpg" 
					and wep:GetClass() != "weapon_ar2"  
					and wep:GetClass() != "weapon_357"  
					and wep:GetClass() != "weapon_pistol"  
					and wep:GetClass() != "weapon_shotgun" 
					and wep:GetClass() != "weapon_smg1" 
					and wep:GetClass() != "weapon_rpg" 
					and wep:GetClass() != "weapon_doom3_bfg"
					and wep:GetClass() != "weapon_doom3_chaingun"
					and wep:GetClass() != "weapon_doom3_machinegun"
					and wep:GetClass() != "weapon_doom3_plasmagun"
					and wep:GetClass() != "weapon_doom3_doublebarrel"
					and wep:GetClass() != "weapon_doom3_shotgun"
					and wep:GetClass() != "weapon_doom3_rocketlauncher"
					and wep:GetClass() != "weapon_doom3_grenade"
					and wep:GetClass() != "weapon_doom3_pistol"
					and wep:Clip1() != -1 and GetConVar("rised_HUD_Ammo_enable"):GetBool() then
						if wep:Clip1() <= wep:GetMaxClip1()/2 then			
							draw.DrawText(wep:Clip1(),"zejton60",cx+150+position,cy-20+position,Color(255,60,10, opacity1),0) 
						else
							draw.DrawText(wep:Clip1(),"zejton60",cx+150+position,cy-20+position,main,0)
						end						
					end
				elseif wep:GetClass() == "weapon_frag" and wep:IsValid() then
					cam.Start3D()
						cam.Start3D2D( shootPos + (forward * 160)  + ( right * (145-(stright*15)) ) + (up * (-70+(stup*10))) , angle2, 0.2+(size3d2d/100))
							surface.SetFont("zejton40")
							if p:GetAmmoCount(p:GetWeapon("weapon_frag"):GetPrimaryAmmoType()) > 0 then
								surface.SetDrawColor(ammo)
								draw.DrawText(p:GetAmmoCount(p:GetWeapon("weapon_frag"):GetPrimaryAmmoType()),"zejton40",160+position,66+position,ammo,2)
							else 
								surface.SetDrawColor(warningred2)
								draw.DrawText(p:GetAmmoCount(p:GetWeapon("weapon_frag"):GetPrimaryAmmoType()),"zejton40",160+position,66+position,warningred2,2)
							end
							surface.SetMaterial(Grenades)
							surface.DrawTexturedRect(position + 160  , 65+position, 34, 34)
						cam.End3D2D()
					cam.End3D()	
				end
			end --End of ammo counter
		end --End of "loading" function
		end --End of issuitequiped
	end --End of hudPaint()
	
	hook.Add("Think", "QuantumSmothThink", function()
		if LocalPlayer():Health() != health then
			health = Lerp( FrameTime()*2, health, LocalPlayer():Health() / (LocalPlayer():GetMaxHealth()/100))
		end
		if LocalPlayer():Armor() != armor then
			armor = Lerp( FrameTime()*2, armor, LocalPlayer():Armor())
		end
	end)
end