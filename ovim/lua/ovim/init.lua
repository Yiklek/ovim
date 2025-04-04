-- File: init.lua
-- Author: Yiklek
-- Description: entry
-- Copyright (c) 2022 Yiklek
_G.try = require("ovim.core.try")
_G.ovim = {}

ovim.const = {}
ovim.const.root_path = vim.fn.fnamemodify(debug.getinfo(1, "S").short_src, ":h:h:h")
ovim.util = require("ovim.core.util")

if ovim.util.has_win() then
  ovim.const.cache_path = vim.env.userprofile .. "/.cache/ovim"
else
  local cache_path = vim.env.XDG_CACHE_HOME or (vim.env.HOME .. "/.cache")
  ovim.const.cache_path = cache_path .. "/ovim"
end
vim.opt.packpath:append(ovim.const.cache_path)

ovim.lazy_pack = require("ovim.core.lazy")
ovim.debug = false

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
  vim.o.guifont = "CaskaydiaMono Nerd Font:h16,CaskaydiaCove Nerd Font Mono:h16"
  vim.g.neovide_no_idle = true
  vim.g.neovide_cursor_animation_length = 0.03
  vim.g.neovide_cursor_trail_length = 0.05
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_vfx_opacity = 200.0
  vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
  vim.g.neovide_cursor_vfx_particle_speed = 20.0
  vim.g.neovide_cursor_vfx_particle_density = 5.0
end

disable_distribution_plugins()

if vim.fn.exists("g:neovide") ~= 0 then
  neovide_config()
end

function ovim.setup(options)
  local config = require("ovim.config")
  config:update(options)
  if config.lazyvim == true then
    require("ovim.config"):update(require("ovim.lazyvim").ovim_opts())
  end
  require("ovim.base")
  require("ovim.keymap") -- must require after set <leader> in ovim.base
  ovim.lazy_pack.init()
  vim.cmd([[colorscheme onenord]])
end

return ovim
