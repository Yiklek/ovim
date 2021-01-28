
" vim-autoformat {{{
"auto-format
"F5自动格式化代码并保存
noremap <leader>xf :Autoformat<CR>:w<CR>
call ovim#utils#recursive_update(g:leader_key_map.x,{'f':[':Autoformat<CR>:w<CR>','格式化']})
" let g:autoformat_verbosemode=1
" }}}
