-- from https://github.com/ayamir/nvimdots/blob/23305faefce0eb07deca99b20825a9075d04d5f4/lua/keymap/bind.lua
local rhs_options = {}

function rhs_options:new()
	local instance = {
		cmd = "",
        display = nil,
        _display = false,
		options = {
			noremap = false,
			silent = false,
			expr = false,
			nowait = false,
		},
	}
	setmetatable(instance, self)
	self.__index = self
	return instance
end

function rhs_options:map_cmd(cmd_string)
	self.cmd = cmd_string
    self.display = cmd_string
	return self
end

function rhs_options:map_cr(cmd_string)
	self.cmd = (":%s<CR>"):format(cmd_string)
    self.display = cmd_string
	return self
end

function rhs_options:map_args(cmd_string)
	self.cmd = (":%s<Space>"):format(cmd_string)
    self.display = cmd_string
	return self
end

function rhs_options:map_cu(cmd_string)
	self.cmd = (":<C-u>%s<CR>"):format(cmd_string)
    self.display = cmd_string
	return self
end

function rhs_options:with_silent()
	self.options.silent = true
	return self
end

function rhs_options:with_noremap()
	self.options.noremap = true
	return self
end

function rhs_options:with_expr()
	self.options.expr = true
	return self
end

function rhs_options:with_nowait()
	self.options.nowait = true
	return self
end
function rhs_options:with_display(display_string)
    self._display = true
	self.display = display_string or self.display
	return self
end

local pbind = {}

function pbind.map_cr(cmd_string)
	local ro = rhs_options:new()
	return ro:map_cr(cmd_string)
end

function pbind.map_cmd(cmd_string)
	local ro = rhs_options:new()
	return ro:map_cmd(cmd_string)
end

function pbind.map_cu(cmd_string)
	local ro = rhs_options:new()
	return ro:map_cu(cmd_string)
end

function pbind.map_args(cmd_string)
	local ro = rhs_options:new()
	return ro:map_args(cmd_string)
end

function pbind.display(display_string)
	local ro = rhs_options:new()
	return ro:with_display(display_string)
end

local wk = require("ovim.misc.safe_require")('which-key')
local cache_keymaps = {}

function pbind.register_which_key()
    wk = require("ovim.misc.safe_require")('which-key')
    for m,key in pairs(cache_keymaps) do
                    wk.register(key, { mode = m })
    end
    cache_keymaps = {}
end

function pbind.load(mapping)
	for key, value in pairs(mapping) do
		local mode, keymap = key:match("([^|]*)|?(.*)")
		if type(value) == "table" then
			local rhs = value.cmd
			local options = value.options
            -- if wk == nil then
            --     vim.cmd [[packadd which-key.nvim]]
            --     wk = require("ovim.misc.safe_require")('which-key')
            -- end
            if value._display then
                if wk then
                    wk.register({
                        [keymap] = {value.display},
                    }, { mode = mode })
                else
                    local m = cache_keymaps[mode]
                    if m == nil then
                        m = {}
                    end
                    m = vim.tbl_extend("force", m, {
                        [keymap] = {value.display},
                    })
                    cache_keymaps[mode] = m
                end
            end
            if rhs ~= "" then
			    vim.api.nvim_set_keymap(mode, keymap, rhs, options)
            end
		end
	end
end

return pbind
