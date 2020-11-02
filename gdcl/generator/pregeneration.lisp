
(in-package :godot-ecl/generator)


(defun pregenerate-binding (cstore data)
  (flet ((global-c-struct-ptr (struct-name global-name)
           `(ffi:clines ,(format nil "const ~A* ~A;" struct-name global-name)))
         (global-c-struct-var (c-global lisp-global lisp-struct)
           `(ffi:def-foreign-var (,c-global ,lisp-global) ,lisp-struct :default))
         (field (name)
           (list name :pointer-void))
         (binding-func (name arg-types ret-type c-global c-name)
           `(ffi:defcbody ,name ,arg-types ,ret-type
              ,(format nil "~A->~A(~{#~D~^, ~})"
                       c-global c-name (gdcl/utils:count-up-to (length arg-types)))))
         (struct (name fields)
           `(ffi:def-struct ,name ,@fields)))

    (do ((api (new-api-definition data) (api-next api)))
        ((null api))
      (let ((api-c-struct (api-c-struct-name api))
            (api-c-global (api-c-global-name api))
            (api-l-struct (api-lisp-struct-name api))
            (api-l-global (api-lisp-global-name api)))

        (add-global cstore (global-c-struct-ptr api-c-struct api-c-global))
        (add-global cstore (global-c-struct-var api-c-global api-l-global api-l-struct))
        (add-export cstore api-l-global)

        (let ((fields ()))
          (dolist (fn (nreverse (api-functions api)))
            (let ((fn-name (fn-name fn))
                  (fn-arg-names (fn-argument-names fn))
                  (fn-arg-types (fn-argument-types fn))
                  (fn-ret-type (fn-return-type fn))
                  (fn-c-name (fn-c-name fn)))

              (push (field fn-name) fields)
              (add-function cstore (binding-func fn-name fn-arg-types
                                              fn-ret-type api-c-global fn-c-name))
              (add-export cstore fn-name)))

          (when (and (string= (api-type api) "CORE")
                     (api-is-version-1.0? api))
            (push `(,(intern "EXTENSIONS")
                    (* (* ',(intern "GODOT-GDNATIVE-API-STRUCT")))) fields)
            (push `(,(intern "NUM-EXTENSIONS") :unsigned-int) fields))

          (push `(,(intern "NEXT")
                  (* ',(intern "GODOT-GDNATIVE-API-STRUCT"))) fields)
          (push `(,(intern "VERSION") ',(intern "GODOT-GDNATIVE-API-VERSION")) fields)
          (push `(,(intern "TYPE") :unsigned-int) fields)

          (let ((api-l-struct (api-lisp-struct-name api)))
            (add-type cstore (struct api-l-struct fields))
            (add-export cstore api-l-struct)))))
    cstore))


;(let* ((api (gdcl/utils:load-json #P"./godot_headers/gdnative_api.json"))
;      (core-api (gdcl/utils:assoc-cdr :core api))
;      (code-store (new-code-storage)))
;  (pregenerate-core-binding code-store core-api)
;  (with-open-file (out "core.lisp" :direction :output :if-exists :supersede)
;    (print (get-all-items code-store) out)))
