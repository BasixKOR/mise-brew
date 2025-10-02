local M = {}

---Joins path segments into a path.
---@meta
---@param ... string
---@return string
function M.join_path(...) end

---Read a file entirely.
---@param path string
---@return string
function M.read(path) end

---Create a symbolic link.
---@param source string
---@param target string
function M.symlink(source, target) end

return M
