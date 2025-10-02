--[[
Do not change any thing in the current file,
it's just there to show what objects are injected by vfox and what they do.

It's just handy when developing plugins, IDE can use this object for code hints!
 --]]
---@meta
RUNTIME = {
    --- Operating system type at runtime (Windows, Linux, Darwin)
    ---@meta
    ---@type "darwin"|"windows"|"linux"
    osType = "",
    --- Operating system architecture at runtime (amd64, arm64, etc.)
    ---@meta
    ---@type "amd64"|"arm64"
    archType = "",
    --- vfox runtime version
    version = "",
    --- Plugin directory
    pluginDirPath = "",
}
