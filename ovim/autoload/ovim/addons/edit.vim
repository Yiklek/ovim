" File: edit.vim
" Author: Yiklek
" Description: addon for edit
" Last Modified: 二月 09, 2021
" Copyright (c) 2021 Yiklek

function! ovim#addons#edit#load(addon)
    noremap <leader>xa :call ovim#addons#edit#remove_white_space()<CR>
    let l:leader_key_map = {'x':{'a':[':call ovim#addons#edit#remove_white_space()','RemoveWhiteSpace']}}
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
