
"fold {{{
" vim 文件折叠方式为 marker {{{
augroup ft_vim
    au!
    "au BufRead,BufNewFile * if &ft == 'vim' | normal zM | endif
    au FileType vim setlocal foldmethod=marker
    autocmd Filetype vim AnyFoldActivate
    au FileType vim exe "silent!:%foldc"
augroup END
" }}}

set foldlevel=1
set foldlevelstart=99
"nnoremap <space> za
" }}}
