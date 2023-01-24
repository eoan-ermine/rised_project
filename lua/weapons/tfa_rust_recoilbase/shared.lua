-- "lua\\weapons\\tfa_rust_recoilbase\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not TFA then return end

SWEP.Base = "tfa_gun_base"

SWEP.Author = "Darky"
SWEP.Contact = "Darky#7990"
SWEP.Spawnable = false

SWEP.MuzzleAttachment = "0"
SWEP.ShellAttachment = "1"

SWEP.MuzzleFlashEnabled = true

SWEP.UseHands = true
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true

SWEP.RTOpaque	= true
SWEP.LaserDistance = 4000
SWEP.LaserDistanceVisual = 4000

SWEP.CrouchAccuracyMultiplier = 1

SWEP.IronSightTime = 0.3

SWEP.Primary.TakeAmmo = 1
SWEP.Primary.Recoil = 1
SWEP.Primary.Force = 1
SWEP.DisableChambering = true 

SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"


SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_HYBRID
SWEP.SprintBobMult = 0.9

SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH
SWEP.Idle_Blend = 0.25
SWEP.Idle_Smooth = 0.05

SWEP.RunSightsPos = Vector(1, 0, 1)
SWEP.RunSightsAng = Vector(-18, 0, 0)


--                    --                      --
--          Recoil base itself below          --
--                    --                      --


SWEP.Rec = 0
SWEP.LastRec = UnPredictedCurTime()+0.1

SWEP.RecoilIS = 1 -- *number in recoil function while in ironsights
SWEP.RecoilLerp = 0.05
SWEP.RecoilReturnTime = 0.05
SWEP.RecoilShootReturnTime = 0.2

DEFINE_BASECLASS(SWEP.Base)

SWEP.RecoilAng = Angle(0, 0, 0)

function SWEP:Recoil(recoil, ifp)
	local owner = self:GetOwner()

	if self:GetOwner():IsPlayer() then
		if CLIENT and IsFirstTimePredicted() or CLIENT and game.SinglePlayer() then
			self.Rec = self.Rec + 1
			self.LastRec = UnPredictedCurTime() + self.RecoilShootReturnTime
			
			local rectable = self.RecoilTable

			local IS = self:GetIronSights() and self.RecoilIS or 1

			self.RecoilAng = rectable[self.Rec%#rectable+1]*IS*0.5*self:GetStat("Primary.Recoil") -- cool?
		end
	end

	return
end

function SWEP:RecoilUpdate()
    local ply = self:GetOwner()

    if ply:IsPlayer() then
        if not self.RecoilAng:IsZero() then 
            local eyeang = ply:EyeAngles()
            local withRecoil = eyeang + (self.RecoilAng * 100 * FrameTime())
            local withRecoilLimited = Angle(math.max(withRecoil.p, -89), withRecoil.y, 0) -- math max to prevent spinning while looking stright up
                
            eyeang = LerpAngle(self.RecoilLerp, eyeang, withRecoilLimited)
            eyeang.r = 0

            ply:SetEyeAngles(eyeang)
        end

        if UnPredictedCurTime() > self.LastRec and self.Rec > 0 then
            self.RecoilAng = Angle(0, 0, 0)
            self.Rec = self.Rec - 1
            self.LastRec = UnPredictedCurTime() + self.RecoilReturnTime
        end
    end
end

function SWEP:DrawHUD()
    local pl = self:GetOwner()
    self:RecoilUpdate()
	
    if pl:IsPlayer() then
        if UnPredictedCurTime() > self.LastRec and self.Rec > 0 then -- Recoil fucntions
            self.Rec = self.Rec - 1
            self.LastRec = UnPredictedCurTime() + self.RecoilReturnTime
        end
    end
	BaseClass.DrawHUD(self)
end