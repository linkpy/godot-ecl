
(PROGN
 (DEFCONSTANT +GODOT-BOOL-SIZE+ 1)
 (FFI:DEF-FOREIGN-TYPE GODOT-BOOL :UINT8-T)
 (DEFCONSTANT +GODOT-CHAR-TYPE-SIZE+ 4)
 (FFI:DEF-FOREIGN-TYPE GODOT-CHAR-TYPE :UINT32-T)
 (DEFCONSTANT +GODOT-STRING-SIZE+ 8)
 (FFI:DEF-FOREIGN-TYPE GODOT-STRING (:ARRAY :UINT8-T 8))
 (DEFCONSTANT +GODOT-CHAR-STRING-SIZE+ 8)
 (FFI:DEF-FOREIGN-TYPE GODOT-CHAR-STRING (:ARRAY :UINT8-T 8))
 (DEFCONSTANT +GODOT-STRING-NAME-SIZE+ 8)
 (FFI:DEF-FOREIGN-TYPE GODOT-STRING-NAME (:ARRAY :UINT8-T 8))
 (DEFCONSTANT +GODOT-VECTOR2-SIZE+ 8)
 (FFI:DEF-FOREIGN-TYPE GODOT-VECTOR2 (:ARRAY :UINT8-T 8))
 (DEFCONSTANT +GODOT-RECT2-SIZE+ 16)
 (FFI:DEF-FOREIGN-TYPE GODOT-RECT2 (:ARRAY :UINT8-T 16))
 (DEFCONSTANT +GODOT-VECTOR3-SIZE+ 12)
 (FFI:DEF-FOREIGN-TYPE GODOT-VECTOR3 (:ARRAY :UINT8-T 12))
 (DEFCONSTANT +GODOT-TRANSFORM2D-SIZE+ 24)
 (FFI:DEF-FOREIGN-TYPE GODOT-TRANSFORM2D (:ARRAY :UINT8-T 24))
 (DEFCONSTANT +GODOT-PLANE-SIZE+ 16)
 (FFI:DEF-FOREIGN-TYPE GODOT-PLANE (:ARRAY :UINT8-T 16))
 (DEFCONSTANT +GODOT-QUAT-SIZE+ 16)
 (FFI:DEF-FOREIGN-TYPE GODOT-QUAT (:ARRAY :UINT8-T 16))
 (DEFCONSTANT +GODOT-AABB-SIZE+ 24)
 (FFI:DEF-FOREIGN-TYPE GODOT-AABB (:ARRAY :UINT8-T 24))
 (DEFCONSTANT +GODOT-BASIS-SIZE+ 36)
 (FFI:DEF-FOREIGN-TYPE GODOT-BASIS (:ARRAY :UINT8-T 36))
 (DEFCONSTANT +GODOT-TRANSFORM-SIZE+ 48)
 (FFI:DEF-FOREIGN-TYPE GODOT-TRANSFORM (:ARRAY :UINT8-T 48))
 (DEFCONSTANT +GODOT-COLOR-SIZE+ 16)
 (FFI:DEF-FOREIGN-TYPE GODOT-COLOR (:ARRAY :UINT8-T 16))
 (DEFCONSTANT +GODOT-NODE-PATH-SIZE+ 8)
 (FFI:DEF-FOREIGN-TYPE GODOT-NODE-PATH (:ARRAY :UINT8-T 8))
 (DEFCONSTANT +GODOT-RID-SIZE+ 8)
 (FFI:DEF-FOREIGN-TYPE GODOT-RID (:ARRAY :UINT8-T 8))
 (DEFCONSTANT +GODOT-DICTIONARY-SIZE+ 8)
 (FFI:DEF-FOREIGN-TYPE GODOT-DICTIONARY (:ARRAY :UINT8-T 8))
 (DEFCONSTANT +GODOT-ARRAY-SIZE+ 8)
 (FFI:DEF-FOREIGN-TYPE GODOT-ARRAY (:ARRAY :UINT8-T 8))
 (DEFCONSTANT +GODOT-VARIANT-SIZE+ 24)
 (FFI:DEF-FOREIGN-TYPE GODOT-VARIANT (:ARRAY :UINT8-T 24))
 (DEFCONSTANT +GODOT-METHOD-BIND-SIZE+ 1)
 (FFI:DEF-FOREIGN-TYPE GODOT-METHOD-BIND (:ARRAY :UINT8-T 1))
 (DEFCONSTANT +GODOT-POOL-BYTE-ARRAY-READ-ACCESS-SIZE+ 1)
 (FFI:DEF-FOREIGN-TYPE GODOT-POOL-BYTE-ARRAY-READ-ACCESS (:ARRAY :UINT8-T 1))
 (DEFCONSTANT +GODOT-POOL-BYTE-ARRAY-WRITE-ACCESS-SIZE+ 1)
 (FFI:DEF-FOREIGN-TYPE GODOT-POOL-BYTE-ARRAY-WRITE-ACCESS (:ARRAY :UINT8-T 1))
 (DEFCONSTANT +GODOT-POOL-INT-ARRAY-READ-ACCESS-SIZE+ 1)
 (FFI:DEF-FOREIGN-TYPE GODOT-POOL-INT-ARRAY-READ-ACCESS (:ARRAY :UINT8-T 1))
 (DEFCONSTANT +GODOT-POOL-INT-ARRAY-WRITE-ACCESS-SIZE+ 1)
 (FFI:DEF-FOREIGN-TYPE GODOT-POOL-INT-ARRAY-WRITE-ACCESS (:ARRAY :UINT8-T 1))
 (DEFCONSTANT +GODOT-POOL-REAL-ARRAY-READ-ACCESS-SIZE+ 1)
 (FFI:DEF-FOREIGN-TYPE GODOT-POOL-REAL-ARRAY-READ-ACCESS (:ARRAY :UINT8-T 1))
 (DEFCONSTANT +GODOT-POOL-REAL-ARRAY-WRITE-ACCESS-SIZE+ 1)
 (FFI:DEF-FOREIGN-TYPE GODOT-POOL-REAL-ARRAY-WRITE-ACCESS (:ARRAY :UINT8-T 1))
 (DEFCONSTANT +GODOT-POOL-STRING-ARRAY-READ-ACCESS-SIZE+ 1)
 (FFI:DEF-FOREIGN-TYPE GODOT-POOL-STRING-ARRAY-READ-ACCESS (:ARRAY :UINT8-T 1))
 (DEFCONSTANT +GODOT-POOL-STRING-ARRAY-WRITE-ACCESS-SIZE+ 1)
 (FFI:DEF-FOREIGN-TYPE GODOT-POOL-STRING-ARRAY-WRITE-ACCESS
                       (:ARRAY :UINT8-T 1))
 (DEFCONSTANT +GODOT-POOL-VECTOR2-ARRAY-READ-ACCESS-SIZE+ 1)
 (FFI:DEF-FOREIGN-TYPE GODOT-POOL-VECTOR2-ARRAY-READ-ACCESS
                       (:ARRAY :UINT8-T 1))
 (DEFCONSTANT +GODOT-POOL-VECTOR2-ARRAY-WRITE-ACCESS-SIZE+ 1)
 (FFI:DEF-FOREIGN-TYPE GODOT-POOL-VECTOR2-ARRAY-WRITE-ACCESS
                       (:ARRAY :UINT8-T 1))
 (DEFCONSTANT +GODOT-POOL-VECTOR3-ARRAY-READ-ACCESS-SIZE+ 1)
 (FFI:DEF-FOREIGN-TYPE GODOT-POOL-VECTOR3-ARRAY-READ-ACCESS
                       (:ARRAY :UINT8-T 1))
 (DEFCONSTANT +GODOT-POOL-VECTOR3-ARRAY-WRITE-ACCESS-SIZE+ 1)
 (FFI:DEF-FOREIGN-TYPE GODOT-POOL-VECTOR3-ARRAY-WRITE-ACCESS
                       (:ARRAY :UINT8-T 1))
 (DEFCONSTANT +GODOT-POOL-COLOR-ARRAY-READ-ACCESS-SIZE+ 1)
 (FFI:DEF-FOREIGN-TYPE GODOT-POOL-COLOR-ARRAY-READ-ACCESS (:ARRAY :UINT8-T 1))
 (DEFCONSTANT +GODOT-POOL-COLOR-ARRAY-WRITE-ACCESS-SIZE+ 1)
 (FFI:DEF-FOREIGN-TYPE GODOT-POOL-COLOR-ARRAY-WRITE-ACCESS (:ARRAY :UINT8-T 1))
 (DEFCONSTANT +GODOT-POOL-BYTE-ARRAY-SIZE+ 8)
 (FFI:DEF-FOREIGN-TYPE GODOT-POOL-BYTE-ARRAY (:ARRAY :UINT8-T 8))
 (DEFCONSTANT +GODOT-POOL-INT-ARRAY-SIZE+ 8)
 (FFI:DEF-FOREIGN-TYPE GODOT-POOL-INT-ARRAY (:ARRAY :UINT8-T 8))
 (DEFCONSTANT +GODOT-POOL-REAL-ARRAY-SIZE+ 8)
 (FFI:DEF-FOREIGN-TYPE GODOT-POOL-REAL-ARRAY (:ARRAY :UINT8-T 8))
 (DEFCONSTANT +GODOT-POOL-STRING-ARRAY-SIZE+ 8)
 (FFI:DEF-FOREIGN-TYPE GODOT-POOL-STRING-ARRAY (:ARRAY :UINT8-T 8))
 (DEFCONSTANT +GODOT-POOL-VECTOR2-ARRAY-SIZE+ 8)
 (FFI:DEF-FOREIGN-TYPE GODOT-POOL-VECTOR2-ARRAY (:ARRAY :UINT8-T 8))
 (DEFCONSTANT +GODOT-POOL-VECTOR3-ARRAY-SIZE+ 8)
 (FFI:DEF-FOREIGN-TYPE GODOT-POOL-VECTOR3-ARRAY (:ARRAY :UINT8-T 8))
 (DEFCONSTANT +GODOT-POOL-COLOR-ARRAY-SIZE+ 8)
 (FFI:DEF-FOREIGN-TYPE GODOT-POOL-COLOR-ARRAY (:ARRAY :UINT8-T 8))
 (DEFCONSTANT +SIZE-T-SIZE+ 8)
 (FFI:DEF-FOREIGN-TYPE SIZE-T :UINT64-T)) 