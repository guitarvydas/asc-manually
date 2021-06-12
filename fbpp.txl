tokens
  lpar "\("
  rpar "\)"
  lbrace "{"
  rbrace "}"
end tokens

keys
   red yellow green
   connector ignore rect circle color text
   i o c x n
end keys


define topObject
  'rect [id] [container]
end define

define container
  '{ [IN] [FL]
    [repeat fact]
  [EX] [FL] '}
end define

define containedAttributes
  '{ [FL]
    [IN]
    [repeat attribute]
    [EX]
  '}
  [FL]
end define

define containerBody
  [object] | [attribute]
end define

define qname
  '( [componentRef] [namespace] [nameRef] ')
end define

define idOrNum
  [id] | [number]
end define

define componentRef
  [idOrNum] | [qname]
end define

define nameRef
  [idOrNum]
end define

define attribute
  [FL] 'color [colorValue] [FL]
end define

define colorValue
  'green | 'yellow | 'red | [hexColor]
end define

define hexColor
  [stringlit]
end define

define fact
  [object] [FL] | [attribute]
end define


define object
    'rect [rectName] [container]
  | 'circle [circleName] [opt containedAttributes]
  | 'text [textName] [stringlit]
  | 'connector [connectorName] [sender] [receiver]
  | 'ignore 'connector [connectorName]
end define

define rectName
  [qname]
end define

define circleName
  [qname]
end define

define textName
  [qname]
end define

define connectorName
  [qname]
end define

define sender
  [qname]
end define

define receiver
  [qname]
end define

define namespace
  'i | 'o | 'c | 'x | 'n
end define




define program
    '{ [IN] [FL] [topObject] [FL] [EX]'}
end define

function main
  import TXLargs [repeat stringlit]
  replace [program]
    P [program]
  by
    P
end function
