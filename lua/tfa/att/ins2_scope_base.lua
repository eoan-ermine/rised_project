-- "lua\\tfa\\att\\ins2_scope_base.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Scope Base"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {TFA.AttachmentColors["-"], "Why the hell would you equip this?"}
ATTACHMENT.Icon = "" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "BASE"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["rail_sights"] = {
			["active"] = true
		},
		["sights_folded"] = {
			["active"] = false
		}
	},
	["WElements"] = {
		["rail_sights"] = {
			["active"] = true
		},
		["sights_folded"] = {
			["active"] = false
		}
	},
	["IronSightsPos"] = function(wep, val) return wep:GetStat("IronSightsPos_" .. wep:GetStat("INS2_SightSuffix")) or val end,
	["IronSightsAng"] = function(wep, val) return wep:GetStat("IronSightsAng_" .. wep:GetStat("INS2_SightSuffix")) or val end,
	["IronSightsSensitivity"] = function(wep, val)
		local res = val * wep:Get3DSensitivity()

		return res, false, true
	end,
	["Secondary"] = {
		["IronFOV"] = function(wep, val) return wep:GetStat("Secondary.IronFOV_" .. wep:GetStat("INS2_SightSuffix")) or val end
	},
	["IronSightTime"] = function(wep, val) return val * 1.40 end,
	["IronSightMoveSpeed"] = function(stat) return stat * 0.9 end,
	["RTScopeFOV"] = function(wep, val) return (wep:GetStat("RTScopeFOV_" .. wep:GetStat("INS2_SightSuffix")) or wep:GetStat("Secondary.IronFOV")) / wep:GetStat("Secondary.ScopeZoom") / 2 end,
	["RTOpaque"] = -1,
	["RTMaterialOverride"] = -1,
	["RTDrawEnabled"] = true
}

local shadowborder = 256
local cd = {}
local myshad
local debugcv = GetConVar("cl_tfa_debug_rt")
local shadowcv = GetConVar("cl_tfa_3dscope_overlay")
local tmpts = {}

function ATTACHMENT:GetScopeOrigin(myself)
	local vm = myself.OwnerViewModel
	if not IsValid(vm) then return end
	vm:SetupBones()
	local vel = myself:GetStat("VElements")
	if not vel then return end
	local siVel = myself:GetStat("INS2_SightVElement")
	if not siVel then return end
	local mdl = myself:GetStat("VElements." .. siVel .. ".curmodel")
	if not IsValid(mdl) then return end
	mdl:SetupBones()
	local att = mdl:GetAttachment(mdl:LookupAttachment("scope_origin"))
	if not att then return end
	if not att.Ang then return end
	att.Ang:RotateAroundAxis(att.Ang:Forward(), -90)
	local traceres = util.QuickTrace(att.Pos, att.Ang:Forward() * 5, {vm, mdl, myself, myself:GetOwner()})

	if traceres and traceres.Hit then
		local offset = 5 - att.Pos:Distance(traceres.HitPos)
		att.TracePos = att.Pos - att.Ang:Forward() * offset
		att.znear = 0.1
	end

	return att
end

local shadowAngCache, lastFN
local ShadowScreenScale = 1

hook.Add("PostDrawViewModel", "TFA_INS2_SCOPEBASE_CACHE_EP", function(vm, ply, wep)
	if not IsValid(vm) then return end
	if lastFN == FrameNumber() then return end
	if not wep.GetStat then return end
	local siVel = wep:GetStat("INS2_SightVElement")
	if not siVel then return end
	local mdl = wep:GetStat("VElements." .. siVel .. ".curmodel")
	if not IsValid(mdl) then return end
	local attID = mdl:LookupAttachment("scope_origin")
	if attID == 0 then return end
	if TFA.DrawingRenderTarget then return end
	local att = mdl:GetAttachment(attID)
	if not att or not att.Pos then return end
	local attPos = att.Pos
	local _, ang = WorldToLocal(vector_origin, (attPos - EyePos()):Angle(), vector_origin, EyeAngles())
	shadowAngCache = ang * ShadowScreenScale
	lastFN = FrameNumber()
end)

function ATTACHMENT:GetScopeTarget(myself)
	local suffix = myself:GetStat("INS2_SightSuffix")
	if not suffix then return end
	local vm = myself.OwnerViewModel
	if not IsValid(vm) then return end
	vm:SetupBones()
	local vel = myself:GetStat("VElements")
	if not vel then return end
	local siVel = myself:GetStat("INS2_SightVElement")
	if not siVel then return end
	local mdl = myself:GetStat("VElements." .. siVel .. ".curmodel")
	if not IsValid(mdl) then return end
	mdl:SetupBones()
	local att = mdl:GetAttachment(mdl:LookupAttachment("scope_align"))
	if not att then return end
	if not att.Pos then return end
	local origin = mdl:GetAttachment(mdl:LookupAttachment("scope_origin"))
	if not origin then return end
	if not origin.Pos then return end
	local ply = myself:GetOwner()
	if not IsValid(ply) then return end
	local fov = math.sqrt(myself:GetStat("RTScopeFOV") or 10)
	local ang = mdl:WorldToLocalAngles((att.Pos - origin.Pos):Angle())
	local ang2 = shadowAngCache or mdl:WorldToLocalAngles((origin.Pos - ply:EyePos()):Angle())
	local t = TFA.INS2.SightShadowOffsets[mdl:GetModel()]

	if t then
		ang2.p = ang2.p + t[1] * ShadowScreenScale
		ang2.y = ang2.y + t[2] * ShadowScreenScale
	end

	tmpts.x = (-ang.y + ang2.y) / fov + 0.5
	tmpts.y = (ang.p + -ang2.p) / fov + 0.5
	local trans = myself:GetStat("RTOverlayTransforms_" .. suffix)

	if trans then
		tmpts.x = tmpts.x + trans[1]
		tmpts.y = tmpts.y - trans[2]
	end

	return tmpts
end

function ATTACHMENT:GetScopeTargetLegacy(myself)
	local suffix = myself:GetStat("INS2_SightSuffix")
	if not suffix then return end
	local attn = myself:GetStat("RTAttachment_" .. suffix)
	if not attn then return end
	local vm = myself.OwnerViewModel
	if not IsValid(vm) then return end
	local ply = myself:GetOwner()
	if not IsValid(ply) then return end
	local att = vm:GetAttachment(math.max(isnumber(attn) and attn or vm:LookupAttachment(attn), 1))
	if not att or not att.Pos then return end
	local fov = math.sqrt(myself:GetStat("RTScopeFOV") or 10)
	local ang = vm:WorldToLocalAngles((att.Pos - ply:EyePos()):Angle())
	local trans = myself:GetStat("ScopeOverlayTransforms_" .. suffix)
	tmpts.x = ang.y / fov / 15 + 0.5
	tmpts.y = -ang.p / fov / 15 + 0.5

	if trans then
		tmpts.x = tmpts.x + trans[1]
		tmpts.y = tmpts.y - trans[2]
	end

	return tmpts
end

function ATTACHMENT:DistanceFactor(myself)
	local distfac
	local suffix = myself:GetStat("INS2_SightSuffix")

	if suffix and myself:GetStat("RTAttachment_" .. suffix) and myself:GetStat("ScopeDistanceMin_" .. suffix) and myself:GetStat("ScopeDistanceRange_" .. suffix) then
		local targent = myself.OwnerViewModel

		if IsValid(targent) then
			local att = targent:GetAttachment(myself:GetStat("RTAttachment_" .. suffix))

			if att and att.Pos then
				local dist = att.Pos:Distance(myself:GetOwner():GetShootPos())
				distfac = 1 - 0.5 * math.Clamp(dist - myself:GetStat("ScopeDistanceMin_" .. suffix), 0, myself:GetStat("ScopeDistanceRange_" .. suffix)) / myself:GetStat("ScopeDistanceRange_" .. suffix)
			end
		end
	else
		distfac = (myself.CLIronSightsProgress or 1) * 0.4 + 0.5
	end

	return distfac
end

local tsFinal = {}

if TFA_BASE_VERSION >= 4.5 then -- updates never
	function ATTACHMENT:RTCode(myself, rt, scrw, scrh)
		if not IsValid(myself:GetOwner()) or not IsValid(myself.OwnerViewModel) then return end
		local rttw, rtth
		rttw = ScrW()
		rtth = ScrH()

		if not myshad then
			myshad = Material("vgui/scope_shadowmask")
		end

		local ang = myself.OwnerViewModel:GetAngles()
		cd.angles = ang
		cd.origin = myself:GetOwner():GetShootPos()
		local attpos = self:GetScopeOrigin(myself)

		if attpos then
			cd.angles = attpos.Ang
			cd.origin = attpos.TracePos or attpos.Pos
			cd.znear = attpos.znear
		end

		local suffix = myself:GetStat("INS2_SightSuffix")

		if suffix then
			local angtrans = myself:GetStat("ScopeAngleTransforms_" .. suffix)

			if angtrans then
				cd.angles:RotateAroundAxis(cd.angles:Right(), angtrans.p)
				cd.angles:RotateAroundAxis(cd.angles:Up(), angtrans.y)
				cd.angles:RotateAroundAxis(cd.angles:Forward(), angtrans.r)
			end
		end

		local sipos = self:GetScopeTarget(myself)

		if not sipos then
			sipos = self:GetScopeTargetLegacy(myself)
		end

		cd.x = 0
		cd.y = 0
		cd.w = rttw
		cd.h = rtth
		cd.fov = myself:GetStat("RTScopeFOV")
		cd.drawviewmodel = false
		cd.drawhud = false
		render.Clear(0, 0, 0, 255, true, true)

		if myself.CLIronSightsProgress > 0.005 then
			render.RenderView(cd)

			if attpos and not (suffix and myself:GetStat("RTRedrawViewModel_" .. suffix) == false) then
				cam.Start3D(cd.origin, cd.angles)
				cam.IgnoreZ(true)
				myself.OwnerViewModel:SetupBones()
				myself.OwnerViewModel:DrawModel()
				cam.IgnoreZ(false)
				cam.End3D()
			end
		end

		cam.Start2D()

		if sipos and shadowcv and shadowcv:GetBool() then
			local distfac = self:DistanceFactor(myself)

			if debugcv and debugcv:GetBool() then
				distfac = 1
			end

			tsFinal.x = sipos.x
			tsFinal.y = sipos.y
			tsFinal.x = tsFinal.x * rttw
			tsFinal.y = tsFinal.y * rttw
			local texW = rttw * distfac
			local texH = rtth * distfac
			local texX = tsFinal.x - texW / 2
			local texY = tsFinal.y - texH / 2
			surface.SetMaterial(myshad)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(texX, texY, texW, texH)
			surface.SetDrawColor(color_black)
			surface.DrawRect(0, 0, texX + 1, rtth)
			surface.DrawRect(texX + texW - 1, 0, rttw - texX - texW + 1, rtth)
			surface.DrawRect(0, 0, rttw, texY + 1)
			surface.DrawRect(0, texY + texH - 1, rttw, rtth - texY - texH + 1)
		else
			surface.SetMaterial(myshad)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(-shadowborder, -shadowborder, shadowborder * 2 + rttw, shadowborder * 2 + rtth)
		end

		surface.SetDrawColor(ColorAlpha(color_black, 255 * (1 - myself.CLIronSightsProgress)))
		surface.DrawRect(0, 0, scrw, scrh)
		cam.End2D()
	end
else
	function ATTACHMENT:Attach(wep)
		if not IsValid(wep) then return end
		wep.RTCodeOld = wep.RTCodeOld or wep.RTCode

		wep.RTCode = function(myself, rt, scrw, scrh)
			if not IsValid(myself:GetOwner()) or not IsValid(myself.OwnerViewModel) then return end
			local rttw, rtth
			rttw = ScrW()
			rtth = ScrH()

			if not myshad then
				myshad = Material("vgui/scope_shadowmask")
			end

			local ang = myself.OwnerViewModel:GetAngles()
			cd.angles = ang
			cd.origin = myself:GetOwner():GetShootPos()
			local attpos = self:GetScopeOrigin(myself)

			if attpos then
				cd.angles = attpos.Ang
				cd.origin = attpos.TracePos or attpos.Pos
				cd.znear = attpos.znear
			end

			local suffix = myself:GetStat("INS2_SightSuffix")

			if suffix then
				local angtrans = myself:GetStat("ScopeAngleTransforms_" .. suffix)

				if angtrans then
					cd.angles:RotateAroundAxis(cd.angles:Right(), angtrans.p)
					cd.angles:RotateAroundAxis(cd.angles:Up(), angtrans.y)
					cd.angles:RotateAroundAxis(cd.angles:Forward(), angtrans.r)
				end
			end

			local sipos = self:GetScopeTarget(myself)

			if not sipos then
				sipos = self:GetScopeTargetLegacy(myself)
			end

			cd.x = 0
			cd.y = 0
			cd.w = rttw
			cd.h = rtth
			cd.fov = myself:GetStat("RTScopeFOV")
			cd.drawviewmodel = false
			cd.drawhud = false
			render.Clear(0, 0, 0, 255, true, true)

			if myself.CLIronSightsProgress > 0.005 then
				render.RenderView(cd)

				if attpos and not (suffix and myself:GetStat("RTRedrawViewModel_" .. suffix) == false) then
					cam.Start3D(cd.origin, cd.angles)
					cam.IgnoreZ(true)
					myself.OwnerViewModel:SetupBones()
					myself.OwnerViewModel:DrawModel()
					cam.IgnoreZ(false)
					cam.End3D()
				end
			end

			cam.Start2D()

			if sipos and shadowcv and shadowcv:GetBool() then
				local distfac = self:DistanceFactor(myself)

				if debugcv and debugcv:GetBool() then
					distfac = 1
				end

				tsFinal.x = sipos.x
				tsFinal.y = sipos.y
				tsFinal.x = tsFinal.x * rttw
				tsFinal.y = tsFinal.y * rttw
				local texW = rttw * distfac
				local texH = rtth * distfac
				local texX = tsFinal.x - texW / 2
				local texY = tsFinal.y - texH / 2
				surface.SetMaterial(myshad)
				surface.SetDrawColor(color_white)
				surface.DrawTexturedRect(texX, texY, texW, texH)
				surface.SetDrawColor(color_black)
				surface.DrawRect(0, 0, texX + 1, rtth)
				surface.DrawRect(texX + texW - 1, 0, rttw - texX - texW + 1, rtth)
				surface.DrawRect(0, 0, rttw, texY + 1)
				surface.DrawRect(0, texY + texH - 1, rttw, rtth - texY - texH + 1)
			else
				surface.SetMaterial(myshad)
				surface.SetDrawColor(color_white)
				surface.DrawTexturedRect(-shadowborder, -shadowborder, shadowborder * 2 + rttw, shadowborder * 2 + rtth)
			end

			surface.SetDrawColor(ColorAlpha(color_black, 255 * (1 - myself.CLIronSightsProgress)))
			surface.DrawRect(0, 0, scrw, scrh)
			cam.End2D()
		end
	end

	function ATTACHMENT:Detach(wep)
		if not IsValid(wep) then return end
		wep.RTCode = wep.RTCodeOld
		wep.RTCodeOld = nil
	end
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end