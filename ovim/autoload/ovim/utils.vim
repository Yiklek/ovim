" File: utils.vim
" Author: Yiklek
" Description: utilities
" Last Modified: 二月 09, 2021
" Copyright (c) 2021 Yiklek

let g:ovim_keymap_order = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k',
					\ 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
					\ '1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
					\ 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K',
					\ 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
					\ '!', '@', '#', '$', '%', '&', '&', '*', '(',')',]
let s:ovim_config_suffix = ["json","toml"]
" a:1 unite desc
" a:2 unite cmd
" a:3 guide desc
" example  call SpaceVim#mapping#def('nnoremap <silent>', 'gf', ':call SpaceVim#mapping#gf()<CR>', 'Jump to a file under cursor', '')
function! ovim#utils#keymap(type, key, value, ...) abort
    exe a:type .' '.a:key.' '.a:value
    " other operation
endfun

function ovim#utils#log(...) abort
    let time = strftime('%H:%M:%S')
	let l:msg = join(a:000,' ')
    let log = '[ovim][' . time . '][info]:' . l:msg
	echom log
endfun
function ovim#utils#warn(...) abort
    let time = strftime('%H:%M:%S')
	let l:msg = join(a:000,' ')
    let log = '[ovim][' . time . '][warn]:' . l:msg
	echohl WarningMsg | echom log | echohl None
endfun


" 暂时使用json  后续支持toml yaml
function ovim#utils#load_config(filename) abort
	let l:filename = expand(a:filename)
    if !filereadable(l:filename)
        return ''
    endif
    " Parse YAML/JSON config file fast than yaml
	let l:config_str = has('nvim') ? readfile(l:filename) : join(readfile(l:filename),"\n")
	if l:filename =~# '\.json$'
		" Parse JSON with built-in json_decode
		return json_decode(l:config_str)
	" elseif l:filename =~# '\.ya\?ml$'
	" 	" Parse YAML with common command-line utilities
	" 	return s:load_yaml(l:filename)
	elseif l:filename =~# '\.toml$'
		return json_decode(s:toml2json(l:config_str))
	endif
	call ovim#utils#log('Unknown config file format ' . l:filename)
	return ''
endfun

function ovim#utils#load_default() abort
	for i in s:ovim_config_suffix
        let l:option_path = g:ovim_root_path.'/config/default.'.i
		if filereadable(l:option_path)
			let l:options = ovim#utils#load_config(l:option_path)
            let l:options._option_path = l:option_path
			return l:options
		endif
	endfor
	throw 'OvimError:0001: default config not found.'
endfun

function ovim#utils#load_custom() abort
	for i in s:ovim_config_suffix
        let l:option_path = g:vim_path.'/config/custom.'.i
		if filereadable(l:option_path)
			let l:options = ovim#utils#load_config(l:option_path)
            let l:options._option_path = l:option_path
			return l:options
		endif
	endfor
	call ovim#utils#log('cannot find custom config. use default.')
	return ovim#utils#load_default()
endfun
function ovim#utils#load_list(config_list) abort
    if type(a:config_list) == v:t_string
        return ovim#utils#load_config(a:config_list)
    endif
    let l:options = {}
    let l:options_path = []
	for i in a:config_list
        call add(l:options_path, i)
		if filereadable(i)
			let l:o = ovim#utils#load_config(i)
            call ovim#utils#recursive_update(l:options, l:o)
		endif
	endfor
    let l:options._option_path = l:options_path
    if len(l:options._option_path) == 0
        call ovim#utils#log('cannot find custom config. use default.')
        return ovim#utils#load_default()
    else
        return l:options
    endif
endfun

function ovim#utils#make_option_cache(path)
    let l:options = ovim#utils#load_list(g:ovim_global_options._option_path)
    let l:options._option_path = g:ovim_global_options._option_path
	call writefile([json_encode(l:options)], a:path)
endfunction

function ovim#utils#source(filename) abort
	exe 'source '.a:filename
endfun
function ovim#utils#try_source(filename) abort
	try
		exe 'source '.a:filename
	catch
		call ovim#utils#warn(v:errmsg,'-->',v:throwpoint)
	endtry
endfun

function s:toml2json(toml)
	if executable('rq')
		let l:cmd = 'rq --input-toml --output-json'
	elseif executable(expand(g:ovim_default_python_path))
		let l:cmd = expand(g:ovim_default_python_path).' -c "import json,toml,sys; t = toml.loads(sys.stdin.read()); print(json.dumps(t))" '
	elseif executable('python3')
		let l:cmd = 'python3 -c "import json,toml,sys; t = toml.loads(sys.stdin.read()); print(json.dumps(t))" '
	elseif executable('python')
		let l:cmd = 'python -c "import json,toml,sys; t = toml.loads(sys.stdin.read()); print(json.dumps(t))" '
	else
		throw "OvimError:0000: one of python3 toml or rq required!"
	endif
	return system(l:cmd,a:toml)
endfun


function ovim#utils#recursive_update(source,update)
    if empty(a:update) || type(a:update) != v:t_dict || type(a:source) != v:t_dict
       return
    endif
	for [k,v] in items(a:update)
		if !has_key(a:source,k) || type(v) != v:t_dict
			let a:source[k] = v
        else
			if type(a:source[k]) != v:t_dict
				let a:source[k] = {}
			endif
            call ovim#utils#recursive_update(a:source[k],v)
        endif
    endfor
endfunction

function ovim#utils#dein_sourced()
	let l:ps = dein#get()
	let l:count = 0
	let l:sourced = []
	for [k,v] in items(l:ps)
		if v.sourced
			let l:count += 1
			call add(l:sourced,v.name)
		endif
	endfor
	OvimLogInfo l:count len(l:ps)
	OvimLogInfo l:sourced
endfunction

function ovim#utils#copy(src,dst)
	if !filewritable(a:dst)
		if !isdirectory(fnamemodify(a:dst,":p:h"))
			silent! call mkdir(fnamemodify(a:dst,":p:h"), 'p')
		endif
		let l:str = readfile(a:src)
        call writefile(l:str,a:dst)
	endif
endfunction

function ovim#utils#copy_config()
	call ovim#utils#copy(g:ovim_root_path.'/config/default.toml',g:vim_path.'/config/custom.toml')
endfunction

function! ovim#utils#get_hightlight(group)
  let output = execute('hi ' . a:group)
  let list = split(output, '\s\+')
  let dict = {}
  for item in list
    if match(item, '=') > 0
      let splited = split(item, '=')
      let dict[substitute(splited[0],'\s\|\n','','')] = substitute(splited[1],'\s\|\n','','')
    endif
  endfor
  return dict
endfunction

function! ovim#utils#check_level(arg)
    return get(g:ovim_global_options,'config_level',10) < get(a:arg,'level',0) ? 0 : 1
endfunction

" check pass return 1.else return 0
function ovim#utils#check_level_and_enable(arg)
    if !ovim#utils#check_level(a:arg)
        \ || !get(a:arg,'enable',1)
        return 0
    endif
    return 1
endfunction

function ovim#utils#has_win()
    return has('win64') || has('win32') || has('win16') || has('win95')
endfunction
