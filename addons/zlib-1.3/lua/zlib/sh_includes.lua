-- "addons\\zlib-1.3\\lua\\zlib\\sh_includes.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    zlib - (SH) Includes
    Developed by Zephruz
]]

--[[Load Includes]]
local files, dirs = file.Find("zlib/includes/*", "LUA")

for k,v in pairs(files) do
    zlib.util:IncludeByPath(v, "includes/")
end