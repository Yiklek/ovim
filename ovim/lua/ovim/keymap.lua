-- File: keymap.lua
-- Author: Yiklek
-- Description: keymap for lsp
-- Last Modified: 03 17, 2022
-- Copyright (c) 2022 ovim

local km = require "ovim.misc.keymap"
local map_cr = km.map_cr
local map_cu = km.map_cu
local map_cmd = km.map_cmd
local display = km.display

vim.cmd [[
inoremap <c-h> <left>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>
nnoremap <silent> <esc><esc> :silent! nohlsearch<cr>
nnoremap <leader>ve<space> :edit $MYVIMRC<cr>
nnoremap <leader>vs :source $MYVIMRC<cr>
"粘贴模式
set pastetoggle=<F4>
nmap <F5> :redraw!<cr>

"窗口快捷键
"l-\ 左右分割
nmap <leader>\ :vsplit<space>
" l-- 上下分割
nmap <leader>- :split<space>

" 焦点移动
nmap <leader>wh <c-w>h
nmap <leader>wj <c-w>j
nmap <leader>wk <c-w>k
nmap <leader>wl <c-w>l
" 位置移动
nmap <leader>wJ <c-w>J
nmap <leader>wK <c-w>K
nmap <leader>wH <c-w>H
nmap <leader>wL <c-w>L
" 大小调整
nmap <leader>w= 5<c-w>+
nmap <leader>w- 5<c-w>-
nmap <leader>w, 5<c-w><
nmap <leader>w. 5<c-w>>
nmap <leader>ww 5<c-w>+
nmap <leader>ws 5<c-w>-
nmap <leader>wa 5<c-w><
nmap <leader>wd 5<c-w>>
" 标签
" 关闭当前标签
nmap <leader>tq  <cmd>tabc<CR>
" 关闭所有标签
nmap <leader>tQ  <cmd>tabo<CR>
" 列出所有标签
nmap <leader>tls <cmd>tabs<CR>
" 在新标签中打开
nmap <leader>to  <cmd>tabe<space>
" 新标签打开当前文件
nmap <leader>tsp <cmd>tab split<CR>
" 切换标签
nmap <leader>th gT
nmap <leader>tj gt
nmap <leader>tk gT
nmap <leader>tl gt

nmap <leader>bd <cmd>bd<cr>
nmap <leader>bp <cmd>bp<cr>
nmap <leader>bn <cmd>bn<cr>

nnoremap <leader>q <cmd>q<cr>

nnoremap <tab>1 <cmd>b!1<cr>
nnoremap <tab>2 <cmd>b!2<cr>
nnoremap <tab>3 <cmd>b!3<cr>
nnoremap <tab>4 <cmd>b!4<cr>
nnoremap <tab>5 <cmd>b!5<cr>
nnoremap <tab>6 <cmd>b!6<cr>
nnoremap <tab>7 <cmd>b!7<cr>
nnoremap <tab>8 <cmd>b!8<cr>
nnoremap <tab>9 <cmd>b!9<cr>
nnoremap <tab>0 <cmd>b!10<cr>

noremap [b  <cmd>bp!<cr>
noremap ]b  <cmd>bn!<cr>
noremap ]t  gt
noremap [t  gT

tnoremap <esc><esc> <C-\><C-N>

tnoremap <C-W>h  <C-\><C-N><C-W>h
tnoremap <C-W>j  <C-\><C-N><C-W>j
tnoremap <C-W>k  <C-\><C-N><C-W>k
tnoremap <C-W>l  <C-\><C-N><C-W>l
tnoremap <C-W><C-H>  <C-\><C-N><C-W><C-H>
tnoremap <C-W><C-J>  <C-\><C-N><C-W><C-J>
tnoremap <C-W><C-K>  <C-\><C-N><C-W><C-K>
tnoremap <C-W><C-L>  <C-\><C-N><C-W><C-L>

]]

local function basic()
  local maps = {
    ["n|<leader>\\"] = display "vsplit",
    ["n|<leader>-"] = display "split",
    ["n|<leader>q"] = display "Exit",
    ["n|<leader>t"] = display "Tab",
    ["n|<leader>tq"] = display "Close",
    ["n|<leader>tk"] = display "Prev",
    ["n|<leader>th"] = display "Prev",
    ["n|<leader>tj"] = display "Next",
    ["n|<leader>tl"] = display "Next",
    ["n|<leader>tQ"] = display "CloseAll",
    ["n|<leader>to"] = display "Open",
    ["n|<leader>tp"] = display "OpenCurrentInNewTab",
    ["n|<leader>tL"] = display "List",

    ["n|<leader>w"] = display "Window",
    ["n|<leader>wH"] = display "Move to Left",
    ["n|<leader>wJ"] = display "Move to Below",
    ["n|<leader>wK"] = display "Move to Top",
    ["n|<leader>wL"] = display "Move to Right",
    ["n|<leader>wa"] = display "Decrease Width",
    ["n|<leader>w,"] = display "Decrease Width",
    ["n|<leader>wd"] = display "Increase Width",
    ["n|<leader>w."] = display "Increase Width",
    ["n|<leader>ws"] = display "Decrease Height",
    ["n|<leader>ww"] = display "Increase Height",
    ["n|<leader>w-"] = display "Decrease Height",
    ["n|<leader>w="] = display "Increase Height",
    ["n|<leader>wh"] = display "Focus to Left",
    ["n|<leader>wj"] = display "Focus to Below",
    ["n|<leader>wk"] = display "Focus to Top",
    ["n|<leader>wl"] = display "Focus to Right",

    ["n|<leader>e"] = display "Extensions",
  }
  return maps
end

km.load(basic())
km.load(require("ovim.modules.search.keymap").telescope())
km.load(require("ovim.modules.lsp.keymap").vista())

return {
  basic = basic,
}
