
(in-package :godot-ecl/ffi)

(defmacro c-include (name)
  `(ffi:clines ,(format nil "#include <~A>" name)))

(defmacro c-type-size (name)
  `(ffi:c-inline () () :uint64-t ,(format nil "sizeof(~A)" name)
                       :side-effects nil :one-liner t))

(defmacro c-union-cast (from-type to-type value &key custom-c-from-type custom-c-to-type)
  (let ((c-from-type (or custom-c-from-type
                         (gdcl/utils:name-to-string from-type)))
        (c-to-type (or custom-c-to-type
                       (gdcl/utils:name-to-string to-type))))
    `(ffi:c-inline (,value) (,from-type) ,to-type
                   ,(format nil "{ union { ~A from; ~A to; } uc; uc.from = #0; @(return) = uc.to; }"
                            c-from-type c-to-type))))


(defmacro c-get-member (value typename fieldname resultype &key ptr)
  `(ffi:c-inline (,)))
