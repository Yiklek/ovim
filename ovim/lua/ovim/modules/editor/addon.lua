local M = {}

local function switch_cursor()
  vim.cmd([[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif | normal! zvzz]])
  vim.cmd(
    [[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif | normal! zvzz]]
  )
  vim.cmd([[nnoremap <expr> .  col('.') == '1' ? '$':'0']])
  vim.cmd([[vnoremap <expr> .  col('.') == '1' ? '$':'0']])

  vim.o.updatetime = 500
  vim.api.nvim_create_autocmd({ "BufLeave", "InsertLeave", "CursorMoved", "CursorHold", "CursorHoldI" }, {
    pattern = "*",
    nested = true,
    callback = function(ev)
      local modifiable = vim.api.nvim_get_option_value("modifiable", { buf = ev.buf })
      local buftype = vim.api.nvim_get_option_value("buftype", { buf = ev.buf })
      local filetype = vim.api.nvim_get_option_value("filetype", { buf = ev.buf })
      local modified = vim.api.nvim_get_option_value("modified", { buf = ev.buf })
      if
        modifiable
        and buftype
        and not vim.tbl_contains({ "gitcommit", "gitrebase" }, filetype)
        and modified
      then
        vim.cmd([[silent! write]])
      end
    end,
  })
end

function M.init()
  switch_cursor()
end

return M
