-- "addons\\darkrpmodification\\lua\\darkrp_modules\\base\\cl_radialmenu.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
function isCP()
    return LocalPlayer():isCP()
end

function isRazor()
    return LocalPlayer():Team() == TEAM_OTA_Razor
end

function isCMD()
    return LocalPlayer():Team() == TEAM_MPF_JURY_CPT or LocalPlayer():Team() == TEAM_MPF_JURY_GEN or LocalPlayer():Team() == TEAM_OWUDISPATCH
end

function isCivilian()
    return LocalPlayer():Team() == TEAM_CONNECTOR or LocalPlayer():Team() == TEAM_CITIZENXXX or GAMEMODE.LoyaltyJobs[LocalPlayer():Team()] or GAMEMODE.CrimeJobs[LocalPlayer():Team()]
end

function isCombine()
    return GAMEMODE.CombineJobs[LocalPlayer():Team()]
end

function isCitMale()
    return (GAMEMODE.Rebels[LocalPlayer():Team()] or GAMEMODE.LoyaltyJobs[LocalPlayer():Team()] or LocalPlayer():Team() == TEAM_CONNECTOR or LocalPlayer():Team() == TEAM_CITIZENXXX || LocalPlayer():Team() == TEAM_JAILEDCITIZEN || LocalPlayer():Team() == TEAM_THEIF || LocalPlayer():Team() == TEAM_DRUGDEALER || LocalPlayer():Team() == TEAM_UNGUN || LocalPlayer():Team() == TEAM_REFUGEE) and LocalPlayer():GetNWString("Player_Sex") == "Мужской"
end

function isCitFemale()
    return (GAMEMODE.Rebels[LocalPlayer():Team()] or GAMEMODE.LoyaltyJobs[LocalPlayer():Team()] or LocalPlayer():Team() == TEAM_CONNECTOR or LocalPlayer():Team() == TEAM_CITIZENXXX || LocalPlayer():Team() == TEAM_JAILEDCITIZEN || LocalPlayer():Team() == TEAM_THEIF || LocalPlayer():Team() == TEAM_DRUGDEALER || LocalPlayer():Team() == TEAM_UNGUN || LocalPlayer():Team() == TEAM_REFUGEE) and LocalPlayer():GetNWString("Player_Sex") == "Женский"
end

function isRebMale()
    return GAMEMODE.Rebels[LocalPlayer():Team()] and LocalPlayer():GetNWString("Player_Sex") == "Мужской"
end

function isRebFemale()
    return GAMEMODE.Rebels[LocalPlayer():Team()] and LocalPlayer():GetNWString("Player_Sex") == "Женский"
end

function isVortigaunt()
    return LocalPlayer():Team() == TEAM_VORTIGAUNT or LocalPlayer():Team() == TEAM_VORTIGAUNTSLAVE
end

function isMetropolice()
    return GAMEMODE.MetropoliceJobs[LocalPlayer():Team()]
end

function isMetropoliceCanOL()
    return GAMEMODE.MetropoliceJobs[LocalPlayer():Team()] and LocalPlayer():Team() != TEAM_MPF_JURY_Conscript and LocalPlayer():Team() != TEAM_MPF_JURY_PVT
end

function isMetropoliceCMD()
    return GAMEMODE.MetropoliceCmdJobs[LocalPlayer():Team()]
end

function IsCombine()
    return GAMEMODE.CombineJobs[LocalPlayer():Team()]
end

function IsCombineMask()
    return LocalPlayer():GetNWBool("Player_CombineMask")
end

function IsCombineVocoder()
    return LocalPlayer():GetNWBool("Player_CombineVOX")
end

function IsRazor()
    if !isfunction(LocalPlayer().Team) then return false end
    return LocalPlayer():Team() == TEAM_OTA_Razor
end

function IsGhosted()
    if !isfunction(LocalPlayer().Team) then return false end
    return LocalPlayer():GetNWBool("Player_Razor_Ghosted")
end

function CanAnnouncement()
    if !isfunction(LocalPlayer().Team) then return false end
    return LocalPlayer():Team() == TEAM_OWUDISPATCH or LocalPlayer():Team() == TEAM_PARTYGENERALSECRETARY or LocalPlayer():Team() == TEAM_CONSUL or LocalPlayer():Team() == TEAM_MPF_JURY_GEN or LocalPlayer():Team() == TEAM_PARTYWORKSUPERVISOR
end

function CanAnnouncementWorkPhase()
    if !isfunction(LocalPlayer().Team) then return false end
    return LocalPlayer():Team() == TEAM_PARTYWORKSUPERVISOR
end

function CanAnnouncementCityStatuses()
    if !isfunction(LocalPlayer().Team) then return false end
    return LocalPlayer():Team() == TEAM_OWUDISPATCH or LocalPlayer():Team() == TEAM_PARTYGENERALSECRETARY or LocalPlayer():Team() == TEAM_CONSUL or LocalPlayer():Team() == TEAM_MPF_JURY_GEN
end

function ReturnVoicesPack(voice_pack)
    local commands = {}

    for k,v in pairs(voice_pack) do
        table.insert(commands, {
            ["Name"] = v,
            ["IsDraggable"] = 0,
            ["Function"] = function()
                RunConsoleCommand("say", v)
            end
        })
    end
    return commands
end

RISED.Animations = {
    ["Metropolice"] = {
        {
            ["AnimationName"] = "Расслабиться, бить палкой об ногу",
            ["AnimationID"] = 13,
            ["Simple"] = true,
            ["AutoKill"] = false,
        },
        {
            ["AnimationName"] = "Приказать отойти",
            ["AnimationID"] = 20,
            ["Simple"] = true,
            ["AutoKill"] = true,
        },
        {
            ["AnimationName"] = "Остановить",
            ["AnimationID"] = 21,
            ["Simple"] = true,
            ["AutoKill"] = true,
        },
        {
            ["AnimationName"] = "Приказать отойти",
            ["AnimationID"] = 20,
            ["Simple"] = true,
            ["AutoKill"] = true,
        },
        {
            ["AnimationName"] = "Оттолкнуть",
            ["AnimationID"] = 187,
            ["Simple"] = true,
            ["AutoKill"] = true,
        },
        {
            ["AnimationName"] = "Предупредить/Приказать отойти",
            ["AnimationID"] = 186,
            ["Simple"] = true,
            ["AutoKill"] = true,
        },
        {
            ["AnimationName"] = "Приказать пройти налево",
            ["AnimationID"] = 194,
            ["Simple"] = true,
            ["AutoKill"] = true,
        },
        {
            ["AnimationName"] = "Запретить проход, расслабившись",
            ["AnimationID"] = 171,
            ["Simple"] = false,
            ["AutoKill"] = true,
            ["Delay"] = 3.3,
            ["SecondAnimationID"] = 13,
            ["SecondAutoKill"] = false,
        },
        {
            ["AnimationName"] = "Потереть палку",
            ["AnimationID"] = 172,
            ["Simple"] = true,
            ["AutoKill"] = true,
        },
        {
            ["AnimationName"] = "Скрестить руки, начав бить палкой по плечу",
            ["AnimationID"] = 173,
            ["Simple"] = true,
            ["AutoKill"] = true,
        },
    },
    ["Combine"] = {
        {
            ["AnimationName"] = "Начать что-то писать на консоли",
            ["AnimationID"] = 156,
            ["Simple"] = false,
            ["AutoKill"] = true,
            ["Delay"] = 1.1,
            ["SecondAnimationID"] = 157,
            ["SecondAutoKill"] = false,
        },
    },
    ["Models1"] = {
        {
            ["AnimationName"] = "Прикрыться",
            ["AnimationID"] = 548,
            ["Simple"] = false,
            ["AutoKill"] = true,
            ["Delay"] = 0.6,
            ["SecondAnimationID"] = 549,
            ["SecondAutoKill"] = false,
        },
        {
            ["AnimationName"] = "Отрицать руками",
            ["AnimationID"] = 1052,
            ["Simple"] = true,
            ["AutoKill"] = true,
        },
        {
            ["AnimationName"] = "Расслабиться, сгорбить спину",
            ["AnimationID"] = 876,
            ["Simple"] = true,
            ["AutoKill"] = false,
        },
        {
            ["AnimationName"] = "Скрестить руки",
            ["AnimationID"] = 468,
            ["Simple"] = true,
            ["AutoKill"] = false,
        },
        {
            ["AnimationName"] = "Положить руки в карманы",
            ["AnimationID"] = 470,
            ["Simple"] = true,
            ["AutoKill"] = false,
        },
        {
            ["AnimationName"] = "Сесть на что-то",
            ["AnimationID"] = 814,
            ["Simple"] = true,
            ["AutoKill"] = false,
        },
        {
            ["AnimationName"] = "Сесть на пол",
            ["AnimationID"] = 810,
            ["Simple"] = false,
            ["AutoKill"] = true,
            ["Delay"] = 2,
            ["SecondAnimationID"] = 811,
            ["SecondAutoKill"] = false,
        },
        {
            ["AnimationName"] = "Лечь",
            ["AnimationID"] = 897,
            ["Simple"] = true,
            ["AutoKill"] = false,
        },
        {
            ["AnimationName"] = "Лежать на спине извиваясь от боли",
            ["AnimationID"] = 911,
            ["Simple"] = true,
            ["AutoKill"] = false,
        },
        {
            ["AnimationName"] = "Лежать на боку, держась за живот, терпя боль",
            ["AnimationID"] = 912,
            ["Simple"] = true,
            ["AutoKill"] = false,
        },
        {
            ["AnimationName"] = "Лежать на спине, тяжело дыша",
            ["AnimationID"] = 913,
            ["Simple"] = true,
            ["AutoKill"] = false,
        },
    },
    ["Models"] = {
        {
            ["AnimationName"] = "Держать рукой другую руку",
            ["AnimationID"] = 469,
            ["Simple"] = true,
            ["AutoKill"] = false,
        },
        {
            ["AnimationName"] = "Держать руку под подбородком",
            ["AnimationID"] = 470,
            ["Simple"] = true,
            ["AutoKill"] = false,
        },
        {
            ["AnimationName"] = "Скрестить руки",
            ["AnimationID"] = 468,
            ["Simple"] = true,
            ["AutoKill"] = false,
        },
        {
            ["AnimationName"] = "Лечь",
            ["AnimationID"] = 785,
            ["Simple"] = true,
            ["AutoKill"] = false,
        },
        {
            ["AnimationName"] = "Помахать",
            ["AnimationID"] = 522,
            ["Simple"] = true,
            ["AutoKill"] = true,
        },
        {
            ["AnimationName"] = "Подозвать",
            ["AnimationID"] = 523,
            ["Simple"] = true,
            ["AutoKill"] = true,
        },
        {
            ["AnimationName"] = "Проверить тело",
            ["AnimationID"] = 809,
            ["Simple"] = false,
            ["AutoKill"] = true,
            ["Delay"] = 0.6,
            ["SecondAnimationID"] = 808,
            ["SecondAutoKill"] = false,
        },
        {
            ["AnimationName"] = "Прикрыться",
            ["AnimationID"] = 525,
            ["Simple"] = false,
            ["AutoKill"] = true,
            ["Delay"] = 0.5,
            ["SecondAnimationID"] = 526,
            ["SecondAutoKill"] = false,
        },
        {
            ["AnimationName"] = "Сесть, положив ногу на другую",
            ["AnimationID"] = 773,
            ["Simple"] = true,
            ["AutoKill"] = false,
        },
        {
            ["AnimationName"] = "Лечить/Проверить тело",
            ["AnimationID"] = 817,
            ["Simple"] = false,
            ["AutoKill"] = true,
            ["Delay"] = 2.4,
            ["SecondAnimationID"] = 816,
            ["SecondAutoKill"] = false,
        },
        {
            ["AnimationName"] = "Лежать раненным",
            ["AnimationID"] = 814,
            ["Simple"] = true,
            ["AutoKill"] = false,
        },
    },
}

function ReturnAnimationPack()

    local commands = {}
    local anims = {}

    local models = { 
        "models/hl2rp/female_01.mdl",
        "models/hl2rp/female_02.mdl",
        "models/hl2rp/female_03.mdl",
        "models/hl2rp/female_04.mdl",
        "models/hl2rp/female_06.mdl",
        "models/hl2rp/female_07.mdl",
        "models/humans/combine/female_01.mdl",
        "models/humans/combine/female_02.mdl",
        "models/humans/combine/female_03.mdl",
        "models/humans/combine/female_04.mdl",
        "models/humans/combine/female_06.mdl",
        "models/humans/combine/female_07.mdl",
        "models/humans/combine/female_08.mdl",
        "models/humans/combine/female_08.mdl",
        "models/humans/combine/female_09.mdl",
        "models/humans/combine/female_10.mdl",
        "models/humans/combine/female_11.mdl",
        "models/humans/combine/female_ga.mdl",
    }

    local models1 = { 
        "models/hl2rp/male_01.mdl",
        "models/hl2rp/male_02.mdl",
        "models/hl2rp/male_03.mdl",
        "models/hl2rp/male_04.mdl",
        "models/hl2rp/male_05.mdl",
        "models/hl2rp/male_06.mdl",
        "models/hl2rp/male_07.mdl",
        "models/hl2rp/male_08.mdl",
        "models/hl2rp/male_09.mdl",
    }

    if !IsValid(LocalPlayer()) then return end

    if GAMEMODE.MetropoliceJobs[LocalPlayer():Team()] then
        anims = RISED.Animations["Metropolice"]
    elseif GAMEMODE.CombineJobs[LocalPlayer():Team()] then
        anims = RISED.Animations["Combine"]
    elseif table.HasValue(models, LocalPlayer():GetModel()) then
        anims = RISED.Animations["Models"]
    elseif table.HasValue(models1, LocalPlayer():GetModel()) then
        anims = RISED.Animations["Models1"]
    end

    for k,v in pairs(anims) do
        table.insert(commands, {
            ["Name"] = v["AnimationName"],
            ["IsDraggable"] = 0,
            ["Function"] = function()
                LocalPlayer():SetNWBool("anim", true)
                net.Start( "anim_ris_server" )
                net.WriteInt(v["AnimationID"], 32)
                net.WriteBool(v["AutoKill"])
                net.SendToServer()

                if !v["Simple"] then
                    timer.Simple(v["Delay"], function()
                        LocalPlayer():SetNWBool("anim", true)
                        net.Start( "anim_ris_server" )
                        net.WriteInt(v["SecondAnimationID"], 32)
                        net.WriteBool(v["SecondAutoKill"])
                        net.SendToServer()
                    end)
                end
            end
        })
    end
    return commands
end

Radial = Radial or {}
Radial.radialVersion = "2022-05-19"	-- Modified by Rised
Radial.radialConfig = {}
Radial.radialConfigOperations = {}
Radial.radialMenuOpen = false
Radial.selectedListTool = nil
Radial.settingshovertool = nil

local dragging = false
local dragdist = 0
local dip = {}
local clickedon = ""
local st = 0
local screenCenterX = ScrW() / 2
local screenCenterY = ScrH() / 2
local pi = 4 * math.atan2(1, 1)
local radialEntrySize = 0
local radialMenu_Operation = 0
local tex = surface.GetTextureID("vgui/cursors/arrow")
local exist = false
local RadialDefaultFont = "DermaDefault"

local math = math
local surface = surface
local gui = gui
Radial.includedtoolsettings = {name = 1,exp = 1,rconcommand = 1,cr = 1, cg = 1, cb = 1, ca = 1, cal = 1}

local function resetradialmenu()

    screenCenterX = ScrW() / 2
    screenCenterY = ScrH() / 2

    local tempPresets = table.Copy(Radial.radialConfigOperations)
    
    for k,v in pairs(tempPresets) do --same again
        for k2,v2 in pairs(v) do
            if Radial.includedtoolsettings[k2] ~= 1 then
                tempPresets[k][k2] = nil
            end
        end
    end
    
    Radial.radialConfigOperations = tempPresets
end

Radial.radialConfig["gbr-version"] = Radial.radialVersion
Radial.radialConfig["gbr-menudeadzone"] = 265
Radial.radialConfig["gbr-menuradius"] = 270
Radial.radialConfig["gbr-menusplitterlength"] = 90
Radial.radialConfig["gbr-menushowtraceline"] = 1
Radial.radialConfig["gbr-rotatetext"] = 1
Radial.radialConfig["gbr-spacing"] = 0.3
Radial.radialConfig["gbr-selectedinner"] = 1.22
Radial.radialConfig["gbr-selectedouter"] = 1.69
Radial.radialConfig["gbr-drawborder"] = 0
Radial.radialConfig["gbr-borderpasses"] = 2
Radial.radialConfig["gbr-enablesounds"] = 1

Radial.radialConfig["gbr-font"] = "DermaLarge"
Radial.radialConfig["gbr-fontscale"] = 0.7
Radial.radialConfig["gbr-clampx"] = 1
Radial.radialConfig["gbr-clampy"] = 0
Radial.radialConfig["gbr-outline"] = 0

Radial.radialConfig["gbr-hr"] = 255
Radial.radialConfig["gbr-hg"] = 195
Radial.radialConfig["gbr-hb"] = 0
Radial.radialConfig["gbr-ha"] = 25

Radial.radialConfig["gbr-dr"] = 15
Radial.radialConfig["gbr-dg"] = 15
Radial.radialConfig["gbr-db"] = 15
Radial.radialConfig["gbr-da"] = 155

Radial.radialConfig["gbr-tr"] = 255
Radial.radialConfig["gbr-tg"] = 255
Radial.radialConfig["gbr-tb"] = 255
Radial.radialConfig["gbr-ta"] = 255

Radial.radialConfig["gbr-colorspeed"] = 0.12
Radial.radialConfig["gbr-animspeed"] = 0.38

Radial.radialConfig["gbr-onclose"] = function()
end

Radial.radialConfig["gbr-rotate"] = 0

local function Request(title, text, func)
    return function()
        Derma_StringRequest(title, text, nil, function(s)
            func(s)
        end)
    end
end

function BuildRadialMenu(operations)
    if !istable(operations) then return end
    timer.Simple(0.2,function()
        
        Radial.radialConfigOperations = {}

        local i = 1
        for k,v in pairs(operations) do
            
            if isfunction(v["Disabled"]) then
                local func = v["Disabled"]
                if func() then continue end
            end

            Radial.radialConfigOperations[i] = {}
            Radial.radialConfigOperations[i].name = v["Name"]
            Radial.radialConfigOperations[i].rconcommand = v["Function"]
            Radial.radialConfigOperations[i].exp = v["IsDraggable"]
            i = i + 1
        end

        i = 1
        for k,v in pairs(Radial.radialConfigOperations) do
            Radial.radialConfigOperations[i].exp = Radial.radialConfigOperations[i].exp or 0
            Radial.radialConfigOperations[i].cr = Radial.radialConfigOperations[i].cr or 0
            Radial.radialConfigOperations[i].cg = Radial.radialConfigOperations[i].cg or 255
            Radial.radialConfigOperations[i].cb = Radial.radialConfigOperations[i].cb or 255
            Radial.radialConfigOperations[i].cal = Radial.radialConfigOperations[i].cal or 180
            Radial.radialConfigOperations[i].ca = Radial.radialConfigOperations[i].ca or 0
            i = i + 1
        end
        
        if CLIENT then 
            Radial.CalculateMenuLayout()
        end

        current_operations = operations
    end)
end

local current_operations = {}

function ReturnAnimationPackAfter()

    local commands = {}
    local anims = {}

    local models = { 
        "models/hl2rp/female_01.mdl",
        "models/hl2rp/female_02.mdl",
        "models/hl2rp/female_03.mdl",
        "models/hl2rp/female_04.mdl",
        "models/hl2rp/female_06.mdl",
        "models/hl2rp/female_07.mdl",
        "models/humans/combine/female_01.mdl",
        "models/humans/combine/female_02.mdl",
        "models/humans/combine/female_03.mdl",
        "models/humans/combine/female_04.mdl",
        "models/humans/combine/female_06.mdl",
        "models/humans/combine/female_07.mdl",
        "models/humans/combine/female_08.mdl",
        "models/humans/combine/female_08.mdl",
        "models/humans/combine/female_09.mdl",
        "models/humans/combine/female_10.mdl",
        "models/humans/combine/female_11.mdl",
        "models/humans/combine/female_ga.mdl",
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
    }

    local models1 = { 
        "models/hl2rp/male_01.mdl",
        "models/hl2rp/male_02.mdl",
        "models/hl2rp/male_03.mdl",
        "models/hl2rp/male_04.mdl",
        "models/hl2rp/male_05.mdl",
        "models/hl2rp/male_06.mdl",
        "models/hl2rp/male_07.mdl",
        "models/hl2rp/male_08.mdl",
        "models/hl2rp/male_09.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
    }

    if !IsValid(LocalPlayer()) then return end

    if GAMEMODE.MetropoliceJobs[LocalPlayer():Team()] then
        anims = RISED.Animations["Metropolice"]
    elseif GAMEMODE.CombineJobs[LocalPlayer():Team()] then
        anims = RISED.Animations["Combine"]
    elseif table.HasValue(models, LocalPlayer():GetModel()) then
        anims = RISED.Animations["Models"]
    elseif table.HasValue(models1, LocalPlayer():GetModel()) then
        anims = RISED.Animations["Models1"]
    end

    for k,v in pairs(anims) do
        table.insert(commands, {
            ["Name"] = v["AnimationName"],
            ["IsDraggable"] = 0,
            ["Function"] = function()
                LocalPlayer():SetNWBool("anim", true)
                net.Start( "anim_ris_server" )
                net.WriteInt(v["AnimationID"], 32)
                net.WriteBool(v["AutoKill"])
                net.SendToServer()

                if !v["Simple"] then
                    timer.Simple(v["Delay"], function()
                        LocalPlayer():SetNWBool("anim", true)
                        net.Start( "anim_ris_server" )
                        net.WriteInt(v["SecondAnimationID"], 32)
                        net.WriteBool(v["SecondAutoKill"])
                        net.SendToServer()
                    end)
                end
            end
        })
    end
    return commands
end

function RebuildRadialMenu(operations)
    return function()
        Radial.radialConfigOperations = {}
        local i = 1
        for k,v in pairs(operations) do
            
            if isfunction(v["Disabled"]) then
                local func = v["Disabled"]
                if func() then continue end
            end

            Radial.radialConfigOperations[i] = {}
            Radial.radialConfigOperations[i].name = v["Name"]
            Radial.radialConfigOperations[i].rconcommand = v["Function"]
            Radial.radialConfigOperations[i].exp = v["IsDraggable"]
            i = i + 1
        end
        i = 1
        for k,v in pairs(Radial.radialConfigOperations) do
            Radial.radialConfigOperations[i].exp = Radial.radialConfigOperations[i].exp or 0
            Radial.radialConfigOperations[i].cr = Radial.radialConfigOperations[i].cr or 0
            Radial.radialConfigOperations[i].cg = Radial.radialConfigOperations[i].cg or 255
            Radial.radialConfigOperations[i].cb = Radial.radialConfigOperations[i].cb or 255
            Radial.radialConfigOperations[i].cal = Radial.radialConfigOperations[i].cal or 180
            Radial.radialConfigOperations[i].ca = Radial.radialConfigOperations[i].ca or 0
            i = i + 1
        end
        
        if CLIENT then 
            Radial.CalculateMenuLayout()
        end

        current_operations = operations
    end
end

--Основные #1
local otavoice_01 = {
    "Есть.",
    "Понял.",
    "Вас понял.",
    "Работаю.",
    "Готов.",
    "Жду указаний.",
    "Выдвигаюсь.",
    "Всё чисто в квадрате.",
    "Чисто.",
}
--Контакт #2
local otavoice_02 = {
    "Контакт!",
    "Есть контакт!",
    "Активный перехват.",
    "Видимость есть.",
    "Защита, сдерживаем!",
    "Подавление!",
    "В секторе опасность.",
    "Наступать, наступать!",
    "Сдерживание.",
}
--Ведение боя #3
local otavoice_03 = {
    "Один на земле!",
    "Нейтрализован.",
    "Прикрой!",
    "Есть попадание!",
    "Продолжаю зачистку!",
    "Отряд в атаке.",
    "Пошла граната!",
    "Ложись, ложись!",
    "Цель поражена, преследуем!",
}
--Кодовые #4
local otavoice_04 = {
    "Ехо.",
    "Молот.",
    "Ударник.",
    "Бритва.",
    "Хеликс.",
    "Судья.",
    "Лидер.",
    "Меч.",
    "Кинжал.",
}
--Лидер #5
local otavoice_05 = {
    "Цель в тени, прочесать местность.",
    "Внимательно, оставаться на чеку.",
    "Цель #1.",
    "Цель #1 переместилась в зону сдерживания.",
    "Команда стабилизации на позициях.",
    "Команда стабилизации контролирует сектор.",
    "Закругляйся с ним.",
    "Центр докладывает, возможно опасность.",
    "Движение! Проверить сектора.",
}
--Центру #6
local otavoice_06 = {
    "Сильное сопротивление.",
    "Прошу поддержки!",
    "Прошу поддержки резерва.",
    "Прошу воздушной поддержки.",
    "Центр, сектор захвачен!",
    "Центр, цель уничтожена.",
    "Нарушитель нейтрализован.",
    "Рота уничтожена!",
    "Цель #1 уничтожена.",
}
--Инфекция #7
local otavoice_07 = {
    "Дезинфекция.",
    "Контакт с паразитами.",
    "У нас свободные паразиты.",
    "Опасные формы жизни в секторе.",
    "Нежить.",
    "Нежить вступает.",
    "Мы в зоне инфекции.",
    "У нас вирусное загрязнение.",
    "Зараженный.",
}
--Прочее #8
local otavoice_08 = {
    "Заряды к бою.",
    "Приготовить оружие, неприятели.",
    "Приготовить оружие.",
    "Полная активность!",
    "Внимательно.",
    "Нет движения.",
    "Требуется мед. помощь.",
    "Требуются стимуляторы.",
    "Назначен лидером отделения.",
    "Нарушитель номер 1.",
    "В секторе опасные формы жизни.",
    "Чисто.",
    "Преследую.",
    "Убит.",
    "Кидаю гранату!",
    "Граната!",
    "Не вижу.",
    "Легко ранен.",
    "Рота.",
    "Уходим!",
    "Держать позицию.",
    "Гранаты к бою.",
    "Оружие к бою.",
    "Доложить об опасности.",
    "Рота готова, прочесываем.",
    "Не стрелять.",
    "Выполняй.",
}

start_operations = {
    {
        ["Name"] = "Денежные операции",
        ["IsDraggable"] = 0,
        ["Function"] = RebuildRadialMenu({
            {
                ["Name"] = "Бросить деньги",
                ["IsDraggable"] = 1,
                ["Function"] = function(value)
                    if value and value > 0 then
                        RunConsoleCommand("darkrp", "dropmoney", value)
                    else
                        Derma_StringRequest("", "Сколько хотите бросить денег?", nil, function(s)
                            RunConsoleCommand("darkrp", "dropmoney", s)
                        end)
                    end
                end
            },
            {
                ["Name"] = "Передать деньги",
                ["IsDraggable"] = 1,
                ["Function"] = function(value)
                    if value and value > 0 then
                        RunConsoleCommand("darkrp", "give", value)
                    else
                        Derma_StringRequest("", "Сколько хотите передать денег?", nil, function(s)
                            RunConsoleCommand("darkrp", "give", s)
                        end)
                    end
                end
            }
        })
    },
    {
        ["Name"] = "Режим разговора",
        ["IsDraggable"] = 0,
        ["Function"] = RebuildRadialMenu({
            {
                ["Name"] = "Шёпот",
                ["IsDraggable"] = 0,
                ["Function"] = function(value)
                    RunConsoleCommand("number_of_voice_system", "3")
                    RunConsoleCommand("rised_voice_type")
                end
            },
            {
                ["Name"] = "Обычная речь",
                ["IsDraggable"] = 0,
                ["Function"] = function(value)
                    RunConsoleCommand("number_of_voice_system", "1")
                    RunConsoleCommand("rised_voice_type")
                end
            },
            {
                ["Name"] = "Крик",
                ["IsDraggable"] = 0,
                ["Function"] = function(value)
                    RunConsoleCommand("number_of_voice_system", "2")
                    RunConsoleCommand("rised_voice_type")
                end
            }
        })
    },
    {
        ["Name"] = "Экипировка",
        ["Function"] = RebuildRadialMenu({
            {
                ["Name"] = "Выбросить оружие",
                ["Function"] = function(value)
                    RunConsoleCommand("darkrp", "dropweapon")
                end
            },
            {
                ["Name"] = "Маска",
                ["Disabled"] = function() return (!isMetropolice() && LocalPlayer():Team() != TEAM_REBELSPY01) end,
                ["Function"] = RebuildRadialMenu({
                    {
                        ["Name"] = "Снять маску",
                        ["Disabled"] = function() return !IsCombineMask() end,
                        ["Function"] = function(value)
                            RunConsoleCommand("combine_mask")
                            BuildRadialMenu(current_operations)
                        end
                    },
                    {
                        ["Name"] = "Надеть маску",
                        ["Disabled"] = function() return IsCombineMask() end,
                        ["Function"] = function(value)
                            RunConsoleCommand("combine_mask")
                            BuildRadialMenu(current_operations)
                        end
                    },
                    {
                        ["Name"] = "Включить вокодер",
                        ["Disabled"] = function() return IsCombineVocoder() or !IsCombineMask() end,
                        ["Function"] = function(value)
                            RunConsoleCommand("combine_vox")
                            BuildRadialMenu(current_operations)
                        end
                    },
                    {
                        ["Name"] = "Выключить вокодер",
                        ["Disabled"] = function() return !IsCombineVocoder() or !IsCombineMask() end,
                        ["Function"] = function(value)
                            RunConsoleCommand("combine_vox")
                            BuildRadialMenu(current_operations)
                        end
                    }
                })
            },
            {
                ["Name"] = "Включить маскировку",
                ["Disabled"] = function() return !IsRazor() or !IsGhosted() end,
                ["Function"] = function(value)
                    RunConsoleCommand("otaghost")
                    BuildRadialMenu(current_operations)
                end
            },
            {
                ["Name"] = "Выключить маскировку",
                ["Disabled"] = function() return !IsRazor() or IsGhosted() end,
                ["Function"] = function(value)
                    RunConsoleCommand("otaghost")
                    BuildRadialMenu(current_operations)
                end
            }
        })
    },
    {
        ["Name"] = "Запросы",
        ["Disabled"] = function() return !isMetropolice() end,
        ["Function"] = RebuildRadialMenu({
            {
                ["Name"] = "Выдача ОЛ",
                ["Disabled"] = function() return !isMetropoliceCanOL() end,
                ["Function"] = function(value)
                    RunConsoleCommand("say", "/add_ol")
                end
            },
            {
                ["Name"] = "Снятие ОЛ",
                ["Disabled"] = function() return !isMetropoliceCanOL() end,
                ["Function"] = function(value)
                    RunConsoleCommand("say", "/remove_ol")
                end
            },
            {
                ["Name"] = "Заступить на пост",
                ["Function"] = function(value)
                    RunConsoleCommand("say", "/mpf_getpost")
                end
            },
        })
    },
    {
        ["Name"] = "Объявления",
        ["Disabled"] = function() return !CanAnnouncement() end,
        ["Function"] = RebuildRadialMenu({
            {
                ["Name"] = "Рабочая фаза",
                ["Disabled"] = function() return !CanAnnouncementCityStatuses() and !CanAnnouncementWorkPhase() end,
                ["Function"] = function(value)
                    RunConsoleCommand("say", "/codeworkphase")
                end
            },
            {
                ["Name"] = "КОД: Красный",
                ["Disabled"] = function() return !CanAnnouncementCityStatuses() end,
                ["Function"] = function(value)
                    RunConsoleCommand("say", "/coder")
                end
            },
            {
                ["Name"] = "КОД: Оранжевый",
                ["Disabled"] = function() return !CanAnnouncementCityStatuses() end,
                ["Function"] = function(value)
                    RunConsoleCommand("say", "/codeo")
                end
            },
            {
                ["Name"] = "КОД: Желтый",
                ["Disabled"] = function() return !CanAnnouncementCityStatuses() end,
                ["Function"] = function(value)
                    RunConsoleCommand("say", "/codey")
                end
            },
            {
                ["Name"] = "КОД: Зеленый",
                ["Disabled"] = function() return !CanAnnouncementCityStatuses() end,
                ["Function"] = function(value)
                    RunConsoleCommand("say", "/codeg")
                end
            },
            {
                ["Name"] = "Биологическая угроза",
                ["Disabled"] = function() return !CanAnnouncementCityStatuses() end,
                ["Function"] = function(value)
                    RunConsoleCommand("say", "/codebiohazard")
                end
            },
            {
                ["Name"] = "Инспекционная фаза",
                ["Disabled"] = function() return !CanAnnouncementCityStatuses() end,
                ["Function"] = function(value)
                    RunConsoleCommand("say", "/codehome")
                end
            }
        })
    },
    {
        ["Name"] = "РП операции",
        ["Function"] = RebuildRadialMenu({
            {
                ["Name"] = "Повысить RP игроку",
                ["Function"] = function(value)
                    RunConsoleCommand("uprp")
                end
            },
            {
                ["Name"] = "Понизить RP игроку",
                ["Function"] = function(value)
                    RunConsoleCommand("downrp")
                end
            },
            {
                ["Name"] = "Принять отчет",
                ["Disabled"] = function() return !isMetropoliceCMD() end,
                ["Function"] = function(value)
                    RunConsoleCommand("rised_accept_report")
                end
            },
            {
                ["Name"] = "Описание персонажа",
                ["Function"] = function(value)
                    local ply = LocalPlayer()
                    local height = math.Round(ply:GetNWString("Character_Height", 170))
                    local constitution = ply:GetNWString("Character_Сonstitution", "Обычное")
                    local eye_color = string.lower(ply:GetNWString("Character_EyeColor", "Зеленый"))
                    local facial_hair = ply:GetNWInt("Character_FacialHair", 0)
                    local physical_description = ply:GetNWString("Character_PhysicalDescription", "")
            
                    if physical_description != "" then
                        physical_description = ", " .. physical_description
                    end
                    
                    if facial_hair != nil and facial_hair > 0 then
                        facial_hair = "присутствует"
                    else
                        facial_hair = "отсутствует"
                    end
            
                    local text = "Рост: " .. height .. " см., телосложение " .. constitution .. ", цвет глаз " .. eye_color .. ", растительность на лице " .. facial_hair .. physical_description
            
                    chat.AddText( Color( 255, 195, 0 ), ply, text)
                end
            },
            {
                ["Name"] = "Самоубийство",
                ["Function"] = function(value)
                    RunConsoleCommand("suicide")
                end
            }
        })
    },
    {
        ["Name"] = "Голосовые команды",
        ["Disabled"] = function() return !IsCombine() end,
        ["Function"] = RebuildRadialMenu({
            {
                ["Name"] = "Основные",
                ["Disabled"] = function() return !IsCombine() end,
                ["Function"] = RebuildRadialMenu(ReturnVoicesPack(otavoice_01))
            },
            {
                ["Name"] = "Контакт",
                ["Disabled"] = function() return !IsCombine() end,
                ["Function"] = RebuildRadialMenu(ReturnVoicesPack(otavoice_02))
            },
            {
                ["Name"] = "Ведение боя",
                ["Disabled"] = function() return !IsCombine() end,
                ["Function"] = RebuildRadialMenu(ReturnVoicesPack(otavoice_03))
            },
            {
                ["Name"] = "Кодовые",
                ["Disabled"] = function() return !IsCombine() end,
                ["Function"] = RebuildRadialMenu(ReturnVoicesPack(otavoice_04))
            },
            {
                ["Name"] = "Лидер",
                ["Disabled"] = function() return !IsCombine() end,
                ["Function"] = RebuildRadialMenu(ReturnVoicesPack(otavoice_05))
            },
            {
                ["Name"] = "Центру",
                ["Disabled"] = function() return !IsCombine() end,
                ["Function"] = RebuildRadialMenu(ReturnVoicesPack(otavoice_06))
            },
            {
                ["Name"] = "Инфекция",
                ["Disabled"] = function() return !IsCombine() end,
                ["Function"] = RebuildRadialMenu(ReturnVoicesPack(otavoice_07))
            },
            {
                ["Name"] = "Прочее",
                ["Disabled"] = function() return !IsCombine() end,
                ["Function"] = RebuildRadialMenu(ReturnVoicesPack(otavoice_08))
            },
        })
    },
    {
        ["Name"] = "Анимации",
        ["Function"] = RebuildRadialMenu(ReturnAnimationPack())
    },
    {
        ["Name"] = "Разное",
        ["Function"] = RebuildRadialMenu({
            {
                ["Name"] = "Остановить звуки",
                ["Function"] = function(value)
                    RunConsoleCommand("stopsound")
                end
            },
            {
                ["Name"] = "Убрать метки",
                ["Function"] = function(value)
                    local i = 0
                    while i <= 1000 do
                        i = i + 1
                        hook.Remove( "HUDPaint", "CallCPHudIconDraw"..i )
                        hook.Remove( "HUDPaint", "DeadCPHudIconDraw"..i )
                        hook.Remove( "HUDPaint", "DisturbCPHudIconDraw"..i )
                        hook.Remove( "RenderScreenspaceEffects", "DispachMovepoint01CPHudIconDraw" )
                        hook.Remove( "RenderScreenspaceEffects", "DispachClear01CPHudIconDraw" )
                        hook.Remove( "HUDPaint", "DestroyFieldCPHudIconDraw"..i )
                        hook.Remove( "HUDPaint", "CaptureSectorCPHudIconDraw"..i )
                
                        hook.Remove( "HUDPaint", "RubbishInfoMarkerHudIconDraw"..i )
                                
                        hook.Remove( "HUDPaint", "MeatInfoMarkerHudIconDraw"..i )
                        hook.Remove( "HUDPaint", "EnzymesInfoMarkerHudIconDraw"..i )
                        hook.Remove( "HUDPaint", "MeatTableInfoMarkerHudIconDraw"..i )
                        hook.Remove( "HUDPaint", "ResourceInfoMarkerHudIconDraw"..i )
                        hook.Remove( "HUDPaint", "EnzymesContainerInfoMarkerHudIconDraw"..i )
                                
                        hook.Remove( "HUDPaint", "MeatWorkInfoMarkerHudIconDraw"..i )
                                
                        hook.Remove( "HUDPaint", "RationWorkInfoMarkerHudIconDraw"..i )
                        hook.Remove( "HUDPaint", "RationFillInfoMarkerHudIconDraw"..i )
                                
                        hook.Remove( "HUDPaint", "DoctorInfoMarkerHudIconDraw"..i )
                        hook.Remove( "HUDPaint", "ExtraFoodInfoMarkerHudIconDraw"..i )
                        hook.Remove( "HUDPaint", "BarInfoMarkerHudIconDraw"..i )
                        hook.Remove( "HUDPaint", "FilmInfoMarkerHudIconDraw"..i )
                
                        hook.Remove( "HUDPaint", "ContrabandInfoMarkerHudIconDraw"..i )
                
                        hook.Remove( "HUDPaint", "CaptureSectorCPHudIconDraw"..i )
                    end
                    
                    hook.Remove( "HUDPaint", "HUDInfoMarker01" )
                    hook.Remove( "HUDPaint", "HUDInfoMarker02" )
                    hook.Remove( "HUDPaint", "HUDInfoMarker03" )
                    hook.Remove( "HUDPaint", "HUDInfoMarker04" )
                    hook.Remove( "HUDPaint", "HUDInfoMarker05" )
                    hook.Remove( "HUDPaint", "HUDInfoMarker06" )
                
                    hook.Remove( "HUDPaint", "ApartmentInfoMarkerHudIconDraw" )
                    hook.Remove( "HUDPaint", "NewPatientInfoMarkerHudIconDraw" )
                    hook.Remove( "HUDPaint", "NewCWUInfoMarkerHudIconDraw" )
                    hook.Remove( "HUDPaint", "MPF_PostMarker" )
                    hook.Remove( "HUDPaint", "TheifQuestMarkerHudIconDraw" )
                end
            },
            {
                ["Name"] = "Награды",
                ["Function"] = function(value)
                    RunConsoleCommand("say", "!zrew_main")
                end
            }
        })
    }
}

function Radial.MyRunConsoleCommand(func, value)
    if value then
        func(value)
    else
        func()
    end
end

local spacing

function Radial.CalculateMenuLayout()
    
    local angle = Radial.radialConfig["gbr-rotate"]
    
    local spa = 0
    if #Radial.radialConfigOperations == 3 then
        spa = 20
    elseif #Radial.radialConfigOperations <= 2 then
        spa = 60
    end
    
    spacing = Radial.radialConfig["gbr-spacing"]+spa
    
    local longestName = 0

    radialEntrySize = 360 / math.Max(table.getn(Radial.radialConfigOperations),2)
    
    for key,value in pairs(Radial.radialConfigOperations) do

        surface.SetFont(tostring(RadialDefaultFont))
        tw, th = surface.GetTextSize(value.name)
        
        if key == radialMenu_Operation then
            value.r = Radial.radialConfig["gbr-hr"]
            value.g = Radial.radialConfig["gbr-hg"]
            value.b = Radial.radialConfig["gbr-hb"]
            value.a = Radial.radialConfig["gbr-ha"]
        else
            value.r = Radial.radialConfig["gbr-dr"]
            value.g = Radial.radialConfig["gbr-dg"]
            value.b = Radial.radialConfig["gbr-db"]
            value.a = Radial.radialConfig["gbr-da"]
        end
        if tw > longestName then longestName = tw end
    end
    
    longestName = longestName + 8
    
    for key,value in pairs(Radial.radialConfigOperations) do

        value.minangle = angle - (radialEntrySize / 2) + spacing
        
        value.maxangle = angle + (radialEntrySize / 2) - spacing
        
        value.angle = (value.minangle + value.maxangle)/2
        
        if value.minangle < 0 then value.minangle = 360 + value.minangle; value.angle = 0 end
        
        tw, th = surface.GetTextSize(value.name)
        
        local inex = Radial.radialConfig["gbr-selectedinner"]
        local oute = Radial.radialConfig["gbr-selectedouter"]

        value.xpos = screenCenterX - ((Radial.radialConfig["gbr-menuradius"] + (Radial.radialConfig["gbr-menusplitterlength"]/2)) * math.sin((360 - angle) * (pi / 180)))
        value.ypos = screenCenterY - ((Radial.radialConfig["gbr-menuradius"] + (Radial.radialConfig["gbr-menusplitterlength"]/2)) * math.cos((360 - angle) * (pi / 180)))
        
        local inrad 	= Radial.radialConfig["gbr-menuradius"]
        local outrd		= Radial.radialConfig["gbr-menusplitterlength"] + Radial.radialConfig["gbr-menuradius"]
        local outrd2	= Radial.radialConfig["gbr-menusplitterlength"] * oute + Radial.radialConfig["gbr-menuradius"]
        
        value.xpos2 = screenCenterX - ((inrad*inex)+outrd2) * 0.5 * math.sin((360 - angle) * (pi / 180))
        value.ypos2 = screenCenterY - ((inrad*inex)+outrd2) * 0.5 * math.cos((360 - angle) * (pi / 180))
        
        value.menusplitxinner = screenCenterX - (inrad * math.sin((360 - value.minangle) * (pi / 180)))
        value.menusplityinner = screenCenterY - (inrad * math.cos((360 - value.minangle) * (pi / 180)))
        value.menusplitxouter = screenCenterX - (outrd * math.sin((360 - value.minangle) * (pi / 180)))
        value.menusplityouter = screenCenterY - (outrd * math.cos((360 - value.minangle) * (pi / 180)))
        
        value.menusplitxinner2= screenCenterX - (inrad * math.sin((360 - value.maxangle) * (pi / 180)))
        value.menusplityinner2= screenCenterY - (inrad * math.cos((360 - value.maxangle) * (pi / 180)))
        value.menusplitxouter2= screenCenterX - (outrd * math.sin((360 - value.maxangle) * (pi / 180)))
        value.menusplityouter2= screenCenterY - (outrd * math.cos((360 - value.maxangle) * (pi / 180)))
        
        value.menusplitxinner3 = screenCenterX - ((inrad*inex) * math.sin((360 - value.minangle) * (pi / 180)))
        value.menusplityinner3 = screenCenterY - ((inrad*inex) * math.cos((360 - value.minangle) * (pi / 180)))
        value.menusplitxinner4 = screenCenterX - ((inrad*inex) * math.sin((360 - value.maxangle) * (pi / 180)))
        value.menusplityinner4 = screenCenterY - ((inrad*inex) * math.cos((360 - value.maxangle) * (pi / 180)))
        
        value.menusplitxouter3 = screenCenterX - (outrd2 * math.sin((360 - value.minangle) * (pi / 180)))
        value.menusplityouter3 = screenCenterY - (outrd2 * math.cos((360 - value.minangle) * (pi / 180)))
        value.menusplitxouter4 = screenCenterX - (outrd2 * math.sin((360 - value.maxangle) * (pi / 180)))
        value.menusplityouter4 = screenCenterY - (outrd2 * math.cos((360 - value.maxangle) * (pi / 180)))
                    
        tw, th = surface.GetTextSize(value.name)
        
        value.labelwidth = longestName
        value.labelheight = th

        angle = angle + radialEntrySize
    end
end

Radial.CalculateMenuLayout()

function Radial.ShowRadialMenu()

    if LocalPlayer():GetActiveWeapon() and LocalPlayer():GetActiveWeapon():GetClass() == "gmod_tool" then
        -- Let the gamemode decide whether we should open or not..
        if ( !hook.Call( "ContextMenuOpen", self ) ) then return end

        if ( IsValid( g_ContextMenu ) && !g_ContextMenu:IsVisible() ) then
            g_ContextMenu:Open()
            menubar.ParentTo( g_ContextMenu )
        end

        hook.Call( "ContextMenuOpened", self )
    else
        BuildRadialMenu(start_operations)
        
        clickedon = ""

        screenCenterX = ScrW() / 2
        screenCenterY = ScrH() / 2

        Radial.radialMenuOpen = true
        gui.EnableScreenClicker(true)
        return false
    end

end

function Radial.HideRadialMenu()
    if Radial.settingsPanelShown then return end
    
    if radialMenu_Operation > 0 and clickedon ~= radialMenu_Operation then
        Radial.MyRunConsoleCommand(Radial.radialConfigOperations[radialMenu_Operation].rconcommand)
        if Radial.radialConfig["gbr-enablesounds"] == 1 then
            sound.Play( "ui/buttonclick.wav" , LocalPlayer():GetShootPos(), 60, 100, 0.2)
        end
        radialMenu_Operation = 0
    end
    
    if Radial.radialConfig["gbr-onclose"] ~= nil and Radial.radialConfig["gbr-onclose"] ~= "" then
        Radial.MyRunConsoleCommand(Radial.radialConfig["gbr-onclose"])
    end
    
    clickedon = ""
    dragging = false
    
    gui.EnableScreenClicker(false)

    Radial.radialMenuOpen = false
    BuildRadialMenu(start_operations)
end

local DrawText = surface.DrawText
local SetTextColor = surface.SetTextColor
local SetFont = surface.SetFont
local SetTextPos = surface.SetTextPos
local PopModelMatrix = cam.PopModelMatrix
local PushModelMatrix = cam.PushModelMatrix

local function drawRotatedText(text, x, y, xScale, yScale, angle, centered)
    local matrix = Matrix()
    local matrixAngle = Angle(0, 0, 0)
    local matrixScale = Vector(0, 0, 0)
    local matrixTranslation = Vector(0, 0, 0)

    matrixAngle.y = math.floor( angle )
    matrix:SetAngles(matrixAngle)
    
    matrixTranslation.x = math.floor( x )
    matrixTranslation.y = math.floor( y )

    if centered	then
        local sizeX, sizeY = surface.GetTextSize( text )
        sizeX = sizeX * xScale
        sizeY = sizeY * yScale

        matrixTranslation.x = math.floor( matrixTranslation.x - math.sin( math.rad( -angle + 90 ) ) * sizeX / 2 - math.sin( math.rad( -angle ) ) * sizeY / 2)
        matrixTranslation.y = math.floor( matrixTranslation.y - math.cos( math.rad( -angle + 90 ) ) * sizeX / 2 - math.cos( math.rad( -angle ) ) * sizeY / 2)
    end
    matrix:SetTranslation(matrixTranslation)

    matrixScale.x = xScale
    matrixScale.y = yScale
    matrix:Scale(matrixScale)
    
    SetTextPos(0, 0)
    
    PushModelMatrix(matrix)
        DrawText(text)
    PopModelMatrix()
end

function draw.Circle( x, y, radius, seg )
    local cir = {}

    table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
    for i = 0, seg do
        local a = math.rad( ( i / seg ) * -360 )
        table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
    end

    local a = math.rad( 0 )
    table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

    surface.DrawPoly( cir )
end

function Radial.DrawRadialMenuItem(itemText, itemXpos, itemYpos, labelWidth, labelHeight, textColor, itemAng, fieldWidth)
    if not itemText then return end
    
    if Radial.radialConfig["gbr-font"] == nil or Radial.radialConfig["gbr-font"] == "" then return end
    SetFont( Radial.radialConfig["gbr-font"] )
    local ang = 0

    if Radial.radialConfig["gbr-rotatetext"] == 1 then
        ang = math.NormalizeAngle( itemAng - 180 )
        if ang >= 89 or ang <= -89 then ang = ang - 180 end
    end

    local xScale = Radial.radialConfig["gbr-fontscale"]
    local yScale = Radial.radialConfig["gbr-fontscale"]

    local sizeX, sizeY = surface.GetTextSize( itemText )
    
    if Radial.radialConfig["gbr-clampx"] == 1 then
        xScale = math.Clamp((fieldWidth / sizeX) * 0.2,0,xScale)
        if Radial.radialConfig["gbr-clampy"] == 1 then
            yScale = xScale
        end
    end
    
    local itemX = itemXpos
    local itemY = itemYpos

    if Radial.radialConfig["gbr-outline"] == 1 then
        SetTextColor( Color(0, 0, 0, 255) )
        drawRotatedText(itemText, itemX+1, itemY+1, xScale, yScale, ang, true)
        drawRotatedText(itemText, itemX+1, itemY-1, xScale, yScale, ang, true)
        drawRotatedText(itemText, itemX-1, itemY+1, xScale, yScale, ang, true)
        drawRotatedText(itemText, itemX-1, itemY-1, xScale, yScale, ang, true)
    end
    SetTextColor( textColor )
    drawRotatedText(itemText, itemX, itemY, xScale, yScale, ang, true)
end

local ft = VGUIFrameTime()
function Radial.DrawRadialMenu(paint)

    radialMenu_Operation = 0
    if not Radial.radialMenuOpen then return end
    local dt = (VGUIFrameTime() - ft)*33
    ft = VGUIFrameTime()
    
    if Radial.settingsPanelShown and (Radial.selectedListTool ~= nil or Radial.settingshovertool ~= nil) then
        radialMenu_Operation = Radial.selectedListTool or Radial.settingshovertool
        Radial.settingshovertool = nil
    elseif dragging then
        radialMenu_Operation = dl
    elseif math.Dist(screenCenterX, screenCenterY, gui.MouseX(), gui.MouseY()) > Radial.radialConfig["gbr-menudeadzone"] then

        local radialSelectAngle = 360 - (math.deg(math.atan2(gui.MouseX() - screenCenterX, gui.MouseY() - screenCenterY)) + 180)
        
        local es = (radialEntrySize/2) - spacing
        local sa = radialSelectAngle
        
        for key,value in pairs(Radial.radialConfigOperations) do
            local da = math.abs((value.angle-sa + 180) % 360 - 180)
            if da < es then
                radialMenu_Operation = key
            end
        end			
    else
        radialMenu_Operation = 0
    end
    
    -- Draw the tool menu entries
    local ch = 0
    for key,value in pairs(Radial.radialConfigOperations) do
        ch = ch + 1
        if not value == nil then continue end
        local sp = {
            {x = value.menusplitxouter2, y = value.menusplityouter2},
            {x = value.menusplitxinner2, y = value.menusplityinner2},
            {x = value.menusplitxinner, y = value.menusplityinner},
            {x = value.menusplitxouter, y = value.menusplityouter},
        }
        draw.NoTexture()
        
        local colspeed = Radial.radialConfig["gbr-colorspeed"]*dt
        
        if key == radialMenu_Operation then
            -- This is the selected tool
            -- Draw the splitter-poly, if the user wants to
            sp = {
                {x = value.menusplitxouter4, y = value.menusplityouter4},
                {x = value.menusplitxinner4, y = value.menusplityinner4},
                {x = value.menusplitxinner3, y = value.menusplityinner3},
                {x = value.menusplitxouter3, y = value.menusplityouter3},
            }
            value.r = Lerp( colspeed, value.r, Radial.radialConfig["gbr-hr"] )
            value.g = Lerp( colspeed, value.g, Radial.radialConfig["gbr-hg"] )
            value.b = Lerp( colspeed, value.b, Radial.radialConfig["gbr-hb"] )			
            value.a = Lerp( colspeed, value.a, Radial.radialConfig["gbr-ha"] )			
        else
            if value.ca == 1 then
                value.r = Lerp( colspeed, value.r, value.cr )
                value.g = Lerp( colspeed, value.g, value.cg )
                value.b = Lerp( colspeed, value.b, value.cb )
                value.a = Lerp( colspeed, value.a, value.cal )
            else
                value.r = Lerp( colspeed, value.r, Radial.radialConfig["gbr-dr"] )
                value.g = Lerp( colspeed, value.g, Radial.radialConfig["gbr-dg"] )
                value.b = Lerp( colspeed, value.b, Radial.radialConfig["gbr-db"] )
                value.a = Lerp( colspeed, value.a, Radial.radialConfig["gbr-da"] )
            end
        end

        surface.SetDrawColor(value.r, value.g, value.b, value.a)
        value.visualVertexData = value.visualVertexData or sp

        local animSpeed = Radial.radialConfig["gbr-animspeed"]*dt
        value.visualVertexData = {
            { x = Lerp( animSpeed, value.visualVertexData[1].x, sp[1].x ), y = Lerp( animSpeed, value.visualVertexData[1].y, sp[1].y ) },
            { x = Lerp( animSpeed, value.visualVertexData[2].x, sp[2].x ), y = Lerp( animSpeed, value.visualVertexData[2].y, sp[2].y ) },
            { x = Lerp( animSpeed, value.visualVertexData[3].x, sp[3].x ), y = Lerp( animSpeed, value.visualVertexData[3].y, sp[3].y ) },
            { x = Lerp( animSpeed, value.visualVertexData[4].x, sp[4].x ), y = Lerp( animSpeed, value.visualVertexData[4].y, sp[4].y ) },
        }
        
        local vvd = value.visualVertexData
        
        local tang = Vector(vvd[4].x-vvd[1].x,vvd[4].y-vvd[1].y,0):Angle().y %360 - 180			

        surface.DrawPoly(vvd)

        local posX = (math.floor(vvd[ 1 ].x) + math.floor(vvd[ 2 ].x)) / 2
        local posY = (math.floor(vvd[ 1 ].y) + math.floor(vvd[ 2 ].y)) / 2
        local pos2X = (math.floor(vvd[ 3 ].x) + math.floor(vvd[ 4 ].x)) / 2
        local pos2Y = (math.floor(vvd[ 3 ].y) + math.floor(vvd[ 4 ].y)) / 2

        local fposX = (posX + pos2X) / 2
        local fposY = (posY + pos2Y) / 2
        
        local fieldWidth = 0
        if Radial.radialConfig["gbr-clampx"] == 1 then
            fieldWidth = (Vector( vvd[3].x - vvd[2].x, vvd[3].y - vvd[2].y, 0 ):Length() + Vector( vvd[1].x - vvd[4].x, vvd[1].y - vvd[4].y, 0 ):Length()) * 2
        end
        
        if paint then
            Radial.DrawRadialMenuItem(value.name, fposX, fposY, value.labelwidth, value.labelheight, Color(Radial.radialConfig["gbr-tr"], Radial.radialConfig["gbr-tg"], Radial.radialConfig["gbr-tb"], Radial.radialConfig["gbr-ta"] ), tang, fieldWidth)
        end
    end
    
    if dragging then
        local function sign (xy,w)
            if xy > w then return w elseif xy < -w then return -w else return 0 end
        end
    
        local mx = gui.MouseX()
        local my = gui.MouseY()
        local dx = dip.x
        local dy = dip.y
        local ddx= mx-dx
        local ddy= my-dy
        local ax = 1
        local add = 0
        local cmd = Radial.radialConfigOperations[dl].rconcommand
        local lst = st
        st = math.Clamp(math.floor(math.abs(ddx)/24),0,10000)
        if Radial.radialConfig["gbr-enablesounds"] == 1 then
            if st > lst then 
                sound.Play( "buttons/lightswitch2.wav" , LocalPlayer():GetShootPos(), 60, 255, 0.3)
            elseif st < lst then
                sound.Play( "buttons/blip1.wav" , LocalPlayer():GetShootPos(), 60, 200, 0.1)
            end
        end
        if paint then
            surface.SetDrawColor(Color(0,0,0,255))
            surface.DrawOutlinedRect(dx-4,dy-4,8,8)
            if sign(ddy,4) ~= 0 then
                if sign(ddy,1) == 1 then add = 1 end
                surface.DrawLine(dx,dy+sign(ddy,4),dx,my+add)
                surface.DrawLine(dx-1,dy+sign(ddy,4),dx-1,my+add)
                ax = 0
            end
            surface.DrawLine(dx+4*sign(ddx,1)*ax,my,mx,my)
            
            surface.SetFont( "DermaDefault" )
            surface.SetTextColor( 0, 0, 0, 255 )
            
            for j = 1, st-1, 1 do
                local sx = dx+24*j*sign(ddx,1)
                local sd = sign(ddy,-1)
                local sy = my+(7+add)*sd
                local txt = j+1
                surface.DrawLine(sx,my+add*sd,sx,sy)
                local tsx, tsy = surface.GetTextSize(txt)
                surface.SetTextPos(sx-tsx/2, sy-tsy/2 + 6*sd) 
                surface.DrawText(txt)
            end
            
            local tx = 6
            local ty = 7
            
            surface.SetTextPos(dx+tx+1, dy-ty+1) 
            surface.DrawText(tostring(st))
            surface.SetTextPos(dx+tx+1, dy-ty-1) 
            surface.DrawText(tostring(st))
            surface.SetTextPos(dx+tx-1, dy-ty+1) 
            surface.DrawText(tostring(st))
            surface.SetTextPos(dx+tx-1, dy-ty-1) 
            surface.DrawText(tostring(st))
            
            surface.SetTextColor( Radial.radialConfig["gbr-hr"], Radial.radialConfig["gbr-hg"], Radial.radialConfig["gbr-hb"], 255 )
            surface.SetTextPos(dx+tx, dy-ty) 
            surface.DrawText(tostring(st))
            
            surface.SetDrawColor(Color(Radial.radialConfig["gbr-hr"], Radial.radialConfig["gbr-hg"], Radial.radialConfig["gbr-hb"],180))
            surface.DrawRect(dx-3,dy-3,6,6)
        end
    end
    
    if Radial.radialConfig["gbr-menushowtraceline"] == 1 and paint then
        surface.SetDrawColor(255, 255, 255, 255)
        local mx, my
        if dragging then
            mx, my = dip.x, dip.y
        else
            mx, my = gui.MouseX() , gui.MouseY() 
        end
        local ang = Vector(mx - screenCenterX, my - screenCenterY, 0):Angle().y

        local dist = math.min( Vector( screenCenterX, screenCenterY, 0 ):Distance( Vector( mx, my, 0) ), Radial.radialConfig["gbr-menudeadzone"]-20)

        local x = screenCenterX - (dist * math.sin((270-ang) * (pi / 180)))
        local y = screenCenterY - (dist * math.cos((270-ang) * (pi / 180)))

        surface.SetTexture( tex )
        surface.DrawTexturedRectRotated( x, y, 32, 32, 225-ang )
    end
end

local function drawmenu()
    Radial.DrawRadialMenu(true)
end
local function calcmenu()
    Radial.DrawRadialMenu(false)
end

hook.Add("HUDPaint", "Radial.DrawRadialMenu", drawmenu)
hook.Add("Think", "Radial.DrawRadialMenu", calcmenu) --makes it a bit smoother
local ld = false
local rd = false

function Radial.CaptureMouseClicks()

    if not Radial.radialMenuOpen then return end
    
    lld = ld
    lrd = rd
    ld = input.IsMouseDown( MOUSE_LEFT )
    rd = input.IsMouseDown( MOUSE_RIGHT )
    
    LDown = lld ~= ld and ld
    RDown = lrd ~= rd and rd

    if LDown then
        if not Radial.settingsPanelShown and Radial.radialMenuOpen then
            clickedon = radialMenu_Operation
            if radialMenu_Operation ~= nil and radialMenu_Operation ~= 0 then
                if Radial.radialConfigOperations[radialMenu_Operation].exp == 1 then
                    dragging = true
                    st = 0
                    dl = radialMenu_Operation
                    dip = {x = gui.MouseX(), y = gui.MouseY()}
                else
                    Radial.MyRunConsoleCommand(Radial.radialConfigOperations[radialMenu_Operation].rconcommand)
                    if Radial.radialConfig["gbr-enablesounds"] == 1 then
                        sound.Play( "ui/buttonclickrelease.wav" , LocalPlayer():GetShootPos(), 60, 100, 0.1)
                    end
                end
            end
        end
        return true
    end
end

local cando = true
function Radial.CaptureMouseRelease()
    if not input.IsMouseDown( MOUSE_LEFT ) and dragging then
        gui.SetMousePos(dip.x, dip.y)
        local cmd = Radial.radialConfigOperations[dl].rconcommand
        
        Radial.MyRunConsoleCommand(cmd, st)
        
        if Radial.radialConfig["gbr-enablesounds"] == 1 then
            sound.Play( "ui/buttonclickrelease.wav" , LocalPlayer():GetShootPos(), 60, 100, 0.1)
        end
        dragging = false
    end
end

hook.Add("Think", "Radial.CaptureMouseClicks", Radial.CaptureMouseClicks)
hook.Add("Think", "Radial.CaptureMouseRelease", Radial.CaptureMouseRelease)

hook.Add("OnContextMenuOpen", "Radial.ShowRadialMenu", Radial.ShowRadialMenu)
hook.Add("OnContextMenuClose", "Radial.HideRadialMenu", Radial.HideRadialMenu)

concommand.Add("+gb-radial", Radial.ShowRadialMenu)
concommand.Add("-gb-radial", Radial.HideRadialMenu)
