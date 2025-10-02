local http = require("http")
local json = require("json")
local strings = require("strings")
local utils = require("utils")
-- hooks/backend_list_versions.lua
-- Lists available versions for a tool in this backend
-- Documentation: https://mise.jdx.dev/backend-plugin-development.html#backendlistversions
function PLUGIN:BackendListVersions(ctx)
    local tool = ctx.tool

    -- Validate tool name
    if not tool or tool == "" then
        error("Tool name cannot be empty")
    end

    -- Example implementations (choose/modify based on your backend):

    -- Example 1: API-based version listing (like npm, pip, cargo)

    local resp, err = http.get({
        url = "https://formulae.brew.sh/api/formula/" .. tool .. ".json",
    })
    if err then
        error("Failed to fetch versions for " .. tool .. ": " .. err)
    end
    if resp.status_code ~= 200 then
        error("API returned status " .. resp.status_code .. " for " .. tool)
    end

    -- Now there's a lot of assumptions:
    -- * A given formulae won't become non-relocatable (cellar: any to cellar).
    -- * A build for this environment will be available for all versions. Although it will fail if build isn't there.
    -- * If a build for current environment doesn't exist, it won't for all versions.

    local data = json.decode(resp.body)
    local os_symbol = utils.get_os_symbol()

    if data.bottle.stable.files[os_symbol] == nil then
        error("No bottle available for " .. tool .. " on " .. os_symbol)
    end
    if not strings.has_prefix(data.bottle.stable.files[os_symbol].cellar, ":any") then
        -- TODO: Make this configurable
        error("The bottle available for " .. tool .. " on " .. os_symbol .. "is not relocatable")
    end

    return { versions = { data.versions.stable } }
end
