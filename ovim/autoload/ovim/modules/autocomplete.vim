" File: autocomplete.vim
" Author: Yiklek
" Description: module autocomplete
" Last Modified: 02 10, 2021
" Copyright (c) 2021 Yiklek


let s:self = ovim#modules#new()

function ovim#modules#autocomplete#load(...) abort
    if get(s:self,'loaded',0)
        return s:self
    endif
    let s:self.name = 'autocomplete'
    let s:self.method = 'auto'
    if exists('a:1') && type(a:1) == v:t_dict
        for [k,v] in items(a:1)
            if k !=# 'name'
               let s:self[k] = v
            endif
        endfor
    endif
    if s:self.method ==# 'auto'
      " if has node,use coc
      if ovim#utils#check_lua()
        let s:self.method = 'nvim_cmp'
      elseif executable('node')
        let s:self.method = 'coc'
      else
        let s:self.method = 'ncm2'
      endif
    endif
    let s:self.loaded = 1
    let g:ovim#modules#{s:self.name} = s:self
    return s:self
endfun

function s:self.plugins() abort
    let s:self.plugs = {}
    call s:plugins_{s:self.method}()
    return s:self.plugs
endfun

function s:plugins_coc()
  let s:self.plugs['neoclide/coc.nvim'] = {"repo": "neoclide/coc.nvim",
                        \ "rev": "release","branch": "release",
                        \ "hook_source":"source $OVIM_ROOT_PATH/plugins/coc.source.vim",
                        \ "on_event":["VimEnter"]
                        \}
    " disable defx
    let l:disable_list = ["Shougo/defx.nvim","kristijanhusak/defx-git","kristijanhusak/defx-icons",
                        \ ]
    call ovim#plugin#disable(l:disable_list)
endfunction

function s:plugins_deoplete()
        let s:self.plugs['Shougo/deoplete.nvim'] = {
    \        "repo": "Shougo/deoplete.nvim",
    \        "do": ":UpdateRemotePlugins",
    \        "on_event":["VimEnter"],
    \        "hook_post_source":"source $OVIM_ROOT_PATH/plugins/complete-deoplete.vim"
    \    }
        let s:self.plugs['Shougo/neco-vim'] = { "repo": "Shougo/neco-vim","ft":"vim",'on_source':'deoplete.nvim'}
endfunction

function s:plugins_nvim_cmp()
    if executable('node')
        call s:plugins_coc()
    endif
endfunction

function s:plugins_ncm2()
    let s:self.plugs['ncm2/ncm2'] = {
    \        "repo": "ncm2/ncm2",
    \        "do": ":UpdateRemotePlugins",
    \        "on_event":["VimEnter"],
    \        "hook_post_source":"source $OVIM_ROOT_PATH/plugins/complete-ncm2.post-source.vim"
    \    }
    let s:self.plugs['ncm2/ncm2-bufword'] = {
    \        "repo": "ncm2/ncm2-bufword",
    \        "do": ":UpdateRemotePlugins",
    \        "on_event":["VimEnter"],
    \    }
    let s:self.plugs['ncm2/ncm2-path'] = {
    \        "repo": "ncm2/ncm2-path",
    \        "do": ":UpdateRemotePlugins",
    \        "on_event":["VimEnter"],
    \    }
    let s:self.plugs['ncm2/ncm2-vim'] = {
    \        "repo": "ncm2/ncm2-vim",
    \        "do": ":UpdateRemotePlugins",
    \        "on_event":["VimEnter"],
    \    }
    let s:self.plugs['Shougo/neco-vim'] = { "repo": "Shougo/neco-vim","ft":"vim",'on_source':'ncm2-vim'}
    let s:self.plugs['ncm2/ncm2-ultisnips'] = {
    \        "repo": "ncm2/ncm2-ultisnips",
    \        "do": ":UpdateRemotePlugins",
    \        "on_event":["VimEnter"],
    \    }
    let l:enable_list = ["roxma/nvim-yarp","roxma/vim-hug-neovim-rpc"]
    call ovim#plugin#enable(l:enable_list)
endfunction

function s:plugins_ycm()
  let s:self.plugs['Valloric/YouCompleteMe'] = {
    \        "repo": "Valloric/YouCompleteMe",
    \        "on_event":["VimEnter","GUIEnter"],
    \        "hook_source":"source $OVIM_ROOT_PATH/plugins/complete-youcompleteme.vim"
    \    }
endfunction

function s:self.config() abort
    if s:self.method != 'ycm'
        autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
        set completeopt-=preview
        inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
        inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

        inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
        inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"

        inoremap <expr> <CR> pumvisible() ?  "\<C-y>" : "\<CR>"

        call s:config_{s:self.method}()
        " ycm 仅由hook配置
        if s:self.method != 'ycm'
            inoremap <silent><expr> <leader><TAB>
                            \ pumvisible() ? "\<C-n>" :
                            \ <SID>check_back_space() ? "\<TAB>" : g:ovim#modules#autocomplete.func_manual()
            let g:leader_key_map["<TAB>"] = [":call g:ovim#modules#autocomplete#func_manual()","Trigger Complete(Insert Mode)"]
        endif
    endif
endfun

function s:config_coc()
    let g:ovim#modules#autocomplete.func_manual = function('coc#refresh')
endfunction

function s:config_deoplete()
    let g:ovim#modules#autocomplete.func_manual = function('deoplete#manual_complete')
endfunction

function s:config_ncm2()
    let g:ovim#modules#autocomplete.func_manual = function('ncm2#force_trigger')
endfunction

function s:config_nvim_cmp()
endfunction

function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction
"}}}
