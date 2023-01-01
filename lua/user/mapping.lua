local opts = { silent = true }
local expr_opts = { silent = true, expr = true }

vim.g.mapleader = " "

-- stylua: ignore start
vim.keymap.set({ "n"      }, "x"        , '"_x')
vim.keymap.set({ "n"      }, "<ESC>"    , "<Cmd>noh<CR>", opts)
vim.keymap.set({      "v" }, "<"        , "<gv",      opts)
vim.keymap.set({      "v" }, ">"        , ">gv",      opts)

-- Tabs
vim.keymap.set({ "n"      }, "<leader>x", '<Cmd>tabc<CR>')

-- Buffers
vim.keymap.set({ "n"      }, "<leader>bk", '<Cmd>bd<CR>', {desc = "[B]uffer [K]ill"})

-- Search and replace with word under cursor
vim.keymap.set({ "n"      }, "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- stylua: ignore end
