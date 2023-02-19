
local dau = {}

dau.downloadTool = {}

dau.downloadTool.aria2 = {
	detect = function(self)
		local r, re, ec = os.execute("aria2c -h")
		if r and (re == "exit") and (ec == 0) then
			self.executable = "aria2c"
		end
	end,
	downloadFile = function(self, url, target)
		local commandline = self.executable .. " --no-conf -o \"" .. target .. "\" \"" .. url .. "\""
		local r, re, ec = os.execute(commandline)
		if r and (re == "exit") and (ec == 0) then
			return true
		end

		return false
	end,
}

dau.downloadTool.curl = {
	detect = function(self)
		local r, re, ec = os.execute("curl --help")
		if r and (re == "exit") and (ec == 0) then
			self.executable = "curl"
		end
	end,
	downloadFile = function(self, url, target)
		local commandline = self.executable .. " -o \"" .. target .. "\" \"" .. url .. "\""
		local r, re, ec = os.execute(commandline)
		if r and (re == "exit") and (ec == 0) then
			return true
		end

		return false
	end,
}

dau.downloadTool.wget = {
	detect = function(self)
		local r, re, ec = os.execute("wget --help")
		if r and (re == "exit") and (ec == 0) then
			self.executable = "wget"
		end
	end,
	downloadFile = function(self, url, target)
		local commandline = self.executable .. " -O \"" .. target .. "\" \"" .. url .. "\""
		local r, re, ec = os.execute(commandline)
		if r and (re == "exit") and (ec == 0) then
			return true
		end

		return false
	end,
}

for _, item in pairs(dau.downloadTool) do
	item:detect()
end

dau.download = function(self, url)
	-- get filename from URL since we don't use redirections
	local n, n2
	repeat
		n = n2
		n2 = string.find(url, "/", n and (n + 1) or 1)
	until n2 == nil
	local target = string.sub(url, n + 1)

	local r = false
	-- try aria2 first
	if dau.downloadTool.aria2.executable then
		r = dau.downloadTool.aria2:downloadFile(url, target)
	elseif dau.downloadTool.wget.executable then
		r = dau.downloadTool.wget:downloadFile(url, target)
	elseif dau.downloadTool.curl.executable then
		r = dau.downloadTool.curl:downloadFile(url, target)
	end

	return r
end

return dau
