-- "lua\\autorun\\ez_menu.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

hook.Add("PopulateToolMenu","EZ_MENU",function()
spawnmenu.AddToolMenuOption("Options","#ez_swep.swep.settings","EZ_Settings","#ez_swep.settings","","",function(pnl)
pnl:ClearControls()
pnl:AddControl( "CheckBox", { Label = "#ez_swep.no.recoil", Command = "sk_ez_no_recoil" } )
pnl:AddControl( "CheckBox", { Label = "#ez_swep.no.bullet.spread", Command = "sk_ez_no_bullet_spread" } )
pnl:AddControl( "CheckBox", { Label = "#ez_swep.infinite.ammo", Command = "sk_ez_infinite_ammo" } )
pnl:AddControl( "Slider", { Label = "#ez_swep.ar2.dmg", Type = "Integer", Command = "sk_ez_proto_ar2_dmg", Min = "0", Max = "100" } )
pnl:AddControl( "Slider", { Label = "#ez_swep.ar2.bullet.num", Type = "Integer", Command = "sk_ez_proto_ar2_num", Min = "0", Max = "10" } )
pnl:AddControl( "Slider", { Label = "#ez_swep.ar2.ball.explode.time", Type = "Integer", Command = "sk_ez_proto_ar2_ball_explode_time", Min = "0", Max = "100" } )
pnl:AddControl( "Slider", { Label = "#ez_swep.mp5k.dmg", Type = "Integer", Command = "sk_ez2_mp5k_dmg", Min = "0", Max = "100" } )
pnl:AddControl( "Slider", { Label = "#ez_swep.pulse.pistol.dmg", Type = "Integer", Command = "sk_ez2_pulse_pistol_dmg", Min = "0", Max = "100" } )
pnl:AddControl( "Button", { Label = "#ez_swep.reset.commands", Command = "sk_ez_no_recoil 0 \n sk_ez_no_bullet_spread 0 \n sk_ez_infinite_ammo 0 \n sk_ez_proto_ar2_dmg 16 \n sk_ez_proto_ar2_num 2 \n sk_ez2_mp5k_dmg 8 \n sk_ez2_pulse_pistol_dmg 15 \n sk_ez_proto_ar2_ball_explode_time 1" } )
end)
end)