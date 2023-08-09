M = {}

--- @class NvimWinConfig
--- @field relative string
--- @field title string
--- @alias NvimWinId integer
--- @alias NvimBufId integer
---Check window is float
---@param config (NvimWinId)|(NvimWinConfig)
---@return boolean
function M.is_float(config)
  local c = config
  if type(config) == "number" then
    c = vim.api.nvim_win_get_config(config) ---@cast c NvimWinConfig
  end
  return c.relative ~= nil and c.relative ~= ""
end

---Check buffer is floatable
---@param buffer NvimBufId
---@return boolean
function M.is_floatable_buffer(buffer)
  return vim.tbl_contains({ "", "terminal" }, vim.api.nvim_buf_get_option(buffer, "buftype"))
end

---Scale float window. min: (10, 20) max: (lines, columns)
---@param winid NvimWinId
---@param height number Scaling factor
---@param width number Scaling factor
function M.float_scale(winid, height, width)
  local win_config = vim.api.nvim_win_get_config(winid)
  if not M.is_float(win_config) then
    return
  end

  win_config.width = math.max(vim.fn.ceil(win_config.width * width), 20)
  win_config.height = math.max(vim.fn.ceil(win_config.height * height), 10)

  win_config.width = math.min(win_config.width, vim.o.columns)
  win_config.height = math.min(win_config.height, vim.o.lines)

  vim.api.nvim_win_set_config(winid, win_config)
end

---Modify float window height and width. min: (10, 20) max: (lines, columns)
---@param winid NvimWinId
---@param height number height bais
---@param width number width bais
function M.float_plus(winid, height, width)
  local win_config = vim.api.nvim_win_get_config(winid)
  if not M.is_float(win_config) then
    return
  end
  win_config.width = math.max(win_config.width + width, 20)
  win_config.height = math.max(win_config.height + height, 10)

  win_config.width = math.min(win_config.width, vim.o.columns)
  win_config.height = math.min(win_config.height, vim.o.lines)

  vim.api.nvim_win_set_config(winid, win_config)
end

---Move float window.
---@param winid NvimWinId
---@param row number row bais
---@param col number col bais
function M.float_move(winid, row, col)
  local win_config = vim.api.nvim_win_get_config(winid)
  local pos = vim.api.nvim_win_get_position(winid)
  if not M.is_float(win_config) then
    return
  end
  win_config.row = vim.fn.floor(pos[1] + row)
  win_config.col = vim.fn.floor(pos[2] + col)
  vim.api.nvim_win_set_config(winid, win_config)
end

function M._default_float_config()
  local height = vim.fn.floor(0.8 * vim.o.lines)
  local width = vim.fn.floor(0.8 * vim.o.columns)
  local row = vim.fn.floor((vim.o.lines - height) / 2)
  local col = vim.fn.floor((vim.o.columns - width) / 2)
  return {
    relative = "editor",
    row = row,
    col = col,
    height = height,
    width = width,
    border = "rounded",
  }
end

function M._nw_config(config)
  config.height = vim.fn.floor(0.5 * vim.o.lines)
  config.width = vim.fn.floor(0.5 * vim.o.columns)
  config.row = 0
  config.col = 0
  return config
end

function M._sw_config(config)
  config.height = vim.fn.floor(0.5 * vim.o.lines)
  config.width = vim.fn.floor(0.5 * vim.o.columns)
  config.row = config.height
  config.col = 0
  return config
end

function M._ne_config(config)
  config.height = vim.fn.floor(0.5 * vim.o.lines)
  config.width = vim.fn.floor(0.5 * vim.o.columns)
  config.row = 0
  config.col = config.width
  return config
end

function M._se_config(config)
  config.height = vim.fn.floor(0.5 * vim.o.lines)
  config.width = vim.fn.floor(0.5 * vim.o.columns)
  config.row = config.height
  config.col = config.width
  return config
end

function M._full_config(config)
  config.height = vim.o.lines - 4
  config.width = vim.o.columns - 2
  config.row = 1
  config.col = 1
  return config
end

M._configs = {
  float = function(_)
    return M._default_float_config()
  end,
  ne = M._ne_config,
  se = M._se_config,
  nw = M._nw_config,
  sw = M._sw_config,
  full = M._full_config,
  right = function(config)
    config.col = vim.o.columns - config.width - 3
    return config
  end,
  left = function(config)
    config.col = 1
    return config
  end,
  top = function(config)
    config.row = 1
    return config
  end,
  bottom = function(config)
    config.row = vim.o.lines - config.height - 3
    return config
  end,
}

---Build float window function
---@param a string action
---@return fun(winid: NvimWinId)
function M._float_helper(a)
  return function(winnr)
    local config = vim.api.nvim_win_get_config(winnr)
    local floated = M.is_float(config)
    if not floated then
      config = M._default_float_config()
    end
    config = M._configs[a](config)
    if not floated then
      vim.api.nvim_open_win(0, true, config)
    else
      vim.api.nvim_win_set_config(winnr, config)
    end
  end
end

M.float = M._float_helper("float")
M.float_full = M._float_helper("full")

M.float_nw = M._float_helper("nw")
M.float_ne = M._float_helper("ne")
M.float_sw = M._float_helper("sw")
M.float_se = M._float_helper("se")
M.float_left = M._float_helper("left")
M.float_right = M._float_helper("right")
M.float_top = M._float_helper("top")
M.float_bottom = M._float_helper("bottom")

M.FLOAT_WINDOW_AUGROUP = "OvimFloatWindow"
vim.api.nvim_create_augroup(M.FLOAT_WINDOW_AUGROUP, { clear = true })

local km = require("ovim.core.keymap")
local map_f = km.map_f

---Build buf control Keymaps
---@param opts table
---@return KeymapTable
function M.buf_ctrl_keymaps(opts)
  return {
        -- stylua: ignore start
        ["n|" .. (opts.center or "f")] = map_f(function() M.float(0) end):with_display "Center",
        ["n|" .. (opts.full or "g")] = map_f(function() M.float_full(0) end):with_display "Full",
        ["n|" .. (opts.nw or "y")] = map_f(function() M.float_nw(0) end):with_display "NW",
        ["n|" .. (opts.ne or "u")] = map_f(function() M.float_ne(0) end):with_display "NE",
        ["n|" .. (opts.sw or "n")] = map_f(function() M.float_sw(0) end):with_display "SW",
        ["n|" .. (opts.se or "m")] = map_f(function() M.float_se(0) end):with_display "SE",
        ["n|" .. (opts.top or "k")] = map_f(function() M.float_top(0) end):with_display "Top",
        ["n|" .. (opts.left or "h")] = map_f(function() M.float_left(0) end):with_display "Left",
        ["n|" .. (opts.bottom or "j")] = map_f(function() M.float_bottom(0) end):with_display "Bottom",
        ["n|" .. (opts.right or "l")] = map_f(function() M.float_right(0) end):with_display "Right",
        ["n|" .. (opts.scale_up or "o")] = map_f(function() M.float_scale(0, 1.1, 1.1) end):with_display "Scale +",
        ["n|" .. (opts.scale_down or "i")] = map_f(function() M.float_scale(0, 0.9, 0.9) end):with_display "Scale -",
        ["n|" .. (opts.move_left or "[")] = map_f(function() M.float_move(0, 0, -5) end):with_display "MoveLeft",
        ["n|" .. (opts.move_right or "]")] = map_f(function() M.float_move(0, 0, 5) end):with_display "MoveRight",
        ["n|" .. (opts.move_up or ";")] = map_f(function() M.float_move(0, -5, 0) end):with_display "MoveUp",
        ["n|" .. (opts.move_down or "'")] = map_f(function() M.float_move(0, 5, 0) end):with_display "MoveDown",
        ["n|" .. (opts.reduce_width or "9")] = map_f(function() M.float_plus(0, 0, -5) end):with_display "Width -",
        ["n|" .. (opts.increase_width or "0")] = map_f(function() M.float_plus(0, 0, 5) end):with_display "Width +",
        ["n|" .. (opts.increase_height or ".")] = map_f(function() M.float_plus(0, 5, 0) end):with_display "Height +",
        ["n|" .. (opts.reduce_height or ",")] = map_f(function() M.float_plus(0, -5, 0) end):with_display "Height -",
        ["n|" .. (opts.quit or "q")] = map_f(function() km.unset_keymap(M._buf_ctrl_keymaps, "n", 0) end):with_display "Quit",
    -- stylua: ignore end
  }
end

---@class WinInfo
---@field id integer
---@field win NvimWinId
---@field buffer NvimBufId
---@field config NvimWinConfig
---@field terminal integer? toggleterm terminal id

---@type WinInfo[]
M._wins = {}
---Add window to be manager
---@param buffer NvimBufId buffer id
---@param window NvimWinId window id
function M.append_window(buffer, window)
  if not M.is_float(window) or not M.is_floatable_buffer(buffer) then
    return
  end
  local cond = vim.tbl_contains(M._wins, function(w)
    return w.win == window -- or (w.terminal ~= nil and w.terminal == tid)
  end, { predicate = true })
  if cond then
    return
  end
  local id = M._next_id()
  local config
  if vim.api.nvim_win_is_valid(window) then
    config = vim.api.nvim_win_get_config(window)
  else
    config = M._default_float_config()
  end
  local info = {
    id = id,
    win = window,
    buffer = buffer,
    config = config,
  }
  M._wins[id] = info
end

---remove a managed window
---@param window NvimWinId
function M.remove_window(window)
  if type(window) == "table" then
    window = window.win
  end
  local find = vim.tbl_filter(function(w)
    return w.win == window --or (w.terminal ~= nil and w.terminal == tid)
  end, M._wins)
  for _, w in pairs(find) do
    M._wins[w.id] = nil
  end
end

---Build float buffer Keymaps
---@param opts table
---@return KeymapTable
function M.buf_float_keymaps(opts)
  return {
    ["n|" .. (opts.start_ctrl_mode or "<leader>ff")] = map_f(function()
      if M.is_float(0) then
        km.load(M._buf_ctrl_keymaps, { map = { buffer = 0 } })
      end
    end):with_display("Start Ctrl"),
    ["n|" .. (opts.stop_ctrl_mode or "<leader>fq")] = map_f(function()
      km.unset_keymap(M._buf_ctrl_keymaps, "n", 0)
    end):with_display("Stop Ctrl"),
    ["n|" .. (opts.append_window or "<leader>fa")] = map_f(function()
      if M.is_float(0) then
        local buffer = vim.api.nvim_get_current_buf()
        local win = vim.api.nvim_get_current_win()
        M.append_window(buffer, win)
      end
    end):with_display("Append Window"),
    ["n|" .. (opts.remove_window or "<leader>fx")] = map_f(function()
      if M.is_float(0) then
        local winid = vim.fn.win_getid()
        M.remove_window(winid)
      end
    end):with_display("Remove Window"),
  }
end

---@return WinInfo[]
function M._get_all()
  local result = {}
  for _, v in pairs(M._wins) do
    result[#result + 1] = v
  end
  table.sort(result, function(a, b)
    return a.id < b.id
  end)
  return result
end

--- Get the next available id based on the next number in the sequence that
--- hasn't already been allocated e.g. in a list of {1,2,5,6} the next id should
--- be 3 then 4 then 7
---@return integer
function M._next_id()
  local result = M._get_all()
  for index, win in pairs(result) do
    if index ~= win.id then
      return index
    end
  end
  return #result + 1
end

function M._float_leave_callback(ev)
  if M.is_float(0) then
    km.unset_keymap(M._buf_float_keymaps, "n", ev.buf)
    local winid = vim.fn.win_getid()
    local find = vim.tbl_filter(function(w)
      return w.win == winid
    end, M._wins)
    local config = vim.api.nvim_win_get_config(0)
    local tid = require("toggleterm.terminal").get_focused_id()
    for _, w in pairs(find) do
      w.config = config
      w.terminal = tid
    end
  end
end

function M._float_enter_callback(ev)
  if ev.event == "TermOpen" or (M.is_float(0) and M.is_floatable_buffer(ev.buf)) then
    km.load(M._buf_float_keymaps, { map = { buffer = ev.buf } })
  else
    km.unset_keymap(M._buf_float_keymaps, "n", ev.buf)
  end
end

function M._floatterm_close_callback(ev)
  if M.is_float(0) then
    local find = vim.tbl_filter(function(w)
      return w.buffer == ev.buf
    end, M._wins)
    for _, w in pairs(find) do
      M._wins[w.id] = nil
    end
  end
end

function M._open_toggleterm(window)
  local term = require("toggleterm.terminal")
  local t = term.get(window.terminal, true)
  local wid = vim.api.nvim_open_win(window.buffer, true, window.config)
  t.window = wid
  window.win = wid
end

---Open a managed window
---@param win (WinInfo)|(integer)
function M.open(win)
  local window = win
  if type(win) == "number" then
    window = M._wins[win]
  end
  if window == nil then
    return
  end
  if window.terminal ~= nil then
    return M._open_toggleterm(window)
  end
  if window.win == nil or not vim.api.nvim_win_is_valid(window.win) then
    window.win = vim.api.nvim_open_win(window.buffer, true, window.config)
    return
  end
  vim.api.nvim_set_current_win(window.win)
end

---get win display name
---@param win WinInfo|integer
local function get_win_display_name(win)
  if type(win) == "number" then
    win = M._wins[win]
  end
  local term = require("toggleterm.terminal")
  local t = term.get(win.terminal, true)
  return t and t:_display_name() or win.config.title or vim.fn.bufname(win.buffer)
end

---@param win WinInfo|integer
local function format_win(win)
  if type(win) == "number" then
    win = M._wins[win]
  end
  return string.format("%s. %s", win.id, get_win_display_name(win))
end

---Select a managed window
function M.select()
  local result = M._get_all()
  vim.ui.select(result, {
    prompt = "Select Float Window:",
    format_item = format_win,
  }, M.open)
end

---Remove a managed window
function M.remove()
  local result = M._get_all()
  vim.ui.select(result, {
    prompt = "Select Float Window to Remove:",
    format_item = format_win,
  }, M.remove_window)
end

---setup
---@param opts table
function M.setup(opts)
  local o = opts or {}
  M._buf_float_keymaps = M.buf_float_keymaps(o)
  M._buf_ctrl_keymaps = M.buf_ctrl_keymaps(o)
  vim.api.nvim_create_autocmd({ "WinLeave" }, {
    group = M.FLOAT_WINDOW_AUGROUP,
    nested = true,
    pattern = "*",
    callback = M._float_leave_callback,
  })

  vim.api.nvim_create_autocmd({ "TermClose" }, {
    group = M.FLOAT_WINDOW_AUGROUP,
    nested = true,
    pattern = "*",
    callback = M._floatterm_close_callback,
  })
  vim.api.nvim_create_autocmd({ "WinEnter", "TermOpen", "BufEnter" }, {
    pattern = "*",
    group = M.FLOAT_WINDOW_AUGROUP,
    nested = true,
    callback = M._float_enter_callback,
  })
end

return M
