(defun design-rule-must-refer-to-component-namespace (nsname)
    (unless (and (stringp nsname) (string= "c" nsname))
      (design-rule-fail (format nil "namespace must be \"c\" (~a)" nsname))))

(defun design-rule-must-refer-to-input-namespace (nsname)
    (unless (and (stringp nsname) (string= "i" nsname))
      (design-rule-fail (format nil "namespace must be \"i\" (~a)" nsname))))

(defun design-rule-must-refer-to-output-namespace (nsname)
    (unless (and (stringp nsname) (string= "o" nsname))
      (design-rule-fail (format nil "namespace must be \"o\" (~a)" nsname))))

(defun design-rule-component-must-exist (c)
  (unless (eq 'component (type-of c))
      (design-rule-fail (format nil "component (~a) does not exist" c))))

(defun design-rule-value-must-not-exist (c ns name)
  (multiple-value-bind (v success)
      (gethash name (gethash ns (namespaces c)))
    (declare (ignore v))
    (unless (not success)
      (design-rule-fail (format nil "value must not exist ~a" (list c ns name))))))
(defun design-rule-value-must-exist (c ns name)
  (multiple-value-bind (v success)
      (gethash name (gethash ns (namespaces c)))
    (declare (ignore v))
    (unless success
      (design-rule-fail (format nil "value must exist ~a" (list c ns name))))))

(defun design-rule-input-must-not-already-exist (component ns name)
  (let ((input-ns (gethash "i" component)))
    (assert (eq input-ns ns))
    (multiple-value-bind (v success)
	(declare (ignore v))
      (when success
	(design-rule-fail (format nil "input must not already exist ~s" (list component name)))))))

(defun design-rule-output-must-not-already-exist (component ns name)
  (let ((output-ns (gethash "o" component)))
    (assert (eq output-ns ns))
    (multiple-value-bind (v success)
	(declare (ignore v))
      (when success
	(design-rule-fail (format nil "output must not already exist ~s" (list component name)))))))

(defun design-rule-must-be-a-component (x)
  (unless (eq 'component (type-of x))
    (design-rule-fail (format nil "must be a component ~a" x))))

(defun design-rule-fail (msg)
  (error msg))
