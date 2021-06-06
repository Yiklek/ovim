
" asyncrun {{{
nnoremap <leader>r<space> <esc>:AsyncRun<space>
let g:asyncrun_open=10
let s:leader_key_map = {'r':{"name":"+Run"," ":["","Run"]}}
call ovim#utils#recursive_update(g:leader_key_map,s:leader_key_map)
" }}}
