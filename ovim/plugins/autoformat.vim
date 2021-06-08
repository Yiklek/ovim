
" vim-autoformat {{{
"auto-format
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

noremap <leader>xf :Autoformat<CR>
call ovim#utils#recursive_update(g:leader_key_map.x,{'f':[':Autoformat','格式化']})
" let g:autoformat_verbosemode=1
" }}}
