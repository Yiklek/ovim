" File: lsp.vim
" Author: Yiklek
" Description: module lsp
" Last Modified: 02 14, 2021
" Copyright (c) 2021 Yiklek


let s:self = ovim#modules#new()

function ovim#modules#lsp#load(...) abort
    if get(s:self,'loaded',0)
        return s:self
    endif
    let s:self.name = 'lsp'
    let s:self.method = "auto"
    if exists('a:1') && type(a:1) == v:t_dict
        for [k,v] in items(a:1)
            if k !=# 'name'
               let s:self[k] = v
            endif
        endfor
    endif

    if s:self.method ==# 'auto' && exists('g:ovim_global_options.modules.autocomplete')
            \ && ovim#utils#check_level_and_enable(g:ovim_global_options.modules.autocomplete)
        let l:autocomplete_config = ovim#modules#load('autocomplete',g:ovim_global_options.modules.autocomplete)
        let s:self.method = l:autocomplete_config.method ==# "nvim_cmp" ? "nvim_lsp" :
                                            \ l:autocomplete_config.method ==# "coc" ? "coc" : "lcn"
    else
        call ovim#utils#warn("can't auto select lsp from autocomplete module.")
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
    " plugins have been specified in autocomplete module
endfunction

function s:plugins_nvim_lsp()
    " plugins have been specified in autocomplete module
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
    call s:config_{s:self.method}()
    if s:self.method != "nvim_lsp"
        nnoremap <leader>g<space>    <esc>:call g:ovim#modules#lsp.func_show_doc()<cr>
        nnoremap <leader>gd          <esc>:call g:ovim#modules#lsp.func_go_to_def()<cr>
        nnoremap <leader>gt          <esc>:call g:ovim#modules#lsp.func_go_to_typedef()<cr>
        nnoremap <leader>gi          <esc>:call g:ovim#modules#lsp.func_go_to_impl()<cr>
        nnoremap <leader>gn          <esc>:call g:ovim#modules#lsp.func_rename()<cr>
        nnoremap <leader>gu          <esc>:call g:ovim#modules#lsp.func_references()<cr>
        nnoremap <leader>gc          <esc>:call g:ovim#modules#lsp.func_go_to_declaration()<cr>
        nnoremap <leader>gs          <esc>:call g:ovim#modules#lsp.func_document_symbol()<cr>
        nnoremap <leader>gr          <esc>:call g:ovim#modules#lsp.func_refactor()<cr>
        nnoremap <leader>gf          <esc>:call g:ovim#modules#lsp.func_format()<cr>

        let l:leader_key_map = {'g':{'name':'+LSP',' ':[':call g:ovim#modules#lsp.func_show_doc()','Doc'],
                                                \ 'd':[':call g:ovim#modules#lsp.func_go_to_def()','Define'],
                                                \ 't':[':call g:ovim#modules#lsp.func_go_to_typedef()','Type Define'],
                                                \ 'i':[':call g:ovim#modules#lsp.func_go_to_impl()','Impl'],
                                                \ 'n':[':call g:ovim#modules#lsp.func_rename()','Rename'],
                                                \ 'u':[':call g:ovim#modules#lsp.func_references()','References'],
                                                \ 'c':[':call g:ovim#modules#lsp.func_go_to_declaration()','Declaration'],
                                                \ 's':[':call g:ovim#modules#lsp.func_document_symbol()','Doc Symbol'],
                                                \ 'r':[':call g:ovim#modules#lsp.func_refactor()','Refactor'],
                                                \ 'f':[':call g:ovim#modules#lsp.func_format()','Format'],
                              \ }}
        call ovim#utils#recursive_update(g:leader_key_map,l:leader_key_map)
    endif
endfun

function s:config_coc()
    function s:call_coc_action_async(action)
        return CocActionAsync(a:action)
    endfunction
    let s:self.func_show_doc          = function("s:call_coc_action_async",["doHover"])
    let s:self.func_go_to_def         = function("s:call_coc_action_async",["jumpDefinition"])
    let s:self.func_go_to_typedef     = function("s:call_coc_action_async",["jumpTypeDefinition"])
    let s:self.func_go_to_impl        = function("s:call_coc_action_async",["jumpImplementation"])
    let s:self.func_rename            = function("s:call_coc_action_async",["rename"])
    let s:self.func_references        = function("s:call_coc_action_async",["jumpReferences"])
    let s:self.func_go_to_declaration = function("s:call_coc_action_async",["jumpDeclaration"])
    let s:self.func_document_symbol   = function("s:call_coc_action_async",["documentSymbols"])
    let s:self.func_refactor          = function("s:call_coc_action_async",["refactor"])
    let s:self.func_format            = function("s:call_coc_action_async",["format"])
endfunction

function s:config_lcn()
    let s:self.func_show_doc          = function("LanguageClient#textDocument_hover")
    let s:self.func_go_to_def         = function("LanguageClient#textDocument_definition")
    let s:self.func_go_to_typedef     = function("LanguageClient#textDocument_typeDefinition")
    let s:self.func_go_to_impl        = function("LanguageClient#textDocument_implementation")
    let s:self.func_rename            = function("LanguageClient#textDocument_rename")
    let s:self.func_references        = function("LanguageClient#textDocument_references")
    let s:self.func_go_to_declaration = function("LanguageClient#textDocument_declaration")
    let s:self.func_document_symbol   = function("LanguageClient#textDocument_documentSymbol")
    let s:self.func_refactor          = function("ovim#utils#warn",["no define action"])
    let s:self.func_format            = function("LanguageClient#textDocument_formatting")
endfunction
function s:config_nvim_lsp()
endfunction
