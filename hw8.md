# rect app
## text (app n t1) "app"
## circle (app i in)
### color green
## rect (app c inner)
### text ((app c inner) n t2) "inner"
### circle ((app c inner) i a)
### color green
### circle ((app c inner) o b)
### color yellow
## circle (app o out)
### color yellow
## connector (app x 1) (app i in) ((app c inner) i a)
## connector (app x 2) ((app c inner) o b) (app o out)

## ignore connector (app x 1)
## ignore connector (app x 2)
## connector (app x appNx1) (app i in) ((app c hwsub) i x)
## connector (app x appNx1) ((app c hwsub) o y) (app o out)

## rect (app c hwsub)
### text (hwsub n t1) "sub"
### circle (hwsub i x)
#### color green
### circle (hwsub o y)
#### color yellow
### rect (hwsub c hwhello)
#### circle ((sub c hwhello) i r)
##### color green
#### circle ((sub c hwhello) o s)
##### color yellow
### connector (hwsub x 1) (hwsub i x) ((hwsub c hwhello)  i r)
### connector (hwsub x 2) ((hwsub c hwhello) o s) (hwsub o y)

### ignore connector (hwsub x 1)
### ignore connector (hwsub x 2)

### rect ((hwsub c hwhello) c 1)
#### color red
#### text ((hwsub c 1) n 1) "greet"
#### circle (((hwsub c hwhello) c 1) i 1)
##### color green
#### circle (((hwsub c hwhello) c 1) o 1)
##### color yellow

### circle ((hwsub c hwhello) i 1)
#### color green

### circle ((hwsub c hwhello) o 1)
#### color yellow


## connector (hwhello x 1) (hwhello i 1) ((hwhello c 1)  i 1)
## connector (hwhello x 2) ((hwhello c 1) o 1) (hwhello o 1)


