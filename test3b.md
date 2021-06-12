# rect app
## rect ./c:inner
## circle ./i:in
## circle ./o:out
### rect ./c:inner/i:a
### rect ./c:inner/o:b
## connector ./x:1 ./i:in ./c:inner/i:1
## connector ./x:2 ./c:inner/o:2 ./o:out

## rect ./c:sub
### rect ./c:sub/i:x
### rect ./c:sub/o:y

## ignore ./x:1
## ignore ./x:2

## connector ./x:3 ./i:in ./c:sub/i:x
## connector ./x:4 ./c:sub/o:y ./o:out
