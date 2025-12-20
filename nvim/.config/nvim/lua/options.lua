--basic setting
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.cursorline = true
vim.o.mouse = "a"
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.clipboard = "unnamedplus"
vim.opt.fillchars:append({ eob = " " }) -- Unicode non-breaking space (U+202F)
vim.opt.shortmess:append("I") -- tắt intro message
