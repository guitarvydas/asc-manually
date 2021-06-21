(defun new-hw23 ()
  (let ((hw23 (new-hwsub)))
    (setter-kind hw23 "hw23")
    (forget-connection hw23 "x/1")
    (forget-connection hw23 "x/2")    

    (let ((hwhello (new-hwhello)))
      (add-child hw23 hwhello)

      (add-connection hw23 (iport hw23 "A") (iport hwhello "in"))
      (add-connection hw23 (oport hwhello "out") (oport hw23 "B"))
