let g:asynctasks_extra_config = [
    \ g:ovim_root_path.'/config/asynctasks/tasks.ini',
    \ ]

let g:asynctasks_term_pos = "bottom"

nnoremap <leader>rx :AsyncTask file-run<CR>
nnoremap <leader>rb :AsyncTask file-build<CR>
nnoremap <leader>rr :AsyncTask project-run<CR>
nnoremap <leader>rp :AsyncTask project-build<CR>
let s:leader_key_map = {'r':{"x":[':AsyncTask file-run','file-run'],
                    \ "b":[':AsyncTask file-build','file-build'],
                    \ "r":[':AsyncTask project-run','file-run'],
                    \ "p":[':AsyncTask project-build','project-build'],
                    \}}
call ovim#utils#recursive_update(g:leader_key_map,s:leader_key_map)