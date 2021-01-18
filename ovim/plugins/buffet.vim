let g:buffet_show_index = 1
let g:buffet_always_show_tabline = 0

function! g:BuffetSetCustomColors()
    " hi!  BuffetCurrentBuffer  term=bold ctermfg=142 ctermbg=237 guifg=#b8bb26 guibg=#3c3836
    hi!  link  BuffetCurrentBuffer   TabLineSel
    hi!  link  BuffetActiveBuffer   BuffetTab
    hi!  link  BuffetBuffer   TabLine
    hi!  link  BuffetModCurrentBuffer   BuffetCurrentBuffer
    hi!  link  BuffetModActiveBuffer   BuffetActiveBuffer
    hi!  link  BuffetModBuffer   BuffetBuffer
    hi!  link  BuffetTrunc   TabLine
    hi!  link  BuffetTab   TabLine

"   hi! BuffetCurrentBuffer cterm=NONE ctermbg=5 ctermfg=8 guibg=#00FF00 guifg=#000000
endfunction

" hi  link  BuffetCurrentBuffer   BuffetCurrentBuffer

nmap <leader>1 <Plug>BuffetSwitch(1)
nmap <leader>2 <Plug>BuffetSwitch(2)
nmap <leader>3 <Plug>BuffetSwitch(3)
nmap <leader>4 <Plug>BuffetSwitch(4)
nmap <leader>5 <Plug>BuffetSwitch(5)
nmap <leader>6 <Plug>BuffetSwitch(6)
nmap <leader>7 <Plug>BuffetSwitch(7)
nmap <leader>8 <Plug>BuffetSwitch(8)
nmap <leader>9 <Plug>BuffetSwitch(9)
nmap <leader>0 <Plug>BuffetSwitch(10)