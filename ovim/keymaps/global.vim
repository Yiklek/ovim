let s:leader_fve = {'m':[':tabe $OVIM_ROOT_PATH/../core/main.vim','main'],
  \  'o':[':tabe $OVIM_ROOT_PATH/autoload/ovim.vim','ovim'],
  \  'c':[':tabe $OVIM_ROOT_PATH/config/default.toml','ovim config'],
  \  }
let s:leader_key_map = {'x':{'name':'+编辑'},'f':{'name':'+文件','v':{'e':s:leader_fve}},
    \ 'e':{'name':'+Extentions'},'j':{"name":"+Code Jump"},
    \ 'c':{'name':'+注释'},
    \}
call ovim#utils#recursive_update(g:leader_key_map,s:leader_key_map)
