## rect ((hwsub c hwhello) c 1)
### color gray
### text (((hwsub c hwhello) c 1) n t1) "object_hello"
### text (((hwsub c hwhello) c 1) n t2) "/greet < >(string)"

## rect ((hwsub c hwhello) c 2)
### text ./c/1/n/t2 "object_hello/greet ()"
### circle (((hwsub c hwhello) c 2) i 1)
#### color green
### circle (((hwsub c hwhello) c 2) o 1)
#### color yellow

## circle ((hwsub c hwhello) i 1)
### color green

## circle ((hwsub c hwhello) o 1)
### color yellow


## connection ((hwsub c hwhello) x 1) ((hwsub c hwhello) i 1) (((hwsub c hwhello) c 2)  i 1)
## connection ((hwsub c hwhello) x 2) (((hwsub c hwhello) c 2) o 1) ((hwsub c hwhello) o 1)
