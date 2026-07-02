# Ovim

Ovim is a Neovim config and plugins manage framework.
Ovim provides themes, completion, lsp and other useful plugins.

## Prerequisites

- [Neovim](https://neovim.io/) >= 0.10
- [ripgrep](https://github.com/BurntSushi/ripgrep) — required by telescope and blink.cmp search
  - macOS: `brew install ripgrep`
  - Ubuntu/Debian: `apt install ripgrep`
  - Arch: `pacman -S ripgrep`
  - or x-cmd: `x env use rg`

## Install

```bash
git clone https://github.com/Yiklek/ovim
cd ovim
python3 h.py install
```

The `install` command creates a symlink at `~/.config/nvim/init.lua` pointing to ovim.
On first Neovim startup, lazy.nvim will be bootstrapped and all plugins will be installed automatically.

### Download Neovim

```bash
# auto-detect platform and architecture
python3 h.py download

# specify arch manually
python3 h.py download --arch macos-arm64
```

### Uninstall

```bash
python3 h.py uninstall        # remove config symlink
python3 h.py uninstall -r-c   # also remove plugin cache
```

## LICENSE

This project is licensed under the [MIT license](LICENSE)
