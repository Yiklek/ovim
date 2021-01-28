map <Leader>cc <Plug>NERDCommenterComment
map <Leader>cn <Plug>NERDCommenterNested
map <Leader>c<space> <Plug>NERDCommenterToggle
map <Leader>cm <Plug>NERDCommenterMinimal
map <Leader>ci <Plug>NERDCommenterInvert
map <Leader>cs <Plug>NERDCommenterSexy
map <Leader>cy <Plug>NERDCommenterYank
map <Leader>c$ <Plug>NERDCommenterToEOL
map <Leader>cA <Plug>NERDCommenterAppend
map <Leader>ca <Plug>NERDCommenterAltDelims
map <Leader>cl <Plug>NERDCommenterAlignLeft
map <Leader>cb <Plug>NERDCommenterAlignBoth
map <Leader>cu <Plug>NERDCommenterUncomment
let s:comment_map = {
                    \    'c':['<Plug>NERDCommenterComment','Comment'],
                    \    'n':['<Plug>NERDCommenterNested','Nested'],
                    \    ' ':['<Plug>NERDCommenterToggle','Toggle'],
                    \    'm':['<Plug>NERDCommenterMinimal','Minimal'],
                    \    'i':['<Plug>NERDCommenterInvert','Invert'],
                    \    's':['<Plug>NERDCommenterSexy','Sexy'],
                    \    'y':['<Plug>NERDCommenterYank','Yank'],
                    \    '$':['<Plug>NERDCommenterToEOL','ToEOL'],
                    \    'A':['<Plug>NERDCommenterAppend','Append'],
                    \    'a':['<Plug>NERDCommenterAltDelims','AltDelims'],
                    \    'l':['<Plug>NERDCommenterAlignLeft','AlignLeft'],
                    \    'b':['<Plug>NERDCommenterAlignBoth','AlignBoth'],
                    \    'u':['<Plug>NERDCommenterUncomment','Uncomment'],
                    \}
call ovim#utils#recursive_update(g:leader_key_map.c,s:comment_map)
