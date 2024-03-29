-- File: completion/config.lua
-- Author: Yiklek
-- Description: completion config
-- Copyright (c) 2022 Yiklek
local C = {}
function C.nvim_cmp()
    vim.cmd [[highlight CmpItemAbbrDeprecated guifg=#D8DEE9 guibg=NONE gui=strikethrough]]
    vim.cmd [[highlight CmpItemKindSnippet guifg=#BF616A guibg=NONE]]
    vim.cmd [[highlight CmpItemKindUnit guifg=#D08770 guibg=NONE]]
    vim.cmd [[highlight CmpItemKindProperty guifg=#A3BE8C guibg=NONE]]
    vim.cmd [[highlight CmpItemKindKeyword guifg=#EBCB8B guibg=NONE]]
    vim.cmd [[highlight CmpItemAbbrMatch guifg=#5E81AC guibg=NONE]]
    vim.cmd [[highlight CmpItemAbbrMatchFuzzy guifg=#5E81AC guibg=NONE]]
    vim.cmd [[highlight CmpItemKindVariable guifg=#8FBCBB guibg=NONE]]
    vim.cmd [[highlight CmpItemKindInterface guifg=#88C0D0 guibg=NONE]]
    vim.cmd [[highlight CmpItemKindText guifg=#81A1C1 guibg=NONE]]
    vim.cmd [[highlight CmpItemKindFunction guifg=#B48EAD guibg=NONE]]
    vim.cmd [[highlight CmpItemKindMethod guifg=#B48EAD guibg=NONE]]

    local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
    end
    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local cmp = require("cmp")
    if not packer_plugins["cmp-under-comparator"].loaded then
        vim.cmd [[packadd cmp-under-comparator]]
    end
    cmp.setup {
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        sorting = {
            comparators = {
                cmp.config.compare.offset,
                cmp.config.compare.exact,
                cmp.config.compare.score,
                require("cmp-under-comparator").under,
                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order
            }
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
                    TypeParameter = ""
                }
                local max_width = vim.o.columns / 2
                if max_width ~= 0 and #vim_item.abbr > max_width then
                    vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. "…"
                end
                -- load lspkind icons
                vim_item.kind = string.format("%s %s", lspkind_icons[vim_item.kind], vim_item.kind)

                vim_item.menu =
                    ({
                    -- cmp_tabnine = "[TN]",
                    buffer = "[BUF]",
                    orgmode = "[ORG]",
                    nvim_lsp = "[LSP]",
                    nvim_lua = "[LUA]",
                    path = "[PATH]",
                    tmux = "[TMUX]",
                    luasnip = "[SNIP]",
                    spell = "[SPELL]"
                })[entry.source.name]

                return vim_item
            end
        },
        -- You can set mappings if you want
        mapping = cmp.mapping.preset.insert {
            ["<CR>"] = cmp.mapping.confirm({select = true}),
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<C-k>"] = cmp.mapping.scroll_docs(-4),
            ["<C-j>"] = cmp.mapping.scroll_docs(4),
            ["<C-e>"] = cmp.mapping.close(),
            ["<Tab>"] = cmp.mapping(
                function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end,
                {"i", "s"}
            ),
            ["<S-Tab>"] = cmp.mapping(
                function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end,
                {"i", "s"}
            ),
            ["<C-h>"] = function(fallback)
                if require("luasnip").jumpable(-1) then
                    vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
                else
                    fallback()
                end
            end,
            ["<C-l>"] = function(fallback)
                if require("luasnip").expand_or_jumpable() then
                    vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
                else
                    fallback()
                end
            end
        },
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end
        },
        -- You should specify your *installed* sources.
        sources = {
            {name = "nvim_lsp"},
            {name = "nvim_lua"},
            {name = "luasnip"},
            {name = "path"},
            {name = "spell"},
            {name = "tmux"},
            {name = "orgmode"},
            {name = "buffer"},
            {name = "latex_symbols"},
            {name = 'ultisnips'}
        }
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
    cmp.setup.cmdline('?', {
        mapping = cmp.mapping.preset.cmdline(),
        -- completion = {
        -- ---@usage The minimum length of a word to complete on.
        --     keyword_length = 2,
        -- },
        sources = {
            { name = 'buffer' }
        }
    })
    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        -- completion = {
        -- ---@usage The minimum length of a word to complete on.
        --     keyword_length = 2,
        -- },
        sources = {
            { name = 'buffer' }
        }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        completion = {
        ---@usage The minimum length of a word to complete on.
            keyword_length = 2,
        },
        sources = cmp.config.sources({
            { name = 'cmdline' }
            }, {
            { name = 'path' }
        })
    })
    vim.o.wildmenu = false
end
function C.lua_snip()
    require("luasnip").config.set_config {
        history = true,
        updateevents = "TextChanged,TextChangedI"
    }
    require("luasnip/loaders/from_vscode").load()
end
return C
