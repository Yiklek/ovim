
" option: plug dein(todo)
let g:ovim_plug_manager = 'plug'


function ovim#plugin#begin(arg) 
    if g:ovim_plug_manager ==# 'plug'
        call plug#begin(a:arg)
    endif
endfun

function ovim#plugin#end(plugins) 
    if g:ovim_plug_manager ==# 'plug'
        call s:_plug_source(a:plugins)
        call plug#end()
        call s:_plug_post_source(a:plugins)
    endif
endfun


function ovim#plugin#add(repo,...) 
    if g:ovim_plug_manager ==# 'plug'
        call s:_plug_add(a:1)
        Plug a:repo, a:1
    endif
endfun

function s:_plug_source(plugins) 
    for p in a:plugins
        if exists('p.if') 
            \ && (type(p['if']) == v:t_number && p.if == 0 
            \ || type(p['if']) == v:t_string && !eval(p['if']))
        else
            if exists('p.hook_source')
                execute(p.hook_source)
            endif 
        endif
    endfor
endfun

function s:_plug_post_source(plugins) 
    for p in a:plugins
        if exists('p.if') 
            \ && (type(p['if']) == v:t_number && p.if == 0 
            \ || type(p['if']) == v:t_string && !eval(p['if']))
        else
            if exists('p.hook_post_source')
                execute(p.hook_post_source)
            endif 
        endif
    endfor
endfun

function s:_plug_add(plugin) 
    if exists('a:plugin.if') 
        \ && (type(a:plugin['if']) == v:t_number && a:plugin.if == 0 
        \ || type(a:plugin['if']) == v:t_string && !eval(a:plugin['if']))
    else
        if exists('a:plugin.hook_add')
            execute(p.hook_add)
        endif 
    endif
endfun