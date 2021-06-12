# rect hwsub
## text (hwsub n t1) "sub"
## circle (hwsub i x)
### color green
## circle (hwsub o y)
### color yellow
## rect (hwsub c hwhello)
### circle ((hwsub c hwhello) i r)
#### color green
### circle ((hwsub c hwhello) o s)
#### color yellow
## connector (hwsub x 1) (hwsub i x) ((hwsub c hwhello)  i r)
## connector (hwsub x 2) ((hwsub c hwhello) o s) (hwsub o y)

## ignore connector (hwsub x 1)
## ignore connector (hwsub x 2)

## rect ((hwsub c hwhello) c 1)
### color red
### text ((hwsub c 1) n t2) "greet"
### circle (((hwsub c hwhello) c 1) i 1)
#### color green
### circle (((hwsub c hwhello) c 1) o 1)
#### color yellow

## circle ((hwsub c hwhello) i 1)
### color green

## circle ((hwsub c hwhello) o 1)
### color yellow



## connection ((hwsub c hwhello) x 1) ((hwsub c hwhello) i 1) (((hwsub c hwhello) c 2)  i 1)
## connection ((hwsub c hwhello) x 2) (((hwsub c hwhello) c 2) o 1) ((hwsub c hwhello) o 1)
