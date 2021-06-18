# rect "app"
## connector ./x/1 ./i/in ./c/hwsub/i/xx
## connector ./x/2 ./c/hwsub/o/yy ./o/out
## circle ./i/in
### color green
## circle ./o/out
### color yellow
## rect "hwsub"
### connector ./x/1 ./i/xx ./c/hwsub/i/1
### connector ./x/2 ./c/hwsub/o/1 ./o/yy
### circle ./i/xx
#### color green
### circle ./o/yy
#### color yellow
### rect "hwhello"
#### connector ./x/1 ./i/1 ./c/1/i/1
#### connector ./x/2 ./c/1/o/1 ./o/1
#### circle ./i/1
##### color green
#### circle ./o/1
##### color yellow
#### rect ""
#### circle ./i/1
##### color green
#### circle ./o/1
##### color yellow
#### text ./n/t "greet"

