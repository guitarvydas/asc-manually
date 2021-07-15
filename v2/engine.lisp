(defun def% (rid)
  (cond ((eq 'yes (is-leaf (path rid)))
	 (design-rule-component-must-not-exist (path rid))
	 (def-component-raw (path rid)))
	((eq 'no is-leaf (path rid))
	 (def-path-component (path rid))
	 (let ((path-component (get (path rid)))
	       (def (create-rid path-component (ns rid) (name rid))))))
	(t (panic (format nil "def %a" rid)))))

(defun get% (rid)
  (cond ((eq 'yes (is-leaf (path rid)))
	 (design-rule-component-name-must-exist (path rid))
	 (let ((component-name (lookup-component (path rid))))
	   (design-rule-namespace-must-exist component-name (ns rid))
	   (design-rule-value-must-exist component-name (ns rid) (name rid))
	   (lookup-value component-name (ns rid) (name rid))))

	((eq 'no (is-leaf (path rid)))
	 (let ((component (get (path rid))))
	   (design-rule-path-must-be-a-component component)
	   (get% (create-rid component ns name))))
	
	(t (panic (format nil "get %a" rid)))))

(defun set% (rid val)
  (cond ((eq 'yes is-leaf (path rid))
	 (design-rule-component-must-exist (path rid))
	 (let ((component-name (lookup-component (path rid))))
	   (design-rule-namespace-must-exist component-name (ns rid))
	   (design-rule-value-must-not-exist component-name (ns rid) (name rid))
	   (set-value-raw component-name (ns rid) (name rid))))

	((eq 'no is-leaf (path rid))
	 (let ((component (get% (path rid))))
	   (design-rule-path-must-be-a-component component)
	   (set% (create-rid component (ns rid) (name rid)))))

	(t (panic (format nil "set %a" rid)))))



(defparameter *top-level-components* (make-hash-table :test 'equal))

(defun design-rule-component-must-not-exist (cname)
  (multiple-value-bind (c success)
      (gethash *top-level-components* cname)
    (declare (ignore c))
    (unless (not success)
      (design-rule-fail (format nil "component must not exist ~a" cname)))))

(defun design-rule-component-name-must-exist (cname)
  (multiple-value-bind (c success)
      (gethash *top-level-components* cname)
    (declare (ignore c))
    (unless (not success)
      (design-rule-fail (format nil "component name exist ~a" cname)))))

(defun design-rule-namespace-must-exist (c ns)
  (multiple-value-bind (namespace success)
      (gethash ns c)
    (declare (ignore ns))
    (unless success
      (design-rule-fail (format nil "namespace must exist ~a" (list c ns))))))

(defun design-rule-value-must-not-exist (c ns name)
  (multiple-value-bind (v success)
      (gethash name (gethash ns c))
    (unless (not success)
      (design-rule-fail (format nil "value must not exist ~a" (list c ns name))))))
(defun design-rule-value-must-exist (c ns name)
  (multiple-value-bind (v success)
      (gethash name (gethash ns c))
    (unless success
      (design-rule-fail (format nil "value must exist ~a" (list c ns name))))))

(defun design-rule-path-must-be-a-component (c)
  (unless (typeof c 'component)
    (design-rule-fail (format nil "path must be a component ~a" c))))
