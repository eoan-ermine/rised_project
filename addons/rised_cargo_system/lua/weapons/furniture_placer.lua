-- "addons\\rised_cargo_system\\lua\\weapons\\furniture_placer.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if SERVER then
    AddCSLuaFile()
end

SWEP.Author = "D-Rised"
if CLIENT then
	SWEP.Slot = 3
	SWEP.ViewModelFOV = 10
	
	local lang_desc
	local lang_mapwarn
	if language == "ru" then
		lang_desc = ""
	else
		lang_desc = ""
	end
	SWEP.EquipMenuData = {
		type = "item_weapon",
		desc = lang_desc
	};
	
	SWEP.Purpose = lang_desc
end

SWEP.PrintName = "Установщик мебели"
SWEP.Purpose = "Установка мебели в квартиры"
SWEP.Instructions = "ЛКМ: установить \nПКМ: вращать"
SWEP.Category = "A - Rised - [Поставки]"
SWEP.HoldType = "duel"

local language = GetConVarString( "gmod_language" )

SWEP.ViewModel			 = "models/weapons/v_crowbar.mdl"
SWEP.WorldModel			= ""
SWEP.DrawWorldModel = false

SWEP.DrawCrosshair		= false
SWEP.Primary.ClipSize		 = -1
SWEP.Primary.DefaultClip	 = -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		 = "none"
SWEP.Primary.Delay = 1

SWEP.Secondary.ClipSize	  = -1
SWEP.Secondary.DefaultClip  = -1
SWEP.Secondary.Automatic	 = true
SWEP.Secondary.Ammo	  = "none"
SWEP.Secondary.Delay = 1

SWEP.Spawnable = true
SWEP.LimitedStock = false
SWEP.AllowDrop = true
SWEP.NoSights = true

SWEP.DefaultFurnitureModel = "models/props_interiors/Furniture_chair03a.mdl"
SWEP.RotationSpin = 0

function SWEP:RemoveClientPreview()
	if CLIENT then
		if IsValid(self.furniture) then
			self.furniture:SetNoDraw(true)
			self.furniture:Remove()
		end
	end
end

if CLIENT then
	function SWEP:OwnerChanged()
		if LocalPlayer() != self.Owner then
			self:RemoveClientPreview()
		else
			self:Deploy()
		end
	end
end

function SWEP:Initialize()
    if CLIENT then
        self:Deploy()
        self.furniture:SetNoDraw(true)
        self.furniture.hidden = true
        return self.BaseClass.Initialize(self)
    end
end

function SWEP:PrimaryAttack()
	self:Place()
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
end
function SWEP:SecondaryAttack()
    self:SetNWInt("Furniture_RotationYaw", self:GetNWInt("Furniture_RotationYaw") + 1)
end

function SWEP:Place()
	if SERVER then
		local ply = self.Owner
		if not IsValid( ply ) then return end
		if self.Planted then return end

		local vsrc = ply:GetShootPos()
		local vang = ply:GetAimVector()
		local vvel = ply:GetVelocity()
		local eyetrace = ply:GetEyeTrace()
		local distply = eyetrace.HitPos:Distance( ply:GetPos() )
		
		if distply > 100 or !eyetrace.HitWorld then
			if language == "ru" then
				ply:ChatPrint( "Выберите другое место." )
			else
				ply:ChatPrint( "Неподходящее место!" )
			end
			return false
		end

        self:GetDoor()
        local door = self:GetNWString("Rised_Furniture_Door")
        if door == "" then
            ply:ChatPrint( "Установка возможно только квартире!" )
            return
        end
		
		local playerangle = ply:GetAngles()
		local supportangle
		local support = ents.Create( "prop_dynamic" )
		if IsValid( support ) then
			if ply.AddCleanup != nil then
				ply:AddCleanup( "npcs", support )
			end
			support:SetModel( "models/hunter/blocks/cube025x025x025.mdl" )
			supportangle = support:GetAngles()
			support:SetPos( eyetrace.HitPos + eyetrace.HitNormal * 16 )
			support:SetColor( Color( 0,0,0,0 ) )
			support:Spawn()
			support:SetCollisionGroup( COLLISION_GROUP_WORLD ) -- no physgun, etc.

			support:SetRenderMode( 10 )
			support:DrawShadow( false )
			
			support.furniture = ents.Create( "rised_home_mail" )
			if IsValid( support.furniture ) then
				self.Planted = true
				support.furniture.support = support
				support.furniture:SetParent( support ) -- Bug in Garry's Mod
				support.furniture:SetLocalPos( Vector( 0,0,0 ) )
				
				support:SetAngles( Angle( supportangle.p, playerangle.y + self:GetNWInt("Furniture_RotationYaw"), supportangle.r ) )
				support.furniture:SetAngles( support:GetAngles() )
				
				support.furniture:Spawn()
                support.furniture:SetModel(self:GetNWString("Rised_Furniture_Model"))
				support.furniture:SetMoveType(MOVETYPE_NONE)	
				if IsValid(support.furniture:GetPhysicsObject()) then
					support.furniture:GetPhysicsObject():EnableMotion(false)
				end
				
				support.furniture:EmitSound("npc/turret_floor/deploy.wav")
					
				-- Bug fix:
				support.furniture:SetParent( NULL )
				support.furniture:DeleteOnRemove( support )
				constraint.Weld( support.furniture, support, 0, 0, 0, true, false )
				
				support.furniture:Activate()
				support.furniture:SetMaxHealth( 150 )
				support.furniture:SetHealth( 150 )
				
				support.furniture:SetPhysicsAttacker(ply)
				support.furniture:SetCreator(ply)
				support.furniture:SetOwner(ply)
				support.furniture:SetNWString("Rised_Furniture_Name", self:GetNWString("Rised_Furniture_Name"))
				
				ply:SelectWeapon("re_hands")
				
				local turret_pos = support.furniture:GetPos()
				local distance_timer = "turret"..tostring( support.furniture:GetCreationID() )
				timer.Create( distance_timer, 0.2, 0, function()
					if !IsValid( support.furniture ) or !IsValid( ply ) then
						timer.Destroy( distance_timer )
						return
					end
					local ply_pos = ply:GetPos()
					if math.abs( turret_pos.x-ply_pos.x )>50 or math.abs( turret_pos.y-ply_pos.y )>50 then
						support.furniture:SetOwner( nil )
						timer.Destroy( distance_timer )
					end
				end )
				
				support.furniture:SetNWEntity("Rised_Furniture_OwnerId", ply:SteamID())
				support.furniture:SetNWEntity("Rised_Furniture_Apartment", self:GetNWString("Rised_Furniture_Apartment"))
				self:SaveToApartment(support.furniture, door, support.furniture:GetModel(), support.furniture:GetPos(), support.furniture:GetAngles())
				self:Remove()
			end
		end
	end
end

function SWEP:SaveToApartment(furniture, door, model, pos, ang)
	local apartmentId = self:GetNWString("Rised_Furniture_Apartment")
	if RISED.Config.Apartments[apartmentId] and file.Exists("risedproject/apartments.json", "DATA") then
		db = util.JSONToTable(file.Read("risedproject/apartments.json", "DATA") or {})

		local furnitureId = 1
		for k,v in pairs(db[apartmentId]["Мебель"]) do
		   if v["Номер"] >= furnitureId then
			   	furnitureId = v["Номер"] + 1
		   end
		end
		furniture:SetNWInt("Rised_Furniture_Id", furnitureId)
		
		local furniture = {
			["Номер"] = furnitureId,
			["Имя"] = furniture:GetNWInt("Rised_Furniture_Name"),
			["Модель"] = model,
			["Позиция"] = pos,
			["Угол"] = ang,
		}
		table.insert(db[apartmentId]["Мебель"], furniture)
		file.Write("risedproject/apartments.json", util.TableToJSON(db, true))
	end
end

function SWEP:GetDoor()
	local door
	local doors = ents.FindInSphere(self:GetPos(), 1000)
	local self_pos = self:GetPos()
	self_pos.z = 0
	for k,v in pairs(doors) do
		if v:GetClass() == "prop_door_rotating" then
			if IsValid(door) then
				local door_pos = door:GetPos()
				door_pos.z = 0
				local new_door_pos = v:GetPos()
				new_door_pos.z = 0
				if self_pos:Distance(door_pos) > self_pos:Distance(new_door_pos) and (v:GetPos().z - self:GetPos().z) >= -50 and (v:GetPos().z - self:GetPos().z) <= 55 then
					for j,c in pairs(RISED.Config.Apartments) do 
						if c["Входная дверь"] == v:GetName() then
							door = v
							self:SetNWString("Rised_Furniture_Apartment", j)
							self:SetNWString("Rised_Furniture_Door", door:GetName())
						end
					end
				end
			else
				for j,c in pairs(RISED.Config.Apartments) do
					if c["Входная дверь"] == v:GetName() then
						door = v
					end
				end
			end
		end
	end
end

function SWEP:Reload()
	return false
end

function SWEP:OnRemove()
	if CLIENT and IsValid(self.Owner) and self.Owner == LocalPlayer() and self.Owner:Alive() then
		self:RemoveClientPreview()
	end
end

function SWEP:Deploy()

	if self:GetNWString("Rised_Furniture_Model", "") == "" then
		self:SetNWString("Rised_Furniture_Model", self.DefaultFurnitureModel)
	end

	if SERVER and IsValid(self.Owner) then
		self.Owner:DrawViewModel(false)
	end

	if CLIENT then
		if !IsValid(self.furniture) then
			self.furniture = ents.CreateClientProp(self:GetNWString("Rised_Furniture_Model"))
		end
		if IsValid(self.furniture) then
			self.furniture:SetParent(self)
			self.furniture:SetModel(self:GetNWString("Rised_Furniture_Model"))
			self.furniture:Spawn()
            self.furniture:SetPos(self.Owner:GetPos())
			self.furniture.WellPlaced = true
			self:Think()
		end
	end

	return true
end

function SWEP:Holster()
	self:RemoveClientPreview()
	return true
end

if CLIENT then
	function SWEP:Think()
		if IsValid(self.furniture) then
			local ply = LocalPlayer()
			if ply:GetActiveWeapon() == self then
				if self.furniture.hidden then
					self.furniture:SetNoDraw(false)
					self.furniture.hidden = false
				end
				local eyetrace = ply:GetEyeTrace()

				local newPos = eyetrace.HitPos + eyetrace.HitNormal * 16
                local newAngle = Angle(0, ply:GetAngles().y + self:GetNWInt("Furniture_RotationYaw"), 0)
				self.furniture:SetPos(LerpVector(0.01, self.furniture:GetPos(), newPos))
				self.furniture:SetAngles(LerpAngle(0.01, self.furniture:GetAngles(), newAngle))
				local distply = newPos:Distance(ply:GetPos())
				if distply > 100 or !eyetrace.HitWorld then
					if self.furniture.WellPlaced then
						self.furniture:SetColor(Color(128,0,0))
						self.furniture:SetMaterial("models/shiny")
						self.furniture.WellPlaced = false
					end
				else
					self.furniture:SetColor(Color(255,255,255))
					self.furniture:SetMaterial("models/shiny")
					self.furniture.WellPlaced = true
				end
			else
				if !self.furniture.hidden then
					self.furniture:SetNoDraw(true)
					self.furniture.hidden = true
				end
			end
		end
	end
end