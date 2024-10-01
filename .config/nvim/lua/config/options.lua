-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"
vim.opt.guicursor = ""
vim.opt.softtabstop = 2
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.isfname:append("@-@")
vim.opt.encoding = "utf-8"
vim.opt.backspace = "indent,eol,start"
-- vim.opt.mouse = "a"
vim.opt.mousemoveevent = true
vim.cmd([[
  syntax enable
]])

vim.g.NERDSpaceDelims = 1
vim.g.vimspector_enable_mappings = 'VISUAL_STUDIO'
vim.g.airline = {}
vim.g["airline#extensions#tabline#enabled"] = 1