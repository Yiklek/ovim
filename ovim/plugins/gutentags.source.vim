
" gutentags {{{
let g:gutentags_enabled = 0
let g:gutentags_define_advanced_commands = 1
" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
elseif executable('cscope')
	let g:gutentags_modules += ['cscope']
endif
if len(g:gutentags_modules) == 0
    let g:gutentags_enabled = 0
endif

" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = get(g:,'root_markers',['.root', '.svn', '.git', '.hg', '.project'])

" 所生成的数据文件的名称
" let g:gutentags_ctags_tagfile = 'tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = g:ovim_cache_path.'/tags'
let g:gutentags_cache_dir = s:vim_tags

" 检测 ~/.cache/ovim/tags 不存在就新建
if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags, 'p')
endif

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 如果使用 universal ctags 需要增加下面一行，老的 Exuberant-ctags 不能加下一行
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']



set cscopequickfix=s-,c-,d-,i-,t-,e-,a-
set cscopetag
" cscope 倒排索引
let g:gutentags_cscope_build_inverted_index = 1

" 禁用 gutentags 自动加载 gtags 数据库的行为
" let g:gutentags_auto_add_gtags_cscope = 0
" let g:gutentags_auto_add_cscope = 0

nmap <Plug>OvimFindSmbl       :vertical   rightbelow   scs   find   s   <C-R>=expand("<cword>")<CR><CR>
nmap <Plug>OvimFindDef        :vertical   rightbelow   scs   find   g   <C-R>=expand("<cword>")<CR><CR>
nmap <Plug>OvimFindUse        :vertical   rightbelow   scs   find   c   <C-R>=expand("<cword>")<CR><CR>
nmap <Plug>OvimFindStr        :vertical   rightbelow   scs   find   t   <C-R>=expand("<cword>")<CR><CR>
nmap <Plug>OvimFindEGrep      :vertical   rightbelow   scs   find   e   <C-R>=expand("<cword>")<CR><CR>
nmap <Plug>OvimFindFile       :vertical   rightbelow   scs   find   f   <C-R>=expand("<cfile>")<CR><CR>
nmap <Plug>OvimFindHaveFile   :vertical   rightbelow   scs   find   i   ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <Plug>OvimFindInvk       :vertical   rightbelow   scs   find   d   <C-R>=expand("<cword>")<CR><CR>
nmap <Plug>OvimFindAssign     :vertical   rightbelow   scs   find   a   <C-R>=expand("<cword>")<CR><CR>

nmap <leader>ecs <Plug>OvimFindSmbl
nmap <leader>ecg <Plug>OvimFindDef
nmap <leader>ecc <Plug>OvimFindUse
nmap <leader>ect <Plug>OvimFindStr
nmap <leader>ece <Plug>OvimFindEGrep
nmap <leader>ecf <Plug>OvimFindFile
nmap <leader>eci <Plug>OvimFindHaveFile
nmap <leader>ecd <Plug>OvimFindInvk
nmap <leader>eca <Plug>OvimFindAssign

nmap <leader>ecS :vertical rightbelow scs find s<space>
nmap <leader>ecG :vertical rightbelow scs find g<space>
nmap <leader>ecC :vertical rightbelow scs find c<space>
nmap <leader>ecT :vertical rightbelow scs find t<space>
nmap <leader>ecE :vertical rightbelow scs find e<space>
nmap <leader>ecF :vertical rightbelow scs find f<space>
nmap <leader>ecI :vertical rightbelow scs find i<space>
nmap <leader>ecD :vertical rightbelow scs find d<space>
nmap <leader>ecA :vertical rightbelow scs find a<space>
let s:leader_key_map = {'e':{'c':{'name':'+cscope',
                                \ 's':[':execute "normal \<Plug>OvimFindSmbl"'     , '本C符号']            ,
                                \ 'g':[':execute "normal \<Plug>OvimFindDef"'      , '本定义']             ,
                                \ 'd':[':execute "normal \<Plug>OvimFindInvk"'     , '本函数调用的函数']   ,
                                \ 'c':[':execute "normal \<Plug>OvimFindUse"'      , '调用本函数的函数']   ,
                                \ 't':[':execute "normal \<Plug>OvimFindStr"'      , '本字符串']           ,
                                \ 'e':[':execute "normal \<Plug>OvimFindEGrep"'    , '本 egrep 模式']      ,
                                \ 'f':[':execute "normal \<Plug>OvimFindFile"'     , '本文件']             ,
                                \ 'i':[':execute "normal \<Plug>OvimFindHaveFile"' , '包含本文件的文件']   ,
                                \ 'a':[':execute "normal \<Plug>OvimFindAssign"'   , '此符号被赋值的位置'] ,
                                \ 'S':[':execute "normal \<Plug>OvimFindSmbl"'     , ' C 符号']            ,
                                \ 'G':[':execute "normal \<Plug>OvimFindDef"'      , '定义']               ,
                                \ 'D':[':execute "normal \<Plug>OvimFindUse"'      , '函数调用的函数']     ,
                                \ 'C':[':execute "normal \<Plug>OvimFindStr"'      , '调用本函数的函数']   ,
                                \ 'T':[':execute "normal \<Plug>OvimFindEGrep"'    , '字符串']             ,
                                \ 'E':[':execute "normal \<Plug>OvimFindFile"'     , 'egrep 模式']         ,
                                \ 'F':[':execute "normal \<Plug>OvimFindHaveFile"' , '文件']               ,
                                \ 'I':[':execute "normal \<Plug>OvimFindInvk"'     , '包含本文件的文件']   ,
                                \ 'A':[':execute "normal \<Plug>OvimFindAssign"'   , '此符号被赋值的位置'] ,
                                \ }}}
call ovim#utils#recursive_update(g:leader_key_map,s:leader_key_map)
" }}}
