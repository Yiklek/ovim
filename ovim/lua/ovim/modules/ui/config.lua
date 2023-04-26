-- File: ui/config.lua
-- Author: Yiklek
-- Description: ui config
-- Copyright (c) 2022 Yiklek

local C = {}
local keymap = require "ovim.modules.ui.keymap"

function C.nvim_treesitter()
  vim.api.nvim_command "set foldmethod=expr"
  vim.api.nvim_command "set foldexpr=nvim_treesitter#foldexpr()"
  vim.o.foldlevelstart = 99
  local parser_install_dir = ovim.const.cache_path .. "/treesitter"
  vim.opt.runtimepath:append(parser_install_dir)
  require("nvim-treesitter.configs").setup {
    parser_install_dir = parser_install_dir,
    ensure_installed = {
      "c",
      "cpp",
      "python",
      "rust",
      "vim",
      "javascript",
      --"lua",
      "toml",
      "json",
      "go",
      "gomod",
    },
    indent = {
      enable = true,
    },
    highlight = {
      enable = true,
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = true,
    },
    textobjects = {
      select = {
        enable = true,
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          -- You can optionally set descriptions to the mappings (used in the desc parameter of
          -- nvim_buf_set_keymap) which plugins like which-key display
          ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
          -- You can also use captures from other query groups like `locals.scm`
          ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
        },
        -- You can choose the select mode (default is charwise 'v')
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * method: eg 'v' or 'o'
        -- and should return the mode ('v', 'V', or '<c-v>') or a table
        -- mapping query_strings to modes.
        selection_modes = {
          ["@parameter.outer"] = "v", -- charwise
          ["@function.outer"] = "V", -- linewise
          ["@class.outer"] = "<c-v>", -- blockwise
        },
        -- If you set this to `true` (default is `false`) then any textobject is
        -- extended to include preceding or succeeding whitespace. Succeeding
        -- whitespace has priority in order to act similarly to eg the built-in
        -- `ap`.
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * selection_mode: eg 'v'
        -- and should return true of false
        include_surrounding_whitespace = true,
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]["] = { query = "@class.outer", desc = "Next class start" },
          --
          -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
          ["]o"] = "@loop.*",
          -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
          --
          -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
          -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
          ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
          ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
        -- Below will go to either the start or the end, whichever is closer.
        -- Use if you want more granular movements
        -- Make it even more gradual by adding multiple queries and regex.
        goto_next = {
          ["]d"] = "@conditional.outer",
        },
        goto_previous = {
          ["[d"] = "@conditional.outer",
        },
      },
    },
  }
end

function C.indent_guides()
  require("indent_guides").setup {
    exclude_filetypes = {
      "help",
      "dashboard",
      "dashpreview",
      "NvimTree",
      "vista",
      "sagahover",
      "coc-explorer",
      "floaterm",
      "packer",
    },
  }
end

function C.nvim_navic()
  require("nvim-navic").setup()
end

function C.nvim_gps()
  require("nvim-gps").setup {
    icons = {
      ["class-name"] = " ", -- Classes and class-like objects
      ["function-name"] = " ", -- Functions
      ["method-name"] = " ", -- Methods (functions inside class-like objects)
    },
    languages = {
      -- You can disable any language individually here
      ["c"] = true,
      ["cpp"] = true,
      ["go"] = true,
      ["java"] = true,
      ["javascript"] = true,
      ["lua"] = true,
      ["python"] = true,
      ["rust"] = true,
    },
    separator = " > ",
  }
end

function C.lualine()
  -- ovim.pack.load({ "nvim-treesitter", "nvim-gps" })
  local ui_config = require("ovim.config").modules.ui
  local lualine_c = ""
  if
    ui_config.features.lsp_progress.enable == true and ui_config.features.lsp_progress.use == "lualine-lsp-progress"
  then
    ovim.pack.load "lualine-lsp-progress"
    lualine_c = "lsp_progress"
  end
  local function context_content()
    local navic = require "ovim.misc.safe_require" "nvim-navic"
    local gps = require "ovim.misc.safe_require" "nvim-gps"
    if navic ~= nil and navic.is_available() then
      return navic.get_location()
    end
    if gps ~= nil and gps.is_available() then
      return gps.get_location()
    end
    return ""
  end
  local function context_condition()
    local navic = require "ovim.misc.safe_require" "nvim-navic"
    local gps = require "ovim.misc.safe_require" "nvim-gps"
    if navic ~= nil and navic.is_available() then
      return true
    end
    if gps ~= nil and gps.is_available() then
      return true
    end
    return false
  end

  local simple_sections = {
    lualine_a = { "mode" },
    lualine_b = { "filetype" },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { "location" },
  }
  local aerial = {
    sections = simple_sections,
    filetypes = { "aerial" },
  }
  local dapui_scopes = {
    sections = simple_sections,
    filetypes = { "dapui_scopes" },
  }

  local dapui_breakpoints = {
    sections = simple_sections,
    filetypes = { "dapui_breakpoints" },
  }

  local dapui_stacks = {
    sections = simple_sections,
    filetypes = { "dapui_stacks" },
  }

  local dapui_watches = {
    sections = simple_sections,
    filetypes = { "dapui_watches" },
  }

  require("lualine").setup {
    options = {
      icons_enabled = true,
      theme = "auto",
      disabled_filetypes = {},
      component_separators = "|",
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { { "branch" }, { "diff" } },
      lualine_c = {
        "filename",
        {
          context_content,
          cond = context_condition,
        },
        lualine_c,
      },
      lualine_x = {
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = { error = " ", warn = " ", info = " " },
        },
      },
      lualine_y = {
        "filetype",
        "encoding",
        {
          "fileformat",
          icons_enabled = true,
          symbols = {
            unix = "LF",
            dos = "CRLF",
            mac = "CR",
          },
        },
      },
      lualine_z = { "progress", "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = {
      "quickfix",
      "nvim-tree",
      "toggleterm",
      "fugitive",
      aerial,
      dapui_scopes,
      dapui_breakpoints,
      dapui_stacks,
      dapui_watches,
    },
  }
end

function C.bufferline()
  require("bufferline").setup {
    options = {
      numbers = "both",
      offsets = {
        {
          filetype = "coc-explorer",
          text = "File Explorer",
          text_align = "left",
        },
        {
          filetype = "NvimTree",
          text = "File Explorer",
          text_align = "left",
        },
        {
          filetype = "vista",
          text = "Vista",
          text_align = "right",
        },
        {
          filetype = "vista_kind",
          text = "Vista",
          text_align = "right",
        },
      },
      always_show_bufferline = false,
      diagnostics = "nvim_lsp",
    },
  }
  require("ovim.misc.keymap").load(keymap.bufferline())
end

function C.nvim_tree()
  local function on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- Default mappings. Feel free to modify or remove as you wish.
    --
    -- BEGIN_DEFAULT_ON_ATTACH
    vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts "CD")
    vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer, opts "Open: In Place")
    vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts "Info")
    vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts "Rename: Omit Filename")
    vim.keymap.set("n", "<C-t>", api.node.open.tab, opts "Open: New Tab")
    vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts "Open: Vertical Split")
    vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts "Open: Horizontal Split")
    vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts "Close Directory")
    vim.keymap.set("n", "<CR>", api.node.open.edit, opts "Open")
    vim.keymap.set("n", "<Tab>", api.node.open.preview, opts "Open Preview")
    vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts "Next Sibling")
    vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts "Previous Sibling")
    vim.keymap.set("n", ".", api.node.run.cmd, opts "Run Command")
    vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts "Up")
    vim.keymap.set("n", "a", api.fs.create, opts "Create")
    vim.keymap.set("n", "bmv", api.marks.bulk.move, opts "Move Bookmarked")
    vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter, opts "Toggle No Buffer")
    vim.keymap.set("n", "c", api.fs.copy.node, opts "Copy")
    vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter, opts "Toggle Git Clean")
    vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts "Prev Git")
    vim.keymap.set("n", "]c", api.node.navigate.git.next, opts "Next Git")
    vim.keymap.set("n", "d", api.fs.remove, opts "Delete")
    vim.keymap.set("n", "D", api.fs.trash, opts "Trash")
    vim.keymap.set("n", "E", api.tree.expand_all, opts "Expand All")
    vim.keymap.set("n", "e", api.fs.rename_basename, opts "Rename: Basename")
    vim.keymap.set("n", "]e", api.node.navigate.diagnostics.next, opts "Next Diagnostic")
    vim.keymap.set("n", "[e", api.node.navigate.diagnostics.prev, opts "Prev Diagnostic")
    vim.keymap.set("n", "F", api.live_filter.clear, opts "Clean Filter")
    vim.keymap.set("n", "f", api.live_filter.start, opts "Filter")
    vim.keymap.set("n", "g?", api.tree.toggle_help, opts "Help")
    vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts "Copy Absolute Path")
    vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts "Toggle Dotfiles")
    vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts "Toggle Git Ignore")
    vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts "Last Sibling")
    vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts "First Sibling")
    vim.keymap.set("n", "m", api.marks.toggle, opts "Toggle Bookmark")
    vim.keymap.set("n", "o", api.node.open.edit, opts "Open")
    vim.keymap.set("n", "O", api.node.open.no_window_picker, opts "Open: No Window Picker")
    vim.keymap.set("n", "p", api.fs.paste, opts "Paste")
    vim.keymap.set("n", "P", api.node.navigate.parent, opts "Parent Directory")
    vim.keymap.set("n", "q", api.tree.close, opts "Close")
    vim.keymap.set("n", "r", api.fs.rename, opts "Rename")
    vim.keymap.set("n", "R", api.tree.reload, opts "Refresh")
    vim.keymap.set("n", "s", api.node.run.system, opts "Run System")
    vim.keymap.set("n", "S", api.tree.search_node, opts "Search")
    vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts "Toggle Hidden")
    vim.keymap.set("n", "W", api.tree.collapse_all, opts "Collapse")
    vim.keymap.set("n", "x", api.fs.cut, opts "Cut")
    vim.keymap.set("n", "y", api.fs.copy.filename, opts "Copy Name")
    vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts "Copy Relative Path")
    vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts "Open")
    vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts "CD")
    -- END_DEFAULT_ON_ATTACH

    -- Mappings migrated from view.mappings.list
    --
    -- You will need to insert "your code goes here" for any mappings with a custom action_cb
    vim.keymap.set("n", "l", api.node.open.edit, opts "Open")
    vim.keymap.set("n", "e", api.node.open.replace_tree_buffer, opts "Open: In Place")
    vim.keymap.set("n", "v", api.node.open.vertical, opts "Open: Vertical Split")
    vim.keymap.set("n", "x", api.node.open.horizontal, opts "Open: Horizontal Split")
    vim.keymap.set("n", "t", api.node.open.tab, opts "Open: New Tab")
    vim.keymap.set("n", "h", api.node.navigate.parent_close, opts "Close Directory")
  end
  require "ovim.misc.safe_require"("nvim-tree").setup {
    disable_netrw = true,
    hijack_netrw = true,
    open_on_tab = false,
    hijack_cursor = true,
    update_cwd = false,
    on_attach = on_attach,
    diagnostics = {
      enable = false,
      icons = { hint = "", info = "", warning = "", error = "" },
    },
    system_open = { cmd = nil, args = {} },
    filters = { dotfiles = false, custom = {} },
    git = { enable = true, ignore = true, timeout = 500 },
    view = {
      width = 40,
      hide_root_folder = false,
      side = "left",
      number = false,
      relativenumber = false,
      signcolumn = "yes",
    },
    trash = { cmd = "trash", require_confirm = true },
    renderer = {
      icons = {
        git_placement = "after",
      },
    },
  }
  require("ovim.misc.keymap").load(keymap.nvim_tree())
end

function C.indent_blankline()
  vim.opt.termguicolors = true
  vim.opt.list = true
  require("indent_blankline").setup {
    char = "│",
    show_first_indent_level = true,
    filetype_exclude = {
      "startify",
      "dashboard",
      "dotooagenda",
      "log",
      "fugitive",
      "gitcommit",
      "packer",
      "vimwiki",
      "markdown",
      "json",
      "txt",
      "vista",
      "help",
      "todoist",
      "NvimTree",
      "peekaboo",
      "git",
      "TelescopePrompt",
      "undotree",
      "flutterToolsOutline",
      "", -- for all buffers without a file type
    },
    buftype_exclude = { "terminal", "nofile" },
    show_trailing_blankline_indent = false,
    show_current_context = true,
    context_patterns = {
      "class",
      "function",
      "method",
      "block",
      "list_literal",
      "selector",
      "^if",
      "^table",
      "if_statement",
      "while",
      "for",
      "type",
      "var",
      "import",
    },
    space_char_blankline = " ",
  }
  -- because lazy load indent-blankline so need readd this autocmd
  vim.cmd "autocmd CursorMoved * IndentBlanklineRefresh"
end

function C.which_key()
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ ", "<Plug>", "<plug>" }, -- hide mapping boilerplate
    key_labels = {
      -- override the label used to display some keys. It doesn't effect WK in any other way.
      -- For example:
      ["<space>"] = "SPC",
      ["<cr>"] = "RET",
      ["<tab>"] = "TAB",
    },
  }
  require("ovim.misc.keymap").register_which_key()
end

function C.toggleterm()
  local toggleterm = require "toggleterm"
  toggleterm.setup {
    size = 20,
    open_mapping = [[<leader>et<space>]],
    hide_numbers = false,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 3,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = "curved",
      winblend = 3,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
  }
end

function C.floaterm()
  vim.cmd [[let g:floaterm_complete_options = {'shortcut': 'floaterm', 'priority': 5,'filter_length':[0,100]}]]
  if ovim.util.has_win() then
    for _, i in ipairs { "pwsh.exe", "powershell.exe", "cmd.exe" } do
      if vim.fn.executable(i) ~= 0 then
        vim.g.floaterm_shell = i
        break
      end
    end
  end
  require("ovim.misc.keymap").load(keymap.floaterm())
end

function C.dressing()
  require("dressing").setup {
    input = {
      -- Set to false to disable the vim.ui.input implementation
      enabled = true,
      -- Default prompt string
      default_prompt = "Input:",
      -- Can be 'left', 'right', or 'center'
      prompt_align = "left",
      -- When true, <Esc> will close the modal
      insert_only = true,
      -- When true, input will start in insert mode.
      start_in_insert = true,
      -- These are passed to nvim_open_win
      anchor = "SW",
      border = "rounded",
      -- 'editor' and 'win' will default to being centered
      relative = "editor",
      -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      prefer_width = 40,
      width = nil,
      -- min_width and max_width can be a list of mixed types.
      -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
      max_width = { 140, 0.9 },
      min_width = { 20, 0.2 },
      buf_options = {},
      win_options = {
        -- Window transparency (0-100)
        winblend = 10,
        -- Disable line wrapping
        wrap = false,
      },
      -- Set to `false` to disable
      mappings = {
        n = {
          ["<Esc>"] = "Close",
          ["<CR>"] = "Confirm",
        },
        i = {
          ["<C-c>"] = "Close",
          ["<CR>"] = "Confirm",
          ["<Up>"] = "HistoryPrev",
          ["<Down>"] = "HistoryNext",
        },
      },
      override = function(conf)
        -- This is the config that will be passed to nvim_open_win.
        -- Change values here to customize the layout
        return conf
      end,
      -- see :help dressing_get_config
      get_config = nil,
    },
    select = {
      -- Set to false to disable the vim.ui.select implementation
      enabled = true,
      -- Priority list of preferred vim.select implementations
      backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
      -- Trim trailing `:` from prompt
      trim_prompt = true,
      -- Options for telescope selector
      -- These are passed into the telescope picker directly. Can be used like:
      -- telescope = require('telescope.themes').get_ivy({...})
      telescope = nil,
      -- Options for fzf selector
      fzf = {
        window = {
          width = 0.5,
          height = 0.4,
        },
      },
      -- Options for fzf_lua selector
      fzf_lua = {
        winopts = {
          width = 0.5,
          height = 0.4,
        },
      },
      -- Options for nui Menu
      nui = {
        position = "50%",
        size = nil,
        relative = "editor",
        border = {
          style = "rounded",
        },
        buf_options = {
          swapfile = false,
          filetype = "DressingSelect",
        },
        win_options = {
          winblend = 10,
        },
        max_width = 80,
        max_height = 40,
        min_width = 40,
        min_height = 10,
      },
      -- Options for built-in selector
      builtin = {
        -- These are passed to nvim_open_win
        anchor = "NW",
        border = "rounded",
        -- 'editor' and 'win' will default to being centered
        relative = "editor",
        buf_options = {},
        win_options = {
          -- Window transparency (0-100)
          winblend = 10,
        },
        -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- the min_ and max_ options can be a list of mixed types.
        -- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
        width = nil,
        max_width = { 140, 0.8 },
        min_width = { 40, 0.2 },
        height = nil,
        max_height = 0.9,
        min_height = { 10, 0.2 },
        -- Set to `false` to disable
        mappings = {
          ["<Esc>"] = "Close",
          ["<C-c>"] = "Close",
          ["<CR>"] = "Confirm",
        },
        override = function(conf)
          -- This is the config that will be passed to nvim_open_win.
          -- Change values here to customize the layout
          return conf
        end,
      },
      -- Used to override format_item. See :help dressing-format
      format_item_override = {},
      -- see :help dressing_get_config
      get_config = nil,
    },
  }
end

function C.noice()
  require("noice").setup {
    lsp = {
      progress = {
        enabled = false,
      },
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = false,
      },
      signature = {
        enabled = false,
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
    messages = {
      view = "mini", -- default view for messages
    },
    popupmenu = {
      enabled = false,
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          find = "%slines?%s",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          find = "NvimTree",
        },
        opts = { skip = true },
      },
    },
  }
end

return C
