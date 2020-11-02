
(in-package :godot-ecl/generator)


(defclass code-storage ()
  ((%exports :initform ())
   (%types :initform ())
   (%globals :initform ())
   (%functions :initform ())))



(defgeneric add-export (cstore export))
(defgeneric add-type (cstore type))
(defgeneric add-global (cstore global))
(defgeneric add-function (cstore func))
(defgeneric get-all-items (cstore))



(defun new-code-storage ()
  (make-instance 'code-storage))



(defmethod add-export ((cstore code-storage) export)
  (with-slots (%exports) cstore
    (push export %exports)))

(defmethod add-type ((cstore code-storage) type)
  (with-slots (%types) cstore
    (push type %types)))

(defmethod add-global ((cstore code-storage) global)
  (with-slots (%globals) cstore
    (push global %globals)))

(defmethod add-function ((cstore code-storage) func)
  (with-slots (%functions) cstore
    (push func %functions)))

(defmethod get-all-items ((cstore code-storage))
  (with-slots (%types %globals %functions) cstore
      (append
       (nreverse %types)
       (nreverse %globals)
       (nreverse %functions))))
