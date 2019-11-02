
" vim-plug {{{
call plug#begin(g:dotvimd.'/plugged')
if has('nvim')
  "Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'kristijanhusak/defx-git'
  Plug 'kristijanhusak/defx-icons'
  else
  "Plug 'Shougo/deoplete.nvim'
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'kristijanhusak/defx-git'
  Plug 'kristijanhusak/defx-icons'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
" best completer
Plug 'Valloric/YouCompleteMe'
Plug 'tenfyzhong/CompleteParameter.vim'
" generate .ycm_extra_conf.py
Plug 'https://gitee.com/yelgors/YCM-Generator.git',{'branch':'stable'}

" use this to complete if YCM can't work
"Plug 'maralla/completor.vim'

" status bar
"Plug 'Lokaltog/vim-powerline',{'branch':'develop'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" indent
Plug 'Yggdroot/indentLine'

" source manager
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" auto comment
Plug 'scrooloose/nerdcommenter'

" tag
"Plug 'vim-scripts/taglist.vim', { 'on':  'Tlist' }
Plug 'majutsushi/tagbar', { 'on':  'TagbarToggle' }
Plug 'jiangmiao/auto-pairs'
" templete
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'chiel92/vim-autoformat',{'on':'Autoformat'}

Plug 'skywind3000/asyncrun.vim'

" search file
Plug 'Yggdroot/LeaderF'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
"Plug 'wincent/command-t'

Plug 'arakashic/nvim-colors-solarized'
"Plug 'altercation/vim-colors-solarized'
"Plug 'iCyMind/NeoSolarized'
Plug 'miconda/lucariox.vim'
Plug 'morhetz/gruvbox'
" fold
Plug 'pseewald/vim-anyfold',{'for': ['c','cpp','python','java','fortran','javascript']}

Plug 'roxma/vim-paste-easy'
"Plug 'conradirwin/vim-bracketed-paste'

Plug 'tpope/vim-surround'

Plug 'ludovicchabant/vim-gutentags'

Plug 'mhinz/vim-signify'

Plug 'https://gitee.com/yelgors/vim-togglemouse.git',{'branch':'dev'}
" auto nohl after search
"Plug 'romainl/vim-cool'

" easy regular search
"Plug 'haya14busa/incsearch.vim'

" shell in vim
"Plugin 'shougo/vimshell.vim'
"Plugin 'Shougo/vimproc.vim'
call plug#end()
""""""""""""""""""""""""""""""
" }}}
