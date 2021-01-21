
" option: plug dein(todo)

function ovim#plugin#begin(arg)
    let g:ovim_plug_manager = get(g:ovim_global_options,'ovim_plug_manager','dein')
    if exists('g:ovim_global_options.hook_before_setup_plugin')
        exe g:ovim_global_options.hook_before_setup_plugin
    endif 
    if g:ovim_plug_manager ==# 'plug'
    if !filereadable(g:vim_path.'/autoload/plug.vim')
            call ovim#utils#log('downloading plug.vim...')
            if executable('curl')
                call ovim#utils#log('downloading plug.vim...')
                call system('curl -fLo '.g:vim_path.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
            else
                call ovim#utils#log('download plug.vim manually')
            endif
    endif
        call plug#begin(a:arg.'/plugged')
        return 1
    elseif g:ovim_plug_manager ==# 'dein'
        set rtp+=$VIM_PATH/dein.vim
        let g:dein#auto_recache = 1
        if !isdirectory(g:vim_path.'/dein.vim')
            if executable('git')
                call ovim#utils#log('downloading dein.vim...')
                call system('git clone https://github.com/Shougo/dein.vim.git '.g:vim_path.'/dein.vim')
            else 
                call ovim#utils#log('download dein.vim manually')
            endif
        endif
        if dein#load_state(a:arg.'/dein')
            call dein#begin(a:arg.'/dein')
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
        if type(a:plugins) == v:t_dict
            call s:_plug_source(values(a:plugins))
        endif
        call plug#end()
        if type(a:plugins) == v:t_dict
            call s:_plug_post_source(values(a:plugins))
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
    if exists('g:ovim_global_options.hook_after_setup_plugin')
        exe g:ovim_global_options.hook_after_setup_plugin
    endif 
endfun


function ovim#plugin#add(repo,...)
    if !s:_plug_will_load(a:1)
        return
    endif
    if g:ovim_plug_manager ==# 'plug'
        if s:_plug_will_load(a:1)
            call s:_plug_add(a:1)
            Plug a:repo, a:1
        endif
    elseif g:ovim_plug_manager ==# 'dein'
        if exists("g:dein_loading") && g:dein_loading
            call dein#add(a:repo,a:1)
        endif
    endif
endfun

function s:_plug_source(plugins)
    for p in a:plugins
        if s:_plug_will_load(p)
            if exists('p.hook_source')
                execute(p.hook_source)
            endif
        endif
    endfor
endfun

function s:_plug_post_source(plugins)
    for p in a:plugins
        if s:_plug_will_load(p)
            if exists('p.hook_post_source')
                execute(p.hook_post_source)
            endif
        endif
    endfor
endfun

function s:_plug_add(plugin)
    if s:_plug_will_load(a:plugin)
        if exists('a:plugin.hook_add')
            execute(a:plugin.hook_add)
        endif
    endif
endfun

function s:_plug_will_load(plugin)
    if exists('a:plugin._will_load')
        return a:plugin._will_load
    endif
    let l:level =  get(g:ovim_global_options,'config_level',2) < get(a:plugin,'level',0) ? 0 : 1
    let l:if = !(exists('a:plugin.if') 
        \ && (type(a:plugin['if']) == v:t_number && a:plugin.if == 0
            \ || type(a:plugin['if']) == v:t_string && !eval(a:plugin['if'])))
    let a:plugin._will_load = l:level && l:if
    return a:plugin._will_load
endfun
