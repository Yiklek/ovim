let g:vimspector_base_dir=g:ovim_cache_path."/vimspector-config"
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
        \  " ":[":execute 'normal \<Plug>VimspectorContinue'","VimspectorContinue"],
        \  "s":[":execute 'normal \<Plug>VimspectorStop'","VimspectorStop"],
        \  "r":[":execute 'normal \<Plug>VimspectorRestart'","VimspectorRestart"],
        \  "p":[":execute 'normal \<Plug>VimspectorPause'","VimspectorPause"],
        \  "b":[":execute 'normal \<Plug>VimspectorToggleBreakpoint'","VimspectorToggleBreakpoint"],
        \  "c":[":execute 'normal \<Plug>VimspectorToggleConditionalBreakpoint'","VimspectorToggleConditionalBreakpoint"],
        \  "f":[":execute 'normal \<Plug>VimspectorAddFunctionBreakpoint'","VimspectorAddFunctionBreakpoint"],
        \  "o":[":execute 'normal \<Plug>VimspectorStepOver'","VimspectorStepOver"],
        \  "i":[":execute 'normal \<Plug>VimspectorStepInto'","VimspectorStepInto"],
        \  "q":[":execute 'normal \<Plug>VimspectorStepOut'","VimspectorStepOut"],
        \  "g":[":execute 'normal \<Plug>VimspectorRunToCursor'","VimspectorRunToCursor"],
        \     }}}
call ovim#utils#recursive_update(g:leader_key_map,s:leader_key_map)
