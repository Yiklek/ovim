
"auto-pairs {{{
"let g:AutoPairsMapCR=0
"let g:AutoPairs = {'[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
"inoremap <buffer><silent> ) <C-R>=AutoPairsInsert(')')<CR>
autocmd FileType lisp let b:AutoPairs = {'```': '```', '{': '}', '(': ')', "'''": "'''", '[': ']', '"""': '"""'}
"}}}
