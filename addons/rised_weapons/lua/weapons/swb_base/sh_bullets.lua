-- "addons\\rised_weapons\\lua\\weapons\\swb_base\\sh_bullets.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

-----------------------------------------------------
local Dir, Dir2, dot, sp, ent, trace, seed, hm
local trace_normal = bit.bor(CONTENTS_SOLID, CONTENTS_OPAQUE, CONTENTS_MOVEABLE, CONTENTS_DEBRIS, CONTENTS_MONSTER, CONTENTS_HITBOX, 402653442, CONTENTS_WATER)
local trace_walls = bit.bor(CONTENTS_TESTFOGVOLUME, CONTENTS_EMPTY, CONTENTS_MONSTER, CONTENTS_HITBOX)
local NoPenetration = {[MAT_SLOSH] = true}
local NoRicochet = {[MAT_FLESH] = true, [MAT_ANTLION] = true, [MAT_BLOODYFLESH] = true, [MAT_DIRT] = true, [MAT_SAND] = true, [MAT_GLASS] = true, [MAT_ALIENFLESH] = true}
local PenMod = {[MAT_SAND] = 0.5, [MAT_DIRT] = 0.8, [MAT_METAL] = 1.1, [MAT_TILE] = 0.9, [MAT_WOOD] = 1.2}
local bul, tr = {}, {}
local SP = game.SinglePlayer()

local reg = debug.getregistry()
local GetShootPos = reg.Player.GetShootPos
local GetCurrentCommand = reg.Player.GetCurrentCommand
local CommandNumber = reg.CUserCmd.CommandNumber

SWEP.Tracer = 'Tracer'

function SWEP:FireBullet(damage, cone, bullets)
	sp = GetShootPos(self.Owner)
	math.randomseed(CommandNumber(GetCurrentCommand(self.Owner)))
	
	if self.Owner:Crouching() then
		cone = cone * 0.85
	end
	
	Dir = (self.Owner:EyeAngles() + self.Owner:GetPunchAngle() + Angle(math.Rand(-cone, cone), math.Rand(-cone, cone), 0) * 25):Forward()

	for i = 1, bullets do
		Dir2 = Dir
		
		if self.ClumpSpread and self.ClumpSpread > 0 then
			Dir2 = Dir + Vector(math.Rand(-1, 1), math.Rand(-1, 1), math.Rand(-1, 1)) * self.ClumpSpread
		end
		
		bul.Num = 1
		bul.Src = sp
		bul.Dir = Dir2
		bul.Spread 	= Vector(0, 0, 0)
		bul.Tracer	= 1
		bul.Force	= 0
		bul.TracerName = self.Tracer
		bul.Damage = math.Round(damage)
		
		self.Owner:FireBullets(bul)
		
		tr.start = sp
		tr.endpos = tr.start + Dir2 * self.PenetrativeRange
		tr.filter = self.Owner
		tr.mask = trace_normal
		
		trace = util.TraceLine(tr)
			
		if trace.Hit and not trace.HitSky then
			--[[
			if not NoPenetration[trace.MatType] then
				dot = -Dir2:DotProduct(trace.HitNormal)
				ent = trace.Entity
			
				if dot > 0.26 and self.CanPenetrate and not ent:IsNPC() and not ent:IsPlayer() then
					tr.start = trace.HitPos
					tr.endpos = tr.start + Dir2 * self.PenStr * (PenMod[trace.MatType] and PenMod[trace.MatType] or 1) * self.PenMod
					tr.filter = self.Owner
					tr.mask = trace_walls
					
					trace = util.TraceLine(tr)
					
					tr.start = trace.HitPos
					tr.endpos = tr.start + Dir2 * 0.1
					tr.filter = self.Owner
					tr.mask = trace_normal
					
					trace = util.TraceLine(tr) -- run ANOTHER trace to check whether we've penetrated a surface or not
					
					if not trace.Hit then
						bul.Num = 1
						bul.Src = trace.HitPos
						bul.Dir = Dir2
						bul.Spread 	= Vec0
						bul.Tracer	= 4
						bul.Force	= damage * 0.15
						bul.Damage = bul.Damage * 0.5
						
						self.Owner:FireBullets(bul)
						
						bul.Num = 1
						bul.Src = trace.HitPos
						bul.Dir = -Dir2
						bul.Spread 	= Vec0
						bul.Tracer	= 4
						bul.Force	= damage * 0.15
						bul.Damage = bul.Damage * 0.5
						
						self.Owner:FireBullets(bul)
					end
				else
					if self.CanRicochet then
						if not NoRicochet[trace.MatType] and self.PenetrativeRange * trace.Fraction < self.PenetrativeRange then
							Dir2 = Dir2 + (trace.HitNormal * dot) * 3
							Dir2 = Dir2 + VectorRand() * 0.06
							bul.Num = 1
							bul.Src = trace.HitPos
							bul.Dir = Dir2
							bul.Spread 	= Vec0
							bul.Tracer	= 0
							bul.Force	= damage * 0.225
							bul.Damage = bul.Damage * 0.75
							
							self.Owner:FireBullets(bul)
						end
					end
				end
			end]]
		end
	end
		
	tr.mask = trace_normal
end