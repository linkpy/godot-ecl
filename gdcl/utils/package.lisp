
(defpackage :godot-ecl/utils
  (:nicknames :gdcl/utils)
  (:use :cl)
  (:export :elt-cdr :assoc-cdr :string-to-name :name-to-string
   :convert-c-type-to-ffi :count-up-to :load-json))

(in-package :godot-ecl/utils)



(defmacro elt-cdr (list n)
  `(cdr (elt ,list ,n)))

(defmacro assoc-cdr (item alist)
  `(cdr (assoc ,item ,alist)))


(defun string-to-name (s &optional (pkg *package*))
  (intern (string-upcase (substitute #\- #\_ s)) pkg))

(defun name-to-string (name)
  (substitute #\_ #\- (string-downcase (string name))))

(defun convert-c-type-to-ffi (s)
  (let ((result ()))
    (dolist (p (split-sequence:split-sequence #\space s))
      (cond ((string= p "*") (push '* result))
            ((string= p "**") (setf result `(* (* ,(car result)))))
            ((string= p "void") (push :void result))
            ((string= p "char") (push :char result))
            ((string= p "wchar_t") (push (intern "GODOT-CHAR-TYPE") result))
            ((string= p "int") (push :int result))
            ((string= p "float") (push :float result))
            ((string= p "double") (push :double result))
            ((string= p "uint64_t") (push :uint64-t result))
            ((string= p "int64_t") (push :int64-t result))
            ((and (string/= p "const")
                  (string/= p "signed")) (push `',(string-to-name p) result))))
    (cond ((= (length result) 1) (car result))
          ((equal '(* :void) result) :pointer-void)
          ((equal '(* :char) result) :cstring)
          (t result))))

(defun count-up-to (num)
  (loop for n below num collect n))



(defun load-json (target-path)
  (with-open-file (in target-path)
    (json:decode-json in)))

