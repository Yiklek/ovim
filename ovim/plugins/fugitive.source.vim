
nnoremap <leader>eg<space> :<c-u>Git<CR> 
nnoremap <leader>egb :<c-u>Git blame<CR> 
nnoremap <leader>egd :<c-u>Git difftool<CR> 
nnoremap <leader>egm :<c-u>Git mergetool<CR> 
nnoremap <leader>egp :<c-u>Git push<CR> 
nnoremap <leader>egf :<c-u>Git fetch<CR> 
nnoremap <leader>egl :<c-u>Git log<CR> 
let s:leader_key_map = {"e":{"g":{"name":"+git",
                                \ " ":[":Git","Git"],
                                \ "b":[":Git blame","GitBlame"],
                                \ "d":[":Git difftool","GitDiff"],
                                \ "m":[":Git mergetoll","GitMerge"],
                                \ "p":[":Git push","GitPush"],
                                \ "f":[":Git fetch","GitFetch"],
                                \ "l":[":Git log","GitLog"],
                                \ }}}
call ovim#utils#recursive_update(g:leader_key_map,s:leader_key_map)
