with Interfaces.C; use Interfaces.C;

package Raymath is

   ------------------------
   --  Type definitions  --
   ------------------------
   type Vector2 is record
      x: Float;
      y: Float;
   end record;
   type C_Vector2 is private;

   type Vector3 is record
      X: Float;
      Y: Float;
      Z: Float;
   end record;
   type C_Vector3 is private;
   
   ------------------------
   --  Pubilc functions  --
   ------------------------

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
   
private
   
   ------------------------------------------
   --  C representation for the Ada types  --
   ------------------------------------------

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
   
   ------------------------------
   --  Type casting functions  --
   ------------------------------
   
   function To_C(Vector : Vector2) return C_Vector2 is
      (X => C_Float(Vector.X), Y => C_Float(Vector.Y))
      with Inline;
      
    function To_C(Vector : Vector3) return C_Vector3 is
       (X => C_Float(Vector.X), Y => C_Float(Vector.Y), Z => C_Float(Vector.Z))
       with Inline;

    function To_Ada(Vector : C_Vector2) return Vector2 is
       (X => Float(Vector.X), Y => Float(Vector.Y))   
       with Inline;
    
    function To_Ada(Vector : C_Vector3) return Vector3 is
       (X => Float(Vector.X), Y => Float(Vector.Y), Z => Float(Vector.Z))
       with Inline;
   
   -------------------------------
   --  Import Raylib functions  --
   -------------------------------
     
   function "+"(a, b: C_Vector2) return C_Vector2
     with
     Import => True,
     Convention => C,
     External_Name => "Vector2Add";
   
   function "-"(a, b: C_Vector2) return C_Vector2
     with
     Import => True,
     Convention => C,
     External_Name => "Vector2Subtract";
   
      function "*"(a, b: C_Vector2) return C_Vector2
        with
        Import => True,
        Convention => C,
        External_Name => "Vector2Multiply";
      
      function "*"(v: C_Vector2; scale: C_Float) return C_Vector2
        with
        Import => True,
        Convention => C,
        External_Name => "Vector2Scale";

      function Vector2_Rotate(V: C_Vector2; Angle: C_Float) return C_Vector2
        with
        Import => True,
        Convention => C,
        External_Name => "Vector2Rotate";

      function Vector2_Line_Angle(Start, Finish: C_Vector2) return C_Float
        with
        Import => True,
        Convention => C,
        External_Name => "Vector2LineAngle";
      
      function Vector2_Lerp(V1, V2: C_Vector2; Amount: C_Float) return C_Vector2
        with
        Import => True,
        Convention => C,
        External_Name => "Vector2Lerp";

      
   ----------------------------------------------------------
   --  Define Ada functions with their bodies/expressions  --
   ----------------------------------------------------------
     
   function "+"(a, b: Vector2) return Vector2 is
      (To_Ada(To_C(A) + To_C(B)));
      
   function "-"(a, b: Vector2) return Vector2 is
      (To_Ada(To_C(a) - To_C(b)));
         
   function "*"(a, b: Vector2) return Vector2 is
      (To_Ada(To_C(a) * To_C(b)));
            
   function "*"(v: Vector2; scale: Float) return Vector2 is
      (To_Ada(To_C(v) * C_Float(scale)));
               
   function Vector2_Rotate(V: Vector2; Angle: Float) return Vector2 is
      (To_Ada(Vector2_Rotate(To_C(V), C_Float(Angle))));
                  
   function Vector2_Line_Angle(Start, Finish: Vector2) return Float is
      (Float(Vector2_Line_Angle(To_C(Start), To_C(Finish))));
                   
   function Vector2_Lerp(V1, V2: Vector2; Amount: Float) return Vector2 is
      (To_Ada(Vector2_Lerp(To_C(V1), To_C(V2), C_Float(Amount))));

end;
