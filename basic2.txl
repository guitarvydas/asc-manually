tokens
  dot  "."
  slash "/"
  colon ":"
  at "@"
end tokens

define topObject
  [NL] [IN]
  'rect [id] [opt container]
  [EX] [NL]
end define

define rectObject
  [NL] [IN]
  'rect [rid] [opt container]
  [EX] [NL]
end define

define container
  '{
    [repeat rectObject]
  '}
end define

define relativeIdent
  [SP] [root] [repeat pathname]
end define

define root
  '. | '@ | [stringlit] | [id]
end define

define pathname
  '/ [qualifiedName]
end define

define qualifiedName
  [ns] ': [absoluteIdent]
end define

define ns
  [id] % should be i/o/x/c/n
end define

define absoluteIdent
  [id]
end define

define rid
  [relativeIdent] | [absoluteIdent]
end define

define topid
  [id]
end define




define program
    '{ [topObject] '}
end define

rule replaceRelativeIdent
  import topStringName [stringlit]
  replace $ [relativeIdent]
     R [relativeIdent]
  deconstruct R
     Root [root] Stuff [repeat pathname]
  % construct topName [id]
  %   AAA
  construct topName [id]
    'topStringName [+ '_abc_]
  by
     topName Stuff
end rule


function main
  import TXLargs [repeat stringlit]
  deconstruct * TXLargs
    topStringName [stringlit] other [repeat stringlit]
  export topStringName [stringlit]
  replace [program]
    P [program]
  by
    P [replaceRelativeIdent]
end function
