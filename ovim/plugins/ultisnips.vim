
" UltiSnips {{{
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
" if exists('g:coc_global_extensions') && index(g:coc_global_extensions,'coc-snippets') >= 0
"     let g:UltiSnipsExpandTrigger=""
"     " let g:UltiSnipsJumpForwardTrigger=""
"     " let g:UltiSnipsJumpBackwardTrigger=""
"     finish
" endif
let g:UltiSnipsExpandTrigger="<leader><space><space>"
" let g:UltiSnipsJumpForwardTrigger="<leader>xj"
" let g:UltiSnipsJumpBackwardTrigger="<leader>xk"
call ovim#utils#recursive_update(g:leader_key_map,{' ':{'name':'which_key_ignore'}})
" }}}
