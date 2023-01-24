-- "addons\\ulib\\lua\\autorun\\ulib_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
-- Short and sweet
if SERVER then
	include( "ulib/init.lua" )
else
	include( "ulib/cl_init.lua" )
end
