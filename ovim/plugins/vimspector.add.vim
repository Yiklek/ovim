let g:vimspector_base_dir=g:ovim_cacha_path."/vimspector-config"
let g:vimspector_install_gadgets = [ "debugpy","vscode-cpptools" ]

nmap <leader>ed<space>   <Plug>VimspectorContinue
nmap <leader>eds   <Plug>VimspectorStop
nmap <leader>edr   <Plug>VimspectorRestart
nmap <leader>edp   <Plug>VimspectorPause
nmap <leader>edb   <Plug>VimspectorToggleBreakpoint
nmap <leader>edc   <Plug>VimspectorToggleConditionalBreakpoint
nmap <leader>edf   <Plug>VimspectorAddFunctionBreakpoint
nmap <leader>edo   <Plug>VimspectorStepOver
nmap <leader>edi   <Plug>VimspectorStepInto
nmap <leader>edq   <Plug>VimspectorStepOut
nmap <leader>edg   <Plug>VimspectorRunToCursor
let s:leader_key_map = {"e":{"d":{"name":"+Debug",
                                \  " ":"VimspectorContinue",
                                \  "s":"VimspectorStop",
                                \  "r":"VimspectorRestart",
                                \  "p":"VimspectorPause",
                                \  "b":"VimspectorToggleBreakpoint",
                                \  "c":"VimspectorToggleConditionalBreakpoint",
                                \  "f":"VimspectorAddFunctionBreakpoint",
                                \  "o":"VimspectorStepOver",
                                \  "i":"VimspectorStepInto",
                                \  "q":"VimspectorStepOut",
                                \  "g":"VimspectorRunToCursor",
                                \     }}}
call ovim#utils#recursive_update(g:leader_key_map,s:leader_key_map)