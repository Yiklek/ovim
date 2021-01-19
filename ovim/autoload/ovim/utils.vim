let g:ovim_keymap_order = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 
					\ 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 
					\ '1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
					\ 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 
					\ 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
					\ '!', '@', '#', '$', '%', '&', '&', '*', '(',')',]
" a:1 unite desc
" a:2 unite cmd
" a:3 guide desc
" example  call SpaceVim#mapping#def('nnoremap <silent>', 'gf', ':call SpaceVim#mapping#gf()<CR>', 'Jump to a file under cursor', '')
function! ovim#utils#keymap(type, key, value, ...) abort
    exe a:type .' '.a:key.' '.a:value
    " other operation
endfun

function ovim#utils#log(msg) abort
    let time = strftime('%H:%M:%S')
    let log = '[ovim] [' . time . '] ' . a:msg
    echom log
endfun

" 暂时使用json  后续支持toml yaml
function ovim#utils#load_config(filename) abort
    " Parse YAML/JSON config file fast than yaml
	let l:config_str = has('nvim') ? readfile(a:filename) : join(readfile(a:filename),"\n")
	if a:filename =~# '\.json$'
		" Parse JSON with built-in json_decode
		return json_decode(l:config_str) 
	" elseif a:filename =~# '\.ya\?ml$'
	" 	" Parse YAML with common command-line utilities
	" 	return s:load_yaml(a:filename)
	elseif a:filename =~# '\.toml$'
		return json_decode(s:toml2json(l:config_str))
	endif
	call ovim#utils#log('Unknown config file format ' . a:filename)
	return '' 
endfun

function ovim#utils#load_default() abort
	let l:default_suffix = ['json','toml']
	for i in l:default_suffix
		if filereadable(g:ovim_root_path.'/config/default.'.i)
			let l:r = ovim#utils#load_config(g:ovim_root_path.'/config/default.'.i)
			if i != 'json' && get(l:r,'make_json',0)
				call writefile([json_encode(l:r)],g:ovim_root_path.'/config/default.json')
			endif
			return r
		endif
	endfor
	throw 'OvimError: default config not found.'
endfun

function ovim#utils#load_custom() abort
	let l:default_suffix = ['json','toml']
	for i in l:default_suffix
		if filereadable(g:vim_path.'/config/custom.'.i)
			let l:r = ovim#utils#load_config(g:vim_path.'/config/custom.'.i)
			return r
		endif
	endfor
	return {}
endfun

function ovim#utils#source(filename) abort
	source a:filename
endfun

function s:toml2json(toml)
	if executable('rq')
		let l:cmd = 'rq --input-toml --output-json --format indented'
	elseif executable('python3')
		let l:cmd = 'python3 -c "import json,toml,sys; t = toml.loads(sys.stdin.read()); print(json.dumps(t))" '
	else
		throw "OvimError:0000: one of python3 or rq required!"
	endif
	return system(l:cmd,a:toml)
endfun
