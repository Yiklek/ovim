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

function! s:cd_root_directory()
    let cur_file = expand('%:p:h')
    let root_path = s:find_root_path(cur_file)
    if root_path != ''
        execute('cd '.root_path)
    endif
endfunction

function! s:find_root_path(path)
    if a:path == '/'
        return ''
    endif
    let root_markers = get(g:,"root_markers",[])
    for mark in root_markers
        let temp_path = expand(a:path.'/'.mark)
        if filereadable(temp_path) || isdirectory(temp_path)
            return a:path
        endif
    endfor
    return s:find_root_path(fnamemodify(a:path,":h"))
endfunction

command -nargs=0 OvimCdProjectRoot call <SID>cd_root_directory()
