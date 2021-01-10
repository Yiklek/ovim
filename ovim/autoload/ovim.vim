
let g:ovim_root_path = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')
let $OVIM_ROOT_PATH = g:ovim_root_path
let $VIM_PATH  = g:dotvim 


let g:ovim_global_options = {}

if !exists('g:space_key_map')
    let g:space_key_map =  {}
endif


if !exists('g:leader_key_map')
    let g:leader_key_map =  {'x':{'name':'+编辑'},'f':{'name':'+文件/查找'},'e':{'name':'+Extentions'}}
endif

function! ovim#init() abort
    let g:ovim_global_options = s:options()
    call ovim#plugin#begin(g:dotvimd.'/plugged')
        call s:modules(g:ovim_global_options.modules)
        call s:plugins(g:ovim_global_options.plugins)

    call ovim#plugin#end(g:ovim_global_options.plugins)

endfunction


function! s:options() abort
    let l:options = ovim#utils#load_default()
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