-- from https://github.com/ayamir/nvimdots/blob/23305faefce0eb07deca99b20825a9075d04d5f4/lua/keymap/bind.lua
local rhs_options = {}

function rhs_options:new()
  local instance = {
    rhs = "",
    opts = {
      display = {
        repr = nil,
        enable = false,
      },
      map = {
        noremap = false,
        silent = true,
        expr = false,
        nowait = false,
        script = false,
        unique = false,
      },
    },
  }
  setmetatable(instance, self)
  self.__index = self
  return instance
end

function rhs_options:update_opts(opts)
  if opts ~= nil then
    self.opts = vim.tbl_deep_extend("force", self.opts, opts)
  end
end

function rhs_options:map_cmd(cmd_string, opts)
  self.rhs = ("<cmd>%s<cr>"):format(cmd_string)
  self.opts.display.repr = cmd_string
  self:update_opts(opts)
  return self
end

function rhs_options:map_cr(cmd_string, opts)
  self.rhs = (":%s<CR>"):format(cmd_string)
  self.opts.display.repr = cmd_string
  self:update_opts(opts)
  return self
end

function rhs_options:map_args(cmd_string, opts)
  self.rhs = (":%s<Space>"):format(cmd_string)
  self.opts.display.repr = cmd_string
  self:update_opts(opts)
  return self
end

function rhs_options:map_cu(cmd_string, opts)
  self.rhs = (":<C-u>%s<CR>"):format(cmd_string)
  self.opts.display.repr = cmd_string
  self:update_opts(opts)
  return self
end

function rhs_options:map_f(func, opts)
  self.rhs = func
  self.opts.display.repr = ""
  self:update_opts(opts)
  return self
end

function rhs_options:map(key, opts)
  self.rhs = key
  self.opts.display.repr = ""
  self:update_opts(opts)
  return self
end

local function with_helper(sub_opt, field, value)
  if value ~= nil then
    sub_opt[field] = value
  else
    sub_opt[field] = true
  end
end
function rhs_options:with_silent(silent)
  with_helper(self.opts.map, "silent", silent)
  return self
end

function rhs_options:with_noremap(noremap)
  with_helper(self.opts.map, "noremap", noremap)
  return self
end

function rhs_options:with_expr(expr)
  with_helper(self.opts.map, "expr", expr)
  return self
end

function rhs_options:with_nowait(nowait)
  with_helper(self.opts.map, "nowait", nowait)
  return self
end

function rhs_options:with_display(display_string)
  self.opts.display.enable = true
  self.opts.display.repr = display_string or self.opts.display.repr
  self.opts.map.desc = self.opts.display.repr
  return self
end

local pbind = {}

function pbind.map_cr(cmd_string, opts)
  local ro = rhs_options:new()
  return ro:map_cr(cmd_string, opts)
end

function pbind.map_cmd(cmd_string, opts)
  local ro = rhs_options:new()
  return ro:map_cmd(cmd_string, opts)
end

function pbind.map_cu(cmd_string, opts)
  local ro = rhs_options:new()
  return ro:map_cu(cmd_string, opts)
end

function pbind.map_args(cmd_string, opts)
  local ro = rhs_options:new()
  return ro:map_args(cmd_string, opts)
end

function pbind.map_f(func, opts)
  local ro = rhs_options:new()
  return ro:map_f(func, opts)
end

function pbind.map(key, opts)
  local ro = rhs_options:new()
  return ro:map_f(key, opts)
end

function pbind.display(display_string, opts)
  local ro = rhs_options:new()
  return ro:with_display(display_string, opts)
end

local cache_keymaps = {}

function pbind.register_which_key()
  -- must ensure which-key.nvim loaded
  local wk = require "which-key"
  for m, key in pairs(cache_keymaps) do
    wk.register(key, { mode = m })
  end
  cache_keymaps = {}
end

function pbind.mode_lhs(s)
  return s:match "([^|]*)|?(.*)"
end

function pbind.load(mapping, extra_opts)
  for mode_lhs, ro in pairs(mapping) do
    local mode, lhs = pbind.mode_lhs(mode_lhs)
    if type(ro) == "table" then
      local rhs = ro.rhs
      local opts = vim.tbl_deep_extend("force", ro.opts, extra_opts or {})
      if opts.display.enable then
        local m = cache_keymaps[mode]
        if m == nil then
          m = {}
        end
        m = vim.tbl_deep_extend("force", m, {
          [lhs] = { opts.display.repr },
        })
        cache_keymaps[mode] = m
      end
      if rhs ~= nil and rhs ~= "" then
        vim.keymap.set(mode, lhs, rhs, opts.map)
      end
    end
  end
  local wk = require "ovim.core.safe_require" "which-key"
  if wk ~= nil then
    pbind.register_which_key()
  end
end

function pbind.unset_keymap(keymaps, mode, buffer)
  if keymaps == nil then
    return
  end
  if mode == nil then
    mode = "n"
  end
  local keys = vim.tbl_map(function(s)
    local _, lhs = pbind.mode_lhs(s)
    return lhs
  end, vim.tbl_keys(keymaps))
  local maps
  if buffer == nil then
    maps = vim.api.nvim_get_keymap(mode)
  else
    maps = vim.api.nvim_buf_get_keymap(buffer, mode)
  end
  local m = {}
  for _, value in ipairs(maps) do
    m[value.lhs] = true
  end
  for _, value in ipairs(keys) do
    local v = string.gsub(value, "<leader>", vim.g.mapleader)
    if m[v] then
      vim.keymap.del(mode, v, { buffer = buffer })
    end
  end
end

---@class KeymapOption
---@field display table
---@field map table

---@class KeymapSpec
---@field rhs string
---@field opts KeymapOption

---@alias KeymapTable { [string]: KeymapSpec}
return pbind
