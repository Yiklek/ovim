
" gutentags {{{
let g:gutentags_enabled = 0
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
let s:vim_tags = g:ovim_cacha_path.'/tags'
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


nmap <leader>ecs :vertical rightbelow scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <leader>ecg :vertical rightbelow scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <leader>ecc :vertical rightbelow scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <leader>ect :vertical rightbelow scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <leader>ece :vertical rightbelow scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <leader>ecf :vertical rightbelow scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <leader>eci :vertical rightbelow scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <leader>ecd :vertical rightbelow scs find d <C-R>=expand("<cword>")<CR><CR>
nmap <leader>eca :vertical rightbelow scs find a <C-R>=expand("<cword>")<CR><CR>

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
                                \ 's':'查找本 C 符号',
                                \ 'g':'查找本定义',
                                \ 'd':'查找本函数调用的函数',
                                \ 'c':'查找调用本函数的函数',
                                \ 't':'查找本字符串',
                                \ 'e':'查找本 egrep 模式',
                                \ 'f':'查找本文件',
                                \ 'i':'查找包含本文件的文件',
                                \ 'a':'查找此符号被赋值的位置',
                                \ 'S':'查找 C 符号',
                                \ 'G':'查找定义',
                                \ 'D':'查找函数调用的函数',
                                \ 'C':'查找调用本函数的函数',
                                \ 'T':'查找字符串',
                                \ 'E':'查找 egrep 模式',
                                \ 'F':'查找文件',
                                \ 'I':'查找包含本文件的文件',
                                \ 'A':'查找符号被赋值的位置',
                                \ }}}
call ovim#utils#recursive_update(g:leader_key_map,s:leader_key_map)
" }}}
