-- "addons\\rised_job_system\\lua\\autorun\\sh_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
Job = {}
---------------------------------------------------------------
--      Ниже код в котором вы создаете/редактируете NPC      --
---------------------------------------------------------------
Job.NPC = { -- Строка открывает основной код редактирования всех NPC
---------------------------------------------------------------

useless = {
	name = "Useless",
	model = {"models/Humans/Charple03.mdl"},
	pos = {
		[1] = {

			pos = Vector(-15000, 0, 0),
			angle = Angle(0, 90, 0),
		}
	},
	limit = 1

},
---------------------------------------------------------------
-- Скобку ниже не трогать! --
}
-- Если вы не шарите в Lua. Код не трогать
function Job:Get(name)
	return Job.NPC[name]
end






