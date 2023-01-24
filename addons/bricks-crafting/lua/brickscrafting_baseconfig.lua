-- "addons\\bricks-crafting\\lua\\brickscrafting_baseconfig.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
	
	DO NOT EDIT ANYTHING BELOW THIS
	You can edit the real config in game by typing !brickscrafting

]]--

BRICKSCRAFTING.BASECONFIG = {}

--[[ RARITY ]]--
BRICKSCRAFTING.BASECONFIG.Rarity = {
	[1] = {
		Name = "Uncommon",
		Color = Color( 30, 255, 0 )
	},
	[2] = {
		Name = "Rare",
		Color = Color( 0, 112, 221, 75 )
	},
	[3] = {
		Name = "Epic",
		Color = Color( 163, 53, 238 )
	},
	[4] = {
		Name = "Legendary",
		Color = Color( 255, 128, 0 )
	}
}

--[[ CRAFTING ]]--
BRICKSCRAFTING.BASECONFIG.Crafting = {}

--[[ Different crafting benches ]]--
BRICKSCRAFTING.BASECONFIG.Crafting["General"] = {
	Name = "General Bench",
	model = "models/brickscrafting/workbench_1.mdl",
	Skill = { "General Crafting", 100 },
	Items = {}
}

BRICKSCRAFTING.BASECONFIG.Crafting["Weapons"] = {
	Name = "Weapons Bench",
	model = "models/brickscrafting/workbench_2.mdl",
	Skill = { "Weapon Making", 200 },
	Items = {}
}

--[[ General Bench Items ]]--
if( BRICKSCRAFTING.LUACONFIG.DarkRP ) then
	BRICKSCRAFTING.BASECONFIG.Crafting["General"].Items[1] = {
		Name = "Small Money Bag",
		Description = "Rewards between $10,000 and $15,000!",
		Rarity = 2,
		model = "models/gta iv/duffle_bag.mdl",
		Type = "Money Bag",
		TypeInfo = { 10000, 15000 },
		Resources = { ["Wood"] = 200, ["Iron"] = 125 }
	}

	BRICKSCRAFTING.BASECONFIG.Crafting["General"].Items[2] = {
		Name = "Medium Money Bag",
		Description = "Rewards between $100,000 and $150,000!",
		Rarity = 3,
		Skill = 5,
		model = "models/gta iv/duffle_bag.mdl",
		Type = "Money Bag",
		TypeInfo = { 100000, 150000 },
		Resources = { ["Wood"] = 500, ["Iron"] = 250 }
	}

	BRICKSCRAFTING.BASECONFIG.Crafting["General"].Items[3] = {
		Name = "Large Money Bag",
		Description = "Rewards between $1,000,000 and $1,500,000!",
		Rarity = 4,
		Cost = 10000,
		Skill = 50,
		model = "models/gta iv/duffle_bag.mdl",
		Type = "Money Bag",
		TypeInfo = { 1000000, 1500000 },
		Resources = { ["Wood"] = 2000, ["Iron"] = 1000 }
	}
end

BRICKSCRAFTING.BASECONFIG.Crafting["General"].Items[4] = {
	Name = "First Aid Kit",
	Description = "Gives 50 health (max health: 100)!",
	model = "models/healthvial.mdl",
	Type = "Health",
	TypeInfo = { 50, 100 },
	Resources = { ["Plastic"] = 50 }
}

BRICKSCRAFTING.BASECONFIG.Crafting["General"].Items[5] = {
	Name = "Medical Kit",
	Description = "Gives 100 health.",
	Rarity = 1,
	Cost = 2500,
	Skill = 10,
	model = "models/items/healthkit.mdl",
	Type = "Health",
	TypeInfo = { 100, 100 },
	Resources = { ["Plastic"] = 100 }
}

BRICKSCRAFTING.BASECONFIG.Crafting["General"].Items[6] = {
	Name = "Body Armor",
	Description = "Gives 50 Armor.",
	model = "models/items/battery.mdl",
	Type = "Armor",
	TypeInfo = { 50, 50 },
	Resources = { ["Iron"] = 50 }
}

if( BRICKSCRAFTING.LUACONFIG.DarkRP ) then
	BRICKSCRAFTING.BASECONFIG.Crafting["General"].Items[7] = {
		Name = "Money Printer",
		Description = "Gives you a money printer.",
		Cost = 5000,
		model = "models/props_c17/consolebox01a.mdl",
		Type = "Entity",
		TypeInfo = { "money_printer" },
		Resources = { ["Iron"] = 150 }
	}
end

--[[ Weapons Bench Items ]]--
BRICKSCRAFTING.BASECONFIG.Crafting["Weapons"].Items[1] = {
	Name = "Deagle",
	Description = "A generic Deagle.",
	model = "models/weapons/w_pist_deagle.mdl",
	Type = "SWEP",
	TypeInfo = { "weapon_deagle2" },
	Resources = { ["Plastic"] = 5, ["Iron"] = 100 }
}
BRICKSCRAFTING.BASECONFIG.Crafting["Weapons"].Items[2] = {
	Name = "AK-47",
	Description = "A generic AK-47.",
	Rarity = 1,
	Cost = 1000,
	Skill = 10,
	model = "models/weapons/w_rif_ak47.mdl",
	Type = "SWEP",
	TypeInfo = { "weapon_ak472" },
	Resources = { ["Plastic"] = 10, ["Iron"] = 250, ["Scrap"] = 5 }
}

--[[ Resources ]]--
BRICKSCRAFTING.BASECONFIG.Resources = {}
BRICKSCRAFTING.BASECONFIG.Resources["Scrap"] = {
	model = "models/sterling/crafting_scraps.mdl",
	icon = "materials/brickscrafting/resource_icons/scrap.png"
}
BRICKSCRAFTING.BASECONFIG.Resources["Wood"] = {
	model = "models/sterling/crafting_wood.mdl",
	icon = "materials/brickscrafting/resource_icons/wood.png",
	Price = 2
}
BRICKSCRAFTING.BASECONFIG.Resources["Plastic"] = {
	model = "models/sterling/crafting_waterbottle.mdl",
	icon = "materials/brickscrafting/resource_icons/plastic.png"
}
BRICKSCRAFTING.BASECONFIG.Resources["Iron"] = {
	model = "models/sterling/crafting_metal.mdl",
	icon = "materials/brickscrafting/resource_icons/iron.png",
	Price = 1
}
BRICKSCRAFTING.BASECONFIG.Resources["Diamond"] = {
	model = "models/sterling/crafting_rock.mdl",
	color = Color( 3, 252, 240 ),
	icon = "materials/brickscrafting/resource_icons/diamond.png",
	Price = 5
}
BRICKSCRAFTING.BASECONFIG.Resources["Ruby"] = {
	model = "models/sterling/crafting_rock.mdl",
	color = Color( 	224, 17, 95 ),
	icon = "materials/brickscrafting/resource_icons/ruby.png",
	Price = 10
}

--[[ Garbage PIle ]]--
BRICKSCRAFTING.BASECONFIG.Garbage = {}
BRICKSCRAFTING.BASECONFIG.Garbage.CollectTime = 3
BRICKSCRAFTING.BASECONFIG.Garbage.Resources = {
	["Scrap"] = 40,
	["Plastic"] = 40,
}

--[[ Mining ]]--
BRICKSCRAFTING.BASECONFIG.Mining = {}
BRICKSCRAFTING.BASECONFIG.Mining["Iron"] = {
	model = "models/brickscrafting/rock.mdl",
	color = Color( 196, 196, 196 ),
	resource = {
		["Iron"] = 75,
	},
	BaseReward = 10
}
BRICKSCRAFTING.BASECONFIG.Mining["Diamond"] = {
	model = "models/brickscrafting/rock.mdl",
	color = Color( 3, 252, 240 ),
	resource = {
		["Diamond"] = 50,
		["Ruby"] = 10,
	},
	BaseReward = 1
}

--[[ Wood cutting ]]--
BRICKSCRAFTING.BASECONFIG.WoodCutting = {}
BRICKSCRAFTING.BASECONFIG.WoodCutting["Oak"] = {
	model = "models/props_foliage/tree_springers_01a-lod.mdl",
	resource = {
		["Wood"] = 75,
	},
	BaseReward = 5
}
BRICKSCRAFTING.BASECONFIG.WoodCutting["Birch"] = {
	model = "models/props_foliage/tree_springers_01a-lod.mdl",
	resource = {
		["Wood"] = 100,
	},
	BaseReward = 10
}

--[[ Quests ]]--
BRICKSCRAFTING.BASECONFIG.Quests = {}
if( BRICKSCRAFTING.LUACONFIG.DarkRP ) then
	BRICKSCRAFTING.BASECONFIG.Quests[1] = {
		Name = "Jewlery Store Robbery!",
		Description = "Collect resources to craft an AK-47!",
		Icon = "IconQuest",
		Goal = {
			["Resource"] = { -- "Resource" name of goal type
				["Scrap"] = 5, -- "Diamond" name of resource, 5 is the amount
				["Plastic"] = 10,
				["Iron"] = 250
			},
			["Craft"] = {
				["Weapons"] = { -- "Weapons" is the bench type
					[2] = 1	-- 2 is the item key, 1 is the amount
				}
			}
		},
		Rewards = {
			["Money"] = { 25000 },
			["Resource"] = {
				["Diamond"] = 20,
				["Ruby"] = 10
			},
		}
	}

	BRICKSCRAFTING.BASECONFIG.Quests[2] = {
		Name = "Gambling Addict",
		Description = "Craft 3 Small Money Bags for me uWu.",
		Icon = "IconQuest",
		Goal = {
			["Craft"] = {
				["General"] = { 
					[1] = 3
				}
			}
		},
		Rewards = {
			["Craftable"] = { 
				["General"] = {
					[2] = 2
				}
			}
		}
	}

	BRICKSCRAFTING.BASECONFIG.Quests[3] = {
		Name = "Scrap Man",
		Description = "Collect 15 scrap and 200 iron for me!",
		Icon = "IconQuest",
		Goal = {
			["Resource"] = {
				["Scrap"] = 15,
				["Iron"] = 200
			},
		},
		Rewards = {
			["Money"] = { 25000 },
		}
	}
end
BRICKSCRAFTING.BASECONFIG.Quests[4] = {
	Name = "Gem buyer",
	Description = "Collect 5 rubies for my gem collection.",
	Daily = true,
	Icon = "IconQuest",
	Goal = {
		["Resource"] = {
			["Ruby"] = 5
		},
	},
	Rewards = {
		["Money"] = { 10000 },
		["Craftable"] = { 
			["Weapons"] = {
				[1] = 2
			}
		}
	}
}

--[[ Pickaxe Upgrades ]]--
BRICKSCRAFTING.BASECONFIG.Tools = {}
BRICKSCRAFTING.BASECONFIG.Tools.MaxPickaxeSkill = 100
BRICKSCRAFTING.BASECONFIG.Tools.Pickaxe = {}
BRICKSCRAFTING.BASECONFIG.Tools.Pickaxe[1] = {
	Increase = 5,
	Skill = 10,
	Color = Color( 150, 90, 56 )
}
BRICKSCRAFTING.BASECONFIG.Tools.Pickaxe[2] = {
	Increase = 10,
	Skill = 20,
	Cost = 1000,
	Color = Color( 217, 164, 65 )
}
BRICKSCRAFTING.BASECONFIG.Tools.Pickaxe[3] = {
	Increase = 20,
	Skill = 50,
	Cost = 100000,
	Color = Color( 184, 216, 231 )
}
BRICKSCRAFTING.BASECONFIG.Tools.Pickaxe[4] = {
	Increase = 50,
	Skill = 100,
	Cost = 1000000,
	Color = Color( 59, 23, 77 )
}

BRICKSCRAFTING.BASECONFIG.Tools.MaxLumberAxeSkill = 100
BRICKSCRAFTING.BASECONFIG.Tools.LumberAxe = {}
BRICKSCRAFTING.BASECONFIG.Tools.LumberAxe[1] = {
	Increase = 5,
	Skill = 10,
	Color = Color( 150, 90, 56 )
}
BRICKSCRAFTING.BASECONFIG.Tools.LumberAxe[2] = {
	Increase = 10,
	Skill = 20,
	Cost = 1000,
	Color = Color( 217, 164, 65 )
}
BRICKSCRAFTING.BASECONFIG.Tools.LumberAxe[3] = {
	Increase = 20,
	Skill = 50,
	Cost = 100000,
	Color = Color( 184, 216, 231 )
}
BRICKSCRAFTING.BASECONFIG.Tools.LumberAxe[4] = {
	Increase = 50,
	Skill = 100,
	Cost = 1000000,
	Color = Color( 59, 23, 77 )
}