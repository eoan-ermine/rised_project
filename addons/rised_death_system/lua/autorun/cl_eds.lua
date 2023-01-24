-- "addons\\rised_death_system\\lua\\autorun\\cl_eds.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if SERVER then return end

AddCSLuaFile( "eds_config.lua" )
include( "eds_config.lua" )

local function IsJob(ply, jobs)  
	if(!IsValid(ply)) then return end
	if(table.HasValue(jobs, team.GetName(ply:Team()))) then
		return true
	end
	return false
end

hook.Add("CalcView","CorpseDeathCam",function(ply, pos, angles, fov)
	local Ent = GetViewEntity()
	if LocalPlayer():Health()>0 then return end
	if !IsValid(ClCorpse) then return end
	if Ent!=LocalPlayer() then return end
	local view = {}
	if(ClCorpse:LookupAttachment( "eyes" )==nil) then return end
	if ply:Team() == TEAM_RAT then return view end
	local head = ClCorpse:GetAttachment( ClCorpse:LookupAttachment( "eyes" ) )
	if head != nil then
		view.origin = head.Pos + head.Ang:Forward() * 1
		view.angles = head.Ang
		view.fov = fov
		view.znear = 0.5
	end
	return view
end)

local RagInfo = {}

net.Receive("SendRagInfo", function()
	RagInfo.corpse = net.ReadInt(32)
	RagInfo.ply = net.ReadInt(32)
	RagInfo.color = net.ReadVector()
end)

hook.Add("NetworkEntityCreated", "CorpseClientAttributes", function(Ent)
	if not RagInfo.corpse then return end
	if RagInfo.corpse==Ent:EntIndex() then
		if RagInfo.ply==LocalPlayer():EntIndex() then
			ClCorpse=Ent
		end
		local GetColor = RagInfo.color
		Entity(RagInfo.corpse).GetPlayerColor = function(self) return GetColor end
		RagInfo = {}
	end
end)

local function DeathEffect()
	local ply = LocalPlayer()
	if(!IsValid(ply)) then return end
	
	if(ply:Health()<=0) then
		-- draw.DrawText( EDS.text14, "DeathScreenFont", ScrW()/2, ScrH()/2-ScrH()/24, EDS.FontColorDeath, 1, 1 )
		-- if(math.Round(ply:GetNWInt('EDS.RespawnTime', 0), 0)>0) then
		-- draw.DrawText( EDS.text36..math.Round(ply:GetNWInt('EDS.RespawnTime', 0), 0)..EDS.text37, "DeathScreenFont2", ScrW()/2, ScrH()/2, EDS.FontColorDeath, 1, 1 )
		-- else
		-- draw.DrawText( EDS.text15, "DeathScreenFont2", ScrW()/2, ScrH()/2, EDS.FontColorDeath, 1, 1 )
		-- end
		-- return true
	end
end

local function HideDamageIndicator( hud )
	local ply = LocalPlayer()
	if(!IsValid(ply)) then return end
	if (hud == "CHudDamageIndicator" and ply:Health()<=0) then
		return false
	end
end

if(EDS.DeathEffects) then
	hook.Add("HUDPaint", "DeathScreen", DeathEffect)
	hook.Add("HUDShouldDraw", "HideDmgIndicator", HideDamageIndicator)
end

local function CorpseOutline(ent)
	if(!IsValid(ent)) then return end
	local entities = {}
	table.insert( entities, ent )
	halo.Add( entities, EDS.BodyOutlineColor, 2, 2, 2, true, false )
end

hook.Add("HUDPaint", "DrawInvestigation", function()
	ply = LocalPlayer()
	if(ply:GetNWInt('InvProgress', 0)>0) then
		draw.RoundedBox(5, ScrW()/2-ScrW()/12, ScrH()/2-ScrH()/40, ScrW()/6, ScrH()/20, EDS.BoxColor, 1, 1)
		draw.RoundedBox(0, ScrW()/2-ScrW()/12+6, ScrH()/2-ScrH()/40+6, ScrW()/6-12, ScrH()/20-12, EDS.BoxColor2, 1, 1)
		if(IsValid(ply)) then
			local MaxTime = 0
			
			if(IsJob(ply, EDS.MedicJobs) ) then MaxTime = EDS.MedicTime
			elseif(IsJob(ply, EDS.DetectiveJobs)) then MaxTime = EDS.DetectiveTime
			elseif(IsJob(ply, EDS.HoboJobs)) then MaxTime = EDS.HoboTime
			elseif(IsJob(ply, EDS.MafiaJobs)) then MaxTime = EDS.SetOnFireTime
			elseif(ply:isCP()) then MaxTime = EDS.CPTime
			else
				MaxTime = EDS.SetOnFireTime
			end

			mul = Lerp(FrameTime() * 10, mul, ply:GetNWInt('InvProgress', 1)/MaxTime)
			if(mul>1) then mul = 1 end
			
			if(ply:isCP() and EDS.PoliceCanIvestigate) then
				draw.DrawText( EDS.text23, "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/36, EDS.FontColor2, 1, 1 )
			elseif(IsJob(ply, EDS.MedicJobs) and EDS.MedicCanCleanup) then
				draw.DrawText( EDS.text24, "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/36, EDS.FontColor2, 1, 1 )		
			elseif(IsJob(ply, EDS.DetectiveJobs)) then
				draw.DrawText( EDS.text23, "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/36, EDS.FontColor2, 1, 1 )			
			elseif(IsJob(ply, EDS.MafiaJobs) and EDS.BossCanBurn) then
				draw.DrawText( EDS.text25, "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/36, EDS.FontColor2, 1, 1 )			
			elseif(IsJob(ply, EDS.HoboJobs) and EDS.CanHoboEat) then
				draw.DrawText( EDS.text26, "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/36, EDS.FontColor2, 1, 1 )	
			else
				if(ply:GetNWBool('EDS.CanFireUp', false)) then
					draw.DrawText( EDS.text25, "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/36, EDS.FontColor2, 1, 1 )	
				end
			end
			
			draw.RoundedBox(0, ScrW()/2-ScrW()/12+6, ScrH()/2-ScrH()/40+6, (ScrW()/6-12)*mul, ScrH()/20-12, EDS.StripeColor, 1, 1)
			surface.SetDrawColor( EDS.OutlineColor )
			surface.DrawOutlinedRect( ScrW()/2-ScrW()/12+6, ScrH()/2-ScrH()/40+6, ScrW()/6-12, ScrH()/20-12 )
		end
	else
		mul = 0
	end
end)

hook.Add("HUDPaint", "DrawCorpseDetails", function()
	if(!IsValid(LocalPlayer())) then return end
	local eye = LocalPlayer():GetEyeTrace()
	local ply = LocalPlayer()
	
	if(IsValid(eye.Entity)) then
		if(eye.Entity:GetClass()=="prop_ragdoll" and ply:Health()>0) then
			local ent = eye.Entity
			local is_static = ent:GetNWBool("Corpse_Static", false)
			local Attacker = ent:GetNWEntity( 'EDS.Attacker', null)
			local AttackerWeapon = ent:GetNWEntity( 'EDS.AttackerWeapon', null)
			local Victim = ent:GetNWEntity( 'EDS.Victim', null)
			if(ent:GetPos():Distance(ply:GetShootPos())<110 and ent:GetNWBool( 'EDS.UseableClient', false)) then
				if(EDS.EnableBodyOutline) then hook.Add("PreDrawHalos", "AddCorpseOutline", CorpseOutline(ent)) end
				if(ply:GetNWInt('InvProgress', 1)==0) then
				
					if(EDS.HidePlayerNames==false) then
						if((ply:isCP() and EDS.PoliceCanIvestigate) or IsJob(ply, EDS.DetectiveJobs)) then
							if ent:GetModel() == "models/dpfilms/metropolice/playermodels/pm_zombie_police.mdl" or ent:GetModel() == "models/player/zombie_fast.mdl" or ent:GetModel() == "models/player/zombine/combine_zombie.mdl" then
								return	
							end
							
							if(IsValid(Attacker)) then
								if(IsValid(Victim) and Attacker:IsPlayer() and Victim!=Attacker and !IsJob(Attacker, EDS.NotWantedJobs)) then
										if !is_static then
											draw.DrawText( EDS.text4, "i_like_dis_font", ScrW()/2, ScrH()/2+ScrH()/24, EDS.FontColor1, 1, 1 )
										end
									if !ent:GetNWBool( 'EDS.Investigated', false) then
										draw.DrawText( EDS.text41, "i_like_dis_font", ScrW()/2, ScrH()/2, EDS.FontColor2, 1, 1 )
										draw.DrawText( "\n"..EDS.text9, "i_like_dis_font", ScrW()/2, ScrH()/2+ScrH()/24, EDS.FontColor1, 1, 1 )
									else
										draw.DrawText( EDS.text38..Victim:Nick(), "i_like_dis_font", ScrW()/2, ScrH()/2.3, EDS.FontColor2, 1, 1 )
										draw.DrawText( EDS.text10, "i_like_dis_font", ScrW()/2, ScrH()/2.2, EDS.FontColor2, 1, 1 )
										if IsValid(AttackerWeapon) then
											draw.DrawText( EDS.text39..AttackerWeapon:GetPrintName(), "i_like_dis_font", ScrW()/2, ScrH()/2.1, EDS.FontColor2, 1, 1 )
										else
											draw.DrawText( EDS.text39.." неизвестно", "i_like_dis_font", ScrW()/2, ScrH()/2.1, EDS.FontColor2, 1, 1 )
										end
										--draw.DrawText( EDS.text40..Attacker:GetName(), "i_like_dis_font", ScrW()/2, ScrH()/1.92, EDS.FontColor2, 1, 1 )
									end
								elseif(IsValid(Victim) and !Attacker:IsPlayer() and Victim!=Attacker) then
									draw.DrawText( EDS.text6, "CorpseInspectFont", ScrW()/2, ScrH()/2, EDS.FontColor2, 1, 1 )
									if !is_static then
										draw.DrawText( EDS.text4, "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/24, EDS.FontColor1, 1, 1 )
									end
									if !ent:GetNWBool( 'EDS.Investigated', false) then
										draw.DrawText( "\n"..EDS.text9, "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/24, EDS.FontColor1, 1, 1 )
									end
								elseif(IsValid(Victim) and Victim==Attacker) then
									draw.DrawText( EDS.text7, "CorpseInspectFont", ScrW()/2, ScrH()/2, EDS.FontColor2, 1, 1 )
									if !is_static then
										draw.DrawText( EDS.text4, "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/24, EDS.FontColor1, 1, 1 )
									end
								else
									draw.DrawText( EDS.text8, "CorpseInspectFont", ScrW()/2, ScrH()/2, EDS.FontColor2, 1, 1 )
									if !is_static then
										draw.DrawText( EDS.text4, "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/24, EDS.FontColor1, 1, 1 )
									end
									if !ent:GetNWBool( 'EDS.Investigated', false) then
										draw.DrawText( "\n"..EDS.text9, "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/24, EDS.FontColor1, 1, 1 )
									end
								end
							else
								if (IsValid(Victim)) then
									draw.DrawText( EDS.text8, "CorpseInspectFont", ScrW()/2, ScrH()/2, EDS.FontColor2, 1, 1 )
									if !is_static then
										draw.DrawText( EDS.text4, "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/24, EDS.FontColor1, 1, 1 )
									end
									if !ent:GetNWBool( 'EDS.Investigated', false) and IsValid(Attacker) then
										draw.DrawText( "\n"..EDS.text9, "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/24, EDS.FontColor1, 1, 1 )
									end
								else
									draw.DrawText( EDS.text2, "CorpseInspectFont", ScrW()/2, ScrH()/2, EDS.FontColor2, 1, 1 )
									if !is_static then
										draw.DrawText( EDS.text4, "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/24, EDS.FontColor1, 1, 1 )
									end
									if !ent:GetNWBool( 'EDS.Investigated', false) and IsValid(Attacker) then
										draw.DrawText( "\n"..EDS.text9, "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/24, EDS.FontColor1, 1, 1 )
									end
								end
							end
						else
							if ent:GetModel() == "models/dpfilms/metropolice/playermodels/pm_zombie_police.mdl" or ent:GetModel() == "models/player/zombie_fast.mdl" or ent:GetModel() == "models/player/zombine/combine_zombie.mdl" then
								if ply:GetNWBool('EDS.CanFireUp', false) then
									draw.DrawText( EDS.text31, "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/24, EDS.FontColor1, 1, 1 ) return
								else
									return	
								end
							end
							
							if(IsValid(Victim)) then
								--draw.DrawText( "Тело "..Victim:GetName(), "CorpseInspectFont", ScrW()/2, ScrH()/2, EDS.FontColor2, 1, 1 )
							else
								--draw.DrawText( EDS.text2, "CorpseInspectFont", ScrW()/2, ScrH()/2, EDS.FontColor2, 1, 1 )
							end
							if !is_static then
								if(IsJob(ply, EDS.MedicJobs) and EDS.MedicCanCleanup) then
									draw.DrawText( EDS.text4.."\n"..EDS.text3, "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/48, EDS.FontColor1, 1, 1 )
								elseif(IsJob(ply, EDS.HoboJobs) and EDS.CanHoboEat) then
									draw.DrawText( EDS.text4.."\n"..EDS.text16, "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/48, EDS.FontColor1, 1, 1 )
								elseif(IsJob(ply, EDS.MafiaJobs) and EDS.BossCanBurn and !ply:GetNWBool('EDS.CanFireUp', false)) then
									draw.DrawText( EDS.text4.."\n"..EDS.text19.." ("..EDS.text20..EDS.BossRequiredMoney..").", "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/48, EDS.FontColor1, 1, 1 )
								else
									draw.DrawText( EDS.text4, "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/48, EDS.FontColor1, 1, 1 )
								end
							else
								if(IsJob(ply, EDS.MedicJobs) and EDS.MedicCanCleanup) then
									draw.DrawText( EDS.text3, "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/48, EDS.FontColor1, 1, 1 )
								elseif(IsJob(ply, EDS.HoboJobs) and EDS.CanHoboEat) then
									draw.DrawText( EDS.text16, "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/48, EDS.FontColor1, 1, 1 )
								elseif(IsJob(ply, EDS.MafiaJobs) and EDS.BossCanBurn and !ply:GetNWBool('EDS.CanFireUp', false)) then
									draw.DrawText( EDS.text19.." ("..EDS.text20..EDS.BossRequiredMoney..").", "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/48, EDS.FontColor1, 1, 1 )
								end
							end
							
							if(ply:GetNWBool('EDS.CanFireUp', false)) then
								draw.DrawText( EDS.text31, "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/24, EDS.FontColor1, 1, 1 )
							end
						end
					else
						if((ply:isCP() and EDS.PoliceCanIvestigate) or IsJob(ply, EDS.DetectiveJobs)) then
							draw.DrawText( EDS.text35, "CorpseInspectFont", ScrW()/2, ScrH()/2, EDS.FontColor2, 1, 1 )
							if !is_static then
								draw.DrawText( EDS.text4.."\n"..EDS.text34, "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/48, EDS.FontColor1, 1, 1 )
							end
						else
							draw.DrawText( EDS.text35, "CorpseInspectFont", ScrW()/2, ScrH()/2, EDS.FontColor2, 1, 1 )
							if !is_static then
								if(IsJob(ply, EDS.MedicJobs) and EDS.MedicCanCleanup) then
									draw.DrawText( EDS.text4.."\n"..EDS.text3, "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/48, EDS.FontColor1, 1, 1 )
								elseif(IsJob(ply, EDS.HoboJobs) and EDS.CanHoboEat) then
									draw.DrawText( EDS.text4.."\n"..EDS.text16, "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/48, EDS.FontColor1, 1, 1 )
								elseif(IsJob(ply, EDS.MafiaJobs) and EDS.BossCanBurn and !ply:GetNWBool('EDS.CanFireUp', false)) then
									draw.DrawText( EDS.text4.."\n"..EDS.text19.." ("..EDS.text20..EDS.BossRequiredMoney..").", "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/48, EDS.FontColor1, 1, 1 )
								else
									draw.DrawText( EDS.text4, "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/48, EDS.FontColor1, 1, 1 )
								end
							else
								if(IsJob(ply, EDS.MedicJobs) and EDS.MedicCanCleanup) then
									draw.DrawText( EDS.text3, "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/48, EDS.FontColor1, 1, 1 )
								elseif(IsJob(ply, EDS.HoboJobs) and EDS.CanHoboEat) then
									draw.DrawText( EDS.text16, "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/48, EDS.FontColor1, 1, 1 )
								elseif(IsJob(ply, EDS.MafiaJobs) and EDS.BossCanBurn and !ply:GetNWBool('EDS.CanFireUp', false)) then
									draw.DrawText( EDS.text19.." ("..EDS.text20..EDS.BossRequiredMoney..").", "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/48, EDS.FontColor1, 1, 1 )
								end
							end
							
							if(ply:GetNWBool('EDS.CanFireUp', false)) then
								draw.DrawText( EDS.text31, "CorpseInspectFont2", ScrW()/2, ScrH()/2+ScrH()/24, EDS.FontColor1, 1, 1 )
							end
						end
					end
				end
			end
		end
	end
end)