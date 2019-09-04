
" global keymap {{{
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>
inoremap <c-h> <left>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>
noremap <c-h> <left>
noremap <c-j> <down>
noremap <c-k> <up>
noremap <c-l> <right>
nnoremap <esc><esc> :silent! nohlsearch<cr>
nnoremap <leader>e :edit $MYVIMRC<cr>
nnoremap <leader>s :source $MYVIMRC<cr>
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
" l-q 保存并退出
nmap <leader>q :q<CR>
nmap <leader>w :w<CR>
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
nmap <leader>wwj 5<c-w>+
nmap <leader>wwk 5<c-w>-
nmap <leader>wwh 5<c-w><
nmap <leader>wwl 5<c-w>>
" 标签
" 关闭当前标签
nmap <leader>tq :tabc<CR>
" 关闭所有标签
nmap <leader>tQ :tabo<CR>
" 列出所有标签
nmap <leader>tls :tabs<CR>
" 在新标签中打开
nmap <leader>to :tabe<space>
" 新标签打开当前文件
nmap <leader>tsp :tab split<CR>
" 切换标签
nmap <leader>th gT
nmap <leader>tj gt
nmap <leader>tk gT
nmap <leader>tl gt

nmap <leader>bq :bd<cr>
" }}}
