-- "addons\\rised_inventory\\lua\\weapons\\itemstore_checker.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if SERVER then
    AddCSLuaFile()
end

SWEP.PrintName = "Обыск"

SWEP.Purpose = "Обыск инвенторя или хранилища"
SWEP.Instructions = "ЛКМ: обыскать хранилище\nПКМ: проверить человека напротив"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.ViewModel = ""
SWEP.WorldModel = ""
SWEP.UseHands = true

SWEP.Primary.Clipsize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.Clipsize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.Slot               = 2
SWEP.SlotPos            = 99
SWEP.DrawAmmo           = false
SWEP.DrawCrosshair      = true

SWEP.Range = 250

function SWEP:Initialize()
    self:SetHoldType( "normal" )
end

function SWEP:OnDrop()
    self:Remove()
end

function SWEP:SetupDataTables()
    self:NetworkVar("Bool", 0, "IsWeaponChecking")
    self:NetworkVar("Float", 0, "StartCheckTime")
    self:NetworkVar("Float", 1, "EndCheckTime")
    self:NetworkVar("Float", 2, "NextSoundTime")
    self:NetworkVar("Int", 0, "TotalWeaponChecks")
end

function SWEP:PrimaryAttack()
    if self:GetIsWeaponChecking() then return end
    self:SetNextSecondaryFire(CurTime() + 0.3)

    self:GetOwner():LagCompensation(true)
    local trace = self:GetOwner():GetEyeTrace()
    self:GetOwner():LagCompensation(false)

    local ent = trace.Entity

    if not IsValid(ent) or ent:GetClass() != "itemstore_bank" or ent:GetPos():DistToSqr(self:GetOwner():GetPos()) > 10000 then
        return
    end

    self:SetIsWeaponChecking(true)
    self:SetStartCheckTime(CurTime())
    self:SetEndCheckTime(CurTime() + util.SharedRandom("DarkRP_WeaponChecker" .. self:EntIndex() .. "_" .. self:GetTotalWeaponChecks(), 5, 10))
    self:SetTotalWeaponChecks(self:GetTotalWeaponChecks() + 1)

    self:SetNextSoundTime(CurTime() + 0.5)

    if CLIENT then
        self.Dots = ""
        self.NextDotsTime = CurTime() + 0.5
    end
end

function SWEP:SecondaryAttack()
    if self:GetIsWeaponChecking() then return end
    self:SetNextSecondaryFire(CurTime() + 0.3)

    self:GetOwner():LagCompensation(true)
    local trace = self:GetOwner():GetEyeTrace()
    self:GetOwner():LagCompensation(false)

    local ent = trace.Entity
    if not IsValid(ent) or not ent:IsPlayer() or ent:GetPos():DistToSqr(self:GetOwner():GetPos()) > 10000 then
        return
    end

    self:SetIsWeaponChecking(true)
    self:SetStartCheckTime(CurTime())
    self:SetEndCheckTime(CurTime() + 1)
    self:SetTotalWeaponChecks(self:GetTotalWeaponChecks() + 1)

    self:SetNextSoundTime(CurTime() + 0.5)

    if CLIENT then
        self.Dots = ""
        self.NextDotsTime = CurTime() + 0.5
    end
end

function SWEP:Holster()
    self:SetIsWeaponChecking(false)
    self:SetNextSoundTime(0)
    return true
end

function SWEP:Succeed()
    if SERVER then
        if not IsValid(self:GetOwner()) then return end
        self:SetIsWeaponChecking(false)

        local trace = self:GetOwner():GetEyeTrace()
        local ent = trace.Entity
        
        if not IsValid(ent) then return end
        
        if ent:IsPlayer() then
            if !istable(ent.Inv) then return end

            local tbl = util.TableToJSON(ent.Inv)
            local binary = util.Compress(tbl)

            self.Owner:ConCommand("say /status обыскивает " .. ent:Name())
            net.Start("RisedInventory.Open")
            net.WriteInt(#binary, 32)
            net.WriteData(binary, #binary)
            net.WriteInt(2,10)
            net.WriteEntity(ent)
            net.Send(self.Owner)
            self.Owner:EmitSound("npc/combine_soldier/gear5.wav")

            hook.Call("Player_InventoryChecks", GAMEMODE, self.Owner, ent)
        end
    end
end

function SWEP:Fail()
    self:SetIsWeaponChecking(false)
    self:SetHoldType("normal")
    self:SetNextSoundTime(0)
end

function SWEP:Think()
    if self:GetIsWeaponChecking() and self:GetEndCheckTime() ~= 0 then
        self:GetOwner():LagCompensation(true)
        local trace = self:GetOwner():GetEyeTrace()
        self:GetOwner():LagCompensation(false)
        if not IsValid(trace.Entity) or trace.HitPos:DistToSqr(self:GetOwner():GetShootPos()) > 10000 or (not trace.Entity:IsPlayer() and trace.Entity:GetClass() != "itemstore_bank") then
            self:Fail()
        end
        if self:GetEndCheckTime() <= CurTime() then
            self:Succeed()
        end
    end
    if self:GetNextSoundTime() ~= 0 and CurTime() >= self:GetNextSoundTime() then
        if self:GetIsWeaponChecking() then
            self:SetNextSoundTime(CurTime() + 1.5)
            self:EmitSound("npc/combine_soldier/gear5.wav", 50, 100)
        else
            self:SetNextSoundTime(0)
            self:EmitSound("npc/combine_soldier/gear5.wav", 50, 100)
        end
    end
    if CLIENT and self.NextDotsTime and CurTime() >= self.NextDotsTime then
        self.NextDotsTime = CurTime() + 0.5
        self.Dots = self.Dots or ""
        local len = string.len(self.Dots)
        local dots = {
            [0] = ".",
            [1] = "..",
            [2] = "...",
            [3] = ""
        }
        self.Dots = dots[len]
    end
end

function SWEP:DrawHUD()
    if self:GetIsWeaponChecking() and self:GetEndCheckTime() ~= 0 then
        self.Dots = self.Dots or ""
        local w = ScrW()
        local h = ScrH()
        local x, y, width, height = w / 2 - w / 10, h / 1.9, w / 5, h / 15
        local time = self:GetEndCheckTime() - self:GetStartCheckTime()
        local curtime = CurTime() - self:GetStartCheckTime()
        local status = math.Clamp(curtime / time, 0, 1)
        local BarWidth = status * (width - 16)
        local cornerRadius = math.Min(8, BarWidth / 3 * 2 - BarWidth / 3 * 2 % 2)

        draw.RoundedBox(4, x, y, width - 4, 2, Color(0, 0, 0, 150))
        draw.RoundedBox(4, x, y, BarWidth, 2, Color(255, 195, 87, 255))
        draw.DrawNonParsedSimpleText("Обыск" .. self.Dots, "Trebuchet18", w / 2, y + height / 4, Color(255, 195, 87, 255), 1, 1)
    end
end
