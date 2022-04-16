" File: keymap.vim
" Author: Yiklek
" Description: keymap
" Last Modified: 二月 09, 2021
" Copyright (c) 2021 Yiklek

" basic keymap {{{
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

tnoremap <esc><esc><esc>  <C-\><C-N>
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
" 行首尾切换
nnoremap <expr> .  col('.') == '1' ? '$':'0'
vnoremap <expr> .  col('.') == '1' ? '$':'0'

" for vim-which-key
if exists('g:space_key_map')
    let g:space_key_map['<F5>'] = [':redraw!','刷新']
endif
let s:leader_key_map = {'<CR>':{'name':'换行'},
                        \ '\':[':vsplit ', '竖线分割'] ,
                        \ '-':[':split ',  '横线分割'] ,
                        \ 'q':[':q',       '退出']     ,
                        \ 'w':{'name':'+窗口操作',
                        \       'h':[':wincmd h',           '焦点左移'],
                        \       'l':[':wincmd l',           '焦点右移'],
                        \       'j':[':wincmd j',           '焦点下移'],
                        \       'k':[':wincmd k',           '焦点上移'],
                        \       'H':[':wincmd H',           '左移窗口'],
                        \       'L':[':wincmd L',           '右移窗口'],
                        \       'J':[':wincmd J',           '下移窗口'],
                        \       'K':[':wincmd K',           '上移窗口'],
                        \       '=':[':resize +5',          '高度增加'],
                        \       '-':[':resize -5',          '高度减小'],
                        \       ',':[':vertical resize -5', '宽度减小'],
                        \       '.':[':vertical resize +5', '宽度增加'],
                        \       'w':[':resize +5',          '高度增加'],
                        \       's':[':resize -5',          '高度减小'],
                        \       'a':[':vertical resize -5', '宽度减小'],
                        \       'd':[':vertical resize +5', '宽度增加'],
                        \   },
                        \ 't':{'name':'+标签页',
                        \       'q':[':tabc',       '关闭当前标签'],
                        \       'Q':[':tabo',       '关闭所有标签'],
                        \       'ls':[':tabs',      '列出所有标签'],
                        \       'o':[':tabe ',      '新标签打开'],
                        \       'sp':[':tab split', '新标签打开当前文件'],
                        \       'h':[':-tabn',      '上一个标签'],
                        \       'k':[':-tabn',      '上一个标签'],
                        \       'j':[':+tabn',      '下一个标签'],
                        \       'l':[':+tabn',      '下一个标签'],
                        \   },
                        \ 'b':{'name':'+buffer',
                        \       'd':[':bd',         '关闭buffer'],
                        \       'p':[':bp',         '上一个buffer'],
                        \       'n':[':bn',         '下一个buffer']
                        \   },
                        \ 'v':{'name':'+vim相关',   'e':{'name':'编辑配置',' ':[':tabe $MYVIMRC','MYVIMRC']},'s':[':source $MYVIMRC','重新加载配置文件']},
                    \}
if exists('g:leader_key_map')
    call extend(g:leader_key_map,s:leader_key_map)
endif
" }}}
