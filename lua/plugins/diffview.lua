return {
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<CR>" },
      { "<leader>gh", "<cmd>DiffviewFileHistory<CR>" },
      { "<leader>gH", "<cmd>DiffviewFileHistory %<CR>" },
      { "<leader>gh", "<Esc><cmd>'<,'>DiffviewFileHistory<CR>", mode = "x" },
    },
  },
}
