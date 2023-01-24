-- "addons\\bricks-crafting\\lua\\darkrp_modules\\brickscrafting\\sh_brickscrafting_darkrp.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[ ADDS ENTITIES TO F4 MENU ]]--
hook.Add( "BRCS.ConfigLoaded", "BRCS.ConfigLoaded.DarkRP", function()
    for k, v in pairs( BRICKSCRAFTING.CONFIG.Crafting ) do
        DarkRP.createEntity( v.Name, {
            ent = "brickscrafting_bench_" .. string.Replace( string.lower( k ), " ", "" ),
            model = v.model,
            price = 150,
            max = 1,
            cmd = "buycrafting_bench_" .. string.Replace( string.lower( k ), " ", "" ),
            category = "Crafting"
        })
    end
end )
	
DarkRP.createCategory {
    name = "Crafting",
    categorises = "entities",
    startExpanded = true,
    color = Color( 125, 125, 125 ),
    canSee = function(ply) return true end,
    sortOrder = 1
}
