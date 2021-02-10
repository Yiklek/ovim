" File: autocomplete.vim
" Author: Yiklek
" Description: module autocomplete
" Last Modified: 02 10, 2021
" Copyright (c) 2021 Yiklek


let s:self = ovim#modules#new()

function ovim#modules#autocomplete#load(...) abort
    let s:self.name = 'autocomplete'
    let s:self.method = 'auto'
    if exists('a:1') && type(a:1) == v:t_dict
        for [k,v] in items(a:1)
            if k !=# 'name'
               let s:self[k] = v
            endif
        endfor
    endif
    let g:ovim#modules#{s:self.name} = s:self
    return s:self
endfun

function s:self.plugins() abort
    if s:self.method ==# 'auto'
      " if has node,use coc
      if executable('node')
        let s:self.method = 'coc'
      else
        let s:self.method = 'ncm2'
      endif
    endif
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
    let l:disable_list = ["Shougo/defx.nvim","kristijanhusak/defx-git","kristijanhusak/defx-icons"]
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
    call s:plugins_lcn()
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
    call s:plugins_lcn()
endfunction

function s:plugins_ycm()
  let s:self.plugs['Valloric/YouCompleteMe'] = {
    \        "repo": "Valloric/YouCompleteMe",
    \        "on_event":["VimEnter","GUIEnter"],
    \        "hook_source":"source $OVIM_ROOT_PATH/plugins/complete-youcompleteme.vim"
    \    }
endfunction

function s:plugins_lcn()
  let s:self.plugs['autozimu/LanguageClient-neovim'] = { "repo": "autozimu/LanguageClient-neovim","do":"bash install.sh",
                                \    "build":"sh -c 'bash install.sh'","rev":"next","branch": "next",
                                \    "on_event":["VimEnter"],
                                \    "hook_source":"source $OVIM_ROOT_PATH/plugins/languageclient.vim",
                                \    "hook_post_update":"bash install.sh"
                                \    }
endfunction

function s:self.config() abort
    set completeopt-=preview
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

    inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
    inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"

    inoremap <expr> <CR> pumvisible() ?  "\<C-y>" : "\<CR>"

    call s:config_{s:self.method}()

    if s:self.method != 'ycm'
        inoremap <silent><expr> <leader><TAB>
                        \ pumvisible() ? "\<C-n>" :
                        \ <SID>check_back_space() ? "\<TAB>" : g:ovim#modules#autocomplete.func_manual()

        nnoremap <leader>g<space> <esc>:call ovim#modules#autocomplete.func_show_doc()<cr>
        nnoremap <leader>gd <esc>:call ovim#modules#autocomplete.func_go_to_def()<cr>
        nnoremap <leader>gt <esc>:call ovim#modules#autocomplete.func_go_to_typedef()<cr>
        nnoremap <leader>gi <esc>:call ovim#modules#autocomplete.func_go_to_impl()<cr>
        nnoremap <leader>gn <esc>:call ovim#modules#autocomplete.func_rename()<cr>
        nnoremap <leader>gu <esc>:call ovim#modules#autocomplete.func_references()<cr>
        nnoremap <leader>gc <esc>:call ovim#modules#autocomplete.func_go_to_declaration()<cr>
        nnoremap <leader>gs <esc>:call ovim#modules#autocomplete.func_document_symbol()<cr>
        nnoremap <leader>gr <esc>:call ovim#modules#autocomplete.func_refactor()<cr>
        nnoremap <leader>gf <esc>:call ovim#modules#autocomplete.func_format()<cr>
        let l:leader_key_map = {'g':{'name':'LSP',' ':[':call ovim#modules#autocomplete.func_show_doc()','Doc'],
                                                \ 'd':[':call ovim#modules#autocomplete.func_go_to_def()','Define'],
                                                \ 't':[':call ovim#modules#autocomplete.func_go_to_typedef()','Type Define'],
                                                \ 'i':[':call ovim#modules#autocomplete.func_go_to_impl()','Impl'],
                                                \ 'n':[':call ovim#modules#autocomplete.func_rename()','Rename'],
                                                \ 'u':[':call ovim#modules#autocomplete.func_references()','References'],
                                                \ 'c':[':call ovim#modules#autocomplete.func_go_to_declaration()','Declaration'],
                                                \ 's':[':call ovim#modules#autocomplete.func_document_symbol()','Doc Symbol'],
                                                \ 'r':[':call ovim#modules#autocomplete.func_refactor()','Refactor'],
                                                \ 'f':[':call ovim#modules#autocomplete.func_format()','Format'],
                              \ }}
        call ovim#utils#recursive_update(g:leader_key_map,l:leader_key_map)
    endif
    " 不懂为什么这里还要设置路径
    " set pythonthreehome=~/miniconda3/envs/vim/
    "set pyxversion=3
    "离开插入模式后自动关闭预览窗口"
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
    call ovim#utils#recursive_update(g:leader_key_map,{'<tab>':'Trigger Complete(Insert Mode)'})
endfun

function s:config_coc()
    function! g:ovim#modules#autocomplete.func_show_doc() abort
      call CocActionAsync('doHover')
    endfunction

    function! g:ovim#modules#autocomplete.func_go_to_def() abort
      call CocActionAsync('jumpDefinition')
    endfunction

    function! g:ovim#modules#autocomplete.func_go_to_declaration() abort
      call CocActionAsync('jumpDeclaration')
    endfunction

    function! g:ovim#modules#autocomplete.func_go_to_typedef() abort
      call CocActionAsync('jumpTypeDefinition')
    endfunction

    function! g:ovim#modules#autocomplete.func_go_to_impl() abort
      call CocActionAsync('jumpImplementation')
    endfunction

    function! g:ovim#modules#autocomplete.func_refactor() abort
      call CocActionAsync('refactor')
    endfunction

    function! g:ovim#modules#autocomplete.func_rename() abort
      call CocActionAsync('rename')
    endfunction

    function! g:ovim#modules#autocomplete.func_references() abort
      call CocActionAsync('jumpReferences')
    endfunction
    function! g:ovim#modules#autocomplete.func_format() abort
      call CocActionAsync('format')
    endfunction
    let g:ovim#modules#autocomplete.func_manual = function('coc#refresh')
endfunction

function s:config_deoplete()
    let g:ovim#modules#autocomplete.func_manual = function('deoplete#manual_complete')
    call s:config_lcn()
endfunction

function s:config_ncm2()
    let g:ovim#modules#autocomplete.func_manual = function('ncm2#force_trigger')
    call s:config_lcn()
endfunction

function s:config_lcn()
    let g:ovim#modules#autocomplete.func_show_doc = function('LanguageClient#textDocument_hover')
    let g:ovim#modules#autocomplete.func_go_to_def = function('LanguageClient#textDocument_definition')
    let g:ovim#modules#autocomplete.func_go_to_typedef = function('LanguageClient#textDocument_typeDefinition')
    let g:ovim#modules#autocomplete.func_go_to_impl = function('LanguageClient#textDocument_implementation')
    let g:ovim#modules#autocomplete.func_rename = function('LanguageClient#textDocument_rename')
    let g:ovim#modules#autocomplete.func_references = function('LanguageClient#textDocument_references')
    let g:ovim#modules#autocomplete.func_go_to_declaration = function('LanguageClient#textDocument_declaration')
    let g:ovim#modules#autocomplete.func_document_symbol = function('LanguageClient#textDocument_documentSymbol')
    let g:ovim#modules#autocomplete.func_refactor = function('empty')
    let g:ovim#modules#autocomplete.func_format = function('LanguageClient#textDocument_formatting')
endfunction

function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
