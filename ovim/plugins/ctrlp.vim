
" ctrlP {{{
let g:ctrlp_map = ''
" narrow the list down with a word under cursor
nnoremap <Leader>pU :execute 'CtrlPFunky ' . expand('<cword>')
let g:ctrlp_funky_syntax_highlight = 1

let g:ctrlp_extensions = ['funky']
" }}}
