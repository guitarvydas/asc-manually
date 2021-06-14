(defmacro defasctype (strname &rest fields)
  `(defstruct ,(intern (string-upcase strname))
     (%name ,strname)
     ,@fields))
(defparameter *asctypes*
  (make-hash-table :test 'equal))

(defun asctypes-initially ()
  (setf (gethash "component" *asctypes*) (list component-initially component-new))
  (setf (gethash "composite" *asctypes*) composite-initially)
  (setf (gethash "compositeRunnable" *asctypes*) compositeRunnable-initially)
  (setf (gethash "leafRunnable" *asctypes*) leafRunnable-initially)
  (setf (gethash "connection" *asctypes*) connection-initially)
  (setf (gethash "message" *asctypes*) message-initially)
  (setf (gethash "namespace" *asctypes*) nil)
  (setf (gethash "input" *asctypes*) input-initially)
  (setf (gethash "output" *asctypes*) output-initially)
  (setf (gethash "sender" *asctypes*) sender-initially)
  (setf (gethash "receiver" *asctypes*) receiver-initially)
  (setf (gethash "queue" *asctypes*) queue-initially)
  (setf (gethash "runnable" *asctypes*) runnable-initially)
  (setf (gethash "name" *asctypes*) name-initially))
  
(defasctype "component"
  kind
  inputs
  outputs)

(defun component-initially (self)
)

(defun component-new ()
  (let ((self (make-component)))
    (setf (kind self) "component")
    (setf (inputs self) (input-new))
    (setf (outputs self) (output-new))
    self))
 
(defgeneric initially (self))
(defgeneric react (self message))
(defasctype "composite"
  kind
  inputs
  outputs
  children
  connections)

(defun composite-initially ()
  )

(defun composite-new ()
  (let ((self (make-component)))
    (setf (kind self) "composite")
    (setf (inputs self) (input-new))
    (setf (outputs self) (output-new))
    (setf (children self) (namespace-new))
    (setf (connections self) (namespace-new))
    self))
  
(defasctype "compositeRunnable"
  kind
  inputs
  outputs
  children
  connections

  inputQueue
  outputQueue)

(defun compositeRunnable-initially ())

(defun compositeRunnable-new ()
  (let ((self (make-compositeRunnable)))
    (setf (kind self) "compositeRunnable")
    (setf (inputs self) (new "namespace" "input"))
    (setf (outputs self) (new "namespace" "output"))
    (setf (children self) (new "namespace" "component"))
    (setf (connections self) (new "namespace" "connection"))
    (setf (inputQueue self) (new "queue"))
    (setf (outputQueue self) (new "queue"))
    self))
(defasctype "leafRunnable"
  kind
  inputs
  outputs

  inputQueue
  outputQueue)

(defun leafRunnable-initially (self))

(defun leafRunnable-new ()
  (let ((self (make-leafRunnable)))
    (setf (kind self) "compositeRunnable")
    (setf (inputs self) (new "namespace" "input"))
    (setf (outputs self) (new "namespace" "output"))
    (setf (inputQueue self) (new "queue"))
    (setf (outputQueue self) (new "queue"))
    self))

(defasctype "connection"
  name
  sender
  receiver)

(defun connection-initially () )

(defun connection-new (name sender receiver)
  (let ((self (make-connection)))
    (setf (name self) (name-new self name))
    (setf (sender self) (sender-new self sender))
    (setf (receiverer self) (receiver-new self receiver))
    self))

(defasctype "sender"
  component
  tag)

(defasctype "receiver"
  component
  tag)

(defun sender-initially ())

(defun sender-new (component tag)
  (let ((self (make-sender)))
    (setf (component self) component)
    (setf (tag self) tag)
    self))

(defun receiver-initially ())

(defun receiver-new (component tag)
  (let ((self (make-receiver)))
    (setf (component self) component)
    (setf (tag self) tag)
    self))

(defstruct message
  tag
  data)

(defun message-initially ())

(defun message-new (tag data)
  (let ((self (make-message)))
    (set (tag self) tag)
    (set (data self) data)
    self))
  
(defasctype "namespace"
  hashtable
  itemKind)

(defun namespace-initially (kind))

(defun namespace-new (kind)
  (let ((self (make-namespace)))
    (setf (namespace-hashtable self) (make-hash-table :test 'equal))
    (setf (namespace-itemKind self) kind)
    self))
(defasctype "input"
  data)

(defun input-initially ())

(defun input-new ()
  (let ((self (make-input)))
    (name-new self)
    self))
(defstruct output
  data)

(defun output-initially ())

(defun output-new ()
  (let ((self (make-output)))
    (name-new self)
    self)
(defasctype "queue"
  q)

(defun queue-initially ())

(defun queue-new ()
  (let ((self (make-queue)))
    (setf (q self) nil)
    self))

(defasctype "runnable"
  inputQueue
  outputQueue)

(defun runnable-initially ())

(defun runnable-new ()
  (let ((self (make-runnable)))
    (setf (inputQueue self) (inputQueue-new))
    (setf (outputQueue self) (outputQueue-new))
    self))

(defgeneric /busy (self))
(defgeneric /ready (self))

(defgeneric /popInputQueue (self))
(defgeneric /interateOutputs (self))
(defasctype "name"
    str)

(defun name-initially ()
)  

(defun name-new (str)
  (let ((self (make-name)))
    (setf (str self) str)
    self))
