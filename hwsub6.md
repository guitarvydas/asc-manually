### text ((app c hwsub) n t1) "sub"
### circle ((app c hwsub) i x)
#### color green
### circle ((app c hwsub) o y)
#### color yellow
### rect ((app c hwsub) c hwhello)
#### circle (((app c hwsub) c hwhello) i r)
##### color green
#### circle (((app c hwsub) c hwhello) o s)
##### color yellow
### connector ((app c hwsub) x 1) ((app c hwsub) i x) (((app c hwsub) c hwhello)  i r)
### connector ((app c hwsub) x 2) (((app c hwsub) c hwhello) o s) ((app c hwsub) o y)

### ignore connector ((app c hwsub) x 1)
### ignore connector ((app c hwsub) x 2)

### rect (((app c hwsub) c hwhello) c 1)
#### color red
#### text (((app c hwsub) c 1) n t2) "greet"
#### circle ((((app c hwsub) c hwhello) c 1) i 1)
##### color green
#### circle ((((app c hwsub) c hwhello) c 1) o 1)
##### color yellow

### circle (((app c hwsub) c hwhello) i 1)
#### color green

### circle (((app c hwsub) c hwhello) o 1)
#### color yellow



### connection (((app c hwsub) c hwhello) x 1) (((app c hwsub) c hwhello) i 1) ((((app c hwsub) c hwhello) c 2)  i 1)
### connection (((app c hwsub) c hwhello) x 2) ((((app c hwsub) c hwhello) c 2) o 1) (((app c hwsub) c hwhello) o 1)
