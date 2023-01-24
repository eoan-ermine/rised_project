-- "addons\\bricks-crafting\\lua\\weapons\\bcs_axe.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if CLIENT then
	SWEP.PrintName = BRICKSCRAFTING.L("lumberAxe") -- For english translate this to Pickaxe
	SWEP.Slot = 1
	SWEP.SlotPos = 5
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = true
end

-- Variables that are used on both client and server

SWEP.Author = "Brickwall"
SWEP.Instructions = BRICKSCRAFTING.L("lumberAxeInstructions")
SWEP.Contact = ""
SWEP.Purpose = ""

SWEP.ViewModelFOV = 85
SWEP.ViewModelFlip = false
SWEP.ViewModel = Model("models/sterling/c_crafting_axe.mdl")
SWEP.WorldModel = Model("models/sterling/w_crafting_axe.mdl")
SWEP.HoldType = "melee";

SWEP.UseHands = true

SWEP.Spawnable = true	
SWEP.Category = "Bricks Crafting"

SWEP.Sound = Sound("physics/wood/wood_box_impact_hard3.wav")

SWEP.Primary.DefaultClip = 0;
SWEP.Primary.Automatic = true;
SWEP.Primary.ClipSize = -1;
SWEP.Primary.Damage = 1;
SWEP.Primary.Delay = 1;
SWEP.Primary.Ammo = "";

--[[-------------------------------------------------------
Name: SWEP:Initialize()
Desc: Called when the weapon is first loaded
---------------------------------------------------------]]
function SWEP:Initialize()
	self:SendWeaponAnim(ACT_VM_HOLSTER);

	self:UpdateSWEPColour()
end

function SWEP:UpdateSWEPColour()
	if( not IsValid( self.Owner ) or self.Owner:GetActiveWeapon() != self ) then return end
	
	local MiscTable = self.Owner:GetBCS_MiscTable()
	if( BRICKSCRAFTING.CONFIG.Tools.LumberAxe[(MiscTable.LumberAxeLevel or 0)] and BRICKSCRAFTING.CONFIG.Tools.LumberAxe[(MiscTable.LumberAxeLevel or 0)].Color ) then
		self:SetColor( BRICKSCRAFTING.CONFIG.Tools.LumberAxe[(MiscTable.LumberAxeLevel or 0)].Color )
	end
end

function SWEP:Deploy()
	self:UpdateSWEPColour()

    return true
end

local mat = Material( "sterling/crafting_axe_main" )
function SWEP:PreDrawViewModel( viewmodel, weapon )
	local MiscTable = self.Owner:GetBCS_MiscTable()
	if( weapon == self and BRICKSCRAFTING.CONFIG.Tools.LumberAxe[(MiscTable.LumberAxeLevel or 0)] and BRICKSCRAFTING.CONFIG.Tools.LumberAxe[(MiscTable.LumberAxeLevel or 0)].Color ) then
		if( CLIENT ) then
			local inicolor = BRICKSCRAFTING.CONFIG.Tools.LumberAxe[(MiscTable.LumberAxeLevel or 0)].Color
			local color = Color( inicolor.r/255, inicolor.g/255, inicolor.b/255 )
			mat:SetVector( "$color2", Vector( color.r, color.g, color.b ) )
		end
	else
		mat:SetVector( "$color2", Vector( 1, 1, 1 ) )
	end
end

function SWEP:OnRemove()
	mat:SetVector( "$color2", Vector( 1, 1, 1 ) )
end

function SWEP:Holster()
	mat:SetVector( "$color2", Vector( 1, 1, 1 ) )

	return true
end

function SWEP:DoHitEffects()
	local trace = self.Owner:GetEyeTraceNoCursor();
	
	if (((trace.Hit or trace.HitWorld) and self.Owner:GetShootPos():Distance(trace.HitPos) <= 64)) then
		self:SendWeaponAnim(ACT_VM_HITCENTER);
		self:EmitSound("weapons/crossbow/hitbod2.wav");

		local bullet = {}
		bullet.Num    = 1
		bullet.Src    = self.Owner:GetShootPos()
		bullet.Dir    = self.Owner:GetAimVector()
		bullet.Spread = Vector(0, 0, 0)
		bullet.Tracer = 0
		bullet.Force  = 3
		bullet.Damage = 0
		self.Owner:DoAttackEvent()
		self.Owner:FireBullets(bullet) 
	else
		self:SendWeaponAnim(ACT_VM_MISSCENTER);
		self:EmitSound("npc/vort/claw_swing2.wav");
	end;
end;

function SWEP:DoAnimations(idle)
	if (!idle) then
		self.Owner:SetAnimation(PLAYER_ATTACK1);
	end;
end;

--[[-------------------------------------------------------
Name: SWEP:PrimaryAttack()
Desc: +attack1 has been pressed
---------------------------------------------------------]]
function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay);
	self:DoAnimations();
	self:DoHitEffects();

	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK_1 )
	
	if (SERVER) then
		if (self.Owner.LagCompensation) then
			self.Owner:LagCompensation(true);
		end;
		
		local trace = self.Owner:GetEyeTraceNoCursor();
		
		if (self.Owner:GetShootPos():Distance(trace.HitPos) <= 64) then
			if (IsValid(trace.Entity)) then
				if( string.StartWith( trace.Entity:GetClass(), "brickscrafting_tree" ) ) then
					if( BRICKSCRAFTING.CONFIG.WoodCutting[trace.Entity.TreeType or ""] ) then
						self:Succeed( trace.Entity.TreeType )
					end
				end
			end;
		end;
		
		if (self.Owner.LagCompensation) then
			self.Owner:LagCompensation(false);
		end;
	end;
end

function SWEP:Succeed( treeType )
	if( SERVER ) then
		local ChosenResource = ""
		local ResourcePercent = math.Rand(0, 100)
		local CurPercent = 0
		for k, v in pairs( BRICKSCRAFTING.CONFIG.WoodCutting[treeType].resource or {} ) do
			if( ResourcePercent > CurPercent and ResourcePercent < CurPercent+v ) then
				ChosenResource = k
				break
			end
			CurPercent = CurPercent+v
		end
	
		if( BRICKSCRAFTING.CONFIG.Resources[ChosenResource] ) then
			local MiscTable = self.Owner:GetBCS_MiscTable()

			local Multiplier = 1
			if( BRICKSCRAFTING.CONFIG.Tools.LumberAxe[(MiscTable.LumberAxeLevel or 0)] and BRICKSCRAFTING.CONFIG.Tools.LumberAxe[(MiscTable.LumberAxeLevel or 0)].Increase ) then
				Multiplier = 1+(BRICKSCRAFTING.CONFIG.Tools.LumberAxe[(MiscTable.LumberAxeLevel or 0)].Increase/100)
			end

			local ResourceAmount = math.floor( (BRICKSCRAFTING.CONFIG.WoodCutting[treeType].BaseReward or 10)*Multiplier )

			self.Owner:AddBCS_InventoryResource( { [ChosenResource] = ResourceAmount } )
			self.Owner:NotifyBCS_Chat( "+" .. ResourceAmount .. " " .. (ChosenResource or ""), (BRICKSCRAFTING.CONFIG.Resources[ChosenResource] or {}).icon or "" )

			if( self.Owner:GetBCS_SkillLevel( "Wood Cutting" ) < BRICKSCRAFTING.CONFIG.Tools.MaxLumberAxeSkill ) then
				local ChanceToIncrease = (BRICKSCRAFTING.CONFIG.Tools.MaxLumberAxeSkill-(self.Owner:GetBCS_SkillLevel( "Wood Cutting" ) or 0))/BRICKSCRAFTING.CONFIG.Tools.MaxLumberAxeSkill
				ChanceToIncrease = (ChanceToIncrease*100)*BRICKSCRAFTING.LUACONFIG.Defaults.LumberaxeSkillDifficulty
				ChanceToIncrease = math.Clamp( ChanceToIncrease, 5, 100 )
				local Chance = (math.Rand( 0, BRICKSCRAFTING.CONFIG.Tools.MaxLumberAxeSkill )/BRICKSCRAFTING.CONFIG.Tools.MaxLumberAxeSkill)*100

				if( Chance <= ChanceToIncrease ) then
					self.Owner:IncreaseBCS_SkillLevel( "Wood Cutting", 1 )
				end
			end

			BRICKSCRAFTING.AddExperience( self.Owner, BRICKSCRAFTING.LUACONFIG.ExpForCutting, "Wood Cutting" )
		else
			--DarkRP.notify( self.Owner, 1, 5, BRICKSCRAFTING.L("lumberAxeNoResGathered") )
		end
	end
end

function SWEP:SecondaryAttack()
end
