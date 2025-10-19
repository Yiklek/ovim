-- File: util.lua
-- Author: Yiklek
-- Description: util
-- Copyright (c) 2022 Yiklek
local M = {}
function M.detect_modules()
  local list = {}
  local modules_dir = ovim.util.path_concat { ovim.const.root_path, "lua/ovim/modules" }
  local plugins_pattern = "*/init.lua"
  local modules = vim.fn.globpath(modules_dir, plugins_pattern, false, 1)
  for _, f in ipairs(modules) do
    list[#list + 1] = string.match(f, "lua[/\\](.+)[/\\]init.lua$")
  end
  return list
end

function M.has_win()
  return vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 or vim.fn.has("win16") == 1 or vim.fn.has("win95") == 1
end

---@param path_sections string[]
---@return string
function M.path_concat(path_sections)
  return vim.fs.normalize(table.concat(path_sections, "/"))
end

function M.cmp_input(opts, on_confirm)
  require("lazy").load { plugins = { "nvim-cmp", "blink.cmp" }, wait = true, mode = "force" }
  local cmp = require("ovim.core.safe_require")("cmp")
  local blink = require("ovim.core.safe_require")("blink.cmp")
  if cmp == nil and blink == nil then
    vim.ui.input(opts, on_confirm)
    return
  end
  -- 创建临时缓冲区
  local buf = vim.api.nvim_create_buf(false, true)

  -- 计算居中位置
  local width = opts.width or 60
  local height = 1
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2) - 2 -- 稍微上移，更符合视觉中心

  -- 设置浮动窗口 - 改为相对editor使其居中
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor", -- 改为相对编辑器而不是光标
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = opts.prompt or "Input",
    title_pos = "left",
  })

  -- 配置缓冲区
  vim.bo[buf].buftype = ""
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].filetype = "text"

  if cmp ~= nil then
    -- 设置 nvim-cmp 手动触发
    cmp.setup.buffer {
      enabled = true,
      completion = {
        autocomplete = false, -- 禁用自动弹出，手动触发
      },
      sources = cmp.config.sources {
        { name = "path" }, -- 路径补全源
        { name = "buffer" },
      },
    }
  elseif blink ~= nil then
    vim.api.nvim_buf_set_var(buf, "blink_cmp_sources", { "path", "buffer" })
  end

  -- 确认选择
  vim.keymap.set("i", "<CR>", function()
    if cmp ~= nil and cmp.visible() then
      cmp.confirm { select = true }
    elseif blink ~= nil and blink.is_visible() then
      blink.hide()
    end
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    vim.api.nvim_win_close(win, true)
    on_confirm(lines[1] or nil)
  end, { buffer = buf })

  vim.keymap.set("i", "<C-c>", function()
    vim.api.nvim_win_close(win, true)
    on_confirm(nil)
  end, { buffer = buf })

  -- 启动插入模式
  vim.api.nvim_feedkeys("A", "n", false)
end
return M
