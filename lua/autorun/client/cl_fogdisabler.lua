-- "lua\\autorun\\client\\cl_fogdisabler.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

hook.Add("Initialize","SetFog", function() 
	render.FogMode( 1 )
	render.FogStart( 500 )
	render.FogEnd( 1000 )
	render.FogMaxDensity( 1 )
end)