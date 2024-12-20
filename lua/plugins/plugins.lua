return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "php",
        "phpdoc",
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "phpstan",
        "intelephense",
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      ensure_installed = {
        "php",
        "node2",
        "chrome",
        "js",
      },
    },
  },
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

  -- Disabled plugins
  { "folke/noice.nvim", enabled = false },
}
