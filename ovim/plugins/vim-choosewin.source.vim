nmap <leader>w<space> <Plug>(choosewin)
let s:leader_key_map = {"w":{" ":["<Plug>(choosewin)","选择窗口"]}}
call ovim#utils#recursive_update(g:leader_key_map,s:leader_key_map)
let s:color_tabline = ovim#utils#get_hightlight("TabLine")
let s:color_tabline_fill = ovim#utils#get_hightlight("TabLineFill")
let s:color_tabline_sel = ovim#utils#get_hightlight("TabLineSel")
let g:choosewin_color_label           = { 'gui': [get(s:color_tabline,'guibg','#3e4452'), get(s:color_tabline,'guifg','#828997'), 'bold'],
                                        \ 'cterm': [ get(s:color_tabline,'ctermbg',17), get(s:color_tabline,'ctermfb',102),'bold'] }
let g:choosewin_color_label_current   = { 'gui': [get(s:color_tabline_sel,'guibg','#61afef'),get(s:color_tabline_sel,'guifg','#282c34'), 'bold'],
                                        \ 'cterm': [ get(s:color_tabline_sel,'ctermbg',75), get(s:color_tabline_sel,'ctermfb',16), 'bold'] }

let g:choosewin_color_overlay         = { 'gui': [get(s:color_tabline,'guibg','#3e4452'), get(s:color_tabline,'guifg','#828997'), 'bold'],
                                        \ 'cterm': [ get(s:color_tabline,'ctermbg',17), get(s:color_tabline,'ctermfb',102),'bold'] }
let g:choosewin_color_overlay_current = { 'gui': [get(s:color_tabline_sel,'guibg','#61afef'),get(s:color_tabline_sel,'guifg','#282c34'), 'bold'],
                                        \ 'cterm': [ get(s:color_tabline_sel,'ctermbg',75), get(s:color_tabline_sel,'ctermfb',16), 'bold'] }

let g:choosewin_color_other           = { 'gui': [get(s:color_tabline_fill,'guibg','#3e4452'),get(s:color_tabline_fill,'guifg','#5c6370'), 'bold'],
                                        \ 'cterm': [ get(s:color_tabline_fill,'ctermbg',17), get(s:color_tabline_fill,'ctermfb',59), 'bold'] }
let g:choosewin_color_land            = { 'gui': [get(s:color_tabline_sel,'guibg','#61afef'),get(s:color_tabline_sel,'guifg','#282c34'), 'bold'],
                                        \ 'cterm': [ get(s:color_tabline_sel,'ctermbg',75), get(s:color_tabline_sel,'ctermfb',16), 'bold'] }
let g:choosewin_color_shade           = { 'gui':[ '', '#777777'], 'cterm': ['', 'grey'] }
