private with Interfaces.C;

package Raylib.Raymath
is

   ------------------------
   --  Pubilc functions  --
   ------------------------

   function "+" (a, b : Vector2) return Vector2 with
     Inline;
   function "-" (a, b : Vector2) return Vector2 with
     Inline;
   function "*" (a, b : Vector2) return Vector2 with
     Inline;
   function "*" (V : Vector2; Scale : Float) return Vector2 with
     Inline;
   function Vector2_Rotate (V : Vector2; Angle : Float) return Vector2 with
     Inline;
   function Vector2_Line_Angle (Start, Finish : Vector2) return Float with
     Inline;
   function Vector2_Lerp (V1, V2 : Vector2; Amount : Float) return Vector2 with
     Inline;

private

   use Interfaces.C;

   -------------------------------
   --  Import Raylib functions  --
   -------------------------------

   function "+" (a, b : C_Vector2) return C_Vector2 with
     Import => True, ConVention => C, External_Name => "Vector2Add";

   function "-" (a, b : C_Vector2) return C_Vector2 with
     Import => True, ConVention => C, External_Name => "Vector2Subtract";

   function "*" (a, b : C_Vector2) return C_Vector2 with
     Import => True, ConVention => C, External_Name => "Vector2Multiply";

   function "*" (V : C_Vector2; Scale : C_Float) return C_Vector2 with
     Import => True, ConVention => C, External_Name => "Vector2Scale";

   function Vector2_Rotate
     (V : C_Vector2; Angle : C_Float) return C_Vector2 with
     Import => True, ConVention => C, External_Name => "Vector2Rotate";

   function Vector2_Line_Angle (Start, Finish : C_Vector2) return C_Float with
     Import => True, ConVention => C, External_Name => "Vector2LineAngle";

   function Vector2_Lerp
     (V1, V2 : C_Vector2; Amount : C_Float) return C_Vector2 with
     Import => True, ConVention => C, External_Name => "Vector2Lerp";

   ----------------------------------------------------------
   --  Define Ada functions with their bodies/expressions  --
   ----------------------------------------------------------

   function "+" (a, b : Vector2) return Vector2 is
     (To_Ada (To_C (a) + To_C (b)));

   function "-" (a, b : Vector2) return Vector2 is
     (To_Ada (To_C (a) - To_C (b)));

   function "*" (a, b : Vector2) return Vector2 is
     (To_Ada (To_C (a) * To_C (b)));

   function "*" (V : Vector2; Scale : Float) return Vector2 is
     (To_Ada (To_C (V) * C_Float (Scale)));

   function Vector2_Rotate (V : Vector2; Angle : Float) return Vector2 is
     (To_Ada (Vector2_Rotate (To_C (V), C_Float (Angle))));

   function Vector2_Line_Angle (Start, Finish : Vector2) return Float is
     (Float (Vector2_Line_Angle (To_C (Start), To_C (Finish))));

   function Vector2_Lerp (V1, V2 : Vector2; Amount : Float) return Vector2 is
     (To_Ada (Vector2_Lerp (To_C (V1), To_C (V2), C_Float (Amount))));

end Raylib.Raymath;
