-- lua configuratiuon file for neovim

local opt = vim.opt
local g = vim.g

opt.clipboard = "unnamedplus"
opt.cursorline = true
opt.showmode = false

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.ruler = false

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 300
opt.undofile = true


g.mapleader = ","
-- opt.fillchars = { eob = "~" }
opt.scrolloff = 4
opt.spelllang = "fr"
opt.colorcolumn = {100}
opt.textwidth = 100
opt.timeoutlen = 1000
opt.breakindent = true

opt.foldmethod = "expr"
opt.foldlevelstart = 99
opt.foldexpr = 'nvim_treesitter#foldexpr()'

require("bootstrap")

local plugins = require("plugins")
require("lazy").setup(plugins)

vim.cmd.colorscheme "catppuccin"
opt.background = "light"

require("mappings")

-- camenu = require("camenu")
-- bind right click to open camenu
-- vim.keymap.set("n", "<RightMouse>", "<LeftMouse>:lua require('camenu').calistener()<CR>")
-- vim.keymap.set(
--   "n",
--   "<RightRelease>",
--   camenu.calistener
-- )
