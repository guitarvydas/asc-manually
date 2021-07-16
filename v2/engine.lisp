(defun def% (rid)
  (cond ((eq 'yes (is-leaf (path rid)))
	 (design-rule-component-must-not-exist (path rid))
	 (def-component-raw (path rid)))
	((eq 'no (is-leaf (path rid)))
	 (def-path-component (path rid))
	 (let ((path-component (get% (path rid))))
           (def% (create-rid path-component (ns rid) (name rid)))))
	(t (panic (format nil "def %a" rid)))))

(defun get% (rid)
  (cond ((eq 'yes (is-leaf (path rid)))
	 (design-rule-component-name-must-exist (path rid))
	 (let ((component-name (lookup-component-top-level (path rid))))
	   (design-rule-namespace-must-exist component-name (ns rid))
	   (design-rule-value-must-exist component-name (ns rid) (name rid))
	   (lookup-value component-name (ns rid) (name rid))))

	((eq 'no (is-leaf (path rid)))
	 (let ((component (get% (path rid))))
	   (design-rule-path-must-be-a-component component)
	   (get% (create-rid component (ns rid) (name rid)))))
	
	(t (panic (format nil "get %a" rid)))))

(defun set% (rid val)
  (cond ((eq 'yes (is-leaf (path rid)))
	 (design-rule-component-name-must-exist (path rid))
	 (let ((component-name (lookup-component-top-level (path rid))))
	   (design-rule-namespace-must-exist component-name (ns rid))
	   (design-rule-value-must-not-exist component-name (ns rid) (name rid))
	   (set-value-raw component-name (ns rid) (name rid) val)))

	((eq 'no (is-leaf (path rid)))
	 (let ((component (get% (path rid))))
	   (design-rule-path-must-be-a-component component)
	   (set% (create-rid component (ns rid) (name rid)) val)))

	(t (panic (format nil "set %a" rid)))))



