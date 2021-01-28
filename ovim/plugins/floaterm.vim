" Set floaterm window's background to black
hi Floaterm guibg=black ctermbg=darkgreen ctermfg=darkgreen
" Set floating window border line color to cyan, and background to orange
hi FloatermBorder guibg=darkgreen ctermbg=darkgreen guifg=darkgreen
hi FloatermNC guibg=gray

let g:floaterm_complete_options = {'shortcut': 'floaterm', 'priority': 5,'filter_length':[0,100]}

nnoremap <leader>et<space> :FloatermToggle  --wintype=float --position=center --width=0.8 --height=0.8<CR>
nnoremap <leader>et[ :FloatermPrev<CR>
nnoremap <leader>et] :FloatermNext<CR>
nnoremap <leader>etn :FloatermNew --wintype=float --position=center --width=0.8 --height=0.8<CR>
nnoremap <leader>et0 :FloatermFirst<CR>
nnoremap <leader>et9 :FloatermLast<CR>
nnoremap <leader>etk :FloatermKill<CR>
nnoremap <leader>etw<space> :FloatermNew --wintype=normal --position=right --width=0.3<CR>
nnoremap <leader>etwnr :FloatermNew --wintype=normal --position=right --width=0.3<CR>
nnoremap <leader>etwnb :FloatermNew --wintype=normal --position=bottom --width=0.3<CR>

tnoremap <esc><tab><space>  <c-\><c-n>:FloatermToggle<CR>
tnoremap <esc><tab>[  <c-\><c-n>:FloatermPrev<CR>
tnoremap <esc><tab>]  <c-\><c-n>:FloatermNext<CR>
tnoremap <esc><tab>n  <c-\><c-n>:FloatermNew<CR>
tnoremap <esc><tab>0  <c-\><c-n>:FloatermFirst<CR>
tnoremap <esc><tab>9  <c-\><c-n>:FloatermLast<CR>
tnoremap <esc><tab>k  <c-\><c-n>:FloatermKill<CR>

vnoremap <leader>ets :FloatermSend<CR>


call ovim#utils#recursive_update(g:leader_key_map.e,{'t':{'name':'+Terminal',
                                    \    ' ':[':FloatermToggle','Floaterm Toggle'],
                                    \    '[':[':FloatermPrev','Previous Terminal'],
                                    \    ']':[':FloatermNext','Next Terminal'],
                                    \    'n':[':FloatermNew --wintype=float --position=center --width=0.8 --height=0.8','New Terminal'],
                                    \    '0':[':FloatermFirst','First Terminal'],
                                    \    '9':[':FloatermLast','Last Terminal'],
                                    \    'k':[':FloatermKill','Kill Terminal'],
                                    \    '?':[':echo "in terminal,prefix is <esc><tab>"','help'],
                                    \    'w':{'name':'+Normal Window',
                                    \           'n':{'name':'+New',
                                    \               ' ':[':FloatermNew --wintype=normal --position=right --width=0.3','Right Window Terminal'],
                                    \               'r':[':FloatermNew --wintype=normal --position=right --width=0.3','Right Window Terminal'],
                                    \               'b':[':FloatermNew --wintype=normal --position=bottom --width=0.3','Bottom Window Terminal'],
                                    \               },
                                    \           ' ':[':FloatermNew --wintype=normal --position=right --width=0.3','Right Window Terminal'],
                                    \       }
                                \ }})
