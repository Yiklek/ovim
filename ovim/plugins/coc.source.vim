" File: coc.source.vim
" Author: Yiklek
" Description: coc config
" Last Modified: 02 10, 2021
" Copyright (c) 2021 Yiklek

let g:coc_config_home = g:ovim_root_path.'/config/coc'
let g:coc_data_home = g:ovim_cacha_path.'/coc'

autocmd BufAdd * if getfsize(expand('<afile>')) > 1024*1024 |
                                \ let b:coc_enabled=0 |
                                \ endif


let g:coc_user_config = {
\    "session": {
\     "directory":g:ovim_cacha_path.'/coc-lists-session'
\    },
\}
let g:coc_global_extensions = ["coc-marketplace","coc-json","coc-snippets",
                \ "coc-python","coc-lists","coc-yank","coc-vimlsp","coc-toml",
                \ "coc-explorer","coc-git","coc-highlight","coc-ultisnips",
                \ "coc-html","coc-tag","coc-cmake","coc-go"
                \ ]
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" coc-snippets
imap <leader><space><space> <Plug>(coc-snippets-expand)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
" coc-yank

" <c-u> for clean command line to : instead of :'<,'>
nnoremap <silent> <leader>eey  :<C-u>CocList -A --normal yank<cr>

" scroll popup
if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-j>"
    nnoremap <nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-k>"
    inoremap <nowait><expr> <C-j> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Down>"
    inoremap <nowait><expr> <C-k> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Up>"
endif

" coc-explorer
nnoremap <silent> ==  :<C-u>CocCommand explorer<cr>
nnoremap <silent> <space>==  :<C-u>CocCommand explorer<cr>

" coc-lists

nnoremap <silent> <leader>ee<space>  :<C-u>CocList<cr>

let s:space_key_map = {"==":[":CocCommand explorer","Explorer"]}
call ovim#utils#recursive_update(g:space_key_map,s:space_key_map)
" key map <leader>ee
let s:leader_key_map = {"e":{"e":{"name":"Coc",
                                \ " ":[":CocList","List"],
                                \ "y":[":CocList -A --normal yank","Yank"],
                                \ }}}
call ovim#utils#recursive_update(g:leader_key_map,s:leader_key_map)
