-- "addons\\rised_inventory\\lua\\autorun\\ri_inventory_menu.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if SERVER then return end

local mat_bg = Material( "rised_inventory/bg.png" )
local mat_grid_bg1 = Material( "rised_inventory/grid_bg1.png" )
local mat_grid_bg2 = Material( "rised_inventory/grid_bg2.png" )
local mat_item_slot = Material( "rised_inventory/item_slot.png" )
local mat_melee_slot = Material( "rised_inventory/melee_slot.png" )
local mat_weapon_slot = Material( "rised_inventory/weapon_slot.png" )
local mat_white_effect = Material( "rised_inventory/white_effect.png" )

RISED_INVENTORY_ITEMS = {
	["Crowbar"] = {
		["Width"] = 5,
		["Height"] = 1,
		["Flipped"] = false,
	},
	["swb_ak74"] = {
		["Width"] = 5,
		["Height"] = 1,
		["Flipped"] = false,
	}
}

RISED_INVENTORY_ITEM_TO_USE = {
	"rhc_lockpick",
	"med_drug_amitriptyline",
	"med_drug_cardionix_z2",
	"med_drug_combicillin",
	"med_drug_heptender",
	"med_drug_i306n",
	"med_drug_pulmonifer",
	"med_drug_qurantimycin",
	"med_drug_zenocillin",
	"med_drug_hrzs",
	"med_drug_tire",
	"cm_foodegg1",
	"cm_apple",
	"cm_tortilla",
	"cm_foodburger",
	"cm_bread",
	"cm_toast2",
	"cm_cake",
	"cm_foodbacon1",
	"cm_cheese",
	"cm_meat2",
	"cm_fish3",
	"cm_cookedmeat2",
	"cm_cookedmeat",
	"cm_tomato",
	"cm_pizza",
	"cm_pie",
	"cm_beer",
	"cm_pancake",
	"cm_fish2",
	"cm_meat",
	"cm_milk",
	"cm_toast1",
	"cm_bread_slice",
	"cm_cup2",
	"cm_cola2",
	"cm_cola",
	"cm_cabbage",
	"cm_fish1",
	"cm_fishcooked",
	"cm_foodbacon2",
	"cm_foodburger2",
	"cm_pear",
	"cm_water",
	"cm_sandwich",
	"cm_banana",
	"cm_orange",
	"cm_can2",
	"cm_can3",
	"cm_can1",
	"ammo_103x77",
	"ammo_12x70",
	"ammo_545x39",
	"ammo_762x25",
	"ammo_762x39",
	"ammo_762x54r",
	"ammo_9x19",
	"ammo_9x39",
	"med_health_vial",
	"med_health_kit",
	"rc_combine_food",
}


local supported_clothes_model = {
	"models/player/hl2rp/male_01.mdl",
	"models/player/hl2rp/male_02.mdl",
	"models/player/hl2rp/male_03.mdl",
	"models/player/hl2rp/male_04.mdl",
	"models/player/hl2rp/male_05.mdl",
	"models/player/hl2rp/male_06.mdl",
	"models/player/hl2rp/male_07.mdl",
	"models/player/hl2rp/male_08.mdl",
	"models/player/hl2rp/male_09.mdl",

	"models/player/hl2rp/female_01.mdl",
	"models/player/hl2rp/female_02.mdl",
	"models/player/hl2rp/female_03.mdl",
	"models/player/hl2rp/female_04.mdl",
	"models/player/hl2rp/female_06.mdl",
	"models/player/hl2rp/female_07.mdl",

	"models/player/humans/combine/female_01.mdl",
	"models/player/humans/combine/female_02.mdl",
	"models/player/humans/combine/female_03.mdl",
	"models/player/humans/combine/female_04.mdl",
	"models/player/humans/combine/female_06.mdl",
	"models/player/humans/combine/female_07.mdl",
	"models/player/humans/combine/male_01.mdl",
	"models/player/humans/combine/male_02.mdl",
	"models/player/humans/combine/male_03.mdl",
	"models/player/humans/combine/male_04.mdl",
	"models/player/humans/combine/male_05.mdl",
	"models/player/humans/combine/male_06.mdl",
	"models/player/humans/combine/male_07.mdl",
	"models/player/humans/combine/male_08.mdl",
	"models/player/humans/combine/male_09.mdl"
}

supported_weapons_rifle = {
    "swb_smg",
    "swb_shotgun",
    "swb_ak74",
    "swb_asval",
    "swb_mosin",
    "swb_rpk",
    "swb_sks",
    "swb_toz",
    "swb_cheytac",
    "swb_akm",
    "swb_hammer",
    "swb_irifle",
    "swb_ismg",
    "swb_lmg",
    "swb_mp5k",
    "swb_oicw",
    "swb_snipercombine_assault",
    "swb_snipercombine_heavy",
    "swb_slk789",
    "swb_m60",
    "swb_mp5a5",
}

supported_weapons_pistol = {
    "swb_357",
    "swb_pistol",
    "swb_gsh18",
    "swb_sawedoff",
    "swb_tt",
    "swb_deagle",
}

supported_weapons_melee = {
    "weapon_crowbar",
    "weapon_hl2axe",
    "weapon_hl2bottle",
    "weapon_hl2brokenbottle",
    "weapon_hl2hook",
    "weapon_hl2pan",
    "weapon_hl2pickaxe",
    "weapon_hl2pipe",
    "weapon_hl2pot",
    "weapon_hl2shovel",
    "weapon_knife_cookingmod",
}

ota_weapons = {
    "swb_irifle",
    "swb_ismg",
    "swb_lmg",
    "swb_hammer",
}
							
bags = {
	"Ранец",
	"Рюкзак",
	"Сумка",
}

local function UpdatePlayerModel(player_mdl, cloth, old_x, old_y, x, y, cloth_index, cloth_texture)

	if !IsValid(player_mdl) then return end
	if !table.HasValue(supported_clothes_model, player_mdl:GetModel()) then return end
	
	if cloth == "Torso" then
		if x == 1 and y == 1 and cloth_index then
			if cloth_texture != "" then
				player_mdl.Entity:SetSubMaterial(4,cloth_texture)
				player_mdl.Entity:SetSubMaterial(5,cloth_texture)
			else
				player_mdl.Entity:SetBodygroup(1,cloth_index)
			end
		else
			if old_x == 1 and old_y == 1 then
				player_mdl.Entity:SetBodygroup(1,0)
				player_mdl.Entity:SetSubMaterial(4,nil)
				player_mdl.Entity:SetSubMaterial(5,nil)
			end
		end
	elseif cloth == "Legs" then
		if x == 1 and y == 2 and cloth_index then
			player_mdl.Entity:SetBodygroup(2,cloth_index)
		else
			if old_x == 1 and old_y == 2 then
				player_mdl.Entity:SetBodygroup(2,0)
			end
		end
	elseif cloth == "Hands" then
		if x == 1 and y == 3 and cloth_index then
			player_mdl.Entity:SetBodygroup(3,cloth_index)
		else
			if old_x == 1 and old_y == 3 then
				player_mdl.Entity:SetBodygroup(3,0)
			end
		end
	elseif cloth == "Head" then
		if x == 1 and y == 4 and cloth_index then
			player_mdl.Entity:SetBodygroup(4,cloth_index)
		else
			if old_x == 1 and old_y == 4 then
				player_mdl.Entity:SetBodygroup(4,0)
			end
		end
	elseif cloth == "Bag back" then
		if x == 1 and y == 5 and cloth_index then
			player_mdl.Entity:SetBodygroup(5,cloth_index)
		else
			if old_x == 1 and old_y == 5 then
				player_mdl.Entity:SetBodygroup(5,0)
			end
		end
	elseif cloth == "Glasses" then
		if x == 1 and y == 6 and cloth_index then
			player_mdl.Entity:SetBodygroup(6,cloth_index)
		else
			if old_x == 1 and old_y == 6 then
				player_mdl.Entity:SetBodygroup(6,0)
			end
		end
	elseif cloth == "Bag left" then
		if x == 1 and y == 7 and cloth_index then
			player_mdl.Entity:SetBodygroup(7,cloth_index)
		else
			if old_x == 1 and old_y == 7 then
				player_mdl.Entity:SetBodygroup(7,0)
			end
		end
	elseif cloth == "Bag forward" then
		if x == 1 and y == 8 and cloth_index then
			player_mdl.Entity:SetBodygroup(8,cloth_index)
		else
			if old_x == 1 and old_y == 8 then
				player_mdl.Entity:SetBodygroup(8,0)
			end
		end
	elseif cloth == "ID" then
		if x == 1 and y == 9 and cloth_index then
			player_mdl.Entity:SetBodygroup(9,cloth_index)
		else
			if old_x == 1 and old_y == 9 then
				player_mdl.Entity:SetBodygroup(9,0)
			end
		end
	elseif cloth == "Mask" then
		if x == 1 and y == 10 and cloth_index then
			player_mdl.Entity:SetBodygroup(10,cloth_index)
		else
			if old_x == 1 and old_y == 10 then
				player_mdl.Entity:SetBodygroup(10,0)
			end
		end
	elseif cloth == "Armor" then
		if x == 1 and y == 11 and cloth_index then
			player_mdl.Entity:SetBodygroup(11,cloth_index)
		else
			if old_x == 1 and old_y == 11 then
				player_mdl.Entity:SetBodygroup(11,0)
			end
		end
	elseif cloth == "Armband" then
		if x == 1 and y == 14 and cloth_index then
			player_mdl.Entity:SetBodygroup(14,cloth_index)
		else
			if old_x == 1 and old_y == 14 then
				player_mdl.Entity:SetBodygroup(14,0)
			end
		end
	end
end

net.Receive("RisedInventory.Open", function()
	---=== START ===---
	local netlenth = net.ReadInt(32)
	local fileData = net.ReadData(netlenth)
	local text = util.Decompress(fileData)
	local inv = util.JSONToTable(text)
	local mine = net.ReadInt(10)
	
	hook.Add("PlayerBindPress", "Inventory.PlayerBindPress", function()
		if IsValid(inv_panel) then
			inv_panel:Close()
		end
		hook.Remove("PlayerBindPress", "Inventory.PlayerBindPress")
	end)
	if LocalPlayer():GetNWBool("Opened_Inventory_Panel") then return end
	LocalPlayer():SetNWBool("Opened_Inventory_Panel", true)

	---=== BACK DROP SLOT ===---
	local PANEL = {}
	AccessorFunc(PANEL, "m_ItemPanel", "ItemPanel")
	AccessorFunc(PANEL, "m_Color", "Color")
	function PANEL:Init()
		self.m_Coords = {x = 0, y = 0}
		self:SetSize(ScrW(),ScrH())
		self:SetColor(Color(125,125,125,0))
		self:SetItemPanel(false)

		-- На улицу
		self:Receiver("invitem", function(pnl, item, drop, i, x, y) --Drag-drop
			if drop then
				item = item[1]
				local old_x, old_y = item:GetCoords()
				LocalPlayer():GetInvItem(old_x,old_y):SetItemPanel(false)
				item:SetCoords(x,y)
				
				if old_x == 3 and LocalPlayer():isCP() then return end

				local itm = item:GetItem()
				local cloth = itm:GetClothes()
				local cloth_index = itm:GetClothIndex()
				local cloth_weight = itm:GetWeight()

				UpdatePlayerModel(player_mdl, cloth, old_x, old_y)
				
				if item:GetParent():GetName() == "DFrame" then

					if cloth_weight != nil then
						inv.Weight = math.Round(inv.Weight - cloth_weight, 2)
					end
					
					if mine == 2 then
						--- Чужой инвентарь ---> Земля
						net.Start("RisedInventory.Server")
						net.WriteInt(2,10)
						net.WriteBool(false)
						net.WriteInt(old_x,10)
						net.WriteInt(old_y,10)
						net.SendToServer()
					else
						--- Игрок ---> Земля
						net.Start("RisedInventory.Server")
						net.WriteInt(2,10)
						net.WriteBool(true)
						net.WriteInt(old_x,10)
						net.WriteInt(old_y,10)
						net.SendToServer()
					end
				elseif item:GetParent():GetName() == "StorageSlot" then

					if mine == -1 then
						--- Хранилище ---> Земля
						net.Start("RisedInventory.Server")
						net.WriteInt(6,10)
						net.WriteBool(false)
						net.WriteInt(old_x,10)
						net.WriteInt(old_y,10)
						net.SendToServer()
					else
						--- Коробка ---> Земля
						net.Start("RisedInventory.Server")
						net.WriteInt(4,10)
						net.WriteBool(false)
						net.WriteInt(old_x,10)
						net.WriteInt(old_y,10)
						net.SendToServer()
					end
				end


				item:Remove()
			end
		end, {})
	end
	function PANEL:Paint(w,h)
	end
	vgui.Register("InvBack", PANEL, "DPanel")
	
	---=== BAG SLOT ===---
	local PANEL = {}
	AccessorFunc(PANEL, "m_ItemPanel", "ItemPanel")
	AccessorFunc(PANEL, "m_Color", "Color")
	function PANEL:Init()
		self.m_Coords = {x = 0, y = 0}
		self:SetSize(50,50)
		self:SetColor(Color(125,125,125))
		self:SetItemPanel(false)

		-- В слот сумки
		self:Receiver("invitem", function(pnl, item, drop, i, x, y) --Drag-drop
			if drop then
				item = item[1]
				local x1,y1 = pnl:GetPos()
				local x2,y2 = item:GetPos()
				if math.Dist(x1,y1,x2,y2) <= 2500 then --Find the top left slot.
					if not pnl:GetItemPanel() then
						local itm = item:GetItem()
						local x,y = pnl:GetCoords()
						local cloth = itm:GetClothes()
						local cloth_index = itm:GetClothIndex()
						local cloth_texture = itm:GetClothTexture()
						local old_x, old_y = item:GetCoords()

						if old_x == 3 and LocalPlayer():isCP() then return end

						UpdatePlayerModel(player_mdl, cloth, old_x, old_y)

						if item:GetParent():GetName() == "DFrame" then

							local itmw, itmh = itm:GetSize()
							local full = false
							for i1=x, (x+itmw)-1 do
								if full then break end
								for i2=y, (y+itmh)-1 do
									if _Bag[i1][i2]:GetItemPanel() then --check if the panels in the area are full.
										full = true
										break
									end
								end
							end

							if not full then --If none of them are full then
								for i1=x, (x+itmw)-1 do
									for i2=y, (y+itmh)-1 do
										_Bag[i1][i2]:SetItemPanel(item) -- Tell all the things below it that they are now full of this item.
									end
								end
								item:SetParent(pnl)
								item:SetPos(0,0) --move the item.
								local old_x, old_y = item:GetCoords()
								LocalPlayer():GetInvItem(old_x,old_y):SetItemPanel(false)
								item:SetCoords(x,y)

								item:SetSize(50,50)
								min, max = item.Entity:GetRenderBounds()
								item:SetFOV(25)
								item:SetCamPos( Vector( 1, 1, 1 ) * min:Distance( max ) )
								item:SetLookAt( ( min + max ) / 2 )

								--- Игрок ---> Коробка
								net.Start("RisedInventory.Server")
								net.WriteInt(3,10)
								net.WriteBool(true)
								net.WriteInt(old_x,10)
								net.WriteInt(old_y,10)
								net.WriteInt(x,10)
								net.WriteInt(y,10)
								net.SendToServer()
							end
						elseif item:GetParent():GetName() == "StorageSlot" then

							local itmw, itmh = itm:GetSize()
							local full = false
							for i1=x, (x+itmw)-1 do
								if full then break end
								for i2=y, (y+itmh)-1 do
									if _Bag[i1][i2]:GetItemPanel() then --check if the panels in the area are full.
										full = true
										break
									end
								end
							end

							if not full then --If none of them are full then
								for i1=x, (x+itmw)-1 do
									for i2=y, (y+itmh)-1 do
										_Bag[i1][i2]:SetItemPanel(item) -- Tell all the things below it that they are now full of this item.
									end
								end

								item:SetParent(pnl)
								item:SetPos(0,0)
								local old_x, old_y = item:GetCoords()
								_Bag[old_x][old_y]:SetItemPanel(false)
								item:SetCoords(x,y)

								item:SetSize(50,50)
								min, max = item.Entity:GetRenderBounds()
								item:SetFOV(25)
								item:SetCamPos( Vector( 1, 1, 1 ) * min:Distance( max ) )
								item:SetLookAt( ( min + max ) / 2 )
								
								-- Коробка ---> Коробка
								net.Start("RisedInventory.Server")
								net.WriteInt(3,10)
								net.WriteBool(false)
								net.WriteInt(old_x,10)
								net.WriteInt(old_y,10)
								net.WriteInt(x,10)
								net.WriteInt(y,10)
								net.SendToServer()
							end
						end
					end
				end
			end
		end, {})
	end
	function PANEL:SetCoords(x,y)
		self.m_Coords.x = x
		self.m_Coords.y = y
	end
	function PANEL:GetCoords()
		return self.m_Coords.x, self.m_Coords.y
	end
	local col
	function PANEL:Paint(w,h)
		draw.NoTexture()
		col = self:GetColor()
		local x,y = self:GetCoords()

		surface.SetDrawColor( 125, 125, 125, 150 )
		surface.SetMaterial( mat_item_slot )
		surface.DrawTexturedRect( 0, 0, 50, 50 )
	end
	vgui.Register("BagSlot", PANEL, "DPanel")

	whatDoor = "null"

	---=== SETUP ===---
	local ply = LocalPlayer()
	ply.Inv = {}
	ply.Inv.Wear = {}
	ply.Inv.Equipped = {}
	ply.Inv.Weight = 0
	for i=1,3 do
		ply.Inv.Wear[i] = {}
	end
	for k,v in pairs(ply.Inv.Wear)do
		for i=1,21 do
			ply.Inv.Wear[k][i] = false
		end
	end
	_Bag = {}
	for i=1,4 do
		_Bag[i] = {}
	end
	for k,v in pairs(_Bag)do
		for i=1,4 do
			_Bag[k][i] = false
		end
	end
	local plymeta = FindMetaTable("Player")
	function plymeta:GetInvItem(x,y)
		return self.Inv.Wear[x][y]
	end

	inv_panel = vgui.Create("DFrame")

	---=== INVENTORY SLOT ===---
	local PANEL = {}
	AccessorFunc(PANEL, "m_ItemPanel", "ItemPanel")
	AccessorFunc(PANEL, "m_Color", "Color")
	function PANEL:Init()
		self.m_Coords = {x = 0, y = 0}
		self:SetSize(50,50)
		self:SetColor(Color(125,125,125))
		self:SetItemPanel(false)
		self.material = mat_item_slot
		self.isHighlighted = false

		if mine == 2 then return end

		self:Receiver("invitem", function(pnl, item, drop, i, x, y) --Drag-drop
			if drop then
				item = item[1]
				local x1,y1 = pnl:GetPos()
				local x2,y2 = item:GetPos()
				if math.Dist(x1,y1,x2,y2) <= 2500 then --Find the top left slot.
					if not pnl:GetItemPanel() then
						local itm = item:GetItem()
						local x,y = pnl:GetCoords()
						local cloth = itm:GetClothes()
						local cloth_index = itm:GetClothIndex()
						local cloth_texture = itm:GetClothTexture()
						local old_x, old_y = item:GetCoords()
						
						if cloth == "Torso" and x == 1 and y != 1 then return end
						if cloth == "Legs" and x == 1 and y != 2 then return end
						if cloth == "Hands" and x == 1 and y != 3 then return end
						if cloth == "Head" and x == 1 and y != 4 then return end
						if cloth == "Bag back" and x == 1 and y != 5 then return end
						if cloth == "Glasses" and x == 1 and y != 6 then return end
						if cloth == "Bag left" and x == 1 and y != 7 then return end
						if cloth == "Bag forward" and x == 1 and y != 8 then return end
						if cloth == "ID" and x == 1 and y != 9 then return end
						if cloth == "Mask" and x == 1 and y != 10 then return end
						if cloth == "Armor" and x == 1 and y != 11 then return end
						if cloth == "Armband" and x == 1 and y != 14 then return end
						if cloth == "Watch" and x == 1 and y != 15 then return end
						if cloth == "Flashlight" and x == 1 and y != 16 then return end
						
						if x == 1 then
							if (y == 5 or y == 7 or y == 8) and table.HasValue(bags, itm:GetInfo()) then
							elseif cloth then
							else
								return
							end
						end
						
						if old_x == 3 and LocalPlayer():isCP() then return end
						if x == 3 and y == 1 and !table.HasValue(supported_weapons_rifle, itm:GetWeaponClass()) then return end
						if x == 3 and y == 2 and !table.HasValue(supported_weapons_pistol, itm:GetWeaponClass()) then return end
						if x == 3 and y == 3 and !table.HasValue(supported_weapons_melee, itm:GetWeaponClass()) then return end
						if x == 3 and (y == 1 or y == 2 or y == 3) and (ply:Team() == TEAM_VORTIGAUNTSLAVE or ply:Team() == TEAM_VORTIGAUNT) then return end
						if x == 1 and !table.HasValue(supported_clothes_model, player_mdl:GetModel()) then return end
						if x == 3 and table.HasValue(ota_weapons, itm:GetWeaponClass()) then return end
						
						UpdatePlayerModel(player_mdl, cloth, old_x, old_y, x, y, cloth_index, cloth_texture)

						if item:GetParent():GetName() == "DFrame" then
							local itmw, itmh = itm:GetSize()
							local full = false
							for i1=x, (x+itmw)-1 do
								if full then break end
								for i2=y, (y+itmh)-1 do
									if LocalPlayer():GetInvItem(i1,i2):GetItemPanel() then --check if the panels in the area are full.
										full = true
										break
									end
								end
							end
							if not full then --If none of them are full then
								for i1=x, (x+itmw)-1 do
									for i2=y, (y+itmh)-1 do
										LocalPlayer():GetInvItem(i1,i2):SetItemPanel(item) -- Tell all the things below it that they are now full of this item.
									end
								end
								
								item:SetRoot(pnl) --like a parent, but not a parent.
								item:SetPos(pnl:GetPos()) --move the item.
								local old_x, old_y = item:GetCoords()
								LocalPlayer():GetInvItem(old_x,old_y):SetItemPanel(false)
								item:SetCoords(x,y)

								if x == 3 and (y == 1 or y == 3) then
									item:SetSize(200,70)
									min, max = item.Entity:GetRenderBounds()
									item:SetFOV(45)
									item:SetCamPos( Vector( 0.2, 1.5, 0.5 ) * min:Distance( max ) )
									item:SetLookAt( ( min + max ) / 2 )
								elseif x == 3 and y == 2 then
									item:SetSize(200,70)
									min, max = item.Entity:GetRenderBounds()
									item:SetFOV(75)
									item:SetCamPos( Vector( 0.2, 1.5, 0.5 ) * min:Distance( max ) )
									item:SetLookAt( ( min + max ) / 2 )
								else
									item:SetSize(70,70)
									min, max = item.Entity:GetRenderBounds()
									item:SetFOV(32)
									item:SetCamPos( Vector( 1, 1, 1 ) * min:Distance( max ) )
									item:SetLookAt( ( min + max ) / 2 )
								end
								
								--- Игрок ---> Игрок
								net.Start("RisedInventory.Server")
								net.WriteInt(1,10)
								net.WriteBool(true)
								net.WriteInt(old_x,10)
								net.WriteInt(old_y,10)
								net.WriteInt(x,10)
								net.WriteInt(y,10)
								net.SendToServer()
							end
						elseif item:GetParent():GetName() == "StorageSlot" then
							local itmw, itmh = itm:GetSize()
							local full = false
							for i1=x, (x+itmw)-1 do
								if full then break end
								for i2=y, (y+itmh)-1 do
									if LocalPlayer():GetInvItem(i1,i2):GetItemPanel() then --check if the panels in the area are full.
										full = true
										break
									end
								end
							end
							if not full then --If none of them are full then
								for i1=x, (x+itmw)-1 do
									for i2=y, (y+itmh)-1 do
										LocalPlayer():GetInvItem(i1,i2):SetItemPanel(item) -- Tell all the things below it that they are now full of this item.
									end
								end
								item:SetParent(inv_panel)
								local old_x, old_y = item:GetCoords()
								_Storage[old_x][old_y]:SetItemPanel(false)
								item:SetCoords(x,y)

								if x == 3 and (y == 1 or y == 3) then
									item:SetSize(200,70)
									min, max = item.Entity:GetRenderBounds()
									item:SetFOV(45)
									item:SetCamPos( Vector( 0.2, 1.5, 0.5 ) * min:Distance( max ) )
									item:SetLookAt( ( min + max ) / 2 )
								elseif x == 3 and y == 2 then
									item:SetSize(200,70)
									min, max = item.Entity:GetRenderBounds()
									item:SetFOV(75)
									item:SetCamPos( Vector( 0.2, 1.5, 0.5 ) * min:Distance( max ) )
									item:SetLookAt( ( min + max ) / 2 )
								else
									item:SetSize(70,70)
									min, max = item.Entity:GetRenderBounds()
									item:SetFOV(32)
									item:SetCamPos( Vector( 1, 1, 1 ) * min:Distance( max ) )
									item:SetLookAt( ( min + max ) / 2 )
								end
								
								-- Хранилище ---> Игрок
								if mine == -1 then
									net.Start("RisedInventory.Server")
									net.WriteInt(6,10)
									net.WriteBool(true)
									net.WriteInt(old_x,10)
									net.WriteInt(old_y,10)
									net.WriteInt(x,10)
									net.WriteInt(y,10)
									net.SendToServer()

								-- Холодильник ---> Игрок
								elseif mine == -2 then
									net.Start("RisedInventory.Server")
									net.WriteInt(62,10)
									net.WriteBool(true)
									net.WriteInt(old_x,10)
									net.WriteInt(old_y,10)
									net.WriteInt(x,10)
									net.WriteInt(y,10)
									net.WriteString(whatDoor)
									net.SendToServer()

								-- Коробка ---> Игрок
								else
									net.Start("RisedInventory.Server")
									net.WriteInt(4,10)
									net.WriteBool(true)
									net.WriteInt(old_x,10)
									net.WriteInt(old_y,10)
									net.WriteInt(x,10)
									net.WriteInt(y,10)
									net.SendToServer()
								end
								item:SetRoot(pnl)
								item:SetPos(pnl:GetPos()) --move the item.
							end
						end
					end
				end
			else
				--Something about coloring of hovered slots.
			end
		end, {})
	end
	function PANEL:SetCoords(x,y)
		self.m_Coords.x = x
		self.m_Coords.y = y
	end
	function PANEL:GetCoords()
		return self.m_Coords.x, self.m_Coords.y
	end
	function PANEL:GetHighlighted()
		return self.isHighlighted
	end
	function PANEL:SetHighlighted(value)
		self.isHighlighted = value
	end
	function PANEL:OnCursorEntered()
		self.isHighlighted = true
	end
	function PANEL:OnCursorExited()
		self.isHighlighted = false
	end
	function PANEL:Paint(w,h)

		if self:GetItemPanel() then
			self.isHighlighted = true
		else
			self.isHighlighted = false
		end

		draw.NoTexture()
		if self.isHighlighted then
			surface.SetDrawColor( 200, 100, 0, 175 )
		else
			surface.SetDrawColor( 125, 125, 125, 150 )
		end
		surface.SetMaterial( self.material )
		surface.DrawTexturedRect( 0, 0, w, h )
	end
	vgui.Register("InvSlot", PANEL, "DPanel")

	---=== STORAGE SLOT ===---
	local PANEL = {}
	AccessorFunc(PANEL, "m_ItemPanel", "ItemPanel")
	AccessorFunc(PANEL, "m_Color", "Color")
	function PANEL:Init()
		self.m_Coords = {x = 0, y = 0}
		self:SetSize(50,50)
		self:SetColor(Color(125,125,125))
		self:SetItemPanel(false)

		self:Receiver("invitem", function(pnl, item, drop, i, x, y) --Drag-drop
			if drop then
				
				item = item[1]
				local x1,y1 = pnl:GetPos()
				local x2,y2 = item:GetPos()
				if math.Dist(x1,y1,x2,y2) <= 2500 then --Find the top left slot.
					if not pnl:GetItemPanel() then
						local itm = item:GetItem()
						local x,y = pnl:GetCoords()
						local cloth = itm:GetClothes()
						local cloth_index = itm:GetClothIndex()
						local cloth_texture = itm:GetClothTexture()
						local old_x, old_y = item:GetCoords()
						
						if item:GetParent():GetName() == "DFrame" then

							UpdatePlayerModel(player_mdl, cloth, old_x, old_y)

							local itmw, itmh = itm:GetSize()
							local full = false
							for i1=x, (x+itmw)-1 do
								if full then break end
								for i2=y, (y+itmh)-1 do
									if _Storage[i1][i2]:GetItemPanel() then --check if the panels in the area are full.
										full = true
										break
									end
								end
							end

							if not full then --If none of them are full then
								for i1=x, (x+itmw)-1 do
									for i2=y, (y+itmh)-1 do
										_Storage[i1][i2]:SetItemPanel(item) -- Tell all the things below it that they are now full of this item.
									end
								end
								item:SetParent(pnl)
								item:SetPos(0,0) --move the item.
								local old_x, old_y = item:GetCoords()
								LocalPlayer():GetInvItem(old_x,old_y):SetItemPanel(false)
								item:SetCoords(x,y)

								item:SetSize(50,50)
								min, max = item.Entity:GetRenderBounds()
								item:SetFOV(25)
								item:SetCamPos( Vector( 1, 1, 1 ) * min:Distance( max ) )
								item:SetLookAt( ( min + max ) / 2 )

								-- Игрок ---> Коробка
								if mine == 3 then
									net.Start("RisedInventory.Server")
									net.WriteInt(3,10)
									net.WriteBool(true)
									net.WriteInt(old_x,10)
									net.WriteInt(old_y,10)
									net.WriteInt(x,10)
									net.WriteInt(y,10)
									net.SendToServer()

								-- Игрок ---> Хранилище
								elseif mine == -1 then
									net.Start("RisedInventory.Server")
									net.WriteInt(5,10)
									net.WriteBool(true)
									net.WriteInt(old_x,10)
									net.WriteInt(old_y,10)
									net.WriteInt(x,10)
									net.WriteInt(y,10)
									net.SendToServer()

								-- Игрок ---> Холодильник
								elseif mine == -2 then
									net.Start("RisedInventory.Server")
									net.WriteInt(7,10)
									net.WriteBool(true)
									net.WriteInt(old_x,10)
									net.WriteInt(old_y,10)
									net.WriteInt(x,10)
									net.WriteInt(y,10)
									net.WriteString(whatDoor)
									net.SendToServer()
								end
							end
						elseif item:GetParent():GetName() == "StorageSlot" then

							local itmw, itmh = itm:GetSize()
							local full = false
							for i1=x, (x+itmw)-1 do
								if full then break end
								for i2=y, (y+itmh)-1 do
									if _Storage[i1][i2]:GetItemPanel() then --check if the panels in the area are full.
										full = true
										break
									end
								end
							end

							if not full then --If none of them are full then
								for i1=x, (x+itmw)-1 do
									for i2=y, (y+itmh)-1 do
										_Storage[i1][i2]:SetItemPanel(item) -- Tell all the things below it that they are now full of this item.
									end
								end

								item:SetParent(pnl)
								item:SetPos(0,0)
								local old_x, old_y = item:GetCoords()
								_Storage[old_x][old_y]:SetItemPanel(false)
								item:SetCoords(x,y)

								item:SetSize(50,50)
								min, max = item.Entity:GetRenderBounds()
								item:SetFOV(25)
								item:SetCamPos( Vector( 1, 1, 1 ) * min:Distance( max ) )
								item:SetLookAt( ( min + max ) / 2 )

								-- Коробка ---> Коробка
								if mine == 3 then
									net.Start("RisedInventory.Server")
									net.WriteInt(3,10)
									net.WriteBool(false)
									net.WriteInt(old_x,10)
									net.WriteInt(old_y,10)
									net.WriteInt(x,10)
									net.WriteInt(y,10)
									net.SendToServer()

								-- Хранилище ---> Хранилище
								elseif mine == -1 then
									net.Start("RisedInventory.Server")
									net.WriteInt(5,10)
									net.WriteBool(false)
									net.WriteInt(old_x,10)
									net.WriteInt(old_y,10)
									net.WriteInt(x,10)
									net.WriteInt(y,10)
									net.SendToServer()

								-- Холодильник ---> Холодильник
								elseif mine == -2 then
									net.Start("RisedInventory.Server")
									net.WriteInt(7,10)
									net.WriteBool(false)
									net.WriteInt(old_x,10)
									net.WriteInt(old_y,10)
									net.WriteInt(x,10)
									net.WriteInt(y,10)
									net.WriteString(whatDoor)
									net.SendToServer()
								end
							end
						end

						
					end
				end
			else
				--Something about coloring of hovered slots.
			end
		end, {})
	end
	function PANEL:SetCoords(x,y)
		self.m_Coords.x = x
		self.m_Coords.y = y
	end
	function PANEL:GetCoords()
		return self.m_Coords.x, self.m_Coords.y
	end
	local col
	function PANEL:Paint(w,h)
		surface.SetDrawColor( 125, 125, 125, 150 )
		surface.SetMaterial( mat_item_slot )
		surface.DrawTexturedRect( 0, 0, w, h )
	end

	vgui.Register("StorageSlot", PANEL, "DPanel")

	---=== ITEM PANEL ===---
	PANEL = {}
	AccessorFunc(PANEL, "m_Item", "Item")
	AccessorFunc(PANEL, "m_Root", "Root")
	AccessorFunc(PANEL, "m_Color", "Color")
	function PANEL:Init()
		self.m_Coords = {x=0,y=0}
		self:SetSize(50,50)
		self:SetItem(false) --false means no item.
		self:Droppable("invitem")
		self:SetModel( "models/balloons/balloon_classicheart.mdl" )

		min, max = self.Entity:GetRenderBounds()
		self:SetCamPos( Vector( 0.4, 0.4, 0.4 ) * min:Distance( max ) )
		self:SetLookAt( ( min + max ) / 3.5 )

		function self:LayoutEntity( Entity ) return end
	end
	function PANEL:SetCoords(x,y)
		self.m_Coords.x = x
		self.m_Coords.y = y
	end
	function PANEL:GetCoords()
		return self.m_Coords.x, self.m_Coords.y
	end
	function PANEL:GetIcon()
		return "models/props_borealis/bluebarrel001.mdl"
	end
	local item_info = vgui.Create("DFrame", inv_panel)
	item_info:SetSize(100, 75)
	item_info:SetPos(99999, 99999)
	item_info:MakePopup()
	item_info:SetTitle("")
	item_info:ShowCloseButton(false)
	item_info:SetDraggable(false)
	item_info.info = "none"
	item_info.weight = 0
	item_info.time = 0
	item_info.actions = {}
	item_info.Paint = function(self,w,h)
		if self.info == null then return end
		if istable(self.info) then
			local i = 0
			for k,v in pairs(self.info) do
				draw.SimpleText( v, "TargetIDSmall", 0, i * 20, color_white )
				i = i + 1
			end
		else
			draw.SimpleText( "" .. self.info, "TargetIDSmall", 0, 0, color_white )
		end
		if self.weight != nil then
			draw.SimpleText( "Вес: " .. self.weight .. " кг.", "TargetIDSmall", 0, 15, color_white )
		end
	end
	local info_button = vgui.Create( "DButton", item_info )
	info_button:SetText( "Открыть" )
	info_button:SetPos( 0, 30 )
	info_button:SetSize( 0, 0 )
	info_button:SetEnabled(false)
	info_button.box = nil
	info_button.Paint = function(s,w,h)
		draw.RoundedBox(1, 0, 0, w, h, Color(225,225,225, 125))
		draw.SimpleText( "Открыть", "TargetIDSmall", 0, 15, Color(255,255,255) )
	end
	info_button.DoClick = function()
		if istable(info_button.box) then
			info_button.box.OpenBag()
		end
	end
	function PANEL:OnCursorEntered()
		local itm = self:GetItem()
		item_info.info = itm:GetInfo()
		item_info.weight = itm:GetWeight()
		item_info:SetPos(self:LocalToScreen(0,-50))
		if table.HasValue(bags, itm:GetInfo()) then
			info_button.box = itm
			info_button:SetSize( 50, 15 )
			info_button:SetEnabled(true)
		else
			info_button:SetSize( 0, 0 )
			info_button:SetEnabled(false)
		end

		if istable(item_info.actions) then
			for k,v in pairs(item_info.actions) do
				v:Remove()
			end
		end
		
		if mine == 1 then
			if itm:CanUse() then
				item_info.actions = {}
				local actionName = "Использовать"
				local info_button01 = vgui.Create( "DButton", item_info )
				info_button01:Dock(TOP)
				info_button01:DockMargin(-5, 2, 0, 0)
				info_button01:SetText( "" )
				info_button01.item = itm
				info_button01.action = nil
				info_button01.Paint = function(s,w,h)
					draw.RoundedBox(1, 0, 0, w, h-5, Color(225,225,225, 15))
					draw.SimpleText( actionName, "TargetIDSmall", 0, 0, Color(175,175,175) )
				end
				info_button01.DoClick = function()
					if istable(info_button01.item) then
						info_button01.item.DoActionUse()
					end
				end
				table.insert(item_info.actions, info_button01)
			end
		end

		item_info:MoveToFront()
	end
	function PANEL:OnCursorExited()
		if item_info.actions != nil then
			-- for k,v in pairs(item_info.actions) do
			-- 	v:Remove()
			-- end
			-- item_info.actions = nil
		end
		--item_info:MoveToBack()
	end

	vgui.Register("InvItem", PANEL, "DModelPanel")
	
	-- Инвентарь игрока | чужой инвентарь | коробка
	if mine == 1 or mine == 2 or mine == 3 then

		local inv_panel_offset = 0
		local storage
		local storageName
		local storageSize = 1

		-- Подгрузка даты коробки
		if mine == 3 then
			local netlenth2 = net.ReadInt(32)
			local fileData2 = net.ReadData(netlenth2)
			local text2 = util.Decompress(fileData2)
			storage = util.JSONToTable(text2)
			storageName = net.ReadString()
			storageSize = net.ReadInt(10)

			_Storage = {}

			for i=1,storageSize do
			_Storage[i] = {}
			end
			for k,v in pairs(_Storage)do
				for i=1,storageSize do
					_Storage[k][i] = false
				end
			end


			inv_panel_offset = -200
		end

		local ply_mdl = net.ReadEntity()
		
		inv_panel:SetSize(900, 750)
		inv_panel:SetPos(ScrW()/2 - 450 + inv_panel_offset, ScrH()/2 - 375)
		inv_panel:SetTitle("")
		inv_panel:MakePopup()
		inv_panel:SetBackgroundBlur(false)
		inv_panel.startTime = SysTime()
		inv_panel.Paint = function(s,w,h)
			Derma_DrawBackgroundBlur(s, s.startTime)
			draw.RoundedBox(1,0,0,w,h,Color(0,0,0,190))
			if mine == 1 then
				draw.SimpleText( "Вес: " .. inv.Weight .. " кг.", "marske4", 500, 600, color_white )
			end
			draw.SimpleText( "Основное оружие", "marske4", wslot01_x, wslot01_y, color_white )
			draw.SimpleText( "Дополнительное оружие", "marske4", wslot02_x, wslot02_y, color_white )
			draw.SimpleText( "Холодное оружие", "marske4", wslot03_x, wslot03_y, color_white )

			surface.SetDrawColor( 255, 255, 255, 255 )
			draw.SimpleText( "Головной убор", "marske4", slot04_x, slot04_y, color_white )
			draw.SimpleText( "Маска", "marske4", slot10_x, slot10_y, color_white )
			draw.SimpleText( "Очки", "marske4", slot06_x, slot06_y, color_white )
			draw.SimpleText( "Броня", "marske4", slot11_x, slot11_y, color_white )
			draw.SimpleText( "Верхняя одежда", "marske4", slot01_x, slot01_y, color_white )
			draw.SimpleText( "Штаны", "marske4", slot02_x, slot02_y, color_white )
			draw.SimpleText( "Пропуск", "marske4", slot09_x, slot09_y, color_white )
			draw.SimpleText( "Перчатки", "marske4", slot03_x, slot03_y, color_white )
			draw.SimpleText( "Повязка", "marske4", slot14_x, slot14_y, color_white )

			draw.SimpleText( "Часы", "marske4", slot15_x, slot15_y, color_white )
			draw.SimpleText( "Фонарик", "marske4", slot16_x, slot16_y, color_white )
		end

		for k,v in pairs(ply.Inv.Wear) do
			for i=1,21 do
				if k == 1 and i == 1 then -- Torso
					ply.Inv.Wear[k][i] = vgui.Create("InvSlot", inv_panel)
					slot01_x = 315
					slot01_y = 275
					ply.Inv.Wear[k][i]:SetPos(slot01_x,slot01_y)
					ply.Inv.Wear[k][i]:SetCoords(k,i)
					ply.Inv.Wear[k][i].material = mat_item_slot
				elseif k == 1 and i == 14 then -- Armband
					ply.Inv.Wear[k][i] = vgui.Create("InvSlot", inv_panel)
					slot14_x = 300
					slot14_y = 200
					ply.Inv.Wear[k][i]:SetPos(slot14_x,slot14_y)
					ply.Inv.Wear[k][i]:SetCoords(k,i)
					ply.Inv.Wear[k][i].material = mat_item_slot
				elseif k == 1 and i == 2 then -- Legs
					ply.Inv.Wear[k][i] = vgui.Create("InvSlot", inv_panel)
					slot02_x = 125
					slot02_y = 400
					ply.Inv.Wear[k][i]:SetPos(slot02_x,slot02_y)
					ply.Inv.Wear[k][i]:SetCoords(k,i)
					ply.Inv.Wear[k][i].material = mat_item_slot
				elseif k == 1 and i == 3 then -- Hands
					ply.Inv.Wear[k][i] = vgui.Create("InvSlot", inv_panel)
					slot03_x = 65
					slot03_y = 325
					ply.Inv.Wear[k][i]:SetPos(slot03_x,slot03_y)
					ply.Inv.Wear[k][i]:SetCoords(k,i)
					ply.Inv.Wear[k][i].material = mat_item_slot
				elseif k == 1 and i == 4 then -- Head
					ply.Inv.Wear[k][i] = vgui.Create("InvSlot", inv_panel)
					slot04_x = 125
					slot04_y = 50
					ply.Inv.Wear[k][i]:SetPos(slot04_x,slot04_y)
					ply.Inv.Wear[k][i]:SetCoords(k,i)
					ply.Inv.Wear[k][i].material = mat_item_slot
				elseif k == 1 and i == 6 then -- Glasses
					ply.Inv.Wear[k][i] = vgui.Create("InvSlot", inv_panel)
					slot06_x = 275
					slot06_y = 75
					ply.Inv.Wear[k][i]:SetPos(slot06_x,slot06_y)
					ply.Inv.Wear[k][i]:SetCoords(k,i)
					ply.Inv.Wear[k][i].material = mat_item_slot
				elseif k == 1 and i == 9 then -- ID
					ply.Inv.Wear[k][i] = vgui.Create("InvSlot", inv_panel)
					slot09_x = 300
					slot09_y = 375
					ply.Inv.Wear[k][i]:SetPos(slot09_x,slot09_y)
					ply.Inv.Wear[k][i]:SetCoords(k,i)
				elseif k == 1 and i == 10 then -- Mask
					ply.Inv.Wear[k][i] = vgui.Create("InvSlot", inv_panel)
					slot10_x = 275
					slot10_y = 125
					ply.Inv.Wear[k][i]:SetPos(slot10_x,slot10_y)
					ply.Inv.Wear[k][i]:SetCoords(k,i)
					ply.Inv.Wear[k][i].material = mat_item_slot
				elseif k == 1 and i == 11 then -- Armor
					ply.Inv.Wear[k][i] = vgui.Create("InvSlot", inv_panel)
					slot11_x = 100
					slot11_y = 200
					ply.Inv.Wear[k][i]:SetPos(slot11_x,slot11_y)
					ply.Inv.Wear[k][i]:SetCoords(k,i)
					ply.Inv.Wear[k][i].material = mat_item_slot

				--== Wears ==--
				elseif k == 1 and i == 5 then -- Bag back
					ply.Inv.Wear[k][i] = vgui.Create("InvSlot", inv_panel)
					slot05_x = 300
					slot05_y = 250
					ply.Inv.Wear[k][i]:SetPos(225,600)
					ply.Inv.Wear[k][i]:SetCoords(k,i)
					ply.Inv.Wear[k][i].material = mat_item_slot
				elseif k == 1 and i == 7 then -- Bag left
					ply.Inv.Wear[k][i] = vgui.Create("InvSlot", inv_panel)
					slot07_x = 300
					slot07_y = 250
					ply.Inv.Wear[k][i]:SetPos(325,600)
					ply.Inv.Wear[k][i]:SetCoords(k,i)
					ply.Inv.Wear[k][i].material = mat_item_slot
				elseif k == 1 and i == 8 then -- Bag forward
					ply.Inv.Wear[k][i] = vgui.Create("InvSlot", inv_panel)
					slot08_x = 300
					slot08_y = 250
					ply.Inv.Wear[k][i]:SetPos(425,600)
					ply.Inv.Wear[k][i]:SetCoords(k,i)
					ply.Inv.Wear[k][i].material = mat_item_slot

				--== Tools ==--
				elseif k == 1 and i == 15 then -- Watch
					ply.Inv.Wear[k][i] = vgui.Create("InvSlot", inv_panel)
					slot15_x = 50
					slot15_y = 660
					ply.Inv.Wear[k][i]:SetPos(slot15_x,slot15_y)
					ply.Inv.Wear[k][i]:SetCoords(k,i)
					ply.Inv.Wear[k][i].material = mat_item_slot
				elseif k == 1 and i == 16 then -- Flashlight
					ply.Inv.Wear[k][i] = vgui.Create("InvSlot", inv_panel)
					slot16_x = 110
					slot16_y = 660
					ply.Inv.Wear[k][i]:SetPos(slot16_x,slot16_y)
					ply.Inv.Wear[k][i]:SetCoords(k,i)
					ply.Inv.Wear[k][i].material = mat_item_slot

				--== Weapon Slots ==--

				elseif k == 3 and i == 1 then -- Primary weapon
					ply.Inv.Wear[k][i] = vgui.Create("InvSlot", inv_panel)
					wslot01_x = 480
					wslot01_y = 50
					ply.Inv.Wear[k][i]:SetPos(wslot01_x,wslot01_y)
					ply.Inv.Wear[k][i]:SetSize(200,70)
					ply.Inv.Wear[k][i]:SetCoords(k,i)
					ply.Inv.Wear[k][i].material = mat_weapon_slot
				elseif k == 3 and i == 2 then -- Secondary weapon
					ply.Inv.Wear[k][i] = vgui.Create("InvSlot", inv_panel)
					wslot02_x = 680
					wslot02_y = 50
					ply.Inv.Wear[k][i]:SetPos(wslot02_x,wslot02_y)
					ply.Inv.Wear[k][i]:SetSize(200,70)
					ply.Inv.Wear[k][i]:SetCoords(k,i)
					ply.Inv.Wear[k][i].material = mat_weapon_slot
				elseif k == 3 and i == 3 then -- Melee weapon
					ply.Inv.Wear[k][i] = vgui.Create("InvSlot", inv_panel)
					wslot03_x = 720
					wslot03_y = 125
					ply.Inv.Wear[k][i]:SetPos(wslot03_x,wslot03_y)
					ply.Inv.Wear[k][i]:SetSize(140,51)
					ply.Inv.Wear[k][i]:SetCoords(k,i)
					ply.Inv.Wear[k][i].material = mat_melee_slot

				elseif k == 2 then
					if i <= 7 then
						local offset = i
						ply.Inv.Wear[k][i] = vgui.Create("InvSlot", inv_panel)
						ply.Inv.Wear[k][i]:SetPos(410 + offset*54,185)
						ply.Inv.Wear[k][i]:SetSize(70,70)
						ply.Inv.Wear[k][i]:SetCoords(k,i)
					elseif i <= 14 then
						local offset = i - 7
						ply.Inv.Wear[k][i] = vgui.Create("InvSlot", inv_panel)
						ply.Inv.Wear[k][i]:SetPos(410 + offset*54,185 + 55)
						ply.Inv.Wear[k][i]:SetSize(70,70)
						ply.Inv.Wear[k][i]:SetCoords(k,i)
					end
				end
			end
		end
		inv_panel.OnClose = function()
			LocalPlayer():SetNWBool("Opened_Inventory_Panel", false)
		end

		local inv_panel1 = vgui.Create("DFrame", inv_panel)
		inv_panel1:SetSize(ScrW(), ScrH())
		inv_panel1:MakePopup()
		inv_panel1:MoveToBack()
		inv_panel1:SetTitle("")
		inv_panel1:ShowCloseButton(false)
		inv_panel1.Paint = function(s,w,h)
			if inv_panel1:IsActive() then
				inv_panel:Close()
			end
		end

		backDropPanel = vgui.Create("InvBack", inv_panel1)

		local effect_bg = vgui.Create("DFrame", inv_panel)
		effect_bg:SetPos(0, 0)
		effect_bg:SetSize(inv_panel:GetSize())
		effect_bg:SetTitle("")
		effect_bg:SetDraggable(false)
		effect_bg:ShowCloseButton(false)
		effect_bg:MoveToBack()
		effect_bg.Paint = function(s,w,h)
			surface.SetDrawColor( 125, 125, 125, 54 )
			surface.SetMaterial( mat_white_effect )
			surface.DrawTexturedRect( 0, 0, w, h )
		end

		local grid_bg = vgui.Create("DFrame", inv_panel)
		grid_bg:SetPos(470, 190)
		grid_bg:SetSize(384, 330)
		grid_bg:SetTitle("")
		grid_bg:SetDraggable(false)
		grid_bg:ShowCloseButton(false)
		grid_bg:MoveToBack()
		grid_bg.Paint = function(s,w,h)
			surface.SetDrawColor( 125, 125, 125, 150 )
			surface.SetMaterial( mat_grid_bg1 )
			surface.DrawTexturedRect( 0, 0, w, h )
		end
		
		player_mdl = vgui.Create( "DModelPanel", inv_panel )
		player_mdl:SetPos(150,75)
		player_mdl:SetSize(150,500)
		player_mdl:SetModel(ply_mdl:GetModel())
		player_mdl.Entity:SetBodygroup(0, ply_mdl:GetBodygroup(0))
		player_mdl.Entity:SetBodygroup(1, ply_mdl:GetBodygroup(1))
		player_mdl.Entity:SetBodygroup(2, ply_mdl:GetBodygroup(2))
		player_mdl.Entity:SetBodygroup(3, ply_mdl:GetBodygroup(3))
		player_mdl.Entity:SetBodygroup(4, ply_mdl:GetBodygroup(4))
		player_mdl.Entity:SetBodygroup(5, ply_mdl:GetBodygroup(5))
		player_mdl.Entity:SetBodygroup(6, ply_mdl:GetBodygroup(6))
		player_mdl.Entity:SetBodygroup(7, ply_mdl:GetBodygroup(7))
		player_mdl.Entity:SetBodygroup(8, ply_mdl:GetBodygroup(8))
		player_mdl.Entity:SetBodygroup(9, ply_mdl:GetBodygroup(9))
		player_mdl.Entity:SetBodygroup(10, ply_mdl:GetBodygroup(10))
		player_mdl.Entity:SetBodygroup(11, ply_mdl:GetBodygroup(11))
		player_mdl.Entity:SetBodygroup(12, ply_mdl:GetBodygroup(12))
		player_mdl.Entity:SetBodygroup(13, ply_mdl:GetBodygroup(13))
		player_mdl.Entity:SetBodygroup(14, ply_mdl:GetBodygroup(14))
		player_mdl.Entity:SetSubMaterial(4,ply_mdl:GetSubMaterial(4))
		player_mdl.Entity:SetSubMaterial(5,ply_mdl:GetSubMaterial(5))
		player_mdl:SetFOV( 15 )
		player_mdl:SetCamPos( Vector( 90, 0, 55 ) )
		local mn, mx = player_mdl.Entity:GetRenderBounds()
		player_mdl:SetLookAt( (mn + mx) * 0.5 )
		function player_mdl:LayoutEntity( Entity ) return end

		if mine == 3 then
			inv_panel_box = vgui.Create("DFrame")
			inv_panel_box:SetSize(200, 250)
			inv_panel_box:SetPos(ScrW() - 700,ScrH()/2 - 125)
			inv_panel_box:SetTitle(storageName)
			inv_panel_box:MakePopup()
			inv_panel_box:ShowCloseButton(false)
			inv_panel_box.Paint = function(s,w,h)
				draw.RoundedBox(1,0,0,w,h,Color(0,0,0,140))
				
				surface.SetDrawColor( 255, 255, 255, 255 )
			end
			for k,v in pairs(_Storage) do
				for i = 1,storageSize do
					_Storage[k][i] = vgui.Create("StorageSlot", inv_panel_box)
					_Storage[k][i]:SetPos(-45 + i*60,50 + (k-1)*60)
					_Storage[k][i]:SetCoords(k,i)
				end
			end
			inv_panel_box.OnClose = function()
				if IsValid(inv_panel) then
					inv_panel:Close()
				end
			end
			inv_panel.OnClose = function()
				LocalPlayer():SetNWBool("Opened_Inventory_Panel", false)
				if IsValid(inv_panel_box) then
					inv_panel_box:Close()
				end
			end

			local effect_bg1 = vgui.Create("DFrame", inv_panel_box)
			effect_bg1:SetPos(0, 0)
			effect_bg1:SetSize(inv_panel_box:GetSize())
			effect_bg1:SetTitle("")
			effect_bg1:SetDraggable(false)
			effect_bg1:ShowCloseButton(false)
			effect_bg1:MoveToBack()
			effect_bg1.Paint = function(s,w,h)
				surface.SetDrawColor( 125, 125, 125, 150 )
				surface.SetMaterial( mat_white_effect )
				surface.DrawTexturedRect( 0, 0, w, h )
			end
		end

		function IsRoomFor(item, set_x, set_y)
			pnl = LocalPlayer().Inv.Wear[set_x][set_y]
			if not pnl:GetItemPanel() then
				local x,y = pnl:GetCoords()
				local itmw, itmh = item:GetSize()
				local full = false
				for i1=x, (x+itmw)-1 do
					if full then break end
					for i2=y, (y+itmh)-1 do
						if LocalPlayer():GetInvItem(i1,i2):GetItemPanel() then
							full = true
							break
						end
					end
				end
				if !full then
					return pnl
				end
			end

			return false
		end

		function PickupItem(item)
			local set_x, set_y = item:GetPos()

			local place = IsRoomFor(item, set_x, set_y)
			if place then
				
				local itm = vgui.Create("InvItem", inv_panel)
				itm:SetItem(item)
				itm:SetModel( item.Model )
				itm.Entity:SetSkin( item.Skin )
				itm:SetRoot(place)
				itm:SetPos(place:GetPos())
				
				if set_x == 3 and (set_y == 1 or set_y == 3) then
					itm:SetSize(200,70)
					min, max = itm.Entity:GetRenderBounds()
					itm:SetFOV(45)
					itm:SetCamPos( Vector( 0.2, 1.5, 0.5 ) * min:Distance( max ) )
					itm:SetLookAt( ( min + max ) / 2 )
				elseif set_x == 3 and set_y == 2 then
					itm:SetSize(200,70)
					min, max = itm.Entity:GetRenderBounds()
					itm:SetFOV(75)
					itm:SetCamPos( Vector( 0.2, 1.5, 0.5 ) * min:Distance( max ) )
					itm:SetLookAt( ( min + max ) / 2 )
				else
					itm:SetSize(65,65)
					min, max = itm.Entity:GetRenderBounds()
					itm:SetFOV(32)
					itm:SetCamPos( Vector( 1, 1, 1 ) * min:Distance( max ) )
					itm:SetLookAt( ( min + max ) / 2 )
				end
				
				local x,y = place:GetCoords()
				local itmw, itmh = item:GetSize()
				for i1=x, (x+itmw)-1 do
					for i2=y, (y+itmh)-1 do
						if LocalPlayer():GetInvItem(i1,i2) then LocalPlayer():GetInvItem(i1,i2):SetItemPanel(itm) end
						itm:SetCoords(i1,i2)
					end
				end
				
				return true
				
			else
				return false
			end
		end

		if inv.Wear != nil then
			for k,v in pairs(inv.Wear) do
			    for i=1,21 do
			    	if istable(inv.Wear[k][i]) then
						local Item = {}
						Item.Name = inv.Wear[k][i].PrintName
						Item.Model = inv.Wear[k][i].Model
						Item.Skin = inv.Wear[k][i].Skin
						Item.x = k
						Item.y = i
						function Item:GetPos()
							return k, i
						end
						function Item:GetSize()
							return 1, 1
						end
						function Item:GetIcon()
							return Material("entities/weapon_pistol.png")
						end
						function Item:GetClothes()
							return inv.Wear[k][i].Clothes
						end
						function Item:GetClothIndex()
							return inv.Wear[k][i].Index
						end
						function Item:GetClothTexture()
							return inv.Wear[k][i].Texture
						end
						function Item:GetWidth()
							return inv.Wear[k][i].Texture
						end
						function Item:GetWeaponClass()
							if inv.Wear[k][i].DT != nil then
								return inv.Wear[k][i].DT.WeaponClass
							else
								return ""
							end
						end
						function Item:OpenBag()

							local bag_x = table.Count(_Bag[1])
							local bag_y = table.Count(_Bag)

							inv_panel_bag = vgui.Create("DFrame")
							inv_panel_bag:SetSize(25 + 60  * bag_x, 75 + 60 * bag_y)
							inv_panel_bag:SetPos(ScrW() - 700,ScrH()/2 - 125)
							inv_panel_bag:SetTitle("Маленькая коробка")
							inv_panel_bag:MakePopup()
							inv_panel_bag:ShowCloseButton( true )
							inv_panel_bag:SetDraggable( true )
							inv_panel_bag.time = 0
							inv_panel_bag.focused = true
							inv_panel_bag.Paint = function(self,w,h)
								draw.RoundedBox(1,0,0,w,h,Color(45,45,45,145))
								draw.RoundedBox(1,0,0,w,25,Color(55,55,55,145))
								
								surface.SetDrawColor( 255, 255, 255, 255 )

								if self.time <= CurTime() and !self.focused then
									self.time = CurTime() + 2
									self:MoveToFront()
								end
							end
							inv_panel_bag.OnClose = function()
								if IsValid(inv_panel) then
									inv_panel:Close()
								end
							end
							inv_panel.OnClose = function()
								LocalPlayer():SetNWBool("Opened_Inventory_Panel", false)
								if IsValid(inv_panel_bag) then
									inv_panel_bag:Close()
								end
							end

							function inv_panel_bag:OnFocusChanged(gained)
								inv_panel_bag.focused = gained
							end

							for k,v in pairs(_Bag) do
								for i,bag in pairs(_Bag[k]) do
									_Bag[k][i] = vgui.Create("BagSlot", inv_panel_bag)
									_Bag[k][i]:SetPos(-45 + i*60,50 + (k-1)*60)
									_Bag[k][i]:SetCoords(k,i)
								end
							end
						end
						function Item:GetInfo()
							if inv.Wear[k][i].PrintName == "Food" then
								return inv.Wear[k][i].FoodName
							end
							if inv.Wear[k][i].Notepad_ID != nil then
								return "Док - " .. inv.Wear[k][i].Notepad_ID
							end
							if inv.Wear[k][i].PrintName == "Spawned Weapon" and inv.Wear[k][i].Class != "med_card" then
								return inv.Wear[k][i].DT.WeaponName
							end
							return inv.Wear[k][i].PrintName
						end
						function Item:CanUse()
							if table.HasValue(RISED_INVENTORY_ITEM_TO_USE, inv.Wear[k][i].Class) then
								return true
							end
							return false
						end
						function Item:DoActionUse()
							net.Start("RisedInventory.Server")
							net.WriteInt(71,10)
							net.WriteBool(true)
							net.WriteInt(Item.x,10)
							net.WriteInt(Item.y,10)
							net.SendToServer()
							inv_panel:Close()
						end
						function Item:DoActionDelete()
							net.Start("RisedInventory.Server")
							net.WriteInt(72,10)
							net.WriteBool(true)
							net.WriteInt(k,10)
							net.WriteInt(i,10)
							net.SendToServer()
							inv_panel:Close()
						end
						function Item:GetMedData()
							if inv.Wear[k][i].PrintName == "Мед карта" then
								local tbl = {
									inv.Wear[k][i].MedCard_Person,
									inv.Wear[k][i].MedCard_Height,
									inv.Wear[k][i].MedCard_Weight,
									inv.Wear[k][i].MedCard_Physics,
									inv.Wear[k][i].MedCard_Mental,
									inv.Wear[k][i].MedCard_BloodGroup,
									inv.Wear[k][i].MedCard_Disease,
								}
								return tbl
							end
							return {}
						end
						function Item:GetWeight()
							return inv.Wear[k][i].Weight
						end

			    		PickupItem(Item)
			    	end
			    end
			end
		end

		function IsRoomForStorage(item, set_x, set_y)
			pnl = _Storage[set_x][set_y]
			if not pnl:GetItemPanel() then
				local x,y = pnl:GetCoords()
				local itmw, itmh = item:GetSize()
				local full = false
				for i1=x, (x+itmw)-1 do
					if full then break end
					for i2=y, (y+itmh)-1 do
						if _Storage[i1][i2]:GetItemPanel() then
							full = true
							break
						end
					end
				end
				if !full then
					return pnl
				end
			end

			return false
		end

		function PlaceStorageItem(item)
			local set_x, set_y = item:GetPos()

			local place = IsRoomForStorage(item, set_x, set_y)
			if place then
				
				local itm = vgui.Create("InvItem", inv_panel_box)
				itm:SetItem(item)
				itm:SetModel( item.Model )
				itm.Entity:SetSkin( item.Skin )
				itm:SetParent(place)
				itm:SetPos(0,0)

				itm:SetSize(50,50)
				min, max = itm.Entity:GetRenderBounds()
				itm:SetFOV(25)
				itm:SetCamPos( Vector( 1, 1, 1 ) * min:Distance( max ) )
				itm:SetLookAt( ( min + max ) / 2 )
				
				local x,y = place:GetCoords()
				local itmw, itmh = item:GetSize()
				for i1=x, (x+itmw)-1 do
					for i2=y, (y+itmh)-1 do
						if LocalPlayer():GetInvItem(i1,i2) then LocalPlayer():GetInvItem(i1,i2):SetItemPanel(itm) end
						itm:SetCoords(i1,i2)
					end
				end
				
				return true
				
			else
				return false
			end
		end
		
		if storage != nil then
			for k,v in pairs(storage) do
			    for i = 1,3 do
			    	if istable(storage[k][i]) then
						local Item = {}
						Item.Name = storage[k][i].PrintName
						Item.Model = storage[k][i].Model
						Item.Skin = storage[k][i].Skin
						function Item:GetPos()
							return k, i
						end
						function Item:GetSize()
							return 1, 1
						end
						function Item:GetIcon()
							return Material("entities/weapon_pistol.png")
						end
						function Item:GetClothes()
							return storage[k][i].Clothes
						end
						function Item:GetClothIndex()
							return storage[k][i].Index
						end
						function Item:GetClothTexture()
							return storage[k][i].Texture
						end
						function Item:GetWeaponClass()
							if storage[k][i].DT != nil then
								return storage[k][i].DT.WeaponClass
							else
								return ""
							end
						end
						function Item:GetInfo()
							if storage[k][i].PrintName == "Food" then
								return storage[k][i].FoodName
							end
							if storage[k][i].Notepad_ID != nil then
								return storage[k][i].Notepad_ID
							end
							if storage[k][i].PrintName == "Spawned Weapon" then
								return string.sub(storage[k][i].DT.WeaponClass, 5, 20 )
							end
							if storage[k][i].PrintName == "ID карта" then
								return storage[k][i].IDCard_Person
							end
							return storage[k][i].PrintName
						end
						function Item:GetMedData()
							if storage[k][i].PrintName == "Мед карта" then
								local tbl = {
									storage[k][i].MedCard_Person,
									storage[k][i].MedCard_Height,
									storage[k][i].MedCard_Weight,
									storage[k][i].MedCard_Physics,
									storage[k][i].MedCard_Mental,
									storage[k][i].MedCard_BloodGroup,
									storage[k][i].MedCard_Disease,
								}
								return tbl
							end
							return {}
						end
						function Item:GetWeight()
							return storage[k][i].Weight
						end

			    		PlaceStorageItem(Item)
			    	end
			    end
			end
		end
	
	-- Хранилища
	elseif mine == -1 then
		
		local netlenth2 = net.ReadInt(32)
		local fileData2 = net.ReadData(netlenth2)
		local text2 = util.Decompress(fileData2)
		local storage = util.JSONToTable(text2)

		_Storage = {}

		for i=1,5 do
	      _Storage[i] = {}
		end
		for k,v in pairs(_Storage)do
		    for i=1,5 do
		        _Storage[k][i] = false
		    end
		end

		function plymeta:GetStorageItem(x,y)
		    return _Storage[x][y]
		end

		inv_panel:SetSize(565, 100)
		inv_panel:SetPos(ScrW()/2 - 282.5, ScrH()/2 + 175)
		inv_panel:SetTitle("")
		inv_panel:MakePopup()
		inv_panel.Paint = function(s,w,h)
			draw.RoundedBox(1,0,0,w,h,Color(0,0,0,190))
			draw.SimpleText( "Личные вещи", "marske4", 10, 5, color_white )
		end
		for k,v in pairs(ply.Inv.Wear) do
			for i=1,21 do
				if k != 3 then
					ply.Inv.Wear[k][i] = vgui.Create("InvSlot", inv_panel)
					ply.Inv.Wear[k][i]:SetPos((i-1)*50 + 10,38)
					ply.Inv.Wear[k][i]:SetCoords(k,i)
				end
			end
		end

		inv_panel_box = vgui.Create("DFrame")
		inv_panel_box:SetSize(320, 355)
		inv_panel_box:SetPos(ScrW()/2 - 160,ScrH()/2 - 225)
		inv_panel_box:SetTitle("Хранилище")
		inv_panel_box:MakePopup()
		inv_panel_box:ShowCloseButton( false )
		inv_panel_box:SetDraggable( false )
		inv_panel_box.Paint = function(s,w,h)
			draw.RoundedBox(1,0,0,w,h,Color(0,0,0,190))
			surface.SetDrawColor( 255, 255, 255, 255 )
		end
		for k,v in pairs(_Storage) do
			for i = 1,5 do
				_Storage[k][i] = vgui.Create("StorageSlot", inv_panel_box)
				_Storage[k][i]:SetPos(-45 + i*60,50 + (k-1)*60)
				_Storage[k][i]:SetCoords(k,i)
			end
		end
		inv_panel_box.OnClose = function()
			if IsValid(inv_panel) then
				inv_panel:Close()
			end
		end
		inv_panel.OnClose = function()
			LocalPlayer():SetNWBool("Opened_Inventory_Panel", false)
			if IsValid(inv_panel_box) then
				inv_panel_box:Close()
			end
		end


		local inv_panel1 = vgui.Create("DFrame", inv_panel)
		inv_panel1:SetSize(ScrW(), ScrH())
		inv_panel1:MakePopup()
		inv_panel1:MoveToBack()
		inv_panel1:SetTitle("")
		inv_panel1:ShowCloseButton(false)
		inv_panel1.Paint = function(s,w,h)
			if inv_panel1:IsActive() then inv_panel:Close() inv_panel_box:Close() end
		end

		backDropPanel = vgui.Create("InvBack", inv_panel1)

		function IsRoomFor(item, set_x, set_y)
			if set_x == 2 then
				pnl = LocalPlayer().Inv.Wear[set_x][set_y]
				if not pnl:GetItemPanel() then
					local x,y = pnl:GetCoords()
					local itmw, itmh = item:GetSize()
					local full = false
					for i1=x, (x+itmw)-1 do
						if full then break end
						for i2=y, (y+itmh)-1 do
							if LocalPlayer():GetInvItem(i1,i2):GetItemPanel() then
								full = true
								break
							end
						end
					end
					if !full then
						return pnl
					end
				end
			end

			return false
		end

		function PickupItem(item)
			local set_x, set_y = item:GetPos()

			local place = IsRoomFor(item, set_x, set_y)
			if place then
				
				local itm = vgui.Create("InvItem", inv_panel)
				itm:SetItem(item)
				itm:SetModel( item.Model )
				itm.Entity:SetSkin( item.Skin )
				itm:SetRoot(place)
				itm:SetPos(place:GetPos())

				if set_x == 3 and (set_y == 1 or set_y == 2 or set_y == 3) then
					itm:SetSize(200,50)
					min, max = itm.Entity:GetRenderBounds()
					itm:SetFOV(55)
					itm:SetCamPos( Vector( 1, 1, 1 ) * min:Distance( max ) )
					itm:SetLookAt( ( min + max ) / 2 )
				else
					itm:SetSize(50,50)
					min, max = itm.Entity:GetRenderBounds()
					itm:SetFOV(25)
					itm:SetCamPos( Vector( 1, 1, 1 ) * min:Distance( max ) )
					itm:SetLookAt( ( min + max ) / 2 )
				end
				
				local x,y = place:GetCoords()
				local itmw, itmh = item:GetSize()
				for i1=x, (x+itmw)-1 do
					for i2=y, (y+itmh)-1 do
						if LocalPlayer():GetInvItem(i1,i2) then LocalPlayer():GetInvItem(i1,i2):SetItemPanel(itm) end
						itm:SetCoords(i1,i2)
					end
				end
				
				return true
				
			else
				return false
			end
		end

		if inv.Wear != nil then
			for k,v in pairs(inv.Wear) do
			    for i=1,21 do
			    	if istable(inv.Wear[k][i]) then
						local Item = {}
						Item.Name = inv.Wear[k][i].PrintName
						Item.Model = inv.Wear[k][i].Model
						Item.Skin = inv.Wear[k][i].Skin
						function Item:GetPos()
							return k, i
						end
						function Item:GetSize()
							return 1, 1
						end
						function Item:GetIcon()
							return Material("entities/weapon_pistol.png")
						end
						function Item:GetClothes()
							return inv.Wear[k][i].Clothes
						end
						function Item:GetClothIndex()
							return inv.Wear[k][i].Index
						end
						function Item:GetClothTexture()
							return inv.Wear[k][i].Texture
						end
						function Item:GetWeaponClass()
							if inv.Wear[k][i].DT != nil then
								return inv.Wear[k][i].DT.WeaponClass
							else
								return ""
							end
						end
						function Item:GetInfo()
							if inv.Wear[k][i].PrintName == "Food" then
								return inv.Wear[k][i].FoodName
							end
							if inv.Wear[k][i].Notepad_ID != nil then
								return inv.Wear[k][i].Notepad_ID
							end
							if inv.Wear[k][i].PrintName == "Spawned Weapon" then
								return string.sub(inv.Wear[k][i].DT.WeaponClass, 5, 20 )
							end
							if inv.Wear[k][i].PrintName == "ID карта" then
								return inv.Wear[k][i].IDCard_Person
							end
							return inv.Wear[k][i].PrintName
						end
						function Item:GetMedData()
							if inv.Wear[k][i].PrintName == "Мед карта" then
								local tbl = {
									inv.Wear[k][i].MedCard_Person,
									inv.Wear[k][i].MedCard_Height,
									inv.Wear[k][i].MedCard_Weight,
									inv.Wear[k][i].MedCard_Physics,
									inv.Wear[k][i].MedCard_Mental,
									inv.Wear[k][i].MedCard_BloodGroup,
									inv.Wear[k][i].MedCard_Disease,
								}
								return tbl
							end
							return {}
						end
						function Item:GetWeight()
							return inv.Wear[k][i].Weight
						end

			    		PickupItem(Item)
			    	end
			    end
			end
		end

		function IsRoomForStorage(item, set_x, set_y)
			pnl = _Storage[set_x][set_y]
			if not pnl:GetItemPanel() then
				local x,y = pnl:GetCoords()
				local itmw, itmh = item:GetSize()
				local full = false
				for i1=x, (x+itmw)-1 do
					if full then break end
					for i2=y, (y+itmh)-1 do
						if _Storage[i1][i2]:GetItemPanel() then
							full = true
							break
						end
					end
				end
				if !full then
					return pnl
				end
			end

			return false
		end

		function PlaceStorageItem(item)
			local set_x, set_y = item:GetPos()

			local place = IsRoomForStorage(item, set_x, set_y)
			if place then
				
				local itm = vgui.Create("InvItem", inv_panel_box)
				itm:SetItem(item)
				itm:SetModel( item.Model )
				itm.Entity:SetSkin( item.Skin )
				itm:SetParent(place)
				itm:SetPos(0,0)

				itm:SetSize(50,50)
				min, max = itm.Entity:GetRenderBounds()
				itm:SetFOV(25)
				itm:SetCamPos( Vector( 1, 1, 1 ) * min:Distance( max ) )
				itm:SetLookAt( ( min + max ) / 2 )
				
				local x,y = place:GetCoords()
				local itmw, itmh = item:GetSize()
				for i1=x, (x+itmw)-1 do
					for i2=y, (y+itmh)-1 do
						LocalPlayer():GetStorageItem(i1,i2):SetItemPanel(itm)
						itm:SetCoords(i1,i2)
					end
				end
				
				return true
				
			else
				return false
			end
		end

		if storage != nil then
			for k,v in pairs(storage) do
			    for i = 1,5 do
			    	if istable(storage[k][i]) then
						local Item = {}
						Item.Name = storage[k][i].PrintName
						Item.Model = storage[k][i].Model
						Item.Skin = storage[k][i].Skin
						function Item:GetPos()
							return k, i
						end
						function Item:GetSize()
							return 1, 1
						end
						function Item:GetIcon()
							return Material("entities/weapon_pistol.png")
						end
						function Item:GetClothes()
							return storage[k][i].Clothes
						end
						function Item:GetClothIndex()
							return storage[k][i].Index
						end
						function Item:GetClothTexture()
							return storage[k][i].Texture
						end
						function Item:GetWeaponClass()
							if storage[k][i].DT != nil then
								return storage[k][i].DT.WeaponClass
							else
								return ""
							end
						end
						function Item:GetInfo()
							if storage[k][i].PrintName == "Food" then
								return storage[k][i].FoodName
							end
							if storage[k][i].Notepad_ID != nil then
								return storage[k][i].Notepad_ID
							end
							if storage[k][i].PrintName == "Spawned Weapon" then
								return string.sub(storage[k][i].DT.WeaponClass, 5, 20 )
							end
							if storage[k][i].PrintName == "ID карта" then
								return storage[k][i].IDCard_Person
							end
							return storage[k][i].PrintName
						end
						function Item:GetMedData()
							if storage[k][i].PrintName == "Мед карта" then
								local tbl = {
									storage[k][i].MedCard_Person,
									storage[k][i].MedCard_Height,
									storage[k][i].MedCard_Weight,
									storage[k][i].MedCard_Physics,
									storage[k][i].MedCard_Mental,
									storage[k][i].MedCard_BloodGroup,
									storage[k][i].MedCard_Disease,
								}
								return tbl
							end
							return {}
						end
						function Item:GetWeight()
							return storage[k][i].Weight
						end

			    		PlaceStorageItem(Item)
			    	end
			    end
			end
		end
	
	-- Медиум боксы, холодильники
	elseif mine == -2 then
		
		local netlenth2 = net.ReadInt(32)
		local fileData2 = net.ReadData(netlenth2)
		local text2 = util.Decompress(fileData2)
		local storage = util.JSONToTable(text2)
		
		local plllay = net.ReadEntity()
		whatDoor = net.ReadString()
		
		_Storage = {}

		for i=1,5 do
	      _Storage[i] = {}
		end
		for k,v in pairs(_Storage)do
		    for i=1,5 do
		        _Storage[k][i] = false
		    end
		end

		function plymeta:GetStorageItem(x,y)
		    return _Storage[x][y]
		end

		inv_panel:SetSize(565, 100)
		inv_panel:SetPos(ScrW()/2 - 282.5, ScrH()/2 + 175)
		inv_panel:SetTitle("")
		inv_panel:MakePopup()
		inv_panel.Paint = function(s,w,h)
			draw.RoundedBox(1,0,0,w,h,Color(0,0,0,190))
			draw.SimpleText( "Личные вещи", "marske4", 10, 5, color_white )
		end
		for k,v in pairs(ply.Inv.Wear) do
			for i=1,21 do
				if k != 3 then
					ply.Inv.Wear[k][i] = vgui.Create("InvSlot", inv_panel)
					ply.Inv.Wear[k][i]:SetPos((i-1)*50 + 10,38)
					ply.Inv.Wear[k][i]:SetCoords(k,i)
				end
			end
		end

		inv_panel_box = vgui.Create("DFrame")
		inv_panel_box:SetSize(320, 355)
		inv_panel_box:SetPos(ScrW()/2 - 160,ScrH()/2 - 225)
		inv_panel_box:SetTitle("Хранилище")
		inv_panel_box:MakePopup()
		inv_panel_box:ShowCloseButton( false )
		inv_panel_box:SetDraggable( false )
		inv_panel_box.Paint = function(s,w,h)
			draw.RoundedBox(1,0,0,w,h,Color(0,0,0,190))
			surface.SetDrawColor( 255, 255, 255, 255 )
		end
		for k,v in pairs(_Storage) do
			for i = 1,5 do
				_Storage[k][i] = vgui.Create("StorageSlot", inv_panel_box)
				_Storage[k][i]:SetPos(-45 + i*60,50 + (k-1)*60)
				_Storage[k][i]:SetCoords(k,i)
			end
		end
		inv_panel_box.OnClose = function()
			if IsValid(inv_panel) then
				inv_panel:Close()
			end
		end
		inv_panel.OnClose = function()
			LocalPlayer():SetNWBool("Opened_Inventory_Panel", false)
			if IsValid(inv_panel_box) then
				inv_panel_box:Close()
			end
		end


		local inv_panel1 = vgui.Create("DFrame", inv_panel)
		inv_panel1:SetSize(ScrW(), ScrH())
		inv_panel1:MakePopup()
		inv_panel1:MoveToBack()
		inv_panel1:SetTitle("")
		inv_panel1:ShowCloseButton(false)
		inv_panel1.Paint = function(s,w,h)
			if inv_panel1:IsActive() then inv_panel:Close() inv_panel_box:Close() end
		end

		backDropPanel = vgui.Create("InvBack", inv_panel1)

		function IsRoomFor(item, set_x, set_y)
			if set_x == 2 then
				pnl = LocalPlayer().Inv.Wear[set_x][set_y]
				if not pnl:GetItemPanel() then
					local x,y = pnl:GetCoords()
					local itmw, itmh = item:GetSize()
					local full = false
					for i1=x, (x+itmw)-1 do
						if full then break end
						for i2=y, (y+itmh)-1 do
							if LocalPlayer():GetInvItem(i1,i2):GetItemPanel() then
								full = true
								break
							end
						end
					end
					if !full then
						return pnl
					end
				end
			end

			return false
		end

		function PickupItem(item)
			local set_x, set_y = item:GetPos()

			local place = IsRoomFor(item, set_x, set_y)
			if place then
				
				local itm = vgui.Create("InvItem", inv_panel)
				itm:SetItem(item)
				itm:SetModel( item.Model )
				itm.Entity:SetSkin( item.Skin )
				itm:SetRoot(place)
				itm:SetPos(place:GetPos())

				if set_x == 3 and (set_y == 1 or set_y == 2 or set_y == 3) then
					itm:SetSize(200,50)
					min, max = itm.Entity:GetRenderBounds()
					itm:SetFOV(55)
					itm:SetCamPos( Vector( 1, 1, 1 ) * min:Distance( max ) )
					itm:SetLookAt( ( min + max ) / 2 )
				else
					itm:SetSize(50,50)
					min, max = itm.Entity:GetRenderBounds()
					itm:SetFOV(25)
					itm:SetCamPos( Vector( 1, 1, 1 ) * min:Distance( max ) )
					itm:SetLookAt( ( min + max ) / 2 )
				end
				
				local x,y = place:GetCoords()
				local itmw, itmh = item:GetSize()
				for i1=x, (x+itmw)-1 do
					for i2=y, (y+itmh)-1 do
						if LocalPlayer():GetInvItem(i1,i2) then LocalPlayer():GetInvItem(i1,i2):SetItemPanel(itm) end
						itm:SetCoords(i1,i2)
					end
				end
				
				return true
				
			else
				return false
			end
		end

		if inv.Wear != nil then
			for k,v in pairs(inv.Wear) do
			    for i=1,21 do
			    	if istable(inv.Wear[k][i]) then
						local Item = {}
						Item.Name = inv.Wear[k][i].PrintName
						Item.Model = inv.Wear[k][i].Model
						Item.Skin = inv.Wear[k][i].Skin
						function Item:GetPos()
							return k, i
						end
						function Item:GetSize()
							return 1, 1
						end
						function Item:GetIcon()
							return Material("entities/weapon_pistol.png")
						end
						function Item:GetClothes()
							return inv.Wear[k][i].Clothes
						end
						function Item:GetClothIndex()
							return inv.Wear[k][i].Index
						end
						function Item:GetClothTexture()
							return inv.Wear[k][i].Texture
						end
						function Item:GetWeaponClass()
							if inv.Wear[k][i].DT != nil then
								return inv.Wear[k][i].DT.WeaponClass
							else
								return ""
							end
						end
						function Item:GetInfo()
							if inv.Wear[k][i].PrintName == "Food" then
								return inv.Wear[k][i].FoodName
							end
							if inv.Wear[k][i].Notepad_ID != nil then
								return inv.Wear[k][i].Notepad_ID
							end
							if inv.Wear[k][i].PrintName == "Spawned Weapon" then
								return string.sub(inv.Wear[k][i].DT.WeaponClass, 5, 20 )
							end
							if inv.Wear[k][i].PrintName == "ID карта" then
								return inv.Wear[k][i].IDCard_Person
							end
							return inv.Wear[k][i].PrintName
						end
						function Item:GetMedData()
							if inv.Wear[k][i].PrintName == "Мед карта" then
								local tbl = {
									inv.Wear[k][i].MedCard_Person,
									inv.Wear[k][i].MedCard_Height,
									inv.Wear[k][i].MedCard_Weight,
									inv.Wear[k][i].MedCard_Physics,
									inv.Wear[k][i].MedCard_Mental,
									inv.Wear[k][i].MedCard_BloodGroup,
									inv.Wear[k][i].MedCard_Disease,
								}
								return tbl
							end
							return {}
						end
						function Item:GetWeight()
							return inv.Wear[k][i].Weight
						end

			    		PickupItem(Item)
			    	end
			    end
			end
		end

		function IsRoomForStorage(item, set_x, set_y)
			pnl = _Storage[set_x][set_y]
			if not pnl:GetItemPanel() then
				local x,y = pnl:GetCoords()
				local itmw, itmh = item:GetSize()
				local full = false
				for i1=x, (x+itmw)-1 do
					if full then break end
					for i2=y, (y+itmh)-1 do
						if _Storage[i1][i2]:GetItemPanel() then
							full = true
							break
						end
					end
				end
				if !full then
					return pnl
				end
			end

			return false
		end

		function PlaceStorageItem(item)
			local set_x, set_y = item:GetPos()

			local place = IsRoomForStorage(item, set_x, set_y)
			if place then
				
				local itm = vgui.Create("InvItem", inv_panel_box)
				itm:SetItem(item)
				itm:SetModel( item.Model )
				itm.Entity:SetSkin( item.Skin )
				itm:SetParent(place)
				itm:SetPos(0,0)

				itm:SetSize(50,50)
				min, max = itm.Entity:GetRenderBounds()
				itm:SetFOV(25)
				itm:SetCamPos( Vector( 1, 1, 1 ) * min:Distance( max ) )
				itm:SetLookAt( ( min + max ) / 2 )
				
				local x,y = place:GetCoords()
				local itmw, itmh = item:GetSize()
				for i1=x, (x+itmw)-1 do
					for i2=y, (y+itmh)-1 do
						LocalPlayer():GetStorageItem(i1,i2):SetItemPanel(itm)
						itm:SetCoords(i1,i2)
					end
				end
				
				return true
				
			else
				return false
			end
		end

		if storage != nil then
			for k,v in pairs(storage) do
			    for i = 1,5 do
			    	if istable(storage[k][i]) then
						local Item = {}
						Item.Name = storage[k][i].PrintName
						Item.Model = storage[k][i].Model
						Item.Skin = storage[k][i].Skin
						function Item:GetPos()
							return k, i
						end
						function Item:GetSize()
							return 1, 1
						end
						function Item:GetIcon()
							return Material("entities/weapon_pistol.png")
						end
						function Item:GetClothes()
							return storage[k][i].Clothes
						end
						function Item:GetClothIndex()
							return storage[k][i].Index
						end
						function Item:GetClothTexture()
							return storage[k][i].Texture
						end
						function Item:GetWeaponClass()
							if storage[k][i].DT != nil then
								return storage[k][i].DT.WeaponClass
							else
								return ""
							end
						end
						function Item:GetInfo()
							if storage[k][i].PrintName == "Food" then
								return storage[k][i].FoodName
							end
							if storage[k][i].Notepad_ID != nil then
								return storage[k][i].Notepad_ID
							end
							if storage[k][i].PrintName == "Spawned Weapon" then
								return string.sub(storage[k][i].DT.WeaponClass, 5, 20 )
							end
							if storage[k][i].PrintName == "ID карта" then
								return storage[k][i].IDCard_Person
							end
							return storage[k][i].PrintName
						end
						function Item:GetMedData()
							if storage[k][i].PrintName == "Мед карта" then
								local tbl = {
									storage[k][i].MedCard_Person,
									storage[k][i].MedCard_Height,
									storage[k][i].MedCard_Weight,
									storage[k][i].MedCard_Physics,
									storage[k][i].MedCard_Mental,
									storage[k][i].MedCard_BloodGroup,
									storage[k][i].MedCard_Disease,
								}
								return tbl
							end
							return {}
						end
						function Item:GetWeight()
							return storage[k][i].Weight
						end

			    		PlaceStorageItem(Item)
			    	end
			    end
			end
		end
	end
end)