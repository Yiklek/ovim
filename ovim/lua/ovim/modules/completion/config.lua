-- File: completion/config.lua
-- Author: Yiklek
-- Description: completion config
-- Copyright (c) 2022 Yiklek
local C = {}
function C.nvim_cmp()
  vim.cmd([[highlight CmpItemAbbrDeprecated guifg=#D8DEE9 guibg=NONE gui=strikethrough]])
  vim.cmd([[highlight CmpItemKindSnippet guifg=#BF616A guibg=NONE]])
  vim.cmd([[highlight CmpItemKindUnit guifg=#D08770 guibg=NONE]])
  vim.cmd([[highlight CmpItemKindProperty guifg=#A3BE8C guibg=NONE]])
  vim.cmd([[highlight CmpItemKindKeyword guifg=#EBCB8B guibg=NONE]])
  vim.cmd([[highlight CmpItemAbbrMatch guifg=#5E81AC guibg=NONE]])
  vim.cmd([[highlight CmpItemAbbrMatchFuzzy guifg=#5E81AC guibg=NONE]])
  vim.cmd([[highlight CmpItemKindVariable guifg=#8FBCBB guibg=NONE]])
  vim.cmd([[highlight CmpItemKindInterface guifg=#88C0D0 guibg=NONE]])
  vim.cmd([[highlight CmpItemKindText guifg=#81A1C1 guibg=NONE]])
  vim.cmd([[highlight CmpItemKindFunction guifg=#B48EAD guibg=NONE]])
  vim.cmd([[highlight CmpItemKindMethod guifg=#B48EAD guibg=NONE]])

  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end
  local default = require("cmp.config").global
  -- put underlines to end
  table.insert(default.sorting.comparators, 3, require("cmp-under-comparator").under)
  local cmp = require("cmp")
  ---@diagnostic disable-next-line: redundant-parameter
  cmp.setup {
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    formatting = {
      format = function(entry, vim_item)
        local lspkind_icons = {
          Text = "",
          Method = "",
          Function = "",
          Constructor = "",
          Field = "",
          Variable = "",
          Class = "ﴯ",
          Interface = "",
          Module = "",
          Property = "ﰠ",
          Unit = "",
          Value = "",
          Enum = "",
          Keyword = "",
          Snippet = "",
          Color = "",
          File = "",
          Reference = "",
          Folder = "",
          EnumMember = "",
          Constant = "",
          Struct = "",
          Event = "",
          Operator = "",
          TypeParameter = "",
        }
        local max_width = vim.o.columns / 2
        if max_width ~= 0 and #vim_item.abbr > max_width then
          vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. "…"
        end
        -- load lspkind icons
        vim_item.kind = string.format("%s %s", lspkind_icons[vim_item.kind], vim_item.kind)

        vim_item.menu = ({
          -- cmp_tabnine = "[TN]",
          buffer = "[BUF]",
          orgmode = "[ORG]",
          nvim_lsp = "[LSP]",
          nvim_lua = "[LUA]",
          path = "[PATH]",
          tmux = "[TMUX]",
          luasnip = "[SNIP]",
          spell = "[SPELL]",
        })[entry.source.name]

        return vim_item
      end,
    },
    -- You can set mappings if you want
    mapping = cmp.mapping.preset.insert {
      ["<CR>"] = cmp.mapping.confirm { select = true },
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-k>"] = cmp.mapping.scroll_docs(-4),
      ["<C-j>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.close(),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif require("luasnip").locally_jumpable(1) then
          vim.fn.feedkeys(t("<Plug>luasnip-jump-next"), "")
          -- elseif require("luasnip").expand_or_locally_jumpable() then
          -- vim.fn.feedkeys(t "<Plug>luasnip-expand-or-jump", "")
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif require("luasnip").locally_jumpable(-1) then
          vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
        else
          fallback()
        end
      end, { "i", "s" }),
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    -- You should specify your *installed* sources.
    sources = {
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "luasnip" },
      { name = "path" },
      { name = "spell" },
      { name = "tmux" },
      { name = "orgmode" },
      { name = "buffer" },
      { name = "latex_symbols" },
      { name = "lazydev", group_index = 0 },
    },
  }

  cmp.event:on("menu_opened", function()
    -- solve conflict to vim-easy-paste
    vim.g.paste_easy_enable = 0
  end)
  cmp.event:on("menu_closed", function()
    -- solve conflict to vim-easy-paste
    vim.g.paste_easy_enable = 1
  end)

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline("?", {
    mapping = cmp.mapping.preset.cmdline(),
    -- completion = {
    -- ---@usage The minimum length of a word to complete on.
    --     keyword_length = 2,
    -- },
    sources = {
      { name = "buffer" },
    },
  })
  cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    -- completion = {
    -- ---@usage The minimum length of a word to complete on.
    --     keyword_length = 2,
    -- },
    sources = {
      { name = "buffer" },
    },
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    completion = {
      ---@usage The minimum length of a word to complete on.
      keyword_length = 2,
    },
    sources = cmp.config.sources({
      { name = "cmdline" },
    }, {
      { name = "path" },
    }),
  })
  vim.o.wildmenu = false
end

function C.lua_snip()
  require("luasnip").config.set_config {
    history = true,
    region_check_events = { "InsertEnter", "InsertLeave", "CursorMoved", "CursorHold" },
    delete_check_events = { "InsertEnter", "InsertLeave", "CursorMoved", "CursorHold" },
  }
  require("luasnip/loaders/from_vscode").lazy_load()
  require("luasnip/loaders/from_snipmate").lazy_load()
end

function C.blink_cmp()
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  return {
    cmdline = {
      keymap = {
        preset = "inherit",
        ["<CR>"] = { "accept_and_enter", "fallback" }, -- 更改成'select_and_accept'会选择第一项插入
      },
      completion = {
        -- 自动显示补全窗口
        menu = {
          auto_show = true,
        },
        -- 不在当前行上显示所选项目的预览
        ghost_text = { enabled = false },
      },
    },
    keymap = {
      preset = "none",
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      -- fallback命令将运行下一个非闪烁键盘映射(回车键的默认换行等操作需要)
      ["<CR>"] = { "accept", "fallback" }, -- 更改成'select_and_accept'会选择第一项插入
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" }, -- 同时存在补全列表和snippet时，补全列表选择优先级更高

      ["<C-j>"] = { "scroll_documentation_up", "fallback" },
      ["<C-k>"] = { "scroll_documentation_down", "fallback" },

      ["<C-n>"] = { "snippet_forward", "select_next", "fallback" }, -- 同时存在补全列表和snippet时，snippet跳转优先级更高
      ["<C-p>"] = { "snippet_backward", "select_prev", "fallback" },
    },
    completion = {
      -- 示例：使用'prefix'对于'foo_|_bar'单词将匹配'foo_'(光标前面的部分),使用'full'将匹配'foo__bar'(整个单词)
      keyword = { range = "full" },
      -- 选择补全项目时显示文档(0.1秒延迟)
      documentation = { auto_show = true, auto_show_delay_ms = 100, window = { border = "rounded" } },
      -- 不预选第一个项目，选中后自动插入该项目文本
      list = { selection = { preselect = false, auto_insert = true } },
      menu = {
        border = "rounded",
        max_height = vim.o.lines / 2,
        draw = {
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind", gap = 1 },
            { "source_name" },
          },
        },
      },
    },
    -- 指定文件类型启用/禁用
    enabled = function()
      return not vim.tbl_contains({
        -- "lua",
        -- "markdown"
      }, vim.bo.filetype) and vim.bo.buftype ~= "prompt" and vim.b.completion ~= false
    end,
    fuzzy = { implementation = "lua" },
    signature = { enabled = true },
    appearance = {
      -- 将后备高亮组设置为 nvim-cmp 的高亮组
      -- 当您的主题不支持blink.cmp 时很有用
      -- 将在未来版本中删除
      use_nvim_cmp_as_default = true,
      -- 将“Nerd Font Mono”设置为“mono”，将“Nerd Font”设置为“normal”
      -- 调整间距以确保图标对齐
      nerd_font_variant = "mono",
    },
    snippets = { preset = "luasnip" },
    -- 已定义启用的提供程序的默认列表，以便您可以扩展它
    sources = {
      default = {
        "buffer",
        "ripgrep",
        "lsp",
        "path",
        "snippets",
        "lazydev",
      },
      providers = {
        -- score_offset设置优先级数字越大优先级越高
        buffer = { score_offset = 5 },
        ripgrep = {
          module = "blink-ripgrep",
          name = "Ripgrep",
          score_offset = 4,
        },
        path = { score_offset = 3 },
        lsp = { score_offset = 2 },
        snippets = { score_offset = 1 },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
      },
    },
  }
end

return C
