
" LeaderF {{{
let g:Lf_ShortcutF = '<leader>ff'
let g:Lf_ShortcutB = '<m-n>'
noremap <leader>fm :LeaderfMru<cr>
noremap <leader>fc :LeaderfFunction!<cr>
noremap <leader>fb :LeaderfBuffer<cr>
noremap <leader>ft :LeaderfTag<cr>
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 0
let g:Lf_StlColorscheme = 'powerline'
" }}}
