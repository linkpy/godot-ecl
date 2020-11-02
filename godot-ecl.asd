
(defsystem "godot-ecl"
  :description "Common Lisp for Godot, backed by ECL."
  :version "0.0.1"
  :author "Princess Pancake <nils.reid@neoshadow.co>"
  :licence "MIT"
  :depends-on ("cl-json" "split-sequence" "asdf" "uiop" "alexandria")
  :pathname "./gdcl/"
  :components (
               ;; gdcl/utils

               (:module "utils"
                :components ((:file "package")))

               ;; gdcl/ffi

               (:module "ffi"
                :serial t
                :components ((:file "package")
                             (:file "c")
                             (:file "grovel")))

               ;; gdcl/generator

               (:module "generator"
                :depends-on ("utils")
                :components ((:file "package")
                             (:file "code-storage"
                              :depends-on ("package"))
                             (:file "api"
                              :depends-on ("package"))
                             (:file "pregeneration"
                              :depends-on ("code-storage"
                                           "api"))))

               ;; gdcl/binding

               (:module "binding"
                :depends-on ("generator" "ffi")
                :serial t
                :components ((:file "package")
                             (:file "macros")
                             (:file "types")
                             (:file "gdnative")
                             (:file "entry")))))
