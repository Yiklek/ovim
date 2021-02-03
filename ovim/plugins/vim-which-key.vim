nnoremap <silent> <leader> :WhichKey mapleader<CR>
nnoremap <silent> <localleader> :WhichKey maplocalleader<CR>
nnoremap <silent> <Space> :WhichKey '<Space>'<CR>
let g:which_key_use_floating_win = 1
let g:which_key_fallback_to_native_key = 1
call which_key#register('<Space>', 'g:space_key_map')
call which_key#register(g:mapleader, 'g:leader_key_map')
set timeoutlen=500