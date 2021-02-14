" File: plugin.vim
" Author: Yiklek
" Description: plugin manager
" Last Modified: 二月 09, 2021
" Copyright (c) 2021 Yiklek

function ovim#plugin#begin(arg)
    let g:ovim_plug_manager = get(g:ovim_global_options,'ovim_plug_manager','dein')
    if exists('g:ovim_global_options.hook_before_setup_plugin')
        exe g:ovim_global_options.hook_before_setup_plugin
    endif
    if g:ovim_plug_manager ==# 'plug'
        if !filereadable(g:vim_path.'/autoload/plug.vim')
            call ovim#utils#warn('download plug.vim from https://github.com/junegunn/vim-plug to '.g:vim_path.'/autoload/plug.vim manually')
            throw 'OvimError:0002: download plug.vim from https://github.com/junegunn/vim-plug to '.g:vim_path.'/autoload/plug.vim manually'
        endif
            call plug#begin(a:arg.'/plugged')
    elseif g:ovim_plug_manager ==# 'dein'
        set rtp+=$VIM_PATH/dein.vim
        if !isdirectory(g:vim_path.'/dein.vim')
            call ovim#utils#warn('download dein.vim from https://github.com/Shougo/dein.vim.git to '.g:vim_path.'/dein.vim manually')
            throw 'OvimError:0002: download dein.vim from https://github.com/Shougo/dein.vim.git to '.g:vim_path.'/dein.vim manually'
        endif
        if dein#load_state(a:arg.'/dein')
            call dein#begin(a:arg.'/dein')
            call dein#add(g:vim_path.'/dein.vim',{ 'on_func':'dein#' ,"hook_add":"source $OVIM_ROOT_PATH/plugins/dein.add.vim"})
            let g:dein_loading = 1
        else
            return 0
        endif
    endif
    " disable low priority
    call s:batch_set_plugins_attr(s:disable_plugins,'if',0) 
    " enable high priority
    call s:batch_set_plugins_attr(s:enable_plugins,'if',1) 
    return 1
endfun

function ovim#plugin#end(plugins)
    if g:ovim_plug_manager ==# 'plug'
        if type(a:plugins) == v:t_dict
            call s:_plug_source(values(a:plugins))
        endif
        call plug#end()
        if type(a:plugins) == v:t_dict
            autocmd VimEnter * call s:_plug_post_source(values(g:ovim_global_options.plugins))
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
    let l:level = ovim#utils#check_level(a:plugin)
    let l:if = !(exists('a:plugin.if')
        \ && (type(a:plugin['if']) == v:t_number && a:plugin.if == 0
            \ || type(a:plugin['if']) == v:t_string && !eval(a:plugin['if'])))
    let a:plugin._will_load = l:level && l:if
    return a:plugin._will_load
endfun

function s:append_list(target,...)
    if type(a:target) != v:t_list
        call ovim#utils#warn('plugin append_list: target list required.')
        return
    endif
    if len(a:000) > 0 
        for p in a:000
            if type(p) == v:t_string 
                call add(a:target,p)
            elseif type(p) == v:t_list
                for i in p
                    call s:append_list(a:target,i)
                endfor
            else
                call ovim#utils#warn("plugin append_list:args string or list require.")
            endif
        endfor
    endif
endfunction

function s:batch_set_plugins_attr(plugins,attr,value)
    for p in a:plugins
        try
            let g:ovim_global_options.plugins[p][a:attr] = a:value
        catch
            call ovim#utils#warn("plugin batch_set_plugins_attr: ".v:exception." --> ".v:throwpoint)
        endtry
    endfor
endfunction

let s:disable_plugins = []
function ovim#plugin#disable(...)
    call s:append_list(s:disable_plugins,a:000)
endfunction

let s:enable_plugins = []
function ovim#plugin#enable(...)
    call s:append_list(s:enable_plugins,a:000)
endfunction
