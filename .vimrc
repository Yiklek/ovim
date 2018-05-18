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
"set tags=tags;
set tags=./.tags;,.tags
set hlsearch
set scrolloff=3
set shortmess=atI
"set cursorcolumn
set cursorline
set vb t_vb=
au GuiEnter * set t_vb=
"set mouse=a
" }}}

" windows {{{
if has('win32')
    set clipboard+=unnamed
    " 设置 alt 键不映射到菜单栏
    set winaltkeys=no
    set backspace=indent,eol,start whichwrap+=<,>,[,]
    autocmd GUIEnter * simalt ~x
    let g:dotvim = '~/vimfiles'
    let g:python_interpreter = 'python'
    let g:binary_suffix = 'exe'
else
    let g:dotvim = '~/.vim'
    let g:python_interpreter = '/usr/bin/python3'
    au GUIEnter * call MaximizeWindow()
    let g:binary_suffix = 'out'
endif
" }}}

" gui {{{
if has('gui_running')
    " gvim-only stuff
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
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
    set gcr=a:block-blinkon0
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
call plug#begin(g:dotvim.'/plugged')
" best completer
Plug 'Valloric/YouCompleteMe'

" generate .ycm_extra_conf.py
Plug 'https://gitee.com/yelgors/YCM-Generator.git',{'branch':'stable'}

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
"Plug 'vim-scripts/taglist.vim', { 'on':  'Tlist' }
Plug 'majutsushi/tagbar', { 'on':  'TagbarToggle' }
Plug 'jiangmiao/auto-pairs'
" templete
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'chiel92/vim-autoformat',{'on':'Autoformat'}

Plug 'skywind3000/asyncrun.vim'

" search file
"Plug 'Yggdroot/LeaderF'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
"Plug 'wincent/command-t'

Plug 'arakashic/nvim-colors-solarized'
"Plug 'altercation/vim-colors-solarized'
"Plug 'iCyMind/NeoSolarized'
"Plug 'miconda/lucariox.vim'
" fold
Plug 'pseewald/vim-anyfold',{'for': ['c','cpp','python','java','fortran','javascript']}

Plug 'roxma/vim-paste-easy'
"Plug 'conradirwin/vim-bracketed-paste'

Plug 'tpope/vim-surround'

Plug 'ludovicchabant/vim-gutentags'

Plug 'mhinz/vim-signify'

Plug 'https://gitee.com/yelgors/vim-togglemouse.git',{'branch':'dev'}
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
nmap <F6> :redraw!<cr>
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

nmap <leader>bq :bd<cr>
" }}}

"主题 theme {{{
"set termguicolors
syntax enable
set background=dark
let g:solarized_italic=0
"let g:solarized_termtrans = 1
set t_Co=256
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
let g:ycm_confirm_extra_conf = 1
" 引入，可以补全系统，以及python的第三方包 针对新老版本YCM做了兼容
" old version
if !empty(glob(g:dotvim."/plugged/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py"))
    let g:ycm_global_ycm_extra_conf = g:dotvim."/plugged/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py"
endif
" new version
if !empty(glob(g:dotvim."/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"))
    let g:ycm_global_ycm_extra_conf = g:dotvim."/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
endif
if filereadable('~/.ycm_extra_conf.py')
    let g:ycm_global_ycm_extra_conf = "~/.ycm_extra_conf.py"
endif
"autocmd FileType cpp let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
"autocmd FileType c let g:ycm_global_ycm_extra_conf = "~/.ycm_extra_conf_c.py"
" }}}

"completor {{{
"注释掉completor.vim/pythonx/completers/cpp/__init__.py中on_complete方法的date['word']
let g:completor_clang_binary = '/usr/bin/clang'
inoremap <expr> <Tab> pumvisible() ? "\<down>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<up>" : "\<S-Tab>"
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
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | exe 'NERDTree' | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" }}}

" tagbar {{{
map <F3> :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_width = 30
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
" vim 文件折叠方式为 marker {{{
augroup ft_vim
    au!
    "au BufRead,BufNewFile * if &ft == 'vim' | normal zM | endif
    au FileType vim setlocal foldmethod=marker
    au FileType vim let anyfold_activate=0
    au FileType vim exe "silent!:%foldc"
augroup END
" }}}

let anyfold_activate=1
set foldlevel=1
set foldlevelstart=99
"nnoremap <space> za
" }}}

" LeaderF {{{
"let g:Lf_ShortcutF = '<c-p>'
"let g:Lf_ShortcutB = '<m-n>'
"noremap <c-n> :LeaderfMru<cr>
"noremap <m-p> :LeaderfFunction!<cr>
"noremap <m-n> :LeaderfBuffer<cr>
"noremap <m-m> :LeaderfTag<cr>
"let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

"let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
"let g:Lf_WorkingDirectoryMode = 'Ac'
"let g:Lf_WindowHeight = 0.30
"let g:Lf_CacheDirectory = expand('~/.vim/cache')
"let g:Lf_ShowRelativePath = 0
"let g:Lf_HideHelp = 1
"let g:Lf_StlColorscheme = 'powerline'
" }}}

" make {{{
if has('win32')
    auto FileType  cpp set makeprg=g++\ -Wall\ -O\ -g\ -o\ %<.exe\ %
    auto FileType  c set makeprg=gcc\ -Wall\ -O\ -g\ -o\ %<.exe\ %
else
    auto FileType  cpp set makeprg=g++\ -Wall\ -O\ -g\ -o\ %<.out\ %
    auto FileType  c set makeprg=gcc\ -Wall\ -O\ -g\ -o\ %<.out\ %
endif
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
    let ignore_filetypes = ['diff', 'markdown']
    if index(ignore_filetypes,&ft) < 0
        let b:curcol = col(".")
        let b:curline = line(".")
        silent! %s/\s\+$//
        silent! %s/\(\s*\n\)\+\%$//
        call cursor(b:curline, b:curcol)
    endif
endfunction
autocmd BufWritePre * call RemoveTrailingWhitespace()
" }}}

" max window {{{
function! MaximizeWindow()
    silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
endfunction
" }}}

" gutentags {{{
if !executable('ctags')
    let g:gutentags_enabled = 0
endif
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags, 'p')
endif

" }}}

" signify {{{
" this first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
nmap <F4> :SignifyDiff<cr>
let g:signify_vcs_list = [ 'git', 'hg' ]
" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227
" }}}

" mouse{{{
call toggle_mouse#map("<F7>")
" }}}
