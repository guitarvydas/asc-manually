# rect app
## text (app n t1) "app"
## circle (app i in)
### color green
## rect (app c inner)
### text ((app c inner) n 2) "app/c/inner"
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
## connector (app x nx1) (app i in) ((app c sub) i x)
## connector (app x nx2) ((app c sub) o y) (app o out)
# rect (app c sub)
## text ((app c sub) n t1) "sub"
## circle ((app c sub) i x)
### color green
## circle ((app c sub) o y)
### color yellow
