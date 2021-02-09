" File: ovim.vim
" Author: Yiklek
" Description: ovim init
" Last Modified: 二月 09, 2021
" Copyright (c) 2021 Yiklek

let g:ovim_root_path = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')
let $OVIM_ROOT_PATH = g:ovim_root_path
let g:vim_path = fnamemodify(expand('$MYVIMRC'), ':h')
let $VIM_PATH  = g:vim_path

let g:ovim_cacha_path = $XDG_CACHE_HOME != '' ? $XDG_CACHE_HOME.'/ovim' : expand('~/.cache/ovim')

if has('win64') || has('win32') || has('win16') || has('win95')
    let g:ovim_default_python_path = g:ovim_cacha_path.'/python3-venv/Scripts/python.exe'
else
    let g:ovim_default_python_path = g:ovim_cacha_path.'/python3-venv/bin/python'
endif

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
    let g:ovim_global_options = {'plugins':{}}
    let g:ovim_global_options = s:options(exists("a:1") ? a:1 : 'default')
    call s:setup_python()
    if exists('g:ovim_global_options.modules')
            call s:modules(g:ovim_global_options.modules)
    endif
    if ovim#plugin#begin(g:ovim_cacha_path)
        if exists('g:ovim_global_options.plugins')
            call s:plugins(g:ovim_global_options.plugins)
        endif
    endif
    call ovim#plugin#end(g:ovim_global_options.plugins)

    autocmd VimEnter * call s:addons(g:ovim_global_options.addons)
    autocmd VimEnter * OvimSource g:ovim_root_path.'/keymaps/global.vim'
endfunction

" must be invoked after read config
function! s:setup_python()
    if !exists('g:python3_setup')
        if has('win64') || has('win32') || has('win16') || has('win95')
            let g:python3_host_prog = get(g:,'python3_host_prog',g:ovim_cacha_path.'/python3-venv/Scripts/python.exe')
            let python3_home = fnamemodify(expand(g:python3_host_prog),':p:h')
            let &rtp = python3_home.'/Lib,'.&rtp
        else
            let g:python3_host_prog = get(g:,'python3_host_prog',g:ovim_cacha_path.'/python3-venv/bin/python')
            let python3_home = fnamemodify(expand(g:python3_host_prog),':p:h:h')
            let &rtp = python3_home.'/lib,'.&rtp
        endif
    let g:python3_setup = 1
    endif
endfunction

function! s:options(config) abort
    if a:config == 'default'
        let l:options = ovim#utils#load_default()
    elseif a:config == 'custom'
        let l:options = ovim#utils#load_custom()
    elseif a:config == 'override'
        let l:options = ovim#utils#load_default()
        "try
            let l:options_custom = ovim#utils#load_custom()
            call ovim#utils#recursive_update(l:options,l:options_custom)
        "catch
        "endtry
    else
        let l:options = ovim#utils#load_config(a:config)
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

