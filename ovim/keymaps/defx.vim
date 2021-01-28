
" defx{{{
nmap <silent> = :Defx<CR>
call ovim#utils#recursive_update(g:space_key_map,{'=':[':Defx','defx']})
" }}}
