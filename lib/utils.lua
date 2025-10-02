local cmd = require("cmd")
local strings = require("strings")
local M = {}

function M.log(message, ...)
    local json = require("json")
    if ... ~= nil then
        local args = { ... }
        for i, value in ipairs(args) do
            if type(value) == "table" then
                args[i] = json.encode(value)
            end
        end
        message = message:format(table.unpack(args))
    elseif type(message) ~= "string" then
        message = json.encode(message)
    end

    print(message)
end

-- https://github.com/Homebrew/brew/blob/f2cdfda0f73bfd5d1fbb35a55c6f72c386a3e199/Library/Homebrew/macos_version.rb#L22
function M.get_os_symbol()
    if RUNTIME.osType == "linux" and RUNTIME.archType == "amd64" then
        return "x86_64_linux"
    end

    if RUNTIME.osType == "linux" and RUNTIME.archType == "arm64" then
        return "arm64_linux"
    end

    local prefix = ""
    if RUNTIME.archType == "amd64" then
        prefix = "arm64_"
    end

    if RUNTIME.osType == "darwin" then
        local macos_version = cmd.exec("sw_vers -productVersion")
        if strings.has_prefix(macos_version, "26") then
            return prefix .. "tahoe"
        end
        if strings.has_prefix(macos_version, "15") then
            return prefix .. "sonoma"
        end
        if strings.has_prefix(macos_version, "14") then
            return prefix .. "ventura"
        end
        if strings.has_prefix(macos_version, "13") then
            return prefix .. "monterey"
        end
        -- There's more but...
        error("Unsupported macOS version: " .. macos_version)
    end

    error("Unsupported OS: " .. RUNTIME.osType)
end

return M
