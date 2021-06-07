" File: ime.vim
" Author: Yiklek
" Description: input method engine
" Last Modified: 06 06, 2021
" Copyright (c) 2021 ovim

let s:self = ovim#modules#new()

function ovim#modules#ime#load(...) abort
    if get(s:self,'loaded',0)
        return s:self
    endif
    let s:self.name = 'ime'
    if exists('a:1') && type(a:1) == v:t_dict
        for [k,v] in items(a:1)
            if k !=# 'name'
               let s:self[k] = v
            endif
        endfor
    endif

    if s:self.method ==# 'auto'
        let s:self.method = ["openfly","pinyin"]    
    endif
    let s:self.loaded = 1
    let g:ovim#modules#{s:self.name} = s:self
    return s:self
endfun

function s:self.plugins() abort
    let s:self.plugs = {}
    call s:plugins_base()
    for m in self.method
        call extend(self.plugs,s:method_plugins_{m}())
    endfor
    return s:self.plugs
endfun

function s:plugins_base()
  let s:self.plugs['ZSaberLv0/ZFVimIM'] = { "repo": "ZSaberLv0/ZFVimIM",
                                \    "on_event":["VimEnter"],
                                \    "hook_post_source":"nnoremap <expr><silent> ;' ZFVimIME_keymap_next_n()\ninoremap <expr><silent> ;' ZFVimIME_keymap_next_i()\nvnoremap <expr><silent> ;' ZFVimIME_keymap_next_v()",
                                \    "hook_source":"let g:ZFVimIM_cloudAsync_enable = 1\nlet g:ZFVimIM_cloudSync_enable = 0\nlet g:ZFVimIM_cachePath = g:ovim_cacha_path . '/ZFVimIM'",
                                \    }
  let s:self.plugs['ZSaberLv0/ZFVimJob'] = { "repo": "ZSaberLv0/ZFVimJob",
                                \    "on_event":["VimEnter"],
                                \    }
endfunction
" 全拼输入法
function s:method_plugins_pinyin()
  return {"ZSaberLv0/ZFVimIM_pinyin_base":{ "repo": "ZSaberLv0/ZFVimIM_pinyin_base",
        \                                   "on_event":["VimEnter"],},
        \ "ZSaberLv0/ZFVimIM_openapi": {"repo": "ZSaberLv0/ZFVimIM_openapi","on_event":["VimEnter"]}
        \ }
endfunction

" 小鹤双拼输入法
function s:method_plugins_openfly()
  return {"Yiklek/ZFVimIM_openfly":{ "repo": "Yiklek/ZFVimIM_openfly",
        \                                   "on_event":["VimEnter"],},
        \ }
endfunction

function s:self.config() abort
endfun

