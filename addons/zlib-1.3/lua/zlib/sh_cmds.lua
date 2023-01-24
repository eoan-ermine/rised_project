-- "addons\\zlib-1.3\\lua\\zlib\\sh_cmds.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    zlib - (CL) Commands
    Developed by Zephruz
]]

zlib.cmds = (zlib.cmds or {})
zlib.cmds._chatCmds = (zlib.cmds._chatCmds or {})
zlib.cmds._consoleCmds = (zlib.cmds._consoleCmds or {})

function zlib.cmds:GetChatCommands()
	for k,v in pairs(self._chatCmds) do
		if !(isstring(k)) then
			self._chatCmds[k] = nil
		end
	end

	return (self._chatCmds or {})
end

function zlib.cmds:RegisterChat(cmd, data, callback)
	local cmdTbl = {data = (data or {}), cb = callback}

	if (istable(cmd)) then
		for i=1,#cmd do
			local cmd = cmd[i]

			if (cmd) then
				self._chatCmds[cmd] = cmdTbl
			end
		end
	else
		self._chatCmds[cmd] = cmdTbl
	end
end

function zlib.cmds:RegisterConsole(cmd, callback, ...)
	if (istable(cmd)) then
		for i=1,#cmd do
			local cmd = cmd[i]

			if (cmd) then
				concommand.Add(cmd, callback, ...)

				self._consoleCmds[cmd] = callback
			end
		end
	else
		concommand.Add(cmd, callback, ...)
		
		self._consoleCmds[cmd] = callback
	end
end

local function findChatCommand(msg, cmd)
	if (!msg or !cmd) then return false end

	local args = msg:Split(" ")
	local argCmd = (args && args[1])

	if (argCmd && cmd == argCmd) then
		return args
	end

	--[[local sP, eP, strF = msg:find(cmd, 1, true)
	
	if (sP && sP == 1 or eP && eP == #cmd) then
		-- local noCmd = msg:Replace(cmd, "")
		local args = msg:Split(" ")

		return args
	end]]

	return false
end

--[[
	Hooks
]]
if (SERVER) then

    hook.Add("PlayerSay", "zlib.cmds.playerSay",
    function(ply, msg, tChat)
        local cmds = zlib.cmds:GetChatCommands()

        for cmd,data in pairs(cmds) do
            local args = findChatCommand(msg, cmd)

            if (args) then
                if (args[1] && #args[1] == 0) then table.remove(args,1) end

                if (data && data.cb) then
                    local retVal = data.cb(ply, cmd, args, tChat)

                    if (retVal != nil) then return retVal end
                end

                return ""
            end
        end
    end)

end