

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
    return s:self
endfun

function s:self.plugins() abort
    
    let s:self.plugs = []
    if s:self.method ==# 'coc'
        call add(s:self.plugs,{"repo": "neoclide/coc.nvim", "branch": "release", "hook_source":"source $OVIM_ROOT_PATH/plugins/coc.vim"})
    elseif s:self.method ==# 'deoplete'
        call add(s:self.plugs,{ "repo": "autozimu/LanguageClient-neovim","branch": "next","hook_source":"source $OVIM_ROOT_PATH/plugins/languageclient.vim"})
        call add(s:self.plugs,{
    \        "repo": "Shougo/deoplete.nvim",
    \        "do": ":UpdateRemotePlugins",
    \        "hook_post_source":"source $OVIM_ROOT_PATH/plugins/complete-deoplete.vim"
    \    })
    elseif s:self.method ==# 'ycm'
        call add(s:self.plugs,{
    \        "repo": "Valloric/YouCompleteMe",
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
                    \ s:self.method ==# 'deoplete'?deoplete#manual_complete() : coc#refresh()
    endif

    function! s:check_back_space() abort "{{{
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~ '\s'
    endfunction"}}}

    let g:python3_host_prog = expand('~/miniconda3/envs/vim/bin/python')
    " 不懂为什么这里还要设置路径
    " set pythonthreehome=~/miniconda3/envs/vim/
    "set pyxversion=3
    "离开插入模式后自动关闭预览窗口"
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
endfun