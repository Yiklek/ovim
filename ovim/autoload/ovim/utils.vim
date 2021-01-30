let g:ovim_keymap_order = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k',
					\ 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
					\ '1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
					\ 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K',
					\ 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
					\ '!', '@', '#', '$', '%', '&', '&', '*', '(',')',]
let s:ovim_config_suffix = ['json','toml']
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
    let log = '[ovim] [' . time . '] [info]:' . l:msg
    echom log
endfun
function ovim#utils#warning(...) abort
    let time = strftime('%H:%M:%S')
    let l:msg = join(a:000,' ')
    let log = '[ovim] [' . time . '] [warning]:' . l:msg
	echohl WarningMsg
    echom log
	echohl None
endfun


" 暂时使用json  后续支持toml yaml
function ovim#utils#load_config(filename) abort
	let l:filename = expand(a:filename)
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
		if filereadable(g:ovim_root_path.'/config/default.'.i)
			let l:r = ovim#utils#load_config(g:ovim_root_path.'/config/default.'.i)
			if i != 'json' && get(l:r,'make_json',0)
				call writefile([json_encode(l:r)],g:ovim_root_path.'/config/default.json')
			endif
			return r
		endif
	endfor
	throw 'OvimError:0001: default config not found.'
endfun

function ovim#utils#load_custom() abort
	for i in s:ovim_config_suffix
		if filereadable(g:vim_path.'/config/custom.'.i)
			let l:r = ovim#utils#load_config(g:vim_path.'/config/custom.'.i)
			if i != 'json' && get(l:r,'make_json',0)
				call writefile([json_encode(l:r)],g:vim_path.'/config/custom.json')
			endif
			return r
		endif
	endfor
	call ovim#utils#log('cannot find custom config. use default.')
	return ovim#utils#load_default()
endfun

function ovim#utils#source(filename) abort
	exe 'source '.a:filename
endfun

function s:toml2json(toml)
	if executable('rq')
		let l:cmd = 'rq --input-toml --output-json --format indented'
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
	echo l:count len(l:ps)
	echo l:sourced
endfunction

function ovim#utils#copy_config()
	if !filewritable(g:vim_path.'/config/custom.toml')
		if !isdirectory(g:vim_path.'/config')
			silent! call mkdir(g:vim_path.'/config', 'p')
		endif
		let l:config_str = readfile(g:ovim_root_path.'/config/default.toml')
        call writefile(l:config_str,g:vim_path.'/config/custom.toml')
	endif
endfunction
