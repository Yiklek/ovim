" File: common.vim
" Author: Yiklek
" Description: common addon
" Last Modified: 二月 09, 2021
" Copyright (c) 2021 Yiklek

function! ovim#addons#common#load(addon)
    if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif | normal! zvzz
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif | normal! zvzz
    " if !has('nvim')
    "     set previewpopup=height:20,width:80,border:off
    " endif
endfunction

