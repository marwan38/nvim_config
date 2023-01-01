local opt = vim.opt

opt.nu = true;
opt.relativenumber = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.clipboard:append "unnamedplus"

opt.smartindent = true

opt.splitbelow = true
opt.splitright = true

opt.ignorecase = true
opt.smartcase = true

opt.wrap = false

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv "HOME" .. "/.undodir"
opt.undofile = true

opt.hlsearch = true
opt.incsearch = true

opt.termguicolors = true

opt.scrolloff = 12
opt.signcolumn = "yes"
opt.isfname:append "@-@"

opt.updatetime = 50

opt.colorcolumn = "80"

-- opt.list = true
-- opt.listchars:append("eol:↵")
opt.fillchars = "vert:│,diff:╱,foldclose:,foldopen:,fold: ,msgsep:─"

-- opt.diffopt = {
--   "algorithm:histogram",
--   "internal",
--   "indent-heuristic",
--   "filler",
--   "closeoff",
--   "iwhite",
--   "vertical"
-- }
