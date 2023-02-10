local ovim_root_path = vim.fn.fnamemodify(vim.fn.resolve(vim.fn.expand('<script>:p')), ':h') .. "/ovim"
vim.opt.runtimepath:append(ovim_root_path)
require("ovim")
