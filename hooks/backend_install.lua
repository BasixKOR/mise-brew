local http = require("http")
local json = require("json")
local cmd = require("cmd")
local utils = require("utils")
-- hooks/backend_install.lua
-- Installs a specific version of a tool
-- Documentation: https://mise.jdx.dev/backend-plugin-development.html#backendinstall

function PLUGIN:BackendInstall(ctx)
    local tool = ctx.tool
    local version = ctx.version
    local install_path = ctx.install_path

    -- Validate inputs
    if not tool or tool == "" then
        error("Tool name cannot be empty")
    end
    if not version or version == "" then
        error("Version cannot be empty")
    end
    if not install_path or install_path == "" then
        error("Install path cannot be empty")
    end

    -- Create installation directory
    cmd.exec("mkdir -p " .. install_path)

    -- Example implementations (choose/modify based on your backend):
    local resp, err = http.get({
        url = "https://formulae.brew.sh/api/formula/" .. tool .. ".json",
    })
    if err then
        error("Failed to fetch versions for " .. tool .. ": " .. err)
    end
    if resp.status_code ~= 200 then
        error("API returned status " .. resp.status_code .. " for " .. tool)
    end

    local data = json.decode(resp.body)

    if data.versions.stable ~= version then
        error("The specified version " .. version .. " is no longer available for " .. tool .. ", please use latest")
    end

    -- Download the tool

    local token = require("auth").get_bearer_token(tool)
    local os_symbol = utils.get_os_symbol()

    utils.log(
        "token: " .. token .. ", os_symbol: " .. os_symbol .. ", url: " .. data.bottle.stable.files[os_symbol].url .. ""
    )

    local download_url = data.bottle.stable.files[os_symbol].url

    if download_url == nil then
        error("No download URL found for " .. tool .. " on " .. os_symbol)
    end

    local temp_file = install_path .. "/" .. tool .. ".tar.gz"
    local err = http.download_file({
        url = download_url,
        headers = {
            ["Authorization"] = "Bearer " .. token,
            ["Accept"] = "application/vnd.oci.image.layer.v1.tar+gzip",
        },
    }, temp_file)

    if err then
        error("Failed to download " .. tool .. "@" .. version .. ": " .. err)
    end

    -- Extract the archive
    cmd.exec("cd " .. install_path .. " && tar --strip-components 2 -xzf " .. temp_file)
    cmd.exec("rm " .. temp_file)

    -- Set executable permissions
    cmd.exec("chmod +x " .. install_path .. "/bin/" .. tool)
    return {}
end
