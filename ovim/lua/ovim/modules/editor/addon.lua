local M = {}

local function switch_cursor()
  vim.cmd [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif | normal! zvzz]]
  vim.cmd [[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif | normal! zvzz]]
  vim.cmd [[nnoremap <expr> .  col('.') == '1' ? '$':'0']]
  vim.cmd [[vnoremap <expr> .  col('.') == '1' ? '$':'0']]
end

function M.init()
  switch_cursor()
end

return M
