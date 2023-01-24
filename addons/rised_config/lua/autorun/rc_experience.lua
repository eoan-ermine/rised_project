-- "addons\\rised_config\\lua\\autorun\\rc_experience.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if RISED == null then
	RISED = {}
	if RISED.Config == null then
		RISED.Config = {}
	end
end
if RISED.Config.Experience == null then
	RISED.Config.Experience = {}
end
if RISED.Config.Experience.Tasks == null then
    RISED.Config.Experience.Tasks = {}
end
if RISED.Config.Experience.DefaultTasks == null then
    RISED.Config.Experience.DefaultTasks = {}
end
if RISED.Config.Experience.Jobs == null then
    RISED.Config.Experience.Jobs = {}
end


----------========== Опыт ==========----------

-----===== Опыт за разные вещи =====-----
RISED.Config.Experience.Boost = {}
RISED.Config.Experience.Boost.Global = 1
RISED.Config.Experience.Boost.OldExperience = 20


RISED.Config.Experience.RubbishExp = 30
RISED.Config.Experience.RubbishSodaExp = 15
RISED.Config.Experience.RubbishFoodExp = 25
RISED.Config.Experience.RubbishBodyExp = 200

RISED.Config.Experience.DeliveryMeatExp = 85
RISED.Config.Experience.CookMeatExp = 132
RISED.Config.Experience.DeliveryEnzymesExp = 164

RISED.Config.Experience.CompileRationsNormalExp = 125
RISED.Config.Experience.CompileRationsGoodExp = 200
RISED.Config.Experience.CompileRationsPerfectExp = 350

RISED.Config.Experience.DeliveryMetalExp = 195
RISED.Config.Experience.PressMetalExp = 850
RISED.Config.Experience.WeldMetalExp = 950
RISED.Config.Experience.IonizeMetalExp = 1285

RISED.Config.Experience.DrunkerExp = 450

RISED.Config.Experience.MedPatientDiseaseExp = 340



if CLIENT then
    ClientTasks = {}
    ClientJobs = {}

    function GetCurrentTeamTaskList(ply)
        local tasks = {}
        for k,v in pairs(ClientTasks) do
            if v[ply:Team()] then
                local new_task = {
                    ["Name"] = k,
                    ["Iterations"] = ply["TaskIterations_"..k],
                    ["MaxIterations"] = v[ply:Team()]["MaxIterations"]
                }
                table.insert(tasks, new_task)
            end
        end
        return tasks
    end

    function GetJobTasks(selected_job)
        local job_tasks = {}
        job_tasks["Tasks"] = {}

        for k,task_jobs in pairs(ClientTasks) do
            for job,task in pairs(task_jobs) do
                if selected_job == job then
                    job_tasks["Tasks"][k] = task
                end
            end
        end

        job_tasks["ExpPerDay"] = ClientJobs[selected_job]["ExpPerDay"]
        job_tasks["ExpForTime"] = ClientJobs[selected_job]["ExpForTime"]
        job_tasks["ExpForTasks"] = ClientJobs[selected_job]["ExpForTasks"]
        return job_tasks
    end

    net.Receive("RisedExperience:Client", function()
        local length = net.ReadInt(32)
        local binary = net.ReadData(length)
        local data = util.JSONToTable(util.Decompress(binary))
        
        RISED.Config.Experience.Tasks = data["Tasks"]
        RISED.Config.Experience.Jobs = data["Total"]

        ClientTasks = data["Tasks"]
        ClientJobs = data["Total"]
    end)
end