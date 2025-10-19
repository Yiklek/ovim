-- File: action.lua
-- Author: Yiklek
-- Description: util
-- Copyright (c) 2025 Yiklek

local M = {}

function M.ai_accept()
  local copilot = require("ovim.core.safe_require")("copilot.suggestion")
  if copilot ~= nil and copilot.is_visible() then
    copilot.accept_line()
    return true
  end
end

function M.ai_panel_toggle()
  local copilot = require("ovim.core.safe_require")("copilot.panel")
  if copilot ~= nil then
    copilot.toggle()
    return true
  end
end

function M.snip_forward()
  local luasnip = require("ovim.core.safe_require")("luasnip")
  if vim.snippet.active { direction = 1 } then
    vim.schedule(function()
      vim.snippet.jump(1)
    end)
    return true
  elseif luasnip ~= nil and luasnip.locally_jumpable(1) then
    luasnip.jump(1)
    return true
  end
  return false
end

function M.snip_backward()
  local luasnip = require("ovim.core.safe_require")("luasnip")
  if vim.snippet.active { direction = -1 } then
    vim.schedule(function()
      vim.snippet.jump(-1)
    end)
    return true
  elseif luasnip ~= nil and luasnip.locally_jumpable(-1) then
    luasnip.jump(-1)
    return true
  end
  return false
end

return M
