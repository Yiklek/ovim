vim.cmd [[
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
syntax enable
]]
