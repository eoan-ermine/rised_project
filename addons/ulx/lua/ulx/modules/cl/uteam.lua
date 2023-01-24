-- "addons\\ulx\\lua\\ulx\\modules\\cl\\uteam.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ulx.teams = ulx.teams or {}

function ulx.populateClTeams( teams )
	ulx.teams = teams

	for i=1, #teams do
		local team_data = teams[ i ]
		team.SetUp( team_data.index, team_data.name, team_data.color )
	end
end
