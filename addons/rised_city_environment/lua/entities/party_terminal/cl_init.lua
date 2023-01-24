-- "addons\\rised_city_environment\\lua\\entities\\party_terminal\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

AddCSLuaFile("imgui.lua")
include('shared.lua')

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

function imgui.xTextButtonLeft(text, font, x, y, w, h, borderWidth, color, hoverClr, pressColor)
	local fgColor =
		((imgui.IsPressing() and imgui.IsHovering(x, y, w, h)) and (pressColor or imgui.skin.foregroundPress))
		or (imgui.IsHovering(x, y, w, h) and (hoverClr or imgui.skin.foregroundHover))
		or (color or imgui.skin.foreground)

	local clicked = imgui.xButton(x, y, w, h, borderWidth, color, hoverClr, pressColor)

	font = imgui.xFont(font, math.floor(h * 0.618))
	draw.SimpleText(text, font, x, y, fgColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)

	return clicked
end

function imgui.xTextButtonMultiline(text, font, mWidth, x, y, w, h, borderWidth, color, hoverClr, pressColor)
	local mLines = toLines(text, font, mWidth)

	for i,line in pairs(mLines) do
		if oWidth and oColor then
			draw.SimpleTextOutlined(line, font, x, y + (i - 1) * 25, color, alignX, alignY, oWidth, oColor)
		else
			draw.SimpleText(line, font, x, y + (i - 1) * 25, color, alignX, alignY)
		end
	end
		
	local clicked = imgui.xButton(x, y, w, h, borderWidth, color, hoverClr, pressColor)
	return clicked
end

function ENT:Draw()
	self:DrawModel()
end


ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

local cursor_mat = Material("icon16/cursor.png", "noclamp smooth")

local law_page = 1

function ENT:DrawTranslucent()
	
	self:DrawModel()
	
	if LocalPlayer():GetPos():Distance(self:GetPos()) > 150 then return end

	if shouldAcceptInput() then
		local wasPressing = gState.pressing
		gState.pressing = input.IsMouseDown(MOUSE_LEFT) or input.IsKeyDown(KEY_E)
		gState.pressed = not wasPressing and gState.pressing
	end
	
	if imgui.Entity3D2D(self, Vector(11.7, -9, 11.4), Angle(0, 90, 85), 0.042) then


		local texturedQuadStructure = {
			texture = surface.GetTextureID( "phoenix_storms/black_chrome" ),
			color   = Color( 255, 255, 255, 1 ),
			x 	= 0,
			y 	= 0,
			w 	= 430,
			h 	= 360
		}
		draw.TexturedQuad( texturedQuadStructure )
		draw.RoundedBox(1,0,0,430,360,Color(15,15,15, 225))

		---=== Выключен ===---
		if !self:GetNWBool("Enabled") then
			if !self:GetNWBool("Starting") then
				if imgui.xTextButton("Вкл.", "TargetIDSmall", 425, 405, 45, 25, 2, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
					if PartyTerminalAccess[LocalPlayer():Team()] then
						timer.Simple(5, function() self:EmitSound("buttons/blip2.wav") self:SetNWBool("Starting", false) self:SetNWBool("Enabled", true) end)
						self:SetNWBool("Starting", true)
						self:EmitSound("buttons/button24.wav")
					else
						self:EmitSound("buttons/button16.wav")
					end
				end
			else
				local x = 110
				for i=0,40 do
					draw.SimpleText("/", imgui.xFont("marske6"), x+5*i, math.random(125,175))
				end
				draw.SimpleText("Загрузка ОС", imgui.xFont("marske6"), x+30, 150)
			end
		---=== Включен ===---
		else
			---=== Заселение в квартиру ===---
			if self:GetNWBool("House_Apartment_Entry") and IsValid(self:GetNWEntity("PartyTerminal_Subject")) then
				local today = os.date("%d.%m.%Y", os.time())
				draw.SimpleText("C17I", imgui.xFont("marske5"), 25, 25)
				draw.SimpleText(today .. " || " ..GetGlobalFloat("HoursTimeFloat") .. " : " .. GetGlobalFloat("MinutsTimeFloat"), imgui.xFont("marske5"), 245, 25)
				draw.SimpleText("________________________________________________", imgui.xFont("marske6"), 25, 30)
				draw.SimpleText("Список квартир", imgui.xFont("marske8"), 90, 50)
				draw.SimpleText("________________________________________________", imgui.xFont("marske6"), 25, 62)

				draw.SimpleText("Гражданин: " .. self:GetNWEntity("PartyTerminal_Subject"):Name(), imgui.xFont("marske5"), 25, 95)

				if imgui.xTextButton("Назад", "TargetIDSmall", 0, 320, 125, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
					if PartyTerminalAccess[LocalPlayer():Team()] then
						self:SetNWBool("House_Apartment_Entry", false)
						self:EmitSound("buttons/button15.wav")
					else
						self:EmitSound("buttons/button16.wav")
					end
				end

				local bx = 115
				local by = 140

				draw.SimpleText("Блок A:", imgui.xFont("marske4"), bx, by - 20, Color(255,180,120))
				draw.SimpleText("----------------", imgui.xFont("marske5"), bx, by - 10)

				draw.SimpleText("Блок B:", imgui.xFont("marske4"), bx + 70, by - 20, Color(255,180,120))
				draw.SimpleText("----------------", imgui.xFont("marske5"), bx + 70, by - 10)

				-- draw.SimpleText("Блок C:", imgui.xFont("marske4"), bx + 140, by - 20, Color(255,180,120))
				-- draw.SimpleText("----------------", imgui.xFont("marske5"), bx + 140, by - 10)

				-- draw.SimpleText("Блок D:", imgui.xFont("marske4"), bx + 210, by - 20, Color(255,180,120))
				-- draw.SimpleText("----------------", imgui.xFont("marske5"), bx + 210, by - 10)

				local _ia = 1
				local _ib = 1
				local _ic = 1
				local _id = 1
				local _ie = 1
				local _if = 1
				local _ig = 1
				for k,v in pairs(RISED.Config.Apartments) do
					if RISED.Config.Apartments[k]["Класс"] == "Квартира" then
						if RISED.Config.Apartments[k]["Блок"] == "A" then
							local name = RISED.Config.Apartments[k]["Номер"]

							if imgui.xTextButton(name, "TargetIDSmall", bx + 15, by - 10 + _ia*15, 25, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
								if PartyTerminalAccess[LocalPlayer():Team()] then
									
									net.Start("RisedTerminal_Party:Server")
									net.WriteInt(1,10)
									net.WriteEntity(self:GetNWEntity("PartyTerminal_Subject"))
									net.WriteString(RISED.Config.Apartments[k]["Блок"])
									net.WriteString(RISED.Config.Apartments[k]["Номер"])
									net.SendToServer()

									self:EmitSound("buttons/button15.wav")
								else
									self:EmitSound("buttons/button16.wav")
								end
							end
							_ia = _ia + 1
						elseif RISED.Config.Apartments[k]["Блок"] == "B" then
							local name = RISED.Config.Apartments[k]["Номер"]

							if imgui.xTextButton(name, "TargetIDSmall", bx + 70 + 15, by - 10 + _ib*15, 25, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
								if PartyTerminalAccess[LocalPlayer():Team()] then
									
									net.Start("RisedTerminal_Party:Server")
									net.WriteInt(1,10)
									net.WriteEntity(self:GetNWEntity("PartyTerminal_Subject"))
									net.WriteString(RISED.Config.Apartments[k]["Блок"])
									net.WriteString(RISED.Config.Apartments[k]["Номер"])
									net.SendToServer()

									self:EmitSound("buttons/button15.wav")
								else
									self:EmitSound("buttons/button16.wav")
								end
							end
							_ib = _ib + 1
						elseif RISED.Config.Apartments[k]["Блок"] == "C" then
							local name = RISED.Config.Apartments[k]["Номер"]

							if imgui.xTextButton(name, "TargetIDSmall", bx + 140 + 15, by - 10 + _ic*15, 25, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
								if PartyTerminalAccess[LocalPlayer():Team()] then
									
									net.Start("RisedTerminal_Party:Server")
									net.WriteInt(1,10)
									net.WriteEntity(self:GetNWEntity("PartyTerminal_Subject"))
									net.WriteString(RISED.Config.Apartments[k]["Блок"])
									net.WriteString(RISED.Config.Apartments[k]["Номер"])
									net.SendToServer()

									self:EmitSound("buttons/button15.wav")
								else
									self:EmitSound("buttons/button16.wav")
								end
							end
							_ic = _ic + 1
						elseif RISED.Config.Apartments[k]["Блок"] == "D" then
							local name = RISED.Config.Apartments[k]["Номер"]

							if imgui.xTextButton(name, "TargetIDSmall", bx + 210 + 15, by - 10 + _id*15, 25, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
								if PartyTerminalAccess[LocalPlayer():Team()] then
									
									net.Start("RisedTerminal_Party:Server")
									net.WriteInt(1,10)
									net.WriteEntity(self:GetNWEntity("PartyTerminal_Subject"))
									net.WriteString(RISED.Config.Apartments[k]["Блок"])
									net.WriteString(RISED.Config.Apartments[k]["Номер"])
									net.SendToServer()

									self:EmitSound("buttons/button15.wav")
								else
									self:EmitSound("buttons/button16.wav")
								end
							end
							_id = _id + 1
						end
					end
				end

			---=== Заселение в общежитие ===---
			elseif self:GetNWBool("House_Hostel_Entry") and IsValid(self:GetNWEntity("PartyTerminal_Subject")) then
				local today = os.date("%d.%m.%Y", os.time())
				draw.SimpleText("C17I", imgui.xFont("marske5"), 25, 25)
				draw.SimpleText(today .. " || " ..GetGlobalFloat("HoursTimeFloat") .. " : " .. GetGlobalFloat("MinutsTimeFloat"), imgui.xFont("marske5"), 245, 25)
				draw.SimpleText("________________________________________________", imgui.xFont("marske6"), 25, 30)
				draw.SimpleText("Список общежитий", imgui.xFont("marske8"), 60, 50)
				draw.SimpleText("________________________________________________", imgui.xFont("marske6"), 25, 62)

				if imgui.xTextButton("Назад", "TargetIDSmall", 0, 320, 125, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
					if PartyTerminalAccess[LocalPlayer():Team()] then
						self:SetNWBool("House_Hostel_Entry", false)
						self:EmitSound("buttons/button15.wav")
					else
						self:EmitSound("buttons/button16.wav")
					end
				end

				local bx = 115
				local by = 140

				-- draw.SimpleText("Блок A:", imgui.xFont("marske4"), bx, by - 20, Color(255,180,120))
				-- draw.SimpleText("----------------", imgui.xFont("marske5"), bx, by - 10)

				-- draw.SimpleText("Блок B:", imgui.xFont("marske4"), bx + 70, by - 20, Color(255,180,120))
				-- draw.SimpleText("----------------", imgui.xFont("marske5"), bx + 70, by - 10)

				draw.SimpleText("Блок C:", imgui.xFont("marske4"), bx + 140, by - 20, Color(255,180,120))
				draw.SimpleText("----------------", imgui.xFont("marske5"), bx + 140, by - 10)

				draw.SimpleText("Блок D:", imgui.xFont("marske4"), bx + 210, by - 20, Color(255,180,120))
				draw.SimpleText("----------------", imgui.xFont("marske5"), bx + 210, by - 10)

				local _ia = 1
				local _ib = 1
				local _ic = 1
				local _id = 1
				local _ie = 1
				local _if = 1
				local _ig = 1
				for k,v in pairs(RISED.Config.Apartments) do
					if RISED.Config.Apartments[k]["Класс"] == "Общежитие" then
						if RISED.Config.Apartments[k]["Блок"] == "A" then
							local name = RISED.Config.Apartments[k]["Номер"]

							if imgui.xTextButton(name, "TargetIDSmall", bx + 15, by - 10 + _ia*15, 25, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
								if PartyTerminalAccess[LocalPlayer():Team()] then

									net.Start("RisedTerminal_Party:Server")
									net.WriteInt(2,10)
									net.WriteEntity(self:GetNWEntity("PartyTerminal_Subject"))
									net.WriteString(RISED.Config.Apartments[k]["Блок"])
									net.WriteString(RISED.Config.Apartments[k]["Номер"])
									net.SendToServer()

									self:EmitSound("buttons/button15.wav")
								else
									self:EmitSound("buttons/button16.wav")
								end
							end
							_ia = _ia + 1
						elseif RISED.Config.Apartments[k]["Блок"] == "B" then
							local name = RISED.Config.Apartments[k]["Номер"]

							if imgui.xTextButton(name, "TargetIDSmall", bx + 70 + 15, by - 10 + _ib*15, 25, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
								if PartyTerminalAccess[LocalPlayer():Team()] then

									net.Start("RisedTerminal_Party:Server")
									net.WriteInt(2,10)
									net.WriteEntity(self:GetNWEntity("PartyTerminal_Subject"))
									net.WriteString(RISED.Config.Apartments[k]["Блок"])
									net.WriteString(RISED.Config.Apartments[k]["Номер"])
									net.SendToServer()

									self:EmitSound("buttons/button15.wav")
								else
									self:EmitSound("buttons/button16.wav")
								end
							end
							_ib = _ib + 1
						elseif RISED.Config.Apartments[k]["Блок"] == "C" then
							local name = RISED.Config.Apartments[k]["Номер"]

							if imgui.xTextButton(name, "TargetIDSmall", bx + 140 + 15, by - 10 + _ic*15, 25, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
								if PartyTerminalAccess[LocalPlayer():Team()] then

									net.Start("RisedTerminal_Party:Server")
									net.WriteInt(2,10)
									net.WriteEntity(self:GetNWEntity("PartyTerminal_Subject"))
									net.WriteString(RISED.Config.Apartments[k]["Блок"])
									net.WriteString(RISED.Config.Apartments[k]["Номер"])
									net.SendToServer()

									self:EmitSound("buttons/button15.wav")
								else
									self:EmitSound("buttons/button16.wav")
								end
							end
							_ic = _ic + 1
						elseif RISED.Config.Apartments[k]["Блок"] == "D" then
							local name = RISED.Config.Apartments[k]["Номер"]

							if imgui.xTextButton(name, "TargetIDSmall", bx + 210 + 15, by - 10 + _id*15, 25, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
								if PartyTerminalAccess[LocalPlayer():Team()] then

									net.Start("RisedTerminal_Party:Server")
									net.WriteInt(2,10)
									net.WriteEntity(self:GetNWEntity("PartyTerminal_Subject"))
									net.WriteString(RISED.Config.Apartments[k]["Блок"])
									net.WriteString(RISED.Config.Apartments[k]["Номер"])
									net.SendToServer()

									self:EmitSound("buttons/button15.wav")
								else
									self:EmitSound("buttons/button16.wav")
								end
							end
							_id = _id + 1
						end
					end
				end

			---=== Выселение ===---
			elseif self:GetNWBool("House_Apartment_Leave_Player") then
				local today = os.date("%d.%m.%Y", os.time())
				draw.SimpleText("C17I", imgui.xFont("marske5"), 25, 25)
				draw.SimpleText(today .. " || " ..GetGlobalFloat("HoursTimeFloat") .. " : " .. GetGlobalFloat("MinutsTimeFloat"), imgui.xFont("marske5"), 245, 25)
				draw.SimpleText("________________________________________________", imgui.xFont("marske6"), 25, 30)
				draw.SimpleText("Список квартир", imgui.xFont("marske8"), 90, 50)
				draw.SimpleText("________________________________________________", imgui.xFont("marske6"), 25, 62)

				local bx = 30
				local by = 115
				if imgui.xTextButton("Назад", "TargetIDSmall", 0, 320, 125, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
					if PartyTerminalAccess[LocalPlayer():Team()] then
						self:SetNWBool("House_Apartment_Leave_Player", false)
						self:EmitSound("buttons/button15.wav")
					else
						self:EmitSound("buttons/button16.wav")
					end
				end
				
				draw.SimpleText("Выбрана квартира:", imgui.xFont("marske4"), bx + 175, by + 150, Color(255,180,120))

				if self:GetNWString("House_Apartment_Current_Name") != "" and self:GetNWString("House_Apartment_Current_User") != "" then
					draw.SimpleText(self:GetNWString("House_Apartment_Current_Name"), imgui.xFont("marske4"), bx + 175, by + 170, Color(255,255,255))
					draw.SimpleText(self:GetNWString("House_Apartment_Current_User"), imgui.xFont("marske4"), bx + 175, by + 185, Color(255,255,255))
					if imgui.xTextButton("Выселить", "marske4", bx + 150, by + 205, 125, 15, 0, Color(200,25,25), Color(125,75,75), Color(0,0,0)) then
						if PartyTerminalAccess[LocalPlayer():Team()] then
							
							net.Start("RisedTerminal_Party:Server")
							net.WriteInt(32,10)
							net.SendToServer()

							self:EmitSound("buttons/button15.wav")
						else
							self:EmitSound("buttons/button16.wav")
						end
					end
				end

				draw.SimpleText("Блок A:", imgui.xFont("marske4"), bx, by - 20, Color(255,180,120))
				draw.SimpleText("----------------", imgui.xFont("marske5"), bx, by - 10)

				draw.SimpleText("Блок B:", imgui.xFont("marske4"), bx + 70, by - 20, Color(255,180,120))
				draw.SimpleText("----------------", imgui.xFont("marske5"), bx + 70, by - 10)

				draw.SimpleText("Блок C:", imgui.xFont("marske4"), bx + 140, by - 20, Color(255,180,120))
				draw.SimpleText("----------------", imgui.xFont("marske5"), bx + 140, by - 10)

				draw.SimpleText("Блок D:", imgui.xFont("marske4"), bx + 210, by - 20, Color(255,180,120))
				draw.SimpleText("----------------", imgui.xFont("marske5"), bx + 210, by - 10)

				local _ia = 1
				local _ib = 1
				local _ic = 1
				local _id = 1
				local _ie = 1
				local _if = 1
				local _ig = 1
				for k,v in pairs(RISED.Config.Apartments) do
					if RISED.Config.Apartments[k]["Класс"] == "Квартира" then
						if RISED.Config.Apartments[k]["Блок"] == "A" then
							local name = RISED.Config.Apartments[k]["Номер"]

							if imgui.xTextButton(name, "TargetIDSmall", 50, by - 10 + _ia*15, 25, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
								if PartyTerminalAccess[LocalPlayer():Team()] then
									
									net.Start("RisedTerminal_Party:Server")
									net.WriteInt(3,10)
									net.WriteString(RISED.Config.Apartments[k]["Блок"])
									net.WriteString(RISED.Config.Apartments[k]["Номер"])
									net.SendToServer()

									self:EmitSound("buttons/button15.wav")
								else
									self:EmitSound("buttons/button16.wav")
								end
							end
							_ia = _ia + 1
						elseif RISED.Config.Apartments[k]["Блок"] == "B" then
							local name = RISED.Config.Apartments[k]["Номер"]

							if imgui.xTextButton(name, "TargetIDSmall", 120, by - 10 + _ib*15, 25, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
								if PartyTerminalAccess[LocalPlayer():Team()] then
									
									net.Start("RisedTerminal_Party:Server")
									net.WriteInt(3,10)
									net.WriteString(RISED.Config.Apartments[k]["Блок"])
									net.WriteString(RISED.Config.Apartments[k]["Номер"])
									net.SendToServer()

									self:EmitSound("buttons/button15.wav")
								else
									self:EmitSound("buttons/button16.wav")
								end
							end
							_ib = _ib + 1
						elseif RISED.Config.Apartments[k]["Блок"] == "C" then
							local name = RISED.Config.Apartments[k]["Номер"]

							bx = 150

							if imgui.xTextButton(name, "TargetIDSmall", 190, by - 10 + _ic*15, 25, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
								if PartyTerminalAccess[LocalPlayer():Team()] then
									
									net.Start("RisedTerminal_Party:Server")
									net.WriteInt(3,10)
									net.WriteString(RISED.Config.Apartments[k]["Блок"])
									net.WriteString(RISED.Config.Apartments[k]["Номер"])
									net.SendToServer()

									self:EmitSound("buttons/button15.wav")
								else
									self:EmitSound("buttons/button16.wav")
								end
							end
							_ic = _ic + 1
						elseif RISED.Config.Apartments[k]["Блок"] == "D" then
							local name = RISED.Config.Apartments[k]["Номер"]

							bx = 170

							if imgui.xTextButton(name, "TargetIDSmall", 260, by - 10 + _id*15, 25, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
								if PartyTerminalAccess[LocalPlayer():Team()] then
									
									net.Start("RisedTerminal_Party:Server")
									net.WriteInt(3,10)
									net.WriteString(RISED.Config.Apartments[k]["Блок"])
									net.WriteString(RISED.Config.Apartments[k]["Номер"])
									net.SendToServer()

									self:EmitSound("buttons/button15.wav")
								else
									self:EmitSound("buttons/button16.wav")
								end
							end
							_id = _id + 1
						end
					end
				end

			---=== Личные дела граждан ===---
			elseif self:GetNWBool("Citizen_File_Choose") then
				local today = os.date("%d.%m.%Y", os.time())
				draw.SimpleText("C17I", imgui.xFont("marske5"), 25, 25)
				draw.SimpleText(today .. " || " ..GetGlobalFloat("HoursTimeFloat") .. " : " .. GetGlobalFloat("MinutsTimeFloat"), imgui.xFont("marske5"), 245, 25)
				draw.SimpleText("________________________________________________", imgui.xFont("marske6"), 25, 30)
				draw.SimpleText("Личные дела граждан", imgui.xFont("marske8"), 45, 50)
				draw.SimpleText("________________________________________________", imgui.xFont("marske6"), 25, 62)


				local bx = 40
				local by = 70
				local bk = 1
				if imgui.xTextButton("Назад", "TargetIDSmall", 0, 320, 125, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
					if PartyTerminalAccess[LocalPlayer():Team()] then
						self:SetNWBool("Citizen_File_Choose", false)
						self:SetNWBool("Citizen_File_Open", false)
						self:EmitSound("buttons/button15.wav")
					else
						self:EmitSound("buttons/button16.wav")
					end
				end

				for k,v in pairs(player.GetAll()) do
					if k <= 17 then
						bx = 55
						bk = k
					elseif k <= 34 then
						bx = 180
						bk = k - 17
					else
						bx = 305
						bk = k - 34
					end
					if imgui.xTextButton(v:Nick(), "TargetIDSmall", bx-30, by + bk*15, 125, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
						if PartyTerminalAccess[LocalPlayer():Team()] then
							self:SetNWBool("Citizen_File_Choose", false)
							self:SetNWBool("Citizen_File_Open", true)
							self:SetNWEntity("Citizen_File_Player", v)

							self:EmitSound("buttons/button15.wav")
						else
							self:EmitSound("buttons/button16.wav")
						end
					end
				end
			elseif self:GetNWBool("Citizen_File_Open") then
				local ply = self:GetNWEntity("Citizen_File_Player")
				local today = os.date("%d.%m.%Y", os.time())
				draw.SimpleText("C17I", imgui.xFont("marske5"), 25, 25)
				draw.SimpleText(today .. " || " ..GetGlobalFloat("HoursTimeFloat") .. " : " .. GetGlobalFloat("MinutsTimeFloat"), imgui.xFont("marske5"), 245, 25)
				draw.SimpleText("________________________________________________", imgui.xFont("marske6"), 25, 30, Color(0,255,128))
				draw.SimpleText("Дело: "..ply:Name(), imgui.xFont("marske8"), 45, 50)
				draw.SimpleText("________________________________________________", imgui.xFont("marske6"), 25, 62, Color(0,255,128))


				local bx = 40
				local by = 70
				local bk = 1
				if imgui.xTextButton("Назад", "TargetIDSmall", 0, 320, 125, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
					if PartyTerminalAccess[LocalPlayer():Team()] then
						self:SetNWBool("Citizen_File_Choose", true)
						self:SetNWBool("Citizen_File_Open", false)
						self:EmitSound("buttons/button15.wav")
					else
						self:EmitSound("buttons/button16.wav")
					end
				end

				draw.SimpleText("//", imgui.xFont("marske5"), 30, 100, Color(0,255,128))
				draw.SimpleText("//", imgui.xFont("marske5"), 30, 125, Color(0,255,128))
				draw.SimpleText("//", imgui.xFont("marske5"), 30, 150, Color(0,255,128))
				draw.SimpleText("//", imgui.xFont("marske5"), 30, 175, Color(0,255,128))
				draw.SimpleText("ФИО: "..ply:Name(), imgui.xFont("marske5"), 45, 100, Color(255,255,255))
				draw.SimpleText("Пол: "..ply:GetNWString("Player_Sex"), imgui.xFont("marske5"), 45, 125, Color(255,255,255))
				draw.SimpleText("Очки лояльности: "..ply:GetNWInt("LoyaltyTokens"), imgui.xFont("marske5"), 45, 150, Color(255,255,255))

				if ply:GetNWString("Rised_Owned_Apartment") == "" then
					draw.SimpleText("Место жительства: Отсутствует", imgui.xFont("marske5"), 45, 175, Color(255,255,255))
				else
					draw.SimpleText("Место жительства: "..ply:GetNWString("Rised_Owned_Apartment"), imgui.xFont("marske5"), 45, 175, Color(255,255,255))
					local cur_day = tonumber(os.date("%d", os.time()))
					local owned_day = tonumber(string.Split(ply:GetNWString("Rised_Owned_Apartment_Date"), ".")[1])
					if owned_day - cur_day > 1 then
						draw.SimpleText("Оплачено до: "..ply:GetNWString("Rised_Owned_Apartment_Date"), imgui.xFont("marske5"), 45, 200, Color(255,255,255))
					else
						draw.SimpleText("Оплачено до: "..ply:GetNWString("Rised_Owned_Apartment_Date"), imgui.xFont("marske5"), 45, 200, Color(255,0,0))
					end
					if imgui.xTextButton(">>> Продлить на 1 день (макс. 3 дня)", "marske4", 117, 225, 125, 15, 0, Color(255,255,255), Color(0,255,128), Color(0,0,0)) then
						if PartyTerminalAccess[LocalPlayer():Team()] then
							net.Start("RisedTerminal_Party:Server")
							net.WriteInt(4,10)
							net.WriteEntity(ply)
							net.SendToServer()
							self:EmitSound("buttons/button15.wav")
						else
							self:EmitSound("buttons/button16.wav")
						end
					end
					if imgui.xTextButton(">>> Выселить", "marske4", 117, 245, 125, 15, 0, Color(255,255,255), Color(0,255,128), Color(0,0,0)) then
						if PartyTerminalAccess[LocalPlayer():Team()] then
							net.Start("RisedTerminal_Party:Server")
							net.WriteInt(33,10)
							net.WriteEntity(ply)
							net.SendToServer()
							self:EmitSound("buttons/button15.wav")
						else
							self:EmitSound("buttons/button16.wav")
						end
					end
				end


				if ply:getDarkRPVar("wanted") then
					draw.SimpleText("В розыске: Да", imgui.xFont("marske5"), 45, 270, 0, Color(255,0,0))
					draw.SimpleText(ply:getDarkRPVar("wantedReason"), imgui.xFont("marske4"), 45, 275, Color(255,0,0))
					draw.SimpleText("//", imgui.xFont("marske5"), 30, 270, Color(255,0,0))
				else
					draw.SimpleText("В розыске: Нет", imgui.xFont("marske5"), 45, 270, Color(255,255,255))
					draw.SimpleText("//", imgui.xFont("marske5"), 30, 270, Color(0,255,128))
				end

			elseif self:GetNWBool("Citizen_Loyalty_Open") and IsValid(self:GetNWEntity("PartyTerminal_Subject")) then
				local ply = self:GetNWEntity("PartyTerminal_Subject")
				local today = os.date("%d.%m.%Y", os.time())
				draw.SimpleText("C17I", imgui.xFont("marske5"), 25, 25)
				draw.SimpleText(today .. " || " ..GetGlobalFloat("HoursTimeFloat") .. " : " .. GetGlobalFloat("MinutsTimeFloat"), imgui.xFont("marske5"), 245, 25)
				draw.SimpleText("________________________________________________", imgui.xFont("marske6"), 25, 30, Color(0,255,128))
				draw.SimpleText("Дело: "..ply:Name(), imgui.xFont("marske6"), 45, 53)
				draw.SimpleText("________________________________________________", imgui.xFont("marske6"), 25, 62, Color(0,255,128))


				local bx = 40
				local by = 70
				local bk = 1
				if imgui.xTextButton("Назад", "TargetIDSmall", 0, 320, 125, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
					if PartyTerminalAccess[LocalPlayer():Team()] then
						self:SetNWBool("Citizen_Loyalty_Open", false)
						self:EmitSound("buttons/button15.wav")
					else
						self:EmitSound("buttons/button16.wav")
					end
				end

				draw.SimpleText("//", imgui.xFont("marske5"), 30, 100, Color(0,255,128))
				draw.SimpleText("//", imgui.xFont("marske5"), 30, 125, Color(0,255,128))
				draw.SimpleText("//", imgui.xFont("marske5"), 30, 150, Color(0,255,128))
				draw.SimpleText("//", imgui.xFont("marske5"), 30, 175, Color(0,255,128))
				draw.SimpleText("ФИО: "..ply:Name(), imgui.xFont("marske5"), 45, 100, Color(255,255,255))
				draw.SimpleText("Пол: "..ply:GetNWString("Player_Sex"), imgui.xFont("marske5"), 45, 125, Color(255,255,255))
				draw.SimpleText("Очки лояльности: "..ply:GetNWInt("LoyaltyTokens"), imgui.xFont("marske5"), 45, 150, Color(255,255,255))

				if ply:GetNWString("Rised_Owned_Apartment") == "" then
					draw.SimpleText("Место жительства: Отсутствует", imgui.xFont("marske5"), 45, 175, Color(255,255,255))
				else
					draw.SimpleText("Место жительства: "..ply:GetNWString("Rised_Owned_Apartment"), imgui.xFont("marske5"), 45, 175, Color(255,255,255))
				end

				by = 220
				if imgui.xTextButton("-1 ОЛ", "marske8", 50, by, 100, 50, 2, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
					if PartyTerminalAccess[LocalPlayer():Team()] then
						net.Start("RisedTerminal_Party:Server")
						net.WriteInt(55,10)
						net.WriteInt(-1,10)
						net.SendToServer()
						self:EmitSound("buttons/button15.wav")
					else
						self:EmitSound("buttons/button16.wav")
					end
				end

				if imgui.xTextButton("+1 ОЛ", "marske8", 280, by, 100, 50, 2, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
					if PartyTerminalAccess[LocalPlayer():Team()] then
						net.Start("RisedTerminal_Party:Server")
						net.WriteInt(55,10)
						net.WriteInt(1,10)
						net.SendToServer()
						self:EmitSound("buttons/button15.wav")
					else
						self:EmitSound("buttons/button16.wav")
					end
				end

			---=== Изменение законов ===---
			elseif self:GetNWBool("Opened_Laws_Menu") then
				local today = os.date("%d.%m.%Y", os.time())
				draw.SimpleText("C17I", imgui.xFont("marske5"), 25, 25)
				draw.SimpleText(today .. " || " ..GetGlobalFloat("HoursTimeFloat") .. " : " .. GetGlobalFloat("MinutsTimeFloat"), imgui.xFont("marske5"), 245, 25)
				draw.SimpleText("________________________________________________", imgui.xFont("marske6"), 25, 30)
				draw.SimpleText("Список законов", imgui.xFont("marske8"), 90, 50)
				draw.SimpleText("________________________________________________", imgui.xFont("marske6"), 25, 62)

				local bx = 125
				local by = 95
				
				if !self:GetNWBool("Opened_Laws_Menu_SelectedLaw") then
					if imgui.xTextButton("Назад", "TargetIDSmall", 0, 320, 125, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
						if PartyTerminalAccess[LocalPlayer():Team()] then
							self:SetNWBool("Opened_Laws_Menu", false)
							self:EmitSound("buttons/button15.wav")
						else
							self:EmitSound("buttons/button16.wav")
						end
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
								draw.SimpleText(line, "TargetIDSmall", bx-110, by + (k2 - 1 + offset_y) * 25, Color(255,255,255))
								button_y = by + offset_y * 25
								lines_summary = lines_summary + 1
								local_lines = local_lines + 1
							end
							local select_law = imgui.xButton(bx-110, button_y, 400, 25 * local_lines - 5, 1, Color(255,255,255), Color(75,75,75), Color(0,0,0))
							if select_law then
								if PartyTerminalAccess[LocalPlayer():Team()] then
									self:SetNWBool("Opened_Laws_Menu_SelectedLaw", true)
									self:SetNWInt("Opened_Laws_Menu_SelectedLaw_Id", k)
									self:EmitSound("buttons/button15.wav")
								else
									self:EmitSound("buttons/button16.wav")
								end
							end
						end

						pages = math.ceil((lines_summary + skip_lines) / 9) + 1
					end
					
					draw.SimpleText("страница: " .. law_page, imgui.xFont("TargetIDSmall"), bx+207, 320)
					if imgui.xTextButton("< < <", "TargetIDSmall", bx+185, 335, 50, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
						law_page = math.Clamp(law_page - 1, 1, pages)
						self:EmitSound("buttons/button15.wav")
					end
					if imgui.xTextButton("> > >", "TargetIDSmall", bx+255, 335, 50, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
						law_page = math.Clamp(law_page + 1, 1, pages)
						self:EmitSound("buttons/button15.wav")
					end

					if imgui.xTextButtonLeft("Добавить", "TargetIDSmall", bx+50, 320, 125, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
						if PartyTerminalAccess[LocalPlayer():Team()] then
							
							local newLawFrame = vgui.Create( "DFrame" )
							newLawFrame:SetSize( 300, 60 )
							newLawFrame:Center()
							newLawFrame:SetTitle("Текст нового закона")
							newLawFrame:MakePopup()

							local newLawTextEntry = vgui.Create( "DTextEntry", newLawFrame )
							newLawTextEntry:Dock( TOP )
							newLawTextEntry.OnEnter = function(input)
								net.Start("RisedTerminal_Party:Server")
								net.WriteInt(52,10)
								net.WriteString(input:GetValue())
								net.SendToServer()

								table.insert(RISED.Config.Laws, input:GetValue())

								newLawFrame:Close()
							end

							self:EmitSound("buttons/button15.wav")
						else
							self:EmitSound("buttons/button16.wav")
						end
					end
				else
					if imgui.xTextButton("Назад", "TargetIDSmall", 0, 320, 125, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
						if PartyTerminalAccess[LocalPlayer():Team()] then
							self:SetNWBool("Opened_Laws_Menu_SelectedLaw", false)
							self:EmitSound("buttons/button15.wav")
						else
							self:EmitSound("buttons/button16.wav")
						end
					end

					local law = RISED.Config.Laws[self:GetNWInt("Opened_Laws_Menu_SelectedLaw_Id")]

					if imgui.xTextButtonMultiline(law, "TargetIDSmall", 400, bx-100, by + 15, 400, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
						
					end

					if imgui.xTextButtonLeft("Изменить", "TargetIDSmall", bx+135, 320, 60, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
						if PartyTerminalAccess[LocalPlayer():Team()] then

							local editLawFrame = vgui.Create( "DFrame" )
							editLawFrame:SetSize( 300, 60 )
							editLawFrame:Center()
							editLawFrame:SetTitle("Текст нового закона")
							editLawFrame:MakePopup()

							local editLawTextEntry = vgui.Create( "DTextEntry", editLawFrame )
							editLawTextEntry:Dock( TOP )
							editLawTextEntry:SetText(RISED.Config.Laws[self:GetNWInt("Opened_Laws_Menu_SelectedLaw_Id")])
							editLawTextEntry.OnEnter = function(input)
								net.Start("RisedTerminal_Party:Server")
								net.WriteInt(53,10)
								net.WriteInt(self:GetNWInt("Opened_Laws_Menu_SelectedLaw_Id"),10)
								net.WriteString(input:GetValue())
								net.SendToServer()

								RISED.Config.Laws[self:GetNWInt("Opened_Laws_Menu_SelectedLaw_Id")] = input:GetValue()

								self:SetNWBool("Opened_Laws_Menu_SelectedLaw", false)
								self:SetNWInt("Opened_Laws_Menu_SelectedLaw_Id", NULL)

								editLawFrame:Close()
							end

							self:EmitSound("buttons/button15.wav")
						else
							self:EmitSound("buttons/button16.wav")
						end
					end

					if imgui.xTextButtonLeft("Удалить", "TargetIDSmall", bx+200, 320, 55, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
						if PartyTerminalAccess[LocalPlayer():Team()] then

							net.Start("RisedTerminal_Party:Server")
							net.WriteInt(54,10)
							net.WriteInt(self:GetNWInt("Opened_Laws_Menu_SelectedLaw_Id"),10)
							net.SendToServer()

							table.remove(RISED.Config.Laws, self:GetNWInt("Opened_Laws_Menu_SelectedLaw_Id"))
							self:SetNWBool("Opened_Laws_Menu_SelectedLaw", false)
							self:SetNWInt("Opened_Laws_Menu_SelectedLaw_Id", null)
							self:EmitSound("buttons/button15.wav")
						else
							self:EmitSound("buttons/button16.wav")
						end
					end
				end

			---=== Выбор ранга партийца для вступления ===---
			elseif self:GetNWBool("Party_Join_Choose") then
				local today = os.date("%d.%m.%Y", os.time())
				draw.SimpleText("C17I", imgui.xFont("marske5"), 25, 25)
				draw.SimpleText(today .. " || " ..GetGlobalFloat("HoursTimeFloat") .. " : " .. GetGlobalFloat("MinutsTimeFloat"), imgui.xFont("marske5"), 245, 25)
				draw.SimpleText("________________________________________________", imgui.xFont("marske6"), 25, 30)
				draw.SimpleText("Профессии Партии", imgui.xFont("marske8"), 45, 50)
				draw.SimpleText("________________________________________________", imgui.xFont("marske6"), 25, 62)


				local bx = 175
				local by = 90
				local bk = 1
				if imgui.xTextButton("Назад", "TargetIDSmall", 0, 320, 125, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
					if PartyTerminalAccess[LocalPlayer():Team()] then
						self:SetNWBool("Party_Join_Choose", false)
						self:EmitSound("buttons/button15.wav")
					else
						self:EmitSound("buttons/button16.wav")
					end
				end

				if imgui.xTextButton(">>>     Кандидат на членство в партии |", "TargetIDSmall", bx-40, by + bk*20, 125, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
					if PartyTerminalAccess[LocalPlayer():Team()] then
						self:SetNWBool("Party_Join_Choose", false)
						net.Start("RisedTerminal_Party:Server")
						net.WriteInt(21,10)
						net.WriteInt(1,10)
						net.SendToServer()
						self:EmitSound("buttons/button15.wav")
					else
						self:EmitSound("buttons/button16.wav")
					end
				end
				bk = bk + 1
				if imgui.xTextButton(">>>     Утвержденный член партии |", "TargetIDSmall", bx-45, by + bk*20, 125, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
					if PartyTerminalAccess[LocalPlayer():Team()] then
						self:SetNWBool("Party_Join_Choose", false)
						net.Start("RisedTerminal_Party:Server")
						net.WriteInt(21,10)
						net.WriteInt(2,10)
						net.SendToServer()
						self:EmitSound("buttons/button15.wav")
					else
						self:EmitSound("buttons/button16.wav")
					end
				end
				bk = bk + 1
				if imgui.xTextButton(">>>     Помощник партии |", "TargetIDSmall", bx-70, by + bk*20, 125, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
					if PartyTerminalAccess[LocalPlayer():Team()] then
						self:SetNWBool("Party_Join_Choose", false)
						net.Start("RisedTerminal_Party:Server")
						net.WriteInt(21,10)
						net.WriteInt(3,10)
						net.SendToServer()
						self:EmitSound("buttons/button15.wav")
					else
						self:EmitSound("buttons/button16.wav")
					end
				end
				bk = bk + 1
				if imgui.xTextButton(">>>     Старший помощник партии |", "TargetIDSmall", bx-35, by + bk*20, 125, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
					if PartyTerminalAccess[LocalPlayer():Team()] then
						self:SetNWBool("Party_Join_Choose", false)
						net.Start("RisedTerminal_Party:Server")
						net.WriteInt(21,10)
						net.WriteInt(4,10)
						net.SendToServer()
						self:EmitSound("buttons/button15.wav")
					else
						self:EmitSound("buttons/button16.wav")
					end
				end
				bk = bk + 1
				if imgui.xTextButton(">>>     Руководитель работ |", "TargetIDSmall", bx-50, by + bk*20, 125, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
					if PartyTerminalAccess[LocalPlayer():Team()] then
						self:SetNWBool("Party_Join_Choose", false)
						net.Start("RisedTerminal_Party:Server")
						net.WriteInt(21,10)
						net.WriteInt(5,10)
						net.SendToServer()
						self:EmitSound("buttons/button15.wav")
					else
						self:EmitSound("buttons/button16.wav")
					end
				end
				bk = bk + 1
				if imgui.xTextButton(">>>     Член верховного совета |", "TargetIDSmall", bx-25, by + bk*20, 125, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
					if PartyTerminalAccess[LocalPlayer():Team()] then
						self:SetNWBool("Party_Join_Choose", false)
						net.Start("RisedTerminal_Party:Server")
						net.WriteInt(21,10)
						net.WriteInt(7,10)
						net.SendToServer()
						self:EmitSound("buttons/button15.wav")
					else
						self:EmitSound("buttons/button16.wav")
					end
				end
				bk = bk + 1
				if imgui.xTextButton(">>>     Председатель совета |", "TargetIDSmall", bx-25, by + bk*20, 125, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
					if PartyTerminalAccess[LocalPlayer():Team()] then
						self:SetNWBool("Party_Join_Choose", false)
						net.Start("RisedTerminal_Party:Server")
						net.WriteInt(21,10)
						net.WriteInt(8,10)
						net.SendToServer()
						self:EmitSound("buttons/button15.wav")
					else
						self:EmitSound("buttons/button16.wav")
					end
				end
			elseif self:GetNWBool("Factory_Rations_Open") then
				local today = os.date("%d.%m.%Y", os.time())
				draw.SimpleText("C17I", imgui.xFont("marske5"), 25, 25)
				draw.SimpleText(today .. " || " ..GetGlobalFloat("HoursTimeFloat") .. " : " .. GetGlobalFloat("MinutsTimeFloat"), imgui.xFont("marske5"), 245, 25)
				draw.SimpleText("________________________________________________", imgui.xFont("marske6"), 25, 30, Color(0,255,128))
				draw.SimpleText("Продовольствие города", imgui.xFont("marske8"), 25, 50)
				draw.SimpleText("________________________________________________", imgui.xFont("marske6"), 25, 62, Color(0,255,128))


				local bx = 40
				local by = 70
				local bk = 1
				if imgui.xTextButton("Назад", "TargetIDSmall", 0, 320, 125, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
					if PartyTerminalAccess[LocalPlayer():Team()] then
						self:SetNWBool("Factory_Rations_Open", false)
						self:EmitSound("buttons/button15.wav")
					else
						self:EmitSound("buttons/button16.wav")
					end
				end

				draw.SimpleText("//", imgui.xFont("marske5"), 30, 100, Color(0,255,128))
				draw.SimpleText("//", imgui.xFont("marske5"), 30, 125, Color(0,255,128))
				draw.SimpleText("//", imgui.xFont("marske5"), 30, 210, Color(0,255,128))
				draw.SimpleText("//", imgui.xFont("marske5"), 30, 235, Color(0,255,128))

				local provisor = "отсутствует"
				for k,v in pairs(player.GetAll()) do
				   if v:GetNWString("Player_WorkStatus") == "Провизор" then
					   provisor = "присутствует"
				   end
				end

				draw.SimpleText("Пищевых единиц в раздатчике: " .. GetGlobalInt("Factory_Rations_Dispenser"), imgui.xFont("marske5"), 45, 100, Color(255,255,255))
				draw.SimpleText("Мясо в контейнерах: " .. GetGlobalInt("Factory_Rations_Meat"), imgui.xFont("marske5"), 45, 125, Color(255,255,255))
				draw.SimpleText("Сырое мясо выдано: " .. GetGlobalInt("City_FactoryRation_MeatGiven"), imgui.xFont("marske4"), 75, 150, Color(255,255,255))
				draw.SimpleText("Готовое мясо получено: " .. GetGlobalInt("City_FactoryRation_MeatCompleted"), imgui.xFont("marske4"), 75, 170, Color(255,255,255))
				draw.SimpleText("Разница: " .. GetGlobalInt("City_FactoryRation_MeatGiven") - GetGlobalInt("City_FactoryRation_MeatCompleted"), imgui.xFont("marske4"), 75, 190, Color(255,255,255))

				draw.SimpleText("Энзимы в контейнерах: " .. GetGlobalInt("Factory_Rations_Enzymes"), imgui.xFont("marske5"), 45, 210, Color(255,255,255))
				draw.SimpleText("Провизор: " .. provisor, imgui.xFont("marske5"), 45, 235, Color(255,255,255))
			
			elseif self:GetNWBool("Sity_Status_Open") then
				local today = os.date("%d.%m.%Y", os.time())
				draw.SimpleText("C17I", imgui.xFont("marske5"), 25, 25)
				draw.SimpleText(today .. " || " ..GetGlobalFloat("HoursTimeFloat") .. " : " .. GetGlobalFloat("MinutsTimeFloat"), imgui.xFont("marske5"), 245, 25)
				draw.SimpleText("________________________________________________", imgui.xFont("marske6"), 25, 30, Color(0,255,128))
				draw.SimpleText("Статус города:", imgui.xFont("marske8"), 30, 50)
				draw.SimpleText("________________________________________________", imgui.xFont("marske6"), 25, 62, Color(0,255,128))


				local bx = 40
				local by = 70
				local bk = 1
				if imgui.xTextButton("Назад", "TargetIDSmall", 0, 320, 125, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
					if PartyTerminalAccess[LocalPlayer():Team()] then
						self:SetNWBool("Sity_Status_Open", false)
						self:EmitSound("buttons/button15.wav")
					else
						self:EmitSound("buttons/button16.wav")
					end
				end

				draw.SimpleText("//", imgui.xFont("marske5"), 30, 100, Color(0,255,128))
				draw.SimpleText("Изменение статуса города:", imgui.xFont("marske5"), 45, 100, Color(255,255,255))

				local city_statuses = {
					{
						["Название"] = "Штатный режим.",
						["Код"] = "CodeGreen",
						["Включен"] = GetGlobalBool("DarkRP_LockdownCodeGreen", true)
					},
					{
						["Название"] = "Локальные беспорядки.",
						["Код"] = "CodeYellow",
						["Включен"] = GetGlobalBool("DarkRP_LockdownCodeYellow", false)
					},
					{
						["Название"] = "Нарушение социальной стабильности.",
						["Код"] = "CodeOrange",
						["Включен"] = GetGlobalBool("DarkRP_LockdownCodeOrange", false)
					},
					{
						["Название"] = "Угроза стабильности.",
						["Код"] = "CodeRed",
						["Включен"] = GetGlobalBool("DarkRP_LockdownCodeRed", false)
					},
					{
						["Название"] = "Инспекционная фаза.",
						["Код"] = "CodeHome",
						["Включен"] = GetGlobalBool("DarkRP_LockdownCodeHome", false)
					},
					{
						["Название"] = "Биологическая угроза.",
						["Код"] = "Biohazard",
						["Включен"] = GetGlobalBool("DarkRP_LockdownBiohazard", false)
					},
					{
						["Название"] = "Рабочая фаза.",
						["Код"] = "Workphase",
						["Включен"] = GetGlobalBool("DarkRP_LockdownWorkphase", false)
					},
				}

				for k,status in pairs(city_statuses) do
					local offset_x = 0
					local status_col = Color(255,255,255)
					if status["Включен"] then
						offset_x = 25
						status_col = Color(255,195,0)
					end
					if imgui.xTextButtonLeft(">>> " .. status["Название"], "marske4", 50 + offset_x, 100 + k * 25, 325, 15, 0, status_col, Color(0,255,128), Color(0,0,0)) then
						if PartyTerminalAccess[LocalPlayer():Team()] and !status["Включен"] then
							net.Start("RisedTerminal_Party:Server")
							net.WriteInt(6,10)
							net.WriteString(status["Код"])
							net.SendToServer()
							self:EmitSound("buttons/button15.wav")
						else
							self:EmitSound("buttons/button16.wav")
						end
					end
				end

			---=== Главное меню ===---
			else
				local today = os.date("%d.%m.%Y", os.time())
				draw.SimpleText("C17I", imgui.xFont("marske5"), 25, 25)
				draw.SimpleText(today .. " || " ..GetGlobalFloat("HoursTimeFloat") .. " : " .. GetGlobalFloat("MinutsTimeFloat"), imgui.xFont("marske5"), 245, 25)
				draw.SimpleText("________________________________________________", imgui.xFont("marske6"), 25, 30)
				draw.SimpleText("Партия Альянса", imgui.xFont("marske8"), 90, 50)
				draw.SimpleText("________________________________________________", imgui.xFont("marske6"), 25, 62)
				if IsValid(self:GetNWEntity("PartyTerminal_Subject")) then
					if imgui.xTextButton("Гражданин:", "marske5", 0, 90, 175, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
						if PartyTerminalAccess[LocalPlayer():Team()] then
							net.Start("RisedTerminal_Party:Server")
							net.WriteInt(-1,10)
							net.SendToServer()
							self:EmitSound("buttons/button15.wav")
						else
							self:EmitSound("buttons/button16.wav")
						end
					end
					draw.SimpleText(self:GetNWEntity("PartyTerminal_Subject"):Name(), imgui.xFont("marske5"), 150, 90)
				else
					draw.SimpleText("Гражданин не установлен", imgui.xFont("marske4"), 100, 85)
					draw.SimpleText("Для некоторых операций гражданину", imgui.xFont("DebugFixedSmall"), 20, 100)
					draw.SimpleText("необходимо вставить ID карту в терминал", imgui.xFont("DebugFixedSmall"), 20, 112)
				end

				local bx = 30
				local by = 150

				local tx = 30

				draw.SimpleText("Трудоустройство:", imgui.xFont("marske4"), bx, by - 20, Color(255,180,120))
				draw.SimpleText("-----------------------------------", imgui.xFont("marske5"), bx, by - 10)
				if imgui.xTextButtonLeft("Найм сотрудника", "TargetIDSmall", tx, by, 175, 15, 0, Color(36,36,36), Color(75,75,75), Color(0,0,0)) then
					-- if PartyTerminalAccess[LocalPlayer():Team()] then
					-- 	self:SetNWBool("Opened_NAV", true)
					-- 	self:EmitSound("buttons/button15.wav")
					-- else
						self:EmitSound("buttons/button16.wav")
					-- end
				end
				if imgui.xTextButtonLeft("Повышение квалификации", "TargetIDSmall", tx, by + 15, 175, 15, 0, Color(36,36,36), Color(75,75,75), Color(0,0,0)) then
					-- if PartyTerminalAccess[LocalPlayer():Team()] then
					-- 	self:SetNWBool("Opened_NAV", true)
					-- 	self:EmitSound("buttons/button15.wav")
					-- else
						self:EmitSound("buttons/button16.wav")
					-- end
				end
				if imgui.xTextButtonLeft("Увольнение сотрудника", "TargetIDSmall", tx, by + 30, 175, 15, 0, Color(36,36,36), Color(75,75,75), Color(0,0,0)) then
					-- if PartyTerminalAccess[LocalPlayer():Team()] then
					-- 	self:SetNWBool("Opened_NAV", true)
					-- 	self:EmitSound("buttons/button15.wav")
					-- else
						self:EmitSound("buttons/button16.wav")
					-- end
				end

				by =  by + 80
				draw.SimpleText("Обеспечение жильем:", imgui.xFont("marske4"), bx, by - 20, Color(255,180,120))
				draw.SimpleText("------------------------------------------", imgui.xFont("marske5"), bx, by - 10)
				if imgui.xTextButtonLeft("Заселение в квартиру [ID]", "TargetIDSmall", tx, by, 175, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
					if IsValid(self:GetNWEntity("PartyTerminal_Subject")) and (PartyTerminalAccess[LocalPlayer():Team()]) then
						self:SetNWBool("House_Apartment_Entry", true)
						self:EmitSound("buttons/button15.wav")
					else
						self:EmitSound("buttons/button16.wav")
					end
				end
				if imgui.xTextButtonLeft("Заселение в общежитие [ID]", "TargetIDSmall", tx, by + 15, 175, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
					if IsValid(self:GetNWEntity("PartyTerminal_Subject")) and (PartyTerminalAccess[LocalPlayer():Team()]) then
						self:SetNWBool("House_Hostel_Entry", true)
						self:EmitSound("buttons/button15.wav")
					else
						self:EmitSound("buttons/button16.wav")
					end
				end
				if imgui.xTextButtonLeft("Выселение", "TargetIDSmall", tx, by + 30, 175, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
					if PartyTerminalAccess[LocalPlayer():Team()] then
						self:SetNWBool("House_Apartment_Leave_Player", true)
						self:EmitSound("buttons/button15.wav")
					else
						self:EmitSound("buttons/button16.wav")
					end
				end

				by =  by + 80
				draw.SimpleText("Эффекивность ГСР:", imgui.xFont("marske4"), bx, by - 20, Color(255,180,120))
				draw.SimpleText("--------------------------------------", imgui.xFont("marske5"), bx, by - 10)
				if imgui.xTextButtonLeft("Металлургический завод", "TargetIDSmall", tx, by, 175, 15, 0, Color(36,36,36), Color(75,75,75), Color(0,0,0)) then
					-- if PartyTerminalAccess[LocalPlayer():Team()] then
					-- 	self:SetNWBool("Opened_NAV", true)
					-- 	self:EmitSound("buttons/button15.wav")
					-- else
						self:EmitSound("buttons/button16.wav")
					-- end
				end
				if imgui.xTextButtonLeft("Продовольствие города", "TargetIDSmall", tx, by + 15, 175, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
					if PartyTerminalAccess[LocalPlayer():Team()] then
						self:SetNWBool("Factory_Rations_Open", true)
						self:EmitSound("buttons/button15.wav")
					else
						self:EmitSound("buttons/button16.wav")
					end
				end

				bx = 240
				by = 150

				tx = 240
				draw.SimpleText("Дела партии:", imgui.xFont("marske4"), bx, by - 20, Color(255,180,120))
				draw.SimpleText("------------------------", imgui.xFont("marske5"), bx, by - 10)
				if imgui.xTextButtonLeft("Изменить законы", "TargetIDSmall", tx, by, 175, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
					if PartyTerminalAccess[LocalPlayer():Team()] then
						self:SetNWBool("Opened_Laws_Menu", true)
						self:EmitSound("buttons/button15.wav")
					else
						self:EmitSound("buttons/button16.wav")
					end
				end
				if imgui.xTextButtonLeft("Принять в партию [ID]", "TargetIDSmall", tx, by + 15, 175, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
					if IsValid(self:GetNWEntity("PartyTerminal_Subject")) and (PartyTerminalAccess[LocalPlayer():Team()]) then
						self:SetNWBool("Party_Join_Choose", true)
						self:EmitSound("buttons/button15.wav")
					else
						self:EmitSound("buttons/button16.wav")
					end
				end
				if imgui.xTextButtonLeft("Изменение статуса города", "TargetIDSmall", tx, by + 15 * 2, 175, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
					if PartyTerminalAccess[LocalPlayer():Team()] then
						self:SetNWBool("Sity_Status_Open", true)
						self:EmitSound("buttons/button15.wav")
					else
						self:EmitSound("buttons/button16.wav")
					end
				end

				by =  by + 80
				draw.SimpleText("Гражданские:", imgui.xFont("marske4"), bx, by - 20, Color(255,180,120))
				draw.SimpleText("--------------------------", imgui.xFont("marske5"), bx, by - 10)
				if imgui.xTextButtonLeft("Выдача талона на еду [ID]", "TargetIDSmall", tx, by, 175, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
					if IsValid(self:GetNWEntity("PartyTerminal_Subject")) and (PartyTerminalAccess[LocalPlayer():Team()]) then
						net.Start("RisedTerminal_Party:Server")
						net.WriteInt(51,10)
						net.SendToServer()
						self:EmitSound("buttons/button15.wav")
					else
						self:EmitSound("buttons/button16.wav")
					end
				end
				if imgui.xTextButtonLeft("Личные дела", "TargetIDSmall", tx, by + 15, 175, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
					if PartyTerminalAccess[LocalPlayer():Team()] then
						self:SetNWBool("Citizen_File_Choose", true)
						self:EmitSound("buttons/button15.wav")
					else
						self:EmitSound("buttons/button16.wav")
					end
				end
				if imgui.xTextButtonLeft("Доносы", "TargetIDSmall", tx, by + 30, 175, 15, 0, Color(36,36,36), Color(75,75,75), Color(0,0,0)) then
					-- if PartyTerminalAccess[LocalPlayer():Team()] then
						--self:SetNWBool("Opened_NAV", true)
						--self:EmitSound("buttons/button15.wav")
					--else
						self:EmitSound("buttons/button16.wav")
					--end
				end
				if imgui.xTextButtonLeft("Очки лояльности", "TargetIDSmall", tx, by + 45, 175, 15, 0, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
					if PartyTerminalAccess[LocalPlayer():Team()] then
						if IsValid(self:GetNWEntity("PartyTerminal_Subject")) then
							self:SetNWBool("Citizen_Loyalty_Open", true)
							self:EmitSound("buttons/button15.wav")
						else
							chat.AddText( Color( 51, 255, 119 ), "***********************")
							chat.AddText( Color( 128, 255, 245 ), "Необходимо чтобы гражданин вставил ID карту в приемник")
							chat.AddText( Color( 51, 255, 119 ), "***********************")
						end
					else
						self:EmitSound("buttons/button16.wav")
					end
				end

				if imgui.xTextButton("Выкл.", "TargetIDSmall", 425, 405, 45, 25, 2, Color(255,255,255), Color(75,75,75), Color(0,0,0)) then
					if PartyTerminalAccess[LocalPlayer():Team()] then
						self:SetNWBool("Enabled", false)
						self:EmitSound("buttons/button1.wav")
					else
						self:EmitSound("buttons/button16.wav")
					end
				end
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
		surface.DrawTexturedRect(cursor_x, cursor_y, 7, 7)

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


