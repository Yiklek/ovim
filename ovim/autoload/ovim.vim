
let g:ovim_root_path = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')
let $OVIM_ROOT_PATH = g:ovim_root_path
let g:vim_path = fnamemodify(expand('$MYVIMRC'), ':h')
let $VIM_PATH  = g:vim_path

let g:ovim_cacha_path = $XDG_CACHE_HOME != '' ? $XDG_CACHE_HOME.'/ovim' : expand('~/.cache/ovim')


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
" give 'default','custom' or {path} to choose config file.
" when 'default' given,the default config will be loaded.
" when 'custom' given,config file at your $MYVIMRC's directory config/custom.[json|toml] will be loaded
" when a {path} given,specified file will be loaded
function! ovim#init(...) abort
    let g:ovim_global_options = {'plugins':{}}
    let g:ovim_global_options = s:options(exists("a:1") ? a:1 : 'default')
    if exists('g:ovim_global_options.modules')
            call s:modules(g:ovim_global_options.modules)
    endif
    if ovim#plugin#begin(g:ovim_cacha_path)
        if exists('g:ovim_global_options.plugins')
            call s:plugins(g:ovim_global_options.plugins)
        endif
    endif
    call ovim#plugin#end(g:ovim_global_options.plugins)
    autocmd VimEnter * call ovim#utils#source(g:ovim_root_path.'/keymaps/global.vim')
endfunction


function! s:options(config) abort
    if a:config == 'default'
        let l:options = ovim#utils#load_default()
    elseif a:config == 'custom'
        let l:options = ovim#utils#load_custom()
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
        if get(g:ovim_global_options,'config_level',2) < get(m,'level',0)
            continue
        endif
        if exists('m.enable') && m.enable == v:false
        else
            let module = ovim#modules#load(m.name,m)
            let l:module_plugins = module.plugins()
            call extend(g:ovim_global_options['plugins'],l:module_plugins)
            call module.config()
        endif

    endfor
endfunction
