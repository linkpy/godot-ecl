(ffi:def-struct foo (a :unsigned-int)
  (b    (* :char))
  (c    (:array :int 10))
  (next :pointer-self))


(defun test ()
  (ffi:c-inline (arg) ('foo) :void ""))
