-- "addons\\rised_permissions\\lua\\autorun\\rp_spawnprops.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

Prop_civil = {}

Prop_building = {}

Prop_combine = {}

Prop_rebel = {}

Prop_realistic = {}

local z, x, u, j, o, e, t, g, s = 1, 1, 1, 1, 1, 1, 1, 1, 1

Prop_building[j] = "models/props_phx/construct/metal_plate1.mdl"
j = j + 1
Prop_building[j] = "models/props_phx/construct/metal_plate1_tri.mdl"
j = j + 1
Prop_building[j] = "models/props_phx/construct/metal_plate1x2.mdl"
j = j + 1
Prop_building[j] = "models/props_phx/construct/metal_plate1x2_tri.mdl"
j = j + 1
Prop_building[j] = "models/props_phx/construct/metal_plate2x2.mdl"
j = j + 1
Prop_building[j] = "models/props_phx/construct/metal_plate2x2_tri.mdl"
j = j + 1
Prop_building[j] = "models/props_phx/construct/metal_tube.mdl"
j = j + 1
Prop_building[j] = "models/props_phx/construct/metal_angle360.mdl"
j = j + 1
Prop_building[j] = "models/props_phx/construct/metal_angle180.mdl"
j = j + 1
Prop_building[j] = "models/props_phx/construct/metal_angle90.mdl"
j = j + 1
Prop_building[j] = "models/props_phx/construct/metal_wire1x1.mdl"
j = j + 1
Prop_building[j] = "models/props_phx/construct/metal_wire1x1x1.mdl"
j = j + 1
Prop_building[j] = "models/props_phx/construct/metal_wire1x2.mdl"
j = j + 1
Prop_building[j] = "models/props_phx/construct/metal_wire2x2.mdl"
j = j + 1
Prop_building[j] = "models/props_phx/construct/glass/glass_plate1x1.mdl"
j = j + 1
Prop_building[j] = "models/props_phx/construct/glass/glass_plate2x2.mdl"
j = j + 1
Prop_building[j] = "models/props_phx/construct/windows/window1x1.mdl"
j = j + 1
Prop_building[j] = "models/props_phx/construct/windows/window1x2.mdl"
j = j + 1
Prop_building[j] = "models/props_phx/construct/windows/window2x2.mdl"
j = j + 1
Prop_building[j] = "models/hunter/blocks/cube025x025x025.mdl"
j = j + 1
Prop_building[j] = "models/hunter/blocks/cube025x05x025.mdl"
j = j + 1
Prop_building[j] = "models/hunter/blocks/cube025x1x025.mdl"
j = j + 1
Prop_building[j] = "models/hunter/blocks/cube025x150x025.mdl"
j = j + 1
Prop_building[j] = "models/hunter/blocks/cube025x2x025.mdl"
j = j + 1
Prop_building[j] = "models/hunter/blocks/cube05x05x025.mdl"
j = j + 1
Prop_building[j] = "models/hunter/blocks/cube05x1x025.mdl"
j = j + 1
Prop_building[j] = "models/hunter/blocks/cube05x2x025.mdl"
j = j + 1
Prop_building[j] = "models/hunter/blocks/cube05x05x05.mdl"
j = j + 1
Prop_building[j] = "models/hunter/blocks/cube05x1x05.mdl"
j = j + 1
Prop_building[j] = "models/hunter/blocks/cube05x105x05.mdl"
j = j + 1
Prop_building[j] = "models/hunter/blocks/cube05x2x05.mdl"
j = j + 1
Prop_building[j] = "models/hunter/blocks/cube075x075x075.mdl"
j = j + 1
Prop_building[j] = "models/hunter/blocks/cube075x1x075.mdl"
j = j + 1
Prop_building[j] = "models/hunter/blocks/cube075x2x075.mdl"
j = j + 1
Prop_building[j] = "models/hunter/blocks/cube075x1x1.mdl"
j = j + 1
Prop_building[j] = "models/hunter/blocks/cube075x2x1.mdl"
j = j + 1
Prop_building[j] = "models/hunter/blocks/cube1x1x025.mdl"
j = j + 1
Prop_building[j] = "models/hunter/blocks/cube1x1x05.mdl"
j = j + 1
Prop_building[j] = "models/hunter/blocks/cube1x1x1.mdl"
j = j + 1
Prop_building[j] = "models/hunter/blocks/cube1x150x1.mdl"
j = j + 1
Prop_building[j] = "models/hunter/blocks/cube2x2x025.mdl"
j = j + 1
Prop_building[j] = "models/hunter/blocks/cube2x2x05.mdl"
j = j + 1
Prop_building[j] = "models/hunter/blocks/cube2x2x1.mdl"
j = j + 1
Prop_building[j] = "models/hunter/plates/plate1x1.mdl"
j = j + 1
Prop_building[j] = "models/hunter/plates/plate1x2.mdl"
j = j + 1
Prop_building[j] = "models/hunter/plates/plate1x3.mdl"
j = j + 1
Prop_building[j] = "models/hunter/plates/plate2x2.mdl"
j = j + 1
Prop_building[j] = "models/Mechanics/gears2/pinion_20t3.mdl"
j = j + 1
Prop_building[j] = "models/Mechanics/gears2/pinion_40t3.mdl"
j = j + 1
Prop_building[j] = "models/Mechanics/gears2/pinion_80t3.mdl"
j = j + 1


Prop_civil[z] = "models/props_c17/FurnitureCouch002a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/FurnitureCouch001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/FurnitureChair001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/FurnitureDrawer001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/FurnitureDrawer002a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/FurnitureFireplace001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/FurnitureRadiator001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/FurnitureShelf001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/FurnitureShelf001b.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/FurnitureSink001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/FurnitureTable001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/FurnitureTable002a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/lampShade001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/FurnitureToilet001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/gravestone002a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/gravestone_coffinpiece001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_junk/PlasticCrate01a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/Lockers001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/shelfunit01a.mdl"
z = z + 1
Prop_civil[z] = 'models/props_c17/FurnitureCupboard001a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_c17/furnitureStove001a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_c17/FurnitureTable003a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_c17/FurnitureWashingmachine001a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_c17/FurnitureDresser001a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_debris/wood_board04a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_junk/wood_crate001a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_interiors/pot01a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_interiors/pot02a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_lab/binderblue.mdl'
z = z + 1
Prop_civil[z] = 'models/props_lab/binderbluelabel.mdl'
z = z + 1
Prop_civil[z] = 'models/props_lab/bindergraylabel01a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_lab/bindergreen.mdl'
z = z + 1
Prop_civil[z] = 'models/props_lab/bindergreenlabel.mdl'
z = z + 1
Prop_civil[z] = 'models/props_lab/binderredlabel.mdl'
z = z + 1
Prop_civil[z] = 'models/props_lab/clipboard.mdl'
z = z + 1
Prop_civil[z] = 'models/props_lab/filecabinet02.mdl'
z = z + 1
Prop_civil[z] = 'models/props_lab/cactus.mdl'
z = z + 1
Prop_civil[z] = 'models/props_lab/lockers.mdl'
z = z + 1
Prop_civil[z] = 'models/props_lab/lockerdoorleft.mdl'
z = z + 1
Prop_civil[z] = 'models/props_lab/lockerdoorright.mdl'
z = z + 1
Prop_civil[z] = 'models/props_lab/lockerdoorsingle.mdl'
z = z + 1
Prop_civil[z] = 'models/props_junk/cardboard_box004a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_junk/cardboard_box004a_gib01.mdl'
z = z + 1
Prop_civil[z] = 'models/props_wasteland/controlroom_chair001a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_wasteland/laundry_cart002.mdl'
z = z + 1
Prop_civil[z] = 'models/props_interiors/Furniture_chair03a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_interiors/Furniture_chair01a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_wasteland/controlroom_filecabinet002a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_interiors/Furniture_Couch02a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_interiors/Furniture_Couch01a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_c17/suitcase001a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_c17/suitcase_passenger_physics.mdl'
z = z + 1
Prop_civil[z] = 'models/props_c17/tools_pliers01a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_lab/Ladel.mdl'
z = z + 1
Prop_civil[z] = 'models/props_c17/tools_wrench01a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_junk/MetalBucket01a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_junk/MetalBucket02a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_c17/furniturearmchair001a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_c17/furniturefridge001a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_c17/furnituredrawer003a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_c17/briefcase001a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_interiors/furniture_cabinetdrawer01a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_interiors/furniture_cabinetdrawer02a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_junk/garbage_carboard002a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_interiors/Furniture_Desk01a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_junk/garbage_glassbottle001a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_junk/garbage_glassbottle002a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_junk/garbage_glassbottle003a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_junk/garbage_metalcan002a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_junk/garbage_milkcarton001a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_junk/garbage_milkcarton002a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_junk/garbage_newspaper001a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_junk/garbage_plasticbottle001a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_junk/garbage_plasticbottle002a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_junk/garbage_plasticbottle003a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_junk/garbage_takeoutcarton001a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_junk/GlassBottle01a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_junk/metal_paintcan001a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_junk/metal_paintcan001b.mdl'
z = z + 1
Prop_civil[z] = 'models/props_junk/Shoe001a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_lab/citizenradio.mdl'
z = z + 1
Prop_civil[z] = 'models/props_junk/metalgascan.mdl'
z = z + 1
Prop_civil[z] = 'models/props_junk/plasticbucket001a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_junk/Shovel01a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_c17/metalladder002.mdl'
z = z + 1
Prop_civil[z] = 'models/props_junk/CinderBlock01a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_wasteland/controlroom_filecabinet001a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_wasteland/controlroom_storagecloset001a.mdl'
z = z + 1
Prop_civil[z] = 'models/props_wasteland/controlroom_storagecloset001b.mdl'
z = z + 1
Prop_civil[z] = 'models/props_wasteland/kitchen_shelf001a.mdl'
z = z + 1
Prop_civil[z] = "models/props_borealis/mooring_cleat01.mdl"
z = z + 1
Prop_civil[z] = "models/props_borealis/door_wheel001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/FurnitureBathtub001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/FurnitureBed001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/FurnitureBoiler001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/GasPipes006a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/gate_door02a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/gate_door01a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/metalladder002b.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/pulleyhook01.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/pulleywheels_small01.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/signpole001.mdl"
z = z + 1
Prop_civil[z] = "models/props_docks/channelmarker_gib01.mdl"
z = z + 1
Prop_civil[z] = "models/props_docks/channelmarker_gib02.mdl"
z = z + 1
Prop_civil[z] = "models/Combine_Helicopter/helicopter_bomb01.mdl"
z = z + 1
Prop_civil[z] = "models/props_docks/channelmarker_gib03.mdl"
z = z + 1
Prop_civil[z] = "models/props_docks/channelmarker_gib04.mdl"
z = z + 1
Prop_civil[z] = "models/props_docks/dock01_cleat01a.mdl"
z = z + 1
Prop_civil[z] = "models/props_docks/dock01_pole01a_128.mdl"
z = z + 1
Prop_civil[z] = "models/props_interiors/ElevatorShaft_Door01a.mdl"
z = z + 1
Prop_civil[z] = "models/props_interiors/Radiator01a.mdl"
z = z + 1
Prop_civil[z] = "models/props_interiors/SinkKitchen01a.mdl"
z = z + 1
Prop_civil[z] = "models/props_junk/harpoon002a.mdl"
z = z + 1
Prop_civil[z] = "models/props_junk/iBeam01a_cluster01.mdl"
z = z + 1
Prop_civil[z] = "models/props_junk/iBeam01a.mdl"
z = z + 1
Prop_civil[z] = "models/props_junk/ravenholmsign.mdl"
z = z + 1
Prop_civil[z] = "models/props_junk/sawblade001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_trainstation/TrackSign02.mdl"
z = z + 1
Prop_civil[z] = "models/props_trainstation/TrackSign03.mdl"
z = z + 1
Prop_civil[z] = "models/props_trainstation/TrackSign07.mdl"
z = z + 1
Prop_civil[z] = "models/props_trainstation/TrackSign08.mdl"
z = z + 1
Prop_civil[z] = "models/props_trainstation/TrackSign09.mdl"
z = z + 1
Prop_civil[z] = "models/props_trainstation/TrackSign10.mdl"
z = z + 1
Prop_civil[z] = "models/props_trainstation/trainstation_arch001.mdl"
z = z + 1
Prop_civil[z] = "models/props_trainstation/trainstation_column001.mdl"
z = z + 1
Prop_civil[z] = "models/props_trainstation/trainstation_ornament001.mdl"
z = z + 1
Prop_civil[z] = "models/props_trainstation/trainstation_ornament002.mdl"
z = z + 1
Prop_civil[z] = "models/props_vehicles/tire001c_car.mdl"
z = z + 1
Prop_civil[z] = "models/props_wasteland/dockplank01b.mdl"
z = z + 1
Prop_civil[z] = "models/props_wasteland/gaspump001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_borealis/borealis_door001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_borealis/bluebarrel001.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/bench01a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/chair02a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/display_cooler01a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/door01_left.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/door02_double.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/FurnitureShelf002a.mdl"
z = z + 1
Prop_civil[z] = "models/props_combine/breenchair.mdl"
z = z + 1
Prop_civil[z] = "models/props_combine/breendesk.mdl"
z = z + 1
Prop_civil[z] = "models/props_combine/breenglobe.mdl"
z = z + 1
Prop_civil[z] = "models/props_interiors/BathTub01a.mdl"
z = z + 1
Prop_civil[z] = "models/props_interiors/Furniture_Lamp01a.mdl"
z = z + 1
Prop_civil[z] = "models/props_interiors/Furniture_shelf01a.mdl"
z = z + 1
Prop_civil[z] = "models/props_interiors/Furniture_Vanity01a.mdl"
z = z + 1
Prop_civil[z] = "models/props_interiors/refrigerator01a.mdl"
z = z + 1
Prop_civil[z] = "models/props_interiors/refrigeratorDoor01a.mdl"
z = z + 1
Prop_civil[z] = "models/props_interiors/refrigeratorDoor02a.mdl"
z = z + 1
Prop_civil[z] = "models/props_interiors/VendingMachineSoda01a.mdl"
z = z + 1
Prop_civil[z] = "models/props_interiors/VendingMachineSoda01a_door.mdl"
z = z + 1
Prop_civil[z] = "models/props_junk/PushCart01a.mdl"
z = z + 1
Prop_civil[z] = "models/props_junk/TrashBin01a.mdl"
z = z + 1
Prop_civil[z] = "models/props_junk/TrashDumpster01a.mdl"
z = z + 1
Prop_civil[z] = "models/props_junk/wood_crate002a.mdl"
z = z + 1
Prop_civil[z] = "models/props_junk/wood_pallet001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_lab/kennel_physics.mdl"
z = z + 1
Prop_civil[z] = "models/props_trainstation/BenchOutdoor01a.mdl"
z = z + 1
Prop_civil[z] = "models/props_trainstation/bench_indoor001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_trainstation/traincar_rack001.mdl"
z = z + 1
Prop_civil[z] = "models/props_trainstation/trainstation_clock001.mdl"
z = z + 1
Prop_civil[z] = "models/props_trainstation/trainstation_post001.mdl"
z = z + 1
Prop_civil[z] = "models/props_trainstation/trashcan_indoor001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_trainstation/trashcan_indoor001b.mdl"
z = z + 1
Prop_civil[z] = "models/props_wasteland/barricade001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_wasteland/barricade002a.mdl"
z = z + 1
Prop_civil[z] = "models/props_wasteland/kitchen_counter001b.mdl"
z = z + 1
Prop_civil[z] = "models/props_wasteland/kitchen_counter001d.mdl"
z = z + 1
Prop_civil[z] = "models/props_wasteland/kitchen_shelf002a.mdl"
z = z + 1
Prop_civil[z] = "models/props_wasteland/kitchen_fridge001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_wasteland/kitchen_counter001c.mdl"
z = z + 1
Prop_civil[z] = "models/props_wasteland/kitchen_counter001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_wasteland/kitchen_stove001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_wasteland/laundry_cart001.mdl"
z = z + 1
Prop_civil[z] = "models/props_wasteland/prison_bedframe001b.mdl"
z = z + 1
Prop_civil[z] = "models/props_wasteland/prison_celldoor001b.mdl"
z = z + 1
Prop_civil[z] = "models/props_wasteland/prison_shelf002a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/cashregister01a.mdl"
z = z + 1
Prop_civil[z] = "models/props_interiors/medicalcabinet02.mdl"
z = z + 1
Prop_civil[z] = "models/env/lighting/lamp_trumpet/lamp_trumpet_tall.mdl"
z = z + 1
Prop_civil[z] = "models/props_interiors/lamp_table02.mdl"
z = z + 1
Prop_civil[z] = "models/props_urban/light_fixture01.mdl"
z = z + 1
Prop_civil[z] = "models/props_interiors/painting_landscape01.mdl"
z = z + 1
Prop_civil[z] = "models/props_interiors/painting_portrait01.mdl"
z = z + 1
Prop_civil[z] = "models/props_furniture/picture_frame8.mdl"
z = z + 1
Prop_civil[z] = "models/props_urban/hotel_curtain001.mdl"
z = z + 1
Prop_civil[z] = "models/props_plants/plantairport01.mdl"
z = z + 1
Prop_civil[z] = "models/Highrise/potted_plant_05.mdl"
z = z + 1
Prop_civil[z] = "models/env/decor/tall_plant_b/tall_plant_b.mdl"
z = z + 1
Prop_civil[z] = "models/env/decor/plant_decofern/plant_decofern.mdl"
z = z + 1
Prop_civil[z] = "models/props_interiors/corkboardverticle01.mdl"
z = z + 1
Prop_civil[z] = "models/props_equipment/sleeping_bag1.mdl"
z = z + 1
Prop_civil[z] = "models/props_equipment/sleeping_bag2.mdl"
z = z + 1
Prop_civil[z] = "models/props_junk/trashcluster01a_corner.mdl"
z = z + 1

-- Little --
Prop_civil[z] = "models/props_junk/meathook001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_junk/metal_paintcan001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_junk/PopCan01a.mdl"
z = z + 1
Prop_civil[z] = "models/props_junk/propane_tank001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_junk/PropaneCanister001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_junk/TrafficCone001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/Frame002a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/lamp001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/metalPot001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/metalPot002a.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/TrapPropeller_Lever.mdl"
z = z + 1
Prop_civil[z] = "models/props_combine/breenbust.mdl"
z = z + 1
Prop_civil[z] = "models/props_combine/breenclock.mdl"
z = z + 1
Prop_civil[z] = "models/props_junk/garbage_coffeemug001a.mdl"
z = z + 1
Prop_civil[z] = "models/props_lab/bindergraylabel01b.mdl"
z = z + 1
Prop_civil[z] = "models/props_lab/binderredlabel.mdl"
z = z + 1
Prop_civil[z] = "models/props_lab/box01a.mdl"
z = z + 1
Prop_civil[z] = "models/props_lab/huladoll.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/handrail04_medium.mdl"
z = z + 1
Prop_civil[z] = "models/props_c17/handrail04_corner.mdl"

--- CSS
z = z  + 1
Prop_civil[z] = 'models/props/cs_office/Bookshelf1.mdl'
z = z  + 1
Prop_civil[z] = 'models/props/cs_office/Bookshelf2.mdl'
z = z  + 1
Prop_civil[z] = 'models/props/cs_office/Bookshelf3.mdl'
z = z + 1
Prop_civil[z] = 'models/props/cs_office/file_box.mdl'
z = z + 1
Prop_civil[z] = 'models/props/cs_office/sofa_chair.mdl'
z = z + 1
Prop_civil[z] = 'models/props/cs_office/Table_coffee.mdl'
z = z + 1
Prop_civil[z] = 'models/props/de_nuke/clock.mdl'
z = z + 1
Prop_civil[z] = 'models/props/cs_office/offinspa.mdl'
z = z + 1
Prop_civil[z] = 'models/props/cs_office/offpaintingk.mdl'
z = z + 1
Prop_civil[z] = 'models/props/cs_office/offpaintingi.mdl'
z = z + 1
Prop_civil[z] = 'models/props/cs_office/plant01.mdl'
z = z + 1
Prop_civil[z] = 'models/props/cs_office/file_cabinet3.mdl'
z = z + 1
Prop_civil[z] = 'models/props/cs_office/file_cabinet2.mdl'
z = z + 1
Prop_civil[z] = 'models/props/cs_office/file_cabinet1_group.mdl'
z = z + 1
Prop_civil[z] = 'models/props/cs_office/file_cabinet1.mdl'
z = z + 1
Prop_civil[z] = 'models/props/cs_office/Cardboard_box01.mdl'
z = z + 1
Prop_civil[z] = 'models/props/cs_office/Cardboard_box02.mdl'
z = z + 1
Prop_civil[z] = 'models/props/cs_office/Cardboard_box03.mdl'
z = z + 1
Prop_civil[z] = 'models/props/cs_office/Shelves_metal.mdl'
z = z + 1
Prop_civil[z] = 'models/props/cs_office/Shelves_metal1.mdl'
z = z + 1
Prop_civil[z] = 'models/props/cs_office/Shelves_metal2.mdl'
z = z + 1
Prop_civil[z] = 'models/props/cs_office/Shelves_metal3.mdl'
z = z + 1
Prop_civil[z] = 'models/props/CS_militia/food_stack.mdl'
z = z + 1
Prop_civil[z] = 'models/props/cs_office/coffee_mug.mdl'
z = z + 1
Prop_civil[z] = 'models/props/CS_militia/footlocker01_open.mdl'
z = z + 1
Prop_civil[z] = 'models/props/CS_militia/footlocker01_closed.mdl'
z = z + 1
Prop_civil[z] = 'models/props/CS_militia/bottle01.mdl'
z = z + 1
Prop_civil[z] = 'models/props/CS_militia/bottle02.mdl'
z = z + 1
Prop_civil[z] = 'models/props/CS_militia/bottle03.mdl'
z = z + 1
Prop_civil[z] = 'models/props/CS_militia/boxes_garage_lower.mdl'
z = z + 1
Prop_civil[z] = 'models/props/CS_militia/circularsaw01.mdl'
z = z + 1
Prop_civil[z] = 'models/props/CS_militia/newspaperstack01.mdl'
z = z + 1
Prop_civil[z] = 'models/props/CS_militia/furniture_shelf01a.mdl'
z = z + 1
Prop_civil[z] = 'models/props/CS_militia/wood_table.mdl'
z = z + 1
Prop_civil[z] = 'models/props/CS_militia/wood_bench.mdl'



	-- Combine --
Prop_combine[x] = "models/props_combine/combine_barricade_med02a.mdl"
x = x + 1
Prop_combine[x] = 'models/props_combine/breenconsole.mdl'
x = x + 1
Prop_combine[x] = 'models/props_combine/breenlight.mdl'
x = x + 1
Prop_combine[x] = 'models/props_combine/cell_01_pod_cheap.mdl'
x = x + 1
Prop_combine[x] = 'models/props_combine/combine_barricade_bracket01a.mdl'
x = x + 1
Prop_combine[x] = 'models/props_combine/combine_barricade_bracket01b.mdl'
x = x + 1
Prop_combine[x] = 'models/props_combine/combine_barricade_bracket02a.mdl'
x = x + 1
Prop_combine[x] = 'models/props_combine/combine_barricade_bracket02b.mdl'
x = x + 1
Prop_combine[x] = 'models/props_combine/combine_barricade_short01a.mdl'
x = x + 1
Prop_combine[x] = 'models/props_combine/combine_barricade_short02a.mdl'
x = x + 1
Prop_combine[x] = 'models/props_combine/combine_barricade_short03a.mdl'
x = x + 1
Prop_combine[x] = 'models/props_combine/combine_fence01a.mdl'
x = x + 1
Prop_combine[x] = 'models/props_combine/combine_fence01b.mdl'
x = x + 1
Prop_combine[x] = 'models/props_combine/combine_generator01.mdl'
x = x + 1
Prop_combine[x] = 'models/props_combine/combine_interface001.mdl'
x = x + 1
Prop_combine[x] = 'models/props_combine/combine_interface001a.mdl'
x = x + 1
Prop_combine[x] = 'models/props_combine/combine_interface002.mdl'
x = x + 1
Prop_combine[x] = 'models/props_combine/combine_interface003.mdl'
x = x + 1
Prop_combine[x] = 'models/props_combine/combine_intmonitor001.mdl'
x = x + 1
Prop_combine[x] = 'models/props_combine/combine_intmonitor003.mdl'
x = x + 1
Prop_combine[x] = 'models/props_combine/combine_intwallunit.mdl'
x = x + 1
Prop_combine[x] = 'models/props_combine/combine_light001a.mdl'
x = x + 1
Prop_combine[x] = 'models/props_combine/combine_light001b.mdl'
x = x + 1
Prop_combine[x] = 'models/props_combine/combine_light002a.mdl'
x = x + 1
Prop_combine[x] = 'models/props_combine/combine_monitorbay.mdl'
x = x + 1
Prop_combine[x] = 'models/props_combine/combine_mortar01b.mdl'
x = x + 1
Prop_combine[x] = 'models/props_combine/combine_window001.mdl'
x = x + 1
Prop_combine[x] = 'models/props_combine/masterinterface.mdl'
x = x + 1
Prop_combine[x] = 'models/props_combine/railing_128.mdl'
x = x + 1
Prop_combine[x] = 'models/props_combine/railing_256.mdl'
x = x + 1
Prop_combine[x] = 'models/props_combine/railing_corner_inside.mdl'
x = x + 1
Prop_combine[x] = 'models/props_combine/railing_corner_outside.mdl'
x = x + 1
Prop_combine[x] = "models/props_combine/weaponstripper.mdl"
x = x + 1
Prop_combine[x] = "models/props_wasteland/controlroom_desk001a.mdl"
x = x + 1
Prop_combine[x] = "models/props_wasteland/controlroom_desk001b.mdl"
x = x + 1
Prop_combine[x] = "models/props_c17/chair_kleiner03a.mdl"
x = x + 1
Prop_combine[x] = "models/props_combine/combine_barricade_med01a.mdl"
x = x + 1
Prop_combine[x] = "models/props_combine/combine_binocular01.mdl"

-- Rebel --
Prop_rebel[g] = "models/props_c17/canister01a.mdl"
g = g + 1
Prop_rebel[g] = "models/props_c17/canister02a.mdl"
g = g + 1
Prop_rebel[g] = "models/props_c17/canister_propane01a.mdl"
g = g + 1
Prop_rebel[g] = "models/props_c17/concrete_barrier001a.mdl"
g = g + 1
Prop_rebel[g] = "models/props_c17/fence01a.mdl"
g = g + 1
Prop_rebel[g] = "models/props_c17/fence02a.mdl"
g = g + 1
Prop_rebel[g] = "models/props_c17/fence01b.mdl"
g = g + 1
Prop_rebel[g] = "models/props_c17/fence02b.mdl"
g = g + 1
Prop_rebel[g] = "models/props_c17/fence03a.mdl"
g = g + 1
Prop_rebel[g] = "models/props_c17/fence04a.mdl"
g = g + 1
Prop_rebel[g] = "models/props_c17/metalladder001.mdl"
g = g + 1
Prop_rebel[g] = "models/props_c17/oildrum001.mdl"
g = g + 1
Prop_rebel[g] = "models/props_debris/metal_panel01a.mdl"
g = g + 1
Prop_rebel[g] = "models/props_debris/metal_panel02a.mdl"
g = g + 1
Prop_rebel[g] = "models/props_doors/door03_slotted_left.mdl"
g = g + 1
Prop_rebel[g] = "models/props_junk/TrashDumpster02b.mdl"
g = g + 1
Prop_rebel[g] = "models/props_lab/blastdoor001a.mdl"
g = g + 1
Prop_rebel[g] = "models/props_lab/blastdoor001b.mdl"
g = g + 1
Prop_rebel[g] = "models/props_lab/blastdoor001c.mdl"
g = g + 1
Prop_rebel[g] = "models/props_wasteland/interior_fence001g.mdl"
g = g + 1
Prop_rebel[g] = "models/props_wasteland/interior_fence002d.mdl"
g = g + 1
Prop_rebel[g] = "models/props_wasteland/interior_fence002e.mdl"
g = g + 1
Prop_rebel[g] = "models/props_lab/crematorcase.mdl"
g = g + 1
Prop_rebel[g] = "models/props_lab/securitybank.mdl"
g = g + 1
Prop_rebel[g] = "models/props_lab/servers.mdl"
g = g + 1

-- Rebel --
Prop_realistic[s] = "models/env/furniture/wc_double_cupboard/wc_double_cupboard.mdl"
s = s + 1
Prop_realistic[s] = "models/env/furniture/square_sink/sink_double.mdl"
s = s + 1
Prop_realistic[s] = "models/env/furniture/square_sink/sink_merged_b.mdl"
s = s + 1
Prop_realistic[s] = "models/env/furniture/showerbase/showerbase.mdl"
s = s + 1
Prop_realistic[s] = "models/env/furniture/shower/shower.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/bathtub01.mdl"
s = s + 1
Prop_realistic[s] = "models/env/furniture/ensuite1_toilet/ensuite1_toilet.mdl"
s = s + 1
Prop_realistic[s] = "models/env/furniture/ensuite1_toilet/ensuite1_toilet_b.mdl"
s = s + 1
Prop_realistic[s] = "models/env/furniture/ensuite1_sink/ensuite1_sink.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/soap_dispenser.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/toiletpaperdispenser_residential.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/toiletpaperroll.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/bed_motel.mdl"
s = s + 1
Prop_realistic[s] = "models/props_downtown/bed_motel01.mdl"
s = s + 1
Prop_realistic[s] = "models/env/furniture/bed_secondclass/beddouble_group.mdl"
s = s + 1
Prop_realistic[s] = "models/env/furniture/bed_andrea/bed_andrea_1st.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/side_table_square.mdl"
s = s + 1
Prop_realistic[s] = "models/props_equipment/phone_booth.mdl"
s = s + 1
Prop_realistic[s] = "models/Highrise/trashcanashtray_01.mdl"
s = s + 1
Prop_realistic[s] = "models/Highrise/trash_can_03.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/trashcan01.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/cashregister01.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/magazine_rack.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/shelvinggrocery01.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/shelvingstore01.mdl"
s = s + 1
Prop_realistic[s] = "models/props_equipment/fountain_drinks.mdl"
s = s + 1
Prop_realistic[s] = "models/scenery/structural/vesuvius/bartap.mdl"
s = s + 1
Prop_realistic[s] = "models/env/furniture/bstoolred/bstoolred.mdl"
s = s + 1
Prop_realistic[s] = "models/props_furniture/cafe_barstool1.mdl"
s = s + 1
Prop_realistic[s] = "models/props_downtown/pooltable.mdl"
s = s + 1
Prop_realistic[s] = "models/de_vegas/card_table.mdl"
s = s + 1
Prop_realistic[s] = "models/props_equipment/security_desk1.mdl"
s = s + 1
Prop_realistic[s] = "models/sickness/bk_booth2.mdl"
s = s + 1
Prop_realistic[s] = "models/props_downtown/booth01.mdl"
s = s + 1
Prop_realistic[s] = "models/props_downtown/booth02.mdl"
s = s + 1
Prop_realistic[s] = "models/props_downtown/booth_table.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/table_cafeteria.mdl"
s = s + 1
Prop_realistic[s] = "models/props_warehouse/table_01.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/chairs_airport.mdl"
s = s + 1
Prop_realistic[s] = "models/props_warehouse/toolbox.mdl"
s = s + 1
Prop_realistic[s] = "models/props_vtmb/turntable.mdl"
s = s + 1
Prop_realistic[s] = "models/props_unique/wheelchair01.mdl"
s = s + 1
Prop_realistic[s] = "models/props_unique/hospital/exam_table.mdl"
s = s + 1
Prop_realistic[s] = "models/props_unique/hospital/gurney.mdl"
s = s + 1
Prop_realistic[s] = "models/props_equipment/surgicaltray_01.mdl"
s = s + 1
Prop_realistic[s] = "models/props_unique/hospital/hospital_bed.mdl"
s = s + 1
Prop_realistic[s] = "models/props_unique/hospital/iv_pole.mdl"
s = s + 1
Prop_realistic[s] = "models/props_unique/hospital/surgery_lamp.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/medicalcabinet02.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/refrigerator03.mdl"
s = s + 1
Prop_realistic[s] = "models/sickness/fridge_01.mdl"
s = s + 1
Prop_realistic[s] = "models/sickness/stove_01.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/sink_kitchen.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/coffee_maker.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/chair01.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/chair_cafeteria.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/dining_table_round.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/dinning_table_oval.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/trashcankitchen01.mdl"
s = s + 1
Prop_realistic[s] = "models/props_unique/spawn_apartment/lantern.mdl"
s = s + 1
Prop_realistic[s] = "models/env/lighting/lamp_trumpet/lamp_trumpet_tall.mdl"
s = s + 1
Prop_realistic[s] = "models/env/lighting/jelly_lamp/jellylamp.mdl"
s = s + 1
Prop_realistic[s] = "models/env/lighting/corridor_ceil_lamp/corridor_ceil_lamp.mdl"
s = s + 1
Prop_realistic[s] = "models/env/lighting/corridorlamp/corridorlamp.mdl"
s = s + 1
Prop_realistic[s] = "models/props_urban/light_fixture01.mdl"
s = s + 1
Prop_realistic[s] = "models/Highrise/tall_lamp_01.mdl"
s = s + 1
Prop_realistic[s] = "models/U4Lab/track_lighting_a.mdl"
s = s + 1
Prop_realistic[s] = "models/Highrise/sconce_01.mdl"
s = s + 1
Prop_realistic[s] = "models/wilderness/lamp6.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/lamp_table02.mdl"
s = s + 1
Prop_realistic[s] = "models/U4Lab/tv_monitor_plasma.mdl"
s = s + 1
Prop_realistic[s] = "models/gmod_tower/suitetv.mdl"
s = s + 1
Prop_realistic[s] = "models/scenery/furniture/coffeetable1/vestbl.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/chairlobby01.mdl"
s = s + 1
Prop_realistic[s] = "models/props_warehouse/office_furniture_couch.mdl"
s = s + 1
Prop_realistic[s] = "models/props_vtmb/armchair.mdl"
s = s + 1
Prop_realistic[s] = "models/props_vtmb/sofa.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/sofa01.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/sofa02.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/sofa_chair02.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/ottoman01.mdl"
s = s + 1
Prop_realistic[s] = "models/env/furniture/decosofa_wood/decosofa_wood_dou.mdl"
s = s + 1
Prop_realistic[s] = "models/Highrise/lobby_chair_01.mdl"
s = s + 1
Prop_realistic[s] = "models/Highrise/lobby_chair_02.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/desk_motel.mdl"
s = s + 1
Prop_realistic[s] = "models/props_furniture/piano.mdl"
s = s + 1
Prop_realistic[s] = "models/props_furniture/piano_bench.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/painting_landscape01.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/painting_portrait01.mdl"
s = s + 1
Prop_realistic[s] = "models/props_furniture/picture_frame8.mdl"
s = s + 1
Prop_realistic[s] = "models/props_urban/hotel_curtain001.mdl"
s = s + 1
Prop_realistic[s] = "models/props_plants/plantairport01.mdl"
s = s + 1
Prop_realistic[s] = "models/Highrise/potted_plant_05.mdl"
s = s + 1
Prop_realistic[s] = "models/env/decor/tall_plant_b/tall_plant_b.mdl"
s = s + 1
Prop_realistic[s] = "models/env/decor/plant_decofern/plant_decofern.mdl"
s = s + 1
Prop_realistic[s] = "models/U4Lab/chair_office_a.mdl"
s = s + 1
Prop_realistic[s] = "models/U4Lab/desk_office_a.mdl"
s = s + 1
Prop_realistic[s] = "models/props_warehouse/office_furniture_coffee_table.mdl"
s = s + 1
Prop_realistic[s] = "models/props_warehouse/office_furniture_desk.mdl"
s = s + 1
Prop_realistic[s] = "models/props_warehouse/office_furniture_desk_corner.mdl"
s = s + 1
Prop_realistic[s] = "models/props_office/desk_01.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/desk_executive.mdl"
s = s + 1
Prop_realistic[s] = "models/env/furniture/largedesk/largedesk.mdl"
s = s + 1
Prop_realistic[s] = "models/props_office/file_cabinet_03.mdl"
s = s + 1
Prop_realistic[s] = "models/Highrise/cubicle_monitor_01.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/copymachine01.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/printer.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/paper_tray.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/water_cooler.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/corkboardverticle01.mdl"
s = s + 1
Prop_realistic[s] = "models/props_unique/spawn_apartment/coffeeammo.mdl"
s = s + 1
Prop_realistic[s] = "models/props_downtown/sign_donotenter.mdl"
s = s + 1
Prop_realistic[s] = "models/props_waterfront/awning01.mdl"
s = s + 1
Prop_realistic[s] = "models/props_street/awning_department_store.mdl"
s = s + 1
Prop_realistic[s] = "models/props/de_tides/planter.mdl"
s = s + 1
Prop_realistic[s] = "models/props_urban/bench001.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/table_picnic.mdl"
s = s + 1
Prop_realistic[s] = "models/props_urban/plastic_chair001.mdl"
s = s + 1
Prop_realistic[s] = "models/props_interiors/patio_chair2_white.mdl"
s = s + 1
Prop_realistic[s] = "models/props/de_tides/patio_chair2.mdl"
s = s + 1
Prop_realistic[s] = "models/props/de_tides/patio_table2.mdl"
s = s + 1
Prop_realistic[s] = "models/env/furniture/pool_recliner/pool_recliner.mdl"
s = s + 1
Prop_realistic[s] = "models/props/de_piranesi/pi_bench.mdl"
s = s + 1
Prop_realistic[s] = "models/props/de_piranesi/pi_sundial.mdl"
s = s + 1
Prop_realistic[s] = "models/props/de_inferno/bench_concrete.mdl"
s = s + 1
Prop_realistic[s] = "models/props/de_inferno/fountain.mdl"
s = s + 1
Prop_realistic[s] = "models/props/de_inferno/lattice.mdl"
s = s + 1
Prop_realistic[s] = "models/props_unique/firepit_campground.mdl"
s = s + 1
Prop_realistic[s] = "models/props_equipment/sleeping_bag1.mdl"
s = s + 1
Prop_realistic[s] = "models/props_equipment/sleeping_bag2.mdl"
s = s + 1
Prop_realistic[s] = "models/props_urban/outhouse001.mdl"
s = s + 1
Prop_realistic[s] = "models/props_junk/trashcluster01a_corner.mdl"
s = s + 1


if CLIENT then	

    local spawntable = {}

    spawntable["[1] Для Гражданских:"] = {}
    spawntable["[1] Для Гражданских:"].Model = Prop_civil
    spawntable["[1] Для Гражданских:"].Data = Prop_civil

    spawntable["[2] Для Построек:"] = {}
    spawntable["[2] Для Построек:"].Model = Prop_building
    spawntable["[2] Для Построек:"].Data = Prop_building

    spawntable["[3] Для Альянса:"] = {}
    spawntable["[3] Для Альянса:"].Model = Prop_combine
    spawntable["[3] Для Альянса:"].Data = Prop_combine

    spawntable["[4] Для Повстанцев:"] = {}
    spawntable["[4] Для Повстанцев:"].Model = Prop_rebel
    spawntable["[4] Для Повстанцев:"].Data = Prop_rebel

    spawntable["[5] Подписка Builder:"] = {}
    spawntable["[5] Подписка Builder:"].Model = Prop_realistic
    spawntable["[5] Подписка Builder:"].Data = Prop_realistic


	
    local PANEL = {}

    function PANEL:Init()
        self.PanelList = vgui.Create("DPanelList", self)
        self.PanelList:SetPadding(4)
        self.PanelList:SetSpacing(2)
        self.PanelList:EnableVerticalScrollbar(true)
        self:BuildList()
    end

    local function AddComma(n)
        local sn = tostring(n)
        sn = string.ToTable(sn)
        local tab = {}

        for i = 0, #sn - 1 do
            if i % 3 == #sn % 3 and not (i == 0) then
                table.insert(tab, ",")
            end

            table.insert(tab, sn[i + 1])
        end

        return string.Implode("", tab)
    end

    function PANEL:BuildList()
        self.PanelList:Clear()
        local Categorised = {}

        for k, v in pairs(spawntable) do
            v.Category = k
            Categorised[v.Category] = Categorised[v.Category] or {}
            table.insert(Categorised[v.Category], v)
        end

        for CategoryName, v in SortedPairs(Categorised) do
            local Category = vgui.Create("DCollapsibleCategory", self)
            self.PanelList:AddItem(Category)
            Category:SetExpanded(false)
            Category:SetLabel(CategoryName)
            Category:SetCookieName("EntitySpawn." .. CategoryName)
            local Content = vgui.Create("DPanelList")
            Category:SetContents(Content)
            Content:EnableHorizontal(true)
            Content:SetDrawBackground(false)
            Content:SetSpacing(2)
            Content:SetPadding(2)
            Content:SetAutoSize(true)
            number = 1

            for k, v in pairs(spawntable[CategoryName].Model) do
              
                local Icon = vgui.Create("SpawnIcon", self)
                local Model = spawntable[CategoryName].Model[number]

                if (spawntable[CategoryName].Model[number] ~= nil) then
                    Icon:SetModel(spawntable[CategoryName].Model[number])
                else
                    Icon:SetModel("models/error.mdl")
                end

                Icon.DoClick = function()
                    RunConsoleCommand("gm_spawn", Model)
                end

                local lable = vgui.Create("DLabel", Icon)
                lable:SetFont("DebugFixedSmall")
                lable:SetTextColor(color_black)
                lable:SetText(Model)
                lable:SetContentAlignment(5)
                lable:SetWide(self:GetWide())
                lable:AlignBottom(-42)
                Content:AddItem(Icon)
                number = number + 1
            end
        end

        self.PanelList:InvalidateLayout()
    end

    function PANEL:PerformLayout()
        self.PanelList:StretchToParent(0, 0, 0, 0)
    end

    local CreationSheet = vgui.RegisterTable(PANEL, "Panel")

    local function CreateContentPanel()
        local ctrl = vgui.CreateFromTable(CreationSheet)

        return ctrl
    end

    local function RemoveSandboxTabs()
        
        local tabstoremove = {

	        	language.GetPhrase("spawnmenu.content_tab"), 
		        language.GetPhrase("spawnmenu.category.npcs"), 
		        language.GetPhrase("spawnmenu.category.entities"), 
		        language.GetPhrase("spawnmenu.category.weapons"), 
		        language.GetPhrase("spawnmenu.category.vehicles"), 
		        language.GetPhrase("spawnmenu.category.postprocess"), 
		        language.GetPhrase("spawnmenu.category.dupes"), 
                language.GetPhrase("spawnmenu.category.saves"),
				"SCars",
                
    	}
    	
        if !IsRisedStuff(LocalPlayer()) then 
            
            for k, v in pairs(g_SpawnMenu.CreateMenu.Items) do
                
                if table.HasValue(tabstoremove, v.Tab:GetText()) then
                    
                    g_SpawnMenu.CreateMenu:CloseTab(v.Tab, true)
                    
                    RemoveSandboxTabs()
                    
                end
                
	        end
        end

    end

    hook.Add("SpawnMenuOpen", "blockmenutabs", RemoveSandboxTabs)

    local function BunkMenu()

        return

    end

    spawnmenu.AddCreationTab("Меню предметов", CreateContentPanel, "icon16/application_view_columns.png", 4)


else

    hook.Add("PlayerSpawnRagdoll", 'RisedNope', function(ply, model)

        if IsRisedEventer(ply) then return end
        
        return false
    
    end)

    hook.Add("PlayerSpawnProp", 'RisedNope', function(p, model) 

		if IsRisedStuff(p) then return true end

        for _, m in pairs(Prop_civil) do

            if model == m then return true end

        end
		
		for _, m in pairs(Prop_building) do

            if model == m then return true end

        end

        if GAMEMODE.CivilProtection[p:Team()] then

            for _, m in pairs(Prop_combine) do

                if model == m then return true end
    
            end

        end
		
		if GAMEMODE.Rebels[p:Team()] then

            for _, m in pairs(Prop_rebel) do

                if model == m then return true end
    
            end

        end
		
		if p:HasPurchase("status_builder") then

            for _, m in pairs(Prop_realistic) do

                if model == m then return true end
    
            end

        end
        
        return false

    end)

end