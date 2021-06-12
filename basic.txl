define rectObject
  'rect [id] [opt container]
end define

define container
  '{
    [repeat rectObject]
  '}
end define

define relativeIdent
  '. '/ [absoluteIdent] ': [absoluteIdent]
end define

define absoluteIdent
  [id]
end define

define program
    '{ [rectObject] '}
end define

function main
  replace [program]
    P [program]
  by
    P
end function
