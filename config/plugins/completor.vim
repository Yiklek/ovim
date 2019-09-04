
"completor {{{
"注释掉completor.vim/pythonx/completers/cpp/__init__.py中on_complete方法的date['word']
let g:completor_clang_binary = '/usr/bin/clang'
inoremap <expr> <Tab> pumvisible() ? "\<down>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<up>" : "\<S-Tab>"
"}}}
