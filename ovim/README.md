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

## 依赖 

### python
* pynvim
* toml
* python-language-server

### node
* neovim

### other

* Universal Ctags(for vista.vim)
* nerd-fonts(for icon) 
* fzf
* rg(optional,for fuzzy search text)
* rq(optional,for faster bootstrap)
* rust-analyzer(for rust)
