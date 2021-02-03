
set hidden
" 告诉LS那个文件夹才是project root，同时也告诉它compile_commands在哪里
let g:LanguageClient_autoStart = 1
let g:LanguageClient_rootMarkers = {
            \ 'cpp': ['compile_commands.json', 'build'],
            \ 'c': ['compile_commands.json', 'build'],
            \ 'python': ['.git'],
            \ 'rust':['Cargo.toml']
            \ }
let s:lsp_servers = {
      \ 'ada' : ['ada_language_server'],
      \ 'c' : ['ccls'],
      \ 'cpp' : ['ccls'],
      \ 'css' : ['css-languageserver', '--stdio'],
      \ 'dart' : ['dart_language_server'],
      \ 'dockerfile' : ['docker-langserver', '--stdio'],
      \ 'go' : ['go-langserver', '-mode', 'stdio'],
      \ 'haskell' : ['hie-wrapper', '--lsp'],
      \ 'html' : ['html-languageserver', '--stdio'],
      \ 'javascript' : ['javascript-typescript-stdio'],
      \ 'julia' : ['julia', '--startup-file=no', '--history-file=no', '-e', 'using LanguageServer; server = LanguageServer.LanguageServerInstance(STDIN, STDOUT, false); server.runlinter = true; run(server);'],
      \ 'objc' : ['clangd'],
      \ 'objcpp' : ['clangd'],
      \ 'purescript' : ['purescript-language-server', '--stdio'],
      \ 'python' : ['python3' , '-m' ,'pyls'],
      \ 'crystal' : ['scry'],
      \ 'rust' : ['rust-analyzer'],
      \ 'scala' : ['metals-vim'],
      \ 'sh' : ['bash-language-server', 'start'],
      \ 'typescript' : ['typescript-language-server', '--stdio'],
      \ 'ruby' : ['solargraph',  'stdio'],
      \ 'vue' : ['vls']
      \ }
" 为语言指定Language server和server的参数
let g:LanguageClient_serverCommands = s:lsp_servers


"nnoremap <space>li :call LanguageClient_textDocument_implementation()<CR>
"nnoremap <space>ld :call LanguageClient#textDocument_definition()<CR>
"nnoremap <space>lr :call LanguageClient#textDocument_rename()<CR>
"nnoremap <space>lf :call LanguageClient#textDocument_formatting()<CR>
"nnoremap <space>lt :call LanguageClient#textDocument_typeDefinition()<CR>
"nnoremap <space>lx :call LanguageClient#textDocument_references()<CR>
"nnoremap <space>la :call LanguageClient_workspace_applyEdit()<CR>
"nnoremap <space>lh :call LanguageClient#textDocument_hover()<CR>
"nnoremap <space>ls :call LanguageClient_textDocument_documentSymbol()<CR>
"nnoremap <space>lc :call LanguageClient_textDocument_codeAction()<CR>
"nnoremap <space>lu :call *LanguageClient#textDocument_documentHighlight()<CR>
"nnoremap <space>lm :call LanguageClient_contextMenu()<CR>
"nnoremap <space>pc :pc<CR>

" autocmd VimEnter *  call s:start_server()

" function s:start_server()
"       if !LanguageClient#isServerRunning()
"             silent! call LanguageClient#startServer()
"       endif
" endfunction
