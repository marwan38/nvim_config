----------------------------------------------[[ Bootstrap Lazy ]]

require "user/lazy_bootstrap" -- bootstraps folke/lazy

----------------------------------------------[[  User Settings ]]

require "user"

----------------------------------------------[[  Load Plugins  ]]

-- loads each lua/plugin/*
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
})
