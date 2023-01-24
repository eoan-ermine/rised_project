-- "addons\\zlib-1.3\\lua\\zlib\\data\\types\\sh_data_mysql.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    zlib - (SH) DATA - Mysqloo
    Developed by Zephruz
]]

zlib.data:RegisterType("mysqloo", {
	isConnected = function(self)
		return self._dbconn && self._dbconn:status() == mysqloo.DATABASE_CONNECTED
	end,
	dbString = function(self)
		local cfg = self:GetConfig()
		local dbInfo = (cfg && cfg.mysqlInfo || false)

		return string.format("[%s - %s]", self:GetName(), (dbInfo && dbInfo.dbHost || "UNKNOWN HOST"))
	end,
	connect = function(self, sucCb, errCb)
		local db
		local res, resErr = pcall(require, "mysqloo")
		local cfg = self:GetConfig()
		local dbInfo = (cfg && cfg.mysqlInfo || false)

		if !(dbInfo) then zlib:ConsoleMessage("Invalid MySQL info, cancelling connection attempt.") return end

		if (self:isConnected()) then
			if (sucCb) then
				sucCb()
			end
		elseif (res) then
			db = mysqloo.connect(dbInfo.dbHost, dbInfo.dbUser, dbInfo.dbPass, dbInfo.dbName, (dbInfo.dbPort or 3306))

			db.onConnected = function(s)
				zlib:DebugMessage(self:dbString(), " Connected to database")
				
				if (sucCb) then
					sucCb()
				end
			end

			db.onConnectionFailed = function(s, err)
				zlib:ConsoleMessage(self:dbString(), Color(255,125,35), " Failed to connect to database! Error: " .. err)

				if (errCb) then
					errCb(err)
				end
			end

			db:setAutoReconnect(true)
			db:connect()

			self._dbconn = db
		else
			ErrorNoHalt(resErr)
		end
	end,
	disconnect = function(self, sucCb, errCb)
		local isConnected = self:isConnected()

		if (isConnected) then
			self._dbconn:disconnect(isConnected)
			
			zlib:DebugMessage(self:dbString(), " Disconnected from database")
		end

		if (sucCb) then 
			sucCb(!self:isConnected()) 
		end
	end,
	query = function(self, query, sucCb, errCb)
		if !(self:isConnected()) then return false end

		query = query:gsub("AUTOINCREMENT", "AUTO_INCREMENT")

		local q = self._dbconn:query(query)

		q.onSuccess = function(s, data)
			if (sucCb) then sucCb(data, s:lastInsert()) end
		end
		q.onError = function(s, err, sql)
			zlib:DebugMessage(string.format("%s %s", self:dbString(), err .. "\n" .. sql))
			
			if (errCb) then errCb(err, sql) end
		end
		q.onAbort = function(s, sql)
			local err = "Query was aborted!\n" .. sql

			zlib:DebugMessage(string.format("%s %s", self:dbString(), err))

			if (errCb) then 
				errCb(err, sql) 
			end
		end
		
		q:start()
	end,
	getDatabaseConnection = function(self)
		return self._dbconn
	end,
})