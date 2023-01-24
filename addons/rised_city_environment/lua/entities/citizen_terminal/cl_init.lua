-- "addons\\rised_city_environment\\lua\\entities\\citizen_terminal\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

include('shared.lua')


cp_koef_zp = 1.12
ota_koef_zp = 1.12

cp_koef_cost = 60
ota_koef_cost = 60

rct_cost = 20
u03_cost = math.Round((rct_cost + rct_cost/5) + cp_koef_cost, 1)
u02_cost = math.Round((u03_cost + u03_cost/5) + cp_koef_cost, 1)
u01_cost = math.Round((u02_cost + u02_cost/5) + cp_koef_cost, 1)
helix_cost = math.Round((u01_cost + u01_cost/5) + cp_koef_cost, 1)
grid_cost = math.Round((helix_cost + helix_cost/5) + cp_koef_cost, 1)
judge_cost = math.Round((grid_cost + grid_cost/5) + cp_koef_cost, 1)
instr_cost = math.Round((judge_cost + judge_cost/5) + cp_koef_cost, 1)
ofc_cost = math.Round((instr_cost + instr_cost/5) + cp_koef_cost, 1)
cmr_cost = math.Round((ofc_cost + ofc_cost/5) + cp_koef_cost, 1)
sec_cost = math.Round((cmr_cost + cmr_cost/5) + cp_koef_cost, 1)
dispatch_cost = math.Round((sec_cost + sec_cost/5) + cp_koef_cost, 1)

echo_cost = helix_cost
apf_cost = math.Round((echo_cost + echo_cost/5) + ota_koef_cost, 1)
wall_cost = math.Round((apf_cost + apf_cost/5) + ota_koef_cost, 1)
guard_cost = math.Round((wall_cost + wall_cost/5) + ota_koef_cost, 1)
striker_cost = math.Round((guard_cost + guard_cost/5) + ota_koef_cost, 1)
razor_cost = math.Round((striker_cost + striker_cost/5) + ota_koef_cost, 1)
clown_cost = math.Round((razor_cost + razor_cost/5) + ota_koef_cost, 1)

function ENT:Initialize()
	self.Opened_MPF = false
end

local imgui = {}

imgui.skin = {
	background = Color(0, 0, 0, 0),
	backgroundHover = Color(0, 0, 0, 0),

	border = Color(255, 255, 255),
	borderHover = Color(255, 127, 0),
	borderPress = Color(255, 80, 0),

	foreground = Color(255, 255, 255),
	foregroundHover = Color(255, 127, 0),
	foregroundPress = Color(255, 80, 0),
}

local devCvar = GetConVar("developer")
function imgui.IsDeveloperMode()
	return not imgui.DisableDeveloperMode and devCvar:GetInt() > 0
end

local _devMode = false -- cached local variable updated once in a while

local localPlayer
local gState = {}

local function shouldAcceptInput()

	-- don't process input during non-main renderpass
	if render.GetRenderTarget() ~= nil then
		return false
	end

	-- don't process input if we're doing VGUI stuff (and not in context menu)
	if vgui.CursorVisible() and vgui.GetHoveredPanel() ~= g_ContextMenu then
		return false
	end

	return true
end

hook.Add("NotifyShouldTransmit", "IMGUI / ClearRenderBounds", function(ent, shouldTransmit)
	if shouldTransmit and ent._imguiRBExpansion then
		ent._imguiRBExpansion = nil
	end
end)

local traceResultTable = {}
local traceQueryTable = { output = traceResultTable, filter = {} }
local function isObstructed(eyePos, hitPos, ignoredEntity)
	local q = traceQueryTable
	q.start = eyePos
	q.endpos = hitPos
	q.filter[1] = localPlayer
	q.filter[2] = ignoredEntity

	local tr = util.TraceLine(q)
	if tr.Hit then
		return true, tr.Entity
	else
		return false
	end
end

function imgui.Start3D2D(pos, angles, scale, distanceHide, distanceFadeStart)
	if not IsValid(localPlayer) then
		localPlayer = LocalPlayer()
	end

	if gState.shutdown == true then
		return
	end

	if gState.rendering == true then
		print(
			"[IMGUI] Starting a new IMGUI context when previous one is still rendering" ..
			"Shutting down rendering pipeline to prevent crashes.."
		)
		gState.shutdown = true
		return false
	end

	_devMode = imgui.IsDeveloperMode()

	local eyePos = localPlayer:EyePos()
	local eyePosToPos = pos - eyePos

	-- OPTIMIZATION: Test that we are in front of the UI
	do
		local normal = angles:Up()
		local dot = eyePosToPos:Dot(normal)

		if _devMode then gState._devDot = dot end

		-- since normal is pointing away from surface towards viewer, dot<0 is visible
		if dot >= 0 then
			return false
		end
	end

	-- OPTIMIZATION: Distance based fade/hide
	if distanceHide then
		local distance = eyePosToPos:Length()
		if distance > distanceHide then
			return false
		end

		if _devMode then
			gState._devDist = distance
			gState._devHideDist = distanceHide
		end

		if distanceHide and distanceFadeStart and distance > distanceFadeStart then
			local blend = math.min(math.Remap(distance, distanceFadeStart, distanceHide, 1, 0), 1)
			render.SetBlend(blend)
			surface.SetAlphaMultiplier(blend)
		end
	end

	gState.rendering = true
	gState.pos = pos
	gState.angles = angles
	gState.scale = scale

	cam.Start3D2D(pos, angles, scale)

	-- calculate mousepos
	if not vgui.CursorVisible() or vgui.IsHoveringWorld() then
		local tr = localPlayer:GetEyeTrace()
		local eyepos = tr.StartPos
		local eyenormal

		if vgui.CursorVisible() and vgui.IsHoveringWorld() then
			eyenormal = gui.ScreenToVector(gui.MousePos())
		else
			eyenormal = tr.Normal
		end

		local planeNormal = angles:Up()

		local hitPos = util.IntersectRayWithPlane(eyepos, eyenormal, pos, planeNormal)
		if hitPos then
			local obstructed, obstructer = isObstructed(eyepos, hitPos, gState.entity)
			if obstructed then
				gState.mx = nil
				gState.my = nil

				if _devMode then gState._devInputBlocker = "collision " .. obstructer:GetClass() .. "/" .. obstructer:EntIndex() end
			else
				local diff = pos - hitPos

				-- This cool code is from Willox's keypad CalculateCursorPos
				local x = diff:Dot(-angles:Forward()) / scale
				local y = diff:Dot(-angles:Right()) / scale

				gState.mx = x
				gState.my = y
			end
		else
			gState.mx = nil
			gState.my = nil

			if _devMode then gState._devInputBlocker = "not looking at plane" end
		end
	else
		gState.mx = nil
		gState.my = nil

		if _devMode then gState._devInputBlocker = "not hovering world" end
	end

	if _devMode then gState._renderStarted = SysTime() end

	return true
end

function imgui.Entity3D2D(ent, lpos, lang, scale, ...)
	gState.entity = ent
	local ret = imgui.Start3D2D(ent:LocalToWorld(lpos), ent:LocalToWorldAngles(lang), scale, ...)
	if not ret then
		gState.entity = nil
	end
	return ret
end

local function calculateRenderBounds(x, y, w, h)
	local pos = gState.pos
	local fwd, right = gState.angles:Forward(), gState.angles:Right()
	local scale = gState.scale
	local firstCorner, secondCorner =
		pos + fwd * x * scale + right * y * scale,
		pos + fwd * (x + w) * scale + right * (y + h) * scale

	local minrb, maxrb = Vector(math.huge, math.huge, math.huge), Vector(-math.huge, -math.huge, -math.huge)

	minrb.x = math.min(minrb.x, firstCorner.x, secondCorner.x)
	minrb.y = math.min(minrb.y, firstCorner.y, secondCorner.y)
	minrb.z = math.min(minrb.z, firstCorner.z, secondCorner.z)
	maxrb.x = math.max(maxrb.x, firstCorner.x, secondCorner.x)
	maxrb.y = math.max(maxrb.y, firstCorner.y, secondCorner.y)
	maxrb.z = math.max(maxrb.z, firstCorner.z, secondCorner.z)

	return minrb, maxrb
end

function imgui.ExpandRenderBoundsFromRect(x, y, w, h)
	local ent = gState.entity
	if IsValid(ent) then
		-- make sure we're not applying same expansion twice
		local expansion = ent._imguiRBExpansion
		if expansion then
			local ex, ey, ew, eh = unpack(expansion)
			if ex == x and ey == y and ew == w and eh == h then
				return
			end
		end

		local minrb, maxrb = calculateRenderBounds(x, y, w, h)

		ent:SetRenderBoundsWS(minrb, maxrb)
		if _devMode then
			print("[IMGUI] Updated renderbounds of ", ent, " to ", minrb, "x", maxrb)
		end

		ent._imguiRBExpansion = {x, y, w, h}
	else
		if _devMode then
			print("[IMGUI] Attempted to update renderbounds when entity is not valid!! ", debug.traceback())
		end
	end
end

local devOffset = Vector(0, 0, 30)
local devColours = {
	background = Color(0, 0, 0, 200),
	title = Color(78, 205, 196),
	mouseHovered = Color(0, 255, 0),
	mouseUnhovered = Color(255, 0, 0),
	pos = Color(255, 255, 255),
	distance = Color(200, 200, 200, 200),
	ang = Color(255, 255, 255),
	dot = Color(200, 200, 200, 200),
	angleToEye = Color(200, 200, 200, 200),
	renderTime = Color(255, 255, 255),
	renderBounds = Color(0, 0, 255)
}

local function developerText(str, x, y, clr)
	draw.SimpleText(
		str, "DefaultFixedDropShadow", x, y, clr, TEXT_ALIGN_CENTER, nil
	)
end

local function drawDeveloperInfo()
	local camAng = localPlayer:EyeAngles()
	camAng:RotateAroundAxis(camAng:Right(), 90)
	camAng:RotateAroundAxis(camAng:Up(), -90)

	cam.IgnoreZ(true)
	cam.Start3D2D(gState.pos + devOffset, camAng, 0.15)

	local bgCol = devColours["background"]
	surface.SetDrawColor(bgCol.r, bgCol.g, bgCol.b, bgCol.a)
	surface.DrawRect(-100, 0, 200, 140)

	local titleCol = devColours["title"]
	developerText("imgui developer", 0, 5, titleCol)

	surface.SetDrawColor(titleCol.r, titleCol.g, titleCol.b)
	surface.DrawLine(-50, 16, 50, 16)

	local mx, my = gState.mx, gState.my
	if mx and my then
		developerText(
			string.format("mouse: hovering %d x %d", mx, my),
			0, 20, devColours["mouseHovered"]
		)
	else
		developerText(
			string.format("mouse: %s", gState._devInputBlocker or ""),
			0, 20, devColours["mouseUnhovered"]
		)
	end

	local pos = gState.pos
	developerText(
		string.format("pos: %.2f %.2f %.2f", pos.x, pos.y, pos.z),
		0, 40, devColours["pos"]
	)

	developerText(
		string.format("distance %.2f / %.2f", gState._devDist or 0, gState._devHideDist or 0),
		0, 53, devColours["distance"]
	)

	local ang = gState.angles
	developerText(string.format("ang: %.2f %.2f %.2f", ang.p, ang.y, ang.r), 0, 75, devColours["ang"])
	developerText(string.format("dot %d", gState._devDot or 0), 0, 88, devColours["dot"])

	local angToEye = (pos - localPlayer:EyePos()):Angle()
	angToEye:RotateAroundAxis(ang:Up(), -90)
	angToEye:RotateAroundAxis(ang:Right(), 90)

	developerText(
		string.format("angle to eye (%d,%d,%d)", angToEye.p, angToEye.y, angToEye.r),
		0, 100, devColours["angleToEye"]
	)

	developerText(
		string.format("rendertime avg: %.2fms", (gState._devBenchAveraged or 0) * 1000),
		0, 120, devColours["renderTime"]
	)

	cam.End3D2D()
	cam.IgnoreZ(false)

	local ent = gState.entity
	if IsValid(ent) and ent._imguiRBExpansion then
		local ex, ey, ew, eh = unpack(ent._imguiRBExpansion)
		local minrb, maxrb = calculateRenderBounds(ex, ey, ew, eh)
		render.DrawWireframeBox(vector_origin, angle_zero, minrb, maxrb, devColours["renderBounds"])
	end
end

function imgui.End3D2D()
	if gState then
		if _devMode then
			local renderTook = SysTime() - gState._renderStarted
			gState._devBenchTests = (gState._devBenchTests or 0) + 1
			gState._devBenchTaken = (gState._devBenchTaken or 0) + renderTook
			if gState._devBenchTests == 100 then
				gState._devBenchAveraged = gState._devBenchTaken / 100
				gState._devBenchTests = 0
				gState._devBenchTaken = 0
			end
		end

		gState.rendering = false
		cam.End3D2D()
		render.SetBlend(1)
		surface.SetAlphaMultiplier(1)

		if _devMode then
			drawDeveloperInfo()
		end

		gState.entity = nil
	end
end

function imgui.CursorPos()
	local mx, my = gState.mx, gState.my
	return mx, my
end

function imgui.IsHovering(x, y, w, h)
	local mx, my = gState.mx, gState.my
	return mx and my and mx >= x and mx <= (x + w) and my >= y and my <= (y + h)
end
function imgui.IsPressing()
	return shouldAcceptInput() and gState.pressing
end
function imgui.IsPressed()
	return shouldAcceptInput() and gState.pressed
end

-- String->Bool mappings for whether font has been created
local _createdFonts = {}

-- Cached IMGUIFontNamd->GModFontName
local _imguiFontToGmodFont = {}

local EXCLAMATION_BYTE = string.byte("!")
function imgui.xFont(font, defaultSize)
	-- special font
	if string.byte(font, 1) == EXCLAMATION_BYTE then

		local existingGFont = _imguiFontToGmodFont[font]
		if existingGFont then
			return existingGFont
		end

		-- Font not cached; parse the font
		local name, size = font:match("!([^@]+)@(.+)")
		if size then size = tonumber(size) end

		if not size and defaultSize then
			name = font:match("^!([^@]+)$")
			size = defaultSize
		end

		local fontName = string.format("IMGUI_%s_%d", name, size)
		_imguiFontToGmodFont[font] = fontName
		if not _createdFonts[fontName] then
			surface.CreateFont(fontName, {
				font = name,
				size = size
			})
			_createdFonts[fontName] = true
		end

		return fontName
	end
	return font
end

function imgui.xButton(x, y, w, h, borderWidth, borderClr, hoverClr, pressColor)
	local bw = borderWidth or 1

	local bgColor = imgui.IsHovering(x, y, w, h) and imgui.skin.backgroundHover or imgui.skin.background
	local borderColor =
		((imgui.IsPressing() and imgui.IsHovering(x, y, w, h)) and (pressColor or imgui.skin.borderPress))
		or (imgui.IsHovering(x, y, w, h) and (hoverClr or imgui.skin.borderHover))
		or (borderClr or imgui.skin.border)

	surface.SetDrawColor(bgColor)
	surface.DrawRect(x, y, w, h)

	if bw > 0 then
		surface.SetDrawColor(borderColor)

		surface.DrawRect(x, y, w, bw)
		surface.DrawRect(x, y + bw, bw, h - bw * 2)
		surface.DrawRect(x, y + h-bw, w, bw)
		surface.DrawRect(x + w - bw + 1, y, bw, h)
	end

	return shouldAcceptInput() and imgui.IsHovering(x, y, w, h) and gState.pressed
end

function imgui.xCursor(x, y, w, h)
	local fgColor = imgui.IsPressing() and imgui.skin.foregroundPress or imgui.skin.foreground
	local mx, my = gState.mx, gState.my

	if not mx or not my then return end

	if x and w and (mx < x or mx > x + w) then return end
	if y and h and (my < y or my > y + h) then return end

	local cursorSize = math.ceil(0.3 / gState.scale)
	surface.SetDrawColor(fgColor)
	surface.DrawLine(mx - cursorSize, my, mx + cursorSize, my)
	surface.DrawLine(mx, my - cursorSize, mx, my + cursorSize)
end

function imgui.xTextButton(text, font, x, y, w, h, borderWidth, color, hoverClr, pressColor)
	local fgColor =
		((imgui.IsPressing() and imgui.IsHovering(x, y, w, h)) and (pressColor or imgui.skin.foregroundPress))
		or (imgui.IsHovering(x, y, w, h) and (hoverClr or imgui.skin.foregroundHover))
		or (color or imgui.skin.foreground)

	local clicked = imgui.xButton(x, y, w, h, borderWidth, color, hoverClr, pressColor)

	font = imgui.xFont(font, math.floor(h * 0.618))
	draw.SimpleText(text, font, x + w / 2, y + h / 2, fgColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	return clicked
end

local breakLineLimit = 350
function imgui.xTextButtonLeft(text, font, x, y, w, h, borderWidth, color, hoverClr, pressColor)
	local fgColor =
		((imgui.IsPressing() and imgui.IsHovering(x, y, w, h)) and (pressColor or imgui.skin.foregroundPress))
		or (imgui.IsHovering(x, y, w, h) and (hoverClr or imgui.skin.foregroundHover))
		or (color or imgui.skin.foreground)

	local clicked = imgui.xButton(x, y, w, h, borderWidth, color, hoverClr, pressColor)

	font = imgui.xFont(font, math.floor(h * 0.618))
	
	local width, height = surface.GetTextSize(text)
	local linesCount = 1
	if width - breakLineLimit > 0 then linesCount = math.ceil(width / breakLineLimit) end

	local newLine = ""
	local i = 0

	if linesCount > 1 then
		local wordsArr = string.gmatch(text, "[^%s,]+")
		for word in wordsArr do
			local lineWidth, lineHeight = surface.GetTextSize(newLine)
			local wordWidth, wordHeight = surface.GetTextSize(word)
			if wordWidth + lineWidth > breakLineLimit then
				draw.SimpleText(newLine, font, x + w / 2, y + h / 2 + i * 15, fgColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
				newLine = word
				i = i + 1
			elseif lineWidth > breakLineLimit then
				draw.SimpleText(newLine, font, x + w / 2, y + h / 2 + i * 15, fgColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
				newLine = ""
				i = i + 1
			else
				newLine = newLine .. " " .. word
			end
		end
		draw.SimpleText(newLine, font, x + w / 2, y + h / 2 + i * 15, fgColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
		i = i + 1
	else
		draw.SimpleText(text, font, x + w / 2 + 5, y + h / 2, fgColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
	end

	return clicked
end

-- 3D2D UI should be rendered in translucent pass, so this should be either TRANSLUCENT or BOTH
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

local cursor_mat = Material("icon16/cursor.png", "noclamp smooth")

local migaet_count = 0
local isMigaet = false

local law_page = 1

function ENT:DrawTranslucent()
	
	self:DrawModel()
	
	if LocalPlayer():GetPos():Distance(self:GetPos()) > 150 then return end

	if shouldAcceptInput() then
		local wasPressing = gState.pressing
		gState.pressing = input.IsMouseDown(MOUSE_LEFT) or input.IsKeyDown(KEY_E)
		gState.pressed = not wasPressing and gState.pressing
	end
	
	if imgui.Entity3D2D(self, Vector(12.8, -5, 19), Angle(0, 88, 90), 0.04) then


		local texturedQuadStructure = {
			texture = surface.GetTextureID( "models/props_combine/combine_interface_disp" ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= -50,
			y 	= 0,
			w 	= 410,
			h 	= 360
		}
		draw.TexturedQuad( texturedQuadStructure )
		draw.RoundedBox(1,-44,0,410,360,Color(15,15,35,225))
		
		if migaet_count > 200 and !isMigaet then
			isMigaet = true
		elseif migaet_count <= 0 and isMigaet then
			isMigaet = false
		end

		if !isMigaet then
			migaet_count = migaet_count + 1
		else
			migaet_count = migaet_count - 1
		end

		if isMigaet then
			if GetGlobalBool("DarkRP_LockdownCodeRed") then
				draw.RoundedBox(1,-44,0,410,360,Color(255,0,0,math.random(65,75)))
			elseif GetGlobalBool("DarkRP_LockdownCodeOrange") then
				draw.RoundedBox(1,-44,0,410,360,Color(255,165,0,75))
			elseif GetGlobalBool("DarkRP_LockdownCodeYellow") then
				draw.RoundedBox(1,-44,0,410,360,Color(255,255,0,10))
			elseif GetGlobalBool("DarkRP_LockdownCodeMiss") or GetGlobalBool("DarkRP_LockdownCodeHome") or GetGlobalBool("DarkRP_LockdownCodeIdent") then
				draw.RoundedBox(1,-44,0,410,360,Color(0,0,125,50))
			elseif GetGlobalBool("DarkRP_LockdownBiohazard") then
				draw.RoundedBox(1,-44,0,410,360,Color(0,125,0,50))
			elseif GetGlobalBool("DarkRP_LockdownWorkphase") then
				draw.RoundedBox(1,-44,0,410,360,Color(255,255,255,10))
			end
		end

		if self:GetNWBool("Opened_NAV") then

			local ply = LocalPlayer()
			local playerpos = ply:GetPos()
			local arrow_icon = Material( "icon16/arrow_up.png" )

			if imgui.xTextButton("< < < < <", "marske12", 20, 30, 100, 25, 0, Color(255, 255, 255), Color(255,165,0), Color(0,0,0)) then
				self:SetNWBool("Opened_NAV", false)
				self:EmitSound("buttons/combine_button3.wav")
			end
			
			if imgui.xTextButton("Нексус надзора", "marske5", 5, 75, 300, 25, 1, Color(255, 255, 255), Color(255,165,0), Color(50,50,50)) then
				hook.Add( "HUDPaint", "HUDInfoMarker01", function()
					local markerPos = RISED.Config.Tutorial.Marks.Nexus
					local pos = markerPos:ToScreen()
					local dist = markerPos:Distance( LocalPlayer():GetPos() )
							
					surface.SetDrawColor( color_white )
					surface.SetMaterial( arrow_icon )
					surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
							
					dist = math.Round( ( dist / 17.3 ) - 3, 0 )
					
					if dist >= 2 && ply:IsValid() then
						draw.SimpleText( dist .. "m | " .. "Нексус Надзора", "zejton20", pos.x + 21, pos.y, color_orange )
					elseif ply:IsValid() then
						hook.Remove( "HUDPaint", "HUDInfoMarker01" )
					end
				end )
				self:EmitSound("buttons/combine_button5.wav")
				self:SetNWBool("Opened_NAV", false)
			end
		
			if imgui.xTextButton("Гражданский центр", "marske5", 5, 115, 300, 25, 1, Color(255, 255, 255), Color(255,165,0), Color(50,50,50)) then
				hook.Add( "HUDPaint", "HUDInfoMarker02", function()
					local markerPos = RISED.Config.Tutorial.Marks.CivilCenter
					local pos = markerPos:ToScreen()
					local dist = markerPos:Distance( LocalPlayer():GetPos() )
									
					surface.SetDrawColor( color_white )
					surface.SetMaterial( arrow_icon )
					surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
									
					dist = math.Round( ( dist / 17.3 ) - 3, 0 )
					if dist >= 2 then
						draw.SimpleText( dist .. "m " .. "Гражданский центр", "zejton20", pos.x + 21, pos.y, color_orange )
					elseif ply:IsValid() then
						hook.Remove( "HUDPaint", "HUDInfoMarker02" )
					end
				end )
				self:EmitSound("buttons/combine_button5.wav")
				self:SetNWBool("Opened_NAV", false)
			end

			if imgui.xTextButton("Раздатчики рационов", "marske5", 5, 155, 300, 25, 1, Color(255, 255, 255), Color(255,165,0), Color(50,50,50)) then
				hook.Add( "HUDPaint", "HUDInfoMarker03", function()
					local markerPos = RISED.Config.Tutorial.Marks.RationsDispenser
					local pos = markerPos:ToScreen()
					local dist = markerPos:Distance( LocalPlayer():GetPos() )
									
					surface.SetDrawColor( color_white )
					surface.SetMaterial( arrow_icon )
					surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
									
					dist = math.Round( ( dist / 17.3 ) - 3, 0 )
					if dist >= 2 then
						draw.SimpleText( dist .. "m " .. "Раздатчики рационов питания", "zejton20", pos.x + 21, pos.y, color_orange )
					elseif ply:IsValid() then
						hook.Remove( "HUDPaint", "HUDInfoMarker03" )
					end
				end )
				self:EmitSound("buttons/combine_button5.wav")
				self:SetNWBool("Opened_NAV", false)
			end
		
			if imgui.xTextButton("Завод ГСР", "marske5", 5, 195, 300, 25, 1, Color(255, 255, 255), Color(255,165,0), Color(50,50,50)) then
				hook.Add( "HUDPaint", "HUDInfoMarker04", function()
					local markerPos = RISED.Config.Tutorial.Marks.FactoryRations
					local pos = markerPos:ToScreen()
					local dist = markerPos:Distance( LocalPlayer():GetPos() )
									
					surface.SetDrawColor( color_white )
					surface.SetMaterial( arrow_icon )
					surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
									
					dist = math.Round( ( dist / 17.3 ) - 3, 0 )
					if dist >= 2 then
						draw.SimpleText( dist .. "m " .. "Завод ГСР", "zejton20", pos.x + 21, pos.y, color_orange )
					elseif ply:IsValid() then
						hook.Remove( "HUDPaint", "HUDInfoMarker04" )
					end
				end )
				self:EmitSound("buttons/combine_button5.wav")
				self:SetNWBool("Opened_NAV", false)
			end
		
			if imgui.xTextButton("Больница", "marske5", 5, 235, 300, 25, 1, Color(255, 255, 255), Color(255,165,0), Color(50,50,50)) then
				hook.Add( "HUDPaint", "HUDInfoMarker05", function()
					local markerPos = RISED.Config.Tutorial.Marks.Hospital
					local pos = markerPos:ToScreen()
					local dist = markerPos:Distance( LocalPlayer():GetPos() )
									
					surface.SetDrawColor( color_white )
					surface.SetMaterial( arrow_icon )
					surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
									
					dist = math.Round( ( dist / 17.3 ) - 3, 0 )
					if dist >= 2 then
						draw.SimpleText( dist .. "m " .. "Больница", "zejton20", pos.x + 21, pos.y, color_orange )
					elseif ply:IsValid() then
						hook.Remove( "HUDPaint", "HUDInfoMarker05" )
					end
				end )
				self:EmitSound("buttons/combine_button5.wav")
				self:SetNWBool("Opened_NAV", false)
			end

			if imgui.xTextButton("Верховная партия Альянса", "marske5", 5, 275, 300, 25, 1, Color(255, 255, 255), Color(255,165,0), Color(50,50,50)) then
				hook.Add( "HUDPaint", "HUDInfoMarker06", function()
					local markerPos = RISED.Config.Tutorial.Marks.Party
					local pos = markerPos:ToScreen()
					local dist = markerPos:Distance( LocalPlayer():GetPos() )
									
					surface.SetDrawColor( color_white )
					surface.SetMaterial( arrow_icon )
					surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
									
					dist = math.Round( ( dist / 17.3 ) - 3, 0 )
					if dist >= 2 then
						draw.SimpleText( dist .. "m " .. "Верховная партия Альянса", "zejton20", pos.x + 21, pos.y, color_orange )
					elseif ply:IsValid() then
						hook.Remove( "HUDPaint", "HUDInfoMarker06" )
					end
				end )
				self:EmitSound("buttons/combine_button5.wav")
				self:SetNWBool("Opened_NAV", false)
			end
		elseif self:GetNWBool("Opened_Laws_Menu") then
			local today = os.date("%d.%m.%Y", os.time())
			draw.SimpleText("C17 Industrial", imgui.xFont("marske6"), -35, 20, Color(255, 165, 0))
			draw.SimpleText(GetGlobalFloat("HoursTimeFloat") .. " : " .. GetGlobalFloat("MinutsTimeFloat"), imgui.xFont("marske8"), 250, 10, Color(255, 165, 0))
			draw.SimpleText("________________________________________________", imgui.xFont("marske6"), -35, 30, Color(255, 165, 0))
			draw.SimpleText("Гражданский терминал", imgui.xFont("marske8"), -35, 50, Color(255, 255, 255))
			draw.SimpleText("________________________________________________", imgui.xFont("marske6"), -35, 62, Color(255, 165, 0))

			local bx = -25
			local by = 70
			
			if imgui.xTextButton("Назад", "TargetIDSmall", 0, 320, 125, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
				self:SetNWBool("Opened_Laws_Menu", false)
				self:EmitSound("buttons/button15.wav")
			end
			
			local pages = 1
			local lines_summary = 0
			local skip_lines = 0
			local max_lines = 9
			local start_law_index = 1
			for k,law in pairs(RISED.Config.Laws) do
				
				if k < start_law_index then continue end

				local mLines = toLines(law, "TargetIDSmall", 400)

				if (lines_summary + #mLines + skip_lines) > max_lines * law_page then break end
				if (lines_summary + #mLines + skip_lines) <= max_lines * (law_page - 1) then
					local cur_lines = 0
					for k3,next_law in pairs(RISED.Config.Laws) do
						if k3 > k then
							local mLines2 = #toLines(next_law, "TargetIDSmall", 400)
							cur_lines = cur_lines + mLines2
							if (#mLines + cur_lines) == 9 then
								start_law_index = k3 + 1
								skip_lines = skip_lines + (max_lines - lines_summary)
								break
							elseif (#mLines + cur_lines) > 9 then
								start_law_index = k3
								skip_lines = skip_lines + (max_lines - lines_summary)
								break
							end
						end
					end
				else
					local offset_y = lines_summary
					local local_lines = 0
					local button_y = 0
					for k2,line in pairs(mLines) do
						draw.SimpleText(line, "TargetIDSmall", bx - 10, by + 15 + (k2 - 1 + offset_y) * 25, Color(255,255,255))
						button_y = by + offset_y * 25
						lines_summary = lines_summary + 1
						local_lines = local_lines + 1
					end
				end

				pages = math.ceil((lines_summary + skip_lines) / 9) + 1
			end
			
			draw.SimpleText("страница: " .. law_page, imgui.xFont("TargetIDSmall"), bx+240, 320)
			if imgui.xTextButton("< < <", "TargetIDSmall", bx+220, 335, 50, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
				law_page = math.Clamp(law_page - 1, 1, pages)
				self:EmitSound("buttons/button15.wav")
			end
			if imgui.xTextButton("> > >", "TargetIDSmall", bx+290, 335, 50, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
				law_page = math.Clamp(law_page + 1, 1, pages)
				self:EmitSound("buttons/button15.wav")
			end
		else
			draw.SimpleText("C17 Industrial", imgui.xFont("marske6"), -35, 20, Color(255, 165, 0))
			draw.SimpleText(GetGlobalFloat("HoursTimeFloat") .. " : " .. GetGlobalFloat("MinutsTimeFloat"), imgui.xFont("marske8"), 250, 10, Color(255, 165, 0))
			draw.SimpleText("________________________________________________", imgui.xFont("marske6"), -35, 30, Color(255, 165, 0))
			draw.SimpleText("Гражданский терминал", imgui.xFont("marske8"), -35, 50, Color(255, 255, 255))
			draw.SimpleText("________________________________________________", imgui.xFont("marske6"), -35, 62, Color(255, 165, 0))


			local city_status = "Штатный режим."
			if GetGlobalBool("DarkRP_LockdownCodeRed") then
				city_status = "Угроза стабильности."
			elseif GetGlobalBool("DarkRP_LockdownCodeOrange") then
				city_status = "Массовые беспорядки."
			elseif GetGlobalBool("DarkRP_LockdownCodeYellow") then
				city_status = "Локальные беспорядки."
			elseif GetGlobalBool("DarkRP_LockdownCodeGreen") then
				city_status = "Штатный режим."

			elseif GetGlobalBool("DarkRP_LockdownCodeMiss") then
				city_status = "Отклонение численности населения. Сотрудничество награждается."
			elseif GetGlobalBool("DarkRP_LockdownCodeHome") then
				city_status = "Инспекционная фаза."
			elseif GetGlobalBool("DarkRP_LockdownCodeIdent") then
				city_status = "Проверка идентификации. Всем прийти к нексусу."

			elseif GetGlobalBool("DarkRP_LockdownBiohazard") then
				city_status = "Биологическая угроза."
			elseif GetGlobalBool("DarkRP_LockdownWorkphase") then
				city_status = "Рабочая фаза."
			end

			drawMultiLine("Статус города: " .. city_status, "marske5", 375, 25, -15, 100, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
			local offset_y = 145
			if imgui.xTextButton("Информация по зарплате", "marske5", 0, offset_y + 35 * 1, 300, 25, 1, Color(255, 255, 255), Color(255,165,0), Color(0,0,0)) then
				net.Start("RisedTerminal_Civil:Server")
				net.WriteString("Информация по зарплате")
				net.SendToServer()
				
				chat.AddText( Color( 51, 255, 119 ), "***********************")
				chat.AddText( Color( 128, 255, 245 ), "Гражданин: " .. LocalPlayer():Name())
				chat.AddText( Color( 128, 255, 245 ), "Неподтвержденные токены: " .. LocalPlayer():GetNWInt("Player_SalaryPoint", 0))
				chat.AddText( Color( 128, 255, 245 ), "Неподтвержденные очки лояльности: " .. LocalPlayer():GetNWInt("Player_LoyaltyPoint", 0))
				chat.AddText( Color( 128, 255, 245 ), "Для подтверждения обратитесь к сотрудникам Партии Альянса")
				chat.AddText( Color( 51, 255, 119 ), "***********************")
				self:EmitSound("buttons/combine_button1.wav")
			end
			if imgui.xTextButton("Навигация по городу", "marske5", 0, offset_y + 35 * 2, 300, 25, 1, Color(255, 255, 255), Color(255,165,0), Color(0,0,0)) then
				self:SetNWBool("Opened_NAV", true)
				self:EmitSound("buttons/combine_button1.wav")
			end
			if imgui.xTextButton("Законы сектора", "marske5", 0, offset_y + 35 * 3, 300, 25, 1, Color(255, 255, 255), Color(255,165,0), Color(0,0,0)) then
				self:SetNWBool("Opened_Laws_Menu", true)
				self:EmitSound("buttons/combine_button1.wav")
			end
			if imgui.xTextButton("Вызвать ГО", "marske5", 0, offset_y + 35 * 4, 300, 25, 1, Color(255, 255, 255), Color(255,165,0), Color(0,0,0)) then
				net.Start("RisedTerminal_Civil:Server")
				net.WriteString("Вызов ГО")
				net.SendToServer()
				self:EmitSound("buttons/combine_button1.wav")
			end
		end
		
		local cursor_x, cursor_y = imgui.CursorPos()
		if cursor_x == nil or cursor_y == nil then
			cursor_x, cursor_y = 0,0
		end
		cursor_x = math.Clamp(cursor_x, 0, 430)
		cursor_y = math.Clamp(cursor_y, 0, 360)

		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(cursor_mat)
		surface.DrawTexturedRect(cursor_x, cursor_y, 10, 10)

		imgui.End3D2D()
	end
end

hook.Add("PostDrawTranslucentRenderables", "PaintIMGUI", function(bDrawingSkybox, bDrawingDepth)
  -- Don't render during depth pass
  if bDrawingDepth then return end

  -- Starts the 3D2D context at given position, angle and scale.
  -- First 3 arguments are equivalent to cam.Start3D2D arguments.
  -- Fourth argument is the distance at which the UI panel won't be rendered anymore
  -- Fifth argument is the distance at which the UI will start fading away
  -- Function returns boolean indicating whether we should proceed with the rendering, hence the if statement
  -- These specific coordinates are for gm_construct at next to spawn
  if imgui.Start3D2D(Vector(980, -83, -79), Angle(0, 270, 90), 0.1, 200, 150) then
    -- This is a regular 3D2D context, so you can use normal surface functions to draw things
    surface.SetDrawColor(255, 127, 0)
    surface.DrawRect(0, 0, 100, 20)
    
    -- The main priority of the library is providing interactable panels
    -- This creates a clickable text button at x=0, y=30 with width=100, height=25
    -- The first argument is text to render inside button
    -- The second argument is special font syntax, that dynamically creates font "Roboto" at size 24
    -- The special syntax is just for convinience; you can use normal Garry's Mod font names in place
    -- The third, fourth, fith and sixth arguments are for x, y, width and height
    -- The seventh argument is the border width (optional)
    -- The last 3 arguments are for color, hover color, and press color (optional)
    if imgui.xTextButton("Foo bar", "!Roboto@24", 0, 30, 100, 25, 1, Color(255,255,255), Color(0,0,255), Color(255,0,0)) then
      -- the xTextButton function returns true, if user clicked on this area during this frame
      print("yay, we were clicked :D")
    end
  
    -- End the 3D2D context
    imgui.End3D2D()
  end
end)


