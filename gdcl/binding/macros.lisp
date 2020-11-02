
(in-package :godot-ecl/binding)


(eval-when (compile)
  (defconstant %+godot-types+
    '("godot_bool" "godot_char_type"
      "godot_string" "godot_char_string" "godot_string_name" "godot_vector2"
      "godot_rect2" "godot_vector3" "godot_transform2d" "godot_plane"
      "godot_quat" "godot_aabb" "godot_basis" "godot_transform"
      "godot_color" "godot_node_path" "godot_rid" "godot_dictionary"
      "godot_array" "godot_variant" "godot_method_bind"

      "godot_pool_byte_array_read_access" "godot_pool_byte_array_write_access"
      "godot_pool_int_array_read_access" "godot_pool_int_array_write_access"
      "godot_pool_real_array_read_access" "godot_pool_real_array_write_access"
      "godot_pool_string_array_read_access" "godot_pool_string_array_write_access"
      "godot_pool_vector2_array_read_access" "godot_pool_vector2_array_write_access"
      "godot_pool_vector3_array_read_access" "godot_pool_vector3_array_write_access"
      "godot_pool_color_array_read_access" "godot_pool_color_array_write_access"

      "godot_pool_byte_array" "godot_pool_int_array" "godot_pool_real_array"
      "godot_pool_string_array" "godot_pool_vector2_array" "godot_pool_vector3_array"
      "godot_pool_color_array"

      "size_t"))

  (defmacro %define-core-godot-types ()
    (labels ((make-size-const-name (c-name)
               (gdcl/utils:string-to-name (format nil "+~A-SIZE+" c-name)))
             (make-type-name (c-name)
               (gdcl/utils:string-to-name c-name))
             (make-const (c-name v)
               `(defconstant ,(make-size-const-name c-name) ,v))
             (make-type (c-name c-size)
               `(ffi:def-foreign-type ,(make-type-name c-name)
                    (:array :uint8-t ,c-size)))
             (make-int-type (c-name size)
               `(ffi:def-foreign-type ,(make-type-name c-name)
                    ,(case size
                       (1 :uint8-t)
                       (2 :uint16-t)
                       (4 :uint32-t)
                       (8 :uint64-t))))

             (grovel-size-template (name)
               `(print (gdcl/ffi:c-type-size ,name)))

             (generate-for-type (type size)
               (list (make-const type size)
                     (if (or (string-equal type "godot_bool")
                             (string-equal type "godot_char_type")
                             (string-equal type "size_t"))
                         (make-int-type type size)
                         (make-type type size))))
             (generator (sizes)
               (alexandria:mappend
                (lambda (type) (generate-for-type type (pop sizes)))
                %+godot-types+)))

      (let* ((gdheadersp (asdf:system-relative-pathname :godot-ecl "./godot_headers/"))
             (cc-flags (format nil "-I~A" gdheadersp))
             (grovel-template `((gdcl/ffi:c-include "gdnative_api_struct.gen.h")
                                ,@(map 'list #'grovel-size-template %+godot-types+)))
             (sizes (gdcl/ffi:grovel cc-flags nil grovel-template)))

        (list* 'progn (generator sizes))))))


(eval-when (compile)
  (defmacro %define-gdnative-types-and-functions ()
    (let* ((api (gdcl/utils:load-json #P"./godot_headers/gdnative_api.json"))
           (core-api (gdcl/utils:assoc-cdr :core api))
           (ext-apis (gdcl/utils:assoc-cdr :extensions api))
           (code-store (gdcl/gen:new-code-storage)))
      (gdcl/gen:pregenerate-binding code-store core-api)
      (dolist (ext-api ext-apis)
        (gdcl/gen:pregenerate-binding code-store ext-api))
      `(progn ,@(gdcl/gen:get-all-items code-store)))))

