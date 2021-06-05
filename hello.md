# rect hello
## text ./n/t1 "hello"
## rect ./c/1
### text ./c/hello/n/t1 "object_hello\nb/greet < >(string)"
## rect ./c/2
### rect ./c/2/i/1
#### color green
### rect ./c/2/o/1
#### color yellow
### text ./c/2/t2 "object_hello/greet ()"
## circle ./i/1
### color green
## circle ./o/1
### color yellow


## connector ./x/1 ./i/1 ./c/2/i/1
## connector ./x/2 ./c/2/o/1 ./o/1

