# ovim

## 基本功能

支持自定义配置module、plugin
keymap全部经过统一接口便于生成速查

## 启动流程

module可由多个plugin配置成 预留接口

常量初始化  
加载合并modules配置  
加载合并plugins配置  
加载合并addons配置  
调用包管理器  

## default

### plugin

见`config/default.toml`

### Extern dependency

```bash
# all dependencies
python3 h.py depand --node --cargo 
# all dependencies and platform specified script
python3 h.py depend --all
```

#### python

* pynvim
* toml
* python-lsp-server

```bash
pip install --user -U pynvim toml python-lsp-server[all]
python3 -m pip install -t ~/.cache/ovim/python3-venv -U -r requirements.txt
```

python统一使用`$HOME/.cache/ovim/python3-venv`下的虚拟环境，依赖也安装在虚拟环境中
同时`python3_host_prog`也需要对应
使用脚本快速安装

```bash
python3 h.py depend
```

#### node

* neovim
* bash-language-server
* yarn
* js-beautify
* standard
* eslint
* typescript-formatterr

```bash
npm install -g neovim bash-language-server yarn
# or
python h.py depend --node
```

### other

* git
* [Universal Ctags](https://github.com/universal-ctags/ctags)(for vista.vim gutentags.vim)
* [nerd-fonts](https://github.com/ryanoasis/nerd-fonts)(for icon) 
* [fzf](https://github.com/junegunn/fzf)
* [rg](https://github.com/BurntSushi/ripgrep)(optional,for fuzzy search text)
* [rq](https://github.com/dflemstr/rq)(optional,for faster bootstrap)
* [rust-analyzer](https://github.com/rust-analyzer/rust-analyzer)(for rust)
* [youcompleteme](https://github.com/ycm-core/YouCompleteMe)(optional for autocomplete module)
* rustfmt
* clang-formt

```bash
#rg
cargo install ripgrep
#rq
cargo install record-query
#u-ctags
brew tap universal-ctags/universal-ctags
brew install --HEAD universal-ctags/universal-ctags
```

## TODO

* os适配
* vim bookmark manager
* module sub plugin batch config
* tmux
* denite
