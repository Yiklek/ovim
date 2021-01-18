
"ycm {{{
"keymaps:
"直接触发自动补全
let g:ycm_key_invoke_completion = '<leader><tab>'
" 跳转定义
" nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
"补全后自动关机预览窗口"
let g:ycm_autoclose_preview_window_after_completion=1
"python解释器路径"
let g:ycm_path_to_python_interpreter=g:python_interpreter
let g:ycm_server_python_interpreter=g:python_interpreter
"let g:ycm_python_interpreter_path=g:python_interpreter
""是否开启语义补全"
let g:ycm_seed_identifiers_with_syntax=1
"是否在注释中也开启补全"
"let g:ycm_complete_in_comments=1
"let g:ycm_collect_identifiers_from_comments_and_strings = 0
""开始补全的字符数"
" let g:ycm_auto_trigger=0
let g:ycm_min_num_of_chars_for_completion=2
let g:ycm_cache_omnifunc=0
" 跳转到定义处, 分屏打开
" let g:ycm_goto_buffer_command = 'horizontal-split'
let g:ycm_confirm_extra_conf = 1
" 引入，可以补全系统，以及python的第三方包 针对新老版本YCM做了兼容
" old version
if !empty(glob(g:dotvimd."/plugged/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py"))
    let g:ycm_global_ycm_extra_conf = g:dotvimd."/plugged/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py"
endif
" new version
if !empty(glob(g:dotvimd."/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"))
    let g:ycm_global_ycm_extra_conf = g:dotvimd."/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
endif
if filereadable('~/.ycm_extra_conf.py')
    let g:ycm_global_ycm_extra_conf = "~/.ycm_extra_conf.py"
endif
"autocmd FileType cpp let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
"autocmd FileType c let g:ycm_global_ycm_extra_conf = "~/.ycm_extra_conf_c.py"
" }}}
