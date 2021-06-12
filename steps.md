# 0. 3 diagrams
## 0a 
	resolve ./ to app top-level name
## 0b
	convert names into machine readable form
	e.g. app/c/inner -> (app c inner)
	e.g. hwhello/c/2/o/1 -> ((hwhello c 2) o 1)
# 1 merge 3 into 2 
	(hwhello merged into hwsub)
## 1a
	in hwhello: rename "hwhello" -> "(hwsub c hwhello)"
	-> (((hwsub c hwhello) c 2) i 1)
	-> (((hwsub c hwhello) c 2) i 1)
	-> (((hwsub c hwhello) c 2) o 1)
	((hwhello c 2) o 1) -> (((hwsub c hwhello) c 2) o 1)
	
## 1b
	in hwsub: orphan 2 connections

## 1c
	in hwsub: create new connections
	
## 1d
	(hwsub + hwhello) -> hw1.md

# 2 merge 2+3 into 1
	merge hw1.md with hw.md
	similar steps as in 1a-1d
## 2a
	in hw1.md: rename "hwsub" -> "(app c hwsub)"
## 2b
	in hw: orphan 2 connections
## 2c
	in hw: create new connections
## 2d
	merge hw1+hw -> hwfinal.md
	
# final
	remove "dead code": (app c inner) and (app c hwsub)
	(a component is "dead" if all of its inputs are N/C)
	(can there be "volatile" components? not dead although all inputs are N/C?)



# rename .
# rewrite using hierarchical notation (machine readable)

> step1.bash
creates hw_e.md, hwsub_e.md, hwhello_e.md (for machine readability)
(creates hw.fb, hwsub.fb, hwhello.fb -- pretty printed .mds, for human-readability)

# 3. remove "# rect ???" line
	>> sed -E -e '/^# rect/d' <hw_e.md >hw_1.md
	>> sed -E -e '/^# rect/d' <hwsub_e.md >hwsub_1.md
	>> sed -E -e '/^# rect/d' <hwhello_e.md >hwhello_1.md
    > step3.bash	

## 4. goal: merge hwhello into hwsub
### demote hwhello
	-- change each ^# to ^##
	awk -f step4.awk <hwhello_1.md >hwhello_4.md
    -- change "hwhello" to "(app c hwhello)"
    awk -f step4a.awk <hwhello_4.md >hwhello_4a.md

-- here --
# create new connections and obsolete old connections
	ignore connector (hwsub x 1) 
	ignore connector (hwsub x 2)
    -> hwsub_5.md

## goal: merge hwsub into hw
...



# demote sub
## s/sub/{app c sub}/g except in strings
## demote app <sub2.md >sub3.md

# no need to remove {app c inner}
## dummy component can remain in app

# create new connections and obsolete old connections
## rewrite nx connection {{app c inner} i a} -> {{app c sub} i x}
## and rewrite nx connection {{app c inner} i a} -> {{app c sub} o y}
## ignore connector {app x 1}
## ignore connector {app x 2}
### fixupconnections ... <app2.md >app4.md

# merge sub into app
## merge app3.md sub4.md >app5.md
