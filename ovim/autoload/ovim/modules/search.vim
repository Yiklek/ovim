

let s:self = ovim#modules#new() 

function ovim#modules#search#load(...) abort
    let s:self.name = 'search'
    let s:self.method = ['leaderf','ctrlp']
    if exists('a:1') && type(a:1) == v:t_dict
        for [k,v] in items(a:1)
               let s:self[k] = v
        endfor
    endif
    let g:ovim#modules#{s:self.name} = s:self
    return s:self
endfun

function s:self.plugins() abort
    
    let s:self.plugs = []
    for m in self.method

            call extend(self.plugs,s:method_plugins_{m}())

    endfor
    return s:self.plugs
endfun

function s:method_plugins_leaderf() abort
    return [{
\    "repo": "Yggdroot/LeaderF",
\    "hook_add": "source $OVIM_ROOT_PATH/plugins/leaderf.vim",
\    'on' : ['Leaderf','LeaderfFile','LeaderfBuffer',
\    'LeaderfBufferAll',"LeaderfMru","LeaderfMruCwd",
\    "LeaderfTag","LeaderfBufTag","LeaderfBufTagAll",
\    "LeaderfFunction","LeaderfFunctionAll"],
\    'on_cmd' : ['Leaderf','LeaderfFile','LeaderfBuffer',
\    'LeaderfBufferAll',"LeaderfMru","LeaderfMruCwd",
\    "LeaderfTag","LeaderfBufTag","LeaderfBufTagAll",
\    "LeaderfFunction","LeaderfFunctionAll"]
\        }]
endfun

function s:method_plugins_ctrlp() abort
    return [{
\    "repo" : "ctrlpvim/ctrlp.vim",
\    "hook_add" : "source $OVIM_ROOT_PATH/plugins/ctrlp.vim",
\    "on" : ["CtrlP","CtrlPFunky"],
\    "on_cmd" : ["CtrlP","CtrlPFunky"],
\    },
\    {"repo" : "tacahiroy/ctrlp-funky",
\       "on" : ["CtrlP","CtrlPFunky"],
\   "on_cmd" : ["CtrlP","CtrlPFunky"],}
\]
endfun


function s:self.config() abort
    
endfun