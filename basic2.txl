tokens
  dot  "."
  slash "/"
  colon ":"
  at "@"
end tokens

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

define program
    '{ [rectObject] '}
end define


% rule replaceRelativeIdent
%   replace $ [relativeIdent]
%      R [relativeIdent]
%   by
%      R
% end rule

rule replaceRelativeIdent
  replace $ [relativeIdent]
     R [relativeIdent]
  deconstruct R
     Root [root] Stuff [repeat pathname]
  by
     'APP Stuff
end rule


function main
  replace [program]
    P [program]
  by
    P [replaceRelativeIdent]
end function
