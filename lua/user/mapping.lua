local utils = require('user.utils')

vim.g.mapleader = " "

vim.keymap.set({ "n" }, "x", '"_x')
vim.keymap.set({ "n" }, "c", '"_c')
vim.keymap.set({ "n" }, "<ESC>", "<Cmd>noh<CR>", utils.opts)
vim.keymap.set({ "v" }, "<", "<gv", utils.opts)
vim.keymap.set({ "v" }, ">", ">gv", utils.opts)

-- Move lines up and down
vim.keymap.set({ "n", "v" }, "<M-j>", "<Cmd>m .+1<CR>==", utils.set_opts("[M]ove line down"))
vim.keymap.set({ "n", "v" }, "<M-k>", "<Cmd>m .-2<CR>==", utils.set_opts("[M]ove line up"))

-- Tabs
vim.keymap.set({ "n" }, "<leader>x", "<Cmd>tabc<CR>", utils.set_opts("Tab close"))
vim.keymap.set({ "n" }, "<leader><Tab>", "<Cmd>tabnext<CR>", utils.set_opts("Tab next"))
vim.keymap.set({ "n" }, "<leader>tn", "<Cmd>tabnew<CR>", utils.set_opts("[T]ab [n]ew"))

-- Quickfix
vim.keymap.set({ "n" }, "<C-q>", "<Cmd>copen<CR>")
vim.keymap.set({ "n" }, "]q", "<Cmd>cnext<CR>")
vim.keymap.set({ "n" }, "[q", "<Cmd>cprev<CR>")

-- Search and replace with word under cursor
vim.keymap.set({ "n" }, "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Stop it
-- vim.keymap.set({ "n" }, "q", "<Nop>")
