
(in-package :godot-ecl/binding)

(gdcl/ffi:c-include "gdnative_api_struct.gen.h")

(ffi:clines "
extern void _gdcl_module_init(cl_object);

static char* _ecl_string = \"ecl\";
static char** _ecl_argv = &_ecl_string;

void GDN_EXPORT godot_gdnative_init(godot_gdnative_init_options *o) {
    cl_boot(1, _ecl_argv);
    ecl_init_module(NULL, _gdcl_module_init);

    cl_object fn = ecl_make_symbol(\"%GDNATIVE-INIT\", \"GODOT-ECL/BINDING\");
    cl_object fdata = ecl_make_foreign_data(
        ecl_make_symbol(\"POINTER-VOID\", \"KEYWORD\"),
        sizeof(godot_gdnative_init_options),
        o
    );
    cl_funcall(2, fn, fdata);
}

void GDN_EXPORT godot_gdnative_terminate(godot_gdnative_terminate_options *o) {
    cl_object fn = ecl_make_symbol(\"%GDNATIVE-TERMINATE\", \"GODOT-ECL/BINDING\");
    cl_object fdata = ecl_make_foreign_data(
        ecl_make_symbol(\"POINTER-VOID\", \"KEYWORD\"),
        sizeof(godot_gdnative_terminate_options),
        o
    );
    cl_funcall(2, fn, fdata);

    cl_shutdown();
}

void GDN_EXPORT godot_nativescript_init(void *desc) {
    cl_object fn = ecl_make_symbol(\"%NATIVESCRIPT-INIT\", \"GODOT-ECL/BINDIGN\");
    cl_funcall(1, fn);
}
")



(defparameter +godot-in-editor+ nil)

(defun %gdnative-init (init-options)
  (format t "%gdnative-init~%")

  (do ((api (godot-gdnative-init-options-api-struct init-options) (godot-gdnative-api-struct-next api)))
      ((ffi:null-pointer-p api))
    (%print-api api)))

(defun %gdnative-terminate (term-options)
  (format t "%gdnative-terminate~%"))

(defun %nativescript-init ()
  (format t "%nativescript-init"))




(defun %print-api (api)
  (let ((type (godot-gdnative-api-struct-type api))
        (version (godot-gdnative-api-struct-version api)))
    (format t "~A v~D.~D~%"
            (cond ((= type godot-api-type/core) (format nil "CORE"))
                  ((= type godot-api-type/ext-nativescript) (format nil "NATIVESCRIPT"))
                  ((= type godot-api-type/ext-pluginscript) (format nil "PLUGINSCRIPT"))
                  ((= type godot-api-type/ext-android) (format nil "ANDROID"))
                  ((= type godot-api-type/ext-arvr) (format nil "ARVR"))
                  ((= type godot-api-type/ext-videodecoder) (format nil "VIDEODECODER"))
                  ((= type godot-api-type/ext-net) (format nil "NET"))
                  (t (format nil "/!\ UNKOWN(~D)" type)))
            (godot-gdnative-api-version-major version)
            (godot-gdnative-api-version-minor version))))

