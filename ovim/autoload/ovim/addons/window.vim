" File: window.vim
" Author: Yiklek
" Description: addon for window
" Last Modified: 二月 09, 2021
" Copyright (c) 2021 Yiklek

function! ovim#addons#window#load(addon)
    nnoremap <leader>wz :call ovim#addons#window#zoom()<CR>
    let l:leader_key_map = {'w':{'z':[':call ovim#addons#window#zoom()','最大化窗口']}}
    call ovim#utils#recursive_update(g:leader_key_map,l:leader_key_map)
endfunction

" zoom {{{
function! ovim#addons#window#zoom()
    " check if is the zoomed state (tabnumber > 1 && window == 1)
    if tabpagenr('$') > 1 && tabpagewinnr(tabpagenr(), '$') == 1
        let l:cur_winview = winsaveview()
        let l:cur_bufname = bufname('')
        tabclose

        " restore the view
        if l:cur_bufname == bufname('')
            call winrestview(cur_winview)
        endif
    else
        tab split
    endif
endfunction
" }}
