" File: search.vim
" Author: Yiklek
" Description: module fuzzy seach
" Last Modified: 二月 09, 2021
" Copyright (c) 2021 Yiklek

" require rg fzf

let s:self = ovim#modules#new()

function ovim#modules#search#load(...) abort
    if get(s:self,'loaded',0)
        return s:self
    endif
    let s:self.name = 'search'
    let s:self.method = ['leaderf','ctrlp']
    if exists('a:1') && type(a:1) == v:t_dict
        for [k,v] in items(a:1)
               let s:self[k] = v
        endfor
    endif
    let s:self.loaded = 1
    let g:ovim#modules#{s:self.name} = s:self
    return s:self
endfun

function s:self.plugins() abort

    let s:self.plugs = {}
    for m in self.method

            call extend(self.plugs,s:method_plugins_{m}())

    endfor
    return s:self.plugs
endfun



" require rg for Leaderf rg
let s:leader_cmds = ["LeaderfFile",
\ "LeaderfBuffer",
\ "LeaderfBufferAll",
\ "LeaderfMru",
\ "LeaderfMruCwd",
\ "LeaderfTag",
\ "LeaderfBufTag",
\ "LeaderfBufTagAll",
\ "LeaderfFunction",
\ "LeaderfFunctionAll",
\ "LeaderfLine",
\ "LeaderfLineAll",
\ "LeaderfHistoryCmd",
\ "LeaderfHistorySearch",
\ "LeaderfSelf",
\ "LeaderfHelp",
\ "LeaderfColorscheme",
\ "LeaderfFiletype",
\ "LeaderfCommand",
\ "LeaderfWindow",
\ "LeaderfQuickFix",
\ "LeaderfLocList",
\ "LeaderfRgInteractive",
\ "LeaderfRgRecall",
\ "Leaderf"]
function s:method_plugins_leaderf() abort
    return {'Yggdroot/LeaderF':{
\    "repo": "Yggdroot/LeaderF",
\    "hook_add": "source $OVIM_ROOT_PATH/plugins/leaderf.vim",
\    'on' : s:leader_cmds,
\    'on_cmd' : s:leader_cmds,
\    "on_func" : ['leaderf#Any#start']
\        }}
endfun


let s:ctrlp_cmds = [ "CtrlP",
\ "CtrlPBuffer",
\ "CtrlPCurFile",
\ "CtrlPCurWD",
\ "CtrlPMRU",
\ "CtrlPLastMode",
\ "CtrlPRoot",
\ "CtrlPClearCache",
\ "CtrlPClearAllCaches",]
function s:method_plugins_ctrlp() abort
    return {'ctrlpvim/ctrlp.vim':{
\    "repo" : "ctrlpvim/ctrlp.vim",
\    "hook_add" : "source $OVIM_ROOT_PATH/plugins/ctrlp.vim",
\    "on" : s:ctrlp_cmds,
\    "on_cmd" : s:ctrlp_cmds,
\    },
\    "tacahiroy/ctrlp-funky":{"repo" : "tacahiroy/ctrlp-funky",
\       "on" : ['CtrlPFunky'],
\   "on_cmd" : ['CtrlPFunky'],}
\}
endfun
" require fzf
let s:fzf_cmds = ["Files",'GFiles','Buffers','Colors','Ag','Rg','Lines','BLines',
\    'Tags','BTags','Marks','Windows','Locate','History',
\    'Snippets','Commits','BCommits','Commands','Maps','Helptags','Filetypes']
function s:method_plugins_fzf() abort
    return {'junegunn/fzf':{
\    "repo" : "junegunn/fzf",
\    "on" : s:fzf_cmds,
\    "on_cmd" : s:fzf_cmds,
\    "on_func" :['fzf#run'],
\    },'junegunn/fzf.vim':{
\    "repo" : "junegunn/fzf.vim",
\    "on" : s:fzf_cmds,
\    "on_source" : ['fzf'],
\    "on_func" :['fzf#run','fzf#vim#'],
\    },
\}
endfun
let s:denite_cmds = ["Denite"]
function s:method_plugins_denite() abort
    return {'Shougo/denite.nvim':{
\    "repo" : "Shougo/denite.nvim",
\    "on_cmd" : s:denite_cmds,
\    "hook_source": "source $OVIM_ROOT_PATH/plugins/denite.post-source.vim"
\    },
\}
endfun

let s:far_cmds = ["Far","F","Farr","Farf","Fardo","Farundo","Refar"]
function s:method_plugins_far() abort
    return {"brooth/far.vim":{
\    "repo" : "brooth/far.vim",
\    "on" : s:far_cmds,
\    "on_cmd" : s:far_cmds,
\    },
\}
endfun
function s:self.config() abort
    "todo config
    let g:leader_key_map[self.leader_prefix] = get(g:leader_key_map,self.leader_prefix,{'name':'+Search'})
    for m in self.method
        call s:config_{m}()
    endfor
endfun

function s:config_fzf()
    let g:leader_key_map[s:self.leader_prefix].f = {"name":"+fzf"," ":[":Files","Files"]}
    exe "nnoremap <leader>".s:self.leader_prefix."f<space> :Files<CR>"

    let g:space_key_map.fzf = [":FZF","fzf"]
    nnoremap fzf :Files<CR>
    nnoremap <space>fzf :Files<CR>

    let g:space_key_map.ffr = [":Rg","Rg"]
    nnoremap ffr :Rg<CR>
    nnoremap <space>ffr :Rg<CR>

    call s:keymap_list("f",s:fzf_cmds)
endfunction

function s:config_leaderf()
    let g:space_key_map.flf = [":Leaderf file","LeaderfFile"]
    nnoremap flf :LeaderfFile<CR>
    nnoremap <space>flf :LeaderfFile<CR>

    let g:space_key_map.flr = [":Leaderf rg","LeaderfRg"]
    nnoremap flr :Leaderf rg<CR>
    nnoremap <space>flr :Leaderf rg<CR>

    let g:leader_key_map[s:self.leader_prefix].l = {"name":"+Leaderf"," ":[":LeaderfFile","LeaderfFile"]}
    exe "nnoremap <leader>".s:self.leader_prefix."l<space> :LeaderfFile<CR>"
    call s:keymap_list("l",s:leader_cmds)
endfunction
function s:config_ctrlp()
    let g:leader_key_map[s:self.leader_prefix].p = {"name":"+CtrlP"," ":[":CtrlP","CtrlP"]}
    exe "nnoremap <leader>".s:self.leader_prefix."p<space> :CtrlP<CR>"
    let g:leader_key_map[s:self.leader_prefix].p["J"] = ['execute("CtrlPFunky " . expand("<cword>"))',"CtrlPFunky Word"]
    exe "nnoremap <leader>".s:self.leader_prefix.'pJ :execute "CtrlPFunky " . expand("<cword>")<CR>'
    call s:keymap_list("p",add(deepcopy(s:ctrlp_cmds),"CtrlPFunky"))
endfunction
function s:config_far()
endfunction
function s:config_denite()

endfunction
function s:keymap_list(key,map_list)
    let l:index = 0
    let l:len = len(a:map_list)
    while l:index < l:len && l:index < len(g:ovim_keymap_order)
        exe "nnoremap <leader>".s:self.leader_prefix."".a:key."".g:ovim_keymap_order[l:index]." :".a:map_list[l:index]."<CR>"
        let g:leader_key_map[s:self.leader_prefix][a:key][g:ovim_keymap_order[l:index]] =  [":".a:map_list[l:index],a:map_list[l:index]]
        let l:index = l:index + 1
    endwhile
endfun
