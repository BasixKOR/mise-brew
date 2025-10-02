-- metadata.lua
-- Backend plugin metadata and configuration
-- Documentation: https://mise.jdx.dev/backend-plugin-development.html

PLUGIN = { -- luacheck: ignore
    -- Required: Plugin name (will be the backend name users reference)
    name = "brew",

    -- Required: Plugin version (not the tool versions)
    version = "0.0.1",

    -- Required: Brief description of the backend and tools it manages
    description = "A mise backend for fetching Homebrew Bottles",

    -- Required: Plugin author/maintainer
    author = "BasixKOR",

    -- Optional: Plugin homepage/repository URL
    homepage = "https://github.com/BasixKOR/mise-brew",

    -- Optional: Plugin license
    license = "MIT",

    -- Optional: Important notes for users
    notes = {
        "Windows will not be supported as Homebrew does not build binaries for it.",
        -- "This plugin manages tools from the <BACKEND> ecosystem"
    },
}
