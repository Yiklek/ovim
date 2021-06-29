set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified', 'gitbranch','gitstatus'],['lsp'] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'background','fileformat', 'fileencoding', 'filetype'] ],
      \ },
      \ 'component_function': {
      \   'readonly': 'OvimLightLineReadOnly',
      \   'filename': 'OvimLightLineFilename',
      \   'modified': 'OvimLightLineModified',
      \   'gitbranch': 'OvimLightLineGitBranch',
      \   'lsp':'OvimLightLineLsp',
      \   'gitstatus':'OvimLightLineGitStatus',
      \   'fileformat':'OvimLightLineFileformat',
      \   'fileencoding':'OvimLightLineFileEncoding',
      \   'background':'OvimLightLineBackground'
      \ },
      \ }

" Inspired by: https://github.com/chemzqm/tstool.nvim
let s:frames = ['◐', '◑', '◒', '◓']
let s:frame_index = 0
let s:lcn = s:frames[0]


function! s:OnFrame(...) abort
  echo LanguageClient#serverStatusMessage()
  let s:lcn = s:frames[s:frame_index]
  let s:frame_index += 1
  let s:frame_index = s:frame_index % len(s:frames)
  " When the server is idle, LanguageClient#serverStatus() returns 0
  if LanguageClient#serverStatus() == 0
      call timer_stop(s:timer)
      unlet s:timer
      let s:lcn = s:frames[0]
  else
      let s:lcn = LanguageClient#serverStatusMessage()
  endif
endfunction

function! OvimLightLineFileformat() abort
    if winwidth(0) < 60
        return ''
    endif
    if &modifiable == 0
        return ''
    endif
    return &fileformat
endfunction
function! OvimLightLineFileEncoding() abort
    if winwidth(0) < 60
        return ''
    endif
    if &modifiable == 0
        return ''
    endif
    return &fileencoding
endfunction
function! OvimLightLineReadOnly() abort
    if &modifiable == 0
        return ''
    endif
    return &readonly && !s:is_tmp_file() ? 'RO' : ''
endfunction
function! OvimLightLineFilename() abort
    if &modifiable == 0
        return ''
    endif
    return expand("%:t")
endfunction
function! OvimLightLineModified() abort
    if &modifiable == 0
        return ''
    endif
    return &modified ? "+" : ""
endfunction
function! OvimLightLineGitBranch() abort
    if winwidth(0) < 85
        return ''
    endif
    if &modifiable == 0
        return ''
    endif
    if !empty(get(g:, 'coc_git_status', ''))
        return ''
    endif
    return FugitiveHead()
endfunction
function! OvimLightLineBackground() abort
    if winwidth(0) < 90
        return ''
    endif
    if &modifiable == 0
        return ''
    endif
    let l:result = []
    if exists("*gutentags#inprogress") && len(gutentags#inprogress()) > 0
        call add(l:result, "gutentags:".gutentags#statusline()) 
    endif
  return join(l:result, ',')
endfunction
function! OvimLightLineGitStatus() abort
    if winwidth(0) < 85
        return ''
    endif
    if &modifiable == 0
        return ''
    endif
    if exists('b:sy.stats')
        let l:summary = b:sy.stats
    elseif exists('b:gitgutter.summary')
        let l:summary = b:gitgutter.summary
    else
        let l:summary = [0, 0, 0]
    endif
    let l:summary = ' +'.l:summary[0].' ~'.l:summary[1].' -'.l:summary[2].' '
    if !empty(get(g:, 'coc_git_status', ''))
        return ' '.g:coc_git_status.' '.l:summary
    endif
    return l:summary
endfunction
function! s:is_tmp_file() abort
  return !empty(&buftype)
        \ || index(['startify', 'gitcommit', 'defx', 'vista', 'vista_kind','coc-explorer'], &filetype) > -1
        \ || expand('%:p') =~# '^/tmp'
endfunction

function OvimLightLineLsp() abort
    if winwidth(0) < 100
        return ''
    endif
    if &modifiable == 0
        return ''
    endif
    if s:is_tmp_file()
        return ''
    endif
    if get(g:, 'coc_enabled', 0)
        return coc#status().get(b:,"coc_current_function","")
    endif
    if exists('g:LanguageClient_loaded')
        if !exists('s:timer')
            let s:timer = timer_start(200, function('s:OnFrame'), {'repeat': -1})
        endif
        return s:lcn
    endif
    if has('nvim-0.5') && luaeval('#vim.lsp.buf_get_clients() > 0')
        return luaeval("require('lsp-status').status()")
    endif
    return '' 
endfunction
