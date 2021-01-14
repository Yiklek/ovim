
" option: plug dein(todo)

function ovim#plugin#begin(arg)
    if g:ovim_plug_manager ==# 'plug'
        call plug#begin(a:arg)
        return 1
    elseif g:ovim_plug_manager ==# 'dein'
        set rtp+=$VIM_PATH/dein.vim
        let g:dein#auto_recache = 1
        if dein#load_state('~/.cache/dein')
            call dein#begin('~/.cache/dein')
            call dein#add(g:vim_path.'/dein.vim')
            let g:dein_loading = 1
            return 1
        else
            return 0
        endif
    endif
endfun

function ovim#plugin#end(plugins)
    if g:ovim_plug_manager ==# 'plug'
        if type(a:plugins) == v:t_list
            call s:_plug_source(a:plugins)
        endif
        call plug#end()
        if type(a:plugins) == v:t_list
            call s:_plug_post_source(a:plugins)
        endif
    elseif g:ovim_plug_manager ==# 'dein'
        if exists("g:dein_loading") && g:dein_loading
            call dein#end()
            call dein#save_state()
            let s:dein_loading = 0
        endif
        call dein#call_hook('source')
        call dein#call_hook('post_source')
    endif
endfun


function ovim#plugin#add(repo,...)
    if g:ovim_plug_manager ==# 'plug'
        call s:_plug_add(a:1)
        Plug a:repo, a:1
    elseif g:ovim_plug_manager ==# 'dein'
        if exists("g:dein_loading") && g:dein_loading
            call dein#add(a:repo,a:1)
        endif
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
            execute(a:plugin.hook_add)
        endif
    endif
endfun
