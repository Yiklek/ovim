-- File: init.lua
-- Author: Yiklek
-- Description: entry
-- Copyright (c) 2022 Yiklek
_G.try = require "ovim.misc.try"
_G.ovim = {}

ovim.const = {}
ovim.const.root_path = vim.fn.fnamemodify(vim.fn.resolve(vim.fn.expand "<script>:p"), ":h") .. "/ovim"
vim.env.OVIM_ROOT_PATH = ovim.const.root_path

ovim.util = require "ovim.misc.util"

if ovim.util.has_win() then
  ovim.const.cache_path = vim.env.userprofile .. "/.cache/ovim"
else
  ovim.const.cache_path = vim.fn.stdpath "cache" .. "/../ovim"
end
vim.opt.packpath:append(ovim.const.cache_path)

ovim.compat = require "ovim.misc.compat"
ovim.sys = require "ovim.sys"
ovim.lazy_pack = require "ovim.lazy"
ovim.debug = false

require "ovim.base"

ovim.lazy_pack.init()

local function disable_distribution_plugins()
  vim.g.loaded_gzip = 1
  vim.g.loaded_tar = 1
  vim.g.loaded_tarPlugin = 1
  vim.g.loaded_zip = 1
  vim.g.loaded_zipPlugin = 1
  vim.g.loaded_getscript = 1
  vim.g.loaded_getscriptPlugin = 1
  vim.g.loaded_vimball = 1
  vim.g.loaded_vimballPlugin = 1
  vim.g.loaded_matchit = 1
  vim.g.loaded_matchparen = 1
  vim.g.loaded_2html_plugin = 1
  vim.g.loaded_logiPat = 1
  vim.g.loaded_rrhelper = 1
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  vim.g.loaded_netrwSettings = 1
  vim.g.loaded_netrwFileHandlers = 1
end
local function neovide_config()
  vim.o.guifont = "DejaVuSansMono NF:h16,CaskaydiaCove Nerd Font Mono:h16"
  --vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.g.neovide_no_idle = true
  vim.g.neovide_cursor_animation_length = 0.03
  vim.g.neovide_cursor_trail_length = 0.05
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_vfx_opacity = 200.0
  vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
  vim.g.neovide_cursor_vfx_particle_speed = 20.0
  vim.g.neovide_cursor_vfx_particle_density = 5.0
end

local default_python_path = nil
if ovim.util.has_win() then
  default_python_path = ovim.const.cache_path .. "/python3-venv/Scripts/python.exe"
else
  default_python_path = ovim.const.cache_path .. "/python3-venv/bin/python"
end

vim.g.python3_host_prog = vim.fn.get(vim.g, "python3_host_prog", default_python_path)

disable_distribution_plugins()

if vim.fn.exists "g:neovide" ~= 0 then
  neovide_config()
end

require "ovim.keymap"

function ovim.setup(options) end
vim.cmd [[colorscheme kanagawa]]
return ovim
