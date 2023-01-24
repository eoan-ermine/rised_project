-- "addons\\pickpocket\\lua\\weapons\\swep_pickpocket.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SWEP.PrintName = "Карманная кража"

SWEP.Purpose = "Stealing money or weapons from other players"
SWEP.Instructions = "Primary attack: steal active weapon\nSecondary attack: steal money\nMash mouse1 while pickpocketing: speed up pickpocket"

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.ViewModel = "models/weapons/v_hands.mdl"
SWEP.WorldModel = ""

SWEP.Primary.Clipsize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.Clipsize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.Slot               = 2
SWEP.SlotPos 			= 8
SWEP.DrawAmmo           = false
SWEP.DrawCrosshair      = false

SWEP.Cooldown = 0

SWEP.WepSelectFont		= "HL2MPTypeDeath"
SWEP.WepSelectLetter	= "P"

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )

	surface.SetDrawColor( color_transparent )
	surface.SetTextColor( 75, 75, 75, alpha )
	surface.SetFont( self.WepSelectFont )
	local w, h = surface.GetTextSize( self.WepSelectLetter )

	surface.SetTextPos( x + ( wide / 2 ) - ( w / 2 ),
						y + ( tall / 2 ) - ( h / 2 ) )
	surface.DrawText( self.WepSelectLetter )
end

-- Configuration
SWEP.PickpocketDuration = 5 -- Time it takes to successfully pickpocket a player
SWEP.PickpocketDistance = 35 -- How close the player has to stand to the other player to successfully pickpocket
SWEP.PickpocketFailureChance = 10 -- How often should a pickpocket "fail" at random?
SWEP.PickpocketCooldown = 0 -- Amount of time in seconds that a player has to wait before they can pickpocket again
SWEP.AllowPickpocketSpeedup = false -- Should the pickpocket speed up if the player mashes mouse1?
SWEP.SpeedUpIncrement = 0.2 -- How much time to take away from the timer if the player is mashing.
SWEP.AllowWeaponPickpocket = false -- Should we let the player pickpocket weapons?
SWEP.BannedWeapons = { "keys", "pocket", "gmod_tool", "gmod_camera", "weapon_keypadchecker", "arrest_stick", "unarrest_stick", "door_ram", "weapon_cbox", "weapon_m9" } -- Weapons that should not be pickpocketed
SWEP.BannedJobs = { TEAM_ZOMBIE, TEAM_ZOMBIECP, TEAM_FASTZOMBIE, TEAM_COMBINEZOMBIE } -- Jobs that should not be pickpocketed
SWEP.AllowMoneyPickpocket = true -- Should we let the player pickpocket money?
SWEP.PickpocketReward = 0.1 -- % of money stolen on successful pickpocket.
SWEP.PickpocketMax = 2 -- Maximum amount of money that can be stolen
SWEP.AllowInventoryPickpocket = false -- Should we let the player pickpocket from inventories if ItemStore is installed?
SWEP.SoundFrequency = 1 -- How often the "rummmaging" sounds play, in seconds.
SWEP.DarkRP25 = true -- Set this to true if you are running DarkRP 2.5.0
-- End of configuration

function SWEP:SetupDataTables()
	self:NetworkVar( "Bool", 0, "Pickpocketing" )
	self:NetworkVar( "String", 0, "PickpocketMode" )
	self:NetworkVar( "Float", 0, "PickpocketTime" )
	self:NetworkVar( "Entity", 0, "PickpocketTarget" )
end

function SWEP:Initialize()
	self:SetWeaponHoldType( "normal" )
end

function SWEP:CanPickpocket( target )
	return IsValid( target ) and target:IsPlayer() and not table.HasValue( self.BannedJobs, target:Team() ) and target:GetPos():Distance( self.Owner:GetPos() ) < self.PickpocketDistance
end

function SWEP:StartCooldown()
	self.Cooldown = CurTime() + self.PickpocketCooldown
end

function SWEP:Pickpocket( target, mode )
	self:SetPickpocketing( true )
	self:SetPickpocketTime( CurTime() + self.PickpocketDuration )
	self:SetPickpocketTarget( target )
	self:SetPickpocketMode( mode )

	self:StartCooldown()
end

function SWEP:PrimaryAttack()
	local target = self.Owner:GetEyeTrace().Entity

	if ( self.Owner:GetPos():Distance( target:GetPos() ) < self.PickpocketDistance ) and target:GetNWBool("Player_Char_NotImmune") then
		if ( self:GetPickpocketing() ) then
			if ( self.AllowPickpocketSpeedup ) then
				self:SetPickpocketTime( self:GetPickpocketTime() - self.SpeedUpIncrement )
			end
		else
			if ( self.AllowWeaponPickpocket and self:CanPickpocket( target ) and self.Cooldown < CurTime() ) then
				self:Pickpocket( target, "weapon" )
			end
		end
	end
end

function SWEP:SecondaryAttack()
	local target = self.Owner:GetEyeTrace().Entity

	if ( self.Owner:GetPos():Distance( target:GetPos() ) < self.PickpocketDistance ) and target:GetNWBool("Player_Char_NotImmune") then
		if ( self.AllowMoneyPickpocket and not self:GetPickpocketing() and self:CanPickpocket( target ) and self.Cooldown < CurTime()  ) then
			self:Pickpocket( target, "money" )
		end
	end
end

function SWEP:Reload()
	if ( itemstore ) then
		local target = self.Owner:GetEyeTrace().Entity

		if ( self.Owner:GetPos():Distance( target:GetPos() ) < self.PickpocketDistance ) then
			if ( self.AllowInventoryPickpocket and not self:GetPickpocketing() and self:CanPickpocket( target ) and self.Cooldown < CurTime()  ) then
				self:Pickpocket( target, "inventory" )
			end
		end
	end
end

if SERVER then
	AddCSLuaFile()

	local NextSound = 0
	function SWEP:Think()
		if ( self:GetPickpocketing() ) then
			local target = self:GetPickpocketTarget()

			if ( not self:CanPickpocket( target ) or self.Owner:GetEyeTrace().Entity ~= target ) then
				self:SetPickpocketing( false )
			else
				if ( NextSound < CurTime() ) then
					NextSound = CurTime() + self.SoundFrequency
				end

				if ( self:GetPickpocketTime() < CurTime() ) then
					self:SetPickpocketing( false )

					if ( math.random( 0, 100 ) > self.PickpocketFailureChance ) then
						if ( self:GetPickpocketMode() == "money" ) then
							
							local money = math.random( 500, 2000 )
							
							if target:getDarkRPVar( "money" ) == 0 then return false end
							
							if target:getDarkRPVar( "money" ) < money then
							money = math.random( 1, target:getDarkRPVar( "money" ) )
							end
							
							if ( self.DarkRP25 ) then
								target:addMoney( -money )
								self.Owner:addMoney( money )
							else
								target:AddMoney( -money )
								self.Owner:AddMoney( money )
							end

							AddTaskExperience(self.Owner, "Карманная кража")

							self.Owner:EmitSound( "physics/body/body_medium_impact_soft5.wav", 20 )
							self.Owner:PrintMessage( HUD_PRINTTALK, "Украдено " .. tostring( money ) .. " T." )
						elseif ( self:GetPickpocketMode() == "weapon" ) then
							local wep = target:GetActiveWeapon()

							if ( IsValid( wep ) ) then
								local class = wep:GetClass()

								if ( not table.HasValue( self.BannedWeapons, class ) ) then
									self.Owner:Give( class )
									target:StripWeapon(	class )

									self.Owner:PrintMessage( HUD_PRINTTALK, "Stole a " .. class .. "." )
								else
									self.Owner:PrintMessage( HUD_PRINTTALK, "..." )
								end
							else
								self.Owner:PrintMessage( HUD_PRINTTALK, "Could not steal from the player, they weren't holding anything!" )
							end
						elseif ( self:GetPickpocketMode() == "inventory" ) then
							local inv = target:GetInventory()
							local slots = {}

							for slot, item in pairs( inv.Items ) do
								if ( item ) then
									table.insert( slots, slot )
								end
							end

							local slot = table.Random( slots )

							if ( slot ) then
								local item = target:GetInventory():GetItem( slot )

								self.Owner:AddItem( item )
								target:SetItem( nil, slot )

								self.Owner:PrintMessage( HUD_PRINTTALK, "Stole a " .. item:GetName() .. "." )
							else
								self.Owner:PrintMessage( HUD_PRINTTALK, "Couldn't steal anything, there are no items in their inventory!" )
							end
						end
					else
						target:PrintMessage( HUD_PRINTTALK, "Вас пытались обокрасть!" )
						self.Owner:PrintMessage( HUD_PRINTTALK, "Неудача!" )
					end
					self.Owner:EmitSound( "physics/body/body_medium_impact_soft7.wav" )
				end
			end
		end
	end

	function SWEP:Holster()
		self:SetPickpocketing( false )
		return true
	end
else
	local gradientup = Material( "gui/gradient_up" )
	local gradientdown = Material( "gui/gradient_down" )

	function SWEP:DrawProgressBar( label, colour, filled )
		filled = math.Clamp( filled, 0, 1 )
		local w, h = 300, 20
		local centerx, centery = ScrW() / 2, ScrH() / 2
		local x, y = centerx - w / 2, centery - h / 2

		surface.SetDrawColor( Color( 255, 255, 255 ) )
		surface.DrawOutlinedRect( x, y, w, h )

		surface.SetDrawColor( colour )
		surface.SetMaterial( gradientdown )
		surface.DrawTexturedRect( x + 2, y + 2, ( w - 4 ) * filled, h - 4 )

		surface.SetDrawColor( Color( colour.r / 2, colour.g / 2, colour.b/ 2 ) )
		surface.SetMaterial( gradientup )
		surface.DrawTexturedRect( x + 2, y + 2, ( w - 4 ) * filled, h - 4 )

		draw.SimpleTextOutlined( label, "DermaDefaultBold", centerx, centery - 1, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
	end

	function SWEP:DrawHUD()
		if ( self:GetPickpocketing() ) then
			local text, colour

			if ( self:GetPickpocketMode() == "weapon" ) then
				text = "Pickpocketing weapon..."
				colour = Color( 255, 0, 0 )
			elseif ( self:GetPickpocketMode() == "money" ) then
				text = ""
				colour = Color( 200, 200, 200 )
			elseif ( self:GetPickpocketMode() == "inventory" ) then
				text = "Pickpocketing from inventory..."
				colour = Color( 0, 0, 255 )
			end

			self:DrawProgressBar( text, colour, ( self:GetPickpocketTime() - CurTime() ) / self.PickpocketDuration )
		end
	end
end
