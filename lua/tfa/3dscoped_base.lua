-- "lua\\tfa\\3dscoped_base.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local SWEP = {}

local BaseClass = baseclass.Get("tfa_gun_base")

local scopeshadowcvar = GetConVar("cl_tfa_3dscope_overlay")

local sp = game.SinglePlayer()

function SWEP:Do3DScope()
	return true
end

function SWEP:Do3DScopeOverlay()
	if scopeshadowcvar then
		return scopeshadowcvar:GetBool()
	else
		return false
	end
end

function SWEP:UpdateScopeType()
	-- empty, function retains for error preventing
end

function SWEP:Initialize(...)
	local unsetA = self.Primary_TFA == nil
	local unsetB = self.Secondary_TFA == nil

	self.Primary_TFA = self.Primary_TFA or self.Primary
	self.Secondary_TFA = self.Secondary_TFA or self.Secondary

	if unsetA then
		self.Primary_TFA = nil
	end

	if unsetB then
		self.Secondary_TFA = nil
	end

	BaseClass.Initialize(self, ...)
end

local flipcv = GetConVar("cl_tfa_viewmodel_flip")
local cd = {}
local crosscol = Color(255, 255, 255, 255)
SWEP.RTOpaque = true

local cv_cc_r = GetConVar("cl_tfa_hud_crosshair_color_r")
local cv_cc_g = GetConVar("cl_tfa_hud_crosshair_color_g")
local cv_cc_b = GetConVar("cl_tfa_hud_crosshair_color_b")
local cv_cc_a = GetConVar("cl_tfa_hud_crosshair_color_a")

SWEP.defaultscrvec = Vector()

SWEP.ScopeAngleTransformISAngleFallback = true -- fallback to reverse ironsights angle for scope transforms
SWEP.ScopeAngleTransforms = { -- this is bad this is bad this is bad this is bad this is bad this is bad this is bad this is bad this is bad
	-- {"P", 0}, -- Pitch
	-- {"Y", 0}, -- Yaw
	-- {"R", 0}, -- Roll
}

function SWEP:RTCode(rt, scrw, scrh)
	local legacy = self.ScopeLegacyOrientation
	local rttw = ScrW()
	local rtth = ScrH()

	if not self:VMIV() then return end

	if not self.myshadowmask then
		self.myshadowmask = surface.GetTextureID(self.ScopeShadow or "vgui/scope_shadowmask_test")
	end

	if not self.myreticule then
		self.myreticule = Material(self.ScopeReticule or "scope/gdcw_scopesightonly")
	end

	if not self.mydirt then
		self.mydirt = Material(self.ScopeDirt or "vgui/scope_dirt")
	end

	local vm = self.OwnerViewModel

	if not self.LastOwnerPos then
		self.LastOwnerPos = self:GetOwner():GetShootPos()
	end

	local owoff = self:GetOwner():GetShootPos() - self.LastOwnerPos

	self.LastOwnerPos = self:GetOwner():GetShootPos()

	local scrpos

	local attShadowID = self:GetStatL("RTScopeShadowAttachment")
	if attShadowID and attShadowID > 0 then
		vm:SetupBones()

		local att = vm:GetAttachment(attShadowID)
		if att and att.Pos then
			local pos = att.Pos - owoff
			cam.Start3D()
			cam.End3D()
			scrpos = pos:ToScreen()
		end
	end

	if not scrpos then
		local spos = self:GetOwner():GetShootPos() + self:GetOwner():EyeAngles():Forward() * 16

		local pos = spos - owoff
		cam.Start3D()
		cam.End3D()
		scrpos = pos:ToScreen()

		-- self.defaultscrvec.x = scrw / 2
		-- self.defaultscrvec.y = scrh / 2
		-- scrpos = self.defaultscrvec
	end

	scrpos.x = scrpos.x - scrw / 2 + self.ScopeOverlayTransforms[1]
	scrpos.y = scrpos.y - scrh / 2 + self.ScopeOverlayTransforms[2]
	scrpos.x = scrpos.x / scrw * 1920
	scrpos.y = scrpos.y / scrw * 1920
	scrpos.x = math.Clamp(scrpos.x, -1024, 1024)
	scrpos.y = math.Clamp(scrpos.y, -1024, 1024)
	--scrpos.x = scrpos.x * ( 2 - self:GetIronSightsProgress()*1 )
	--scrpos.y = scrpos.y * ( 2 - self:GetIronSightsProgress()*1 )
	scrpos.x = scrpos.x * self.ScopeOverlayTransformMultiplier
	scrpos.y = scrpos.y * self.ScopeOverlayTransformMultiplier

	if not self.scrpos then
		self.scrpos = scrpos
	end

	self.scrpos.x = math.Approach(self.scrpos.x, scrpos.x, (scrpos.x - self.scrpos.x) * FrameTime() * 10)
	self.scrpos.y = math.Approach(self.scrpos.y, scrpos.y, (scrpos.y - self.scrpos.y) * FrameTime() * 10)
	scrpos = self.scrpos
	render.OverrideAlphaWriteEnable(true, true)
	surface.SetDrawColor(color_white)
	surface.DrawRect(-512, -512, 1024, 1024)
	render.OverrideAlphaWriteEnable(true, true)

	local ang = legacy and self:GetOwner():EyeAngles() or vm:GetAngles()

	local attID = self:GetStatL("RTScopeAttachment")
	if attID and attID > 0 then
		vm:SetupBones()
		local AngPos = vm:GetAttachment( attID )

		if AngPos then
			ang = AngPos.Ang

			if flipcv:GetBool() then
				ang.y = -ang.y
			end
		end
	elseif self:GetStatL("ScopeAngleTransformISAngleFallback") then
		local isang = self:GetStatL("IronSightsAngle") * self:GetIronSightsProgress()

		ang:RotateAroundAxis(ang:Forward(), -isang.z)
		ang:RotateAroundAxis(ang:Right(), -isang.x)
		ang:RotateAroundAxis(ang:Up(), -isang.y)

		ang:RotateAroundAxis(ang:Forward(), isang.z)
	end

	-- WHY WHY WHY WHY WHY WHY WHY WHY
	for _, v in ipairs(self:GetStatL("ScopeAngleTransforms")) do
		if v[1] == "P" then
			ang:RotateAroundAxis(ang:Right(), v[2])
		elseif v[1] == "Y" then
			ang:RotateAroundAxis(ang:Up(), v[2])
		elseif v[1] == "R" then
			ang:RotateAroundAxis(ang:Forward(), v[2])
		end
	end

	cd.angles = ang
	cd.origin = self:GetOwner():GetShootPos()

	if not self.RTScopeOffset then
		self.RTScopeOffset = {0, 0}
	end

	if not self.RTScopeScale then
		self.RTScopeScale = {1, 1}
	end

	local rtow, rtoh = self.RTScopeOffset[1], self.RTScopeOffset[2]
	local rtw, rth = rttw * self.RTScopeScale[1], rtth * self.RTScopeScale[2]

	cd.x = 0
	cd.y = 0
	cd.w = rtw
	cd.h = rth
	cd.fov = self:GetStatL("RTScopeFOV")
	cd.drawviewmodel = false
	cd.drawhud = false
	render.Clear(0, 0, 0, 255, true, true)
	render.SetScissorRect(0 + rtow, 0 + rtoh, rtw + rtow, rth + rtoh, true)

	if self:GetIronSightsProgress() > 0.01 and self.Scoped_3D then
		render.RenderView(cd)
	end

	render.SetScissorRect(0, 0, rtw, rth, false)
	render.OverrideAlphaWriteEnable(false, true)
	cam.Start2D()
	draw.NoTexture()
	surface.SetTexture(self.myshadowmask)
	surface.SetDrawColor(color_white)

	if self:Do3DScopeOverlay() then
		surface.DrawTexturedRect(scrpos.x + rtow - rtw / 2, scrpos.y + rtoh - rth / 2, rtw * 2, rth * 2)
	end

	if self.ScopeReticule_CrossCol then
		crosscol.r = cv_cc_r:GetFloat()
		crosscol.g = cv_cc_g:GetFloat()
		crosscol.b = cv_cc_b:GetFloat()
		crosscol.a = cv_cc_a:GetFloat()
		surface.SetDrawColor(crosscol)
	end

	surface.SetMaterial(self.myreticule)
	local tmpborderw = rtw * (1 - self.ScopeReticule_Scale[1]) / 2
	local tmpborderh = rth * (1 - self.ScopeReticule_Scale[2]) / 2
	surface.DrawTexturedRect(rtow + tmpborderw, rtoh + tmpborderh, rtw - tmpborderw * 2, rth - tmpborderh * 2)
	surface.SetDrawColor(color_black)
	draw.NoTexture()

	if self:Do3DScopeOverlay() then
		surface.DrawRect(scrpos.x - 2048 + rtow, -1024 + rtoh, 2048, 2048)
		surface.DrawRect(scrpos.x + rtw + rtow, -1024 + rtoh, 2048, 2048)
		surface.DrawRect(-1024 + rtow, scrpos.y - 2048 + rtoh, 2048, 2048)
		surface.DrawRect(-1024 + rtow, scrpos.y + rth + rtoh, 2048, 2048)
	end

	surface.SetDrawColor(ColorAlpha(color_black, 255 - 255 * (math.Clamp(self:GetIronSightsProgress() - 0.75, 0, 0.25) * 4)))
	surface.DrawRect(-1024 + rtow, -1024 + rtoh, 2048, 2048)
	surface.SetMaterial(self.mydirt)
	surface.SetDrawColor(ColorAlpha(color_white, 128))
	surface.DrawTexturedRect(0, 0, rtw, rth)
	surface.SetDrawColor(ColorAlpha(color_white, 64))
	surface.DrawTexturedRectUV(rtow, rtoh, rtw, rth, 2, 0, 0, 2)
	cam.End2D()
end

local function l_Lerp(v, f, t)
	return f + (t - f) * v
end

function SWEP:AdjustMouseSensitivity(...)
	local retVal = BaseClass.AdjustMouseSensitivity(self, ...)

	retVal = retVal * l_Lerp(self:GetIronSightsProgress(), 1, self:Get3DSensitivity())

	return retVal
end

return SWEP
