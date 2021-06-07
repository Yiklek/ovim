
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
      \ 'python' : ['python3' , '-m' ,'pylsp'],
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

