-- "addons\\zlib-1.3\\lua\\zlib\\includes\\stringrandom.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
	Snippet pulled from: https://gist.github.com/haggen/2fd643ea9a261fea2094
]]

local charset = {}

-- qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890
for i = 48,  57 do table.insert(charset, string.char(i)) end
for i = 65,  90 do table.insert(charset, string.char(i)) end
for i = 97, 122 do table.insert(charset, string.char(i)) end

function string.random(length)
	if length < 0 then return "" end
	
	math.randomseed(os.time() + (SysTime()%1)^5)
	
	return string.random(length - 1) .. charset[math.random(1, #charset)]
end
