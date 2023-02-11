-- File: sys.lua
-- Author: Yiklek
-- Description: sys
-- Copyright (c) 2022 Yiklek
local obj = {}
local function gg()
  if vim.fn.has "nvim" then
    return vim.g
  else
    return vim.eval "g:"
  end
end
local function eval()
  if vim.fn.has "nvim" then
    return vim.api.nvim_eval
  else
    return vim.eval
  end
end

obj.g = gg()
obj.eval = eval()
obj.cmd = vim.cmd
obj.fn = vim.fn
return obj
