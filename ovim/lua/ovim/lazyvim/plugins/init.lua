return {
  {
    "LazyVim/LazyVim",
    import = "lazyvim.plugins",
    priority = 10000,
    lazy = false,
    cond = true,
  },
  {
    import = "lazyvim.plugins.extras.dap.core",
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    keys = {
      { "<leader>qd", false },
      { "<leader>ql", false },
      { "<leader>qs", false },
      { "<leader>qS", false },
    },
  },
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      picker = {
        win = {
          input = {
            keys = {
              ["<c-->"] = { "edit_split", mode = { "i", "n" } },
              ["<c-\\>"] = { "edit_vsplit", mode = { "i", "n" } },
            },
          },
        },
      },
      styles = {
        input = {
          b = {
            completion = true,
          },
        },
      },
    },
    keys = {
      { "<leader>.", false },
      { "<leader>S", false },
      -- stylua: ignore start
      { "<leader>xs",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>xS",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
      -- stylua: ignore end
    },
  },
}
