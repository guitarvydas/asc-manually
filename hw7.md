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
