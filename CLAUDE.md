# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Ovim is a Neovim configuration and plugin management framework that provides themes, completion, LSP, and other useful plugins through a modular architecture.

## Installation and Setup

```bash
# Install (create symlink ~/.config/nvim/init.lua -> ovim/init.lua)
python3 h.py install

# Download latest Neovim release (auto-detect platform)
python3 h.py download

# Uninstall
python3 h.py uninstall -r-c  # remove cache too
```

On first Neovim startup, lazy.nvim is automatically bootstrapped from `ovim/lua/ovim/core/lazy.lua`.

## Architecture

### Entry Points
- `ovim/init.lua` - Minimal entry that calls `require("ovim").setup()`
- `ovim/lua/ovim/init.lua` - Main setup: config, base settings, keymaps, lazy plugin initialization
- `ovim/lua/ovim/config.lua` - Global configuration with hierarchical module structure

### Module System
Modules are auto-discovered from `ovim/lua/ovim/modules/*/init.lua` and include:
- **ui** - Statusline, tabline, file tree, devicons, terminal, dashboard
- **editor** - Autopairs, comments, VCS, paste, movement, formatting
- **lsp** - Language server configuration and features (lspsaga, inlay hints)
- **search** - Telescope with fzf and frecency
- **completion** - nvim-cmp configuration
- **debug** - DAP (Debug Adapter Protocol) support
- **lang** - Language-specific configurations
- **basic** - Basic Neovim settings

Each module has:
- `level` - Priority level (lower = higher priority)
- `features` - Feature flags and configurations
- `plugins` - Lazy.nvim plugin specs
- `condition` - Optional boolean/string condition for enabling

### Configuration System
- `ovim/lua/ovim/config.lua` defines default `M` config with `update()` method for deep merging
- Configuration is hierarchical: `modules.{module_name}.features.{feature_name}`
- LazyVim integration is controlled by `config.lazyvim = true`
- Color scheme defaults to `cyberdream`

### Feature Activation (`ovim.core.features`)
Each module has a `features.lua` exporting named functions. Enabled features from config trigger their function, injecting plugin specs. Features can have a `use` field to choose alternatives (e.g., `fileTree.use = "neo-tree"` vs `"nvim-tree"` vs `"yazi"`).

### LazyVim Integration (`ovim/lua/ovim/lazyvim/`)
When `config.lazyvim = true`: LazyVim specs are prepended, some ovim features are disabled to avoid duplication (basic UI, which-key, debug), and ovim keymaps are re-applied after LazyVim's via `LazyVimKeymaps` user event.

### Core Utilities (`ovim/lua/ovim/core/`)
- `try.lua` — Lua try/catch/finally via `xpcall`
- `safe_require.lua` — wraps `require()` in try/catch, returns nil on failure
- `window.lua` — float window management (float/scale/move/resize/quadrant, lifecycle via autocmds)
- `action.lua` — Copilot integration, LuaSnip navigation, Telescope wrappers
- `util.lua` — module detection (`detect_modules`), path helpers, cmp-powered floating input

### Completion System
Two engines selectable via `vim.g.lazyvim_cmp`: nvim-cmp (with LuaSnip + many sources) or blink.cmp (with LuaSnip + ripgrep source). Both configured in `modules/completion/`.

### Plugin Management
- Uses `lazy.nvim` (bootstrapped in `ovim/lua/ovim/core/lazy.lua`)
- All lazy data (plugins, lock file, state) lives under `$XDG_CACHE_HOME/ovim/lazy/` — isolated from default Neovim paths
- Module `plugins` tables are deep-merged into `config.plugins` before lazy setup
- Modules with `level < config.level` (default 4) are included

### Keymap System
- `ovim/lua/ovim/keymap.lua` defines global keybindings using `ovim.core.keymap`
- Leader key is `<Space>` (set in `ovim/lua/ovim/base.lua`), local leader is `<Tab>`
- Two spec formats: ovim (`{["n|<leader>x"] = map_cr("cmd"):display("desc")}`) and which-key v3 (`{{"<leader>x", fn, desc = "desc", mode = "n"}}`)
- Keymaps are layered: global + per-module (`modules/{name}/keymap.lua`)
- Key prefixes: `<leader>w` (windows), `<leader>t` (tabs), `<leader>b` (buffers), `<leader>f` (float windows), `<leader>g` (LSP), `<leader>s` (search), `<leader>d` (debug), `<leader>e` (editor), `<leader>x` (extensions)

## Code Style

Use `stylua` for formatting (config in `stylua.toml`):
- 2-space indentation
- 120 character column width
- Double quotes preferred

## Common Development Tasks

**Adding a new feature to a module:**
1. Add feature config to `ovim/lua/ovim/config.lua` under `modules.{module}.features.{feature}`
2. Add plugin spec to `ovim/lua/ovim/modules/{module}/init.lua`
3. Add keymaps to `ovim/lua/ovim/modules/{module}/keymap.lua`

**Testing configuration changes:**
- Configuration is loaded at Neovim startup via `~/.config/nvim/init.lua` symlink
- Lazy state is cached in `$XDG_CACHE_HOME/ovim/lazy/state.json`
- Delete cache files to force reload: `rm -rf ~/.cache/ovim/lazy/`

**System dependencies:**
- [ripgrep](https://github.com/BurntSushi/ripgrep) — required by telescope and blink.cmp for search (`brew install ripgrep`, `apt install ripgrep`, x-cmd: `x env use rg`)
- [Neovim](https://neovim.io/) >= 0.10

## Git Commit

co-author-by is not allowed.
