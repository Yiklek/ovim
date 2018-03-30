" keymaps:
" F2 file tree
" F3 tag list
" F4 ycm auto complete
" F5 pastetoggle
set nocompatible
set number
set ts=4
set shiftwidth=4
set expandtab
"set noexpandtab
set noautoindent
syntax on   
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>
inoremap <c-h> <left>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>
let mapleader=","
set autochdir
set tags=tags;
"set mouse=a
""""""""""""""""""""""""""""""
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Lokaltog/vim-powerline'
Plugin 'Yggdroot/indentLine'
Plugin 'scrooloose/nerdtree'
Plugin 'taglist.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'rdnetto/YCM-Generator'
call vundle#end()
filetype plugin indent on
"""""""""""""""""""""""""""""
set encoding=utf-8
"主题 theme
syntax enable
set background=dark
colorscheme solarized
let g:solarized_termcolors=256

"缩进线
"let g:indentLine_char='┆'
let g:indentLine_enabled = 1

"powerline
set laststatus=2
"let g:Powerline_symbols = 'fancy'

"ycm
"keymaps:
"直接触发自动补全
let g:ycm_key_invoke_completion = '<F4>'
" 跳转定义
" nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
"补全后自动关机预览窗口"
let g:ycm_autoclose_preview_window_after_completion=1
"离开插入模式后自动关闭预览窗口"
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"python解释器路径"
let g:ycm_path_to_python_interpreter='/usr/bin/python3'
"let g:ycm_global_ycm_extra_conf = "~/.ycm_extra_conf.py"
""是否开启语义补全"
let g:ycm_seed_identifiers_with_syntax=1
"是否在注释中也开启补全"
"let g:ycm_complete_in_comments=1
"let g:ycm_collect_identifiers_from_comments_and_strings = 0
""开始补全的字符数"
let g:ycm_min_num_of_chars_for_completion=1
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

" NERDTree
"F2开启和关闭树"
map <F2> :NERDTreeToggle<CR>
let NERDTreeChDirMode=1
""显示书签"
let NERDTreeShowBookmarks=1
"设置忽略文件类型"
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
""窗口大小"
let NERDTreeWinSize=35

" taglist
map <F3> :Tlist<CR>
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window = 1  

"auto-pairs
"let g:AutoPairsMapCR=0
"other keymap
"粘贴模式
set pastetoggle=<F5>

