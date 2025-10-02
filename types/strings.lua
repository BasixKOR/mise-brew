local M = {}

-- Check prefixes
---@meta
---@param text string
---@param prefix string
---@return boolean
function M.has_prefix(text, prefix) end

-- Check suffixes
---@meta
---@param text string
---@param suffix string
---@return boolean
function M.has_suffix(text, suffix) end

return M
