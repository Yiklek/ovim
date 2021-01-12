
" LeaderF {{{
call extend(g:leader_key_map.f,{' ':[':LeaderfFile','LeaderfFile'],
                                \ 'm':[':LeaderfMru','LeaderfMru'],
                                \ 'c':[':LeaderfFunction','LeaderfFunction'],
                                \ 'b':[':LeaderfBuffer','LeaderfBuffer'],
                                \ 't':[':LeaderfTag','LeaderfTag'],
                                \ })
let g:Lf_ShortcutF = '<leader>f<space>'
let g:Lf_ShortcutB = '<m-n>'
noremap <leader>f<space> :LeaderfFile<cr>
noremap <leader>fm :LeaderfMru<cr>
noremap <leader>fc :LeaderfFunction!<cr>
noremap <leader>fb :LeaderfBuffer<cr>
noremap <leader>ft :LeaderfTag<cr>
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.3
let g:Lf_PopupHeight = 0.8
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 0
let g:Lf_StlColorscheme = 'powerline'
" }}}
