
;; templates
(defmacro defasc (name components initially &rest react)
  `(defstruct ,name
     %components ,components
     %initially  ,initially
     %rect       ,react))

(defmacro defssc (name initially react)
  `(defstruct ,name
     %initially  ,initially
     %rect       ,react))
  

;; runnable
;; "reify" is defined as "make (something abstract) more concrete or real."
;; I think of "loading" as an incremental action.  Two files should be joined together and mostly-loaded-but-not-quite.
(defmacro reifyAsc () ...)
(defmacro reifySsc () ...)



(defun send 
