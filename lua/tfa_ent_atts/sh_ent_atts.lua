-- "lua\\tfa_ent_atts\\sh_ent_atts.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
CreateConVar("sv_tfa_attachments_ents_enabled", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Enable extended TFA attachments?")
CreateConVar("sv_tfa_attachments_ents_persistent", "0", {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Enable persistent TFA attachments?")
CreateConVar("sv_tfa_attachments_ents_infinite", "0", {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Make infinite amount of TFA attachment?")

local PLAYER = FindMetaTable("Player")

function PLAYER:GetAttachments()
    return self.Atts or {}
end

function PLAYER:HasAttachment(att)
    return table.HasValue(self.Atts, att)
end

hook.Add("TFA_CanAttach", "AttachmentCanAttach", function(wepom, attid)
    if GetConVar("sv_tfa_attachments_ents_enabled"):GetInt() == 0 then return end

    if wepom.Owner:HasAttachment(attid) then return true end

    return false
end)

hook.Add("Initialize", "AttachmentsInitialize", function()
    AttachmentsGenerateEntities()
end)

function AttachmentsGenerateEntities()
    for k, v in pairs(TFA.Attachments.Atts) do
        local attEnt = {}

        attEnt.Base = "base_att_ent"
        attEnt.PrintName = v.Name .. " [" .. k .. "]" or "Invalid Attachment"
        attEnt.Spawnable = true
        attEnt.AdminOnly = false
        attEnt.Category = "TFA Attachments"
        attEnt.Att = k

        scripted_ents.Register(attEnt, "att_" .. attEnt.Att)
    end
end