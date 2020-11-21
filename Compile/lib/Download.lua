
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
		local commandline = self.executable .. " -o \"" .. target .. "\" \"" .. url .. "\""
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

dau.uncompressTool = {}

dau.uncompressTool["7z"] = { -- includes 7z 7za 7zr
	detect = function(self)
		for _, i in ipairs({ "7z", "7za", "7zr" }) do
			local r, re, ec = os.execute(i)
			if r and (re == "exit") and (ec == 0) then
				self.executable = i
				break
			end
		end
	end,
	uncompress = function(self, file)
		local commandline = self.executable .. " x -y " .. file
		local r, re, ec = os.execute(commandline)
		if r and (re == "exit") and (ec == 0) then
			return true
		end

		return false
	end,
}

-- info-zip

dau.uncompressTool.tar = { -- includes tar bsdtar
	detect = function(self)
		for _, i in ipairs({ "bsdtar", "tar" }) do
			local r, re, ec = os.execute(i .. " --help")
			if r and (re == "exit") and (ec == 0) then
				self.executable = i
				break
			end
		end
	end,
	uncompress = function(self, file)
		local commandline = self.executable .. " -xf " .. file
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

for _, item in pairs(dau.uncompressTool) do
	item:detect()
end

dau.downloadAndUncompress = function(self, url)
	-- get filename from URL since we don't use redirections
	local n, n2
	repeat
		n = n2
		n2 = string.find(url, "/", n and (n + 1) or 1)
	until n2 == nil
	local target = string.sub(url, n + 1)

	print(target .. "\n")

	local r = false
	-- try aria2 first
	if dau.downloadTool.aria2.executable then
		r = dau.downloadTool.aria2:downloadFile(url, target)
	elseif dau.downloadTool.wget.executable then
		r = dau.downloadTool.wget:downloadFile(url, target)
	elseif dau.downloadTool.curl.executable then
		r = dau.downloadTool.curl:downloadFile(url, target)
	end

	if not r then return false end

	-- uncompress
	if string.sub(target, -3) == ".7z" and dau.uncompressTool["7z"].executable then
		r = dau.uncompressTool["7z"]:uncompress(target)
	elseif string.sub(target, -4) == ".zip" and dau.uncompressTool["7z"].executable then
		r = dau.uncompressTool["7z"]:uncompress(target)
	elseif ((string.sub(target, -7) == ".tar.gz") or (string.sub(target, -8) == ".tar.bz2") or (string.sub(target, -7) == ".tar.xz")) and dau.uncompressTool.tar.executable then
		r = dau.uncompressTool.tar:uncompress(target)
	end

	return r
end

return dau
