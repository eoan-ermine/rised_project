-- "addons\\zrewards\\lua\\autorun\\zrewards_auto.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards
    Developed by Zephruz
]]

zrewards = (zrewards or {})
zrewards._version = "v2.5.3b"

function zrewards:ConsoleMessage(...)
    MsgC(Color(125,255,0), "[ZRewards] ", Color(255,255,255), ...)
    Msg("\n")
end

function zrewards:Init()
    if (zlib) then
        zlib.util:IncludeByPath("sh_init.lua", "zrewards/")

        zrewards:ConsoleMessage("Loaded successfully!")
    else
        zrewards:ConsoleMessage("ZLib not loaded, cannot load ZRewards.")
    end
end

--[[
    Includes
]]
local preReqs = {
    ["zlib"] = {
        autoRunFile = "autorun/zlib_auto.lua",
        notFoundMsg = "ZLib is not installed, please download it from here: https://github.com/zephruz/zlib/releases (Error: %s)",
        tbl = zlib,
        preventLoad = true
    }
}

local function loadAddon(name, autoRunFile, addonTable)
	if (addonTable == nil) then
		return pcall(include, autoRunFile) 
	end

	return true
end

for k,v in pairs(preReqs) do
    local res, errMsg = loadAddon(k, v.autoRunFile, v.tbl)

    if !(res) then
        zrewards:ConsoleMessage(string.format(v.notFoundMsg, errMsg))

        if (v.preventLoad) then
            return
        end
    end
end

--[[
    ZLib Addon Registration
]]
local ZLIB_ZREWADDON = zlib.addons:Register("zrewards")
ZLIB_ZREWADDON:SetName("ZRewards 2")
ZLIB_ZREWADDON:SetDescription("Rewards addon.")
ZLIB_ZREWADDON:SetTable(zrewards)
ZLIB_ZREWADDON:SetAddonID(5886)

--[[
    Initialize ZRewards
]]
zrewards:Init()

hook.Add("zlib.Loaded", "zrewards.zlib.Loaded", 
function() 
    zrewards:Init() 
end)