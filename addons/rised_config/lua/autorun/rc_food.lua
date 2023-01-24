-- "addons\\rised_config\\lua\\autorun\\rc_food.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if RISED == null then
	RISED = {}
	if RISED.Config == null then
		RISED.Config = {}
	end
end

----------========== Еда ==========----------
RISED.Config.VendingSodaCost 		= 20
RISED.Config.VendingSodaEnergy 		= 2
RISED.Config.VendingSodaMaxStamina 	= 10

RISED.Config.Food = {
	["cuw_component_meat_raw"] = {
		["Name"] = "Мясо муравьиного льва",
		["Energy"] = 10,
		["Cost"] = 0,
		["Trade"] = false,
	},
	["cm_cookingbook"] = {
		["Name"] = "Книга рецептов",
		["Energy"] = 0,
		["Cost"] = 500,
		["Trade"] = true,
	},
	["weapon_knife_cookingmod"] = {
		["Name"] = "Кухонный нож",
		["Energy"] = 0,
		["Cost"] = 500,
		["Trade"] = true,
	},
	["cm_coffeemach"] = {
		["Name"] = "Кофемашина",
		["Energy"] = 10,
		["Cost"] = 800,
		["Trade"] = true,
	},
	["cm_coffee"] = {
		["Name"] = "Кофе",
		["Energy"] = 5,
		["Cost"] = 600,
		["Trade"] = true,
	},
	["cm_cup"] = {
		["Name"] = "Кружка",
		["Energy"] = 0,
		["Cost"] = 200,
		["Trade"] = true,
	},
	["cm_apple"] = {
		["Name"] = "Яблоко",
		["Energy"] = 10,
		["Cost"] = 150,
		["Trade"] = true,
	},
	["cm_banana"] = {
		["Name"] = "Банан",
		["Energy"] = 10,
		["Cost"] = 150,
		["Trade"] = true,
	},
	["cm_beer"] = {
		["Name"] = "Пиво",
		["Energy"] = 15,
		["Cost"] = 650,
		["Trade"] = true,
	},
	["cm_bread"] = {
		["Name"] = "Хлеб",
		["Energy"] = 20,
		["Cost"] = 290,
		["Trade"] = true,
	},
	["cm_bread_sandwich"] = {
		["Name"] = "Бутерброд",
		["Energy"] = 25,
		["Cost"] = 400,
		["Trade"] = false,
	},
	["cm_bread_slice"] = {
		["Name"] = "Ломтик хлеба",
		["Energy"] = 5,
		["Cost"] = 150,
		["Trade"] = false,
	},
	["cm_bread_toast"] = {
		["Name"] = "Тост",
		["Energy"] = 7,
		["Cost"] = 500,
		["Trade"] = true,
	},
	["cm_flour"] = {
		["Name"] = "Мука",
		["Energy"] = 5,
		["Cost"] = 25,
		["Trade"] = true,
	},
	["cm_cabbage"] = {
		["Name"] = "Капуста",
		["Energy"] = 5,
		["Cost"] = 150,
		["Trade"] = true,
	},
	["cm_cake"] = {
		["Name"] = "Торт",
		["Energy"] = 100,
		["Cost"] = 2000,
		["Trade"] = true,
	},
	["cm_can1"] = {
		["Name"] = "Кола",
		["Energy"] = 0,
		["Cost"] = 150,
		["Trade"] = false,
	},
	["cm_can2"] = {
		["Name"] = "Пепси",
		["Energy"] = 15,
		["Cost"] = 150,
		["Trade"] = false,
	},
	["cm_can3"] = {
		["Name"] = "Энергетик",
		["Energy"] = 15,
		["Cost"] = 150,
		["Trade"] = false,
	},
	["cm_cheese"] = {
		["Name"] = "Сыр",
		["Energy"] = 30,
		["Cost"] = 800,
		["Trade"] = true,
	},
	["cm_cola"] = {
		["Name"] = "Кола 2л",
		["Energy"] = 25,
		["Cost"] = 700,
		["Trade"] = false,
	},
	["cm_cola2"] = {
		["Name"] = "Газировка 0.5л",
		["Energy"] = 10,
		["Cost"] = 300,
		["Trade"] = true,
	},
	["cm_cookedmeat"] = {
		["Name"] = "Мясо",
		["Energy"] = 40,
		["Cost"] = 1000,
		["Trade"] = false,
	},
	["cm_cookedmeat2"] = {
		["Name"] = "Мясо",
		["Energy"] = 70,
		["Cost"] = 1250,
		["Trade"] = false,
	},
	["cm_cup2"] = {
		["Name"] = "Кофе",
		["Energy"] = 5,
		["Cost"] = 50,
		["Trade"] = false,
	},
	["cm_cup3"] = {
		["Name"] = "Кофе",
		["Energy"] = 1,
		["Cost"] = 50,
		["Trade"] = false,
	},
	["cm_fish1"] = {
		["Name"] = "Золотая рыба",
		["Energy"] = 25,
		["Cost"] = 800,
		["Trade"] = true,
	},
	["cm_fish2"] = {
		["Name"] = "Окунь",
		["Energy"] = 25,
		["Cost"] = 800,
		["Trade"] = true,
	},
	["cm_fish3"] = {
		["Name"] = "Радужная рыба",
		["Energy"] = 25,
		["Cost"] = 800,
		["Trade"] = true,
	},
	["cm_fishcooked"] = {
		["Name"] = "Рыба",
		["Energy"] = 30,
		["Cost"] = 850,
		["Trade"] = false,
	},
	["cm_foodbacon1"] = {
		["Name"] = "Сырой бекон",
		["Energy"] = 10,
		["Cost"] = 140,
		["Trade"] = true,
	},
	["cm_foodbacon2"] = {
		["Name"] = "Бекон",
		["Energy"] = 20,
		["Cost"] = 600,
		["Trade"] = false,
	},
	["cm_foodburger"] = {
		["Name"] = "Двойной бургер",
		["Energy"] = 55,
		["Cost"] = 1000,
		["Trade"] = false,
	},
	["cm_foodburger2"] = {
		["Name"] = "Чизбургер",
		["Energy"] = 35,
		["Cost"] = 500,
		["Trade"] = false,
	},
	["cm_foodegg1"] = {
		["Name"] = "Яичница",
		["Energy"] = 17,
		["Cost"] = 300,
		["Trade"] = false,
	},
	["cm_foodegg2"] = {
		["Name"] = "Яйцо",
		["Energy"] = 5,
		["Cost"] = 150,
		["Trade"] = true,
	},
	["cm_meat"] = {
		["Name"] = "Сырое мясо",
		["Energy"] = -10,
		["Cost"] = 50,
		["Trade"] = true,
	},
	["cm_meat2"] = {
		["Name"] = "Сырой стейк",
		["Energy"] = -10,
		["Cost"] = 50,
		["Trade"] = true,
	},
	["cm_meatbad"] = {
		["Name"] = "Испорченое мясо",
		["Energy"] = -30,
		["Cost"] = 50,
		["Trade"] = false,
	},
	["cm_milk"] = {
		["Name"] = "Молоко",
		["Energy"] = 17,
		["Cost"] = 600,
		["Trade"] = true,
	},
	["cm_orange"] = {
		["Name"] = "Апельсин",
		["Energy"] = 5,
		["Cost"] = 150,
		["Trade"] = true,
	},
	["cm_pancake"] = {
		["Name"] = "Оладушек",
		["Energy"] = 12,
		["Cost"] = 310,
		["Trade"] = true,
	},
	["cm_pear"] = {
		["Name"] = "Груша",
		["Energy"] = 5,
		["Cost"] = 150,
		["Trade"] = true,
	},
	["cm_pie"] = {
		["Name"] = "Пирог",
		["Energy"] = 45,
		["Cost"] = 500,
		["Trade"] = true,
	},
	["cm_pizza"] = {
		["Name"] = "Пицца",
		["Energy"] = 50,
		["Cost"] = 600,
		["Trade"] = true,
	},
	["cm_sandwich"] = {
		["Name"] = "Бутерброд",
		["Energy"] = 25,
		["Cost"] = 350,
		["Trade"] = false,
	},
	["cm_toast1"] = {
		["Name"] = "Тост",
		["Energy"] = 10,
		["Cost"] = 250,
		["Trade"] = false,
	},
	["cm_toast2"] = {
		["Name"] = "Тост",
		["Energy"] = 10,
		["Cost"] = 250,
		["Trade"] = false,
	},
	["cm_tomato"] = {
		["Name"] = "Томат",
		["Energy"] = 10,
		["Cost"] = 250,
		["Trade"] = true,
	},
	["cm_tortilla"] = {
		["Name"] = "Шаурма",
		["Energy"] = 50,
		["Cost"] = 700,
		["Trade"] = false,
	},
	["cm_water"] = {
		["Name"] = "Вода",
		["Energy"] = 1,
		["Cost"] = 50,
		["Trade"] = true,
	},
}