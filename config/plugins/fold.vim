
"fold {{{
" vim 文件折叠方式为 marker {{{
augroup ft_vim
    au!
    "au BufRead,BufNewFile * if &ft == 'vim' | normal zM | endif
    au FileType vim setlocal foldmethod=marker
    au FileType vim let anyfold_activate=0
    au FileType vim exe "silent!:%foldc"
augroup END
" }}}

let anyfold_activate=1
set foldlevel=1
set foldlevelstart=99
"nnoremap <space> za
" }}}
