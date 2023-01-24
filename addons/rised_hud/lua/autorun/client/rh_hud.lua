-- "addons\\rised_hud\\lua\\autorun\\client\\rh_hud.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if SERVER then 
	--resource.AddFile( "materials/flathud/user.png" )
	--resource.AddFile( "materials/flathud/salary.png" )
	--resource.AddFile( "materials/flathud/wallet.png" )
	--resource.AddFile( "resource/fonts/Lato-Regular.ttf" )
	return
end

local showcombineinfo = true
local bool = false
local bool21 = false
local bool22 = false
local bool23 = false

local config = {}
/*---------------------------------------------------------------------------
	CONFIG
---------------------------------------------------------------------------*/
config.blurBackground = true 			--replace background with blur
config.teamColoredBackground = false 	--replace background with team color
config.backgroundColor = Color( 236, 113, 73 )
/*---------------------------------------------------------------------------
	END OF CONFIG
---------------------------------------------------------------------------*/

local flatHUD = {}

surface.CreateFont( "flatHUD_font28", {
	font = "Lato",
	size = ScreenScale ( 28 ), 
	weight = 500,
	antialias = true,
})

surface.CreateFont( "flatHUD_font18", {
	font = "Lato",
	size = ScreenScale ( 18 ), 
	weight = 500,
	antialias = true,
})

surface.CreateFont( "flatHUD_font14", {
	font = "Lato",
	size = ScreenScale ( 8 ), 
	weight = 500,
	antialias = true,
})

surface.CreateFont( "flatHUD_fontX", {
	font = "Lato",
	size = ScreenScale ( 20 ), 
	weight = 500,
	antialias = true,
})

surface.CreateFont( "marske2.5", {
	font = "Marske",
	extended = true, 
	size = ScreenScale ( 2.5 ), 
	weight = 0,
	antialias = true,
	extended = true,
	outline = false
})

for i = 1, 30 do
	surface.CreateFont( "marske"..i, {
		font = "Marske",
		extended = true, 
		size = ScreenScale (i), 
		weight = 0,
		antialias = true,
		extended = true,
		outline = false
	})
end

surface.CreateFont( "CloseCaption14", {
	font = "CloseCaption_Normal",
	size = ScreenScale ( 14 ), 
	weight = 500,
	antialias = true,
})

for i=5, 30 do
	surface.CreateFont( "combine_"..i, {
		font = "Combine 17 Regular",
		size = ScreenScale ( i ), 
		weight = 500,
		antialias = true,
	})
end

local function formatCurrency( number )
	local output = number
	if number < 1000000 then
		output = string.gsub( number, "^(-?%d+)(%d%d%d)", "%1,%2" ) 
	else
		output = string.gsub( number, "^(-?%d+)(%d%d%d)(%d%d%d)", "%1,%2,%3" )
	end

	return output
end

local function getClip()
	if LocalPlayer():GetActiveWeapon():IsValid() and LocalPlayer():GetActiveWeapon():Clip1() then
		return LocalPlayer():GetActiveWeapon():Clip1()
	else
		return 0
	end
end

local function getAmmo()
	if LocalPlayer():GetActiveWeapon():IsValid() and LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType() then
		return LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType())
	else
		return 0
	end
end

local blur = Material( "pp/blurscreen" )
local function drawBlur( x, y, w, h, layers, density, alpha )
	surface.SetDrawColor( 255, 255, 255, alpha )
	surface.SetMaterial( blur )

	for i = 1, layers do
		blur:SetFloat( "$blur", ( i / layers ) * density )
		blur:Recompute()

		render.UpdateScreenEffectTexture()
		render.SetScissorRect( x, y, x + w, y + h, true )
			surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
		render.SetScissorRect( 0, 0, 0, 0, false )
	end
end

local matSalary = Material( "flathud/salary.png" )
local matWallet = Material( "flathud/wallet.png" )
local matUser = Material( "flathud/user.png" )

local health = health or 0
local armor = armor or 0
local money = money or 0

local x, y = 5, ScrH() - 195

local clr = {
	[ "$pp_colour_addr" ] = 0,
	[ "$pp_colour_addg" ] = 0,
	[ "$pp_colour_addb" ] = 0,
	[ "$pp_colour_brightness" ] = 0,
	[ "$pp_colour_contrast" ] = 1,
	[ "$pp_colour_colour" ] = 1,
	[ "$pp_colour_mulr" ] = 0,
	[ "$pp_colour_mulg" ] = 0,
	[ "$pp_colour_mulb" ] = 0
}
	
local clrCP = {
	[ "$pp_colour_addr" ] = 0,
	[ "$pp_colour_addg" ] = 0,
	[ "$pp_colour_addb" ] = 0,
	[ "$pp_colour_brightness" ] = 0,
	[ "$pp_colour_contrast" ] = 1,
	[ "$pp_colour_colour" ] = 1,
	[ "$pp_colour_mulr" ] = 0,
	[ "$pp_colour_mulg" ] = 0,
	[ "$pp_colour_mulb" ] = 0
}
	
local clrZ = {
	[ "$pp_colour_addr" ] = 0,
	[ "$pp_colour_addg" ] = 0,
	[ "$pp_colour_addb" ] = 0,
	[ "$pp_colour_brightness" ] = 0,
	[ "$pp_colour_contrast" ] = 1.4,
	[ "$pp_colour_colour" ] = 0.4,
	[ "$pp_colour_mulr" ] = 0,
	[ "$pp_colour_mulg" ] = 0,
	[ "$pp_colour_mulb" ] = 0
}

local to_talk = CreateClientConVar('number_of_voice_system', 1)

table_voice_type = {
    [1] = "Обычное",
    [2] = "Крик",
    [3] = "Шепот"
}

concommand.Add("rised_voice_type", function()

    local s = to_talk:GetInt()
	
    if s == 1 then

        to_talk:SetInt(1)

        net.Start("rised_voice_system")

        net.WriteUInt(1, 3)

        net.SendToServer()

    elseif s == 2 then

        to_talk:SetInt(2)

        net.Start("rised_voice_system")

        net.WriteUInt(2, 3)

        net.SendToServer()

    elseif s == 3 then

        to_talk:SetInt(3)

        net.Start("rised_voice_system")

        net.WriteUInt(3, 3)

        net.SendToServer()

    end

end)

local to_draw = 0

local voice_alpha = 0

local tt3 = 0

hook.Add("PlayerStartVoice", "StartDrawingMode", function(p)

    to_draw = 255

end)


hook.Add("PlayerEndVoice", "StartDrawingMode", function(p)

    to_draw = 0

end)


hook.Add( "HUDItemPickedUp", "ItemPickedUp", function( itemName )
   return false
end)

hook.Add( "HUDWeaponPickedUp", "WeaponPickedUp", function( weapon )
   return false
end)

function GetFractionColor(team)
	if GAMEMODE.CombineJobs[LocalPlayer():Team()] or (LocalPlayer():isCP() && LocalPlayer():Team() != TEAM_PARTYGENERALSECRETARY && LocalPlayer():Team() != TEAM_CONSUL) then
		return col_combine
	elseif GAMEMODE.Rebels[LocalPlayer():Team()] then
		return col_rebel
	elseif GAMEMODE.ZombieJobs[LocalPlayer():Team()] or LocalPlayer():Team() == TEAM_HOBOMAN then
		return col_zombie
	else
		return col_neutral
	end
end

function banHUD()
	local ban_list = {
		-- "STEAM_0:1:38606392",
		"STEAM_0:0:618356886",
		"STEAM_0:1:225858730",
		"STEAM_0:0:576609982",
		"STEAM_0:1:639718783",
		"",
	}
	if table.HasValue(ban_list, LocalPlayer():SteamID()) then
		local tab = {
			[ "$pp_colour_brightness" ] = 10,
			[ "$pp_colour_contrast" ] = 1.4,
			[ "$pp_colour_colour" ] = 0
		}
		DrawColorModify(tab)
	end
end

RisedNewHUD = true
function risedHUDDraw()

	banHUD()
	-- Rised Kostyl
	if false and (GAMEMODE.CombineJobs[LocalPlayer():Team()] or GAMEMODE.SynthJobs[LocalPlayer():Team()]) then
		-- DrawColorModify(clrCP)

		if !GetConVar( "rised_thirdpersonview_enable" ):GetBool() then
			local HUD_Visor_value = (GetConVar( "rised_HUD_Visor_value" ):GetFloat() / 100)
			local COMBINE_OVERLAY
			COMBINE_OVERLAY = Material("effects/combine_binocoverlay")
			COMBINE_OVERLAY:SetFloat("$alpha", HUD_Visor_value)
			COMBINE_OVERLAY:Recompute()
			DrawMaterialOverlay( "effects/combine_binocoverlay", HUD_Visor_value )
		end

		CombineHudInfo()
		return
	elseif ply:GetNWBool("Player_CombineMask") or GAMEMODE.CombineJobs[LocalPlayer():Team()] or GAMEMODE.SynthJobs[LocalPlayer():Team()] then
		if !GetConVar( "rised_thirdpersonview_enable" ):GetBool() then
			local HUD_Visor_value = (GetConVar( "rised_HUD_Visor_value" ):GetFloat() / 100)
			local COMBINE_OVERLAY
			COMBINE_OVERLAY = Material("effects/combine_binocoverlay")
			COMBINE_OVERLAY:SetFloat("$alpha", HUD_Visor_value)
			COMBINE_OVERLAY:Recompute()
			DrawMaterialOverlay( "effects/combine_binocoverlay", HUD_Visor_value )
		end
	elseif GAMEMODE.ZombieJobs[LocalPlayer():Team()] then
		DrawColorModify(clrZ)

		local ZOMBIE_OVERLAY
		ZOMBIE_OVERLAY = Material("pp/frame_blend")
		ZOMBIE_OVERLAY:SetFloat("$alpha", 0.1)
		ZOMBIE_OVERLAY:Recompute()
		DrawMaterialOverlay( "pp/toytown-top", 0.1 )

		if LocalPlayer():Team() == TEAM_JEFF then
			local JEFF_OVERLAY
			JEFF_OVERLAY = Material("pp/sobel")
			JEFF_OVERLAY:SetFloat("$alpha", 0.1)
			JEFF_OVERLAY:Recompute()
			DrawMaterialOverlay( "pp/sobel", 0.1 )
		end
	elseif GAMEMODE.Rebels[LocalPlayer():Team()] then
		if !GetConVar( "rised_thirdpersonview_enable" ):GetBool() then
			if LocalPlayer():Team() == TEAM_REBELSPY01 then
				local HUD_Visor_value = (GetConVar( "rised_HUD_Visor_value" ):GetFloat() / 100)
				local COMBINE_OVERLAY
				COMBINE_OVERLAY = Material("effects/combine_binocoverlay")
				COMBINE_OVERLAY:SetFloat("$alpha", HUD_Visor_value)
				COMBINE_OVERLAY:Recompute()
				DrawMaterialOverlay( "effects/combine_binocoverlay", HUD_Visor_value )
			elseif LocalPlayer():GetNWBool("Player_Gasmask") then
				DrawMaterialOverlay( "OIIJIOT/protectivedmxmd", 0.7 )
			end
		end
		
	elseif LocalPlayer():Team() != TEAM_ADMINISTRATOR and LocalPlayer():Team() != TEAM_GMAN then
		if !GetConVar( "rised_thirdpersonview_enable" ):GetBool() then
			if LocalPlayer():GetNWBool("Player_Gasmask") then
				DrawMaterialOverlay( "OIIJIOT/protectivedmxmd", 0.7 )
			end
		end
	end
	
	if LocalPlayer():GetNWBool("IsBanned") then
		/*---------------------------------------------------------------------------
			Punish таймер
		---------------------------------------------------------------------------*/
		if LocalPlayer():GetNWBool("IsBanned", false) then
			local punish_time = LocalPlayer():GetNWInt("Punish_Timer", 0)
			if punish_time > 0 then
				draw.SimpleText( "Осталось: ", "marske4", ScrW()/2, y + 50 + 47, HealthDrawColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				draw.SimpleText( punish_time, "flatHUD_font14", ScrW()/2 + 40, y + 50 + 47, LifesTextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
			end
		end
		return
	end



	
	if GetConVar( "rised_cinematic_overlay" ):GetBool() then
		DrawMaterialOverlay("nco/cinover", 100)
	end



	/*---------------------------------------------------------------------------
		Настроение
	---------------------------------------------------------------------------*/

	local mood = math.Clamp(LocalPlayer():GetNWInt("Player_Mood", 100) / 100, 0, 1)
	
	if !LocalPlayer():isCP() and !GAMEMODE.ZombieJobs[LocalPlayer():Team()] and !GAMEMODE.CombineJobs[LocalPlayer():Team()] and LocalPlayer():Team() != TEAM_VORTIGAUNTSLAVE and LocalPlayer():Team() != TEAM_VORTIGAUNT then
		local clr = {
			[ "$pp_colour_addr" ] = 0,
			[ "$pp_colour_addg" ] = 0,
			[ "$pp_colour_addb" ] = 0,
			[ "$pp_colour_brightness" ] = 0,
			[ "$pp_colour_contrast" ] = 1.3,
			[ "$pp_colour_colour" ] = mood * 1.2,
			[ "$pp_colour_mulr" ] = 0,
			[ "$pp_colour_mulg" ] = 0,
			[ "$pp_colour_mulb" ] = 0
		}
		DrawColorModify(clr)
		-- DrawBokehDOF( 3, 2, 1 ) -- близорукость
		if mood < 0.5 then
			local shake = -0.4 * mood + 0.25
			util.ScreenShake( LocalPlayer():GetPos(), shake, shake, shake, 50 )
			local sharpen = -2 * mood + 2
			DrawSharpen( sharpen, sharpen )
		end
	end

	if LocalPlayer():Health()<=50 then
		local mul = LocalPlayer():Health()/100*2
		mul = math.Clamp(mul,0.7,1)
		local tab = {
			[ "$pp_colour_contrast" ] = mul
		}
		DrawColorModify( tab )
	end
	
	if LocalPlayer():getDarkRPVar("Energy") != nil and LocalPlayer():Team() != TEAM_ADMINISTRATOR then
		if tonumber(LocalPlayer():getDarkRPVar("Energy")) <= 10 then
			local mul = LocalPlayer():getDarkRPVar("Energy")/10
			mul = math.Clamp(mul,0.7,1)
			local tab = {
				[ "$pp_colour_colour" ] = mul
			}
			DrawColorModify( tab )
			DrawMotionBlur( 0.4, 1, 0.01 )
		end
	end



	/*---------------------------------------------------------------------------
		Микрофон и режим голоса
	---------------------------------------------------------------------------*/

	local r,g,b = 255,255,255
	local rs,gs,bs = 175,175,175
	local rb,gb,bb = 0,0,0
	if GAMEMODE.CombineJobs[ply:Team()] then
		r = 255
		g = 255
		b = 255
		rs = 255
		gs = 0
		bs = 0
	elseif ply:isCP() then
		r = 255
		g = 165
		b = 0
		rs = 255
		gs = 195
		bs = 0
	elseif GAMEMODE.Rebels[ply:Team()] then
		r = 255
		g = 255
		b = 255
		rs = 45
		gs = 195
		bs = 45
	elseif GAMEMODE.LoyaltyJobs[ply:Team()] then
		r = 255
		g = 255
		b = 255
		rs = 155
		gs = 255
		bs = 155
	end
	local main = Color(r, g, b, 210 )
	local secondary = Color(rs, gs, bs, 210 )
	local back = Color(rb, gb, bb, 145 )
	
	if GetConVar("rised_HUD_MicroInfo_enable"):GetBool() then
		if LocalPlayer():HasWeapon("wep_jack_job_drpradio") then
			if LocalPlayer():GetNWBool("Rised_RadioMicro", false) then
				draw.DrawText("Микрофон: включен (Нажмите 'T' чтобы выключить)", "marske4", ScrW() - 10, 15, main, TEXT_ALIGN_RIGHT)
			else
				draw.DrawText("Микрофон: выключен (Нажмите 'T' чтобы включить)", "marske4", ScrW() - 10, 15, main, TEXT_ALIGN_RIGHT)
			end
		end

	    local voice_type = table_voice_type[to_talk:GetInt()]
	    voice_alpha = math.Round(math.Approach(voice_alpha, to_draw, 3))
		local voice_color = Color(main.r,main.g,main.b, voice_alpha)
	    draw.SimpleTextOutlined("Режим: " .. voice_type, "marske4", ScrW() -80, ScrH() / 1.8, voice_color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(12, 12, 12, voice_alpha))
	end




	if RisedNewHUD then
		if GetConVar("rised_HUD_enable"):GetBool() then
			QuantumPaint()
		end
		return
	end




	if GAMEMODE.AnimalJobs[LocalPlayer():Team()] then return end

	local fractionColor = GetFractionColor(LocalPlayer():Team())
	local main_colors = Color(fractionColor.r, fractionColor.g, fractionColor.b, 255)
	
	if not LocalPlayer():Alive() then return end
	if not LocalPlayer().DarkRPVars then return end
	if LocalPlayer():GetNWBool("Player_ScreenFaded") then return end
	if LocalPlayer():GetNWBool("Rised_Combot_Entered", false) then return end
	/*---------------------------------------------------------------------------
		Backgrounds
	---------------------------------------------------------------------------*/
	








	/*---------------------------------------------------------------------------
		ФИО Персонажа
	---------------------------------------------------------------------------*/
	if GetConVar("rised_HUD_Name_enable"):GetBool() then
		draw.SimpleText( LocalPlayer().DarkRPVars.rpname, "marske6", 10, ScrH() - 114, main_colors, TEXT_ALIGN_TOP, TEXT_ALIGN_LEFT )
	end

	/*---------------------------------------------------------------------------
		Информация о персонаже
	---------------------------------------------------------------------------*/
	if GetConVar("rised_HUD_PersonalInfo_enable"):GetBool() then

		if GAMEMODE.CivilJobs[LocalPlayer():Team()] or LocalPlayer():Team() == TEAM_REBELSPY02 then
			local ol = LocalPlayer():GetNWInt("LoyaltyTokens", 0)
			draw.SimpleText( "| " .. LocalPlayer().DarkRPVars.job .. " (" .. LocalPlayer():GetNWString("Player_WorkStatus") .. ") | " .. "ОЛ: " .. ol, "marske5", 10, ScrH() - 88, main_colors, TEXT_ALIGN_TOP, TEXT_ALIGN_LEFT )
		elseif LocalPlayer().DarkRPVars.job != nil and !GAMEMODE.Rebels[LocalPlayer():Team()] and LocalPlayer():Team() != TEAM_REFUGEE then
			local ol = LocalPlayer():GetNWInt("LoyaltyTokens", 0)
			draw.SimpleText( "| " .. LocalPlayer().DarkRPVars.job .. " | " .. "ОЛ: " .. ol, "marske5", 10, ScrH() - 88, main_colors, TEXT_ALIGN_TOP, TEXT_ALIGN_LEFT )
		elseif LocalPlayer().DarkRPVars.job != nil then
			draw.SimpleText( "| " .. LocalPlayer().DarkRPVars.job, "marske5", 10, ScrH() - 88, main_colors, TEXT_ALIGN_TOP, TEXT_ALIGN_LEFT )
		end
		
		draw.SimpleText(  "◈ Зарплата: " .. formatCurrency(LocalPlayer():getDarkRPVar("salary") or 0) .. " T", "marske4", 10, ScrH() - 66, main_colors, TEXT_ALIGN_TOP, TEXT_ALIGN_LEFT )
		draw.SimpleText(  "◈ Наличные: " .. formatCurrency(LocalPlayer():getDarkRPVar("money") or 0) .. " T", "marske4", 10, ScrH() - 50, main_colors, TEXT_ALIGN_TOP, TEXT_ALIGN_LEFT )
		
		draw.SimpleText( "◈ Настроение:", "marske4", 10, ScrH() - 34, main_colors, TEXT_ALIGN_TOP, TEXT_ALIGN_LEFT)
		if mood >= 0.90 then
			draw.SimpleText("Отличное | " .. LocalPlayer():GetNWString("MedicineDisease_02"), "marske4", 120, ScrH() - 34, main_colors, TEXT_ALIGN_TOP, TEXT_ALIGN_LEFT)
		elseif mood >= 0.80 then
			draw.SimpleText("Хорошее | " .. LocalPlayer():GetNWString("MedicineDisease_02"), "marske4", 120, ScrH() - 34, main_colors, TEXT_ALIGN_TOP, TEXT_ALIGN_LEFT)
		elseif mood >= 0.70 or ply:isCP() then
			draw.SimpleText("Нормальное | " .. LocalPlayer():GetNWString("MedicineDisease_02"), "marske4", 120, ScrH() - 34, main_colors, TEXT_ALIGN_TOP, TEXT_ALIGN_LEFT)
		elseif mood >= 0.60 then
			draw.SimpleText("Ниже среднего | " .. LocalPlayer():GetNWString("MedicineDisease_02"), "marske4", 120, ScrH() - 34, main_colors, TEXT_ALIGN_TOP, TEXT_ALIGN_LEFT)
		elseif mood >= 0.50 then
			draw.SimpleText("Грусть | " .. LocalPlayer():GetNWString("MedicineDisease_02"), "marske4", 120, ScrH() - 34, main_colors, TEXT_ALIGN_TOP, TEXT_ALIGN_LEFT)
		elseif mood >= 0.40 then
			draw.SimpleText("Беспокойство | " .. LocalPlayer():GetNWString("MedicineDisease_02"), "marske4", 120, ScrH() - 34, main_colors, TEXT_ALIGN_TOP, TEXT_ALIGN_LEFT)
		elseif mood >= 0.30 then
			draw.SimpleText("Подавленное | " .. LocalPlayer():GetNWString("MedicineDisease_02"), "marske4", 120, ScrH() - 34, main_colors, TEXT_ALIGN_TOP, TEXT_ALIGN_LEFT)
		elseif mood >= 0.20 then
			draw.SimpleText("Тревожное | " .. LocalPlayer():GetNWString("MedicineDisease_02"), "marske4", 120, ScrH() - 34, main_colors, TEXT_ALIGN_TOP, TEXT_ALIGN_LEFT)
		elseif mood >= 0.10 then
			draw.SimpleText("Мрачное | " .. LocalPlayer():GetNWString("MedicineDisease_02"), "marske4", 120, ScrH() - 34, main_colors, TEXT_ALIGN_TOP, TEXT_ALIGN_LEFT)
		elseif mood < 0.10 then
			draw.SimpleText("Отчаяние | " .. LocalPlayer():GetNWString("MedicineDisease_02"), "marske4", 120, ScrH() - 34, main_colors, TEXT_ALIGN_TOP, TEXT_ALIGN_LEFT)
		end
		
		local RPLevel = tonumber(LocalPlayer():GetNWInt("PersonalRPLevel", 0))
		draw.SimpleText( "◈ RP Level:", "marske4", 10, ScrH() - 18, main_colors, TEXT_ALIGN_TOP, TEXT_ALIGN_LEFT)
		draw.SimpleText(RPLevel, "marske4", 105, ScrH() - 18, main_colors, TEXT_ALIGN_TOP, TEXT_ALIGN_LEFT)
	
		-- Event Tokens --
		--draw.SimpleText( "◈ Личные: "..LocalPlayer():GetNWInt("RPTockensSafe"), "flatHUD_font18", x + 115, y + 170, main_colors, TEXT_ALIGN_TOP, TEXT_ALIGN_LEFT )
		--draw.SimpleText( "◈ Текущие: "..LocalPlayer():GetNWInt("RPTockensCur"), "flatHUD_font18", x + 225, y + 170, main_colors, TEXT_ALIGN_TOP, TEXT_ALIGN_LEFT )	

		if LocalPlayer():GetNWBool("Rised_Premium", false) then
			draw.SimpleText( "PLAYER STATUS   -   P R E M I U M", "marske4", ScrW()/4.5, ScrH() - 12, main_colors, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
	end



	/*---------------------------------------------------------------------------
		Статус города
	---------------------------------------------------------------------------*/
	if GetConVar("rised_HUD_CityStatus_enable"):GetBool() then
		local revStatus
		if GetGlobalBool("RebelRevenge") == true then
			revStatus = "   R e v o l u t i o n"
		else
			revStatus = "   C o m b i n e   C o n t r o l"
		end
		draw.SimpleText( "City Status: " .. revStatus, "marske4", ScrW()/1.35, ScrH() - 12, main_colors, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end



	/*---------------------------------------------------------------------------
		Витальная информация
	---------------------------------------------------------------------------*/
	if GetConVar("rised_HUD_Vital_enable"):GetBool() then
	
		armor = LocalPlayer():Armor()
		health = LocalPlayer():Health()

		if LocalPlayer():Health() <= 30 then
			HealthDrawColor = Color( 200, 0, 0)
		else
			HealthDrawColor = main_colors
		end
		
		if LocalPlayer():Armor() <= 0 then
			ArmorDrawColor = main_colors
		else
			ArmorDrawColor = main_colors
		end
		
		if LocalPlayer():getDarkRPVar("Energy") <= 15 then
			HungerDrawColor = Color( 200, 0, 0)
		else
			HungerDrawColor = main_colors
		end
		
		if LocalPlayer():GetNWInt("Rised_Player_Stamina") <= 10 then
			StaminaDrawColor = Color( 200, 0, 0)
		else
			StaminaDrawColor = main_colors
		end
		
		if LocalPlayer():GetNWInt( "PlayerLifes" ) == 0 then
			LifesText = "♥"
			LifesTextColor = main_colors
		elseif LocalPlayer():GetNWInt( "PlayerLifes" ) == 1 then
			LifesText = "♥♥"
			LifesTextColor = main_colors
		elseif LocalPlayer():GetNWInt( "PlayerLifes" ) == 2 then
			LifesText = "♥♥♥"
			LifesTextColor = main_colors
		elseif LocalPlayer():GetNWInt( "PlayerLifes" ) == 3 then
			LifesText = "♥♥♥♥"
			LifesTextColor = main_colors
		elseif LocalPlayer():GetNWInt( "PlayerLifes" ) == 4 then
			LifesText = "♥♥♥♥♥"
			LifesTextColor = main_colors
		end

		draw.SimpleText( math.Round( armor ), "marske4", ScrW() * 7 / 17, ScrH() - 32, ArmorDrawColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		draw.SimpleText( "Броня", "marske4", ScrW() * 7 / 17, ScrH() - 12, ArmorDrawColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		
		draw.SimpleText( math.Round( health ), "marske6",  ScrW()/2, ScrH() - 45, HealthDrawColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		draw.SimpleText( "Жизни", "marske4", ScrW()/2, ScrH() - 25, HealthDrawColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		draw.SimpleText( LifesText, "flatHUD_font14", ScrW()/2, ScrH() - 10, LifesTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

		draw.SimpleText( math.Round( LocalPlayer().DarkRPVars.Energy or 0 ), "marske4", ScrW()/1.7, ScrH() - 32, HungerDrawColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		draw.SimpleText( "Насыщение", "marske4", ScrW()/1.7, ScrH() - 12, HungerDrawColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

		surface.SetDrawColor( main_colors )
		surface.DrawLine( ScrW()/2.18, ScrH() - 18, ScrW()/2.18, ScrH() - 38 )
		surface.DrawLine( ScrW() * 1.18 / 2.18, ScrH() - 18, ScrW() * 1.18 / 2.18, ScrH() - 38 )

		if GAMEMODE.MetropolicePlunger[LocalPlayer():Team()] then
			draw.SimpleText( "Метал Альянса: "..ply:GetNWInt("Rised_Player_Metal_Count"), "marske4", ScrW()/1.442, ScrH() - 35, HungerDrawColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		elseif LocalPlayer():Team() == TEAM_OWUDISPATCH then
			draw.SimpleText( "Метал Альянса: "..GetGlobalInt("CombineResource_Metal"), "marske4", ScrW()/1.442, ScrH() - 35, HungerDrawColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
	end

	/*---------------------------------------------------------------------------
		Патроны
	---------------------------------------------------------------------------*/
	if GetConVar("rised_HUD_Ammo_enable"):GetBool() and LocalPlayer():GetActiveWeapon() != NULL and string.sub(LocalPlayer():GetActiveWeapon():GetClass(),1,3) == "swb" then

		if getClip() > 0 then
			draw.SimpleText( getClip(), "marske4", ScrW() - 155, ScrH() - 30, main_colors, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		else
			draw.SimpleText( "0", "marske4", ScrW() - 155, ScrH() - 30, main_colors, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		draw.SimpleText( "Текущие", "marske4", ScrW() - 155, ScrH() - 12, main_colors, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )


		local reserve = math.ceil(getAmmo() / LocalPlayer():GetActiveWeapon():GetMaxClip1())
		local reserveText = "Магазины"

		if LocalPlayer():GetActiveWeapon().Primary.Ammo == "12x70_ammo" then
			reserve = getAmmo()
			reserveText = "Гильзы"
		end

		draw.SimpleText( reserve, "marske4", ScrW() - 55, ScrH() - 30, main_colors, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		draw.SimpleText( reserveText, "marske4", ScrW() - 55, ScrH() - 12, main_colors, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end

	local other_weps = {
		"weapon_lockpick_shot"
	}

	if IsValid(LocalPlayer():GetActiveWeapon()) then
		local wep_class = LocalPlayer():GetActiveWeapon():GetClass()
		if GetConVar("rised_HUD_Ammo_enable"):GetBool() and table.HasValue(other_weps, wep_class) then
			local reserve = getClip() + getAmmo()
			local reserveText = "Всего"

			draw.SimpleText( reserve, "marske4", ScrW() - 55, ScrH() - 30, main_colors, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			draw.SimpleText( reserveText, "marske4", ScrW() - 55, ScrH() - 12, main_colors, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
	end


	/*---------------------------------------------------------------------------
		Часы
	---------------------------------------------------------------------------*/
	if GetConVar("rised_HUD_ClockInfo_enable"):GetBool() then
		if LocalPlayer():GetNWBool("Player_Watch") == true or GAMEMODE.LoyaltyJobs[LocalPlayer():Team()] or LocalPlayer():Team() == TEAM_REBELSPY01 or LocalPlayer():isCP() then
			draw.SimpleText( GetGlobalFloat("HoursTimeFloat") .. " : " .. GetGlobalFloat("MinutsTimeFloat"), "marske4", ScrW()/2, ScrH()/45, main_colors, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
	end



	/*---------------------------------------------------------------------------
		Jail таймер
	---------------------------------------------------------------------------*/
	if LocalPlayer():GetNWInt("JailRoom_Timer", 0) != nil then
		if LocalPlayer():GetNWInt("JailRoom_Timer", 0) > 0 then
			draw.SimpleText( "Осталось: ", "marske4", ScrW()/2, y + 50 + 47, HealthDrawColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			draw.SimpleText( LocalPlayer():GetNWInt("JailRoom_Timer", 0), "flatHUD_font14", ScrW()/2 + 40, y + 50 + 47, LifesTextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		end
	end




	if LocalPlayer():isCP() then
		CombineHudInfo()
	elseif GAMEMODE.Rebels[LocalPlayer():Team()] then
		RebelsHudInfo()
	elseif GAMEMODE.Syndicate[LocalPlayer():Team()] then
		RedHudInfo()
	end

	DrawRisedStamina()
end
hook.Add( "HUDPaint", "flatHUD_draw", risedHUDDraw )

function CombineHudInfo()
	
	if LocalPlayer():Team() == TEAM_MPF_JURY_Conscript or LocalPlayer():Team() == TEAM_REBELSPY01 then return end

	local fractionColor = GetFractionColor(LocalPlayer():Team())
	local main_colors = Color(fractionColor.r, fractionColor.g, fractionColor.b, 255)

	local cps = 0
	local cits = 0
	for _,ply in ipairs(player.GetAll()) do
		if ply:isCP() then
			cps = cps + 1
		elseif GAMEMODE.CivilJobs[ply:Team()] or GAMEMODE.LoyaltyJobs[ply:Team()] or GAMEMODE.SovietJobs[ply:Team()] or GAMEMODE.CrimeJobs[ply:Team()] then
			cits = cits + 1
		end
	end
	
	local mainRad = tostring(90+GetGlobalString("Rised_MainRadioChannel_Combine", 95)/10)
	local subRad = tostring(90+GetGlobalString("Rised_SubRadioChannel_Combine", 94)/10)
	
	local combineinfocolor1 = main_colors
	local combineinfocolor2 = main_colors
	local combineinfocolor3 = main_colors
	
	if bool == false then
		bool = true
		timer.Create("CombineHudInfoTimer", 0.05, 0, function()
			if combineinfocolor1.a <= -55 then
				bool21 = true
			elseif combineinfocolor1.a >= 255 then
				bool21 = false
			end
			if bool21 == false then
				combineinfocolor1.a = combineinfocolor1.a - 2
			else
				combineinfocolor1.a = combineinfocolor1.a + 2
			end
			
			if combineinfocolor2.a <= -55 then
				bool22 = true
			elseif combineinfocolor2.a >= 255 then
				bool22 = false
			end
			if bool22 == false then
				combineinfocolor2.a = combineinfocolor2.a - 5
			else
				combineinfocolor2.a = combineinfocolor2.a + 5
			end
		end)
	end
	
	if GetConVar("rised_HUD_CombineInfo_enable"):GetBool() then
		draw.SimpleText( "Население города . . . . . . . . . . . . . . ", "marske4", 20, 25, combineinfocolor1, 0, TEXT_ALIGN_CENTER )
		draw.SimpleText( cits, "marske4", 280, 25, combineinfocolor1, 0, TEXT_ALIGN_CENTER )
		draw.SimpleText( "Сотрудников альянса . . . . . . . . . . . ", "marske4", 20, 50, combineinfocolor2, 0, TEXT_ALIGN_CENTER )
		draw.SimpleText( cps, "marske4", 280, 50, combineinfocolor2, 0, TEXT_ALIGN_CENTER )

		draw.SimpleText( "Радиочастота ГО . . . . . . . . . . . ", "marske4", 20, 75, combineinfocolor2, 0, TEXT_ALIGN_CENTER )
		draw.SimpleText( mainRad, "marske4", 255, 75, combineinfocolor2, 0, TEXT_ALIGN_CENTER )

		draw.SimpleText( "Радиочастота ОТА . . . . . . . . . . ", "marske4", 20, 100, combineinfocolor2, 0, TEXT_ALIGN_CENTER )
		draw.SimpleText( subRad, "marske4", 255, 100, combineinfocolor2, 0, TEXT_ALIGN_CENTER )
	end
end

function RebelsHudInfo()
	if GetConVar("rised_HUD_RebelsInfo_enable"):GetBool() then
		local rbs = 0
		for _,ply in ipairs(player.GetAll()) do
			if GAMEMODE.Rebels[ply:Team()] then
				rbs = rbs + 1
			end
		end

		local fractionColor = GetFractionColor(LocalPlayer():Team())
		local rebels_colors = Color(fractionColor.r, fractionColor.g, fractionColor.b, 255)
		
		local mainRad = tostring(90+GetGlobalString("Rised_MainRadioChannel", 55)/10)
		local subRad = tostring(90+GetGlobalString("Rised_SubRadioChannel", 32)/10)

		draw.SimpleText( "Личный состав сопротивления . . . . . . . . . . . ", "marske4", 20, ScrH()/35, rebels_colors, 0, TEXT_ALIGN_CENTER )
		draw.SimpleText( rbs, "marske4", 350, ScrH()/35, rebels_colors, 0, TEXT_ALIGN_CENTER )

		draw.SimpleText( "Основная радиочастота . . . . . . . . . . . ", "marske4", 20, ScrH()/20, rebels_colors, 0, TEXT_ALIGN_CENTER )
		draw.SimpleText( mainRad, "marske4", 300, ScrH()/20, rebels_colors, 0, TEXT_ALIGN_CENTER )

		draw.SimpleText( "Резервная радиочастота . . . . . . . . . . . ", "marske4", 20, ScrH()/14, rebels_colors, 0, TEXT_ALIGN_CENTER )
		draw.SimpleText( subRad, "marske4", 300, ScrH()/14, rebels_colors, 0, TEXT_ALIGN_CENTER )
	end
	
	if GetConVar("rised_HUD_SectorsInfo_enable"):GetBool() then
		local sector01text = ""
		local sector01col  = Color(255, 195, 85, 25)
		
		local sector02text = ""
		local sector02col  = Color(255, 195, 85)
		
		local sector03text = ""
		local sector03col  = Color(255, 195, 85)
		
		local sector04text = ""
		local sector04col  = Color(255, 195, 85)
		
		local sector05text = ""
		local sector05col  = Color(255, 195, 85)
		
		local sector06text = ""
		local sector06col  = Color(255, 195, 85)
		
		local sector07text = ""
		local sector07col  = Color(255, 195, 85)
		
		if !GetGlobalBool("SectorT01_Captured") then
			sector01text = "Под контролем Альянса"
			sector01col  = Color(255, 0, 0)
		else
			sector01text = "Захвачен"
			sector01col  = Color(255, 195, 85, 125)
		end
		
		if !GetGlobalBool("SectorT02_Captured") then
			sector02text = "Под контролем Альянса"
			sector02col  = Color(255, 0, 0)
		else
			sector02text = "Захвачен"
			sector02col  = Color(255, 195, 85, 125)
		end
		
		if !GetGlobalBool("SectorT03_Captured") then
			sector03text = "Под контролем Альянса"
			sector03col  = Color(255, 0, 0)
		else
			sector03text = "Захвачен"
			sector03col  = Color(255, 195, 85, 125)
		end
		
		if !GetGlobalBool("SectorT04_Captured") then
			sector04text = "Под контролем Альянса"
			sector04col  = Color(255, 0, 0)
		else
			sector04text = "Захвачен"
			sector04col  = Color(255, 195, 85, 125)
		end
		
		if !GetGlobalBool("SectorT05_Captured") then
			sector05text = "Под контролем Альянса"
			sector05col  = Color(255, 0, 0)
		else
			sector05text = "Захвачен"
			sector05col  = Color(255, 195, 85, 125)
		end
		
		if !GetGlobalBool("SectorT06_Captured") then
			sector06text = "Под контролем Альянса"
			sector06col  = Color(255, 0, 0)
		else
			sector06text = "Захвачен"
			sector06col  = Color(255, 195, 85, 125)
		end
		
		if !GetGlobalBool("SectorT07_Captured") then
			sector07text = "Под контролем Альянса"
			sector07col  = Color(255, 0, 0)
		else
			sector07text = "Захвачен"
			sector07col  = Color(255, 195, 85, 125)
		end
		
		draw.SimpleText( "Нексус Надзор . . . . . . . "..sector01text, "marske4", ScrW()/1.3, 50, sector01col, 0, TEXT_ALIGN_CENTER )
		draw.SimpleText( "Главный сектор . . . . . . . "..sector02text, "marske4", ScrW()/1.3, 70, sector02col, 0, TEXT_ALIGN_CENTER )
		draw.SimpleText( "Рабочий сектор . . . . . . "..sector03text, "marske4", ScrW()/1.3, 90, sector03col, 0, TEXT_ALIGN_CENTER )
		draw.SimpleText( "Жилой сектор . . . . . . . . "..sector04text, "marske4", ScrW()/1.3, 110, sector04col, 0, TEXT_ALIGN_CENTER )
		draw.SimpleText( "Неблагополучный сектор . . . . . . . . . "..sector05text, "marske4", ScrW()/1.3, 130, sector05col, 0, TEXT_ALIGN_CENTER )
		draw.SimpleText( "Зона карантина . . "..sector06text, "marske4", ScrW()/1.3, 150, sector06col, 0, TEXT_ALIGN_CENTER )
		draw.SimpleText( "Пляж Ракушка . . "..sector07text, "marske4", ScrW()/1.3, 170, sector07col, 0, TEXT_ALIGN_CENTER )
	end
end

function RedHudInfo()
	if GetConVar("rised_HUD_RebelsInfo_enable"):GetBool() then
		local rbs = 0
		for _,ply in ipairs(player.GetAll()) do
			if GAMEMODE.Rebels[ply:Team()] then
				rbs = rbs + 1
			end
		end
		
		local mainRad = tostring(90+GetGlobalString("Rised_MainRadioChannel_Red", 55)/10)
		local subRad = tostring(90+GetGlobalString("Rised_SubRadioChannel_Red", 32)/10)

		draw.SimpleText( "Личный состав сопротивления . . . . . . . . . . . ", "marske4", 20, ScrH()/35, Color(151, 0, 19, 125), 0, TEXT_ALIGN_CENTER )
		draw.SimpleText( rbs, "marske4", 350, ScrH()/35, Color(151, 0, 19, 125), 0, TEXT_ALIGN_CENTER )

		draw.SimpleText( "Основная радиочастота . . . . . . . . . . . ", "marske4", 20, ScrH()/20, Color(151, 0, 19, 125), 0, TEXT_ALIGN_CENTER )
		draw.SimpleText( mainRad, "marske4", 300, ScrH()/20, Color(151, 0, 19, 125), 0, TEXT_ALIGN_CENTER )

		draw.SimpleText( "Резервная радиочастота . . . . . . . . . . . ", "marske4", 20, ScrH()/14, Color(151, 0, 19, 125), 0, TEXT_ALIGN_CENTER )
		draw.SimpleText( subRad, "marske4", 300, ScrH()/14, Color(151, 0, 19, 125), 0, TEXT_ALIGN_CENTER )
	end
end

local Mat = Material("vgui/hsv-brightness")

local Alpha = 0

function DrawRisedStamina()

	local ply = LocalPlayer()

	local Stamina = ply:GetNWInt("Rised_Player_Stamina")
	local MaxStamina = 100
	local CurrentMaxStamina = ply:GetNWInt("Rised_Player_Stamina_Max")
	
	if Stamina == CurrentMaxStamina then
		Alpha = math.max(0,Alpha - 100*FrameTime())
	else
		Alpha = math.min(100,Alpha + 100*FrameTime())
	end
	
	local BasePercent = Alpha/100

	if MaxStamina then
			
		local BaseFade = 255
		local BarWidth = 40
		local BarHeight = 8
		
		local Percent = Stamina/MaxStamina
		local PercentCurMax = CurrentMaxStamina/MaxStamina
		local SizeScale = 1
		
		local XPos = ScrW()/2
		local YPos = ScrH()
		local XSize = BarWidth*10
		local YSize = BarHeight
	
		local fractionColor = GetFractionColor(LocalPlayer():Team())
		local main_colors = Color(fractionColor.r, fractionColor.g, fractionColor.b, 255)
			
		surface.SetMaterial( Mat )
		surface.SetDrawColor(0,0,0, 1.5 * Alpha )
		surface.DrawTexturedRectRotated(XPos,YPos,XSize,YSize,0)
		
		surface.SetMaterial( Mat )
		surface.SetDrawColor(0,0,0, 3 * Alpha)
		surface.DrawTexturedRectRotated(XPos,YPos,XSize*PercentCurMax,YSize,0)
			
		surface.SetMaterial( Mat )
		main_colors.a = BaseFade * BasePercent
		surface.SetDrawColor(main_colors)
		surface.DrawTexturedRectRotated(XPos,YPos,XSize*Percent,YSize,0)
	end
end

hook.Add( "Initialize", "flatHUD_smoother", function()
	hook.Add( "Think", "flatHUD_smoother", function()
		LocalPlayer().DarkRPVars = LocalPlayer().DarkRPVars or {}
		LocalPlayer().DarkRPVars.money = LocalPlayer().DarkRPVars.money or 0
		LocalPlayer().DarkRPVars.salary = LocalPlayer().DarkRPVars.salary or 0
		LocalPlayer().DarkRPVars.Energy = LocalPlayer().DarkRPVars.Energy or 0
		if LocalPlayer():Health() != health then
			health = Lerp( 0.025, health, LocalPlayer():Health() )
		end
		if LocalPlayer():Armor() != armor then
			armor = Lerp( 0.025, armor, LocalPlayer():Armor() )
		end
		if LocalPlayer().DarkRPVars.money != money then
			money = Lerp( 0.05, money, LocalPlayer().DarkRPVars.money )
		end
	end )
end )

local hide = {}
hide[ "CHudAmmo" ] = true
hide[ "CHudSecondaryAmmo" ] = true
hide[ "CHudHealth" ] = true
hide[ "CHudBattery" ] = true
hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if hide[ name ] then
		return false
	end
end )

hook.Add( "InitPostEntity", "flatHUD_avatar", function()
	local portrait = vgui.Create( "DModelPanel" )
	portrait:SetPos( x + 10, y + 10 )
	portrait:SetSize( 0, 0 )
	--portrait:SetModel( LocalPlayer():GetModel() )
	portrait.Think = function()
		if not LocalPlayer():Alive() then
			portrait:SetSize( 0, 0 )
		else
			portrait:SetSize( 0, 0 )
		end
		--portrait:SetModel( LocalPlayer():GetModel() )
	end
	portrait.LayoutEntity = function()
		return false
	end
	portrait:SetFOV( 40 )
	portrait:SetCamPos( Vector( 25, -15, 62 ) )
	portrait:SetLookAt( Vector( 0, 0, 62 ) )
	--portrait.Entity:SetEyeTarget( Vector( 200, 200, 100 ) )
end )

//HIDE DEFAULT HUD
local hideHUDElements = {
	["DarkRP_LocalPlayerHUD"] = true,
}
hook.Add("HUDShouldDraw", "flatHUD_HideDefaultDarkRPHud", function(name)
	--if hideHUDElements[name] then return false end
end)

function GetMoodStatus()
	local mood = math.Clamp(LocalPlayer():GetNWInt("Player_Mood", 100) / 100, 0, 1)
	local mood_status = ""
	if mood >= 0.90 then
		mood_status = "отличное"
	elseif mood >= 0.80 then
		mood_status = "хорошее"
	elseif mood >= 0.70 or ply:isCP() then
		mood_status = "нормальное"
	elseif mood >= 0.60 then
		mood_status = "ниже среднего"
	elseif mood >= 0.50 then
		mood_status = "грусть"
	elseif mood >= 0.40 then
		mood_status = "беспокойство"
	elseif mood >= 0.30 then
		mood_status = "подавленное"
	elseif mood >= 0.20 then
		mood_status = "тревожное"
	elseif mood >= 0.10 then
		mood_status = "мрачное"
	elseif mood < 0.10 then
		mood_status = "отчаяние"
	end
	mood_status = LocalPlayer():GetNWString("MedicineDisease_02") != "" and mood_status .. " | " .. LocalPlayer():GetNWString("MedicineDisease_02") or mood_status
	return mood_status
end