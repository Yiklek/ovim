" File: ovim.vim
" Author: Yiklek
" Description: ovim init
" Last Modified: 二月 09, 2021
" Copyright (c) 2021 Yiklek
" MacVim 8.2-patch-1-2164+ or Neovim 0.4+

let g:ovim_root_path = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')
let $OVIM_ROOT_PATH = g:ovim_root_path
let g:vim_path = fnamemodify(expand('$MYVIMRC'), ':h')
let $VIM_PATH  = g:vim_path

let g:ovim_cache_path = $XDG_CACHE_HOME != '' ? $XDG_CACHE_HOME.'/ovim' : expand('~/.cache/ovim')
let $OVIM_CACHE_PATH = g:ovim_cache_path
let g:ovim_option_cache_path = g:ovim_cache_path . "/ovim_option_cache.json"
let g:ovim_packer_compiled_path = g:ovim_cache_path . "/packer/compiled.vim"

if ovim#utils#has_win()
    let g:ovim_default_python_path = g:ovim_cache_path.'/python3-venv/Scripts/python.exe'
else
    let g:ovim_default_python_path = g:ovim_cache_path.'/python3-venv/bin/python'
endif
let g:python3_host_prog = get(g:,'python3_host_prog', g:ovim_default_python_path)
let g:mapleader = get(g:,'mapleader', ',')

let g:ovim_global_options = {}

if !exists('g:space_key_map')
    let g:space_key_map =  {}
endif


if !exists('g:leader_key_map')
    let g:leader_key_map =  {'x':{'name':'+编辑'},'f':{'name':'+文件'},
    \ 'e':{'name':'+Extentions'},'j':{"name":"+Code Jump"},
    \ 'c':{'name':'+注释'},
    \}
endif

command -nargs=0 OvimCopyConfig call ovim#utils#copy_config()
command -nargs=0 OvimRmOptionCache call delete(g:ovim_option_cache_path) | call delete(g:ovim_packer_compiled_path)
            \ | if g:ovim_plug_manager ==# 'dein' | call dein#clear_state()
            \ | endif
command -nargs=0 OvimMakeOptionCache call ovim#utils#make_option_cache(g:ovim_option_cache_path)
            \ | if get(g:, 'ovim_packer_setup', 0) == 1 | exe 'PackerCompile' | endif
command -nargs=0 OvimCopyDotSpector call ovim#utils#copy(g:ovim_root_path.'/config/vimspector/.vimspector.json','./.vimspector.json')

" both two command receive, expand and eval input string.
" if you want to source directly,use `source`
" examples:
" OvimSource g:var.'/path/to/vim'
" OvimSource "$ENV/path/to/vim"
" source like doesn't support:
" source $ENV/path/to/vim
command -nargs=1 -complete=expression OvimSource call ovim#utils#source(eval(expand(<q-args>)))
command -nargs=1 -complete=expression OvimTrySource call ovim#utils#try_source(eval(expand(<q-args>)))

command -nargs=* -complete=expression OvimLogInfo call ovim#utils#log(<f-args>)
command -nargs=* -complete=expression OvimLogWarn call ovim#utils#warn(<f-args>)
" give 'default','custom','override' or {path} to choose config file.
" when 'default' given,the default config will be loaded.
" when 'custom' given,config file at your $MYVIMRC's directory config/custom.[json|toml] will be loaded
" when 'override' given,config file at your $MYVIMRC's directory config/custom.[json|toml]
" and default will be both loaded.specified option will override default.this maybe cause startup slowly.
" when a {path} given,specified file will be loaded
function! ovim#init(...) abort
    call s:setup_pack()
    call s:setup_python()
    let g:ovim_global_options = s:options(g:ovim_option_cache_path)
    if type(g:ovim_global_options) == v:t_string && g:ovim_global_options == ''
        let g:ovim_global_options = s:options(exists("a:1") ? a:1 : 'default')
    endif
    if exists('g:ovim_global_options.modules')
        call s:modules(g:ovim_global_options.modules)
    endif
    if ovim#plugin#begin(g:ovim_cache_path)
        if exists('g:ovim_global_options.plugins')
            call s:plugins(g:ovim_global_options.plugins)
        endif
    endif
    call ovim#plugin#end(g:ovim_global_options.plugins)
    if ovim#utils#check_lua()
        lua require "ovim"
    endif
    autocmd VimEnter * call s:addons(get(g:ovim_global_options,'addons',{}))
endfunction

" must be invoked after read config
function! s:setup_python()
    if !exists('g:python3_setup')
        if ovim#utils#has_win()
            let python3_home = fnamemodify(expand(g:python3_host_prog),':p:h')
            if !has('nvim')
                let &rtp = python3_home.'/Lib,'.&rtp
            endif
            let $PATH = expand(python3_home.'/vbin').";".$PATH
        else
            let python3_home = fnamemodify(expand(g:python3_host_prog),':p:h:h')
            if !has('nvim')
                let &rtp = python3_home.'/lib,'.&rtp
            endif
            let $PATH = expand(python3_home.'/vbin').":".$PATH
        endif
        let g:python3_setup = 1
    endif
endfunction

function! s:setup_pack()
    if !exists('g:pack_setup')
        let &packpath = g:ovim_cache_path.','.&packpath
        let g:pack_setup = 1
    endif
endfunction

function! s:options(config) abort
    if a:config == 'default'
        let l:options = ovim#utils#load_default()
    elseif a:config == 'custom'
        let l:options = ovim#utils#load_custom()
    elseif a:config == 'override'
        let l:options = ovim#utils#load_default()
        let l:options_custom = ovim#utils#load_custom()
        let l:options_path = [l:options._option_path, l:options_custom._option_path]
        call ovim#utils#recursive_update(l:options, l:options_custom)
        let l:options._option_path = l:options_path
    else
        let l:options = ovim#utils#load_list(a:config)
    endif
    if exists('l:options.var')
        for [k,v] in items(l:options.var)
            let g:{k} = v
        endfor
    endif
    return l:options
endfunction

function! s:plugins(plugs) abort
    for p in values(a:plugs)
        call ovim#plugin#add(p.repo,p)
    endfor
endfunction

function! s:modules(mdls) abort
    for m in values(a:mdls)
        if !ovim#utils#check_level_and_enable(m)
            continue
        endif
        let module = ovim#modules#load(m.name,m)
        let l:module_plugins = module.plugins()
        call extend(g:ovim_global_options['plugins'],l:module_plugins)
        call module.config()
    endfor
endfunction

function! s:addons(addons) abort
    if get(g:,"ovim_addons_loaded",0)
        return
    endif
    for [key,addon] in items(a:addons)
        if !ovim#utils#check_level_and_enable(addon)
            continue
        endif
        call ovim#addons#load(key,addon)
    endfor
    let g:ovim_addons_loaded = 1
endfunction
