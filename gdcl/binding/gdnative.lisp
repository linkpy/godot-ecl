
(in-package :godot-ecl/binding)

;(with-open-file (out "core.lisp" :direction :output :if-exists :supersede)
;  (let ((*print-pretty* t))
;    (print (macroexpand '(%define-gdnative-types-and-functions)) out))
;  nil)

(%define-gdnative-types-and-functions)
