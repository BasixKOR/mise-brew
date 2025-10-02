local M = {}

-- Sends a HTTP GET request.
---@meta
---@param request {url:string, headers?:table<string, string>}
---@return {status_code:integer, body:string, headers:table<string,string>, content_length:integer} response
---@return any err
function M.get(request) end

-- Sends a HTTP HEAD request.
---@meta
---@param request {url:string, headers:table<string, string>}
---@return {status_code:integer, headers:table<string,string>}
function M.head(request) end

-- Downloads a file to the given location.
-- @meta
---@param request {url:string, headers:table<string, string>}
---@param path string
---@return any|nil
function M.download_file(request, path) end

return M
