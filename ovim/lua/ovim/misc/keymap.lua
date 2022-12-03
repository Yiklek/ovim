-- from https://github.com/ayamir/nvimdots/blob/23305faefce0eb07deca99b20825a9075d04d5f4/lua/keymap/bind.lua
local rhs_options = {}

function rhs_options:new()
    local instance = {
        cmd = "",
        opts = {
            display = {
                repr = nil,
                enable = false,
            },
            map = {
                noremap = false,
                silent = true,
                expr = false,
                nowait = false,
                script = false,
                unique = false,
            }
        }
    }
    setmetatable(instance, self)
    self.__index = self
    return instance
end

function rhs_options:update_opts(opts)
    if opts ~= nil then
        self.opts = vim.tbl_deep_extend("force", self.opts, opts)
    end
end

function rhs_options:map_cmd(cmd_string, opts)
    self.cmd = cmd_string
    self.opts.display.repr = cmd_string
    self:update_opts(opts)
    return self
end

function rhs_options:map_cr(cmd_string, opts)
    self.cmd = (":%s<CR>"):format(cmd_string)
    self.opts.display.repr = cmd_string
    self:update_opts(opts)
    return self
end

function rhs_options:map_args(cmd_string, opts)
    self.cmd = (":%s<Space>"):format(cmd_string)
    self.opts.display.repr = cmd_string
    self:update_opts(opts)
    return self
end

function rhs_options:map_cu(cmd_string, opts)
    self.cmd = (":<C-u>%s<CR>"):format(cmd_string)
    self.opts.display.repr = cmd_string
    self:update_opts(opts)
    return self
end

function rhs_options:map_f(func, opts)
    self.cmd = func
    self.opts.display.repr = ""
    self:update_opts(opts)
    return self
end

function rhs_options:with_silent()
    self.opts.map.silent = true
    return self
end

function rhs_options:with_noremap()
    self.opts.map.noremap = true
    return self
end

function rhs_options:with_expr()
    self.opts.map.expr = true
    return self
end

function rhs_options:with_nowait()
    self.opts.map.nowait = true
    return self
end

function rhs_options:with_display(display_string)
    self.opts.display.enable = true
    self.opts.display.repr = display_string or self.opts.display.repr
    return self
end

local pbind = {}

function pbind.map_cr(cmd_string, opts)
    local ro = rhs_options:new()
    return ro:map_cr(cmd_string, opts)
end

function pbind.map_cmd(cmd_string, opts)
    local ro = rhs_options:new()
    return ro:map_cmd(cmd_string, opts)
end

function pbind.map_cu(cmd_string, opts)
    local ro = rhs_options:new()
    return ro:map_cu(cmd_string, opts)
end

function pbind.map_args(cmd_string, opts)
    local ro = rhs_options:new()
    return ro:map_args(cmd_string, opts)
end

function pbind.map_f(func, opts)
    local ro = rhs_options:new()
    return ro:map_f(func, opts)
end

function pbind.display(display_string, opts)
    local ro = rhs_options:new()
    return ro:with_display(display_string, opts)
end

local wk = require("ovim.misc.safe_require")('which-key')
local cache_keymaps = {}

function pbind.register_which_key()
    wk = require("ovim.misc.safe_require")('which-key')
    for m, key in pairs(cache_keymaps) do
        wk.register(key, { mode = m })
    end
    cache_keymaps = {}
end

function pbind.load(mapping, extra_opts)
    for key, value in pairs(mapping) do
        local mode, keymap = key:match("([^|]*)|?(.*)")
        if type(value) == "table" then
            local rhs = value.cmd
            local opts = vim.tbl_deep_extend("force", value.opts, extra_opts or {})

            if opts.display.enable then
                if wk then
                    wk.register({
                        [keymap] = { opts.display.repr },
                    }, { mode = mode })
                else
                    local m = cache_keymaps[mode]
                    if m == nil then
                        m = {}
                    end
                    m = vim.tbl_deep_extend("force", m, {
                        [keymap] = { opts.display.repr },
                    })
                    cache_keymaps[mode] = m
                end
            end
            if rhs ~= nil and rhs ~= "" then
                vim.keymap.set(mode, keymap, rhs, opts.map)
            end
        end
    end
end

return pbind
