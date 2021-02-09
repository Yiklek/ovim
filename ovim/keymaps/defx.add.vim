" File: defx.add.vim
" Author: Yiklek
" Description: defx hook add
" Last Modified: 02 10, 2021
" Copyright (c) 2021 Yiklek

" defx{{{
nmap <silent> == :Defx<CR>
call ovim#utils#recursive_update(g:space_key_map,{'==':[':Defx','defx']})
" }}}
