-- "addons\\zrewards\\lua\\zrewards\\vgui\\sh_menus.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) MENUS
    Developed by Zephruz
]]

zrewards.vgui.menus = (zrewards.vgui.menus or {})

--[[
    zrewards.vgui:RegisterMenu(name [string], data [table])
]]
function zrewards.vgui:RegisterMenu(name, data)
    local menuTbl = {}

    zlib.object:SetMetatable("zrewards.Menu", menuTbl)

    menuTbl:SetName(name)

    if (data) then
        for k,v in pairs(data) do
            menuTbl:setData(k,v)
        end
    end

    self.menus[name] = menuTbl

    return self.menus[name]
end

--[[
    zrewards.vgui:GetMenu(name [string])
]]
function zrewards.vgui:GetMenu(name)
    return self.menus[name]
end

--[[
    zrewards.vgui:OpenMenu(ply [player], menuName [string])
]]
function zrewards.vgui:OpenMenu(ply, menuName)
    local menuTbl = self:GetMenu(menuName)

    if (!IsValid(ply) or !menuTbl) then return end

    netPoint:SendCompressedNetMessage("zrewards.vgui.OpenMenu", ply, {menuName = menuName})
end

--[[
    zrewards.vgui:GetAllMenus()
]]
function zrewards.vgui:GetAllMenus()
    return self.menus
end

--[[
    Menu Metastructure
]]
local menuMeta = zlib.object:Create("zrewards.Menu", {})

menuMeta:setData("Name", "MENU.NAME", {})
menuMeta:setData("OpenOnSpawn", false, {})
menuMeta:setData("ChatCommands", {}, {
    postSet = function(s,val,oldVal)
        zlib.cmds:RegisterChat(val, nil,
        function(ply)
            zrewards.vgui:OpenMenu(ply, s:GetName())
        end)
    end,
})
menuMeta:setData("ConsoleCommands", {}, {
    postSet = function(s,val,oldVal)
        zlib.cmds:RegisterConsole(val, function()
            s:Init()
        end)
    end,
})

function menuMeta:Init() end

function menuMeta:forceOpen(ply)
    zrewards.vgui:ForceOpenMenu(ply, self:GetName())
end

--[[
    Includes
]]

-- Menus
local files, dirs = file.Find("zrewards/vgui/menus/zrew_menu_*", "LUA")

for k,v in pairs(files) do
    zlib.util:IncludeByPath(v, "menus/")
end

--[[
    Hooks
]]
if (CLIENT) then
    hook.Add("InitPostEntity", "zrewards.vgui[InitPostEntity]",
    function(ply)
        for k,v in pairs(zrewards.vgui:GetAllMenus()) do
            if (v:GetOpenOnSpawn()) then
                timer.Simple(1,
                function()
                    if (v.OnOpenOnSpawn && v:OnOpenOnSpawn()) then
                        v:Init()
                    end
                end)
            end
        end
    end)
end

--[[
    Networking
]]
if (SERVER) then
    util.AddNetworkString("zrewards.vgui.OpenMenu")
end

if (CLIENT) then
    net.Receive("zrewards.vgui.OpenMenu",
    function()
        local data, dataBInt = netPoint:DecompressNetData()

        if !(data) then return end

        local menuTbl = zrewards.vgui:GetMenu(data.menuName)

        if (menuTbl) then
            menuTbl:Init()
        end
    end)
end