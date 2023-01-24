-- "addons\\rised_city_environment\\lua\\entities\\party_terminal\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName= "Терминал партии"
ENT.Author= "D-Rised"
ENT.Category = "A - Rised - [Гражданское]"
ENT.Contact= ""
ENT.Purpose= ""
ENT.Instructions= ""
ENT.Spawnable = true
ENT.AdminSpawnable = true

PartyTerminalAccess = {
	[TEAM_PARTYSUPPORTSUPERIOR] = true,
	[TEAM_PARTYWORKSUPERVISOR] = true,
	[TEAM_PARTYSUPERIORCOUNCILMEMBER] = true,
	[TEAM_PARTYCOUNCILCHAIRMAN] = true,
	[TEAM_PARTYGENERALSECRETARY] = true,
	[TEAM_CONSUL] = true,
}