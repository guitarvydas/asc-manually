(defun design-rule-must-refer-to-component-namespace (nsname)
    (unless (and (stringp nsname) (string= "c" nsname))
      (design-rule-fail (format nil "namespace must be \"c\" (~a)" nsname))))

(defun design-rule-component-must-exist (c)
  (unless (eq 'component (type-of c))
      (design-rule-fail (format nil "component (~a) does not exist" c))))

(defun design-rule-value-must-not-exist (c ns name)
  (multiple-value-bind (v success)
      (gethash name (gethash ns c))
    (declare (ignore v))
    (unless (not success)
      (design-rule-fail (format nil "value must not exist ~a" (list c ns name))))))
(defun design-rule-value-must-exist (c ns name)
  (multiple-value-bind (v success)
      (gethash name (gethash ns c))
    (declare (ignore v))
    (unless success
      (design-rule-fail (format nil "value must exist ~a" (list c ns name))))))

(defun design-rule-fail (msg)
  (error msg))
