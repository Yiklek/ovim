" deoplete {{{
let g:deoplete#enable_at_startup = 0

autocmd InsertEnter * call s:setup_deoplete()

function s:setup_deoplete()

    call deoplete#enable()
    call deoplete#custom#source('LanguageClient',
        \ 'min_pattern_length',
        \ 1)
            
    " " 字符串中不补全
    " call deoplete#custom#source('_',
    "             \ 'disabled_syntaxes', ['String']
    "             \ )

    call deoplete#custom#option('sources', {
                \ 'cpp': ['LanguageClient'],
                \ 'c': ['LanguageClient'],
                \ 'vim': ['vim','file'],
                \ 'zsh': ['zsh']
                \})

    " call deoplete#custom#option('refresh_always',v:false)
endfunction

" 忽略一些没意思的completion source。
"let g:deoplete#ignore_sources = {}
"let g:deoplete#ignore_sources._ = ['buffer', 'around']
" }}}
