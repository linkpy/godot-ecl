
(defpackage :godot-ecl/generator
  (:nicknames :gdcl/gen)
  (:use :cl)
  (:export
   :new-code-storage :add-export :add-type :add-global :add-function :get-all-items
   :pregenerate-binding))

(in-package :godot-ecl/generator)

