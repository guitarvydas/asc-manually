;; combine hw23 into app to produce hw123

;;;;; hw23 ;;;;;;;;

;;;;; hwhello.lisp ;;;;;;;

(defun hwhello-react (self message)
  (save-message self message)
  (econd
    ((eqtag message "./i/1")
     (let ((result (hello self message)))
       (send self "./o/1" result)))))

(defparameter *hwhello*
  `((:initially nil)
    (:react hwhello-react)))

;;;;; hwsub.lisp ;;;;;;;
(defun hw-react (self message)
  (save-message self message)
  (econd
   ((eqtag message "./i/x")
    (inject self "./c/1/i/r" (message self "./i/x")))
   ((eqtag message "./c/1/o/s")
    (send self "./o/y" (message self "./c/1/o/s")))))

(defparameter *hwsub/c/1-interface*
  '(:inputs ("./c/1/i/r")
    :outputs ("./c/1/o/s")))

(defparameter *hwsub*
  `((:initially nil)
    (:components '(("./c/1" *hwhello* *hwsub/c/1-interface*)))
    (:synonyms '("./c/1/i/r" "./c/i/1") ("./c/1/o/s" "./c/o/1"))
    (:react app-react)))


;;;;;; app ;;;;;;;;;

(defun app-react (message)  
  (save-message self message)
  (econd
   ((eqtag message "./i/in")
    (inject self "./c/1/i/a" (message self "./i/in")))
   ((eqtag message "./c/1/o/b")
    (send self "./o/out" (message self "./c/1/o/b")))))

(defparameter *app/c/1-interface*
  '(:inputs ("./c/1/i/a")
    :outputs ("./c/1/o/b")))

(defparameter *app*
  `((:initially nil)
    (:components '(("./c/1" *hwsub* *app/c/1-interface*)))
    (:synonyms '(("./c/1/i/a" "./c/i/in")
		 ("./c/1/o/b" "./c/o/out")))
    (:react app-react)))
