
(in-package :godot-ecl/binding)

;;; Enums

(ffi:def-enum godot-variant-type
    (:nil :bool :int :real :string :vector2 :rect2 :vector3 :transform2d :plane :quat
     :aabb :basis :transform :color :node-path :rid :object :dictionary :array
     :pool-byte-array :pool-int-array :pool-real-array :pool-string-array
     :pool-vector2-array :pool-vector3-array :pool-color-array)
  :separator-string "/")

(ffi:def-enum godot-variant-call-error-error
    (:ok :invalid-method :invalid-argument :too-many-arguments :too-few-arguments
     :instance-is-null)
  :separator-string "/")

(ffi:def-enum godot-variant-operator
    (:op-equal :op-not-equal :op-less :op-less-equal :op-greater :op-greater-equal
     :op-add :op-substrat :op-multiply :op-divide :op-negate :op-positive :op-module :op-string-concat
     :shift-left :shift-right :bit-and :bit-or :bit-xor :bit-negate
     :op-and :op-or :op-xor :op-not
     :op-in :op-max)
  :separator-string "/")

;;; Type sizes

; for consistancy
(defconstant +godot-object-size+ (ffi:size-of-foreign-type :pointer-void))
(defconstant +godot-int-size+ (ffi:size-of-foreign-type :int))
(defconstant +godot-real-size+ (ffi:size-of-foreign-type :float))
(defconstant +godot-class-constructor-size+ (ffi:size-of-foreign-type :pointer-void))
(defconstant +godot-gdnative-init-fn-size+ (ffi:size-of-foreign-type :pointer-void))
(defconstant +godot-gdnative-terminate-fn-size+ (ffi:size-of-foreign-type :pointer-void))
(defconstant +godot-gdnative-procedure-fn-size+ (ffi:size-of-foreign-type :pointer-void))
(defconstant +native-call-cb-size+ (ffi:size-of-foreign-type :pointer-void))

(ffi:def-foreign-type godot-object :pointer-void)
(ffi:def-foreign-type godot-int :int)
(ffi:def-foreign-type godot-real :float)
(ffi:def-foreign-type godot-class-constructor :pointer-void)
(ffi:def-foreign-type godot-gdnative-init-fn :pointer-void)
(ffi:def-foreign-type godot-gdnative-terminate-fn :pointer-void)
(ffi:def-foreign-type godot-gdnative-precedure-fn :pointer-void)
(ffi:def-foreign-type native-call-cb :pointer-void)

;(with-open-file (out "types.lisp" :direction :output :if-exists :supersede)
;  (let ((*print-pretty* t))
;    (print (macroexpand '(%define-core-godot-types)) out)))

(%define-core-godot-types)

;;; Boolean values

(ffi:def-constant +godot-true+ 1)
(ffi:def-constant +godot-false+ 0)

;;; API Version struct

(ffi:def-struct godot-gdnative-api-version
  (major :unsigned-int)
  (minor :unsigned-int))

(defmacro godot-gdnative-api-version-major (v)
  `(ffi:get-slot-value ,v 'godot-gdnative-api-version 'major))

(defmacro godot-gdnative-api-version-minor (v)
  `(ffi:get-slot-value ,v 'godot-gdnative-api-version 'minor))

(defun godot-gdnative-api-version-compatible (want have)
  (and
   (= (godot-gdnative-api-version-major want) (godot-gdnative-api-version-major have)
   (<= (godot-gdnative-api-version-minor want) (godot-gdnative-api-version-minor have)))))

;;; API Struct

(ffi:def-enum godot-api-type
    (:core :ext-nativescript :ext-pluginscript :ext-android :ext-arvr
           :ext-videodecoder :ext-net)
  :separator-string "/")

(ffi:def-struct godot-gdnative-api-struct
  (type :unsigned-int)
  (version 'godot-gdnative-api-version)
  (next :pointer-self))

(defmacro godot-gdnative-api-struct-type (v)
  `(ffi:get-slot-value ,v 'godot-gdnative-api-struct 'type))

(defmacro godot-gdnative-api-struct-version (v)
  `(ffi:get-slot-value ,v 'godot-gdnative-api-struct 'version))

(defmacro godot-gdnative-api-struct-next (v)
  `(ffi:get-slot-value ,v 'godot-gdnative-api-struct 'next))

(defun godot-gdnative-api-struct-has-next? (v)
  (not (ffi:null-pointer-p (godot-gdnative-api-struct-next v))))

;;; Init options

(ffi:def-struct godot-gdnative-init-options
  (in-editor 'godot-bool)
  (core-api-hash :uint64-t)
  (editor-api-hash :uint64-t)
  (no-api-hash :uint64-t)
  (report-version-mismatch :pointer-void)
  (report-loading-error :pointer-void)
  (gdnative-library 'godot-object)
  (api-struct (* 'godot-gdnative-api-struct))
  (active-library-path (* 'godot-string)))

(defmacro godot-gdnative-init-options-in-editor (v)
  `(ffi:deref-pointer (ffi:get-slot-value ,v 'godot-gdnative-init-options 'in-editor) 'godot-bool))

(defmacro godot-gdnative-init-options-core-api-hash (v)
  `(ffi:get-slot-value ,v 'godot-gdnative-init-options 'core-api-hash))

(defmacro godot-gdnative-init-options-editor-api-hash (v)
  `(ffi:get-slot-value ,v 'godot-gdnative-init-options 'editor-api-hash))

(defmacro godot-gdnative-init-options-no-api-hash (v)
  `(ffi:get-slot-value ,v 'godot-gdnative-init-options 'no-api-hash))

(defmacro godot-gdnative-init-options-gdnative-library (v)
  `(ffi:get-slot-value ,v 'godot-gdnative-init-options 'gdnative-library))

(defmacro godot-gdnative-init-options-api-struct (v)
  `(ffi:get-slot-value ,v 'godot-gdnative-init-options 'api-struct))

(defmacro godot-gdnative-init-options-active-library-path (v)
  `(ffi:get-slot-value ,v 'godot-gdnative-init-options 'active-library-path))

(defun godot-gdnative-init-options-is-in-editor? (v)
  (/= (godot-gdnative-init-options-in-editor v) +godot-false+))

;;; Terminate options

(ffi:def-struct godot-gdnative-terminate-options
  (in-editor 'godot-bool))

(defmacro godot-gdnative-terminate-options-in-editor (v)
  `(ffi:get-slot-value ,v 'godot-gdnative-terminate-options 'in-editor))

(defun godot-gdnative-terminate-options-is-in-editor? (v)
  (/= (godot-gdnative-terminate-options-in-editor v) +godot-false+))

;;; godot variant call error

(ffi:def-struct godot-variant-call-error
  (error 'godot-variant-call-error-error)
  (argument :int)
  (expected 'godot-variant-type))

