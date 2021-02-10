let g:dashboard_default_executive ="fzf"
let g:dashboard_session_directory = g:ovim_cacha_path.'/session'
let g:dashboard_fzf_window = 0
let g:dashboard_custom_shortcut = {}
let g:dashboard_custom_shortcut['last_session'] = '--->'
let g:dashboard_custom_shortcut['find_history'] = '--->'
let g:dashboard_custom_shortcut['find_file'] = '--->'
let g:dashboard_custom_shortcut['change_colorscheme'] = '--->'
let g:dashboard_custom_shortcut['new_file'] = '--->'
let g:dashboard_custom_shortcut['find_word'] = '--->'
let g:dashboard_custom_shortcut['book_marks'] = '--->'
let g:dashboard_custom_header = [
\ '',
\ ' ██████╗ ██╗   ██╗██╗███╗   ███╗',
\ '██╔═══██╗██║   ██║██║████╗ ████║',
\ '██║   ██║██║   ██║██║██╔████╔██║',
\ '██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║',
\ '╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║',
\ ' ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',
\ '',
\ ] 
autocmd VimLeavePre * if &ft !~? '^git' | SessionSave | endif
