
" ctrlP {{{
let g:ctrlp_map = '<leader>p'
nnoremap <Leader>pu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>pU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
let g:ctrlp_funky_syntax_highlight = 1

let g:ctrlp_extensions = ['funky']
" }}}
