let s:leader_fve = {'m':[':tabe $OVIM_ROOT_PATH/../core/main.vim','main'],
  \  'o':[':tabe $OVIM_ROOT_PATH/autoload/ovim.vim','ovim'],
  \  'c':[':tabe $OVIM_ROOT_PATH/config/default.toml','ovim config'],
  \  'f':[':exe "Defx ".$OVIM_ROOT_PATH','ovim folder defx'],
  \  }
let s:leader_key_map = {'x':{'name':'+编辑'},'f':{'name':'+文件',},
    \ 'e':{'name':'+Extentions'},'j':{"name":"+Code Jump"},
    \ 'c':{'name':'+注释'},'v':{'e':s:leader_fve}
    \}

call ovim#utils#recursive_update(g:leader_key_map,s:leader_key_map)

" 行首尾切换
nnoremap <expr> .  col('.') == '1' ? '$':'0'