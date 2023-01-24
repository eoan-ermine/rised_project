-- "addons\\bricks-crafting\\lua\\weapons\\bcs_storage.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = BRICKSCRAFTING.L("storage")
    SWEP.Slot = 5
    SWEP.SlotPos = 1
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = true
end

-- Variables that are used on both client and server

SWEP.Author = "BrickWall"
SWEP.Instructions = BRICKSCRAFTING.L("storageInstructions")
SWEP.Contact = ""
SWEP.Purpose = "Use storage"

SWEP.ViewModel = Model( "" ) -- just change the model 
SWEP.WorldModel = ( "" )
SWEP.ViewModelFOV = 85
SWEP.UseHands = true

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Category = "Bricks Crafting"

SWEP.Primary.ClipSize = -1      -- Size of a clip
SWEP.Primary.DefaultClip = 0        -- Default number of bullets in a clip
SWEP.Primary.Automatic = false      -- Automatic/Semi Auto
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1        -- Size of a clip
SWEP.Secondary.DefaultClip = -1     -- Default number of bullets in a clip
SWEP.Secondary.Automatic = false        -- Automatic/Semi Auto
SWEP.Secondary.Ammo = ""

--[[-------------------------------------------------------
Name: SWEP:Initialize()
Desc: Called when the weapon is first loaded
---------------------------------------------------------]]
function SWEP:Initialize()
    self:SetHoldType("normal")
end

function SWEP:SetupDataTables()

end

--[[-------------------------------------------------------
Name: SWEP:PrimaryAttack()
Desc: +attack1 has been pressed
---------------------------------------------------------]]

function SWEP:PrimaryAttack()

end

function SWEP:Holster()
	return true
end

function SWEP:Think()

end

function SWEP:SecondaryAttack()
	if( CLIENT ) then
		if( not IsValid( BCS_StorageMenu ) ) then
			BCS_StorageMenu = vgui.Create( "brickscrafting_vgui_storage" )
		else
			BCS_StorageMenu:SetVisible( true )
		end
	end
end

hook.Add( "PlayerLoadout", "BCSHooks_PlayerLoadout_GiveStorageSWEP", function( ply )
	if( BRICKSCRAFTING.LUACONFIG.DisableSWEP != true and IsValid( ply ) ) then
		ply:Give( "bcs_storage" )
	end
end )

if( CLIENT and BRICKSCRAFTING.LUACONFIG.StorageBind ) then
	hook.Add( "PlayerButtonDown", "BCSHooks_PlayerButtonDown_OpenStorage", function( ply, button )
		if( button == BRICKSCRAFTING.LUACONFIG.StorageBind ) then
			if( not IsValid( BCS_StorageMenu ) ) then
				BCS_StorageMenu = vgui.Create( "brickscrafting_vgui_storage" )
			else
				BCS_StorageMenu:SetVisible( true )
			end
		end
	end )
end