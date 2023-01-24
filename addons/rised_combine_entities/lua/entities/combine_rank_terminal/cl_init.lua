-- "addons\\rised_combine_entities\\lua\\entities\\combine_rank_terminal\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
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

function CanChangeCombineJob(ply)
	return GAMEMODE.MetropoliceCmdJobs[ply:Team()] or ply:Team() == TEAM_OWUDISPATCH
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

-- 3D2D UI should be rendered in translucent pass, so this should be either TRANSLUCENT or BOTH
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
				local page = 1

function ENT:DrawTranslucent()
	
	self:DrawModel()
	
	if LocalPlayer():GetPos():Distance(self:GetPos()) > 150 then return end

	if shouldAcceptInput() then
		local wasPressing = gState.pressing
		gState.pressing = input.IsMouseDown(MOUSE_LEFT) or input.IsKeyDown(KEY_E)
		gState.pressed = not wasPressing and gState.pressing
	end
	
	if imgui.Entity3D2D(self, Vector(-3, -8, 49), Angle(0, 90, 42), 0.04) then

		draw.RoundedBox(1,-42,35,385,190,Color(15,15,15, 225))
		if self.Opened_Unit_Change then
			if self.Unit_PlayerInfo != NULL and self.Unit_PlayerInfo:IsPlayer() then
				draw.SimpleText(self.Unit_PlayerInfo:Name(), imgui.xFont("CloseCaption_Normal"), 75, 43)
				if imgui.xTextButton("<<<<<", "CloseCaption_Normal", -20, 42, 100, 25, 0, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
					self.Opened_Unit_Change = false
					self:EmitSound("buttons/combine_button3.wav")
				end
				
				if self.Unit_PlayerInfo:Team() == TEAM_MPF_JURY_Conscript then
					if imgui.xTextButton("Conscript", "marske4", -25, 75, 110, 20, 3, Color(255,255,255), Color(255,255,255), Color(255,255,255)) then end
				elseif self.Unit_PlayerInfo.Player_ExpCombine and self.Unit_PlayerInfo.Player_ExpCombine < 0 then
					if imgui.xTextButton("Conscript", "marske4", -25, 75, 110, 20, 1, Color(100,100,100), Color(100,100,100), Color(100,100,100)) then end
				else
					if imgui.xTextButton("Conscript", "marske4", -25, 75, 110, 20, 1, Color(255,255,255), Color(255,195,87), Color(50,50,50)) then
						net.Start("Net_CombineRanks_ChangeJob")
						net.WriteEntity(self.Unit_PlayerInfo)
						net.WriteInt(TEAM_MPF_JURY_Conscript, 10)
						net.SendToServer()
						self:EmitSound("buttons/combine_button5.wav")
					end
				end
				
				if self.Unit_PlayerInfo:Team() == TEAM_MPF_JURY_PVT then
					if imgui.xTextButton("JURY.PVT", "marske4", -25, 95, 110, 20, 3, Color(255,255,255), Color(255,255,255), Color(255,255,255)) then end
				elseif self.Unit_PlayerInfo.Player_ExpCombine and self.Unit_PlayerInfo.Player_ExpCombine < 0 then
					if imgui.xTextButton("JURY.PVT", "marske4", -25, 95, 110, 20, 1, Color(100,100,100), Color(100,100,100), Color(100,100,100)) then end
				else
					if imgui.xTextButton("JURY.PVT", "marske4", -25, 95, 110, 20, 1, Color(255,255,255), Color(255,195,87), Color(50,50,50)) then
						net.Start("Net_CombineRanks_ChangeJob")
						net.WriteEntity(self.Unit_PlayerInfo)
						net.WriteInt(TEAM_MPF_JURY_PVT, 10)
						net.SendToServer()
						self:EmitSound("buttons/combine_button5.wav")
					end
				end
				
				if self.Unit_PlayerInfo:Team() == TEAM_MPF_JURY_CPL then
					if imgui.xTextButton("JURY.CPL", "marske4", -25, 115, 110, 20, 3, Color(255,255,255), Color(255,255,255), Color(255,255,255)) then end
				elseif self.Unit_PlayerInfo.Player_ExpCombine and self.Unit_PlayerInfo.Player_ExpCombine < 0 then
					if imgui.xTextButton("JURY.CPL", "marske4", -25, 115, 110, 20, 1, Color(100,100,100), Color(100,100,100), Color(100,100,100)) then end
				else
					if imgui.xTextButton("JURY.CPL", "marske4", -25, 115, 110, 20, 1, Color(255,255,255), Color(255,195,87), Color(50,50,50)) then
						net.Start("Net_CombineRanks_ChangeJob")
						net.WriteEntity(self.Unit_PlayerInfo)
						net.WriteInt(TEAM_MPF_JURY_CPL, 10)
						net.SendToServer()
						self:EmitSound("buttons/combine_button5.wav")
					end
				end
				
				if self.Unit_PlayerInfo:Team() == TEAM_MPF_JURY_SGT then
					if imgui.xTextButton("JURY.SGT", "marske4", -25, 135, 110, 20, 3, Color(255,255,255), Color(255,255,255), Color(255,255,255)) then end
				elseif self.Unit_PlayerInfo.Player_ExpCombine and self.Unit_PlayerInfo.Player_ExpCombine < 0 then
					if imgui.xTextButton("JURY.SGT", "marske4", -25, 135, 110, 20, 1, Color(100,100,100), Color(100,100,100), Color(100,100,100)) then end
				else
					if imgui.xTextButton("JURY.SGT", "marske4", -25, 135, 110, 20, 1, Color(255,255,255), Color(255,195,87), Color(50,50,50)) then
						net.Start("Net_CombineRanks_ChangeJob")
						net.WriteEntity(self.Unit_PlayerInfo)
						net.WriteInt(TEAM_MPF_JURY_SGT, 10)
						net.SendToServer()
						self:EmitSound("buttons/combine_button5.wav")
					end
				end
				
				if self.Unit_PlayerInfo:Team() == TEAM_MPF_JURY_LT then
					if imgui.xTextButton("JURY.LT", "marske4", -25, 155, 110, 20, 3, Color(255,255,255), Color(255,255,255), Color(255,255,255)) then end
				elseif self.Unit_PlayerInfo.Player_ExpCombine and self.Unit_PlayerInfo.Player_ExpCombine < 0 then
					if imgui.xTextButton("JURY.LT", "marske4", -25, 155, 110, 20, 1, Color(100,100,100), Color(100,100,100), Color(100,100,100)) then end
				else
					if imgui.xTextButton("JURY.LT", "marske4", -25, 155, 110, 20, 1, Color(255,255,255), Color(255,195,87), Color(50,50,50)) then
						net.Start("Net_CombineRanks_ChangeJob")
						net.WriteEntity(self.Unit_PlayerInfo)
						net.WriteInt(TEAM_MPF_JURY_LT, 10)
						net.SendToServer()
						self:EmitSound("buttons/combine_button5.wav")
					end
				end
				
				if self.Unit_PlayerInfo:Team() == TEAM_MPF_JURY_CPT then
					if imgui.xTextButton("JURY.CPT", "marske4", -25, 175, 110, 20, 3, Color(255,255,255), Color(255,255,255), Color(255,255,255)) then end
				elseif self.Unit_PlayerInfo.Player_ExpCombine and self.Unit_PlayerInfo.Player_ExpCombine < 0 then
					if imgui.xTextButton("JURY.CPT", "marske4", -25, 175, 110, 20, 1, Color(100,100,100), Color(100,100,100), Color(100,100,100)) then end
				else
					if imgui.xTextButton("JURY.CPT", "marske4", -25, 175, 110, 20, 1, Color(255,255,255), Color(255,195,87), Color(50,50,50)) then
						net.Start("Net_CombineRanks_ChangeJob")
						net.WriteEntity(self.Unit_PlayerInfo)
						net.WriteInt(TEAM_MPF_JURY_CPT, 10)
						net.SendToServer()
						self:EmitSound("buttons/combine_button5.wav")
					end
				end
				
				if self.Unit_PlayerInfo:Team() == TEAM_CITIZENXXX then
					if imgui.xTextButton("Уволить сотрудника", "marske4", 45, 197, 250, 20, 3, Color(255,255,255), Color(255,255,255), Color(255,255,255)) then end
				elseif self.Unit_PlayerInfo.Player_ExpCombine and self.Unit_PlayerInfo.Player_ExpCombine < 0 then
					if imgui.xTextButton("Уволить сотрудника", "marske4", 45, 197, 250, 20, 1, Color(100,100,100), Color(100,100,100), Color(100,100,100)) then end
				else
					if imgui.xTextButton("Уволить сотрудника", "marske3", 45, 197, 250, 20, 1, Color(215,215,215), Color(255,0,0), Color(255,0,0)) then
						net.Start("Net_CombineRanks_ChangeJob")
						net.WriteEntity(self.Unit_PlayerInfo)
						net.WriteInt(TEAM_CITIZENXXX, 10)
						net.SendToServer()
						self:EmitSound("buttons/combine_button5.wav")
					end
				end
				
				if self.Unit_PlayerInfo:Team() == TEAM_MPF_ETHERNAL_SGT then
					if imgui.xTextButton("ETHERNAL.SGT", "marske4", 100, 75, 110, 20, 3, Color(255,255,255), Color(255,255,255), Color(255,255,255)) then end
				elseif self.Unit_PlayerInfo.Player_ExpCombine and self.Unit_PlayerInfo.Player_ExpCombine < 0 then
					if imgui.xTextButton("ETHERNAL.SGT", "marske4", 100, 75, 110, 20, 1, Color(100,100,100), Color(100,100,100), Color(100,100,100)) then end
				else
					if imgui.xTextButton("ETHERNAL.SGT", "marske4", 100, 75, 110, 20, 1, Color(255,255,255), Color(255,195,87), Color(50,50,50)) then
						net.Start("Net_CombineRanks_ChangeJob")
						net.WriteEntity(self.Unit_PlayerInfo)
						net.WriteInt(TEAM_MPF_ETHERNAL_SGT, 10)
						net.SendToServer()
						self:EmitSound("buttons/combine_button5.wav")
					end
				end
				
				if self.Unit_PlayerInfo:Team() == TEAM_MPF_ETHERNAL_LT then
					if imgui.xTextButton("ETHERNAL.LT", "marske4", 100, 95, 110, 20, 3, Color(255,255,255), Color(255,255,255), Color(255,255,255)) then end
				elseif self.Unit_PlayerInfo.Player_ExpCombine and self.Unit_PlayerInfo.Player_ExpCombine < 0 then
					if imgui.xTextButton("ETHERNAL.LT", "marske4", 100, 95, 110, 20, 1, Color(100,100,100), Color(100,100,100), Color(100,100,100)) then end
				else
					if imgui.xTextButton("ETHERNAL.LT", "marske4", 100, 95, 110, 20, 1, Color(255,255,255), Color(255,195,87), Color(50,50,50)) then
						net.Start("Net_CombineRanks_ChangeJob")
						net.WriteEntity(self.Unit_PlayerInfo)
						net.WriteInt(TEAM_MPF_ETHERNAL_LT, 10)
						net.SendToServer()
						self:EmitSound("buttons/combine_button5.wav")
					end
				end
				
				if self.Unit_PlayerInfo:Team() == TEAM_MPF_ETHERNAL_CPT then
					if imgui.xTextButton("ETHERNAL.CPT", "marske4", 100, 115, 110, 20, 3, Color(255,255,255), Color(255,255,255), Color(255,255,255)) then end
				elseif self.Unit_PlayerInfo.Player_ExpCombine and self.Unit_PlayerInfo.Player_ExpCombine < 0 then
					if imgui.xTextButton("ETHERNAL.CPT", "marske4", 100, 115, 110, 20, 1, Color(100,100,100), Color(100,100,100), Color(100,100,100)) then end
				else
					if imgui.xTextButton("ETHERNAL.CPT", "marske4", 100, 115, 110, 20, 1, Color(255,255,255), Color(255,195,87), Color(50,50,50)) then
						net.Start("Net_CombineRanks_ChangeJob")
						net.WriteEntity(self.Unit_PlayerInfo)
						net.WriteInt(TEAM_MPF_ETHERNAL_CPT, 10)
						net.SendToServer()
						self:EmitSound("buttons/combine_button5.wav")
					end
				end
				
				if self.Unit_PlayerInfo:Team() == TEAM_MPF_PLUNGER_SGT then
					if imgui.xTextButton("PLUNGER.SGT", "marske4", 100, 135, 110, 20, 3, Color(255,255,255), Color(255,255,255), Color(255,255,255)) then end
				elseif self.Unit_PlayerInfo.Player_ExpCombine and self.Unit_PlayerInfo.Player_ExpCombine < 0 then
					if imgui.xTextButton("PLUNGER.SGT", "marske4", 100, 135, 110, 20, 1, Color(100,100,100), Color(100,100,100), Color(100,100,100)) then end
				else
					if imgui.xTextButton("PLUNGER.SGT", "marske4", 100, 135, 110, 20, 1, Color(255,255,255), Color(255,195,87), Color(50,50,50)) then
						net.Start("Net_CombineRanks_ChangeJob")
						net.WriteEntity(self.Unit_PlayerInfo)
						net.WriteInt(TEAM_MPF_PLUNGER_SGT, 10)
						net.SendToServer()
						self:EmitSound("buttons/combine_button5.wav")
					end
				end
				
				if self.Unit_PlayerInfo:Team() == TEAM_MPF_PLUNGER_LT then
					if imgui.xTextButton("PLUNGER.LT", "marske4", 100, 155, 110, 20, 3, Color(255,255,255), Color(255,255,255), Color(255,255,255)) then end
				elseif self.Unit_PlayerInfo.Player_ExpCombine and self.Unit_PlayerInfo.Player_ExpCombine < 0 then
					if imgui.xTextButton("PLUNGER.LT", "marske4", 100, 155, 110, 20, 1, Color(100,100,100), Color(100,100,100), Color(100,100,100)) then end
				else
					if imgui.xTextButton("PLUNGER.LT", "marske4", 100, 155, 110, 20, 1, Color(255,255,255), Color(255,195,87), Color(50,50,50)) then
						net.Start("Net_CombineRanks_ChangeJob")
						net.WriteEntity(self.Unit_PlayerInfo)
						net.WriteInt(TEAM_MPF_PLUNGER_LT, 10)
						net.SendToServer()
						self:EmitSound("buttons/combine_button5.wav")
					end
				end
				
				if self.Unit_PlayerInfo:Team() == TEAM_MPF_PLUNGER_CPT then
					if imgui.xTextButton("PLUNGER.CPT", "marske4", 100, 175, 110, 20, 3, Color(255,255,255), Color(255,255,255), Color(255,255,255)) then end
				elseif self.Unit_PlayerInfo.Player_ExpCombine and self.Unit_PlayerInfo.Player_ExpCombine < 0 then
					if imgui.xTextButton("PLUNGER.CPT", "marske4", 100, 175, 110, 20, 1, Color(100,100,100), Color(100,100,100), Color(100,100,100)) then end
				else
					if imgui.xTextButton("PLUNGER.CPT", "marske4", 100, 175, 110, 20, 1, Color(255,255,255), Color(255,195,87), Color(50,50,50)) then
						net.Start("Net_CombineRanks_ChangeJob")
						net.WriteEntity(self.Unit_PlayerInfo)
						net.WriteInt(TEAM_MPF_PLUNGER_CPT, 10)
						net.SendToServer()
						self:EmitSound("buttons/combine_button5.wav")
					end
				end
				
				if self.Unit_PlayerInfo:Team() == TEAM_MPF_WATCHER_SGT then
					if imgui.xTextButton("WATCHER.SGT", "marske4", 225, 75, 110, 20, 3, Color(255,255,255), Color(255,255,255), Color(255,255,255)) then end
				elseif self.Unit_PlayerInfo.Player_ExpCombine and self.Unit_PlayerInfo.Player_ExpCombine < 0 then
					if imgui.xTextButton("WATCHER.SGT", "marske4", 225, 75, 110, 20, 1, Color(100,100,100), Color(100,100,100), Color(100,100,100)) then end
				else
					if imgui.xTextButton("WATCHER.SGT", "marske4", 225, 75, 110, 20, 1, Color(255,255,255), Color(255,195,87), Color(50,50,50)) then
						net.Start("Net_CombineRanks_ChangeJob")
						net.WriteEntity(self.Unit_PlayerInfo)
						net.WriteInt(TEAM_MPF_WATCHER_SGT, 10)
						net.SendToServer()
						self:EmitSound("buttons/combine_button5.wav")
					end
				end
				
				if self.Unit_PlayerInfo:Team() == TEAM_MPF_WATCHER_LT then
					if imgui.xTextButton("WATCHER.LT", "marske4", 225, 95, 110, 20, 3, Color(255,255,255), Color(255,255,255), Color(255,255,255)) then end
				elseif self.Unit_PlayerInfo.Player_ExpCombine and self.Unit_PlayerInfo.Player_ExpCombine < 0 then
					if imgui.xTextButton("WATCHER.LT", "marske4", 225, 95, 110, 20, 1, Color(100,100,100), Color(100,100,100), Color(100,100,100)) then end
				else
					if imgui.xTextButton("WATCHER.LT", "marske4", 225, 95, 110, 20, 1, Color(255,255,255), Color(255,195,87), Color(50,50,50)) then
						net.Start("Net_CombineRanks_ChangeJob")
						net.WriteEntity(self.Unit_PlayerInfo)
						net.WriteInt(TEAM_MPF_WATCHER_LT, 10)
						net.SendToServer()
						self:EmitSound("buttons/combine_button5.wav")
					end
				end
				
				if self.Unit_PlayerInfo:Team() == TEAM_MPF_WATCHER_CPT then
					if imgui.xTextButton("WATCHER.CPT", "marske4", 225, 115, 110, 20, 3, Color(255,255,255), Color(255,255,255), Color(255,255,255)) then end
				elseif self.Unit_PlayerInfo.Player_ExpCombine and self.Unit_PlayerInfo.Player_ExpCombine < 0 then
					if imgui.xTextButton("WATCHER.CPT", "marske4", 225, 115, 110, 20, 1, Color(100,100,100), Color(100,100,100), Color(100,100,100)) then end
				else
					if imgui.xTextButton("WATCHER.CPT", "marske4", 225, 115, 110, 20, 1, Color(255,255,255), Color(255,195,87), Color(50,50,50)) then
						net.Start("Net_CombineRanks_ChangeJob")
						net.WriteEntity(self.Unit_PlayerInfo)
						net.WriteInt(TEAM_MPF_WATCHER_CPT, 10)
						net.SendToServer()
						self:EmitSound("buttons/combine_button5.wav")
					end
				end
				
				if self.Unit_PlayerInfo:Team() == TEAM_MPF_SPIRE_SGT then
					if imgui.xTextButton("SPIRE.SGT", "marske4", 225, 135, 110, 20, 3, Color(255,255,255), Color(255,255,255), Color(255,255,255)) then end
				elseif self.Unit_PlayerInfo.Player_ExpCombine and self.Unit_PlayerInfo.Player_ExpCombine < 0 then
					if imgui.xTextButton("SPIRE.SGT", "marske4", 225, 135, 110, 20, 1, Color(100,100,100), Color(100,100,100), Color(100,100,100)) then end
				else
					if imgui.xTextButton("SPIRE.SGT", "marske4", 225, 135, 110, 20, 1, Color(255,255,255), Color(255,195,87), Color(50,50,50)) then
						net.Start("Net_CombineRanks_ChangeJob")
						net.WriteEntity(self.Unit_PlayerInfo)
						net.WriteInt(TEAM_MPF_SPIRE_SGT, 10)
						net.SendToServer()
						self:EmitSound("buttons/combine_button5.wav")
					end
				end
				
				if self.Unit_PlayerInfo:Team() == TEAM_MPF_SPIRE_LT then
					if imgui.xTextButton("SPIRE.LT", "marske4", 225, 155, 110, 20, 3, Color(255,255,255), Color(255,255,255), Color(255,255,255)) then end
				elseif self.Unit_PlayerInfo.Player_ExpCombine and self.Unit_PlayerInfo.Player_ExpCombine < 0 then
					if imgui.xTextButton("SPIRE.LT", "marske4", 225, 155, 110, 20, 1, Color(100,100,100), Color(100,100,100), Color(100,100,100)) then end
				else
					if imgui.xTextButton("SPIRE.LT", "marske4", 225, 155, 110, 20, 1, Color(255,255,255), Color(255,195,87), Color(50,50,50)) then
						net.Start("Net_CombineRanks_ChangeJob")
						net.WriteEntity(self.Unit_PlayerInfo)
						net.WriteInt(TEAM_MPF_SPIRE_LT, 10)
						net.SendToServer()
						self:EmitSound("buttons/combine_button5.wav")
					end
				end
				
				if self.Unit_PlayerInfo:Team() == TEAM_MPF_SPIRE_CPT then
					if imgui.xTextButton("SPIRE.CPT", "marske4", 225, 175, 110, 20, 3, Color(255,255,255), Color(255,255,255), Color(255,255,255)) then end
				elseif self.Unit_PlayerInfo.Player_ExpCombine and self.Unit_PlayerInfo.Player_ExpCombine < 0 then
					if imgui.xTextButton("SPIRE.CPT", "marske4", 225, 175, 110, 20, 1, Color(100,100,100), Color(100,100,100), Color(100,100,100)) then end
				else
					if imgui.xTextButton("SPIRE.CPT", "marske4", 225, 175, 110, 20, 1, Color(255,255,255), Color(255,195,87), Color(50,50,50)) then
						net.Start("Net_CombineRanks_ChangeJob")
						net.WriteEntity(self.Unit_PlayerInfo)
						net.WriteInt(TEAM_MPF_SPIRE_CPT, 10)
						net.SendToServer()
						self:EmitSound("buttons/combine_button5.wav")
					end
				end
			end
		elseif self.Opened_Unit then
			if self.Unit_PlayerInfo != NULL then
				draw.SimpleText(self.Unit_PlayerInfo:Name(), imgui.xFont("CloseCaption_Normal"), 75, 43)
				if imgui.xTextButton("<<<<<", "CloseCaption_Normal", -20, 42, 100, 25, 0, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
					self.Opened_Unit = false
					self:EmitSound("buttons/combine_button3.wav")
				end
				
				draw.SimpleText("Имя . . . " .. self.Unit_PlayerInfo:Name(), imgui.xFont("marske4"), -10, 85)
				draw.SimpleText("Неподтвержденные токены . . . " .. self.Unit_PlayerInfo:GetNWInt("Player_CombineTokens_Current"), imgui.xFont("marske4"), -10, 105)
				draw.SimpleText("Очки лояльности . . . " .. self.Unit_PlayerInfo:GetNWInt("LoyaltyTokens"), imgui.xFont("marske4"), -10, 125)
				draw.SimpleText("Состояние здоровья . . . " .. self.Unit_PlayerInfo:Health(), imgui.xFont("marske4"), -10, 145)
				draw.SimpleText("Состояние брони . . . " .. self.Unit_PlayerInfo:Armor(), imgui.xFont("marske4"), -10, 165)
				
			end
		elseif self.Opened_MPF then
			if !IsValid(self.Opened_MPF_OpenPlayer) then
				draw.SimpleText("Metropolice Force", imgui.xFont("CloseCaption_Normal"), 100, 40)
				if imgui.xTextButton("<<<<<", "CloseCaption_Normal", -20, 42, 100, 25, 0, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
					self.Opened_MPF = false
					self.Opened_MPF_OpenPlayer = nil
					self:EmitSound("buttons/combine_button3.wav")
				end
				local players = {}
				for k,v in pairs(player.GetAll()) do
					if !GAMEMODE.MetropoliceJobs[v:Team()] then continue end
					table.insert(players, v)
				end
				
				for k,v in pairs(players) do
					if page == 1 and k < 5 then
						if imgui.xTextButton(v:Name(), "CloseCaption_Normal", -25, 45 + 30 * k, 350, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
							self.Opened_MPF_OpenPlayer = v
							self:EmitSound("buttons/combine_button1.wav")
						end
					elseif page == 2 and k >= 5 and k < 9 then
						if imgui.xTextButton(v:Name(), "CloseCaption_Normal", -25, 45 + 30 * (k - 4), 350, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
							self.Opened_MPF_OpenPlayer = v
							self:EmitSound("buttons/combine_button1.wav")
						end
					elseif page == 3 and k >= 9 and k < 13 then
						if imgui.xTextButton(v:Name(), "CloseCaption_Normal", -25, 45 + 30 * (k - 8), 350, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
							self.Opened_MPF_OpenPlayer = v
							self:EmitSound("buttons/combine_button1.wav")
						end
					elseif page == 4 and k >= 13 and k < 17 then
						if imgui.xTextButton(v:Name(), "CloseCaption_Normal", -25, 45 + 30 * (k - 12), 350, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
							self.Opened_MPF_OpenPlayer = v
							self:EmitSound("buttons/combine_button1.wav")
						end
					elseif page == 5 and k >= 17 and k < 21 then
						if imgui.xTextButton(v:Name(), "CloseCaption_Normal", -25, 45 + 30 * (k - 16), 350, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
							self.Opened_MPF_OpenPlayer = v
							self:EmitSound("buttons/combine_button1.wav")
						end
					elseif page == 6 and k >= 21 and k < 25 then
						if imgui.xTextButton(v:Name(), "CloseCaption_Normal", -25, 45 + 30 * (k - 20), 350, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
							self.Opened_MPF_OpenPlayer = v
							self:EmitSound("buttons/combine_button1.wav")
						end
					elseif page == 7 and k >= 25 and k < 29 then
						if imgui.xTextButton(v:Name(), "CloseCaption_Normal", -25, 45 + 30 * (k - 24), 350, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
							self.Opened_MPF_OpenPlayer = v
							self:EmitSound("buttons/combine_button1.wav")
						end
					elseif page == 8 and k >= 29 and k < 33 then
						if imgui.xTextButton(v:Name(), "CloseCaption_Normal", -25, 45 + 30 * (k - 28), 350, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
							self.Opened_MPF_OpenPlayer = v
							self:EmitSound("buttons/combine_button1.wav")
						end
					elseif page == 9 and k >= 33 and k < 37 then
						if imgui.xTextButton(v:Name(), "CloseCaption_Normal", -25, 45 + 30 * (k - 32), 350, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
							self.Opened_MPF_OpenPlayer = v
							self:EmitSound("buttons/combine_button1.wav")
						end
					elseif page == 10 and k >= 37 and k < 41 then
						if imgui.xTextButton(v:Name(), "CloseCaption_Normal", -25, 45 + 30 * (k - 44), 350, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
							self.Opened_MPF_OpenPlayer = v
							self:EmitSound("buttons/combine_button1.wav")
						end
					end
				end
				if page > 1 then
					if imgui.xTextButton("<<<", "CloseCaption_Normal", -10, 195, 150, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
						self.Opened_MPF_OpenPlayer = v
						page = page - 1
						self:EmitSound("buttons/combine_button1.wav")
					end
					if imgui.xTextButton(">>>", "CloseCaption_Normal", 155, 195, 150, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
						self.Opened_MPF_OpenPlayer = v
						page = page + 1
						self:EmitSound("buttons/combine_button1.wav")
					end
				elseif page <=1 then
					if imgui.xTextButton(">>>", "CloseCaption_Normal", 155, 195, 150, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
						self.Opened_MPF_OpenPlayer = v
						page = page + 1
						self:EmitSound("buttons/combine_button1.wav")
					end
				end
			elseif IsValid(self.Opened_MPF_OpenPlayer) and self.Opened_MPF_OpenPlayer:IsPlayer() then

				draw.SimpleText(self.Opened_MPF_OpenPlayer:Name(), imgui.xFont("CloseCaption_Normal"), 75, 43)
				if imgui.xTextButton("<<<<<", "CloseCaption_Normal", -20, 42, 100, 25, 0, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
					self.Opened_MPF_OpenPlayer = nil
					self:EmitSound("buttons/combine_button3.wav")
				end
				
				if imgui.xTextButton("Информация о сотруднике", "CloseCaption_Normal", -25, 75, 350, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
					self.Unit_PlayerInfo = self.Opened_MPF_OpenPlayer
					self.Opened_Unit = true
					self:EmitSound("buttons/combine_button1.wav")
				end
				
				-- if imgui.xTextButton("Подтвердить токены", "CloseCaption_Normal", -25, 105, 350, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
				-- 	net.Start("Net_CombineRanks_Terminal_Approve")
				-- 	net.WriteEntity(self.Opened_MPF_OpenPlayer)
				-- 	net.SendToServer()
				-- 	self:EmitSound("buttons/combine_button5.wav")
				-- end
				
				if imgui.xTextButton("Перевод", "CloseCaption_Normal", -25, 135, 350, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
					self.Unit_PlayerInfo = self.Opened_MPF_OpenPlayer
					self.Opened_Unit_Change = true
					self:EmitSound("buttons/combine_button1.wav")
				end
				
				-- if imgui.xTextButton("Наказать", "CloseCaption_Normal", -25, 165, 350, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
				-- 	net.Start("Net_CombineRanks_Terminal_Punish")
				-- 	net.WriteEntity(self.Opened_MPF_OpenPlayer)
				-- 	net.SendToServer()
				-- 	self:EmitSound("buttons/combine_button5.wav")
				-- end
			end
		elseif self.Opened_OTA then
			if self.Opened_OTA_OpenPlayer == NULL then
				draw.SimpleText("Overwatch Transhuman Arm", imgui.xFont("CloseCaption_Normal"), 100, 40)
				if imgui.xTextButton("<<<<<", "CloseCaption_Normal", -20, 42, 100, 25, 0, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
					self.Opened_OTA = false
					self.Opened_OTA_OpenPlayer = nil
					self:EmitSound("buttons/combine_button3.wav")
				end
				local players = {}
				for k,v in pairs(player.GetAll()) do
					if !GAMEMODE.CombineJobs[v:Team()] then continue end
					table.insert(players, v)
				end
				
				for k,v in pairs(players) do
					if page == 1 and k < 5 then
						if imgui.xTextButton(v:Name(), "CloseCaption_Normal", -25, 45 + 30 * k, 350, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
							self.Opened_OTA_OpenPlayer = v
							self:EmitSound("buttons/combine_button1.wav")
						end
					elseif page == 2 and k >= 5 and k < 9 then
						if imgui.xTextButton(v:Name(), "CloseCaption_Normal", -25, 45 + 30 * (k - 4), 350, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
							self.Opened_OTA_OpenPlayer = v
							self:EmitSound("buttons/combine_button1.wav")
						end
					elseif page == 3 and k >= 9 and k < 13 then
						if imgui.xTextButton(v:Name(), "CloseCaption_Normal", -25, 45 + 30 * (k - 8), 350, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
							self.Opened_OTA_OpenPlayer = v
							self:EmitSound("buttons/combine_button1.wav")
						end
					elseif page == 4 and k >= 13 and k < 17 then
						if imgui.xTextButton(v:Name(), "CloseCaption_Normal", -25, 45 + 30 * (k - 12), 350, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
							self.Opened_OTA_OpenPlayer = v
							self:EmitSound("buttons/combine_button1.wav")
						end
					elseif page == 5 and k >= 17 and k < 21 then
						if imgui.xTextButton(v:Name(), "CloseCaption_Normal", -25, 45 + 30 * (k - 16), 350, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
							self.Opened_OTA_OpenPlayer = v
							self:EmitSound("buttons/combine_button1.wav")
						end
					elseif page == 6 and k >= 21 and k < 25 then
						if imgui.xTextButton(v:Name(), "CloseCaption_Normal", -25, 45 + 30 * (k - 20), 350, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
							self.Opened_OTA_OpenPlayer = v
							self:EmitSound("buttons/combine_button1.wav")
						end
					elseif page == 7 and k >= 25 and k < 29 then
						if imgui.xTextButton(v:Name(), "CloseCaption_Normal", -25, 45 + 30 * (k - 24), 350, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
							self.Opened_OTA_OpenPlayer = v
							self:EmitSound("buttons/combine_button1.wav")
						end
					elseif page == 8 and k >= 29 and k < 33 then
						if imgui.xTextButton(v:Name(), "CloseCaption_Normal", -25, 45 + 30 * (k - 28), 350, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
							self.Opened_OTA_OpenPlayer = v
							self:EmitSound("buttons/combine_button1.wav")
						end
					elseif page == 9 and k >= 33 and k < 37 then
						if imgui.xTextButton(v:Name(), "CloseCaption_Normal", -25, 45 + 30 * (k - 32), 350, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
							self.Opened_OTA_OpenPlayer = v
							self:EmitSound("buttons/combine_button1.wav")
						end
					elseif page == 10 and k >= 37 and k < 41 then
						if imgui.xTextButton(v:Name(), "CloseCaption_Normal", -25, 45 + 30 * (k - 44), 350, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
							self.Opened_OTA_OpenPlayer = v
							self:EmitSound("buttons/combine_button1.wav")
						end
					end
				end
				if page > 1 then
					if imgui.xTextButton("<<<", "CloseCaption_Normal", -10, 195, 150, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
						self.Opened_OTA_OpenPlayer = v
						page = page - 1
						self:EmitSound("buttons/combine_button1.wav")
					end
					if imgui.xTextButton(">>>", "CloseCaption_Normal", 155, 195, 150, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
						self.Opened_OTA_OpenPlayer = v
						page = page + 1
						self:EmitSound("buttons/combine_button1.wav")
					end
				elseif page <=1 then
					if imgui.xTextButton(">>>", "CloseCaption_Normal", 155, 195, 150, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
						self.Opened_OTA_OpenPlayer = v
						page = page + 1
						self:EmitSound("buttons/combine_button1.wav")
					end
				end
			else
				draw.SimpleText(self.Opened_OTA_OpenPlayer:Name(), imgui.xFont("CloseCaption_Normal"), 75, 43)
				if imgui.xTextButton("<<<<<", "CloseCaption_Normal", -20, 42, 100, 25, 0, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
					self.Opened_OTA_OpenPlayer = nil
					self:EmitSound("buttons/combine_button3.wav")
				end
				
				if imgui.xTextButton("Информация о сотруднике", "CloseCaption_Normal", -25, 75, 350, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
					self.Unit_PlayerInfo = self.Opened_OTA_OpenPlayer
					self.Opened_MPF = false
					self.Opened_OTA = false
					self.Opened_Unit = true
					self:EmitSound("buttons/combine_button1.wav")
				end
				
				-- if imgui.xTextButton("Подтвердить токены", "CloseCaption_Normal", -25, 105, 350, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
				-- 	net.Start("Net_CombineRanks_Terminal_Approve")
				-- 	net.WriteEntity(self.Opened_OTA_OpenPlayer)
				-- 	net.SendToServer()
				-- 	self:EmitSound("buttons/combine_button5.wav")
				-- end
				
				if imgui.xTextButton("Перевод", "CloseCaption_Normal", -25, 135, 350, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
					self.Unit_PlayerInfo =  self.Opened_OTA_OpenPlayer
					self.Opened_MPF = false
					self.Opened_OTA = false
					self.Opened_Unit = false
					self.Opened_Unit_Change = true
					self:EmitSound("buttons/combine_button1.wav")
				end
				
				-- if imgui.xTextButton("Наказать", "CloseCaption_Normal", -25, 165, 350, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
				-- 	net.Start("Net_CombineRanks_Terminal_Punish")
				-- 	net.WriteEntity(self.Opened_OTA_OpenPlayer)
				-- 	net.SendToServer()
				-- 	self:EmitSound("buttons/combine_button5.wav")
				-- end
			end
		else
			draw.SimpleText("Combine Rank Terminal", imgui.xFont("CloseCaption_Normal"), -20, 40)
			if imgui.xTextButton("MPF", "CloseCaption_Normal", 0, 85, 300, 25, 1, Color(255,255,255), Color(255,195,87), Color(0,0,0)) then
				if CanChangeCombineJob(LocalPlayer()) then
					self.Opened_MPF = true
					self.Opened_OTA = false
					self:EmitSound("buttons/combine_button1.wav")
				else
					self:EmitSound("buttons/combine_button_locked.wav")
				end
			end
		end
		

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


