" File: edit.vim
" Author: Yiklek
" Description: addon for edit
" Last Modified: 二月 09, 2021
" Copyright (c) 2021 Yiklek

function! ovim#addons#edit#load(addon)
    noremap <silent> <leader>xa :call ovim#addons#edit#remove_white_space()<CR>
    noremap <leader>xw :w<CR>
    noremap <leader>xW :w !sudo tee %<CR>
    let l:leader_key_map = {'x': {'a':[':call ovim#addons#edit#remove_white_space()','去除尾部空白'],
                                \ 'w':[':w','保存'],
                                \ }}
    if !ovim#utils#has_win()
        noremap <leader>xW :w !sudo tee %<CR>
        let l:leader_key_map["x"]["W"] = [':w !sudo tee %','保存(sudo)']
    endif
    call ovim#utils#recursive_update(g:leader_key_map,l:leader_key_map)
endfunction

" remove whitespace {{{
" Remove trailing whitespace when writing a buffer, but not for diff files.
" From: Vigil
" @see http://blog.bs2.to/post/EdwardLee/17961
function! ovim#addons#edit#remove_white_space()
    let ignore_filetypes = ['diff', 'markdown']
    if index(ignore_filetypes,&ft) < 0
        let b:curcol = col(".")
        let b:curline = line(".")
        silent! %s/\s\+$//
        silent! %s/\(\s*\n\)\+\%$//
        call cursor(b:curline, b:curcol)
    endif
endfunction
" }}}
