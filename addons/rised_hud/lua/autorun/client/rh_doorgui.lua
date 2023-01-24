-- "addons\\rised_hud\\lua\\autorun\\client\\rh_doorgui.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local black = Color(0, 0, 0, 255)
local white = Color(255, 255, 255, 200)
local red = Color(128, 30, 30, 255)

local function DrawDarkRPDoorInfo(door,ex,why)
	local blocked = door:getKeysNonOwnable()
	local superadmin = LocalPlayer():IsSuperAdmin()
	local doorTeams = door:getKeysDoorTeams()
	local doorGroup = door:getKeysDoorGroup()
	local owned = door:isKeysOwned() or doorGroup or doorTeams

	local doorInfo = {}

	local title = door:getKeysTitle()
	--if title then table.insert(doorInfo, title) end

	if owned then
		--table.insert(doorInfo, DarkRP.getPhrase("keys_owned_by"))
	end

	if door:isKeysOwned() then
		table.insert(doorInfo, door:getDoorOwner():Nick())
		for k,v in pairs(door:getKeysCoOwners() or {}) do
			local ent = Player(k)
			if not IsValid(ent) or not ent:IsPlayer() then continue end
			table.insert(doorInfo, ent:Nick())
		end

		local allowedCoOwn = door:getKeysAllowedToOwn()
		if allowedCoOwn and not fn.Null(allowedCoOwn) then
			table.insert(doorInfo, DarkRP.getPhrase("keys_other_allowed"))

			for k,v in pairs(allowedCoOwn) do
				local ent = Player(k)
				if not IsValid(ent) or not ent:IsPlayer() then continue end
				table.insert(doorInfo, ent:Nick())
			end
		end
	elseif doorGroup then
		table.insert(doorInfo, doorGroup)
	elseif doorTeams then
		for k, v in pairs(doorTeams) do
			if not v or not RPExtraTeams[k] then continue end

			table.insert(doorInfo, RPExtraTeams[k].name)
		end
	elseif blocked and superadmin then
		table.insert(doorInfo, DarkRP.getPhrase("keys_allow_ownership"))
	elseif not blocked then
		table.insert(doorInfo, DarkRP.getPhrase("keys_unowned"))
		if superadmin then
			table.insert(doorInfo, DarkRP.getPhrase("keys_disallow_ownership"))
		end
	end

	if door:IsVehicle() then
		for k,v in pairs(player.GetAll()) do
			if v:GetVehicle() ~= door then continue end

			table.insert(doorInfo, DarkRP.getPhrase("driver", v:Nick()))
			break
		end
	end
	local isCombineDoor = false
	if table.HasValue(doorInfo, "Альянс") then
		isCombineDoor = true
	end

	if isCombineDoor then
		local x, y = ex, why
		if title != nil then
			draw.DrawNonParsedText(title, "marske6", x, y-25, Color(255,165,0), 1)
		end
		draw.DrawNonParsedText(table.concat(doorInfo, "\n"), "marske4", x, y + 10, Color(255,165,0, 75), 1)
	else
		local x, y = ex, why
		if door:GetNWString("Door_Name", "") != "" then
			draw.DrawNonParsedText(door:GetNWString("Door_Name", ""), "methFont", x, y-25, Color(255,255,225), 1)
		elseif title != nil then
			draw.DrawNonParsedText(title, "methFont", x, y-25, Color(255,255,225), 1)
		end

		if door:GetNWString("Door_OwnerName", "") != "" then
			drawMultiLine(door:GetNWString("Door_OwnerName", ""), "methFont", 200, 25, x, y + 25, Color(255,255,225, 75), 1, 1, 0, Color(255,165,0, 15))
		else
			draw.DrawNonParsedText(table.concat(doorInfo, "\n"), "methFont", x, y + 10, Color(255,255,225, 75), 1)
		end
	end

end

local function Draw3DDoor2(door)
	if door:GetClass() and door:GetClass() != "prop_door_rotating" then return end
	
	local ang = door:GetAngles()
	
	cam.Start3D()
	
		ang:RotateAroundAxis(ang:Right(), 90)
		ang:RotateAroundAxis(ang:Up(), -90)
		
		cam.Start3D2D( door:GetPos() + ang:Forward() * -47 + ang:Up() + ang:Right() * -54, ang, 0.12 )
			DrawDarkRPDoorInfo(door,200,450)
		cam.End3D2D()
		
		ang:RotateAroundAxis(ang:Right(), 180)
		
		cam.Start3D2D( door:GetPos() + ang:Forward() * -47 + ang:Up() + ang:Right() * -54, ang, 0.12 )
			DrawDarkRPDoorInfo(door,575,450)
		cam.End3D2D()
		
	cam.End3D()
	
	return true
end
hook.Add("HUDDrawDoorData","Door_Draw_3D_Data",Draw3DDoor2)