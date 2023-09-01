-- File: keymap.lua
-- Author: Yiklek
-- Description: keymap for lsp
-- Last Modified: 03 17, 2022
-- Copyright (c) 2022 ovim

local km = require("ovim.core.keymap")
local map_cr = km.map_cr
local map_cu = km.map_cu
local map_cmd = km.map_cmd
local map = km.map
local map_f = km.map_f
local display = km.display
local window = require("ovim.core.window")
local config = require("ovim.config")
vim.cmd([[
inoremap <c-h> <left>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>
nnoremap <silent> <esc> <cmd>silent! nohlsearch<cr>

"粘贴模式
set pastetoggle=<F4>
nmap <F5> <cmd>redraw!<cr>

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

noremap [b  <cmd>bp!<cr>
noremap ]b  <cmd>bn!<cr>
noremap ]t  gt
noremap [t  gT

tnoremap <A-/> <C-\><C-N>

tnoremap <C-W>h  <C-\><C-N><C-W>h
tnoremap <C-W>j  <C-\><C-N><C-W>j
tnoremap <C-W>k  <C-\><C-N><C-W>k
tnoremap <C-W>l  <C-\><C-N><C-W>l
tnoremap <C-W><C-H>  <C-\><C-N><C-W><C-H>
tnoremap <C-W><C-J>  <C-\><C-N><C-W><C-J>
tnoremap <C-W><C-K>  <C-\><C-N><C-W><C-K>
tnoremap <C-W><C-L>  <C-\><C-N><C-W><C-L>

]])

local opts = {
  display = {
    enable = true,
  },
  map = {
    noremap = true,
    silent = true,
    nowait = true,
  },
}
local function quit()
  local count = 0
  local current_wins = vim.api.nvim_tabpage_list_wins(0)
  for _, value in pairs(current_wins) do
    local buftype = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(value), "buftype")
    if buftype ~= "nofile" then
      count = count + 1
    end
  end
  if #vim.api.nvim_list_tabpages() > 1 or count > 1 then
    vim.api.nvim_win_close(0, false)
  end
end

local function basic()
  local window_opts = config.modules.ui.opts.window or {}
  window.setup(window_opts)
  local quit_window = map_f(function()
    window.append_window(vim.api.nvim_get_current_buf(), vim.api.nvim_get_current_win())
    quit()
  end, opts):display("Quit Window")

  local maps = {
    ["n|<leader>x"] = display("Edit"),
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
    ["n|<A-j>"] = map([[<c-w>j]], opts):display("Focus to Bottom"),
    ["n|<A-k>"] = map([[<c-w>k]], opts):display("Focus to Top"),
    ["n|<A-h>"] = map([[<c-w>h]], opts):display("Focus to Left"),
    ["n|<A-l>"] = map([[<c-w>l]], opts):display("Focus to Right"),
    ["t|<A-j>"] = map([[<c-\><c-n><c-w>j]], opts):display("Focus to Bottom"),
    ["t|<A-k>"] = map([[<c-\><c-n><c-w>k]], opts):display("Focus to Top"),
    ["t|<A-h>"] = map([[<c-\><c-n><c-w>h]], opts):display("Focus to Left"),
    ["t|<A-l>"] = map([[<c-\><c-n><c-w>l]], opts):display("Focus to Right"),
    ["t|<A-q>"] = quit_window,
    ["n|<A-q>"] = quit_window,
    -- stylua: ignore start
    ["n|<leader>f"] = display "Float Window",
    ["n|<leader>f<space>"] = map_f(function() window.float(0) end, opts):display("Float"),
    ["n|<leader>f" .. (window_opts.center or "<space>")] = map_f(function() window.float(0) end):display("Center"),
    ["n|<leader>f" .. (window_opts.full or "g")] = map_f(function() window.float_full(0) end):display("Full"),
    ["n|<leader>f" .. (window_opts.nw or "y")] = map_f(function() window.float_nw(0) end):display("NW"),
    ["n|<leader>f" .. (window_opts.ne or "u")] = map_f(function() window.float_ne(0) end):display("NE"),
    ["n|<leader>f" .. (window_opts.sw or "n")] = map_f(function() window.float_sw(0) end):display("SW"),
    ["n|<leader>f" .. (window_opts.se or "m")] = map_f(function() window.float_se(0) end):display("SE"),
    ["n|<leader>f" .. (window_opts.top or "k")] = map_f(function() window.float_top(0) end):display("Top"),
    ["n|<leader>f" .. (window_opts.left or "h")] = map_f(function() window.float_left(0) end):display("Left"),
    ["n|<leader>f" .. (window_opts.bottom or "j")] = map_f(function() window.float_bottom(0) end):display("Bottom"),
    ["n|<leader>f" .. (window_opts.right or "l")] = map_f(function() window.float_right(0) end):display("Right"),
    ["n|<leader>f" .. (window_opts.scale_up or "o")] = map_f(function() window.float_scale(0, 1.1, 1.1) end):display("Scale +"),
    ["n|<leader>f" .. (window_opts.scale_down or "i")] = map_f(function() window.float_scale(0, 0.9, 0.9) end):display("Scale -"),
    ["n|<leader>f" .. (window_opts.move_left or "[")] = map_f(function() window.float_move(0, 0, -5) end):display("window.veLeft"),
    ["n|<leader>f" .. (window_opts.move_right or "]")] = map_f(function() window.float_move(0, 0, 5) end):display("window.veRight"),
    ["n|<leader>f" .. (window_opts.move_up or ";")] = map_f(function() window.float_move(0, -5, 0) end):display("window.veUp"),
    ["n|<leader>f" .. (window_opts.move_down or "'")] = map_f(function() window.float_move(0, 5, 0) end):display("window.veDown"),
    ["n|<leader>f" .. (window_opts.reduce_width or "9")] = map_f(function() window.float_plus(0, 0, -5) end):display("Width -"),
    ["n|<leader>f" .. (window_opts.increase_width or "0")] = map_f(function() window.float_plus(0, 0, 5) end):display("Width +"),
    ["n|<leader>f" .. (window_opts.increase_height or ".")] = map_f(function() window.float_plus(0, 5, 0) end):display("Height +"),
    ["n|<leader>f" .. (window_opts.reduce_height or ",")] = map_f(function() window.float_plus(0, -5, 0) end):display("Height -"),
    ["n|<leader>f" .. (window_opts.select or "s")] = map_f(window.select):display("Select"),
    ["n|<leader>f" .. (window_opts.remove or "x")] = map_f(window.remove):display("Remove"),
    ["n|" ..(window_opts.toggle_latest or "<A-t>")] = map_f(window.toggle):display("Toggle"),
    ["t|" ..(window_opts.toggle_latest or "<A-t>")] = map_f(window.toggle):display("Toggle"),
    ["n|" ..(window_opts.toggle_latest or "<A-CR>")] = map_f(window.toggle):display("Toggle"),
    ["t|" ..(window_opts.toggle_latest or "<A-CR>")] = map_f(window.toggle):display("Toggle"),
    -- stylua: ignore end

    ["n|<leader>e"] = display("Extensions"),
  }
  return maps
end

km.load(basic())

return {
  basic = basic,
}
