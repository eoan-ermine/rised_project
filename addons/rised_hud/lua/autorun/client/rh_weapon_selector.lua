-- "addons\\rised_hud\\lua\\autorun\\client\\rh_weapon_selector.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
	surface.CreateFont( 'hud_icon', {
		font = 'HalfLife2',
		size = 100,
		weight = 500,
		blursize = 0,
		antialias = true,
		shadow = false
	} )
	
	surface.CreateFont( "hud_lil", {
		font = "Roboto",
		dc = false,
		size = 16,
		weight = 500,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		extended = true
	} )
	
	local ammoTypeIcons = {
		[1] = 		{ icon = Material( "gui/hud_ehl2/ammo_ar2.png" ) },
		[2] = 		{ icon = Material( "gui/hud_ehl2/ammo_alt_ar2.png", "noclamp" ) },
		[3] = 		{ icon = Material( "gui/hud_ehl2/ammo_pistol.png" ) },
		[4] = 		{ icon = Material( "gui/hud_ehl2/ammo_rifle.png" ) },
		[5] = 		{ icon = Material( "gui/hud_ehl2/ammo_357.png" ) },
		[6] = 		{ icon = Material( "gui/hud_ehl2/ammo_crossbow.png" ) },
		[7] = 		{ icon = Material( "gui/hud_ehl2/ammo_shotgun.png" ) },
		[8] = 		{ icon = Material( "gui/hud_ehl2/ammo_rocket.png" ) },
		[9] = 		{ icon = Material( "gui/hud_ehl2/ammo_alt_smg.png" ) },
		[10] = 		{ icon = Material( "gui/hud_ehl2/ammo_grenade.png" ) },
	}
	
	function getAmmoIcon (id)
		local ply = LocalPlayer()
		local wep = ply:GetActiveWeapon()
		
		if ammoTypeIcons[id] then
			if id == 1 then
				if wep:GetClass() == "weapon_ar2" then
					return ammoTypeIcons[1].icon
				else
					return ICON_SIMPLE_RIFLE
				end
			else
				return ammoTypeIcons[id].icon
			end
		else
			return ammoTypeIcons[3].icon
		end
	end

	function drawText (text, font, x, y, color, alignx, aligny)
		local color_shadow = Color(0, 0, 0, 85)
		
		draw.SimpleText(text, font, x + 1, y + 1 + 50, color_shadow, alignx, aligny)
		draw.SimpleText(text, font, x, y + 50, color, alignx, aligny)
	end
	

	local MAX_SLOTS = 6
	local CACHE_TIME = 1
	local MOVE_SOUND = "common/wpn_moveselect.wav"
	local SELECT_SOUND = "common/wpn_select.wav"
	local PHYSGUN = "weapon_physgun"

	local physgunPickup = false
	local lastPhysgunBeam = CurTime()

	hook.Add("DrawPhysgunBeam", "HUDEHL2PhysgunPickup", function(ply, physgun, enabled, target, bone, hitPos)
		if (ply == LocalPlayer() and IsValid(target)) then physgunPickup = true; lastPhysgunBeam = CurTime(); end
	end)

	hook.Add("Think", "HUDEHL2PhysgunPickupThink", function()
		if (lastPhysgunBeam < CurTime() and physgunPickup) then
			physgunPickup = false;
		end
	end)

	local iCurSlot = 0
	local iCurPos = 1
	local flNextPrecache = 0
	local flSelectTime = 5
	local iWeaponCount = 0 

	local tCache = {}
	local tCacheLength = {}

	local defaultWeaponIcons = {
		['weapon_physgun'] = 	{ icon = 'h' },
		['weapon_physcannon'] = { icon = 'm', y = 2 },
		['weapon_pistol'] = 	{ icon = 'd' },
		['swb_pistol'] = 		{ icon = 'd' },
		['weapon_357'] = 		{ icon = 'e' },
		['swb_357'] = 			{ icon = 'e' },
		['weapon_shotgun'] = 	{ icon = 'b' },
		['swb_shotgun'] = 		{ icon = 'b' },
		['weapon_rpg'] = 		{ icon = 'i', y = 5 },
		['weapon_ar2'] = 		{ icon = 'l', y = 3 },
		['swb_ar2'] = 			{ icon = 'l', y = 3 },
		['swb_ar3'] = 			{ icon = 'l', y = 3 },
		['weapon_crowbar'] = 	{ icon = 'c' },
		['weapon_smg1'] = 		{ icon = 'a' },
		['swb_smg'] = 			{ icon = 'a' },
		['weapon_crossbow'] = 	{ icon = 'g' },
		['weapon_frag'] = 		{ icon = 'k', y = 4 },
		['weapon_slam'] = 		{ icon = 'o', y = 3 },
		['weapon_bugbait'] = 	{ icon = 'j' },
		['weapon_stunstick'] = 	{ icon = 'n' },
		['weapon_cp_stick'] = 	{ icon = 'n' },
	}

	local function drawSlot(x, y, w, h, wep, isSelected)
	
		local corner = 0
		local color_text = GetFractionColor(LocalPlayer():Team())
		local color_background = Color(0, 0, 0, 85)

		draw.RoundedBox(corner, x, y + 50, w, h, color_background)

		if (!IsValid(wep)) then return end

		if isSelected then
			local class = wep:GetClass()
			if (defaultWeaponIcons[class]) then
				local settings = defaultWeaponIcons[class]
				local shift = settings.y or 0
				drawText(settings.icon, "WeaponIcons", x + w/2, y + h/2 - 2 + shift, color_text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			elseif wep.DrawWeaponSelection then
				drawText("w", "WeaponIcons", x + w/2, y + h/2 - 2, color_text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end
		if wep:GetClass() == "furniture_placer" then
			drawText(wep:GetNWString("Rised_Furniture_Name"), "marske4", x + w/2, y + h - 5, color_text, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
		else
			drawText(wep:GetPrintName(), "marske4", x + w/2, y + h - 5, color_text, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
		end
	end

	local function drawHeader(x, y, w, h, num)
	
		local corner = 0
		local color_text = GetFractionColor(LocalPlayer():Team())
		local color_background = Color(0, 0, 0, 85)
		
		draw.RoundedBox(corner, x, y + 50, w, h, color_background)
		drawText(num, "marske4", x + w - 10, y + h - 5, color_text, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
	end

	local function DrawWeaponHUD()
		local p = LocalPlayer()

		local f = {}

		for _, pWeapon in pairs(p:GetWeapons()) do

			table.insert(f, pWeapon:GetSlot() + 1) 

		end

		if (!IsValid(p:GetActiveWeapon())) then return end

		local x = ScrW()/2 - 250
		for i=1, 6 do
			local y = 10
			if (i == iCurSlot) then
				local w = 200
				for k, wep in pairs(tCache[i]) do
					local isSelected = iCurPos == k
					local h = isSelected and 150 or 40
					drawSlot(x, y, w, h, wep, isSelected)
					y = y + h + 5
				end
				x = x + w + 10
			else

				if (table.HasValue(f, i)) then

					drawHeader(x, y, 50, 50, i)
					

					x = x + 60

				end
			end
		end
	end

	for i = 1, MAX_SLOTS do
		tCache[i] = {}
		tCacheLength[i] = 0
	end

	local pairs = pairs
	local tonumber = tonumber
	local RealTime = RealTime
	local LocalPlayer = LocalPlayer
	local string_lower = string.lower
	local input_SelectWeapon = input.SelectWeapon
	local fast_Switch = GetConVar("hud_fastswitch"):GetInt()
	local last_SelectWeapon

	function hasAmmoForWeapon(weapon)
		if not IsValid(weapon) then return false end;
		local PrimaryType = weapon:GetPrimaryAmmoType();
		local SecondaryType = weapon:GetSecondaryAmmoType();
		if (PrimaryType <= 0 and SecondaryType <= 0) then return true end;
		local clip = math.Clamp(weapon:Clip1(), 0, 1);
		local primary = math.Clamp(LocalPlayer():GetAmmoCount(weapon:GetPrimaryAmmoType()), 0, 1);
		local secondary = math.Clamp(LocalPlayer():GetAmmoCount(weapon:GetSecondaryAmmoType()), 0, 1);
		return (clip + primary + secondary) > 0;
	 end
	 
	local function GetUsableWeapons()
		local usableWeapons = {};

		for _, weapon in pairs(LocalPlayer():GetWeapons()) do
		  if hasAmmoForWeapon(weapon) then
			table.insert(usableWeapons, weapon);
		  end
		end
		
		return usableWeapons;
	 end

	local function PrecacheWeps()
		for i = 1, MAX_SLOTS do
			for j = 1, tCacheLength[i] do
				tCache[i][j] = nil
			end

			tCacheLength[i] = 0
		end

		flNextPrecache = RealTime() + CACHE_TIME
		iWeaponCount = 0

		for _, pWeapon in pairs(LocalPlayer():GetWeapons()) do
			iWeaponCount = iWeaponCount + 1

			local iSlot = pWeapon:GetSlot() + 1

			if (iSlot <= MAX_SLOTS) then
			
				local iLen = tCacheLength[iSlot] + 1
				tCacheLength[iSlot] = iLen
				tCache[iSlot][iLen] = pWeapon
			end
		end
		
		for i=1, MAX_SLOTS do
		  table.sort( tCache[i], function( a, b ) return a:GetSlotPos() < b:GetSlotPos() end );
		end

		if (iCurSlot ~= 0) then
			local iLen = tCacheLength[iCurSlot]

			if (iLen < iCurPos) then
				if (iLen == 0) then
					iCurSlot = 0
				else
					iCurPos = iLen
				end
			end
		end
	end

	hook.Add("HUDPaint", "HUDEHL2WeaponSelector", function()
		if (iCurSlot == 0) then
			return
		end

		local pPlayer = LocalPlayer()

		if (pPlayer:IsValid() and pPlayer:Alive() and (not pPlayer:InVehicle() or pPlayer:GetAllowWeaponsInVehicle())) then
			if (flNextPrecache <= RealTime()) then
				PrecacheWeps()
			end
			
			DrawWeaponHUD()
		else
			iCurSlot = 0
		end
	end)

	hook.Add("PlayerBindPress", "HUDEHL2WeaponSelector", function(pPlayer, sBind, bPressed)

		if (not pPlayer:Alive() or pPlayer:GetNWBool("Rised_Combot_Entered") or pPlayer:InVehicle() and not pPlayer:GetAllowWeaponsInVehicle() or (not pPlayer:GetActiveWeapon():IsValid() or (pPlayer:GetActiveWeapon():IsValid() and pPlayer:GetActiveWeapon():GetClass() == PHYSGUN and physgunPickup and table.HasValue({"invprev", "invnext"}, sBind)))) then
			return
		end

		if not bPressed then return end

		sBind = string_lower(sBind)

		if (sBind == "lastinv") and IsValid(last_SelectWeapon) then
			input_SelectWeapon(last_SelectWeapon)
			last_SelectWeapon = pPlayer:GetActiveWeapon()
		end

		if (sBind == "cancelselect") then
			if (bPressed) then
				iCurSlot = 0
			end

			return true
		end

		if (sBind == "invprev") then
			if (not bPressed) then
				return true
			end

			PrecacheWeps()

			if (iWeaponCount == 0 or table.Count(GetUsableWeapons()) <= 0) then
				return true
			end

			local bLoop = iCurSlot == 0

			if (bLoop) then
				local pActiveWeapon = pPlayer:GetActiveWeapon()

				if (pActiveWeapon:IsValid()) then
					local iSlot = pActiveWeapon:GetSlot() + 1
					local tSlotCache = tCache[iSlot]

					if (tSlotCache[1] ~= pActiveWeapon) then
						iCurSlot = iSlot
						iCurPos = 1

						for i = 2, tCacheLength[iSlot] do
							if (tSlotCache[i] == pActiveWeapon) then
								iCurPos = i - 1

								break
							end
						end
						flSelectTime = RealTime()
						pPlayer:EmitSound(MOVE_SOUND, 37)

						return true
					end

					iCurSlot = iSlot
				end
			end

			if (bLoop or iCurPos == 1) then
				repeat
					if (iCurSlot <= 1) then
						iCurSlot = MAX_SLOTS
					else
						iCurSlot = iCurSlot - 1
					end
				until(tCacheLength[iCurSlot] ~= 0)

				iCurPos = tCacheLength[iCurSlot]
			else
				iCurPos = iCurPos - 1
			end

			flSelectTime = RealTime()
			pPlayer:EmitSound(MOVE_SOUND, 37)
			
			return true
		end

		if (sBind == "invnext") then
			if (not bPressed) then
				return true
			end

			PrecacheWeps()

			if (iWeaponCount == 0 or table.Count(GetUsableWeapons()) <= 0) then
				return true
			end
			
			local bLoop = iCurSlot == 0

			if (bLoop) then
				local pActiveWeapon = pPlayer:GetActiveWeapon()

				if (pActiveWeapon:IsValid()) then
					local iSlot = pActiveWeapon:GetSlot() + 1
					local iLen = tCacheLength[iSlot]
					local tSlotCache = tCache[iSlot]

					if (tSlotCache[iLen] ~= pActiveWeapon) then
						iCurSlot = iSlot
						iCurPos = 1

						for i = 1, iLen - 1 do
							if (tSlotCache[i] == pActiveWeapon) then
								iCurPos = i + 1

								break
							end
						end

						flSelectTime = RealTime()
						pPlayer:EmitSound(MOVE_SOUND, 37)

						return true
					end

					iCurSlot = iSlot
				end
			end

			if (bLoop or iCurPos == tCacheLength[iCurSlot]) then
				repeat
					if (iCurSlot == MAX_SLOTS) then
						iCurSlot = 1
					else
						iCurSlot = iCurSlot + 1
					end
				until(tCacheLength[iCurSlot] ~= 0)

				iCurPos = 1
			else
				iCurPos = iCurPos + 1
			end

			flSelectTime = RealTime()
			pPlayer:EmitSound(MOVE_SOUND, 37)

			return true
		end

		if (sBind:sub(1, 4) == "slot") then
			local iSlot = tonumber(sBind:sub(5))

			if (iSlot == nil or iSlot <= 0 or iSlot > MAX_SLOTS) then
				return
			end

			if (not bPressed) then
				return true
			end

			PrecacheWeps()

			if (iWeaponCount == 0) then
				pPlayer:EmitSound(MOVE_SOUND, 37)

				return true
			end

			if (iSlot <= MAX_SLOTS) then
				if (iSlot == iCurSlot) then
					if (iCurPos == tCacheLength[iCurSlot]) then
						iCurPos = 1
					else
						iCurPos = iCurPos + 1
					end
				elseif (tCacheLength[iSlot] ~= 0) then
					iCurSlot = iSlot
					iCurPos = 1
				end

				flSelectTime = RealTime()
				pPlayer:EmitSound(MOVE_SOUND, 37)
			end

			return true
		end

		--timer.Create('RemoveThisShit', 2, 0, function()
		
			--flSelectTime = RealTime()
			--iCurSlot = 0
			--pPlayer:EmitSound(SELECT_SOUND, 37)

			--return true
		
		--end)

		if (iCurSlot ~= 0) then
			if (sBind == "+attack") then
				local pWeapon = NULL;
				if (iCurPos > 0) then
					pWeapon = tCache[iCurSlot][iCurPos];
				end
				iCurSlot = 0

				if (pWeapon:IsValid() and pWeapon ~= pPlayer:GetActiveWeapon()) then
					last_SelectWeapon = pPlayer:GetActiveWeapon()
					input_SelectWeapon(pWeapon)
				end

				flSelectTime = RealTime()
				pPlayer:EmitSound(SELECT_SOUND, 37)

				return true
			end

			if (sBind == "+attack2") then
				flSelectTime = RealTime()
				iCurSlot = 0
				pPlayer:EmitSound(SELECT_SOUND, 37)

				return true
			end
		end
	end)