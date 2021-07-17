(defun design-rule-fail (s)
  (error s))

(defun design-rule-must-use-component-namespace (rid)
  (let ((nsname (ns rid)))
    (unless (and (stringp nsname) (string= "c" nsname))
      (design-rule-fail (format nil "must use component namespace \"c\" (~a)" nsname)))))

(defun design-rule-must-use-input-namespace (rid)
  (let ((nsname (ns rid)))
    (unless (and (stringp nsname) (string= "i" nsname))
      (design-rule-fail (format nil "must use input namespace \"i\" (~a)" nsname)))))

(defun design-rule-must-use-output-namespace (rid)
  (let ((nsname (ns rid)))
    (unless (and (stringp nsname) (string= "o" nsname))
      (design-rule-fail (format nil "must use output namespace \"o\" (~a)" nsname)))))

(defun design-rule-must-use-connection-namespace (rid)
  (let ((nsname (ns rid)))
    (unless (and (stringp nsname) (string= "x" nsname))
      (design-rule-fail (format nil "must use connection namespace \"x\" (~a)" nsname)))))

(defun design-rule-must-use-io-namespace (rid)
  (let ((nsname (ns rid)))
    (unless (and (stringp nsname) (or (string= "i" nsname) (string= "o" nsname)))
      (design-rule-fail (format nil "must use i/o namespace \"i\" or \"o\" (~a)" nsname)))))

(defun design-rule-input-pin-must-not-be-defined-more-than-once (component namespace name)
  (declare (ignore namespace))
  (multiple-value-bind (ns ok)
      (gethash "i" (namespaces component))
    (declare (ignore ok))
    (multiple-value-bind (val success)
	(gethash name ns)
      (declare (ignore val))
      (when success
	(design-rule-fail (format nil "input pin must not be defined more than once ~a" name))))))


(defun design-rule-output-pin-must-not-be-defined-more-than-once (component namespace name)
  (declare (ignore namespace))
  (multiple-value-bind (ns ok)
      (gethash "o" (namespaces component))
    (declare (ignore ok))
    (multiple-value-bind (val success)
	(gethash name ns)
      (declare (ignore val))
      (when success
	(design-rule-fail (format nil "output pin must not be defined more than once ~a" name))))))

(defun design-rule-must-be-a-valid-namespace (rid)
  (let ((namespace (ns rid)))
    (unless (or (string= namespace "i") (string= namespace "o") (string= namespace "c") (string= namespace "n"))
	(design-rule-fail (format nil "must be a valid namespace ~a" rid)))))

(defun design-rule-value-must-exist (component namespace name)
  (multiple-value-bind (ns ok) 
      (gethash namespace (namespaces component))
    (declare (ignore ok))
    (multiple-value-bind (v success)
	(gethash name ns)
      (declare (ignore v))
      (unless success
	(design-rule-fail (format nil "value must exist ~a ~a ~a" component namespace name))))))

(defun design-rule-value-must-not-exist (component namespace name)
  (multiple-value-bind (ns ok) 
      (gethash namespace (namespaces component))
    (declare (ignore ok))
    (multiple-value-bind (v success)
	(gethash name ns)
      (declare (ignore v))
      (when success
	(design-rule-fail (format nil "value must not exist ~a ~a ~a" component namespace name))))))

(defun design-rule-must-be-a-component (x)
  (unless (eq 'component (type-of x))
    (design-rule-fail (format nil "must be a component ~a" x))))
    

