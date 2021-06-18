# rect app
## text ./n/t1 "app"
## circle ./i/in
### color green
## rect ./c/inner
### text ./c/inner/n/t2 "./c/inner"
### circle ./c/inner/i/a
#### color green
### circle ./c/inner/o/b
#### color yellow
## circle ./o/out
### color yellow
## connector ./x/1 ./i/in ./c/inner/i/a
## connector ./x/2 ./c/inner/o/b ./o/out
	
