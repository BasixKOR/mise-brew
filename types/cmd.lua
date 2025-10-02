local M = {}

-- Execute command and get output
---@meta
---@param command string
---@param opts? {cwd?:string, env?:table<string, string>, timeout?:number}
---@return string
function M.exec(command, opts) end

return M
