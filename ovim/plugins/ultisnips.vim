
" UltiSnips {{{
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<leader>xg"
let g:UltiSnipsJumpForwardTrigger="<leader>xj"
let g:UltiSnipsJumpBackwardTrigger="<leader>xk"
call ovim#utils#recursive_update(g:leader_key_map.x,{'g':'插入模板'})
" }}}
