require "user/lazy_bootstrap"
require "user"
require("lazy").setup("plugins", {
    change_detection = {
        notify = false,
    },
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
