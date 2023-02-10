-- File: keymap.lua
-- Author: Yiklek
-- Description: keymap for lsp
-- Last Modified: 03 17, 2022
-- Copyright (c) 2022 ovim

local km = require("ovim.misc.keymap")
local map_cr = km.map_cr
local map_cu = km.map_cu
local map_cmd = km.map_cmd
local display = km.display

vim.cmd[[
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
" 下一行
imap <leader><CR> <esc>o
nmap <leader><CR> <esc>o
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
nmap <leader>tq  :tabc<CR>
" 关闭所有标签
nmap <leader>tQ  :tabo<CR>
" 列出所有标签
nmap <leader>tls :tabs<CR>
" 在新标签中打开
nmap <leader>to  :tabe<space>
" 新标签打开当前文件
nmap <leader>tsp :tab split<CR>
" 切换标签
nmap <leader>th gT
nmap <leader>tj gt
nmap <leader>tk gT
nmap <leader>tl gt

nmap <leader>bd :bd<cr>
nmap <leader>bp :bp<cr>
nmap <leader>bn :bn<cr>

nnoremap <leader>q :q<cr>

nnoremap <tab>1 :b!1<cr>
nnoremap <tab>2 :b!2<cr>
nnoremap <tab>3 :b!3<cr>
nnoremap <tab>4 :b!4<cr>
nnoremap <tab>5 :b!5<cr>
nnoremap <tab>6 :b!6<cr>
nnoremap <tab>7 :b!7<cr>
nnoremap <tab>8 :b!8<cr>
nnoremap <tab>9 :b!9<cr>
nnoremap <tab>0 :b!10<cr>

noremap [b  :bp!<cr>
noremap ]b  :bn!<cr>
noremap ]t  gt
noremap [t  gT

tnoremap <esc><esc> <C-\><C-N>
if has("nvim")
    tnoremap <C-W>h  <C-\><C-N><C-W>h
    tnoremap <C-W>j  <C-\><C-N><C-W>j
    tnoremap <C-W>k  <C-\><C-N><C-W>k
    tnoremap <C-W>l  <C-\><C-N><C-W>l
    tnoremap <C-W><C-H>  <C-\><C-N><C-W><C-H>
    tnoremap <C-W><C-J>  <C-\><C-N><C-W><C-J>
    tnoremap <C-W><C-K>  <C-\><C-N><C-W><C-K>
    tnoremap <C-W><C-L>  <C-\><C-N><C-W><C-L>
endif
]]

local function basic()
    local maps = {
        ["n|<leader>\\"] = display("vsplit"),
        ["n|<leader>-"] = display("split"),
        ["n|<leader>q"] = display("Exit"),
        ["n|<leader>t"] = display("Tab"),
        ["n|<leader>tq"] = display("Close"),
        ["n|<leader>tk"] = display("Prev"),
        ["n|<leader>th"] = display("Prev"),
        ["n|<leader>tj"] = display("Next"),
        ["n|<leader>tl"] = display("Next"),
        ["n|<leader>tQ"] = display("CloseAll"),
        ["n|<leader>to"] = display("Open"),
        ["n|<leader>tp"] = display("OpenCurrentInNewTab"),
        ["n|<leader>tL"] = display("List"),

        ["n|<leader>w"] = display("Window"),
        ["n|<leader>wH"] = display("Move to Left"),
        ["n|<leader>wJ"] = display("Move to Below"),
        ["n|<leader>wK"] = display("Move to Top"),
        ["n|<leader>wL"] = display("Move to Right"),
        ["n|<leader>wa"] = display("Decrease Width"),
        ["n|<leader>w,"] = display("Decrease Width"),
        ["n|<leader>wd"] = display("Increase Width"),
        ["n|<leader>w."] = display("Increase Width"),
        ["n|<leader>ws"] = display("Decrease Height"),
        ["n|<leader>ww"] = display("Increase Height"),
        ["n|<leader>w-"] = display("Decrease Height"),
        ["n|<leader>w="] = display("Increase Height"),
        ["n|<leader>wh"] = display("Focus to Left"),
        ["n|<leader>wj"] = display("Focus to Below"),
        ["n|<leader>wk"] = display("Focus to Top"),
        ["n|<leader>wl"] = display("Focus to Right"),
        ["n|<leader>w<space>"] = display("Choose Window"),

        -- the following keymaps are for plugins loaded by dein or vim-plug
        -- and will be remove in the future
        -- Floaterm
        ["n|<leader>e"] = display("Extensions"),
        ["n|<leader>et"] = display("Floaterm"),
        ["n|<leader>et<space>"] = display("Floaterm Toggle"),
        ["n|<leader>et;"] = display("First Terminal"),
        ["n|<leader>et'"] = display("Last Terminal"),
        ["n|<leader>etq"] = display("Kill Terminal"),
        ["n|<leader>etw"] = display("New Terminal Window"),
        ["n|<leader>etw<space>"] = display("Right Window"),
        ["n|<leader>etwr"] = display("Right Window"),
        ["n|<leader>etwb"] = display("Bottom Window"),
        ["n|<leader>et9"] = display("Previous Terminal"),
        ["n|<leader>et0"] = display("Next Terminal"),
        ["n|<leader>etn"] = display("New Terminal"),
        ["n|<leader>et="] = display("Move to Bottom"),
        ["n|<leader>et-"] = display("Move to Top"),
        ["n|<leader>et["] = display("Move to Left"),
        ["n|<leader>et]"] = display("Move to Right"),
        ["n|<leader>et\\"] = display("Float"),

        ["n|<esc>"] = display("Floaterm"),
        ["n|<esc><space>"] = display("Floaterm Toggle"),
        ["n|<esc>-"] = display("First Terminal"),
        ["n|<esc>="] = display("Last Terminal"),
        ["n|<esc>q"] = display("Kill Terminal"),
        ["n|<esc>w"] = display("New Terminal Window"),
        ["n|<esc>w<space>"] = display("Right Window"),
        ["n|<esc>wr"] = display("Right Window"),
        ["n|<esc>wb"] = display("Bottom Window"),
        ["n|<esc>["] = display("Previous Terminal"),
        ["n|<esc>]"] = display("Next Terminal"),
        ["n|<esc>n"] = display("New Terminal"),
        ["n|<esc>?"] = display("Help"),
        ["n|<esc>j"] = display("Move to Bottom"),
        ["n|<esc>k"] = display("Move to Top"),
        ["n|<esc>h"] = display("Move to Left"),
        ["n|<esc>l"] = display("Move to Right"),
        ["n|<esc>f"] = display("Float"),

        -- AnyJump
        ["n|<leader>ej"] = display("AnyJump"),
        ["n|<leader>ej<space>"] = display("Jump"),
        ["n|<leader>ejb"] = display("JumpBack"),
        ["n|<leader>ejl"] = display("JumpLastResults"),

        -- AsyncRun
        ["n|<leader>r"] = display("AsyncRun"),
        ["n|<leader>r<space>"] = display("Run"),
        ["n|<leader>rp"] = display("Project Build"),
        ["n|<leader>rb"] = display("File Build"),
        ["n|<leader>rx"] = display("File Run"),
        ["n|<leader>rr"] = display("Project Run"),

        -- Search
        ["n|<leader>s"] = display("Search"),
        ["n|<leader>sp"] = display("CtrlP"),
        ["n|<leader>sp<space>"] = display("CtrlP"),

        ["n|<leader>sf"] = display("FZF"),
        ["n|<leader>sf<space>"] = display("Files"),

        ["n|<leader>sl"] = display("Leaderf"),
        ["n|<leader>sl<space>"] = display("LeaderFile"),


        ["n|<leader>x"] = display("Edit"),
        ["n|<leader>xf"] = display("Format"),

    }
    return maps
end

km.load(basic())
km.load(require("ovim.modules.search.keymap").telescope())
km.load(require("ovim.modules.lsp.keymap").vista())

return {
    basic = basic
}
