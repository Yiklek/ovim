# 需求
支持自定义配置module、plugin
keymap全部经过统一接口便于生成速查


# 启动流程

module可由多个plugin配置成 预留接口

常量初始化
加载合并modules配置
加载合并plugins配置
调用包管理器

# default

## plugin
见`config/default.toml`
## extern dependency

### python
* pynvim
* toml
* python-language-server

```bash
pip install --user -U pynvim toml python-language-server
python3 -m pip install --user -U -r requirements.txt
```

### node
* neovim
* bash-language-server

```bash
npm install -g neovim bash-language-server
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

```bash
#rg
cargo install ripgrep
#rq
cargo install record-query
#u-ctags
brew tap universal-ctags/universal-ctags
brew install --HEAD universal-ctags/universal-ctags
```


# TODO

* os适配
* 快捷键修改
* kitty
* i3
* vim bookmark manager
* module sub plugin batch config