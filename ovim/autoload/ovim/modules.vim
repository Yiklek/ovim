

"{name:'','plugins':[{ 'name':'name',option:{} }]}
function ovim#modules#new()
    return {'name':'','plugs':[]}
endfun
function ovim#modules#load(module,...)
    return ovim#modules#{a:module}#load(a:1)
endfun