-- "addons\\zlib-1.3\\lua\\zlib\\networking\\cl_networking.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    zlib - (CL) Networking
    Developed by Zephruz
]]

zlib.network._openActions = (zlib.network._openActions or {})

function zlib.network:GetOpenAction(name, id)
    local actTbl = self._openActions[name]

    return (actTbl && actTbl[id])
end

function zlib.network:CloseOpenAction(name, id)
    if !(self._openActions[name]) then return false end

    self._openActions[name][id] = nil
end

function zlib.network:CallAction(name, sendData, receiveCb)
    local actionID = "zlib.Action[" .. name .. "]"

    -- Setup action
    self._openActions[name] = (self._openActions[name] or {})

    local id = table.insert(self._openActions[name], receiveCb)

    -- Send request
    netPoint:FromEndPoint(actionID .. ".receiveRequest", actionID .. ".client.request", { requestData = { request = {name = name, id = id, data = sendData} } })
end

--[[
    Networking
]]
net.Receive("zlib.Action.receiveResult",
function()
    local dataRes = netPoint:DecompressNetData()
    local name, id, data = dataRes.name, dataRes.id, dataRes.data

    local receiveCb = zlib.network:GetOpenAction(name, id)
    
    if (receiveCb) then
        receiveCb(data)

        zlib.network:CloseOpenAction(name, id)
    end
end)