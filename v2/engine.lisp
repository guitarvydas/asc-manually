(defun def-component% (rid)
  (let ((component (deep-define-path-creating-intermediaries rid)))
    component))

(defun def-input% (rid)
  (design-rule-must-refer-to-input-namespace (ns rid))
  (let ((component (deep-get-component (path rid))))
    (design-rule-input-must-not-already-exist component (ns rid) (name rid))
    (create-raw-input component (ns rid) (name rid))))

(defun def-output% (rid)
  (design-rule-must-refer-to-output-namespace (ns rid))
  (let ((component (deep-get-component (path rid))))
    (design-rule-output-must-not-already-exist component (ns rid) (name rid))
    (create-raw-output component (ns rid) (name rid))))

(defun get% (rid)
  (let ((component (deep-get-component rid)))
    (design-rule-value-must-exist component (ns rid) (name rid))
    (raw-get-value component (ns rid) (name rid))))

(defun set% (rid val)
  (let ((component (deep-get-component rid)))
    (design-rule-value-must-not-exist component (ns rid) (name rid))
    (raw-set-value component (ns rid) (name rid) val)))

(defun deep-define-path-creating-intermediaries (rid)
  (case (is-leaf (path rid))
    (yes
     (let ((name (path rid)))
       (let ((component (lookup-or-create-component-at-top-level name)))
	 component)))
    (no
     (design-rule-must-refer-to-component-namespace (ns rid))
     (let ((parent-component (deep-define-path-creating-intermediaries (path rid))))
       (let ((component (lookup-or-create-contained-component parent-component (ns rid) (name rid))))
	 component)))
    (otherwise (panic "case failure deep-define-path-creating-intermediaries"))))
  

(defun deep-get-component (rid)
  (case (is-leaf (path rid))
    (yes
     (let ((component (lookup-component-at-top-level (path rid))))
       (design-rule-component-must-exist component)
       component))

    (no
     (let ((path (deep-get-component (path rid))))
       (design-rule-must-refer-to-component-namespace (ns rid))
       (design-rule-value-must-exist path (ns rid) (name rid))
       (let ((component (resolve-component-raw path (ns rid) (name rid))))
	 (design-rule-must-be-a-component component)
	 component)))

    (otherwise (panic (format nil "case failure deep-get-component" rid)))))


