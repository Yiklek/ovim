local M = {}

local function switch_cursor()
  vim.cmd [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif | normal! zvzz]]
  vim.cmd [[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif | normal! zvzz]]
  vim.cmd [[nnoremap <expr> .  col('.') == '1' ? '$':'0']]
  vim.cmd [[vnoremap <expr> .  col('.') == '1' ? '$':'0']]

  vim.o.updatetime = 500
  vim.api.nvim_create_autocmd({ "BufLeave", "InsertLeave", "CursorMoved", "CursorHold", "CursorHoldI" }, {
    pattern = "*",
    nested = true,
    callback = function(ev)
      if
        vim.api.nvim_buf_get_option(ev.buf, "modifiable")
        and vim.api.nvim_buf_get_option(ev.buf, "buftype") == ""
        and not vim.tbl_contains({ "gitcommit" }, vim.api.nvim_buf_get_option(ev.buf, "filetype"))
        and vim.api.nvim_buf_get_option(ev.buf, "modified")
      then
        vim.cmd [[silent! write]]
      end
    end,
  })
end

function M.init()
  switch_cursor()
end

return M
