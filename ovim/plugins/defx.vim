
" defx{{{

nmap <silent> = :Defx<CR>
call ovim#utils#recursive_update(g:space_key_map,{'=':[':Defx','defx']})
call defx#custom#option('_', {
      \ 'winwidth': 40,
      \ 'split': 'vertical',
      \ 'show_ignored_files': 0,
      \ 'direction':'topleft',
      \ 'buffer_name': '',
      \ 'toggle': 1,
      \ 'resume': 1,
      \ 'columns':'git:mark:indent:icons:filename:type:size:time'
      \ })
" Avoid the white space highting issue
if !has('nvim')
      autocmd FileType defx match ExtraWhitespace /^^/
endif
" Keymap in defx
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
    setl nonumber
    setl norelativenumber
    setl listchars=
    setl timeoutlen=1000
    " Define mappings
    nnoremap <silent><buffer><expr> <CR> defx#do_action('drop','edit')
    nnoremap <silent><buffer><expr> yy defx#do_action('multi',['copy','yank_path'])
    nnoremap <silent><buffer><expr> dd defx#do_action('move')
    nnoremap <silent><buffer><expr> pp defx#do_action('paste')
    nnoremap <silent><buffer><expr> l defx#do_action('open')
    nnoremap <silent><buffer><expr> v defx#do_action('open', 'vsplit')
    nnoremap <silent><buffer><expr> s defx#do_action('drop', 'split')
    nnoremap <silent><buffer><expr> \ defx#do_action('open', 'vsplit')
    nnoremap <silent><buffer><expr> - defx#do_action('drop', 'split')
    nnoremap <silent><buffer><expr> t defx#do_action('drop', 'tabe')
    nnoremap <silent><buffer><expr> o defx#do_action('open_tree')
    nnoremap <silent><buffer><expr> O defx#do_action('open_tree_recursive')
    nnoremap <silent><buffer><expr> l defx#do_action('open_or_close_tree')
    nnoremap <silent><buffer><expr> K defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> e defx#do_action('new_file')
    nnoremap <silent><buffer><expr> ed defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> E defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr> C defx#do_action('toggle_columns', 'git:mark:indent:filename:type:size:time')
    nnoremap <silent><buffer><expr> S defx#do_action('toggle_sort', 'time')
    nnoremap <silent><buffer><expr> dD defx#do_action('remove')
    nnoremap <silent><buffer><expr> r defx#do_action('rename')
    nnoremap <silent><buffer><expr> cw defx#do_action('rename')
    nnoremap <silent><buffer><expr> ! defx#do_action('execute_command')
    nnoremap <silent><buffer><expr> x defx#do_action('execute_system')
    nnoremap <silent><buffer><expr> yp defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> .  defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> <c-h>  defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> <bs>  defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> ;  defx#do_action('repeat')
    nnoremap <silent><buffer><expr> h  defx#is_opened_tree() ? defx#do_action('close_tree') :defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> ~  defx#do_action('cd')
    nnoremap <silent><buffer><expr> q  defx#do_action('quit')
    nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select')
    nnoremap <silent><buffer><expr> v  defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> j  line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k  line('.') == 1 ? 'G' : 'k'
    nnoremap <silent><buffer><expr> R  defx#do_action('redraw')
    nnoremap <silent><buffer><expr> <C-g>  defx#do_action('print')
    nnoremap <silent><buffer><expr> cd  defx#do_action('change_vim_cwd')

	call defx#custom#column('mark', {
	      \ 'readonly_icon': '✗',
	      \ 'selected_icon': '✓',
	      \ })

endfunction

" Defx git
call defx#custom#column('git', 'indicators', {
  \ 'Modified'  : '✹',
  \ 'Staged'    : '✚',
  \ 'Untracked' : '✭',
  \ 'Renamed'   : '➜',
  \ 'Unmerged'  : '═',
  \ 'Ignored'   : '☒',
  \ 'Deleted'   : '✖',
  \ 'Unknown'   : '?'
  \ })
let g:defx_git#column_length = 0
hi def link Defx_filename_directory NERDTreeDirSlash
hi def link Defx_git_Modified Special
hi def link Defx_git_Staged Function
hi def link Defx_git_Renamed Title
hi def link Defx_git_Unmerged Label
hi def link Defx_git_Untracked Tag
hi def link Defx_git_Ignored Comment
" Defx icons
let g:defx_icons_enable_syntax_highlight = 1
" }}}
