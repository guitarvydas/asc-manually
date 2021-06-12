# rename .
	renamed to hw1.md, hwsub1.md and hwhello1.md
	
# rewrite using hierarchical notation (machine readable)
	renamed to hw2.md, hwsub2.md and hwhello2.md

# demote hwhello
	rewritten as hwhello3.md
	remove '# rect hwhello"
	
# no need to remove (app c inner)
## dummy component can remain in app

# create new connections and obsolete old connections
## create hwsub4.md
## rewrite nx connection (((app c hwsub) c hwhello)  i r) -> (((app c hwsub) c hwhello) i r)
## rewrite nx connection (((app c hwsub) c hwhello)  o s) -> (((app c hwsub) c hwhello) o s)

# merge hwhello into hwsub
## creates hwsub5.md <- hwsub4.md + hwhello3.md

# repeat

## demote hwsub5.md
## creates hwsub6.md

## create new connections and obsolete old connections
### create hw7.md <- hw2.md
### ignore connector (app x 1) and (app x 2)

## merge sub' into hw
## "rect sub" -> "rect (app c sub)"
### hw8.md <- hw7.md + hwsub6.md
...
