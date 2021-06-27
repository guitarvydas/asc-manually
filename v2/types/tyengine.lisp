
new-type
new-equivalent-type
new-collection
new-user-collection
new-indirect-type
new-foreign-type

operations:
(one stack for each type)
a    object (no indirection) push a onto a.TOS
a/b  field ref (no indirection) push a/b onto b.TOS
a*/b field ref (indirection only) push (a)/b onto b.TOS
a#b  field set (no indirection) from b.TOS, pop b
a*#b field set (indirection) from b.TOS, pop b
a##b collection append from b.TOS, pop b

type descriptor:
equivalent-to "other"
collection "collection-type" "item-type"
indirect (pointer)
foreign (unknown, determined by-name in toolbox language)
field "type-name" "field-name" "field-type"

triples: relation subject objet
!  a   push a onto a.stack.TOS
*  a   push address(a) onto a.stack.TOS (indirection)
^  a   pop a.stack
/  b   field ref a/b, b pushed onto b.stack.TOS
#  b
## b
@  x   call method with name "x", one parameter=asc,
       "x" might pop/push stacks (any stacks contained by asc)
