" Set floaterm window's background to black
hi Floaterm guibg=black ctermbg=darkgreen ctermfg=darkgreen
" Set floating window border line color to cyan, and background to orange
hi FloatermBorder guibg=darkgreen ctermbg=darkgreen guifg=darkgreen
hi FloatermNC guibg=gray

let g:floaterm_complete_options = {'shortcut': 'floaterm', 'priority': 5,'filter_length':[0,100]}

" leader
nnoremap <silent> <leader>et<space> :FloatermToggle<CR>
nnoremap <silent> <leader>et9 :FloatermPrev<CR>
nnoremap <silent> <leader>et0 :FloatermNext<CR>
nnoremap <silent> <leader>etn :FloatermNew --wintype=float --position=center --width=0.8 --height=0.8<CR>
nnoremap <silent> <leader>et; :FloatermFirst<CR>
nnoremap <silent> <leader>et' :FloatermLast<CR>
nnoremap <silent> <leader>etq :FloatermKill<CR>
nnoremap <silent> <leader>etw<space> :FloatermNew --wintype=vsplit --position=right --width=0.4<CR>
nnoremap <silent> <leader>etwr :FloatermNew --wintype=vsplit --position=right --width=0.4<CR>
nnoremap <silent> <leader>etwb :FloatermNew --wintype=split --position=bottom --height=0.3<CR>
nnoremap <silent> <leader>et- :FloatermUpdate --wintype=split --position=topleft --height=0.3<CR>
nnoremap <silent> <leader>et= :FloatermUpdate --wintype=split --position=botright --height=0.3<CR>
nnoremap <silent> <leader>et[ :FloatermUpdate --wintype=vsplit --position=topleft --width=0.4<CR>
nnoremap <silent> <leader>et] :FloatermUpdate --wintype=vsplit --position=botright --width=0.4<CR>
nnoremap <silent> <leader>et\ :FloatermUpdate --wintype=float --position=center --width=0.8 --height=0.8<CR>

" esc
nnoremap <silent> <esc><space> :FloatermToggle<CR>
nnoremap <silent> <esc>9 :FloatermPrev<CR>
nnoremap <silent> <esc>0 :FloatermNext<CR>
nnoremap <silent> <esc>n :FloatermNew --wintype=float --position=center --width=0.8 --height=0.8<CR>
nnoremap <silent> <esc>; :FloatermFirst<CR>
nnoremap <silent> <esc>' :FloatermLast<CR>
nnoremap <silent> <esc>q :FloatermKill<CR>
nnoremap <silent> <esc>w<space> :FloatermNew --wintype=vsplit --position=right --width=0.4<CR>
nnoremap <silent> <esc>wr :FloatermNew --wintype=vsplit --position=right --width=0.4<CR>
nnoremap <silent> <esc>wb :FloatermNew --wintype=split --position=bottom --height=0.3<CR>
nnoremap <silent> <esc>- :FloatermUpdate --wintype=split --position=topleft --height=0.3<CR>
nnoremap <silent> <esc>= :FloatermUpdate --wintype=split --position=botright --height=0.3<CR>
nnoremap <silent> <esc>[ :FloatermUpdate --wintype=vsplit --position=topleft --width=0.4<CR>
nnoremap <silent> <esc>] :FloatermUpdate --wintype=vsplit --position=botright --width=0.4<CR>
nnoremap <silent> <esc>\ :FloatermUpdate --wintype=float --position=center --width=0.8 --height=0.8<CR>

tnoremap <silent> <esc><space>  <c-\><c-n>:FloatermToggle<CR>
tnoremap <silent> <esc>9  <c-\><c-n>:FloatermPrev<CR>
tnoremap <silent> <esc>0  <c-\><c-n>:FloatermNext<CR>
tnoremap <silent> <esc>n  <c-\><c-n>:FloatermNew --wintype=float --position=center --width=0.8 --height=0.8<CR>
tnoremap <silent> <esc>;  <c-\><c-n>:FloatermFirst<CR>
tnoremap <silent> <esc>'  <c-\><c-n>:FloatermLast<CR>
tnoremap <silent> <esc>q  <c-\><c-n>:FloatermKill<CR>
tnoremap <silent> <esc>w<space> <c-\><c-n>:FloatermNew --wintype=vsplit --position=right --width=0.4<CR>
tnoremap <silent> <esc>wr <c-\><c-n>:FloatermNew --wintype=vsplit --position=right --width=0.4<CR>
tnoremap <silent> <esc>wb <c-\><c-n>:FloatermNew --wintype=split --position=bottom --height=0.3<CR>
tnoremap <silent> <esc>- <c-\><c-n>:FloatermUpdate --wintype=split --position=topleft --height=0.3<CR>
tnoremap <silent> <esc>= <c-\><c-n>:FloatermUpdate --wintype=split --position=botright --height=0.3<CR>
tnoremap <silent> <esc>[ <c-\><c-n>:FloatermUpdate --wintype=vsplit --position=topleft --width=0.4<CR>
tnoremap <silent> <esc>] <c-\><c-n>:FloatermUpdate --wintype=vsplit --position=botright --width=0.4<CR>
tnoremap <silent> <esc>\ <c-\><c-n>:FloatermUpdate --wintype=float --position=center --width=0.8 --height=0.8<CR>
tnoremap <silent> <esc>k <c-\><c-n><c-w>k
tnoremap <silent> <esc>j <c-\><c-n><c-w>j
tnoremap <silent> <esc>h <c-\><c-n><c-w>h
tnoremap <silent> <esc>l <c-\><c-n><c-w>l

vnoremap <leader>ets :FloatermSend<CR>

if ovim#utils#has_win()
    let win_shells = ['pwsh.exe','powershell.exe','cmd.exe']
    for i in win_shells
        if executable(i)
            let g:floaterm_shell = i
            break
        endif
    endfor
endif

call ovim#utils#recursive_update(g:leader_key_map.e,{'t':{'name':'+Terminal',
                                    \    ' ':[':FloatermToggle','Floaterm Toggle'],
                                    \    '[':[':FloatermPrev','Previous Terminal'],
                                    \    ']':[':FloatermNext','Next Terminal'],
                                    \    'n':[':FloatermNew --wintype=float --position=center --width=0.8 --height=0.8','New Terminal'],
                                    \    '-':[':FloatermFirst','First Terminal'],
                                    \    '=':[':FloatermLast','Last Terminal'],
                                    \    'k':[':FloatermKill','Kill Terminal'],
                                    \    '?':[':echo "in terminal,prefix is <esc><tab>"','help'],
                                    \    'w':{'name':'+Normal Window',
                                    \               ' ':[':FloatermNew --wintype=vsplit --position=right --width=0.3','Right Window Terminal'],
                                    \               'r':[':FloatermNew --wintype=vsplit --position=right --width=0.3','Right Window Terminal'],
                                    \               'b':[':FloatermNew --wintype=split --position=bottom --width=0.3','Bottom Window Terminal'],
                                    \       }
                                \ }})
