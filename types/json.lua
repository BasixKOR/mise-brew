local M = {}

-- Encode a value to a JSON string.
---@meta
---@param value any
---@return string
function M.encode(value) end

-- Decode a JSON string to a value.
---@meta
---@param value string
---@return any
function M.decode(value) end

return M
