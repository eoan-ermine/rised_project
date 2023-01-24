-- "addons\\bricks-crafting\\lua\\brickscrafting_luaconfig.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[ LUACONFIG ]]--
BRICKSCRAFTING.LUACONFIG = {}
BRICKSCRAFTING.LUACONFIG.AdminSystem = "ULX/FAdmin/More" -- The admin mod in use, options: "Serverguard", "ULX/FAdmin/More", "xAdmin"
BRICKSCRAFTING.LUACONFIG.AdminRanks = { -- ONLY GIVE TO YOURSELF
	["superadmin"] = true,
	["hand"] = true,
}
BRICKSCRAFTING.LUACONFIG.UseMySQL = false -- Whether MySQL should be used or not, enter your MySQL information in lua/brickscrafting/server/brickscrafting_sql.lua
BRICKSCRAFTING.LUACONFIG.MaxQuests = 1 -- The maximum quests a player can have at once
BRICKSCRAFTING.LUACONFIG.Language = "russian" -- The language to be used, options: "english", "russian", "german", "polish", "french", "chinese"
BRICKSCRAFTING.LUACONFIG.DisableSWEP = false -- Whether the storage SWEP should be given on spawn or not
BRICKSCRAFTING.LUACONFIG.DarkRP = true -- Whether DarkRP is being used or not
BRICKSCRAFTING.LUACONFIG.RockRespawn = 60 -- How long till a rock respawns after being destroyed
BRICKSCRAFTING.LUACONFIG.RockHealth = 100 -- How much health does a rock have
BRICKSCRAFTING.LUACONFIG.GarbageRespawn = 60 -- How long till a garbage pile respawns after being harvested
BRICKSCRAFTING.LUACONFIG.BenchHealth = 0 -- How much health a crafting bench has, 0 will make it indestructible
BRICKSCRAFTING.LUACONFIG.DisableShadows = false -- Disables shadows on the UI, can increase FPS
BRICKSCRAFTING.LUACONFIG.StorageBind = false -- Opens the storage via a key bind, options: false, KEY_F1, KEY_F2, KEY_F3, KEY_F4, (Any of these: http://wiki.garrysmod.com/page/Enums/KEY)
BRICKSCRAFTING.LUACONFIG.ChangeRockSize = true -- Whether rocks should get smaller as they lose health

BRICKSCRAFTING.LUACONFIG.DropCooldown = 1 -- How long a player needs to wait between dropping resources
BRICKSCRAFTING.LUACONFIG.SellCooldown = 1 -- How long a player needs to wait between selling resources
BRICKSCRAFTING.LUACONFIG.NPCSellDistance = 1000 -- The distance a player can be away from an NPC to sell resources

--[[ LEVELING SYSTEM SUPPORT ]]--
BRICKSCRAFTING.LUACONFIG.EnableLeveling = false -- Whether or not experience should be given for mining etc, SUPPORT FOR LEVELING SYSTEMS, DONT ENABLE IF YOU DONT HAVE ONE!
BRICKSCRAFTING.LUACONFIG.ExpForMining = 5
BRICKSCRAFTING.LUACONFIG.ExpForCutting = 5
BRICKSCRAFTING.LUACONFIG.ExpForQuest = 150
BRICKSCRAFTING.LUACONFIG.ExpForGarbage = 50

--[[
	
	DO NOT EDIT ANYTHING BELOW THIS
	You can edit the rest of the config in game by typing !brickscrafting

]]--

BRICKSCRAFTING.LUACONFIG.Defaults = {}
BRICKSCRAFTING.LUACONFIG.Defaults.DisplayDist3D2D = 100000
BRICKSCRAFTING.LUACONFIG.Defaults.QuestResetTime = 86400
BRICKSCRAFTING.LUACONFIG.Defaults.ResorceAddMax = 10000
BRICKSCRAFTING.LUACONFIG.Defaults.QuestCraftGoalMax = 25
BRICKSCRAFTING.LUACONFIG.Defaults.QuestResGoalMax = 10000
BRICKSCRAFTING.LUACONFIG.Defaults.PickaxeSkillDifficulty = 0.1
BRICKSCRAFTING.LUACONFIG.Defaults.LumberaxeSkillDifficulty = 0.1
BRICKSCRAFTING.LUACONFIG.Defaults.CraftingSkillDifficulty = 0.25
BRICKSCRAFTING.LUACONFIG.Defaults.RockModel = "models/brickscrafting/rock.mdl"
BRICKSCRAFTING.LUACONFIG.Defaults.TreeModel = "models/props_foliage/tree_springers_01a-lod.mdl"
BRICKSCRAFTING.LUACONFIG.Defaults.PickaxeModel = "models/sterling/w_crafting_pickaxe.mdl"
BRICKSCRAFTING.LUACONFIG.Defaults.LumberAxeModel = "models/sterling/w_crafting_axe.mdl"