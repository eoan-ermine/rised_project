-- "lua\\tfa\\att\\projecthl2_combine_usp.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Combine Standard Issue Skin"
--ATTACHMENT.ID = "base" -- normally this is just your filename

ATTACHMENT.Icon = "entities/csi_usp.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "CSI"

ATTACHMENT.WeaponTable = {
    MaterialTable_V = { -- materials that are present on both view- and worldmodel
        [1] = "models/weapons/v_pistol_new/v_combine_pistol_body",
        [2] = "models/weapons/v_pistol_new/v_combine_pistol_brass",
        [3] = "models/weapons/v_pistol_new/v_combine_pistol_chrome",
}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end