-- "addons\\controllable_city_scanner\\lua\\weapons\\weapon_controllable_city_scanner\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SWEP.Author = "Thomas"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = ""

SWEP.Category = "A - Rised - [Альянс]"
SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.UseHands = true
SWEP.HoldType = "pistol"
SWEP.ViewModel = Model("models/weapons/c_grenade.mdl")
SWEP.WorldModel = Model("models/manhack.mdl")

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = ControllableScanner.ConVarAmmoInfinite() and -1 or ControllableScanner.ConVarAmmoAmount()
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ControllableScanner.ConVarAmmoInfinite() and "none" or ControllableScanner.manhackAmmoName
SWEP.Primary.Delay = 2

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.SpawnDistance = 40
SWEP.PrimarySequence = 2
SWEP.PrimarySequence2 = 0
SWEP.SpawnDelay = 0.2
SWEP.ResetDelay = 2

SWEP.TraceNormalMultiplier = 8

function SWEP:Initialize()
	local weaponsTable = weapons.GetStored(ControllableScanner.manhackWeaponClassName)
	local primaryDefaultClip = ControllableScanner.ConVarAmmoInfinite() and -1 or ControllableScanner.ConVarAmmoAmount()
	local primaryAmmo = ControllableScanner.ConVarAmmoInfinite() and "none" or ControllableScanner.manhackAmmoName
	
	if weaponsTable then
		weaponsTable.Primary.DefaultClip = primaryDefaultClip
		weaponsTable.Primary.Ammo = primaryAmmo
	end
	
	self.Primary.DefaultClip = primaryDefaultClip
	self.Primary.Ammo = primaryAmmo
	
	self:SetHoldType(self.HoldType)
	
	if CLIENT then
		-- Create a new table for every weapon instance
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

		self:CreateModels(self.VElements) -- create viewmodels
		self:CreateModels(self.WElements) -- create worldmodels
		
		-- init view model bone build function
		if IsValid(self.Owner) then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
				
				-- Init viewmodel visibility
				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetColor(Color(255,255,255,255))
				else
					-- we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
					vm:SetColor(Color(255,255,255,1))
					-- ^ stopped working in GMod 13 because you have to do Entity:SetRenderMode(1) for translucency to kick in
					-- however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
					vm:SetMaterial("Debug/hsv")
				end
			end
		end
	end
end

function SWEP:Holster()
	if CLIENT and IsValid(self.Owner) then
		local vm = self.Owner:GetViewModel()
		
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
		
		self.Owner:DrawViewModel(true)
	end
	
	return true
end

function SWEP:OnRemove()
	self:Holster()
end