-- "addons\\rised_weapons\\lua\\weapons\\swb_base\\cl_calcview.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

-----------------------------------------------------
local FT, CT, cos1, cos2, ws, vel, att, ang
local Ang0, curang, curviewbob = Angle(0, 0, 0), Angle(0, 0, 0), Angle(0, 0, 0)
local reg = debug.getregistry()
local GetVelocity = reg.Entity.GetVelocity
local Length = reg.Vector.Length
local Right = reg.Angle.Right
local Up = reg.Angle.Up
local Forward = reg.Angle.Forward
local RotateAroundAxis = reg.Angle.RotateAroundAxis

SWEP.LerpBackSpeed = 10

function SWEP:CalcView(ply, pos, ang, fov)
	FT, CT = FrameTime(), CurTime()

	if self.ReloadViewBobEnabled then
		if self.IsReloading and self.Cycle <= 0.9 then
			att = self.Owner:GetAttachment(1)
			
			if att then
				ang = ang * 1
				
				self.LerpBackSpeed = 1
				curang = LerpAngle(FT * 10, curang, (ang - att.Ang) * 0.1)
			else
				self.LerpBackSpeed = math.Approach(self.LerpBackSpeed, 10, FT * 50)
				curang = LerpAngle(FT * self.LerpBackSpeed, curang, Ang0)
			end
		else
			self.LerpBackSpeed = math.Approach(self.LerpBackSpeed, 10, FT * 50)
			curang = LerpAngle(FT * self.LerpBackSpeed, curang, Ang0)
		end
		
		RotateAroundAxis(ang, Right(ang), curang.p * self.RVBPitchMod)
		RotateAroundAxis(ang, Up(ang), curang.r * self.RVBYawMod)
		RotateAroundAxis(ang, Forward(ang), (curang.p + curang.r) * 0.15 * self.RVBRollMod)
	end
	
	if self.dt.State == SWB_AIMING then
		if self.DelayedZoom then
			if CT > self.AimTime then
				if self.SnapZoom then
					self.CurFOVMod = self.ZoomAmount
				else
					self.CurFOVMod = Lerp(FT * 10, self.CurFOVMod, self.ZoomAmount)
				end
			else
				self.CurFOVMod = Lerp(FT * 10, self.CurFOVMod, 0)
			end
		else
			if self.SnapZoom then
				self.CurFOVMod = self.ZoomAmount
			else
				self.CurFOVMod = Lerp(FT * 10, self.CurFOVMod, self.ZoomAmount)
			end
		end
	else
		self.CurFOVMod = Lerp(FT * 10, self.CurFOVMod, 0)
	end
	
	fov = math.Clamp(fov - self.CurFOVMod, 0, 100)
	
	if self.Owner then
		if self.ViewbobEnabled then
			ws = self.Owner:GetWalkSpeed()
			vel = Length(GetVelocity(self.Owner))
			
			if self.Owner:OnGround() and vel > ws * 0.3 then
				if vel < ws * 1.2 then
					cos1 = math.cos(CT * 15)
					cos2 = math.cos(CT * 12)
					curviewbob.p = cos1 * 0.15
					curviewbob.y = cos2 * 0.1
				else
					cos1 = math.cos(CT * 20)
					cos2 = math.cos(CT * 15)
					curviewbob.p = cos1 * 0.25
					curviewbob.y = cos2 * 0.15
				end
			else
				curviewbob = LerpAngle(FT * 10, curviewbob, Ang0)
			end
		end
	end

	-- if self.dt.State != SWB_AIMING then
	-- 	fov = LocalPlayer():GetFOV()
	-- end
	
	return pos, ang + curviewbob * self.ViewbobIntensity, fov
end

function SWEP.CreateMove(move)
	ply = LocalPlayer()
	wep = ply:GetActiveWeapon()
	
	if IsValid(wep) and wep.SWBWeapon then
		if wep.dt and wep.dt.State == SWB_AIMING and wep.AimBreathingEnabled then
			CT = CurTime()
			ang = move:GetViewAngles()
			ang.p = ang.p - math.cos(CT * 1.25) * 0.003
			
			move:SetViewAngles(ang)
		end
	end
end

hook.Add("CreateMove", "SWEP.CreateMove (SWB)", SWEP.CreateMove)

function SWEP:AdjustMouseSensitivity()
	if self.dt.State == SWB_RUNNING then
		if self.RunMouseSensMod then
			return self.RunMouseSensMod
		end
	end
	
	if self.dt.State == SWB_AIMING then
		if self.OverrideAimMouseSens then
			return self.OverrideAimMouseSens
		end
		
		return 1 - math.Clamp(self.ZoomAmount / 100, 0.1, 1)
	end
	
	return 1
end