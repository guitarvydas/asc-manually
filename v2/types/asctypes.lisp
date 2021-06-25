(new-type "template"
    '("name" "namespaces"))

(new-type "namespaces" '("i" "o" "x" "c" "n"))

(new-collection "i" "name")
(new-collection "o" "name")
(new-collection "x" "connection")
(new-collection "c" "asc")
(new-user-collection "n" "association" "name")


(new-type "connection"
   '("name" "tag" "action"))

(new-type "asc"
  '("name" "static" "dynamic"))

(new-equivalent-type "static" "template")
(new-indirect-type "dynamic" "runnable")

(new-type "runnable" '("static" "inputq" "upq" "container"))

(new-user-collection "inputq" "queue" "message")
(new-user-collection "upq" "queue" "message")
(new-indirect-type "container" "runnable")

(new-type "message" '("tag" "any"))
(new-foreign-type "tag")
(new-type "item" '("name" "any"))

#|
types:
template
i
o
c
x
n
runnable
message
tag
item
inputq
upq
container
static
|#

