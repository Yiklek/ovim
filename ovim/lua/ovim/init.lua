ovim = {}
ovim.compat = require('ovim.compat')
ovim.sys = require('ovim.sys')
ovim.pkg = require('ovim.pkg')
try = require('ovim.try')

ovim.pkg:load_compile()

return ovim
