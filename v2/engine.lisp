(defclass tag ()
  ((tag :accessor tag)))

(defmethod same-tag-p ((self tag) (other message))
  (same-p self (tag message)))

(defmethod same-tag-p ((self tag) (other tag))
  (equal (tag self) (tag other)))

(defclass message ()
  ((tag :accessor tag)
   (data :accessor data)))


(defclass asc-template ()
  ((ports :accessor ports)
   (dynamic-parent :accessor dynamic-parent)))

(defclass runnable-template ()
  ((q :accessor q :initform (make-instance 'two-way-queue))))

(defclass runnable (asc-template runnable-template)

(defmethod send-inwards ((self asc) (c component-tag) (message message))
  (push-onto-tail (self q) message))
(defmethod send-downwards ((self asc) (c component-tag) (message message))
(defmethod send-upwards ((self asc) (c component-tag) (message message))
  (push-onto-head (self q) (message))
