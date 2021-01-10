let g:dotvimd=expand('~/.vim.d')
set rtp+=g:dotvimd
execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/main.vim'
