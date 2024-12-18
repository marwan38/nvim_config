local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
      opts = {
        colorscheme = "github_dark_default",
      },
    },
    { import = "plugins" },
    {
      "sainnhe/gruvbox-material",
      priority = 1000,
      lazy = false,
      init = function()
        vim.g.gruvbox_material_background = "soft"
      end,
    },
    { "projekt0n/github-nvim-theme", name = "github-theme" },
    { "rose-pine/neovim", name = "rose-pine" },
    {
      "sindrets/diffview.nvim",
      keys = {
        { "<leader>gd", "<cmd>DiffviewOpen<CR>" },
        { "<leader>gh", "<cmd>DiffviewFileHistory<CR>" },
        { "<leader>gH", "<cmd>DiffviewFileHistory %<CR>" },
        { "<leader>gh", "<Esc><cmd>'<,'>DiffviewFileHistory<CR>", mode = "x" },
      },
    },

    { import = "lazyvim.plugins.extras.ui.alpha" },
    -- { import = "lazyvim.plugins.extras.coding.codeium" },

    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    { import = "lazyvim.plugins.extras.lang.rust" },
    { import = "lazyvim.plugins.extras.lang.go" },
    { import = "lazyvim.plugins.extras.lang.docker" },
    { import = "lazyvim.plugins.extras.lang.terraform" },

    { import = "lazyvim.plugins.extras.dap.core" },

    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { import = "lazyvim.plugins.extras.linting.eslint" },

    -- Disabled plugins
    { "folke/noice.nvim", enabled = false },
  },
  defaults = {
    lazy = true,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "catppuccin" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
