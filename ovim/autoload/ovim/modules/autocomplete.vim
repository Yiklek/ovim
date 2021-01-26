

let s:self = ovim#modules#new()

function ovim#modules#autocomplete#load(...) abort
    let s:self.name = 'autocomplete'
    let s:self.method = 'deoplete'
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

    let s:self.plugs = {}
    if s:self.method ==# 'coc'
        let s:self.plugs['neoclide/coc.nvim'] = {"repo": "neoclide/coc.nvim", "rev": "release","branch": "release", "hook_source":"source $OVIM_ROOT_PATH/plugins/coc.vim"}
    elseif s:self.method ==# 'deoplete'
        let s:self.plugs['autozimu/LanguageClient-neovim'] = { "repo": "autozimu/LanguageClient-neovim","do":"bash install.sh",
                                \    "build":"sh -c 'bash install.sh'","rev":"next","branch": "next",
                                \    "on_event":["InsertEnter"],
                                \    "hook_source":"source $OVIM_ROOT_PATH/plugins/languageclient.vim",
                                \    "hook_post_update":"bash install.sh"
                                \    }
        let s:self.plugs['Shougo/deoplete.nvim'] = {
    \        "repo": "Shougo/deoplete.nvim",
    \        "do": ":UpdateRemotePlugins",
    \        "on_event":['InsertEnter'],
    \        "hook_post_source":"source $OVIM_ROOT_PATH/plugins/complete-deoplete.vim"
    \    }
        let s:self.plugs['Shougo/neco-vim'] = { "repo": "Shougo/neco-vim","ft":"vim",'on_source':'deoplete.nvim'}

    elseif s:self.method ==# 'ycm'
        let s:self.plugs['Valloric/YouCompleteMe'] = {
    \        "repo": "Valloric/YouCompleteMe",
    \        "on_event":['InsertEnter']
    \        "hook_source":"source $OVIM_ROOT_PATH/plugins/complete-youcompleteme.vim"
    \
    \    })
    endif
    return s:self.plugs
endfun

function s:self.config() abort
    set completeopt-=preview
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

    inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
    inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"

    inoremap <expr> <CR> pumvisible() ?  "\<C-y>" : "\<CR>"

    if s:self.method != 'ycm'
        inoremap <silent><expr> <leader><TAB>
                        \ pumvisible() ? "\<C-n>" :
                        \ <SID>check_back_space() ? "\<TAB>" :
                        \ g:ovim#modules#autocomplete.method ==# 'deoplete' ? deoplete#manual_complete() : coc#refresh()
    endif

    function! s:check_back_space() abort "{{{
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~ '\s'
    endfunction"}}}

    if s:self.method ==# 'coc'
        let g:coc_user_config = {
                                \ "languageserver": {
                                \   "go": {
                                \           "command": "gopls",
                                \           "rootPatterns": ["go.mod"],
                                \           "trace.server": "verbose",
                                \           "filetypes": ["go"]
                                \       },
                                \   "python":{
                                \           "command":"python3",
                                \           "args":["-m","pyls"],
                                \           "filetypes":["python"]
                                \       },
                                \   "rust":{'command':'rust-analyzer','filetypes':['rust'],'rootPatterns':['Cargo.toml']}
                                \ }
                                \ }
        let g:coc_global_extensions = ['coc-marketplace','coc-json','coc-python']
    endif

    " 不懂为什么这里还要设置路径
    " set pythonthreehome=~/miniconda3/envs/vim/
    "set pyxversion=3
    "离开插入模式后自动关闭预览窗口"
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

    call extend(g:leader_key_map,{'<tab>':'Trigger Complete(Insert Mode)'})
endfun
