
(in-package :godot-ecl/ffi)


(eval-when (compile)
  (defun grovel (cc-flags ld-flags code-list)
    (let* ((tmp-dir (uiop:temporary-directory))
           (filep (merge-pathnames #P"gdcl-grovel-tmp.lisp" tmp-dir))
           (outfilep (merge-pathnames #P"gdcl-grovel-tmp.o" tmp-dir))
           (exefilep (merge-pathnames #P"gdcl-grovel-tmp" tmp-dir)))

      (with-open-file (out filep :direction :output :if-exists :supersede)
        (print '(in-package #:cl-user) out)
        (print `(progn ,@(map 'list #'walker:macroexpand-all code-list)) out)
        (print '(ext:exit) out))

      (let ((c:*user-cc-flags* cc-flags)
            (c:*user-ld-flags* ld-flags))
        (compile-file filep :system-p t :output-file outfilep :verbose nil)
        (c:build-program exefilep :lisp-files (list outfilep)))

      (let ((txt (uiop:run-program (namestring exefilep) :output :string)))
        (with-input-from-string (inps txt)
          (do ((result () (push (read inps) result)))
              ((not (listen inps)) (nreverse result)))))))


  (defmacro grovel-body ((&key cc-flags ld-flags) &body code)
    `(list ,@(grovel code cc-flags ld-flags)))

  (defmacro grovel-list (code-list &key cc-flags ld-flags)
    `(list ,@(grovel code-list cc-flags ld-flags)))


  (defmacro with-grovel (vars (&key cc-flags ld-flags) codeform &body body)
    `(multiple-value-bind ,vars (values-list (grovel-list ,codeform cc-flags ld-flags)) ,@body)))

