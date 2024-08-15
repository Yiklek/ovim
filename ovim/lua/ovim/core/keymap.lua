-- from https://github.com/ayamir/nvimdots/blob/23305faefce0eb07deca99b20825a9075d04d5f4/lua/keymap/bind.lua

---@class KeymapSpec
local rhs_options = {}

---new
---@return KeymapSpec
function rhs_options:new(opts)
  local default_opts = {
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
  }
  local instance = {
    rhs = "",
    opts = default_opts,
  }
  setmetatable(instance, self)
  self.__index = self
  instance:update_opts(opts)
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

function rhs_options:map(key, opts)
  self.rhs = key
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
function rhs_options:silent(silent)
  with_helper(self.opts.map, "silent", silent)
  return self
end

function rhs_options:noremap(noremap)
  with_helper(self.opts.map, "noremap", noremap)
  return self
end

function rhs_options:expr(expr)
  with_helper(self.opts.map, "expr", expr)
  return self
end

function rhs_options:nowait(nowait)
  with_helper(self.opts.map, "nowait", nowait)
  return self
end

function rhs_options:display(display_string)
  self.opts.display.enable = true
  self.opts.display.repr = display_string or self.opts.display.repr
  self.opts.map.desc = self.opts.display.repr
  return self
end

local pbind = {}

function pbind.map_cr(cmd_string, opts)
  local ro = rhs_options:new(opts)
  return ro:map_cr(cmd_string)
end

function pbind.map_cmd(cmd_string, opts)
  local ro = rhs_options:new(opts)
  return ro:map_cmd(cmd_string)
end

function pbind.map_cu(cmd_string, opts)
  local ro = rhs_options:new(opts)
  return ro:map_cu(cmd_string)
end

function pbind.map_args(cmd_string, opts)
  local ro = rhs_options:new(opts)
  return ro:map_args(cmd_string)
end

function pbind.map(rhs, opts)
  local ro = rhs_options:new(opts)
  return ro:map(rhs)
end

function pbind.display(display_string, opts)
  local ro = rhs_options:new(opts)
  return ro:display(display_string)
end

local cache_keymaps = {}
local function set_cache_keymaps(key, callback)
  local m = cache_keymaps[key]
  if m == nil then
    m = {}
  end
  callback(m)
  cache_keymaps[key] = m
end

local function append_cache_keymaps(key, value)
  set_cache_keymaps(key, function(m)
    m[#m + 1] = value
  end)
end

local which_key_mode = "which-key"
function pbind.register_which_key()
  -- must ensure which-key.nvim loaded
  local wk = require("which-key")
  for m, key in pairs(cache_keymaps) do
    if m ~= which_key_mode then
      key.mode = m
    end
    wk.add(key)
  end
  cache_keymaps = {}
end

function pbind.mode_lhs(s)
  return s:match("([^|]*)|?(.*)")
end

local function check_is_map_spec(mapping)
  local cond = type(mapping) == "table" and not vim.islist(mapping)
  if cond then
    for _, value in ipairs { "mode", "desc", "proxy", "hidden", "group", "expand" } do
      if mapping[value] ~= nil then
        cond = false
        break
      end
    end
  end
  return cond
end

local function is_which_key_item(mapping)
  if type(mapping) == "table" and type(mapping[1]) == "string" then
    return true
  end
  return false
end

local function remove_which_key_fieles(item, mode)
  for _, value in ipairs { "proxy", "hidden", "group", "expand" } do
    item[value] = nil
  end
  item.mode = vim.tbl_keys(mode)
  if #item.mode == 0 then
    item.mode = nil
  end
end

local function enter_mode_level(mapping, mode)
  if mapping.mode ~= nil then
    if type(mapping.mode) == "string" then
      mode[mapping.mode] = 1
    else
      for _, m in ipairs(mapping.mode) do
        mode[m] = 1
      end
    end
  end
end
local function check_mode(mode)
  mode = mode or {}
  if type(mode) == "string" then
    mode = { [mode] = 1 }
  end
  return mode
end

---convert which-key spec to lazy
---@param mapping WhichKeySpec
---@param mode ModeList?
---@return LazySpec
function pbind.whick_key_to_lazy(mapping, mode)
  mode = check_mode(mode)
  enter_mode_level(mapping, mode)
  if is_which_key_item(mapping) then
    remove_which_key_fieles(mapping, mode)
    return { mapping }
  end
  local ret = {}
  for _, value in ipairs(mapping) do
    local r = pbind.whick_key_to_lazy(value, vim.deepcopy(mode))
    for _, v in ipairs(r) do
      ret[#ret + 1] = v
    end
  end
  return ret
end

-- mapping support 2 Spec
-- 1. map
-- {
--   ["n|<leader>xa"] = map(require("ovim.modules.editor.util").remove_space):display("RemoveTraialingSpace")
-- }
-- 2. which-key v3. require which-key.nvim
-- {
--   {"<leader>xa", require("ovim.modules.editor.util").remove_space, desc = "RemoveTraialingSpace", mode = "n"}
-- }
function pbind.load(mapping, extra_opts)
  if check_is_map_spec(mapping) then
    for mode_lhs, ro in pairs(mapping) do
      local mode, lhs = pbind.mode_lhs(mode_lhs)
      if type(ro) == "table" then
        local rhs = ro.rhs
        local opts = vim.tbl_deep_extend("force", ro.opts, extra_opts or {})
        if opts.display.enable then
          append_cache_keymaps(mode, { [1] = lhs, desc = opts.display.repr })
        end
        if rhs ~= nil and rhs ~= "" then
          vim.keymap.set(mode, lhs, rhs, opts.map)
        end
      end
    end
  else
    append_cache_keymaps(which_key_mode, mapping)
  end
  local wk = require("ovim.core.safe_require")("which-key")
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
    ---@diagnostic disable-next-line: undefined-field
    m[value.lhs] = true
  end
  for _, value in ipairs(keys) do
    local v = string.gsub(value, "<leader>", vim.g.mapleader)
    if m[v] then
      vim.keymap.del(mode, v, { buffer = buffer })
    end
  end
end

---convert to lazy keymap
---@param mapping KeymapTable
---@param extra_opts KeymapOption?
---@return LazyKeymap[]
function pbind.to_lazy(mapping, extra_opts)
  local ret = {}
  for mode_lhs, ro in pairs(mapping) do
    local mode, lhs = pbind.mode_lhs(mode_lhs)
    if type(ro) == "table" then
      local rhs = ro.rhs
      local opts = vim.tbl_deep_extend("force", ro.opts, extra_opts or {})
      if rhs ~= nil and rhs ~= "" then
        local lazy_key = { lhs, rhs, desc = opts.display.enable and opts.display.repr or nil, mode = mode }
        vim.tbl_deep_extend("force", lazy_key, opts.map)
        table.insert(ret, lazy_key)
      end
    end
  end
  return ret
end
function pbind.cmd(cmd)
  return ("<cmd>%s<cr>"):format(cmd)
end

---@class KeymapOption
---@field display table
---@field map table

---@class KeymapSpec
---@field rhs string
---@field opts KeymapOption

---@alias KeymapTable { [string]: KeymapSpec}

---@class LazyKeymap
---@field desc string?
---@field mode string?
---@field noremap boolean?
---@field silent boolean?
---@field expr boolean?
---@field nowait boolean?
---@field script boolean?
---@field unique boolean?

---@class WhichKeyItem
---@field [1] string
---@field [2] string|function?
---@field group string?
---@field desc string?
---@field mode string?
---@field hidden boolean?
---@field proxy string?
---@field expand function?

---@alias WhichKeySpec WhichKeyItem[]

---@alias Mode string
---@alias ModeList Mode[]

---@class LazyItem
---@field [1] string
---@field [2] string|function?
---@field mode ModeList|Mode
---@field ft string?

---@alias LazySpec LazyItem[]

return pbind
