
(declaim (optimize (debug 3) (speed 0) (space 0) (safety 3)))

(defparameter +godot-headers-path+
  (asdf:system-relative-pathname :godot-ecl "./godot_headers/"))

(let ((c:*user-cc-flags* (format nil "-I~A" +godot-headers-path+)))
  (asdf:make-build :godot-ecl
                   :type :shared-library
                   :move-here #P"./"
                   :monolithic t
                   :init-name "_gdcl_module_init"))
