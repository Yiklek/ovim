local M = {}
local util = require "ovim.pm.util"

local function build(self)
  return vim.deepcopy(self.holder)
end

local function builder_config(self, value)
  if type(value) == "string" then
    self.holder.config = function()
      print(value)
      vim.fn.luaeval(value)
    end
  else
    self.holder.config = value
  end
  return self
end

function M.Builder(short_url)
  local builder = { holder = { short_url } }
  for i, v in ipairs(util.properties) do
    builder[v] = util.builder_func(v)
  end
  builder.config = builder_config
  builder.build = build
  builder.b = build
  return builder
end

return M
