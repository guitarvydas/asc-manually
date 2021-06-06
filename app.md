# rect app
## text ./n/t1 "app"
## circle ./i/in
### color green
## rect ./c/layer1
### text ./layer1/n/t2 "./c/layer1"
### circle ./c/layer1/i/a
### color green
### circle ./c/layer1/o/b
### color yellow
## circle ./o/out
### color yellow

## connector ./x/1 ./i/in ./c/layer1/i/a
## connector ./x/2 ./c/layer1/o/b ./o/out
