----------------------------------------------[[ Bootstrap Lazy ]]

require "user/lazy_bootstrap" -- bootstraps folke/lazy

----------------------------------------------[[  User Settings ]]

require "user"
require "user.options"
require "user.autocommands"
require "user.mapping"

----------------------------------------------[[  Load Plugins  ]]

require("lazy").setup("plugins", {
    disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
    },
}) -- loads each lua/plugin/*
