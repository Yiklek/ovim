nmap <Leader>cc <Plug>NERDCommenterComment
nmap <Leader>cn <Plug>NERDCommenterNested
nmap <Leader>c<space> <Plug>NERDCommenterToggle
nmap <Leader>cm <Plug>NERDCommenterMinimal
nmap <Leader>ci <Plug>NERDCommenterInvert
nmap <Leader>cs <Plug>NERDCommenterSexy
nmap <Leader>cy <Plug>NERDCommenterYank
nmap <Leader>c$ <Plug>NERDCommenterToEOL
nmap <Leader>cA <Plug>NERDCommenterAppend
nmap <Leader>ca <Plug>NERDCommenterAltDelims
nmap <Leader>cl <Plug>NERDCommenterAlignLeft
nmap <Leader>cb <Plug>NERDCommenterAlignBoth
nmap <Leader>cu <Plug>NERDCommenterUncomment
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
call extend(g:leader_key_map.c,s:comment_map)