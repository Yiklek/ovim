vim.g.mapleader = " "
vim.g.maplocalleader = "<tab>"
if vim.fn.has "nvim-0.10" ~= 1 then
  vim.o.nocompatible = true
  vim.o.nobackup = true
end
vim.cmd [[
  filetype on
  filetype plugin on
  syntax enable
  syntax on
]]

vim.o.number = true
vim.o.cursorline = true
vim.o.ts = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.encoding = "utf-8"
vim.o.hlsearch = true
vim.o.scrolloff = 3
vim.o.shortmess = "atI"
vim.o.autoread = true
vim.o.mouse = "a"
vim.o.backspace = "indent,eol,start"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.timeoutlen = 200
vim.o.clipboard = "unnamedplus"
vim.o.signcolumn = "yes"
vim.o.autowrite = true -- Enable auto write
vim.o.completeopt = "menu,menuone,noselect"
vim.o.confirm = true -- Confirm to save changes before exiting modified buffer
vim.o.showmode = false -- Dont show mode since we have a statusline
vim.o.undofile = true
vim.o.undolevels = 10000
vim.opt.shortmess:append { W = true, I = true, c = true }
vim.o.cursorline = true -- Enable highlighting of the current line
