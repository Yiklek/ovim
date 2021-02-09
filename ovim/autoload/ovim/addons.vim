" File: addons.vim
" Author: Yiklek
" Description: ovim build-in addons
" Last Modified: 二月 09, 2021
" Copyright (c) 2021 Yiklek

function ovim#addons#load(name,arg)
    call ovim#addons#{a:name}#load(a:arg)
endfunction
