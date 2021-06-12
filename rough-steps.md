# rename .
## rewritedot <app.md >app1.md
## rewritedot <sub.md >sub1.md

# rewrite using hierarchical notation (machine readable)
## rewritehierarcical <app1.md >app2.md
## rewritehierarcical <sub1.md >sub2.md

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
