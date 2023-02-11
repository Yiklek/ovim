local M = {}
function M.builder_func(name)
  return function(self, value)
    self.holder[name] = value
    return self
  end
end

M.properties = {
  "dir",
  "url",
  "name",
  "dev",
  "lazy",
  "enable",
  "cond",
  "dependencies",
  "init",
  "opts",
  "config",
  "build",
  "branch",
  "tag",
  "commit",
  "version",
  "pin",
  "event",
  "cmd",
  "ft",
  "keys",
  "module",
  "priority",
}
return M
