
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
    let log = '[ ' . self.name . ' ] [' . time . '] ' . a:msg
    echom log
endfun

" 暂时使用json  后续支持toml yaml
function ovim#utils#load_config(filename) abort
    " Parse YAML/JSON config file
	let l:config_str = has('nvim') ? readfile(a:filename) : join(readfile(a:filename),"\n")
	if a:filename =~# '\.json$'
		" Parse JSON with built-in json_decode
		return json_decode(l:config_str) 
	" elseif a:filename =~# '\.ya\?ml$'
	" 	" Parse YAML with common command-line utilities
	" 	return s:load_yaml(a:filename)
	elseif a:filename =~# '\.toml$'
		let l:cmd = 'python3 -c "import json,toml,sys; t = toml.loads(sys.stdin.read()); print(json.dumps(t))" '
		return json_decode(system(l:cmd,l:config_str))
	endif
	call ovim#utils#log('Unknown config file format ' . a:filename)
	return '' 
endfun

function ovim#utils#load_default() abort
	return ovim#utils#load_config(g:ovim_root_path.'/config/default.toml')
endfun

function ovim#utils#source(filename) abort
	source a:filename
endfun