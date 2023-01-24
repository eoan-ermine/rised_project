-- "addons\\ulx\\lua\\ulib\\modules\\ulx_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if SERVER then
	include( "ulx/init.lua" )
else
	include( "ulx/cl_init.lua" )
end
