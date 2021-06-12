# rect hwhello
## rect (hwhello c 1)
### color gray
### text ((hwhello c 1) n t1) "object_hello"
### text ((hwhello c 1) n t2) "/greet < >(string)"

## rect (hwhello c 2)
### text ./c/1/n/t2 "object_hello/greet ()"
### circle ((hwhello c 2) i 1)
#### color green
### circle ((hwhello c 2) o 1)
#### color yellow

## circle (hwhello i 1)
### color green

## circle (hwhello o 1)
### color yellow

# connection hwhello/x/1 hwhello/i/1 hwhello/c/2/i/1
# connection hwhello/x/2 hwhello/c/2/o/1 hwhello/o/1
