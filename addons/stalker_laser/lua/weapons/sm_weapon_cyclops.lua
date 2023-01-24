-- "addons\\stalker_laser\\lua\\weapons\\sm_weapon_cyclops.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SWEP.PrintName = "Лазер"
SWEP.Author = "Orex"
SWEP.Instructions = "Чинить броню Альянса / Поджигать врагов Альянса."
SWEP.Category = "A - Rised - [Другое]"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.ViewModel = ""
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.Base = "weapon_base"
SWEP.isReloading = false
SWEP.laserCharge = 150
SWEP.LaserSight = 0
SWEP.Dissolve = 1
SWEP.IronsightTime = 0.17
SWEP.DisableMuzzle = 1
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"
SWEP.IronSightsPos = Vector(-7.52, -7, 1.629)
SWEP.IronSightsAng = Vector(-1, 0, 0)
SWEP.jumpcd = 0

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_Finger21"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 85.318, 0) },
	["ValveBiped.Bip01_R_Finger11"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 43.699, 0) },
	["ValveBiped.base"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, -30, -30), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(45, 0, -65) },
	["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 45, 0) },
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(15, 0, -3), angle = Angle(0, -45, 2) },
	["ValveBiped.Bip01_R_Finger12"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 54.104, 0) },
	["ValveBiped.Bip01_R_Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(10.404, 35.375, 0) },
	["ValveBiped.Bip01_R_Finger22"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 6.243, 0) },
	["ValveBiped.Bip01_R_Finger3"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(14.565, 41.618, 0) },
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(-30, 0, 0), angle = Angle(0, 180, 0) },
	["ValveBiped.Bip01_L_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -43.7, 0) }
}
SWEP.modAcceleration = 0.003

SWEP.HoldType = "normal"

function SWEP:Deploy()
	self:SetHoldType(self.HoldType)
	
end

function SWEP:SecondaryAttack()

end

function SWEP:PrimaryAttack()
	self:SetNWBool("isReloading", true)
	self.isReloading = true
end

function cLerp(num1, num2, num3) -- fraction, from, to
	return math.Clamp((num2 + (num1 * num3)), num2, num3)
end



function SWEP:Holster()

end

function SWEP:Reload()

end

function SWEP:LaserProcess()

	if (CLIENT) then
		self:DrawBeams()
		if self:GetNWBool("isReloading")==true  then
			if self.laserCharge > 0 then
				self:DrawBeams()
			end
		end
	end

	if (SERVER) then
		if self.isReloading == true then
			
			if self.laserCharge > 0 then
				self:FireBeam()
			end
			self.isReloading = false
			self:SetNWBool("isReloading", false)
		end

	end
end



function SWEP:DrawBeams()
	hook.Add("RenderScreenspaceEffects", "Fuckers", function()

		for k, v in pairs(ents.GetAll()) do

			if v:GetClass()=="sm_weapon_cyclops" then

				if v.Owner == LocalPlayer() then -- if this weapon's owner is localplayer then we see if we have to draw a beam for him
					if v:GetNWBool("isReloading")==true then

						local tr              = v.Owner:GetEyeTrace()

						local sizedist = math.Clamp(LocalPlayer():GetPos():Distance(tr.HitPos), 0, 2000)

						local alphadist = math.Clamp((155/500)*sizedist+math.random(-25,25), 50, 2055)
						local sizedratio = math.Clamp((400/500)*sizedist, 85, 5000) * 2



						local mdl_eyepos      = v.Owner:EyePos()

						local lefteye         = v.Owner:GetAttachment(v.Owner:LookupAttachment("eyes")).Pos - (v.Owner:GetRight() * 2)
						


						local perctg = self:GetNWFloat("laserCharge")/1000

						cam.Start3D( EyePos(), EyeAngles() ) -- Start the 3D function so we can draw onto the screen.

							render.SetMaterial(Material("sprites/bluelaser1"))

							
							render.DrawBeam(lefteye , tr.HitPos, 5*  perctg, 0, 12.5, Color(255, 10, 10, 255))

						
							render.DrawBeam(lefteye , tr.HitPos, 0.5*  perctg + ( math.random(100,1) / 100), 0, 12.5, Color(255, 25, 25, 255))


							render.SetMaterial( Material( "effects/lensflare/bar" ) )



							render.DrawSprite( tr.HitPos, sizedratio, sizedratio, Color(255,0,0,255*perctg) )
							render.DrawSprite( tr.HitPos, sizedratio/2, sizedratio/2, Color(255,155,155,255*perctg) )
							render.DrawSprite( tr.HitPos, sizedratio/4, sizedratio/4, Color(255,255,255,255*perctg) )



							-- draw this onto player's eyess

							--for i=0,5 do
								--render.DrawSprite( v.Owner:GetAttachment(v.Owner:LookupAttachment("eyes")).Pos, 100*perctg + math.random(1,50), 800*perctg, Color(255,0,0,255*perctg  + math.random(-255,50)) )
								--render.DrawSprite( v.Owner:GetAttachment(v.Owner:LookupAttachment("eyes")).Pos, 50*perctg  + math.random(1,50), 450*perctg, Color(255,155,155,255*perctg + math.random(-255,50)) )
								--render.DrawSprite( v.Owner:GetAttachment(v.Owner:LookupAttachment("eyes")).Pos, 25*perctg  + math.random(1,50), 125*perctg, Color(255,255,255,255*perctg + math.random(-255,50)) )
							--end


							--

						cam.End3D()

						local hitlight = DynamicLight( v:EntIndex() )
						if ( hitlight ) then
							hitlight.pos = tr.HitPos
							hitlight.r = 255
							hitlight.g = 25
							hitlight.b = 25
							hitlight.brightness = 4
							hitlight.Decay = 1000
							hitlight.Size = 256*  perctg
							hitlight.DieTime = CurTime() + 1
						end

						local eyelight = DynamicLight( LocalPlayer():EntIndex() )
						if ( eyelight ) then
							eyelight.pos = LocalPlayer():EyePos()
							eyelight.r = 255
							eyelight.g = 25
							eyelight.b = 25
							eyelight.brightness = 1
							eyelight.Decay = 1000
							eyelight.Size = 1*  perctg
							eyelight.DieTime = CurTime() + 1
						end


					end

				end
			end


		end

	end)
end



function SWEP:FireBeam()
	self.laserCharge = math.Clamp(self.laserCharge - 4, 0, 1000)

	if self.laserCharge > 0 then

		self:EmitSound("ambient/energy/weld2.wav")

		local perctg = self:GetNWFloat("laserCharge")/1000
		local tr              = self.Owner:GetEyeTrace()

		ParticleEffect( "red_laser_hit", tr.HitPos, Angle(0,0,0), nil )

		--util.Decal("FadingScorch",  tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
		sound.Play("ambient/energy/spark"..tostring(math.random(1,4))..".wav", tr.HitPos, 60, 100)
		if tr.Entity:IsValid() or tr.Entity:IsWorld() then
			if math.random(1,1)==1 then ParticleEffect( "gf2_flare_universal_welding_effect", tr.HitPos, Angle(0,0,0), nil ) end
			self:FlareDamage(tr.Entity)
		end
	end

end

function SWEP:FlareDamage(entity)
	if entity:IsPlayer() or entity:IsNPC() then
		if entity:IsPlayer() then
			if entity:isCP() then
				if entity:Armor() <= 74 then
					if math.random(1,15) == 3 then
						entity:SetArmor( entity:Armor() + 1 )
					end
				end
			else
				entity:Ignite(1.5, 0)
			end
		else
			entity:Ignite(1.5, 0)
		end
	end
end

function SWEP:LaserRegenerate()
	self.laserCharge = math.Clamp(self.laserCharge + math.random(1,5), 0, 1000)
	self:SetNWFloat("laserCharge", self.laserCharge)


end

function SWEP:Think()
	self:LaserProcess()
	if (SERVER) then
		self:LaserRegenerate()
	end

	if self.Owner:KeyPressed(IN_JUMP) && self.speedmod == true && ( self.jumpcd + 22 <= CurTime() ) then
	self.jumpcd = CurTime()
	end
end

function SWEP:SecondThink()

local ply = self.Owner
local FT = FrameTime()

local ang1 = ply:GetNWFloat("ang1")
local ang2 = ply:GetNWFloat("ang2")

if self.Owner:KeyDown(IN_ATTACK1) then
ply:SetNWFloat("ang1", Lerp(FT*2, ang1, 1) )
ply:SetNWFloat("ang2", Lerp(FT*2, ang1, 45) )
else
ply:SetNWFloat("ang1", Lerp(FT*2, ang1, 0) )
ply:SetNWFloat("ang2", Lerp(FT*2, ang2, 0) )
end

	if IsValid(ply) and SERVER then
		
		local bone = ply:LookupBone("ValveBiped.Bip01_R_UpperArm")
		if bone then 
			ply:ManipulateBoneAngles( bone, Angle(45*ang1,-135*ang1,-45*ang1) )
		end
		local bone = ply:LookupBone("ValveBiped.Bip01_R_Forearm")
		if bone then 
			ply:ManipulateBoneAngles( bone, Angle(0,0,-45*ang1) )
		end
		
	end

end

function SWEP:DoBones()
local FT = FrameTime()

local ply = self.Owner
local ang1 = ply:GetNWFloat("ang1")
local ang2 = ply:GetNWFloat("ang2")

	if IsValid(ply) then
		self.ViewModelBoneMods["ValveBiped.Bip01_R_Forearm"].angle = Angle(0, 45*ang1, 0)
		self.ViewModelBoneMods["ValveBiped.Bip01_R_UpperArm"].angle = Angle(0, -45*ang1, 2)
		self.ViewModelBoneMods["ValveBiped.Bip01_R_UpperArm"].pos = Vector(0 , -15 +(15*ang1), -3)
	end
//self.ViewModelBoneMods["ValveBiped.Bip01_R_UpperArm"].angle = Angle(swingang/4, 0, 0)
end

function SWEP:Holster()
local ply = self.Owner
	if IsValid(ply) then
		
	if SERVER then
		self.ViewModelBoneMods["ValveBiped.Bip01_R_Forearm"].angle = Angle(0, 0, 0)
		self.ViewModelBoneMods["ValveBiped.Bip01_R_UpperArm"].angle = Angle(0, 0, 0)
		
		local bone = ply:LookupBone("ValveBiped.Bip01_R_UpperArm")
		if bone then 
			ply:ManipulateBoneAngles( bone, Angle(0,0,0) )
		end
		local bone = ply:LookupBone("ValveBiped.Bip01_R_Forearm")
		if bone then 
			ply:ManipulateBoneAngles( bone, Angle(0,0,0) )
		end
	end
	
	end
return true
end