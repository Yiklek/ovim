" keymaps:
" F2 file tree
" F3 tag list
" F4 pastetoggle
" l-<tab> ycm autocomplete toggle
" General {{{
set nocompatible
set number
set ts=4
set shiftwidth=4
set expandtab
set encoding=utf-8
"set noexpandtab
"set noautoindent
filetype plugin indent on
syntax on
let mapleader=","
set autochdir
set tags=tags;
set hlsearch
set scrolloff=3
set shortmess=atI
"set mouse=a
" }}}

" vim 文件折叠方式为 marker {{{
augroup ft_vim
    au!
    au FileType vim setlocal foldmethod=marker
augroup END
" }}}

" windows {{{
if has('win32')
    set clipboard+=unnamed
    " 设置 alt 键不映射到菜单栏
    set winaltkeys=no
    set backspace=indent,eol,start whichwrap+=<,>,[,]
    let g:plug_dir = '~/vimfiles'
    let g:python_interpreter = 'python'
else
    let g:plug_dir = '~/.vim'
    let g:python_interpreter = '/usr/bin/python3'
endif
" }}}

" gui {{{
if has('gui_running')
               " gvim-only stuff
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    set cursorline
    " 窗口大小
    set lines=35 columns=140
    " 分割出来的窗口位于当前窗口下边/右边
    set splitbelow
    set splitright
    "不显示工具/菜单栏
    set guioptions-=T
    "set guioptions-=m
    set guioptions-=L
    set guioptions-=r
    set guioptions-=b
    " 使用内置 tab 样式而不是 gui
    set guioptions-=e
    set nolist
    " set listchars=tab:▶\ ,eol:¬,trail:·,extends:>,precedes:<
    set guifont=Consolas:h14:cANSI
               " non-gvim stuff
endif
" }}}

" Vundel {{{
"filetype off
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
"Plugin 'VundleVim/Vundle.vim'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'Lokaltog/vim-powerline'
"Plugin 'Yggdroot/indentLine'
"Plugin 'scrooloose/nerdtree'
"Plugin 'taglist.vim'
"Plugin 'jiangmiao/auto-pairs'
"Plugin 'Yelgors/YCM-Generator'
"Plugin 'SirVer/ultisnips'
"Plugin 'honza/vim-snippets'
"Plugin 'chiel92/vim-autoformat'
"Plugin 'skywind3000/asyncrun.vim'
"Plugin 'kien/ctrlp.vim'
"Plugin 'tacahiroy/ctrlp-funky'
""Plugin 'shougo/vimshell.vim'
""Plugin 'Shougo/vimproc.vim'
"call vundle#end()
"filetype plugin indent on
""""""""""""""""""""""""""""""
" }}}

" vim-plug {{{
call plug#begin(g:plug_dir.'/plugged')
" best completer
Plug 'Valloric/YouCompleteMe'

" generate .ycm_extra_conf.py
Plug 'Yelgors/YCM-Generator',{'branch':'stable'}

" use this to complete if YCM can't work
"Plug 'maralla/completor.vim'

" status bar
"Plug 'Lokaltog/vim-powerline',{'branch':'develop'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" indent
Plug 'Yggdroot/indentLine'

" source manager
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" auto comment
Plug 'scrooloose/nerdcommenter'

" tag
Plug 'vim-scripts/taglist.vim', { 'on':  'Tlist' }
Plug 'jiangmiao/auto-pairs'
" templete
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'chiel92/vim-autoformat'

Plug 'skywind3000/asyncrun.vim'

" search file
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
"Plug 'wincent/command-t'

Plug 'altercation/vim-colors-solarized'

" fold
Plug 'pseewald/vim-anyfold',{'for': ['c','cpp','python','java','fortran','javascript']}

Plug 'roxma/vim-paste-easy'
"Plug 'conradirwin/vim-bracketed-paste'

Plug 'tpope/vim-surround'
" auto nohl after search
"Plug 'romainl/vim-cool'

" easy regular search
"Plug 'haya14busa/incsearch.vim'

" shell in vim
"Plugin 'shougo/vimshell.vim'
"Plugin 'Shougo/vimproc.vim'
call plug#end()
""""""""""""""""""""""""""""""
" }}}

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
nnoremap <esc><esc> :silent! nohls<cr>
"粘贴模式
set pastetoggle=<F4>
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
nmap <leader>h <c-w>h
nmap <leader>j <c-w>j
nmap <leader>k <c-w>k
nmap <leader>l <c-w>l
" 位置移动
nmap <leader>J <c-w>J
nmap <leader>K <c-w>K
nmap <leader>H <c-w>H
nmap <leader>L <c-w>L
" 大小调整
nmap <leader>jj 5<c-w>+
nmap <leader>kk 5<c-w>-
nmap <leader>hh 5<c-w><
nmap <leader>ll 5<c-w>>
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
" }}}

"主题 theme {{{
syntax enable
set background=dark
let g:solarized_italic=0
colorscheme solarized
let g:solarized_termcolors=256
call togglebg#map("<F5>")
" }}}

"缩进线 indentLine {{{
"let g:indentLine_char='┆'
let g:indentLine_enabled = 0
" }}}

" statusline & tabline powerline airline {{{
set laststatus=2
"let g:Powerline_symbols = 'fancy'
"let g:Powerline_colorscheme = 'solarized256'

let g:airline_theme='papercolor'
let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1
"let g:airline#extensions#tabline#formatter = 'default'
"let g:airline#extensions#tabline#buffer_nr_show = 1
"let g:airline#extensions#tabline#tab_nr_show = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#keymap_ignored_filetypes = ['nerdtree']
let g:airline#extensions#whitespace#enabled = 0
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>[ <Plug>AirlineSelectPrevTab
nmap <leader>] <Plug>AirlineSelectNextTab
nmap <leader>; :bp<cr>
nmap <leader>' :bn<cr>
" }}}

"ycm {{{
"keymaps:
"直接触发自动补全
let g:ycm_key_invoke_completion = '<leader><tab>'
" 跳转定义
" nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
"补全后自动关机预览窗口"
let g:ycm_autoclose_preview_window_after_completion=1
"离开插入模式后自动关闭预览窗口"
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"python解释器路径"
let g:ycm_path_to_python_interpreter=g:python_interpreter
"let g:ycm_global_ycm_extra_conf = "~/.ycm_extra_conf.py"
""是否开启语义补全"
let g:ycm_seed_identifiers_with_syntax=1
"是否在注释中也开启补全"
"let g:ycm_complete_in_comments=1
"let g:ycm_collect_identifiers_from_comments_and_strings = 0
""开始补全的字符数"
" let g:ycm_auto_trigger=0
let g:ycm_min_num_of_chars_for_completion=2
let g:ycm_cache_omnifunc=0
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>" |
" 跳转到定义处, 分屏打开
" let g:ycm_goto_buffer_command = 'horizontal-split'
let g:ycm_confirm_extra_conf = 0
" 引入，可以补全系统，以及python的第三方包 针对新老版本YCM做了兼容
" " old version
if !empty(glob("~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py"))
    let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py"
endif
" new version
if !empty(glob("~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"))
    let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
endif
"autocmd FileType cpp let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
"autocmd FileType c let g:ycm_global_ycm_extra_conf = "~/.ycm_extra_conf_c.py"
" }}}

"completor {{{
"注释掉completor.vim/pythonx/completers/cpp/__init__.py中on_complete方法的date['word']
let g:completor_clang_binary = '/usr/bin/clang'
inoremap <expr> <Tab> pumvisible() ? "\<down>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<up>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
"}}}

" NERDTree {{{
"F2开启和关闭树"
map <F2> :NERDTreeToggle<CR>
let NERDTreeChDirMode=1
""显示书签"
let NERDTreeShowBookmarks=1
"设置忽略文件类型"
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
""窗口大小"
let NERDTreeWinSize=35
" }}}

" taglist {{{
map <F3> :Tlist<CR>
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window = 1
" }}}

"auto-pairs {{{
"let g:AutoPairsMapCR=0
"}}}

" UltiSnips {{{
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<leader>g"
let g:UltiSnipsJumpForwardTrigger="<leader>b"
let g:UltiSnipsJumpBackwardTrigger="<leader>z"
" }}}

" vim-autoformat {{{
"auto-format
"F5自动格式化代码并保存
noremap <leader>f :Autoformat<CR>:w<CR>
" let g:autoformat_verbosemode=1
" }}}

" asyncrun {{{
map <leader>r <esc>:AsyncRun<space>
let g:asyncrun_open=10
" }}}

" ctrlP {{{
let g:ctrlp_map = '<leader>p'
nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
let g:ctrlp_funky_syntax_highlight = 1

let g:ctrlp_extensions = ['funky']
" }}}

"fold {{{
let anyfold_activate=1
set foldlevel=1
set foldlevelstart=99
au FileType vim normal zM
"nnoremap <space> za
" }}}

" make {{{
auto FileType  cpp set makeprg=g++\ -Wall\ -O\ -g\ -o\ %<.out\ %
auto FileType  c set makeprg=gcc\ -Wall\ -O\ -g\ -o\ %<.out\ %
" }}}

" clip {{{
function! WSLClip()
    let filename = expand("%").".temp"
    let winclip = $WINCLIP
    exe "silent !" "cat ".filename."|".winclip." && rm ".filename
    redraw!
endfunction
vnoremap <leader>c :w! %.temp<cr>:call WSLClip()<cr>
" }}}

" zoom {{{
function! Zoom ()
    " check if is the zoomed state (tabnumber > 1 && window == 1)
    if tabpagenr('$') > 1 && tabpagewinnr(tabpagenr(), '$') == 1
        let l:cur_winview = winsaveview()
        let l:cur_bufname = bufname('')
        tabclose

        " restore the view
        if l:cur_bufname == bufname('')
            call winrestview(cur_winview)
        endif
    else
        tab split
    endif
endfunction

nmap <leader>z :call Zoom()<CR>
" }}}

" remove whitespace {{{
" Remove trailing whitespace when writing a buffer, but not for diff files.
" From: Vigil
" @see http://blog.bs2.to/post/EdwardLee/17961
function! RemoveTrailingWhitespace()
    if &ft != "diff"
        let b:curcol = col(".")
        let b:curline = line(".")
        silent! %s/\s\+$//
        silent! %s/\(\s*\n\)\+\%$//
        call cursor(b:curline, b:curcol)
    endif
endfunction
autocmd BufWritePre * call RemoveTrailingWhitespace()
" }}}
