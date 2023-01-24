-- "addons\\rised_citizens\\lua\\autorun\\hl2rp_npcs.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local function AddNPC( t, class )
	list.Set( "NPC", class or t.Class, t )
end



local Category = "Half-Life 2 Roleplay Citizens"

AddNPC( {
	Name = "Van",
	Class = "npc_citizen",
	Health = "50", 
	Category = Category,
	Model = "models/hl2rp/male_01.mdl",
	KeyValues = { citizentype = CT_DOWNTRODDEN, SquadName = "resistance" }
}, "male01" )

AddNPC( {
	Name = "Ted",
	Class = "npc_citizen",
	Health = "50", 
	Category = Category,
	Model = "models/hl2rp/male_02.mdl",
	KeyValues = { citizentype = CT_DOWNTRODDEN, SquadName = "resistance" }
}, "male02" )

AddNPC( {
	Name = "Joe",
	Class = "npc_citizen",
	Health = "50", 
	Category = Category,
	Model = "models/hl2rp/male_03.mdl",
	KeyValues = { citizentype = CT_DOWNTRODDEN, SquadName = "resistance" }
}, "male03" )

AddNPC( {
	Name = "Eric",
	Class = "npc_citizen",
	Health = "50", 
	Category = Category,
	Model = "models/hl2rp/male_04.mdl",
	KeyValues = { citizentype = CT_DOWNTRODDEN, SquadName = "resistance" }
}, "male04" )

AddNPC( {
	Name = "Art",
	Class = "npc_citizen",
	Health = "50", 
	Category = Category,
	Model = "models/hl2rp/male_05.mdl",
	KeyValues = { citizentype = CT_DOWNTRODDEN, SquadName = "resistance" }
}, "male05" )

AddNPC( {
	Name = "Sandro",
	Class = "npc_citizen",
	Health = "50", 
	Category = Category,
	Model = "models/hl2rp/male_06.mdl",
	KeyValues = { citizentype = CT_DOWNTRODDEN, SquadName = "resistance" }
}, "male06" )

AddNPC( {
	Name = "Mike",
	Class = "npc_citizen",
	Health = "50", 
	Category = Category,
	Model = "models/hl2rp/male_07.mdl",
	KeyValues = { citizentype = CT_DOWNTRODDEN, SquadName = "resistance" }
}, "male07" )

AddNPC( {
	Name = "Vance",
	Class = "npc_citizen",
	Health = "50", 
	Category = Category,
	Model = "models/hl2rp/male_08.mdl",
	KeyValues = { citizentype = CT_DOWNTRODDEN, SquadName = "resistance" }
}, "male08" )

AddNPC( {
	Name = "Erdin",
	Class = "npc_citizen",
	Health = "50", 
	Category = Category,
	Model = "models/hl2rp/male_09.mdl",
	KeyValues = { citizentype = CT_DOWNTRODDEN, SquadName = "resistance" }
}, "male09" )

AddNPC( {
	Name = "Joey",
	Class = "npc_citizen",
	Health = "50", 
	Category = Category,
	Model = "models/hl2rp/female_01.mdl",
	KeyValues = { citizentype = CT_DOWNTRODDEN, SquadName = "resistance" }
}, "female01" )

AddNPC( {
	Name = "Kanisha",
	Class = "npc_citizen",
	Health = "50", 
	Category = Category,
	Model = "models/hl2rp/female_02.mdl",
	KeyValues = { citizentype = CT_DOWNTRODDEN, SquadName = "resistance" }
}, "female02" )

AddNPC( {
	Name = "Kim",
	Class = "npc_citizen",
	Health = "50", 
	Category = Category,
	Model = "models/hl2rp/female_03.mdl",
	KeyValues = { citizentype = CT_DOWNTRODDEN, SquadName = "resistance" }
}, "female03" )

AddNPC( {
	Name = "Chau",
	Class = "npc_citizen",
	Health = "50", 
	Category = Category,
	Model = "models/hl2rp/female_04.mdl",
	KeyValues = { citizentype = CT_DOWNTRODDEN, SquadName = "resistance" }
}, "female04" )

AddNPC( {
	Name = "Naomi",
	Class = "npc_citizen",
	Health = "50", 
	Category = Category,
	Model = "models/hl2rp/female_06.mdl",
	KeyValues = { citizentype = CT_DOWNTRODDEN, SquadName = "resistance" }
}, "female06" )

AddNPC( {
	Name = "Lakeetra",
	Class = "npc_citizen",
	Health = "50", 
	Category = Category,
	Model = "models/hl2rp/female_07.mdl",
	KeyValues = { citizentype = CT_DOWNTRODDEN, SquadName = "resistance" }
}, "female07" )