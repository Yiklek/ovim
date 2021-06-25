" File: theme.vim
" Author: Yiklek
" Description: module theme
" Last Modified: 06 25, 2021
" Copyright (c) 2021 Yiklek


let s:self = ovim#modules#new()

function ovim#modules#theme#load(...) abort
    if get(s:self,'loaded',0)
        return s:self
    endif
    let s:self.name = 'theme'
    if exists('a:1') && type(a:1) == v:t_dict
        for [k,v] in items(a:1)
            let s:self[k] = v
        endfor
    endif
    let s:self.loaded = 1
    let g:ovim#modules#{s:self.name} = s:self
    return s:self
endfun

function s:self.load_theme() abort
    if get(s:self,'theme_loaded',0)
        return
    endif
    let t = type(s:self.use)
    if t == v:t_string
        execute "colorscheme ".s:self.use
    elseif t == v:t_list
        for u in s:self.use 
            try
                execute "colorscheme ".u
                let s:self['theme_loaded'] = 1
                break
            catch /.*/
            endtry
        endfor
    endif
endfunction


function s:self.plugins() abort
    let s:self.plugs = s:self.options
    return s:self.plugs
endfun



function s:self.config() abort
    autocmd VimEnter * call s:self.load_theme()
    set background=dark
    let g:solarized_italic=0
    "let g:solarized_termtrans = 1
    " set t_Co=256
    if has("termguicolors")
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
      set termguicolors
    endif
    " vim 在iterm2下一半启动时间都在加载主题  nvim很快
    let g:oceanic_material_allow_underline = 1
    " silent! colorscheme solarized
    "silent! colorscheme gruvbox
    "silent! colorscheme one
    "silent! colorscheme zephyr
    " if !has("gui_running")
    "     hi Normal guibg=NONE ctermbg=NONE
    " endif
    " silent! colorscheme oceanic_material
    " silent! colorscheme OceanicNext
    " hi CursorLine cterm=NONE
    " if s:has_colorscheme('gruvbox')
    "     colorscheme gruvbox
    " elseif s:has_colorscheme('solarized')
    "     colorscheme solarized
    " endif
    let g:solarized_termcolors=256
endfun
