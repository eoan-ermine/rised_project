-- "addons\\zlib-1.3\\lua\\zlib\\data\\types\\sh_data_file.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    zlib - (SH) DATA - File
    Developed by Zephruz
]]

zlib.data:RegisterType("file", {
	GetDir = function(self)
		return (self.dir or nil)
	end,
	SetDir = function(self, dir)
		if !(string.EndsWith(dir, "/")) then
			dir = dir .. "/"
		end

		self.dir = dir

		return self
	end,
	GetPath = function(self)
		return (self.path or nil)
	end,
	SetPath = function(self, dir)
		self.path = dir

		return self
	end,
	Find = function(self, fName)
		return file.Find((self.dir or "") .. fName, (self.path or "DATA"))
	end,
	CreateDir = function(self, dirName, setDir)
		file.CreateDir((self.dir or "") .. dirName)

		if (setDir) then self:SetDir((self.dir or "") .. dirName) end

		return self
	end,
	Write = function(self, fName, data)
		file.Write((self.dir or "") .. fName, data)

		return self
	end,
	Read = function(self, fName, sucCb, errCb)
		local data = file.Read((self.dir or "") .. fName, (self.path or "DATA"))

		if (data) then
			if (sucCb) then sucCb(data) end
		else
			if (errCb) then errCb() end
		end

		return data
	end,
})