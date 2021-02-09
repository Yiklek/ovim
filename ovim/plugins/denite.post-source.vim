autocmd FileType denite call s:denite_settings()
function! s:denite_settings() abort
	nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
	nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
	nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
	nnoremap <silent><buffer><expr> q denite#do_map('quit')
	nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
	nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
endfunction
autocmd FileType denite-filter call s:denite_filter_settings()
function! s:denite_filter_settings() abort
	imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
endfunction
let s:denite_options = {'default' : {
\ 'start_filter': 1,
\ 'auto_resize': 1,
\ 'prompt': 'λ ',
\ 'source_names': 'short',
\ 'floating_preview': 1,
\ 'highlight_matched_char': 'QuickFixLine',
\ 'highlight_matched_range': 'Visual',
\ 'highlight_window_background': 'Visual',
\ 'highlight_filter_background': 'DiffAdd',
\ 'statusline': 0,
\ }}
if has('nvim')
	let s:denite_options['default']['split'] = 'floating'
end
" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction
call s:profile(s:denite_options)
if executable('rg')
		call denite#custom#var('file/rec', 'command',
							\ ['rg', '--files', '--glob', '!.git', '--color', 'never'])
		call denite#custom#var('grep', {
							\ 'command': ['rg'],
							\ 'default_opts': ['-i', '--vimgrep', '--no-heading'],
							\ 'recursive_opts': [],
							\ 'pattern_opt': ['--regexp'],
							\ 'separator': ['--'],
							\ 'final_opts': [],
							\ })
endif