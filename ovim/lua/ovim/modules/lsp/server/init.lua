-- File: init.lua
-- Author: Yiklek
-- Description: server.init
-- Last Modified: 12 03, 2022
-- Copyright (c) 2022 Yiklek

local M = {}
function M.on_setup(o)
  return function(opts)
    return vim.tbl_extend("force", vim.deepcopy(o), opts or {})
  end
end
return M
