-- File: init.lua
-- Author: Yiklek
-- Description: server.init
-- Last Modified: 12 03, 2022
-- Copyright (c) 2022 Yiklek

local M = {}
function M.on_setup(o)
  return function(server, opts)
    local fo = vim.tbl_extend("force", o, opts or {})
    server.setup(fo)
  end
end
return M
