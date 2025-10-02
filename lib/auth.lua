require("utils")

local M = {}

---@param tool string
---@return string
function M.get_bearer_token(tool)
    local token_url = "https://ghcr.io/token"

    -- https://distribution.github.io/distribution/spec/auth/token/

    local http = require("http")
    local res, err = http.get({
        url = token_url .. "?service=ghcr.io&scope=repository:homebrew/core/" .. tool .. ":pull&client_id=mise",
    })

    if err then
        error("Failed to fetch token: " .. err)
    end

    local json = require("json")
    local token_document = json.decode(res.body)

    if res.status_code ~= 200 then
        local error = token_document.errors[1]
        error("API returned error code " .. error.code .. " for " .. tool)
    end

    return token_document.token
end

return M
