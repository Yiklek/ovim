-- File: test/try.lua
-- Author: Yiklek
-- Description: test try
-- Copyright (c) 2022 Yiklek
print "test try start"
try = require "ovim.core.try"

local r1, r2 = nil, nil
r1, r2 = pcall(try, {
  function()
    return 1
  end,
})

assert(r1)
assert(r2 == 1)

r1, r2 = pcall(try, {
  function()
    return 1
  end,
  function(e) end,
  function() end,
})
assert(r1)
assert(r2 == 1)
r1, r2 = pcall(try, {
  function()
    return 1
  end,
  nil,
  function() end,
})
assert(r1)
assert(r2 == 1)

r1, r2 = pcall(try, {
  function()
    return 1
  end,
  function(e)
    return 2
  end,
  function() end,
})

assert(r1)
assert(r2 == 1)
r1, r2 = pcall(try, {
  function()
    return 1
  end,
  function(e)
    return 2
  end,
  function()
    return 3
  end,
})
assert(r1)
assert(r2 == 3)

r1, r2 = pcall(try, {
  function()
    return 1
  end,
  function(e)
    return 2
  end,
  function()
    error(3)
  end,
})
assert(not r1)
r1, r2 = pcall(try, {
  function()
    return 1
  end,
  function(e)
    error(2)
  end,
  function()
    return 3
  end,
})
assert(r1)
assert(r2 == 3)

r1, r2 = pcall(try, {
  function()
    error(1)
  end,
})

assert(not r1)

r1, r2 = pcall(try, {
  function()
    error(1)
  end,
  function(e)
    return 2
  end,
})

assert(r1)
assert(r2 == 2)

r1, r2 = pcall(try, {
  function()
    error(1)
  end,
  function(e) end,
  function()
    return 3
  end,
})

assert(r1)
assert(r2 == 3)

r1, r2 = pcall(try, {
  function()
    error(1)
  end,
  nil,
  function()
    return 3
  end,
})

assert(not r1)

r1, r2 = pcall(try, {
  function()
    error(1)
  end,
  function(e)
    error(2)
  end,
  function() end,
})
assert(not r1)

r1, r2 = pcall(try, {
  function()
    error(1)
  end,
  function(e)
    error(2)
  end,
  nil,
})
assert(not r1)

r1, r2 = pcall(try, {
  function()
    error(1)
  end,
  function(e)
    error(2)
  end,
  function()
    error(3)
  end,
})
assert(not r1)

r1, r2 = pcall(try, {
  function()
    error(1)
  end,
  function(e) end,
  function()
    error(3)
  end,
})
assert(not r1)

r1, r2 = pcall(try, {
  function()
    error(1)
  end,
  function(e)
    return 2
  end,
  function() end,
})
assert(r1)
assert(r2 == 2)

r1, r2 = pcall(try, {
  function()
    error(1)
  end,
  function(e)
    return 2
  end,
  function()
    return 3
  end,
})
assert(r1)
assert(r2 == 3)
print "test try end"
