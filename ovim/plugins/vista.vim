let g:vista_default_executive = 'ctags'


if !exists('g:leader_key_map.x.s')
    let g:leader_key_map.x.s = {}
endif

call ovim#utils#recursive_update(g:leader_key_map.x.s,{'name':'+Structure',
                                    \ ' ':[':Vista!!','Vista'],
                                    \ 'a':[':Vista ale','ale'],
                                    \ 't':[':Vista ctags','ctags'],
                                    \ 'c':[':Vista coc','coc'],
                                    \ 'l':[':Vista lcn','lcn'],
                                    \ 'nl':[':Vista nvim_lsp','nvim_lsp'],
                                    \ 'vl':[':Vista vim_lsp','vim_lsp'],
                                    \ 'vc': [':Vista vim_lsc','vim_lsc']
                                    \ })
