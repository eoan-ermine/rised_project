-- "lua\\tfa_ent_atts\\client\\cl_ent_atts.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
net.Receive("Attachments_Init", function()
    LocalPlayer().Atts = {}
end)

net.Receive("Attachments_Add", function()
    local att = net.ReadString()

    table.insert(LocalPlayer().Atts, att)
end)

net.Receive("Attachments_Remove", function()
    local attInTbl = net.ReadInt(16)

    table.remove(LocalPlayer().Atts, attInTbl)
end)

local function tfaOptionAttachments(panel)
    local tfaOptionAttachments = {
        Options = {},
        CVars = {},
        MenuButton = "1",
        Folder = "tfa_base_atts"
    }

    tfaOptionAttachments.Options["#preset.default"] = {
        ["sv_tfa_attachments_ents_enabled"] = 1,
        ["sv_tfa_attachments_ents_persistent"] = 0,
        ["sv_tfa_attachments_ents_infinite"] = 0,
        ["cl_tfa_attachments_ents_name"] = 1
    }

    tfaOptionAttachments.CVars = table.GetKeys(tfaOptionAttachments.Options["#preset.default"])
    panel:AddControl("ComboBox", tfaOptionAttachments)

    panel:Help("#tfa.settings.server")
    TFA.CheckBoxNet(panel, "#tfa.attsettings.enabled", "sv_tfa_attachments_ents_enabled")
    TFA.CheckBoxNet(panel, "#tfa.attsettings.persistent", "sv_tfa_attachments_ents_persistent")
    TFA.CheckBoxNet(panel, "#tfa.attsettings.infinite", "sv_tfa_attachments_ents_infinite")

    panel:Help("#tfa.settings.client")
    panel:CheckBox("#tfa.attsettings.name", "cl_tfa_attachments_ents_name")
end

local function AttachmentsAddOptions()
    spawnmenu.AddToolMenuOption("Utilities", "TFA SWEP Base Settings", "tfaOptionAttachments", "#tfa.smsettings.attachments", "", "", tfaOptionAttachments)
end

hook.Add("PopulateToolMenu", "AttachmentsAddOptions", AttachmentsAddOptions)

if GetConVar("cl_tfa_attachments_ents_name") == nil then
    CreateClientConVar("cl_tfa_attachments_ents_name", "1", "Enable attachments entities name drawing?")
end