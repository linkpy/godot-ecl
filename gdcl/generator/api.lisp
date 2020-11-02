
(in-package :godot-ecl/generator)



(defclass function-definition ()
  (%name %return-type %arguments))

(defgeneric fn-c-name (api-fn))
(defgeneric fn-c-return-type (api-fn))
(defgeneric fn-c-arguments (api-fn))
(defgeneric fn-argument-c-names (api-fn))
(defgeneric fn-argument-c-types (api-fn))
(defgeneric fn-name (api-fn))
(defgeneric fn-return-type (api-fn))
(defgeneric fn-arguments (api-fn))
(defgeneric fn-argument-names (api-fn))
(defgeneric fn-argument-types (api-fn))



(defun new-function-definition (data)
  (let ((fn-def (make-instance 'function-definition)))
    (with-slots (%name %return-type %arguments) fn-def
      (setf %name (gdcl/utils:assoc-cdr :name data))
      (setf %return-type (gdcl/utils:assoc-cdr :return--type data))
      (setf %arguments (gdcl/utils:assoc-cdr :arguments data))
      fn-def)))

(defmethod fn-c-name ((api-fn function-definition))
  (slot-value api-fn '%name))

(defmethod fn-c-return-type ((api-fn function-definition))
  (slot-value api-fn '%return-type))

(defmethod fn-c-arguments ((api-fn function-definition))
  (slot-value api-fn '%arguments))

(defmethod fn-argument-c-names ((api-fn function-definition))
  (map 'list #'second (fn-c-arguments api-fn)))

(defmethod fn-argument-c-types ((api-fn function-definition))
  (map 'list #'first (fn-c-arguments api-fn)))

(defmethod fn-name ((api-fn function-definition))
  (gdcl/utils:string-to-name (fn-c-name api-fn)))

(defmethod fn-return-type ((api-fn function-definition))
  (gdcl/utils:convert-c-type-to-ffi (fn-c-return-type api-fn)))

(defmethod fn-arguments ((api-fn function-definition))
  (map 'list
       (lambda (arg)
         (list
          (gdcl/utils:string-to-name (first arg))
          (gdcl/utils:convert-c-type-to-ffi (second arg))))
       (fn-c-arguments api-fn)))

(defmethod fn-argument-names ((api-fn function-definition))
  (map 'list
       (lambda (name)
         (gdcl/utils:string-to-name name))
       (fn-argument-c-names api-fn)))

(defmethod fn-argument-types ((api-fn function-definition))
  (map 'list #'gdcl/utils:convert-c-type-to-ffi (fn-argument-c-types api-fn)))




(defclass api-definition ()
  (%name %type %version %next %members))


(defgeneric api-name (api-def))
(defgeneric api-type (api-def))
(defgeneric api-version (api-def))
(defgeneric api-version-major (api-def))
(defgeneric api-version-minor (api-def))
(defgeneric api-is-version-1.0? (api-def))
(defgeneric api-next (api-def))
(defgeneric api-has-next? (api-def))
(defgeneric api-members (api-def))
(defgeneric api-functions (api-def))
(defgeneric api-c-struct-name (api-def))
(defgeneric api-lisp-struct-name (api-def))
(defgeneric api-c-global-name (api-def))
(defgeneric api-lisp-global-name (api-def))


(defun new-api-definition (data)
  (let ((api-def (make-instance 'api-definition))
        (name-v (assoc :name data)))
    (with-slots (%name %type %version %next %members) api-def
      (setf %name (if name-v (cdr name-v) "core"))
      (setf %type (gdcl/utils:assoc-cdr :type data))
      (setf %version (gdcl/utils:assoc-cdr :version data))
      (setf %next (gdcl/utils:assoc-cdr :next data))
      (setf %members (gdcl/utils:assoc-cdr :api data))
      api-def)))

(defmethod api-name ((api-def api-definition))
  (slot-value api-def '%name))

(defmethod api-type ((api-def api-definition))
  (slot-value api-def '%type))

(defmethod api-version ((api-def api-definition))
  (slot-value api-def '%version))

(defmethod api-version-major ((api-def api-definition))
  (gdcl/utils:assoc-cdr :major (api-version api-def)))

(defmethod api-version-minor ((api-def api-definition))
  (gdcl/utils:assoc-cdr :minor (api-version api-def)))

(defmethod api-is-version-1.0? ((api-def api-definition))
  (and (= (api-version-major api-def) 1)
       (= (api-version-minor api-def) 0)))

(defmethod api-next ((api-def api-definition))
  (if (api-has-next? api-def)
      (new-api-definition (slot-value api-def '%next))
      nil))

(defmethod api-has-next? ((api-def api-definition))
  (not (eq (slot-value api-def '%next) nil)))

(defmethod api-members ((api-def api-definition))
  (slot-value api-def '%members))

(defmethod api-functions ((api-def api-definition))
  (map 'list #'new-function-definition (api-members api-def)))

(defmethod api-c-struct-name ((api-def api-definition))
  (if (string-equal (api-type api-def) "core")
      (if (api-is-version-1.0? api-def)
          "godot_gdnative_core_api_struct"
          (format nil "godot_gdnative_core_~D_~D_api_struct"
                  (api-version-major api-def)
                  (api-version-minor api-def)))
      (if (api-is-version-1.0? api-def)
          (format nil "godot_gdnative_ext_~A_api_struct"
                  (api-name api-def))
          (format nil "godot_gdnative_ext_~A_~D_~D_api_struct"
                  (api-name api-def)
                  (api-version-major api-def)
                  (api-version-minor api-def)))))

(defmethod api-lisp-struct-name ((api-def api-definition))
  (gdcl/utils:string-to-name
   (format nil "GODOT-GDNATIVE-~A-~D.~D-STRUCT"
           (api-name api-def)
           (api-version-major api-def)
           (api-version-minor api-def))))

(defmethod api-c-global-name ((api-def api-definition))
  (format nil "_gdcl_api_~A_~D_~D"
          (api-name api-def)
          (api-version-major api-def)
          (api-version-minor api-def)))

(defmethod api-lisp-global-name ((api-def api-definition))
  (gdcl/utils:string-to-name
   (format nil "GODOT-GDNATIVE-~A-~D.~D"
           (api-name api-def)
           (api-version-major api-def)
           (api-version-minor api-def))))

