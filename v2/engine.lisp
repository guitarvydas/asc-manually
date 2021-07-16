(defun def% (rid)
  (deep-define-path-creating-intermediaries rid))

(defun get% (rid)
  (let ((component (deep-get-component rid)))
    (design-rule-value-must-exist component (ns rid) (name rid))
    (raw-get-value component (ns rid) (name rid))))

(defun set% (rid val)
  (let ((component (deep-get-component rid)))
    (design-rule-value-must-not-exist component (ns rid) (name rid))
    (raw-set-value component (ns rid) (name rid) val)))

(defun deep-define-path-creating-intermediaries (rid)
  (design-rule-must-refer-to-component-namespace rid)
  (case (is-leaf (path rid))
    (yes
     (let ((name (path rid)))
       (let ((component (lookup-or-create-component-at-top-level name)))
	 component)))
    (no
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
     (design-rule-must-refer-to-component-namespace (ns rid))
     (let ((parent-component (deep-get-component (path rid))))
       (let ((component (lookup-contained-component parent-component (ns rid) (name rid))))
	 (design-rule-component-must-exist component)
	 component)))

    (otherwise (panic "case failure deep-get-component"))))


