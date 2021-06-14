(defmacro defasctype (strname &rest fields)
  `(defstruct ,(intern (string-upcase strname))
     (%name ,strname)
     ,@fields))
