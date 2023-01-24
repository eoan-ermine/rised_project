-- "addons\\bricks-crafting\\lua\\brickscrafting\\brickscrafting_inventory.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local ply_meta = FindMetaTable( "Player" )

function ply_meta:GetBCS_Inventory()
	local Inventory = {}

	if( CLIENT ) then
		if( BCS_INVENTORY ) then
			Inventory = BCS_INVENTORY
		end
	elseif( SERVER ) then
		if( self.BCS_Inventory ) then
			Inventory = self.BCS_Inventory
		end
	end

	return Inventory
end

function ply_meta:GetBCS_InventoryResourcesMet( ResourceTable )
	local Inventory = self:GetBCS_Inventory()
	local Resources = (Inventory.Resources or {})
	
	local ResourcesMet = true
	for k, v in pairs( ResourceTable ) do
		if( (Resources[k] or 0) < v ) then
			ResourcesMet = false
			break
		end
	end
	
	if( ResourcesMet != true ) then
		return false
	else
		return true
	end
end

if( SERVER ) then
	util.AddNetworkString( "BCS_Net_UpdateClientInv" )
	function ply_meta:BCS_UpdateClientInv()
		local Inventory = self:GetBCS_Inventory() or {}
		
		net.Start( "BCS_Net_UpdateClientInv" )
			net.WriteTable( Inventory )
		net.Send( self )
	end
	
	function ply_meta:AddBCS_InventoryResource( ResourceTable, dropped )
		local Inventory = self:GetBCS_Inventory()
		local Resources = Inventory.Resources
		if( not Inventory.Resources ) then
			Inventory.Resources = {}
			Resources = {}
		end
		
		for k, v in pairs( ResourceTable ) do
			if( BRICKSCRAFTING.CONFIG.Resources[k] ) then
				Inventory.Resources[k] = (Resources[k] or 0)+v
				hook.Call( "BCS.Hooks.ResourceAdd", GAMEMODE, self, k, v, dropped )
			end
		end
		
		self:SetBCS_Inventory( Inventory )
	end
	
	function ply_meta:RemoveBCS_InventoryResources( ResourceTable )
		local Inventory = self:GetBCS_Inventory()
		local Resources = (Inventory.Resources or {})
		
		for k, v in pairs( ResourceTable ) do
			if( Resources[k] ) then
				Inventory.Resources[k] = Inventory.Resources[k]-v
			end
		end
		
		self:SetBCS_Inventory( Inventory )
	end
	
	function ply_meta:CraftBCS_Inventory( BenchType, ItemKey )
		if( not BRICKSCRAFTING.CONFIG.Crafting[BenchType] ) then return false end
		if( not BRICKSCRAFTING.CONFIG.Crafting[BenchType].Items[ItemKey] ) then return false end
		
		local CraftTable = BRICKSCRAFTING.CONFIG.Crafting[BenchType].Items[ItemKey]
		if( CraftTable.Cost or CraftTable.Skill ) then
			local MiscTable = self:GetBCS_MiscTable()

			if( not MiscTable or not MiscTable.LearntCrafts or not MiscTable.LearntCrafts[BenchType] or not table.HasValue( MiscTable.LearntCrafts[BenchType], ItemKey ) ) then
				self:NotifyBCS( BRICKSCRAFTING.L("notLearntItem") )
				return false
			end
		end
		
		if( self:GetBCS_InventoryResourcesMet( CraftTable.Resources ) != true ) then
			self:NotifyBCS( BRICKSCRAFTING.L("notEnoughResources") )
			return false
		end
		
		local Additem  = self:AddBCS_InventoryItem( BenchType, ItemKey )

		if( AddItem != false ) then
			self:RemoveBCS_InventoryResources( CraftTable.Resources )

			local MaxSkill = ((BRICKSCRAFTING.CONFIG.Crafting[BenchType].Skill or {})[2] or 0)
			if( self:GetBCS_SkillLevel( BenchType ) < MaxSkill ) then
				local ChanceToIncrease = (MaxSkill-(self:GetBCS_SkillLevel( BenchType ) or 0))/MaxSkill
				ChanceToIncrease = (ChanceToIncrease*100)*BRICKSCRAFTING.LUACONFIG.Defaults.CraftingSkillDifficulty
				ChanceToIncrease = math.Clamp( ChanceToIncrease, 5, 100 )
				local Chance = (math.Rand( 0, MaxSkill )/MaxSkill)*100

				if( Chance <= ChanceToIncrease ) then
					self:IncreaseBCS_SkillLevel( BenchType, 1 )
				end
			end

			hook.Call( "BCS.Hooks.CraftItem", GAMEMODE, self, BenchType, ItemKey )

			if( BRICKSCRAFTING.CraftingTypes[CraftTable.Type or ""] and BRICKSCRAFTING.CraftingTypes[CraftTable.Type or ""].OnCraft ) then
				BRICKSCRAFTING.CraftingTypes[CraftTable.Type or ""].OnCraft( self, BenchType, ItemKey )
			end
			return true
		else
			return false
		end
	end

	function ply_meta:AddBCS_InventoryItem( BenchType, ItemKey, Amount )
		if( not BRICKSCRAFTING.CONFIG.Crafting[BenchType] ) then return false end
		if( not BRICKSCRAFTING.CONFIG.Crafting[BenchType].Items[ItemKey] ) then return false end

		local CraftTable = BRICKSCRAFTING.CONFIG.Crafting[BenchType].Items[ItemKey]

		if( BRICKSCRAFTING.CraftingTypes[CraftTable.Type or ""] ) then
			if( not BRICKSCRAFTING.CraftingTypes[CraftTable.Type or ""].UseFunction and not BRICKSCRAFTING.CraftingTypes[CraftTable.Type or ""].DropFunction ) then
				return true
			end
		else
			return false
		end

		local Inventory = self:GetBCS_Inventory()

		local ItemTable = {}
		ItemTable.BenchType = BenchType
		ItemTable.ItemKey = ItemKey
		ItemTable.Amount = (CraftTable.Amount or 1)
		
		for i = 1, (Amount or 1) do
			table.insert( Inventory, ItemTable )
		end
		
		self:SetBCS_Inventory( Inventory )
		
		self:NotifyBCS_Chat( "+" .. (Amount or 1) .. " " .. (CraftTable.Name or ""), "materials/brickscrafting/general_icons/newitem.png" )
		
		return true
	end
	
	function ply_meta:RemoveBCS_InventoryItem( SlotNum, Amount )
		local Inventory = self:GetBCS_Inventory()
		
		if( not Inventory[SlotNum] ) then return false end

		Inventory[SlotNum] = nil
		
		self:SetBCS_Inventory( Inventory )
	end

	util.AddNetworkString( "BCS_Net_DropResource" )
	net.Receive( "BCS_Net_DropResource", function( len, ply )
		if( (ply.BCS_DropCooldown or 0) > CurTime() ) then return end

		ply.BCS_DropCooldown = CurTime()+BRICKSCRAFTING.LUACONFIG.DropCooldown

		local Resource = net.ReadString()
		local Amount = net.ReadInt( 32 )
		
		if( not Resource or not Amount ) then return end
		if( not BRICKSCRAFTING.CONFIG.Resources[Resource] ) then return end
		
		local Inventory = ply:GetBCS_Inventory()
		if( ((Inventory.Resources or {})[Resource] or 0) >= Amount and Amount > 0 ) then
			local ResourceEnt = ents.Create( "brickscrafting_resource" .. string.Replace( string.lower( Resource ), " ", "" ) )
			if( not IsValid( ResourceEnt ) ) then return end
			ResourceEnt:SetPos( ply:GetPos()+(ply:GetForward()*40)+Vector(0,0,40) )
			ResourceEnt:Spawn()
			ResourceEnt:SetAmount( Amount )
			ResourceEnt.dropped = true

			ply:RemoveBCS_InventoryResources( { [Resource] = Amount } )

			ply:NotifyBCS_Chat( "-" .. (Amount or 1) .. " " .. (Resource or ""), BRICKSCRAFTING.CONFIG.Resources[Resource].icon )
		end
	end )
	
	util.AddNetworkString( "BCS_Net_UseItem" )
	net.Receive( "BCS_Net_UseItem", function( len, ply )
		local InvSlot = net.ReadInt( 32 )
		
		if( not InvSlot ) then return end
		
		local Inventory = ply:GetBCS_Inventory()
		if( Inventory[InvSlot] ) then
			if( BRICKSCRAFTING.CONFIG.Crafting[(Inventory[InvSlot].BenchType or "")] ) then
				local ItemConfigTable = BRICKSCRAFTING.CONFIG.Crafting[(Inventory[InvSlot].BenchType or "")].Items[(Inventory[InvSlot].ItemKey or 0)]
				if( ItemConfigTable ) then
					if( BRICKSCRAFTING.CraftingTypes[ItemConfigTable.Type] and BRICKSCRAFTING.CraftingTypes[ItemConfigTable.Type].UseFunction ) then
						BRICKSCRAFTING.CraftingTypes[ItemConfigTable.Type].UseFunction( ply, Inventory[InvSlot].BenchType, Inventory[InvSlot].ItemKey )
						
						ply:RemoveBCS_InventoryItem( InvSlot )
					end
				end
			end
		end
	end )

	util.AddNetworkString( "BCS_Net_DropItem" )
	net.Receive( "BCS_Net_DropItem", function( len, ply )
		local InvSlot = net.ReadInt( 32 )
		
		if( not InvSlot ) then return end
		
		local Inventory = ply:GetBCS_Inventory()
		if( Inventory[InvSlot] ) then
			if( BRICKSCRAFTING.CONFIG.Crafting[(Inventory[InvSlot].BenchType or "")] ) then
				local ItemConfigTable = BRICKSCRAFTING.CONFIG.Crafting[(Inventory[InvSlot].BenchType or "")].Items[(Inventory[InvSlot].ItemKey or 0)]
				if( ItemConfigTable ) then
					if( BRICKSCRAFTING.CraftingTypes[ItemConfigTable.Type] and BRICKSCRAFTING.CraftingTypes[ItemConfigTable.Type].DropFunction ) then
						BRICKSCRAFTING.CraftingTypes[ItemConfigTable.Type].DropFunction( ply, Inventory[InvSlot].BenchType, Inventory[InvSlot].ItemKey, ply:GetPos()+(ply:GetForward()*40)+Vector(0,0,40) )
						
						ply:RemoveBCS_InventoryItem( InvSlot )
					end
				end
			end
		end
	end )
	
	function ply_meta:SetBCS_Inventory( Inventory, nosave )
		if( not Inventory ) then return end
		self.BCS_Inventory = Inventory
		
		self:BCS_UpdateClientInv()
		
		if( not nosave ) then
			self:SaveBCS_Inventory()
		end
	end
	
	function ply_meta:SaveBCS_Inventory()
		local Inventory = self:GetBCS_Inventory()
		if( Inventory != nil ) then
			if( not istable( Inventory ) ) then
				Inventory = {}
			end
		else
			Inventory = {}
		end
		
		local InventoryJSON = util.TableToJSON( Inventory )
		
		if( BRICKSCRAFTING.LUACONFIG.UseMySQL != true ) then
			if( not file.Exists( "brickscrafting/inventory", "DATA" ) ) then
				file.CreateDir( "brickscrafting/inventory" )
			end
			
			file.Write( "brickscrafting/inventory/" .. self:SteamID64() .. ".txt", InventoryJSON )
		else
			self:BCS_UpdateDBValue( "inventory", InventoryJSON )
		end
	end
	
	hook.Add( "PlayerInitialSpawn", "BCSHooks_PlayerInitialSpawn_InventoryLoad", function( ply )
		local InvTable = {}
	
		if( BRICKSCRAFTING.LUACONFIG.UseMySQL != true ) then
			if( file.Exists( "brickscrafting/inventory/" .. ply:SteamID64() .. ".txt", "DATA" ) ) then
				local FileTable = file.Read( "brickscrafting/inventory/" .. ply:SteamID64() .. ".txt", "DATA" )
				FileTable = util.JSONToTable( FileTable )
				
				if( FileTable != nil ) then
					if( istable( FileTable ) ) then
						InvTable = FileTable
					end
				end
			end
			
			ply:SetBCS_Inventory( InvTable, true )
		else
			ply:BCS_FetchDBValue( "inventory", function( value )
				if( value ) then
					local FileTable = util.JSONToTable( value )

					if( FileTable != nil ) then
						if( istable( FileTable ) ) then
							InvTable = FileTable
						end
					end

					ply:SetBCS_Inventory( InvTable, true )
				end
			end )
		end
	end )
elseif( CLIENT ) then
	net.Receive( "BCS_Net_UpdateClientInv", function( len, ply )
		local Inventory = net.ReadTable() or {}

		BCS_INVENTORY = Inventory
		if( IsValid( BCS_BenchMenu ) ) then
			BCS_BenchMenu:RefreshBCS()
			BCS_BenchMenu:RefreshInv()
		end

		if( IsValid( BCS_StorageMenu ) ) then
			BCS_StorageMenu:RefreshInv()
		end
	end )
end