" File: modules.vim
" Author: Yiklek
" Description: ovim modules
" Last Modified: 02 10, 2021
" Copyright (c) 2021 Yiklek


"{name:'','plugins':[{ 'name':'name',option:{} }]}
function ovim#modules#new()
    return {'name':'','plugs':[]}
endfun
function ovim#modules#load(module,...)
    return ovim#modules#{a:module}#load(a:1)
endfun
