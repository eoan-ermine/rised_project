-- "addons\\zlib-1.3\\lua\\zlib\\includes\\netpoints.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
	netPoint - V1

	-- What does this do?
		* Provides a means of data transferring/querying between the client and server
		* Performs (mostly) like Ajax

	TODO:
		- Handshakes between client & server (to verify that the data is supposed to be transferred at the time of request)
]]

netPoint = (netPoint or {})

--[[CONFIG]]
netPoint.debug = false 		-- Enables debug messages

netPoint.reqTimeout = 5  	-- How long before a request times out and retries

netPoint.reqRetryAmt = 2	-- How many times a request is retried before closed

netPoint.reqThreshold = 5 	-- Threshold (in seconds) for the maximum amount of requests; Ex: 50 requests/2 seconds

netPoint.maxRequests = 50 	-- Maximum amount of requests within (netPoint.reqThreshold) seconds [before a user gets blocked from sending more until timeout]

--[[DON'T EDIT BELOW HERE]]
netPoint._cache = (netPoint._cache or {})
netPoint._endPoints = (netPoint._endPoints or {})
netPoint._payloads = (netPoint._payloads or {})
netPoint._payloadBuffer = (netPoint._payloadBuffer or {})
netPoint._receivers = {
	["cl"] = "NP.RC",
	["sv"] = "NP.RS",
	["payload"] = "NP.PAYLOAD",
}

local function splitTable(inTbl,at)
	if !(istable(inTbl)) then return {} end

	inTbl = table.Copy(inTbl)

	local outTbl, keyStash = {}, {}
	local x, split = table.Count(inTbl), at
	local fl = math.ceil(x/split)
	
	-- [[Chop it up]]
	for i=1,fl do outTbl[i] = {} end

	local curItem = 1

	for k,v in pairs(inTbl) do
		local outID = math.ceil(curItem/at)

		if (outTbl[outID]) then
			outTbl[outID][k] = v

			curItem = curItem + 1
		end
	end

	return outTbl
end

local function rebuildSplitTable(inTbl)
	local outTbl = {}

	for i=1,#inTbl do
		for k,v in pairs(inTbl[i]) do
			outTbl[k] = v
		end
	end

	return outTbl
end

table.split = splitTable
table.rebuild = rebuildSplitTable

--[[----------
	SHARED
------------]]

---------------------
--> netPoint:DebugMessage(...)
-- 	-> Prints a message to console if debug mode is enabled.
-- 	-> Used for debugging.
--  -> ARGUMENTS
	-- Works the same as MsgC()
---------------------
function netPoint:DebugMessage(...)
	if !(self.debug) then return false end

	local pfx = (CLIENT && "CLIENT" || "SERVER")

	MsgC(Color(255,255,0), "[NP - " .. pfx .. "] ", Color(255,255,255), ..., "\n")
end

---------------------
--> netPoint:GetEndPoint(reqEP)
-- 	-> Retrieves an EndPoint
--  -> ARGUMENTS
	-- * reqEP (STRING) - EndPoint name
---------------------
function netPoint:GetEndPoint(reqEP)
	return (self._endPoints && self._endPoints[reqEP] || nil)
end

---------------------
--> netPoint:RemoveEndPoint(reqEP)
-- 	-> Removes an EndPoint
--  -> ARGUMENTS
	-- * reqEP (STRING) - EndPoint name
---------------------
function netPoint:RemoveEndPoint(reqEP)
	self._endPoints[reqEP] = nil -- Just nil it
end

---------------------
--> netPoint:CreateEndPoint(reqEP, data)
-- 	-> Creates an EndPoint
--  -> ARGUMENTS
	-- * reqEP (STRING) - EndPoint name
	-- * data (TABLE) - EndPoint data/configuration
---------------------
function netPoint:CreateEndPoint(reqEP, data)
	if !(self._endPoints) then self._endPoints = {} end

	self._endPoints[reqEP] = data
end

---------------------
--> netPoint:SendPayload(id, ply, tbl)
-- 	-> Sends a payload
--  -> ARGUMENTS
	-- * id (STRING) - ID of the payload
	-- * ply (ENTITY) - Player to send to (can be a table of players)
	-- * tbl (STRING) - Table to send
	-- * pLoadSize (INTEGER) - Maximum size of each payload fragment; defaults to 1
	-- * ... (VARARG) - Any extra information you want to pass; must be a string or integer
---------------------
function netPoint:SendPayload(id, ply, tbl, pLoadSize, ...)
	local compTbl, size = self:CompressTableToSend(tbl)

	-- Split table
	pLoadSize = (pLoadSize or 5)
	local splitTbl = splitTable(tbl, pLoadSize) -- Split the table so we can send it in payloads
	local pLoadRandID = math.random(1,1000000000) -- Generate a random payload ID
	local pLoadSize = table.Count(splitTbl)
	local extraHeader = zlib.util:Serialize({...}) -- Serialize the extraHeader to maintain its type integrity

	for k,v in pairs(splitTbl) do
		self:SendCompressedNetMessage(self._receivers["payload"], ply, v,
		function(compData, compBInt)
			net.WriteString(id .. "," .. pLoadRandID .. "," .. pLoadSize .. "," .. k .. "," .. util.CRC(compData))

			if (extraHeader) then
				net.WriteString(extraHeader)
			end
		end)
	end
end

---------------------
--> netPoint:ReceivePayload(id, tbl, ply)
-- 	-> Receives payload
--  -> ARGUMENTS
	-- * id (STRING) - Payload to receive
	-- * onReceive (FUNCTION) - Receive callback
---------------------
function netPoint:ReceivePayload(id, onReceive)
	self._payloadBuffer[id] = (self._payloadBuffer[id] or {})
	self._payloads[id] = onReceive
end

---------------------
--> netPoint:CompressTableToSend(tbl)
-- 	-> Compresses a table and returns the compressed data and the length of the data
--  -> ARGUMENTS
	-- * tbl (TABLE) - Data table to compress
---------------------
function netPoint:CompressTableToSend(tbl)
	tbl = zlib.util:Serialize(tbl)
	tbl = util.Compress(tbl)
	
	if !(tbl) then return self:CompressTableToSend({["_netPoint"] = "NO DATA [empty]"}) end

	return tbl, (tbl && #tbl || 0)
end

---------------------
--> netPoint:DecompressNetData()
-- 	-> Decompresses received net data.
--	-> Must be used within a net.Receive callback and data must be compressed with netPoint:CompressTableToSend()
---------------------
function netPoint:DecompressNetData()
	local dataBInt = net.ReadUInt(32)
	local compData = net.ReadData(dataBInt)
	local data = (compData && util.Decompress(compData))
	data = (data && zlib.util:Deserialize(data))

	if (data && data["_netPoint"]) then
		self:DebugMessage(data["_netPoint"])

		data["_netPoint"] = nil
	end

	return data, dataBInt, compData
end

---------------------
--> netPoint:SendCompressedNetMessage(nwuid, receiver, data, cbWrite)
-- 	-> Sends a compressed net message
	-- * nwuid (STRING) - EndPoint name
	-- * receiver (ENTITY OR TABLE OR STRING) - Receiver. Must be a player, table of players, or "SERVER"
	-- * data (TABLE) - Message data
	-- * cbWrite (FUNCTION) - Optional argument to append more data to the net message
---------------------
function netPoint:SendCompressedNetMessage(nwuid, receiver, data, cbWrite)
	local compData, compBInt = self:CompressTableToSend(data)

	if (compData && compBInt) then
		net.Start(nwuid)

		net.WriteUInt(compBInt, 32)
		net.WriteData(compData, compBInt)

		if (isfunction(cbWrite)) then cbWrite(compData, compBInt) end
		
		if (receiver == "SERVER") then
			net.SendToServer()
		else
			net.Send(receiver)
		end
	end
end

--[[
	SERVER
]]
if (SERVER) then
	util.AddNetworkString(netPoint._receivers["sv"])
	util.AddNetworkString(netPoint._receivers["cl"])
	util.AddNetworkString(netPoint._receivers["payload"])

	--[[Used to receive netpoint requests]]
	net.Receive(netPoint._receivers["sv"],
	function(len,ply)
		if !(IsValid(ply)) then return false end

		-- Check if this player is spamming, if so; stop them (temporarily)
		local maxReqs = (netPoint.maxRequests or 100)
		local rfsResAt = ply:GetNW2Int("NP_RS_RESETAT", os.time())
		local rfsTReqs = ply:GetNW2Int("NP_RS_TOTAL", 1)

		if (rfsResAt > os.time() && rfsTReqs >= maxReqs) then
			return false
		elseif (rfsResAt <= os.time()) then
			ply:SetNW2Int("NP_RS_RESETAT", os.time() + (netPoint.reqThreshold || 5))
			ply:SetNW2Int("NP_RS_TOTAL", 0)
		else
			ply:SetNW2Int("NP_RS_TOTAL", rfsTReqs + 1)
		end

		local retData = {}
		local reqData, reqDataBInt = netPoint:DecompressNetData()
		local reqEPRec = net.ReadString()
		local reqIDRec = net.ReadString()

		local epData = netPoint:GetEndPoint(reqEPRec)
		
		if (!epData or !reqData or reqData["_CLERR"] or !reqEPRec or !reqIDRec) then return false end

		for k,v in pairs(epData) do
			local val = reqData[k]

			if (val) then
				retData[k] = v(ply,val)
			end
		end

		if !(retData) then return false end
		
		netPoint:SendCompressedNetMessage(netPoint._receivers["cl"], ply, retData,
		function()
			net.WriteString(reqEPRec)
			net.WriteString(reqIDRec)
		end)
	end)
end

--[[
	CLIENT
]]
if (CLIENT) then
	netPoint._openRequests = (netPoint._openRequests or {})

	--[[Receive netpoint messages]]
	net.Receive(netPoint._receivers["cl"],
	function(len)
		local dataRes, dataBInt = netPoint:DecompressNetData()
		local nmReqEP = net.ReadString()
		local nmReqID = net.ReadString()

		if (!dataRes or !nmReqEP or !nmReqID) then return end

		local epData = netPoint:GetEndPoint(nmReqEP)
		local data = netPoint:GetRequest(nmReqID)
		data = (data && data.data)

		if (epData && data) then
			-- Add to cache
			netPoint._cache[nmReqID] = (netPoint._cache[nmReqID] or {})
			table.insert(netPoint._cache[nmReqID], {
				params = data,
				result = dataRes,
			})

			-- Run receive results callback
			local recRes = data.receiveResults

			if (istable(recRes)) then
				for k,v in pairs(dataRes) do
					local resResVal = recRes[k]

					if (isfunction(resResVal)) then
						resResVal(v)
					end
				end
			elseif (isfunction(recRes)) then
				recRes(dataRes)
			end

			netPoint:RemoveRequest(nmReqID)	-- Close the request

			netPoint:DebugMessage("RESULT RECEIVED: " .. nmReqID .. " (SIZE: " .. (dataBInt || "NIL") .. " bytes)" .. " - " .. os.date("%H:%M:%S - %m/%d/%Y", os.time()))
		end
	end)

	--[[Receive payload messages]]
	net.Receive(netPoint._receivers["payload"],
	function(len)
		local data, dataBInt, compData = netPoint:DecompressNetData()
		local pLoadHeader = string.Explode(",", net.ReadString())
		local pLoadExtraHeader = net.ReadString()
		local pLoadID, pLoadRandID, pLoadSize, pLoadFragmentID, svCRC = unpack(pLoadHeader)
		local onReceive = netPoint._payloads[pLoadID]

		pLoadExtraHeader = zlib.util:Deserialize(pLoadExtraHeader)
		pLoadExtraHeader = (istable(pLoadExtraHeader) && unpack(pLoadExtraHeader) || false)
		
		if (onReceive) then
			local clCRC = util.CRC(compData)

			netPoint._payloadBuffer[pLoadID][pLoadRandID] = (netPoint._payloadBuffer[pLoadID][pLoadRandID] or {})

			if (svCRC != clCRC) then table.remove(netPoint._payloadBuffer[pLoadID], pLoadRandID) return end

			table.insert(netPoint._payloadBuffer[pLoadID][pLoadRandID], pLoadFragmentID, data)

			if (#netPoint._payloadBuffer[pLoadID][pLoadRandID] == tonumber(pLoadSize)) then
				local data = rebuildSplitTable(netPoint._payloadBuffer[pLoadID][pLoadRandID])

				onReceive(data, pLoadExtraHeader)

				table.remove(netPoint._payloadBuffer[pLoadID], pLoadRandID)
			end
		end
	end)

	---------------------
	--> netPoint:RemoveRequest(reqID)
	-- 	-> Returns the specified request or nil if invalid
	--  -> ARGUMENTS
		-- * reqID (STRING) - Unique request name/ID
	---------------------
	function netPoint:GetRequest(reqID)
		return (self._openRequests[reqID] or nil)
	end

	---------------------
	--> netPoint:RemoveRequest(reqID)
	-- 	-> Removes the specified request
	--  -> ARGUMENTS
		-- * reqID (STRING) - Unique request name/ID
	---------------------
	function netPoint:RemoveRequest(reqID)
		self._openRequests[reqID] = nil
	end

	---------------------
	--> netPoint:FromEndPoint(reqEP, reqID, data, retAmt (NIL))
	-- 	-> Requests data from the specified endpoint
	--  -> ARGUMENTS
		-- * reqEP (STRING) - EndPoint name
		-- * retID (STRING) - EndPoint unique request name
		-- * data (TABLE) - EndPoint data/configuration
		-- * retAmt (INTEGER) - This is handled in the function automatically
	---------------------
	function netPoint:FromEndPoint(reqEP, reqID, data, retAmt)
		self._openRequests = (self._openRequests or {})

		local function openRequest(reqEP, data)
			local reqData = (data.requestData || {["_CLERR"] = "[NETPOINT] CLIENT REQUEST ERROR: `data.requestData` invalid \n\treqEP: " .. (reqEP or "NIL")})

			-- Send request
			self:SendCompressedNetMessage(netPoint._receivers["sv"], "SERVER", reqData,
			function()
				net.WriteString(reqEP)
				net.WriteString(tostring(reqID))
			end)

			self:DebugMessage("REQUEST SENT: " .. reqID .. " - " .. os.date("%H:%M:%S - %m/%d/%Y", os.time()))
		end

		local function openListener(reqEP, data)
			local reqTime = CurTime()

			self._openRequests[reqID] = {
				data = data,
				time = reqTime,
			}

			timer.Simple(self.reqTimeout,
			function()
				local req = self:GetRequest(reqID)

				if (req && req.time == reqTime) then
					retAmt = (retAmt && retAmt + 1 or 1)

					self:DebugMessage("RESULT TIMED OUT: " .. reqID .. " (RETRYING - " .. retAmt .. " of " .. self.reqRetryAmt .. ") - " .. os.date("%H:%M:%S - %m/%d/%Y", os.time()))

					self:FromEndPoint(reqEP, reqID, data, retAmt)	-- Retry (Probably dropped/not received)
				end
			end)
		end

		if (retAmt && retAmt >= self.reqRetryAmt) then self:RemoveRequest(reqID) return false end

		openListener(reqEP, data)	-- Open our listener
		openRequest(reqEP, data)	-- Start our request
	end
end

hook.Run("netPoint.Loaded", netPoint)
