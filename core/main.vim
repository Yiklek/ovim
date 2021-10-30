" File: main.vim
" Author: Yiklek
" Description: main
" Last Modified: 二月 09, 2021
" Copyright (c) 2021 Yiklek

" keymaps:
" F2 file tree
" F3 tag list
" F4 pastetoggle
" l-<tab> ycm autocomplete toggle
" General {{{
let mapleader = ","      " 定义<leader>键
let maplocalleader = '<TAB>'
set nocompatible         " 设置不兼容原始vi模式
filetype on              " 设置开启文件类型侦测
filetype plugin on       " 设置加载对应文件类型的插件
set noeb                 " 关闭错误的提示
syntax enable            " 开启语法高亮功能
syntax on                " 自动语法高亮

"set t_Co=256             " 开启256色支持 主题Theme中设置
"set cmdheight=2          " 设置命令行的高度
"set showcmd              " select模式下显示选中的行数
"set ruler                " 总是显示光标位置
"set laststatus=2         " 总是显示状态栏
set number               " 开启行号显示
set cursorline           " 高亮显示当前行
"set whichwrap+=<,>,h,l   " 设置光标键跨行
"set ttimeoutlen=0        " 设置<ESC>键响应时间
"set virtualedit=block,onemore   " 允许光标出现在最后一个字符的后面

set ts=4
set shiftwidth=4
set expandtab
set encoding=utf-8
autocmd BufEnter * set formatoptions-=o
"set noexpandtab
"set noautoindent
set autochdir
"set tags=tags;
set tags=./.tags;,.tags
set hlsearch
set scrolloff=3
set shortmess=atI
"set cursorcolumn
set vb t_vb=
au GuiEnter * set t_vb=
set mouse=a
set backspace=indent,eol,start
set splitright
set splitbelow

" 缓存设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup            " 设置不备份
"set noswapfile          " 禁止生成临时文件
set autoread            " 文件在vim之外修改过，自动重新读入
"set autowrite           " 设置自动保存
"set confirm             " 在处理未保存或只读文件的时候，弹出确认

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 编码设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set langmenu=zh_CN.UTF-8
"set helplang=cn
"set termencoding=utf-8
"set encoding=utf8
"set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030"

" }}}

" os config {{{
let g:config_root=fnamemodify(expand('<sfile>'), ':h')
let g:real_ovim_path= fnamemodify(resolve(expand('<sfile>:p')), ':h:h')
if has('win32')    "  windows
    " 设置 alt 键不映射到菜单栏
    set winaltkeys=no
    set backspace=indent,eol,start whichwrap+=<,>,[,]
    autocmd GUIEnter * simalt ~x
elseif has('mac')      " macos
    au GUIEnter * call MaximizeWindow()
else                " linux
    au GUIEnter * call MaximizeWindow()
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
    "set guifont=Consolas:h14:cANSI
    if has('mac')
        let &guifont="DejaVu Sans Mono Nerd Font Complete Mono:h18"
    endif
    if has('win32')
        set guifont=Consolas:h14:cANSI
    endif
    " non-gvim stuff
endif
" }}}
" if has('clipboard')
"  set clipboard+=unnamed
" endif
" 插件无关map
let &rtp=&rtp.','.g:real_ovim_path.'/ovim'

call ovim#init('override')

execute 'source' g:config_root.'/keymap.vim'



"主题 theme {{{
"set termguicolors
function! s:has_colorscheme(name) abort
    let pat = 'colors/'.a:name.'.vim'
    return !empty(globpath(&rtp, pat))
endfunction

syntax enable
" }}}



" clip {{{
function! WSLClip()
    let filename = expand("%").".temp"
    let winclip = $WINCLIP
    exe "silent !" "cat ".$HOME.'/'.filename."|".winclip." && rm ".$HOME.'/'.filename
    redraw!
endfunction
" }}}

" max window {{{
function! MaximizeWindow()
    silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
    if exists("+lines")
        set lines=9999
    endif
    if exists("+columns")
        set columns=9999
    endif
endfunction
" }}}



" {{{ DisplayHelp
function! DisplayHelp()
    let help_file = g:real_ovim_path."/config-help.txt"
    let bnr = bufwinnr(help_file)
    if bnr > 0
        let g:opening = 1
    else
        let g:opening = 0
    endif
    if g:opening
        exec "bdelete ".help_file
        let g:opening = 0
    else
        exec "rightbelow 50vsplit ".help_file
        setlocal nomodifiable
        let g:opening = 1
    endif
endfunction
nmap <F9> :call DisplayHelp()<cr>
try
let g:space_key_map['<F9>'] = [':call DisplayHelp()','Show Help(todo)']
catch
endtry
" }}}
