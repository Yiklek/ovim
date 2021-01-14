
let g:ovim_root_path = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')
let $OVIM_ROOT_PATH = g:ovim_root_path
let g:vim_path = fnamemodify(expand('$MYVIMRC'), ':h')
let $VIM_PATH  = g:vim_path


let g:ovim_global_options = {}
let g:ovim_plug_manager = get(g:,'ovim_plug_manager','dein')

if !exists('g:space_key_map')
    let g:space_key_map =  {}
endif


if !exists('g:leader_key_map')
    let g:leader_key_map =  {'x':{'name':'+编辑'},'f':{'name':'+文件/查找'},
    \ 'e':{'name':'+Extentions'},'j':"+Code Jump(TODO)",
    \ 'c':{'name':'+注释'}, 
    \}
endif

function! ovim#init() abort
    let g:ovim_global_options = {'plugins':[]}
    let g:ovim_global_options = s:options()
    if exists('g:ovim_global_options.modules')
            call s:modules(g:ovim_global_options.modules)
    endif
    if ovim#plugin#begin(g:dotvimd.'/plugged')
        if exists('g:ovim_global_options.plugins')
            call s:plugins(g:ovim_global_options.plugins)
        endif 
    endif
    call ovim#plugin#end(g:ovim_global_options.plugins)
    
endfunction


function! s:options() abort
    let l:options = ovim#utils#load_default()
    if exists('l:options.var')
        for [k,v] in items(l:options.var)
            let g:{k} = v
        endfor
    endif
    return l:options
endfunction

function! s:plugins(plugs) abort
    for p in a:plugs
        if exists('p.if')
            if type(p['if']) == v:t_number && p.if != 0 || type(p['if']) == v:t_string && eval(p['if'])
                call ovim#plugin#add(p.repo,p)
            endif
        else
            call ovim#plugin#add(p.repo,p)
        endif
    endfor
endfunction

function! s:modules(mdls) abort
    for m in a:mdls
        if exists('m.enable') && m.enable == v:false
        else
            let module = ovim#modules#load(m.name,m)
            let l:module_plugins = module.plugins()
            call extend(g:ovim_global_options['plugins'],l:module_plugins)
            call module.config()
        endif
        
    endfor
endfunction