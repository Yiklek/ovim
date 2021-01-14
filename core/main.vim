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
"set mouse=a


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
let g:_config_python_home=''
let g:dotvimd=expand('~/.vim.d')
let g:config_root=fnamemodify(expand('<sfile>'), ':h')
if has('win32')    "  windows
    set clipboard+=unnamed
    " 设置 alt 键不映射到菜单栏
    set winaltkeys=no
    set backspace=indent,eol,start whichwrap+=<,>,[,]
    autocmd GUIEnter * simalt ~x

    let g:_config_python_home=''
    let g:python_interpreter = g:_config_python_home.'python'
    let g:binary_suffix = 'exe'
elseif has('mac')      " macos

    let g:_config_python_home=expand('~/.pyenv/versions/3.7.4')
    let g:python_interpreter = g:_config_python_home. '/bin/python3.7'
    au GUIEnter * call MaximizeWindow()
    let g:binary_suffix = 'out'
else                " linux
    let g:_config_python_home=''
    let g:python_interpreter = g:_config_python_home.'python3'
    au GUIEnter * call MaximizeWindow()
    let g:binary_suffix = 'out'
endif
" }}}

let g:dotvim = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')
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
        set guifont=Monaco:h14
    endif
    if has('win32')
        set guifont=Consolas:h14:cANSI
    endif
    " non-gvim stuff
endif
" }}}
" 插件无关map
let &rtp=&rtp.','.g:dotvim.'/ovim,'.g:dotvimd

call ovim#init()
execute 'source' g:config_root.'/keymap.vim'



"主题 theme {{{
"set termguicolors
function! s:has_colorscheme(name) abort
    let pat = 'colors/'.a:name.'.vim'
    return !empty(globpath(&rtp, pat))
endfunction

syntax enable
set background=dark
let g:solarized_italic=0
"let g:solarized_termtrans = 1
" set t_Co=256
 if (has("termguicolors"))
  set termguicolors
 endif
let g:oceanic_material_allow_underline = 1
silent! colorscheme solarized
silent! colorscheme gruvbox
" silent! colorscheme oceanic_material
" silent! colorscheme OceanicNext
" hi CursorLine cterm=NONE
" if s:has_colorscheme('gruvbox')
"     colorscheme gruvbox
" elseif s:has_colorscheme('solarized')
"     colorscheme solarized
" endif
let g:solarized_termcolors=256
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
    exe "silent !" "cat ".$HOME.'/'.filename."|".winclip." && rm ".$HOME.'/'.filename
    redraw!
endfunction
vnoremap <leader>c :w! $HOME/%.temp<cr>:call WSLClip()<cr>
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

nmap <leader>wz :call Zoom()<CR>
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
    let help_file = g:dotvim."/config-help.txt"
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
let g:space_key_map['<F9>'] = ['<F6>','Show Help(todo)']
catch 
endtry
" }}}

" 剩余的窗口都不是文件编辑窗口时，自动退出vim
autocmd BufEnter * if 0 == len(filter(range(1, winnr('$')), 'empty(getbufvar(winbufnr(v:val), "&bt"))')) | qa! | endif


" 定位到退出位置并移动到屏幕中央
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif | normal! zvzz
endif
