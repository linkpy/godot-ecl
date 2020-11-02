
(defpackage :godot-ecl/ffi
  (:nicknames :gdcl/ffi)
  (:use :cl)
  (:export
   :grovel :grovel-body :grovel-list :with-grovel
   :c-include :c-type-size :c-cast-void-pointer :c-deref))

(in-package :godot-ecl/ffi)
