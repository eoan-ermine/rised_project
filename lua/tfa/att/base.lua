-- "lua\\tfa\\att\\base.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

-- ATTACHMENT.TFADataVersion = 1 -- Uncomment this in your attachment file
-- If it is undefined, if fallback to 0 and WeaponTable gets migrated like SWEPs do

ATTACHMENT.Name = "Base Attachment"
ATTACHMENT.ShortName = nil --Abbreviation, 5 chars or less please
ATTACHMENT.Description = {} --TFA.Attachments.Colors["+"], "Does something good", TFA.Attachments.Colors["-"], "Does something bad" }
ATTACHMENT.Icon = nil --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.WeaponTable = {} --put replacements for your SWEP talbe in here e.g. ["Primary"] = {}

ATTACHMENT.DInv2_GridSizeX = nil -- DInventory/2 Specific. Determines attachment's width in grid.
ATTACHMENT.DInv2_GridSizeY = nil -- DInventory/2 Specific. Determines attachment's height in grid.
ATTACHMENT.DInv2_Volume = nil -- DInventory/2 Specific. Determines attachment's volume in liters.
ATTACHMENT.DInv2_Mass = nil -- DInventory/2 Specific. Determines attachment's mass in kilograms.
ATTACHMENT.DInv2_StackSize = nil -- DInventory/2 Specific. Determines attachment's maximal stack size.

ATTACHMENT.TFADataVersion = nil -- TFA.LatestDataVersion, specifies version of TFA Weapon Data this attachment utilize in `WeaponTable`
-- 0 is original, M9K-like data, and is the fallback if `TFADataVersion` is undefined

function ATTACHMENT:CanAttach(wep)
	return true --can be overridden per-attachment
end

function ATTACHMENT:Attach(wep)
end

function ATTACHMENT:Detach(wep)
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
