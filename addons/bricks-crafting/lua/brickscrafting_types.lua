-- "addons\\bricks-crafting\\lua\\brickscrafting_types.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[ Crafting ]]--
BRICKSCRAFTING.CraftingTypes = {}
BRICKSCRAFTING.CraftingTypes["HelixItem"] = {
    Name = "Helix Item",
    ReqInfo = {
        [1] = { "String", "UniqueID" },
    },
    OnCraft = function( ply, bench, key )
        ply:GetCharacter():GetInventory():Add( BRICKSCRAFTING.CONFIG.Crafting[bench].Items[key].TypeInfo[1] )
    end
}
BRICKSCRAFTING.CraftingTypes["SWEP"] = {
	Name = BRICKSCRAFTING.L("craftingTypeSWEP"),
	ReqInfo = {
		[1] = { "String", BRICKSCRAFTING.L("craftingTypeSWEPWC") },
	},
	UseFunction = function( ply, bench, key )
		ply:Give( BRICKSCRAFTING.CONFIG.Crafting[bench].Items[key].TypeInfo[1] )
	end,
	DropFunction = function( ply, bench, key, pos )
		local ent = ents.Create( "spawned_weapon" )
		ent:SetPos( pos )
		ent:SetWeaponClass( BRICKSCRAFTING.CONFIG.Crafting[bench].Items[key].TypeInfo[1] )
		ent:Setamount( 1 )
		ent:SetModel( BRICKSCRAFTING.CONFIG.Crafting[bench].Items[key].model )
		ent:Spawn()
	end
}
if( BRICKSCRAFTING.LUACONFIG.DarkRP ) then
	BRICKSCRAFTING.CraftingTypes["Money Bag"] = {
		Name = BRICKSCRAFTING.L("craftingTypeMoneyBag"),
		ReqInfo = {
			[1] = { "Int", BRICKSCRAFTING.L("craftingTypeMinReward") },
			[2] = { "Int", BRICKSCRAFTING.L("craftingTypeMaxReward") },
		},
		UseFunction = function( ply, bench, key )
			local RewardAmount = math.random( BRICKSCRAFTING.CONFIG.Crafting[bench].Items[key].TypeInfo[1], BRICKSCRAFTING.CONFIG.Crafting[bench].Items[key].TypeInfo[2] )
			ply:addMoney( RewardAmount )
			ply:NotifyBCS( string.format( BRICKSCRAFTING.L("craftingTypeReward"), DarkRP.formatMoney( RewardAmount ) ) )
		end
	}
end
BRICKSCRAFTING.CraftingTypes["Armor"] = {
	Name = BRICKSCRAFTING.L("craftingTypeArmor"),
	ReqInfo = {
		[1] = { "Int", BRICKSCRAFTING.L("craftingTypeArmor") },
		[2] = { "Int", BRICKSCRAFTING.L("craftingTypeMaxArmor") },
	},
	UseFunction = function( ply, bench, key )
		ply:SetArmor( math.Clamp( ply:Armor()+BRICKSCRAFTING.CONFIG.Crafting[bench].Items[key].TypeInfo[1], 0, BRICKSCRAFTING.CONFIG.Crafting[bench].Items[key].TypeInfo[2] ) )
	end
}
BRICKSCRAFTING.CraftingTypes["Health"] = {
	Name = BRICKSCRAFTING.L("craftingTypeHealth"),
	ReqInfo = {
		[1] = { "Int", BRICKSCRAFTING.L("craftingTypeHealth") },
		[2] = { "Int", BRICKSCRAFTING.L("craftingTypeMaxHealth") },
	},
	UseFunction = function( ply, bench, key )
		ply:SetHealth( math.Clamp( ply:Health()+BRICKSCRAFTING.CONFIG.Crafting[bench].Items[key].TypeInfo[1], 0, BRICKSCRAFTING.CONFIG.Crafting[bench].Items[key].TypeInfo[2] ) )
	end
}
BRICKSCRAFTING.CraftingTypes["Entity"] = {
	Name = BRICKSCRAFTING.L("craftingTypeEntity"),
	ReqInfo = {
		[1] = { "String", BRICKSCRAFTING.L("craftingTypeEntityC") },
	},
	DropFunction = function( ply, bench, key, pos )
		local ent = ents.Create( BRICKSCRAFTING.CONFIG.Crafting[bench].Items[key].TypeInfo[1] )
		if( not IsValid( ent ) ) then return end
		ent:SetPos( pos )
		ent:SetModel( BRICKSCRAFTING.CONFIG.Crafting[bench].Items[key].model )
		ent:CPPISetOwner( ply )
		if( ent.Setowning_ent ) then
			ent:Setowning_ent( ply )
		end
		ent:Spawn()
	end
}
BRICKSCRAFTING.CraftingTypes["Resource"] = {
	Name = BRICKSCRAFTING.L("craftingTypeResource"),
	ReqInfo = {
		[1] = { "String", BRICKSCRAFTING.L("craftingTypeResourceKey") },
		[2] = { "Int", BRICKSCRAFTING.L("craftingTypeResourceAm") },
	},
	OnCraft = function( ply, bench, key )
		local ResourceType = BRICKSCRAFTING.CONFIG.Crafting[bench].Items[key].TypeInfo[1]
		ply:AddBCS_InventoryResource( { [ResourceType] = BRICKSCRAFTING.CONFIG.Crafting[bench].Items[key].TypeInfo[2] } )
		if( BRICKSCRAFTING.CONFIG.Resources[ResourceType] ) then	
			ply:NotifyBCS_Chat( "+" .. (BRICKSCRAFTING.CONFIG.Crafting[bench].Items[key].TypeInfo[2] or 1) .. " " .. (ResourceType or ""), BRICKSCRAFTING.CONFIG.Resources[ResourceType].icon or "" )
		end
	end
}
BRICKSCRAFTING.CraftingTypes["Prop"] = {
	Name = BRICKSCRAFTING.L("craftingTypeProp"),
	DropFunction = function( ply, bench, key, pos )
		local ent = ents.Create( "prop_physics" )
		if( not IsValid( ent ) ) then return end
		ent:SetPos( pos )
		ent:SetModel( BRICKSCRAFTING.CONFIG.Crafting[bench].Items[key].model )
		ent:CPPISetOwner( ply ) 
		ent:Spawn()
	end
}
BRICKSCRAFTING.CraftingTypes["Vehicle"] = {
	Name = BRICKSCRAFTING.L("craftingTypeVehicle"),
	ReqInfo = {
		[1] = { "String", BRICKSCRAFTING.L("craftingTypeVehicleScript") },
	},
	DropFunction = function( ply, bench, key, pos )
		local car = ents.Create("prop_vehicle_jeep_old")
		if( not IsValid( car ) ) then return end
		car:SetModel( BRICKSCRAFTING.CONFIG.Crafting[bench].Items[key].model )
		car:SetKeyValue( "vehiclescript", BRICKSCRAFTING.CONFIG.Crafting[bench].Items[key].TypeInfo[1] )
		car:SetPos( pos )
		car:Spawn()
	end
}

--[[ Rewards ]]--
BRICKSCRAFTING.RewardTypes = {}
if( BRICKSCRAFTING.LUACONFIG.DarkRP ) then
	BRICKSCRAFTING.RewardTypes["Money"] = {
		Name = BRICKSCRAFTING.L("vguiConfigQuestMoney"),
		ReqInfo = {
			[1] = "Int",
		},
		RewardFunc = function( ply, info )
			ply:addMoney( info[1] )
		end
	}
end
BRICKSCRAFTING.RewardTypes["Craftable"] = {
	Name = BRICKSCRAFTING.L("craftingTypeCraftable"),
	ReqInfo = {
		[1] = "String", -- Bench Type
		[2] = "Int", -- Itemkey
	},
	RewardFunc = function( ply, info )
		local AddItemSuccess = true
		for k, v in pairs( info ) do
			for key, val in pairs( v ) do
				local AddItem = ply:AddBCS_InventoryItem( k, key, val )

				if( AddItem != true ) then AddItemSuccess = false end
			end
		end
		if( AddItemSuccess != true ) then return false end
	end
}
BRICKSCRAFTING.RewardTypes["Resources"] = {
	Name = BRICKSCRAFTING.L("vguiConfigResource"),
	ReqInfo = {
		[1] = "Table", -- Resources
	},
	RewardFunc = function( ply, info )
		ply:AddBCS_InventoryResource( info )
	end
}

--[[ Quest ]]--
BRICKSCRAFTING.QuestTypes = {}
BRICKSCRAFTING.QuestTypes["Resource"] = {
	GoalHeader = BRICKSCRAFTING.L("craftingTypeCollectResources"),
	MeetsGoal = function( questInfo, progressInfo )
		if( progressInfo >= questInfo ) then
			return true
		else
			return false
		end
	end
}
BRICKSCRAFTING.QuestTypes["Craft"] = {
	GoalHeader = BRICKSCRAFTING.L("craftingTypeCraftItems"),
	MeetsGoal = function( questInfo, progressInfo )
		for k, v in pairs( questInfo ) do
			if( progressInfo[k] ) then
				if( progressInfo[k] < v ) then
					return false
				end
			else
				return false
			end
		end

		return true
	end
}