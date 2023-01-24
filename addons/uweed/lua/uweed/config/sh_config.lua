-- "addons\\uweed\\lua\\uweed\\config\\sh_config.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
UWeed.Pot = {}
UWeed.Light = {}
UWeed.SeedBox = {}
UWeed.WeedBag = {}
-- You will find a large amount of small tweaks you can make here, the growing process is already pretty fine tuned to work well so you most likely won't need to edit the lower part.
-- That being said, every server has diferent needs and wants so we tried to make everything as configurable as possible.
-- Open a ticket for any questions.help
/* ===========================
	GENERAL CONFIGURATION
===========================*/
-- The prefix in chat for the store actions
UWeed.Config.Prefix = "[RisedRP]"

-- The color of the prefix in chat for the store actions
UWeed.Config.PrefixColor = Color(0, 200, 0)

-- The font used throughout the addon
UWeed.Config.Font = "Calibri"

-- The NPC model
UWeed.Config.NPCModel = "models/hl2rp/male_03.mdl"

-- The min and max price weed sells for per gram (Set them both the same if you want it to be a static value)
UWeed.Config.MinSell = RISED.Config.Economy.WeedMinCost
UWeed.Config.MaxSell = RISED.Config.Economy.WeedMaxCost

-- When selling the weed, should the user be prompted in chat about their sale?
UWeed.Config.SellChatMessage = true

-- How long should you stay high for after you smoke weed? (seconds)
UWeed.Config.HighTime = 900

-- If you die while high should the effect be removed?
UWeed.Config.ResetHighDeath = true

-- How many tugs do you get per rolled joint? (How many times can 1 rolled joint be smoked?)
UWeed.Config.RollAmount = 3

-- When you die should you lose all the weed on you (all the weed you obtained by picking up rolled joints)
UWeed.Config.KeepWeed = true

-- If above is true, should you spawn with a join if you have some on you?
UWeed.Config.SpawnJoints = false

-- There are 2 sizes for the bud models. Normal or small. Small is more realistic however you may find them too small. This option toggles that (true will use the small models)
UWeed.Config.UseSmallGram = true

/* ===========================
	GROWING CONFIGURATION
===========================*/
-- The timer between each stage of growth
UWeed.Pot.GrowthRate = RISED.Config.Economy.WeedGrowStageTime
-- The drop chance for the seed. So it'll be a 1 in x chance of dropping.
UWeed.Pot.SeedDropChance = 15
-- The least amount of buds that can come from a grow
UWeed.Pot.MinBuds = 6
-- The most amount of buds that can come from a grow
UWeed.Pot.MaxBuds = 8
-- When you colkect a bud from the pot, the bud will be between 1 and x grams, what is x? (Setting this to 1 will make it so every bud comes out at base stage of 1g) (Setting this higher than 8 will break it)
UWeed.Pot.MaxBudGram = 3
-- How quickly should light drop? The system works by removing x from itself every second. It starts at 50 and once it hits below 25 it'll prompt the user to give it more light 
UWeed.Pot.LightDeplenishrate = 1

-- So when the light is on the plant how much should it boost the light by each time (roughly every second)? It starts at 50 and once it hits above 75 it'll prompt the user to use less light 
UWeed.Light.IncreaseRate = 2
-- Should the lights require battery?
UWeed.Light.Batery = true
-- If the above is true, how often should the battery decay by 1% (in seconds)
UWeed.Light.BatteryDecay = 8

-- How many seeds can a seedbox hold at 1 time?
UWeed.SeedBox.MaxStorage = 8

-- The max amount of buds that can be stored in 1 bag
UWeed.WeedBag.Capacity = 10
