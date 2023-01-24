-- "lua\\autorun\\altview.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
-- made by darsu <3
local fcvar_rep_archive = bit.bor(FCVAR_REPLICATED, FCVAR_ARCHIVE)

local enabled = CreateConVar("altlook", 1, fcvar_rep_archive)
local limV = CreateConVar("altlook_limit_vertical", 65, fcvar_rep_archive)
local limH = CreateConVar("altlook_limit_horizontal", 140, fcvar_rep_archive)
local smooth = CreateConVar("altlook_smoothness_mult", 1, fcvar_rep_archive)
local blockads = CreateConVar("altlook_block_ads", 1, fcvar_rep_archive)
local blockshoot = CreateConVar("altlook_block_fire", 1, fcvar_rep_archive)

if SERVER then return end

local freelooking = false

concommand.Add("+freelook", function(ply, cmd, args) freelooking = true end)
concommand.Add("-freelook", function(ply, cmd, args) freelooking = false end)

local LookX, LookY = 0, 0
local InitialAng, CoolAng = Angle(), Angle()
local ZeroAngle = Angle()

local function isinsights(ply) -- arccw, arc9, tfa, mgbase, fas2 works
    local weapon = ply:GetActiveWeapon()
    return blockads:GetBool() and (ply:KeyDown(IN_ATTACK2) or (weapon.GetInSights and weapon:GetInSights()) or (weapon.ArcCW and weapon:GetState() == ArcCW.STATE_SIGHTS) or (weapon.GetIronSights and weapon:GetIronSights()))
end

local function holdingbind(ply)
    if !input.LookupBinding("freelook") then 
        return ply:KeyDown(IN_WALK)
    else
        return freelooking
    end
end

-- Im dumbass if someone could make it work better (not return anything to not mess up other calcview hooks) please send me code or make a disscussion on steam page

hook.Add("CalcView", "AltlookView", function(ply, origin, angles, fov)
    if !enabled:GetBool() then return end

    local smoothness = math.Clamp(smooth:GetFloat(), 0.1, 2)

    CoolAng = LerpAngle(0.15 * smoothness, CoolAng, Angle(LookY, -LookX, 0))

    if not holdingbind(ply) and CoolAng.p < 0.05 and CoolAng.p > -0.05 or isinsights(ply) and CoolAng.p < 0.05 and CoolAng.p > -0.05 or not system.HasFocus() or ply:ShouldDrawLocalPlayer() then 
        InitialAng = angles + CoolAng
        LookX, LookY = 0, 0 

        CoolAng = ZeroAngle

        return 
    end

    angles.p = angles.p + CoolAng.p
    angles.y = angles.y + CoolAng.y
    -- return {angles = ang + CoolAng}
end)

-- local VMCalcCalled

hook.Add("CalcViewModelView", "AltlookVM", function(wep, vm, oPos, oAng, pos, ang)
    if !enabled:GetBool() then return end

	-- if VMCalcCalled then return end
	-- VMCalcCalled = true
	-- local tPos, tAng = hook.Run("CalcViewModelView", wep, vm, oPos, oAng, pos, ang, ...)
	-- VMCalcCalled = nil
	-- pos = tPos or pos
	-- ang = tAng+CoolAng/2.5 or ang

    local MWBased = wep.m_AimModeDeltaVelocity and -1.5 or 1

    ang.p = ang.p + CoolAng.p/2.5 * MWBased
    ang.y = ang.y + CoolAng.y/2.5 * MWBased
	-- return pos, ang
end)

hook.Add("InputMouseApply", "AltlookMouse", function(cmd, x, y, ang)
    if !enabled:GetBool() then return end

    local lp = LocalPlayer()
    if not holdingbind(lp) or isinsights(lp) or lp:ShouldDrawLocalPlayer() then LookX, LookY = 0, 0 return end
    
    InitialAng.z = 0 -- roll fix
    cmd:SetViewAngles(InitialAng)

    LookX = math.Clamp(LookX + x * 0.02, -limH:GetInt(), limH:GetInt())
    LookY = math.Clamp(LookY + y * 0.02, -limV:GetInt(), limV:GetInt())
    
    return true
end)

hook.Add("StartCommand", "AltlookBlockShoot", function(ply, cmd)
    if !ply:IsPlayer() or !ply:Alive() then return end
    if !blockshoot:GetBool() then return end
    
    if not holdingbind(ply) or isinsights(ply) or ply:ShouldDrawLocalPlayer() then return end
    cmd:RemoveKey(IN_ATTACK)
end)