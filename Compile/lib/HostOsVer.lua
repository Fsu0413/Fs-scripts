
local hostOsVer = {}

hostOsVer.Windows = function()
    local file, err = io.popen("cmd /c ver" , "r")
    if not file then return fail, err end

    -- the version string is in the second line
    file:read()
    local line = file:read()
    file:close()

    -- currently we are using only Windows 10+
    local major, minor, patch
    string.gsub(line, "%[[^%d]+(%d+)%.(%d+)%.(%d+)[^%]]*%]", function(...)
        major, minor, patch = ...
    end)

    if not major then return fail, "pattern didn't match line " .. line end

    local prefix

    if tonumber(major) < 5 then
        -- Windows 9x / ME / NT4.0 / pre-3.2, not supported
    if tonumber(major) == 5 then
        if tonumber(minor) == 0 then
            prefix = "Windows 2000"
        elseif tonumber(minor) == 1 or tonumber(minor) == 2 then
            prefix = "Windows XP"
        end
    elseif tonumber(major) == 6 then
        if tonumber(minor) == 0 then
            prefix = "Windows Vista"
        elseif tonumber(minor) == 1 then
            prefix = "Windows 7"
        elseif tonumber(minor) == 2 then
            prefix = "Windows 8"
        elseif tonumber(minor) == 3 then
            prefix = "Windows 8.1"
        elseif tonumber(minor) == 4 then
            prefix = "Windows 10"
        end
    elseif tonumber(major) == 10 then
        if tonumber(minor) == 0 then
            -- first Windows 11 is build 10.0.22000.1
            if tonumber(patch) < 22000 then
                prefix = "Windows 10"
            else
                prefix = "Windows 11"
            end
        end
    end

    -- known Windows 10 / 11 codename
    local codename = {
        ["10240"] = "1507",
        ["10586"] = "1511",
        ["14393"] = "1607", -- or Windows Server 2016
        ["15063"] = "1703",
        ["16299"] = "1709",
        ["17134"] = "1803",
        ["17763"] = "1809", -- or Windows Server 2019
        ["18362"] = "1903",
        ["18363"] = "1909",
        ["19041"] = "2004",
        ["19042"] = "20H2",
        ["19043"] = "21H1",
        ["19044"] = "21H2",
        ["19045"] = "22H2", -- final version of Windows 10

        ["20348"] = "21H2", -- Windows Server 2022 only
        ["20349"] = "22H2", -- Does this really exist?

        ["22000"] = "21H2", -- first version of Windows 11
        ["22621"] = "22H2",
    }

    if not prefix then
        return fail, "Windows version not supported " .. line
    end

    return prefix .. " " .. major .. "." .. minor .. "." .. patch
end

return hostOsVer
