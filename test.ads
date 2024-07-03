with Interfaces.C; use Interfaces.C;

package Test is
   function Test return Integer;
   
   type Vector2 is record
      x: Float;
      y: Float;
   end record;
   type C_Vector2 is private;

   
   function "+"(a, b: Vector2) return Vector2
     with Inline;

private
   type C_Vector2 is record
      X: C_Float;
      Y: C_Float;
   end record
     with Convention => C_Pass_By_Copy;
   
   function To_C(Vector : Vector2) return C_Vector2 is
--      (C_Vector2(X => C_Float(Vector.X), Y => C_Float(Vector.Y)));
      (X => C_Float(Vector.X), Y => C_Float(Vector.Y));


   --  function To_C(Vector : Vector2) return C_Vector2 is
   --     (X => To_C(Vector.X), Y => To_C(Vector.Y));
   function To_Ada(Vector : C_Vector2) return Vector2 is
      ((X => Float(Vector.X), Y => Float(Vector.Y)));

   function "+"(a, b: C_Vector2) return C_Vector2
     with
     Import => True,
     Convention => C,
     External_Name => "Vector2Add";
   
   function "+"(a, b: Vector2) return Vector2 is
      (To_Ada(To_C(A) + To_C(B)));

end;
