with Interfaces.C; use Interfaces.C;

package Raymath is
   type Vector2 is record
      x: Float;
      y: Float;
   end record;
   type C_Vector2 is private;
   
   function "+"(a, b: Vector2) return Vector2
     with Inline;
   function "-"(a, b: Vector2) return Vector2
     with Inline;
   function "*"(a, b: Vector2) return Vector2
     with Inline;
   function "*"(v: Vector2; scale: Float) return Vector2
     with Inline;
   function Vector2_Rotate(V: Vector2; Angle: Float) return Vector2
     with Inline;
   function Vector2_Line_Angle(Start, Finish: Vector2) return Float
     with Inline;
   function Vector2_Lerp(V1, V2: Vector2; Amount: Float) return Vector2
     with Inline;
   
   type Vector3 is record
      X: Float;
      Y: Float;
      Z: Float;
   end record;
   type C_Vector3 is private;
   
private
   type C_Vector2 is record
      X: C_Float;
      Y: C_Float;
   end record
     with Convention => C_Pass_By_Copy;
   type C_Vector3 is record
      X: C_Float;
      Y: C_Float;
      Z: C_Float;
   end record
     with Convention => C_Pass_By_Copy;
   
   function To_C(Vector : Vector2) return C_Vector2
     with Inline;
   function To_C(Vector : Vector3) return C_Vector3
     with Inline;
   function To_Ada(Vector : C_Vector2) return Vector2
     with Inline;
   function To_Ada(Vector : C_Vector3) return Vector3
     with Inline;
end;
